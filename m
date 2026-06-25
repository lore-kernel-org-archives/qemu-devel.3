Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B96BCDE002
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 08:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcfap-0004qf-H9; Thu, 25 Jun 2026 04:37:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wcfak-0004q6-2P
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 04:37:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wcfah-0005WL-1G
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 04:37:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782376656;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cML5g3dez7cqSmTKEDe5uJEGFHPYG/iyLTVKgKfdUWs=;
 b=UGSjoUdGXnb8d5Sq7L3MbvpnMGM+VD48kNnLnPJLxVNHJwZqaELqAkXSuZTyN/orGMSyTV
 xtmLgIC+8K6Sw4V9k+DPRMG0xmSnMDyywTlvgxU0aUtNv0URcqWUHfikbhw/08OwS4xpBj
 oTtX8ZsF3ch11mTi4v3lbjiga2eA894=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-o15NAHPVPf6UJLwqRJ8pwQ-1; Thu,
 25 Jun 2026 04:37:34 -0400
X-MC-Unique: o15NAHPVPf6UJLwqRJ8pwQ-1
X-Mimecast-MFC-AGG-ID: o15NAHPVPf6UJLwqRJ8pwQ_1782376653
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 29A8719560A2; Thu, 25 Jun 2026 08:37:33 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.47])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E5071956095; Thu, 25 Jun 2026 08:37:28 +0000 (UTC)
Date: Thu, 25 Jun 2026 09:37:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@stgraber.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Volker =?utf-8?Q?R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH 0/9] hw/audio/virtio-sound: basic migration support
Message-ID: <ajzoxZr4g0Xsr_4p@redhat.com>
References: <20260625080910.30569-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260625080910.30569-1-alexander@mihalicyn.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jun 25, 2026 at 10:09:01AM +0200, Alexander Mikhalitsyn wrote:
> From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> 
> Dear friends,
> 
> This patchset is aimed to support virtio-sound live migration and based on
> pre-existing Volker Rümelin's patches from qemu-devel lists [1]. I tried
> to ask (https://lore.kernel.org/qemu-devel/9d7ea128c711c201688a4716f53b8a335fc53569.camel@mihalicyn.com/)
> if Volker is going to continue his work on this, but received no reply so I
> just decided to go forward: take his patches, rebase and resend. Of course,
> I kept all authorship/tags so I hope that it is fine.

Yes, that's the right way to approach it, you waited a decently long
time for any response to your query.

My only suggestion, in the commit messages, if you made any non-trivial
changes to Volker's functional code, then just put a single sentence
inbetween the two S-o-B lines to highlight it, eg

  Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
  [AM:  changed blah, blah & blah because blah]
  Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

if you didn't make any non-trivial changes, then what you've done is fine.

> Changelog relative to the original Volker Rümelin's submission:
> - rebased:
> 	- "hw/audio/virtio-sound: return correct command response size"
> 		was dropped as it was already merged
> 	- "hw/audio/virtio-sound: fix segmentation fault in tx/rx xfer handler"
> 		was dropped as it seems to be replaced with another fix
> 		https://github.com/qemu/qemu/commit/731655f87f319fd06f27282c6cafbc2467ac8045
> 	- I had to drop all pre-existing Reviewed-by tags cause it was 2 years since
> 	  this patchset was sent and reviewed and I did a quite significant code changes
> 	  during rebase

No problem.

> 
> Kind regards,
> Alex
> 
> Volker Rümelin (9):
>   hw/audio/virtio-sound: remove command and stream mutexes
>   hw/audio/virtio-sound: allocate an array of streams
>   hw/audio/virtio-sound: free all stream buffers on reset
>   hw/audio/virtio-sound: split out virtio_snd_pcm_start_stop()
>   hw/audio/virtio-sound: add stream state variable
>   hw/audio/virtio-sound: introduce virtio_snd_pcm_open()
>   hw/audio/virtio-sound: introduce virtio_snd_set_active()
>   hw/audio/virtio-sound: add missing vmstate fields
>   hw/audio/virtio-sound: add placeholder for buffer write position
> 
>  hw/audio/trace-events         |   3 +-
>  hw/audio/virtio-snd.c         | 685 ++++++++++++++++++++--------------
>  include/hw/audio/virtio-snd.h |  25 +-
>  3 files changed, 407 insertions(+), 306 deletions(-)
> 
> -- 
> 2.47.3
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF38C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 13:34:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyUoe-0002OP-4q; Mon, 24 Aug 2026 09:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wyUod-0002O0-2n
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:34:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wyUob-00008X-DP
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787578456;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FNb9SeD2q6kds1u4yuz8b6I+lBjHu/eNdYhvbqy1Z2Y=;
 b=JwRt+cKfLkuWoYCz0LlUcvBTgs3FtOClpIXcMVlsMPdBDtylHNArfoPSnpvpG/+ao42GTM
 ERtsy7Of/QZefBLJ8fHTftLyyLYSJ8I5BWFVmxp/7PPT77dV6xuXzW0qFtogaMKVj7LmYx
 Xuhowjvxn03WYZ5435OStN06u5RBkYQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-475-MI-esXGiOU6dPupEVdhS7A-1; Mon,
 24 Aug 2026 09:34:12 -0400
X-MC-Unique: MI-esXGiOU6dPupEVdhS7A-1
X-Mimecast-MFC-AGG-ID: MI-esXGiOU6dPupEVdhS7A_1787578449
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E30AB197752E; Mon, 24 Aug 2026 13:34:08 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 346B130002EA; Mon, 24 Aug 2026 13:34:01 +0000 (UTC)
Date: Mon, 24 Aug 2026 14:33:59 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowangio@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Hyman Huang <infra.ai.cloud@bitdeer.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-block@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH v3 32/49] monitor: make hmp_handle_error() take MonitorHMP
Message-ID: <aoxIR9KJTI8nPG-5@redhat.com>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
 <20260816-qemu-no-hmp-v3-32-e53fc35bc550@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260816-qemu-no-hmp-v3-32-e53fc35bc550@redhat.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sun, Aug 16, 2026 at 11:12:59PM +0400, Marc-André Lureau wrote:
> Mostly mechanical, with a few adjustments around it.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  block/monitor/block-hmp-cmds.c  | 73 +++++++++++++++--------------------------
>  chardev/char-hmp-cmds.c         | 17 ++++------
>  dump/dump-hmp-cmds.c            |  5 ++-
>  hw/core/machine-hmp-cmds.c      | 26 +++++++--------
>  hw/i386/kvm/xen_evtchn.c        |  4 +--
>  hw/misc/mos6522.c               |  2 +-
>  hw/net/rocker/rocker-hmp-cmds.c |  8 ++---
>  hw/pci/pci-hmp-cmds.c           |  2 +-
>  hw/uefi/ovmf-log.c              |  2 +-
>  hw/virtio/virtio-hmp-cmds.c     | 10 +++---
>  include/monitor/hmp.h           |  2 +-
>  migration/dirtyrate.c           |  2 +-
>  migration/migration-hmp-cmds.c  | 37 ++++++++-------------
>  monitor/hmp-cmds.c              | 23 +++++--------
>  monitor/hmp.c                   | 12 +++----
>  net/net-hmp-cmds.c              | 11 +++----
>  qom/qom-hmp-cmds.c              | 13 +++-----
>  system/dirtylimit-hmp-cmds.c    |  7 ++--
>  system/qdev-monitor.c           |  6 ++--
>  system/runstate-hmp-cmds.c      |  3 +-
>  target/i386/monitor.c           |  3 +-
>  ui/ui-hmp-cmds.c                | 19 ++++-------
>  22 files changed, 112 insertions(+), 175 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|



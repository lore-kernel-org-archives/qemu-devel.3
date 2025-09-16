Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA27ECAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 08:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyQxp-0002YU-4x; Tue, 16 Sep 2025 04:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyQxm-0002Y3-Ku
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 04:22:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyQxi-0004rD-Ex
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 04:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758010972;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U5Dg6vTgdLbgvsXwjhkw7WbZxwdYGL4meToUEnlCNvI=;
 b=cE+o+3mQs4YrPCVlcVNF8BA+Z1KA0UNGeL9BUlJEo98pfxLANVd4NUG2rmtPugZulO0D0I
 PNeeGDyRjbqTvr5gHWwtn6SlBkbyr/prJ6/eopBrSByI+ZndCi3Xisfo89groQtcMjRPbP
 Zg3rlMpJF1B412diz08jvbt9VjeX6PY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-_EIKXNcYNS2H7NoYhrXd0A-1; Tue,
 16 Sep 2025 04:22:49 -0400
X-MC-Unique: _EIKXNcYNS2H7NoYhrXd0A-1
X-Mimecast-MFC-AGG-ID: _EIKXNcYNS2H7NoYhrXd0A_1758010968
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 387C118002CB; Tue, 16 Sep 2025 08:22:47 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.153])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9276C1800446; Tue, 16 Sep 2025 08:22:40 +0000 (UTC)
Date: Tue, 16 Sep 2025 09:22:36 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, qemu-block@nongnu.org,
 leiyang@redhat.com, marcandre.lureau@redhat.com,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fam Zheng <fam@euphon.net>, Zhao Liu <zhao1.liu@intel.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v4 04/12] handle result of qio_channel_set_blocking()
Message-ID: <aMkeTEfsqJJSsLc6@redhat.com>
References: <20250915193105.230085-1-vsementsov@yandex-team.ru>
 <20250915193105.230085-5-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250915193105.230085-5-vsementsov@yandex-team.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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

On Mon, Sep 15, 2025 at 10:30:56PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Currently, we just always pass NULL as errp argument. That doesn't
> look good.
> 
> Some realizations of interface may actually report errors.
> Channel-socket realization actually either ignore or crash on
> errors, but we are going to straighten it out to always reporting
> an errp in further commits.
> 
> So, convert all callers to either handle the error (where environment
> allows) or explicitly use &error_abort.
> 
> Take also a chance to change the return value to more convenient
> bool (keeping also in mind, that underlying realizations may
> return -1 on failure, not -errno).
> 
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  block/nbd.c                      |  4 +++-
>  chardev/char-socket.c            | 20 ++++++++++++++++----
>  hw/remote/proxy.c                |  6 +++++-
>  hw/remote/remote-obj.c           |  6 +++++-
>  hw/vfio-user/proxy.c             | 11 ++++++++---
>  include/io/channel.h             |  6 +++---
>  io/channel.c                     |  4 ++--
>  nbd/server.c                     |  4 +++-
>  scsi/qemu-pr-helper.c            |  9 ++++++---
>  tests/unit/io-channel-helpers.c  |  5 +++--
>  tests/unit/test-io-channel-tls.c |  4 ++--
>  tools/i386/qemu-vmsr-helper.c    |  6 ++++--
>  ui/vnc.c                         |  2 +-
>  util/vhost-user-server.c         |  7 ++++++-
>  14 files changed, 67 insertions(+), 27 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



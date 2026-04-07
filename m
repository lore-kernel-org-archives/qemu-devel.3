Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D63CBFF5135
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:23:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABW1-0007fu-EG; Tue, 07 Apr 2026 14:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wABTf-0003Pl-1O
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:48:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wA5B2-00051K-3X
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 08:05:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775563503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kXGBnUzf+WQ22SmvtBZcdgQ1E0GJ5tlAPk7M266ahis=;
 b=hYPHI4uROd312ZPCZTLwCbRPtHeUB9xyTyFJfl8/PHQoFC4vQ802fZQlDUG0d/DQ/xPUtO
 7TYdfi4nMc35w8W+ZXDfDdoHCtwXXdIglsQeOjkkG8XZkev8OLAh3Opy0NixYFtlegTUak
 EFWIFBWM6q46+zWTanOzfzvL2zh60QQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-dahYKbJ6Pcej75oLJD5lsg-1; Tue,
 07 Apr 2026 08:04:58 -0400
X-MC-Unique: dahYKbJ6Pcej75oLJD5lsg-1
X-Mimecast-MFC-AGG-ID: dahYKbJ6Pcej75oLJD5lsg_1775563497
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF2871800345; Tue,  7 Apr 2026 12:04:56 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.87])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C7F3119560A6; Tue,  7 Apr 2026 12:04:54 +0000 (UTC)
Date: Tue, 7 Apr 2026 14:04:52 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 pbonzini@redhat.com
Subject: Re: [PULL 4/6] monitor: Fix deadlock in monitor_cleanup
Message-ID: <adTy5PTUjTu_Swj8@redhat.com>
References: <20260331150352.256332-1-kwolf@redhat.com>
 <20260331150352.256332-5-kwolf@redhat.com>
 <d0187495-f196-43a3-b77c-463a098b5f60@tls.msk.ru>
 <2f8a1144-f002-44ae-b9ff-8cbb4f13742f@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f8a1144-f002-44ae-b9ff-8cbb4f13742f@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 04.04.2026 um 08:08 hat Michael Tokarev geschrieben:
> On 04.04.2026 09:02, Michael Tokarev wrote:
> ..
> > This broke qemu guest agent build.
> > 
> > [18/51] Linking target qga/qemu-ga
> > FAILED: qga/qemu-ga
> > ld: libqemuutil.a.p/qapi_qmp-dispatch.c.o: in function
> > `do_qmp_dispatch_bh':
> > qapi/qmp-dispatch.c:140:(.text+0x5c): undefined reference to
> > `aio_wait_kick'
> > collect2: error: ld returned 1 exit status
> 
> To clarify: it is --disable-system --disable-user build - like,
> tools-and-qga-only.

I can reproduce it with a qga-only build, but building tools already
fixes it again. That is, the following configure line breaks:

    ../configure --disable-system --disable-user --enable-guest-agent

But this one works:

    ../configure --disable-system --disable-user --enable-guest-agent --enable-tools

utils_ss in the meson files is messy. Enabling something that needs the
block layer enables additional files for qga, too. It should probably be
split in two and qga should always only be built with what is present
when you build only qga and nothing else.

But for now, the patch below should fix it.

Kevin

diff --git a/util/meson.build b/util/meson.build
index 33132c04ad6..637f0b82dd0 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -78,7 +78,7 @@ if have_system
 endif

 if have_block or have_ga
-  util_ss.add(files('aiocb.c', 'async.c'))
+  util_ss.add(files('aiocb.c', 'aio-wait.c', 'async.c'))
   util_ss.add(files('base64.c'))
   util_ss.add(files('main-loop.c'))
   util_ss.add(files('qemu-coroutine.c', 'qemu-coroutine-lock.c', 'qemu-coroutine-io.c'))
@@ -87,7 +87,6 @@ if have_block or have_ga
   util_ss.add(files('qemu-sockets.c'))
 endif
 if have_block
-  util_ss.add(files('aio-wait.c'))
   util_ss.add(files('buffer.c'))
   util_ss.add(files('bufferiszero.c'))
   util_ss.add(files('hbitmap.c'))



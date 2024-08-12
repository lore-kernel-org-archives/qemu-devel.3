Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52AE2C52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 15:56:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdXP6-0004qz-F5; Mon, 12 Aug 2024 11:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sdXOz-0004lt-O5
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 11:56:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sdXOx-0004vP-Q4
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 11:56:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723478167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fIsw44iXbLWlNY+u+QEcCR4fOCHVyM70MAW+4gpzhuE=;
 b=FD/3AvmF7dNBXgTG4g9DF5Ek1Gkn3N0+IpBZY/fM4NT1KFe9sBE3mObhm4sg6g75ZGwooA
 NfcYw7/NGkc2ByWwmyeWn5TZXFXc4MbASlVcwu0kaBn483xpDWzfloqx/3678v09K1XNLt
 v0bRU1cG0dcgWGodD0uQ1F/GUwYHOBY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-Q5fkYefZMQmnelPWLpmDUA-1; Mon,
 12 Aug 2024 11:56:04 -0400
X-MC-Unique: Q5fkYefZMQmnelPWLpmDUA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B0538192538C; Mon, 12 Aug 2024 15:56:02 +0000 (UTC)
Received: from localhost (unknown [10.2.16.252])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B56031955F66; Mon, 12 Aug 2024 15:56:01 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, qemu-stable@nongnu.org,
 Eric Blake <eblake@redhat.com>
Subject: [PULL 1/1] block/blkio: use FUA flag on write zeroes only if supported
Date: Mon, 12 Aug 2024 11:55:58 -0400
Message-ID: <20240812155558.88189-2-stefanha@redhat.com>
In-Reply-To: <20240812155558.88189-1-stefanha@redhat.com>
References: <20240812155558.88189-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Stefano Garzarella <sgarzare@redhat.com>

libblkio supports BLKIO_REQ_FUA with write zeros requests only since
version 1.4.0, so let's inform the block layer that the blkio driver
supports it only in this case. Otherwise we can have runtime errors
as reported in https://issues.redhat.com/browse/RHEL-32878

Fixes: fd66dbd424 ("blkio: add libblkio block driver")
Cc: qemu-stable@nongnu.org
Buglink: https://issues.redhat.com/browse/RHEL-32878
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240808080545.40744-1-sgarzare@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 meson.build   | 2 ++
 block/blkio.c | 6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index c2a050b844..81ecd4bae7 100644
--- a/meson.build
+++ b/meson.build
@@ -2305,6 +2305,8 @@ config_host_data.set('CONFIG_BLKIO', blkio.found())
 if blkio.found()
   config_host_data.set('CONFIG_BLKIO_VHOST_VDPA_FD',
                        blkio.version().version_compare('>=1.3.0'))
+  config_host_data.set('CONFIG_BLKIO_WRITE_ZEROS_FUA',
+                       blkio.version().version_compare('>=1.4.0'))
 endif
 config_host_data.set('CONFIG_CURL', curl.found())
 config_host_data.set('CONFIG_CURSES', curses.found())
diff --git a/block/blkio.c b/block/blkio.c
index 3d9a2e764c..e0e765af63 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -899,8 +899,10 @@ static int blkio_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     bs->supported_write_flags = BDRV_REQ_FUA | BDRV_REQ_REGISTERED_BUF;
-    bs->supported_zero_flags = BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP |
-                               BDRV_REQ_NO_FALLBACK;
+    bs->supported_zero_flags = BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK;
+#ifdef CONFIG_BLKIO_WRITE_ZEROS_FUA
+    bs->supported_zero_flags |= BDRV_REQ_FUA;
+#endif
 
     qemu_mutex_init(&s->blkio_lock);
     qemu_co_mutex_init(&s->bounce_lock);
-- 
2.46.0



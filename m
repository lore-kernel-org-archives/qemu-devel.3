Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42558C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:21:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rctxY-0002P4-S2; Wed, 21 Feb 2024 16:16:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rctxE-00020x-Ac; Wed, 21 Feb 2024 16:16:37 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rctxB-0000jK-22; Wed, 21 Feb 2024 16:16:35 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EC8214F7E8;
 Thu, 22 Feb 2024 00:16:44 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 9E4B7869A1;
 Thu, 22 Feb 2024 00:16:22 +0300 (MSK)
Received: (nullmailer pid 2335247 invoked by uid 1000);
 Wed, 21 Feb 2024 21:16:22 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 01/28] qemu-img: stop printing error twice in a few places
Date: Thu, 22 Feb 2024 00:15:42 +0300
Message-Id: <20240221211622.2335170-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1708544927.git.mjt@tls.msk.ru>
References: <cover.1708544927.git.mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

Currently we have:

  ./qemu-img resize none +10
  qemu-img: Could not open 'none': Could not open 'none': No such file or directory

stop printing the message twice, - local_err already has
all the info, no need to prepend additional text there.

There are a few other places like this, but I'm unsure
about these.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-img.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 7668f86769..5a756be600 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -404,7 +404,7 @@ static BlockBackend *img_open_file(const char *filename,
     }
     blk = blk_new_open(filename, NULL, options, flags, &local_err);
     if (!blk) {
-        error_reportf_err(local_err, "Could not open '%s': ", filename);
+        error_report_err(local_err);
         return NULL;
     }
     blk_set_enable_write_cache(blk, !writethrough);
@@ -597,7 +597,7 @@ static int img_create(int argc, char **argv)
     bdrv_img_create(filename, fmt, base_filename, base_fmt,
                     options, img_size, flags, quiet, &local_err);
     if (local_err) {
-        error_reportf_err(local_err, "%s: ", filename);
+        error_report_err(local_err);
         goto fail;
     }
 
@@ -5253,9 +5253,7 @@ static int img_dd(int argc, char **argv)
 
     ret = bdrv_create(drv, out.filename, opts, &local_err);
     if (ret < 0) {
-        error_reportf_err(local_err,
-                          "%s: error while creating output image: ",
-                          out.filename);
+        error_report_err(local_err);
         ret = -1;
         goto out;
     }
-- 
2.39.2



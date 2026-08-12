Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3684C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuALF-0007SY-SW; Wed, 12 Aug 2026 10:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAJM-0005P4-3T; Wed, 12 Aug 2026 10:52:08 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAJK-0006rN-4s; Wed, 12 Aug 2026 10:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546231; bh=2cYK9vE6S/he+5dI2p82JGGbqbithEi0e850Vl4PZao=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Wz/ub9SFa4iFaASo4p9uir5sdVHLLK3zHCUyJ9uDOoSUTbY1K2dOQ0RJjp3Q94JjP
 IBHkDAQi+z5lQjswhz4yl5BnTVhCoNQB5FeWnUZqnHRRosk95m4vQuExQL+7hS1o/F
 5KIhe/1K7c4eJO/sFcqARF/gBRP8OoOZ/aAvD76TfdrDycsfMj9gwxhAk+TXVXB/by
 IM0MnD60JK/Kts/bWwENj0kjcEJeABvrvDHFHNCeuZe5fh3cQ2DrFuzEVlQ+arxrhl
 o+bM/jDmoAMxxDRuiZdjUXmbgJbPkSDkz6Xv2rM30XIYxIbu+pCBG1RappBDVIc0Cx
 GD9d6Qt1y7bFQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 324971CA617;
 Wed, 12 Aug 2026 17:50:31 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8C960409D53;
 Wed, 12 Aug 2026 17:50:42 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id EA6F92F989; Wed, 12 Aug 2026 17:50:17 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 019/120] scsi-disk: protect against guest sending
 truncated data for MODE SELECT commands
Date: Wed, 12 Aug 2026 17:48:02 +0300
Message-ID: <20260812144955.649205-19-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Paolo Bonzini <pbonzini@redhat.com>

scsi-disk has a MODE SELECT path where a truncated mode page can be
allowed by a compatibility quirk, but the parser continues to use the
page's declared length rather than the number of bytes actually remaining
in the request buffer.  This means that scsi_disk_check_mode_select() and
scsi_disk_apply_mode_select() can read beyond the valid part of inbuf[],
potentially up to the emulated age's length.

Clamping page_len (the size of the page) to len (whatever the
guest provided) ensures that scsi_disk_check_mode_select() and
scsi_disk_apply_mode_select() do not access anything beyond bounds;
however, this requires care to accept and handle truncated input in
those two functions.

In particular, until scsi_disk_check_mode_select()'s first call to
mode_sense_page() the number of bytes to be cleared in mode_current[] is
unknown, so zero it completely.  And for everything else, be conservative
and use len when providing inputs to other functions; but at the same time,
ensure all accesses to inbuf[] are bound by expected_len.

Note that pages longer than the emulated one are still rejected.

Fixes: 389e18eb9aa4 ("scsi-disk: add SCSI_DISK_QUIRK_MODE_PAGE_TRUNCATED quirk for Macintosh")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4051
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit d149a11c6c825e182cfb5db7d1d1492a049e82ab)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 5ba5b46c4f4..85d0bd0b811 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -1524,7 +1524,7 @@ static void scsi_disk_emulate_read_data(SCSIRequest *req)
 static int scsi_disk_check_mode_select(SCSIDiskState *s, int page,
                                        uint8_t *inbuf, int inlen)
 {
-    uint8_t mode_current[SCSI_MAX_MODE_LEN];
+    uint8_t mode_current[SCSI_MAX_MODE_LEN] = { 0 };
     uint8_t mode_changeable[SCSI_MAX_MODE_LEN];
     uint8_t *p;
     int len, expected_len, changeable_len, i;
@@ -1543,21 +1543,21 @@ static int scsi_disk_check_mode_select(SCSIDiskState *s, int page,
     }
 
     p = mode_current;
-    memset(mode_current, 0, inlen + 2);
     len = mode_sense_page(s, page, &p, 0);
-    if (len < 0 || len != expected_len) {
+    /* The guest may send a truncated page, but not a longer one.  */
+    if (len < 0 || expected_len > len) {
         return -1;
     }
 
     p = mode_changeable;
-    memset(mode_changeable, 0, inlen + 2);
+    memset(mode_changeable, 0, len);
     changeable_len = mode_sense_page(s, page, &p, 1);
     assert(changeable_len == len);
 
     /* Check that unchangeable bits are the same as what MODE SENSE
      * would return.
      */
-    for (i = 2; i < len; i++) {
+    for (i = 2; i < expected_len; i++) {
         if (((mode_current[i] ^ inbuf[i - 2]) & ~mode_changeable[i]) != 0) {
             return -1;
         }
@@ -1565,11 +1565,15 @@ static int scsi_disk_check_mode_select(SCSIDiskState *s, int page,
     return 0;
 }
 
-static void scsi_disk_apply_mode_select(SCSIDiskState *s, int page, uint8_t *p)
+/* Note p may be truncated, so check any bytes you access against len.  */
+static void scsi_disk_apply_mode_select(SCSIDiskState *s, int page,
+                                        uint8_t *p, int len)
 {
     switch (page) {
     case MODE_PAGE_CACHING:
-        blk_set_enable_write_cache(s->qdev.conf.blk, (p[0] & 4) != 0);
+        if (len > 0) {
+            blk_set_enable_write_cache(s->qdev.conf.blk, (p[0] & 4) != 0);
+        }
         break;
 
     default:
@@ -1612,6 +1616,7 @@ static int mode_select_pages(SCSIDiskReq *r, uint8_t *p, int len, bool change)
                 goto invalid_param_len;
             }
             trace_scsi_disk_mode_select_page_truncated(page, page_len, len);
+            page_len = len;
         }
 
         if (!change) {
@@ -1619,7 +1624,7 @@ static int mode_select_pages(SCSIDiskReq *r, uint8_t *p, int len, bool change)
                 goto invalid_param;
             }
         } else {
-            scsi_disk_apply_mode_select(s, page, p);
+            scsi_disk_apply_mode_select(s, page, p, page_len);
         }
 
         p += page_len;
-- 
2.47.3



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF9ECD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:53:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXmw-0003ph-KV; Fri, 22 May 2026 17:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXmd-0002r7-Td; Fri, 22 May 2026 17:52:00 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXmY-0004Bu-8h; Fri, 22 May 2026 17:51:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779486560; bh=JAZIl9UU37pIptr7cp3TbXuzV+fdEh9Xox+SYIH5P7g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=aRD8u+/O54P5TlLhaf3BQP4rUYboVIX4qO9MGMQiY2BWMHM8o78CTxpDx5uRG1d21
 sF0F3XXzphjjj63V8kE3k9Cvm3ERpKaTFRPeCTvbDFiLKXQP31T8VqAOD5KxavVGGT
 43Fvo4slLaBgbZl8PNi7XM/K0TJtffbM79ZhDvABKwu/hVElqlzvEMruxaX7t745c4
 zo1uu9SlS8J6xTpUtdkuKNc3DzY/7b6HLIPZL++lLHL+FTu7x4UAZ7AQ0vF5E371o8
 J+90180kAy2Bmr6K71XLQA5wxNbaiwhuRyyMQjLR7E5c8nAsVlG+pOGqzNjsfKZE6V
 8ClYsdYUQe18A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EAD7A1AFB76;
 Sat, 23 May 2026 00:49:20 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1EF543B71C5;
 Sat, 23 May 2026 00:49:25 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Katherine Leaver <katherine.j.leaver@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 128/149] aspeed/hace: Prevent total_req_len overflow
Date: Sat, 23 May 2026 00:49:00 +0300
Message-ID: <20260522214923.807017-29-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260522213553@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260522213553@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Cédric Le Goater <clg@redhat.com>

In accumulate mode, total_req_len is incremented with plen (hwaddr)
for each hash request. Repeated additions can overflow total_req_len
(uint32_t) and potentially bypass validation checks in has_padding().

Add a helper function to detect overflow before incrementing
total_req_len and reject the request if overflow would occur.

Reported-by: Katherine Leaver <katherine.j.leaver@gmail.com>
Cc: qemu-stable@nongnu.org
Fixes: 5cd7d8564a8b ("aspeed/hace: Support AST2600 HACE")
Link: https://lore.kernel.org/qemu-devel/20260504213421.710035-3-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
(cherry picked from commit c6aa2d0ac161f2a58a8fbab9a15e846278661158)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
index c7a2731e38..f08b7ae376 100644
--- a/hw/misc/aspeed_hace.c
+++ b/hw/misc/aspeed_hace.c
@@ -205,6 +205,19 @@ static uint64_t hash_get_source_addr(AspeedHACEState *s)
     return src_addr;
 }
 
+static bool hash_accumulate_len(AspeedHACEState *s, hwaddr plen)
+{
+    if (plen > UINT32_MAX - s->total_req_len) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: total_req_len overflow, current=0x%x, adding=0x%"
+                      HWADDR_PRIx "\n", __func__, s->total_req_len, plen);
+        return false;
+    }
+
+    s->total_req_len += plen;
+    return true;
+}
+
 static int hash_prepare_direct_iov(AspeedHACEState *s, struct iovec *iov,
                                    bool acc_mode, bool *acc_final_request)
 {
@@ -232,7 +245,9 @@ static int hash_prepare_direct_iov(AspeedHACEState *s, struct iovec *iov,
     iov_idx = 1;
 
     if (acc_mode) {
-        s->total_req_len += plen;
+        if (!hash_accumulate_len(s, plen)) {
+            return -1;
+        }
 
         if (has_padding(s, &iov[0], plen, &total_msg_len,
                         &pad_offset)) {
@@ -299,7 +314,9 @@ static int hash_prepare_sg_iov(AspeedHACEState *s, struct iovec *iov,
 
         iov[iov_idx].iov_base = haddr;
         if (acc_mode) {
-            s->total_req_len += plen;
+            if (!hash_accumulate_len(s, plen)) {
+                return -1;
+            }
 
             if (has_padding(s, &iov[iov_idx], plen, &total_msg_len,
                             &pad_offset)) {
-- 
2.47.3



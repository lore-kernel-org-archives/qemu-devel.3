Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D2BCDB481
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNmG-00062h-BU; Wed, 24 Jun 2026 09:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNmF-00062E-9H; Wed, 24 Jun 2026 09:36:27 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNmD-0000wS-Id; Wed, 24 Jun 2026 09:36:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782307997; bh=u9MhEfJFgVBl71EK5UreCe/1IDcR0M1fW4f5yCNMfJM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=IwU+cPsxZjhtXvSA0R0eJ767ztEk8qI03nnfBhkA5y3kU2rdmeEQOgsT33Mkh1v2U
 Oc+Ms38OommG1BoxwxIpOaLijdUPaLQWO+IHW2C+CZw/QVyEUxNUzMWwbqTLer69zh
 R5d5+/+ubELT2E5GT2Hwaz+1BUDZrC82b94G+kXDsISfR6fPgNSjsiCeQf1hJ3rPFU
 olmuK8uxW+/ttm2SPIxLRZYC4MN6LCpfeLFBY+WTnnW4wokgdrh7e9y9I1Fr3iJQgQ
 ZxrFTWzXtXVKCgTugtlyxMpkmuPZVd4BfA9z18Dm0yRQ5UtdcSRCc60q49nfV2+UE9
 8bCWz4fPSRv6g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AC9441BA9D7;
 Wed, 24 Jun 2026 16:33:17 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 49BEE3DEA26;
 Wed, 24 Jun 2026 16:33:23 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 037/107] hw/net/rocker_of_dpa: Avoid unaligned
 accesses in _of_dpa_flow_match()
Date: Wed, 24 Jun 2026 16:30:42 +0300
Message-ID: <20260624133301.403266-37-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
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

From: Peter Maydell <peter.maydell@linaro.org>

_of_dpa_flow_match() tries to do masked comparisons of OfDpaFlowkey
structs by casting pointers to them to uint64_t* and then doing the
memory accesses as 64-bit. This is undefined behaviour because the
pointers might not be 64-bit aligned, and the UB sanitizer spots this:

../../hw/net/rocker/rocker_of_dpa.c:321:20: runtime error: load of misaligned address 0x512000164044 for type 'uint64_t' (aka 'unsigned long'), which requires 8 byte alignment
0x512000164044: note: pointer points here
  02 00 00 00 00 00 ff ff  00 00 00 00 ff ff ff ff  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
              ^

We do know that OfDpaFlowKey structs must be at least aligned enough
for uint32_t accesses, because that's the type of the first field.
Switch to using uint32_t accesses in the loop.

Because the "width" field is always set via the FLOW_KEY_WIDTH macro
and not exposed to the guest, we can adjust the macro to store the
number of uint32_t to be checked rather than needing to change the
loop boundary in the match function.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit 71d027cfee8553e2ec28efa1ddd7fd0ecbadcc86)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/rocker/rocker_of_dpa.c b/hw/net/rocker/rocker_of_dpa.c
index 958f3006c1..3d6f55b512 100644
--- a/hw/net/rocker/rocker_of_dpa.c
+++ b/hw/net/rocker/rocker_of_dpa.c
@@ -99,13 +99,13 @@ typedef struct of_dpa_flow_key {
             } nd;
         } ipv6;
     };
-    int width;                       /* how many uint64_t's in key? */
+    int width;                       /* how many uint32_t's in key? */
 } OfDpaFlowKey;
 
-/* Width of key which includes field 'f' in u64s, rounded up */
+/* Width of key which includes field 'f' in u32s, rounded up */
 #define FLOW_KEY_WIDTH(f) \
     DIV_ROUND_UP(offsetof(OfDpaFlowKey, f) + sizeof_field(OfDpaFlowKey, f), \
-    sizeof(uint64_t))
+    sizeof(uint32_t))
 
 typedef struct of_dpa_flow_action {
     uint32_t goto_tbl;
@@ -304,9 +304,9 @@ static void _of_dpa_flow_match(void *key, void *value, void *user_data)
 {
     OfDpaFlow *flow = value;
     OfDpaFlowMatch *match = user_data;
-    uint64_t *k = (uint64_t *)&flow->key;
-    uint64_t *m = (uint64_t *)&flow->mask;
-    uint64_t *v = (uint64_t *)&match->value;
+    uint32_t *k = (uint32_t *)&flow->key;
+    uint32_t *m = (uint32_t *)&flow->mask;
+    uint32_t *v = (uint32_t *)&match->value;
     int i;
 
     if (flow->key.tbl_id == match->value.tbl_id) {
-- 
2.47.3



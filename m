Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D68FFC44506
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 04:23:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wilhA-0003oz-I4; Sun, 12 Jul 2026 00:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilh6-0003eS-Kh; Sun, 12 Jul 2026 00:21:33 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilh4-000774-Td; Sun, 12 Jul 2026 00:21:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783829782; bh=qTlKMcp1/538st1InQe/VhKhpqkwgvvEzQtkZKNKcj4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=B9Pm5nFOvMP6FH/sTAABJ1tFPkt0tvhTrxekXGVcD18mHp7ofLG497S45Iwif9k7O
 HE/4GBAEbDwhEsl0FC3hPt4dSa1bl/ANT98OAlHfVZc3z81BpjVovKqGyL8jlEMosk
 oAv6ihSPcBXrCL1tPJYKue5y9c7OZfoNayHH8XxxIeKIptY13xzU2BrP1wEA9WEp7x
 GiGLuqRGKukfbxXPSSf7OjLIHXISlXssbIp0ZfP8SFeiQtM57uegdlwgaMkJSX3Mkc
 TNSLtuHjQT3JQY9gbZt6emNyfNQNm57IVemJfV9oB/AG7ZHDXwXnnms3RydcpkNzIe
 63P54yVvvmKeQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0964B1C0C12;
 Sun, 12 Jul 2026 07:16:22 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3C6CA3EB972;
 Sun, 12 Jul 2026 07:16:32 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 971EF13427; Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 55/75] tcg/loongarch64: Fix vec_val computation in
 tcg_target_const_match
Date: Sun, 12 Jul 2026 07:15:13 +0300
Message-ID: <20260712041539.108341-55-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Only use vece for a vector constant.  This avoids an assertion
failure in sextract64 when vece contains garbage.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit a079836005fb92eb1fee19e59654b337a41fd0ff)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index cbd7642b58a..740b7c264d6 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -211,12 +211,14 @@ static bool tcg_target_const_match(int64_t val, int ct,
     if ((ct & TCG_CT_CONST_WSZ) && val == (type == TCG_TYPE_I32 ? 32 : 64)) {
         return true;
     }
-    int64_t vec_val = sextract64(val, 0, 8 << vece);
-    if ((ct & TCG_CT_CONST_VCMP) && -0x10 <= vec_val && vec_val <= 0x1f) {
-        return true;
-    }
-    if ((ct & TCG_CT_CONST_VADD) && -0x1f <= vec_val && vec_val <= 0x1f) {
-        return true;
+    if (ct & (TCG_CT_CONST_VCMP | TCG_CT_CONST_VADD)) {
+        int64_t vec_val = sextract64(val, 0, 8 << vece);
+        if ((ct & TCG_CT_CONST_VCMP) && -0x10 <= vec_val && vec_val <= 0x1f) {
+            return true;
+        }
+        if ((ct & TCG_CT_CONST_VADD) && -0x1f <= vec_val && vec_val <= 0x1f) {
+            return true;
+        }
     }
     return false;
 }
-- 
2.47.3



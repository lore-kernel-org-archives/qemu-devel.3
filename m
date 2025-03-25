Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A4DC35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 06:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twy8Q-0004zr-7J; Tue, 25 Mar 2025 02:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1twy7v-0004lo-Mw; Tue, 25 Mar 2025 02:51:08 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1twy7t-0001iQ-UG; Tue, 25 Mar 2025 02:51:07 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 20219107D6C;
 Tue, 25 Mar 2025 09:49:29 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B6ED91D5E79;
 Tue, 25 Mar 2025 09:50:38 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id B2F155703A; Tue, 25 Mar 2025 09:50:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.10 44/51] target/arm: Simplify pstate_sm check in
 sve_access_check
Date: Tue, 25 Mar 2025 09:50:31 +0300
Message-Id: <20250325065038.3263786-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-8.2.10-20250325094857@cover.tls.msk.ru>
References: <qemu-stable-8.2.10-20250325094857@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

In StreamingMode, fp_access_checked is handled already.
We cannot fall through to fp_access_check lest we fall
foul of the double-check assertion.

Cc: qemu-stable@nongnu.org
Fixes: 285b1d5fcef ("target/arm: Handle SME in sve_access_check")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250307190415.982049-3-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: move declaration of 'ret' to top of block]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit cc7abc35dfa790ba6c20473c03745428c1c626b6)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 67d3219a30..c7428eb674 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1244,23 +1244,23 @@ static bool fp_access_check(DisasContext *s)
 bool sve_access_check(DisasContext *s)
 {
     if (s->pstate_sm || !dc_isar_feature(aa64_sve, s)) {
+        bool ret;
+
         assert(dc_isar_feature(aa64_sme, s));
-        if (!sme_sm_enabled_check(s)) {
-            goto fail_exit;
-        }
-    } else if (s->sve_excp_el) {
+        ret = sme_sm_enabled_check(s);
+        s->sve_access_checked = (ret ? 1 : -1);
+        return ret;
+    }
+    if (s->sve_excp_el) {
+        /* Assert that we only raise one exception per instruction. */
+        assert(!s->sve_access_checked);
         gen_exception_insn_el(s, 0, EXCP_UDEF,
                               syn_sve_access_trap(), s->sve_excp_el);
-        goto fail_exit;
+        s->sve_access_checked = -1;
+        return false;
     }
     s->sve_access_checked = 1;
     return fp_access_check(s);
-
- fail_exit:
-    /* Assert that we only raise one exception per instruction. */
-    assert(!s->sve_access_checked);
-    s->sve_access_checked = -1;
-    return false;
 }
 
 /*
-- 
2.39.5



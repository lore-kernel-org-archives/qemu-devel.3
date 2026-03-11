Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 144301125875
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 19:36:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0PLR-0007hJ-Qm; Wed, 11 Mar 2026 15:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0PL7-0007Vd-JP; Wed, 11 Mar 2026 15:35:29 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0PL6-00008C-0C; Wed, 11 Mar 2026 15:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773257666; bh=FWx38I5a5emH/5IenvOoVjTCDmASckiQpQhd//9ez0Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=VrM2/A5h5n5ipCKXf6DbFO7GgAQ4HKgWwS+C4kKDAaBZqqRs6RnXNwLbV6yQ+WpbA
 osshc71B6rNGuc/kwjZ8xeBElu8w9Q/TEqT7Q2Vh19vTCmgwa90PItcb8MQB4RCH1j
 8NpMQexxfGgt/wJvekoQc7n7DdLPYC19QSfgJYRUZi+PgYsXgse9jFe2kvmusjJ6II
 FlGiHRLNgVUhQUR7laJkOcpgeaQSvMKLlwBBMO7d5oITSEcsQXtAD3KDy4UkzTHVIv
 RDd5qg1DX0JbZIWz2otBZKCHH68p9iF38JE0CQx0N9KIOLioxstEREiCN+pQtUcDCj
 GFgFTklFMsDDg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EF6921920F3;
 Wed, 11 Mar 2026 22:34:26 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3A78237C458;
 Wed, 11 Mar 2026 22:35:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.2 11/53] target/arm: Account for SME in
 aarch64_sve_narrow_vq() assertion
Date: Wed, 11 Mar 2026 22:34:04 +0300
Message-ID: <20260311193449.1096110-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
References: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

In aarch64_sve_narrow_vq() we assert that the new VQ is within
the maximum supported range for the CPU. We forgot to update
this to account for SME, which might have a different maximum.

Update the assert to permit any VQ which is valid for either
SVE or SME.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260202133353.2231685-2-peter.maydell@linaro.org
(cherry picked from commit 42eab40a12f12f044a5ca7b7d889d9a1f0d172ee)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 633d314edf..5d31c551e1 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10058,7 +10058,7 @@ void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq)
     uint64_t pmask;
 
     assert(vq >= 1 && vq <= ARM_MAX_VQ);
-    assert(vq <= env_archcpu(env)->sve_max_vq);
+    assert(vq <= arm_max_vq(env_archcpu(env)));
 
     /* Zap the high bits of the zregs.  */
     for (i = 0; i < 32; i++) {
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 75677945af..d5f6d6546f 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1807,6 +1807,15 @@ static inline uint64_t arm_mdcr_el2_eff(CPUARMState *env)
     ((1 << (1 - 1)) | (1 << (2 - 1)) |                  \
      (1 << (4 - 1)) | (1 << (8 - 1)) | (1 << (16 - 1)))
 
+/*
+ * Return the maximum SVE/SME VQ for this CPU. This defines
+ * the maximum possible size of the Zn vector registers.
+ */
+static inline int arm_max_vq(ARMCPU *cpu)
+{
+    return MAX(cpu->sve_max_vq, cpu->sme_max_vq);
+}
+
 /*
  * Return true if it is possible to take a fine-grained-trap to EL2.
  */
-- 
2.47.3



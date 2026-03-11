Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94BA112583E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0LBf-0000at-AV; Wed, 11 Mar 2026 11:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0L9x-0004Pc-Oc; Wed, 11 Mar 2026 11:07:43 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0L9t-0005Pc-L8; Wed, 11 Mar 2026 11:07:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773241481; bh=FB4jjS7oGuteuSerXx9FNPqkF7kbcDZLD/fyDh8Zzks=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=IxxosI9SSHdyBEiR3wFKx+u+M5UOxfEdjlzcFUmi6Brle804THNBu0Q7/2Ra9RX3R
 yI9WW3EhV2fnCBi91P6lwD9oVXsSQLg+YUsCzCzRxVsg15bAmVPTlL5Q1wZBTAHf/d
 9CKU0FyN4JOfDb8AfH4R+qvVEcB99LYjGJPTtyJ3h9HiijLzOI6YZ13UYiB35vDGA4
 azU3J7ZQVXlsWcdWmkRXgdLc+LV+9kqkyS7tCMbPywOVXz7D7mkEJgqdsrfZGsIlkB
 Q5PI2vBhjfdtyURvyvUBd+0eA1oicIcT8fL/cM5VjeAFPdJf5vefyQR5a+SUnhtvix
 9Y0nNn7CDKYOg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BC9D8191E8E;
 Wed, 11 Mar 2026 18:04:41 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id A80FF37C2CF;
 Wed, 11 Mar 2026 18:05:19 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.5 11/46] target/arm: Account for SME in
 aarch64_sve_narrow_vq() assertion
Date: Wed, 11 Mar 2026 18:02:47 +0300
Message-ID: <20260311150327.1084669-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.5-20260311180252@cover.tls.msk.ru>
References: <qemu-stable-10.1.5-20260311180252@cover.tls.msk.ru>
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
index 318452d816..518c0c191f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9660,7 +9660,7 @@ void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq)
     uint64_t pmask;
 
     assert(vq >= 1 && vq <= ARM_MAX_VQ);
-    assert(vq <= env_archcpu(env)->sve_max_vq);
+    assert(vq <= arm_max_vq(env_archcpu(env)));
 
     /* Zap the high bits of the zregs.  */
     for (i = 0; i < 32; i++) {
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 1b3d0244fd..36fa5c3d40 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1881,6 +1881,15 @@ static inline uint64_t arm_mdcr_el2_eff(CPUARMState *env)
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



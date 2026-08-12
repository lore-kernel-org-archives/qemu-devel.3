Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 481F1C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 17:46:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuD0T-0002tZ-1y; Wed, 12 Aug 2026 13:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wuD0K-0002nz-7W
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 13:44:40 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wuD0D-0007cZ-Qm
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 13:44:39 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-38e7109321dso1110997a91.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 10:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1786556671; x=1787161471; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rOQkVidkXGCU4X6LBKsJvJHPV73NIi57GitFKMqrLX0=;
 b=U4Z3/TV7+O2mhdO9r1Bc3fWPjxSbssWEwKU1SAKEdNkH7IHDn+5jGfPy6tPRttakh+
 b+freKjm6suBEX1aDrR3sut7VSWEhKnO6MTF+WZFaLSr++wLrssixjI0RRbfqMoIb0hI
 8k17X6osH6/5U5sHAUWGzxx7EAGL4HAspbnPjIsCWLzFC1ntOAeUtlg8+fVgw0Zu6b0M
 P1ASKLtteGg3gpV+av2heyviWjJpYankhNxpLt4hTVbMFJDPHbOp1j/5crW1EMf1CKEd
 cyv6A4wszcZ0J/bVT1aV9dzbSMsA8xjOJU1UV7oZ/a8eo08UihQJsQIH/YYvHYvzj0UC
 vV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786556671; x=1787161471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rOQkVidkXGCU4X6LBKsJvJHPV73NIi57GitFKMqrLX0=;
 b=Kb8tlHPrHslbnR96bKzqKIFaUKmktsprFrCxGT7VOw41MMAjA4Ykow7oAL+aL9/n1w
 5YtJaQIvQxqb3yDcDehNVs5KpTZCtLMAPUfPyKFx+MTINtJVhd7Zcc6KYkOLE9JI/j9M
 Hb4q46zqaD1oddjfZ1z/pJxtayZIwJjKYlCVK687HY2Qq25QqFOqrLeIIag+XbQ4LaRl
 QU1h81VCurLL33Ut+IVLlGMm+mSTOFZ8qRVie5OqqC3FD38riJqgmgCeuMpOoTS/n5x6
 D6QeKPsu8yfS1RBqMPwr9CefLSXXFNJxTw46jbQ0SbsUaCn29qUMR5nmuEgJBxIOJL+Z
 Elbg==
X-Gm-Message-State: AOJu0Yxq8Y1HeM8P7DEYvRm/DYrVhxSWcx8iA1dAeWomjL4InOEyHXM1
 T7HCMHEi7GXLh3fXS5iCzk6pryzMhsIGowKJQX27wREy4KI6zpSH3Q0obmd061FFsSC4iidoTp6
 o+hPZ+eDosXoYSdOaQw/UXmDNtsSbwsKUJH4t9c2StAQMVMzZZ5e1aQU5BX5ODwyUofUXg+0RPy
 fnfspvGna167XfXqJJCmq8qll6b76II4xcRTTpHxQ=
X-Gm-Gg: AR+sD13HzvKDrFYiW9cHabAUJkIDoDm/Kdsa19m5PxO4YyKefNBpa7G4rMsJaG8un0p
 EjGaRtBQt53+1X+iFFlf+zRC6zfI35IsW08VazeDc59DjqKeuyya4tJAB8ivz96eLaf1iNXtJyU
 Qk4E+IY6LK6ajMWTErcFWmMKrRLIeBGbl2IoKqU+jwXKku6P85HgeSc59GMxRo7c8MNmnyTu4iq
 bPO3q+7qFSvRNzFcjtCJniilTKXJ4dPm/5+Mqvt5P6ngkuslc/d+bCx/kRlpsaGO4niXNj4xyN/
 vbu3Nj1Wvp8A9yBy4PO/BlPbmsflb9uTQbEVJM2pnQKTEDsiTjo0s+R6UJocAQFRidvcyO5TzZ3
 VGKffyjav6JNxZGKE31tn1JNGFPyM4bGKNJeyisijYHC43N92edEvvx2ShFBYt5Fqp8gFhjHw3b
 Hp1dweW4juqFh4NHRfFEliQCXoiDD4OsobvPVnqsoKzXGyzxDQLv85JBN7qWuVmZw9et745Bs7/
 LIbzYKKlFKcMY9A4EHzCKFoiZ7u1Oq7ZfQlETqcesqDqWglLdVUk568pwI7G31p
X-Received: by 2002:a17:90b:38d1:b0:380:21b7:e727 with SMTP id
 98e67ed59e1d1-393014cac5dmr6841255a91.14.1786556671046; 
 Wed, 12 Aug 2026 10:44:31 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3931db13c3bsm13210a91.3.2026.08.12.10.44.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 10:44:30 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Max Chou <max.chou@sifive.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 2/6] target/riscv/cpu: List one implied-ext rule per line
Date: Thu, 13 Aug 2026 01:44:12 +0800
Message-ID: <20260812174417.2468981-3-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812174417.2468981-1-max.chou@sifive.com>
References: <20260812174417.2468981-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Every entry added to riscv_multi_ext_implied_rules[] currently has to
reflow whatever line it lands on, since entries are packed several
per line. List one rule per line instead so future additions are a
pure append.

Suggested-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 58 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 14 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e643d7c7af7..fffb92ff110 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2818,20 +2818,50 @@ RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
 };
 
 RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
-    &ZCB_IMPLIED, &ZCD_IMPLIED, &ZCE_IMPLIED,
-    &ZCF_IMPLIED, &ZCMP_IMPLIED, &ZCMT_IMPLIED,
-    &ZDINX_IMPLIED, &ZFA_IMPLIED, &ZFBFMIN_IMPLIED,
-    &ZFH_IMPLIED, &ZFHMIN_IMPLIED, &ZFINX_IMPLIED,
-    &ZHINX_IMPLIED, &ZHINXMIN_IMPLIED, &ZICNTR_IMPLIED,
-    &ZIHPM_IMPLIED, &ZK_IMPLIED, &ZKN_IMPLIED,
-    &ZKS_IMPLIED, &ZVBB_IMPLIED, &ZVE32F_IMPLIED,
-    &ZVE32X_IMPLIED, &ZVE64D_IMPLIED, &ZVE64F_IMPLIED, &ZVE64X_IMPLIED,
-    &ZVFBFA_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
-    &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
-    &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
-    &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SHA_IMPLIED,
-    &SSCFG_IMPLIED, &SUPM_IMPLIED, &SSPM_IMPLIED, &SMCTR_IMPLIED,
-    &SSCTR_IMPLIED, &SSSTATEEN_IMPLIED,
+    &ZCB_IMPLIED,
+    &ZCD_IMPLIED,
+    &ZCE_IMPLIED,
+    &ZCF_IMPLIED,
+    &ZCMP_IMPLIED,
+    &ZCMT_IMPLIED,
+    &ZDINX_IMPLIED,
+    &ZFA_IMPLIED,
+    &ZFBFMIN_IMPLIED,
+    &ZFH_IMPLIED,
+    &ZFHMIN_IMPLIED,
+    &ZFINX_IMPLIED,
+    &ZHINX_IMPLIED,
+    &ZHINXMIN_IMPLIED,
+    &ZICNTR_IMPLIED,
+    &ZIHPM_IMPLIED,
+    &ZK_IMPLIED,
+    &ZKN_IMPLIED,
+    &ZKS_IMPLIED,
+    &ZVBB_IMPLIED,
+    &ZVE32F_IMPLIED,
+    &ZVE32X_IMPLIED,
+    &ZVE64D_IMPLIED,
+    &ZVE64F_IMPLIED,
+    &ZVE64X_IMPLIED,
+    &ZVFBFA_IMPLIED,
+    &ZVFBFMIN_IMPLIED,
+    &ZVFBFWMA_IMPLIED,
+    &ZVFH_IMPLIED,
+    &ZVFHMIN_IMPLIED,
+    &ZVKN_IMPLIED,
+    &ZVKNC_IMPLIED,
+    &ZVKNG_IMPLIED,
+    &ZVKNHB_IMPLIED,
+    &ZVKS_IMPLIED,
+    &ZVKSC_IMPLIED,
+    &ZVKSG_IMPLIED,
+    &SHA_IMPLIED,
+    &SSCFG_IMPLIED,
+    &SUPM_IMPLIED,
+    &SSPM_IMPLIED,
+    &SMCTR_IMPLIED,
+    &SSCTR_IMPLIED,
+    &SSSTATEEN_IMPLIED,
     NULL
 };
 
-- 
2.43.0



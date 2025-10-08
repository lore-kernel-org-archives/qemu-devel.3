Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C8A0CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 05:16:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6MWi-0000KL-9j; Wed, 08 Oct 2025 01:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6MWf-0000Ju-QO
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 01:15:45 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6MWd-0004HV-C1
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 01:15:45 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46e3cdc1a6aso3167365e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 22:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759900541; x=1760505341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N7nTG1OAwF78b/7SFJDM5fupoC2R3lO1U/+AKptoqog=;
 b=aB3opJCKbLF8vG37ya2uF7NleTSHI+vArXUBAjAufzgNhICyIMTPn/5v5kxP/s2bwb
 AaRdr9aWnmJsfuURGhRtE8OxhLhV334Kfum+3KbpqPfrFqq4G3aTuugE8lM/FZOD9KYR
 BjKqepoyG5FhKInaG68H4+s3xr7LPRVw2emMckX2eTU0j7svLQdeziLYTYhLPsNUixNl
 spJBSydcSyncspPDRYvtAjI7LgGLrDQDdRT/30ML4k2MXNnj7bsLzgQaILYFZLElvO82
 fR9b8mwoxcUfjGqo66glxpcsbpVL9zF7cD91UYv6SRa8mGPvmaf2Hsgx6XhyT9Le0+/D
 PLhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759900541; x=1760505341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N7nTG1OAwF78b/7SFJDM5fupoC2R3lO1U/+AKptoqog=;
 b=kP1ymjmumuO/j6kNpQkkwwn4TqhbcwsrIRyRm0dlk2zlUvET/6S9O2qXyyk3/aTQOH
 390swETK7NCiCmcGr7oOXTj+wUQpeXEIVgdHFwXSDF78qswca1zNWLx2KvSFiP82Gyoi
 J9egMxIVQV5DOTbcxeg+nkn4Am4UIWDSqh8HP/3KLw/EhArV/mClkYl7J/8u82xMBD9o
 TFM5Ji4+28nIWQql5mJUWLt/8RPtiODbDF5hMAPB8urcZxjMA0KtKg/M7BNCClXU62CQ
 VOpaSclZIwgHtzdWkNE5Bydx+UwPn8IkQUK1T7Kq2tQKP+oTW+RBQp4LDHSAoPXJZIsP
 bmOA==
X-Gm-Message-State: AOJu0YyCNPvPOPSNXMBUAsfPgtsT2eYxje420gf9i0jOyILhjF2aRZ3t
 2ZMZ+TgD46SRJ1GkoqOBhi/dAbBkHFT19IT7fGDiQQVL9c3wsnrpI6PsCzN52r3PG7O/lJ0RQka
 M2jZtu/qKfw==
X-Gm-Gg: ASbGncslW1NLdTZbh3y+JVHiS1RinF2PPBTWq/m1GkMww2ymb6CRXTHbYZ5SAbMC9Gw
 QP6jZIfpa1FmOsU2FnLijqDZTA/qaLutb/oJ3nWtEtruhlnh88L8cv1wUVojuTPZRTMUczDYUZL
 n3KogI2wb9KJTzbXc73k8jEqQPMnUdKlNFP4ws/y8i3EdYhIQYFt109+ehxlo5Pvya/2iLvL4at
 qHAlDp3gPtKXwYBq91hGkfNWD8BrZPHbv4nzdTAYNW0eI4RRX2Yabzyh9RHraVV8QhSq5DLWu05
 31XupapAT4Bq+BGxjmZ9kxI4WfZt3dWBvCA+Anz6r7m9Nz03ZjmjOVHLGoqEyA0yUDJpAUDkJ/Y
 Z3DopnB+U5zzGx76M+8pKs5dAYtu52UWEl+Hueapn8ZNcxvX+JkqGXsORyLWN7c260cs9lDHrD5
 /NtF5SGFZu+iYs5cSQhBJsBaYh
X-Google-Smtp-Source: AGHT+IGyLCJHrxWDlaeJ2FQo10W6LT2ijwSXafF+wYaIDSAaTjkkMJq2ETGHYcOdfQxVXf6sLeFiKQ==
X-Received: by 2002:a05:600c:450e:b0:46e:1a60:c995 with SMTP id
 5b1f17b1804b1-46fa9e8dcc7mr12428165e9.2.1759900541208; 
 Tue, 07 Oct 2025 22:15:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa9d4c8c5sm19734935e9.11.2025.10.07.22.15.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Oct 2025 22:15:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/2] target/xtensa: Remove target_ulong use in
 xtensa_get_tb_cpu_state()
Date: Wed,  8 Oct 2025 07:15:29 +0200
Message-ID: <20251008051529.86378-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008051529.86378-1-philmd@linaro.org>
References: <20251008051529.86378-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Since commit bb5de52524c ("target: Widen pc/cs_base in
cpu_get_tb_cpu_state"), cpu_get_tb_cpu_state() expects
a uint64_t type for cs_base.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/xtensa/cpu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index ea9b6df3aa2..1eeed44e336 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -59,13 +59,13 @@ static TCGTBCPUState xtensa_get_tb_cpu_state(CPUState *cs)
 {
     CPUXtensaState *env = cpu_env(cs);
     uint32_t flags = 0;
-    target_ulong cs_base = 0;
+    uint64_t cs_base = 0;
 
     flags |= xtensa_get_ring(env);
     if (env->sregs[PS] & PS_EXCM) {
         flags |= XTENSA_TBFLAG_EXCM;
     } else if (xtensa_option_enabled(env->config, XTENSA_OPTION_LOOP)) {
-        target_ulong lend_dist =
+        uint64_t lend_dist =
             env->sregs[LEND] - (env->pc & -(1u << TARGET_PAGE_BITS));
 
         /*
@@ -83,7 +83,7 @@ static TCGTBCPUState xtensa_get_tb_cpu_state(CPUState *cs)
          * for the TB that contains this instruction.
          */
         if (lend_dist < (1u << TARGET_PAGE_BITS) + env->config->max_insn_size) {
-            target_ulong lbeg_off = env->sregs[LEND] - env->sregs[LBEG];
+            uint64_t lbeg_off = env->sregs[LEND] - env->sregs[LBEG];
 
             cs_base = lend_dist;
             if (lbeg_off < 256) {
-- 
2.51.0



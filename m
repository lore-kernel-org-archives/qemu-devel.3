Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77621C83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 18:07:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZZBg-0001MX-Jg; Wed, 09 Jul 2025 14:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uZZBD-00018I-Cn
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 14:06:03 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uZZBB-0004AI-Ac
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 14:06:03 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2353a2bc210so1981745ad.2
 for <qemu-devel@nongnu.org>; Wed, 09 Jul 2025 11:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752084358; x=1752689158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hEjr7l7Vs6ji+drc/SRFgbkpYtZx+u1bmbu4VpSnODg=;
 b=XMVYadiyAGursnXJyCIehcvIBZq4QbBEzY7KKpikeIFhmkxYLNI6ObVAyQ1qs2JKlr
 bxFfA5jmW/QwA3e6/zPIlRx3HEing5AJGRmbcjWb0cwBmXVVIbXXCnInn5Q5cemhbk4x
 BcI6MUlElpSAyb7KtFqdys3YNJKa49BjXe6Ur1o7q2uoNsW8PZfb73btGNuYaYgtfc4n
 RbKosPXP9XWJ5XRiwsnPLhRgXVNY2vc325497fsGsAhZxCIShkkClTkO2WkWtScp/OWs
 X4Kk9IBhAU/h/f34EGzYJG9k+Juj+lbx8xNGlxzaYC27DfDs/+o8rxaLH5uCgmj5RLgA
 H69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752084358; x=1752689158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hEjr7l7Vs6ji+drc/SRFgbkpYtZx+u1bmbu4VpSnODg=;
 b=S+EU7jXwQYr/7VQSmWueqxnYBEbm4/SJoe4HN3lqwqV1SOVAz4u9bKoTEtusn5w34D
 D+olQaKRJ2kELTSzxrw2YcTtyFvwonyxmw1lAsdVGz6R57X3RRoNMO1i0aus+rU1oYq1
 hwwEkCNNYxL1Z0eLmxtwIA7F1oiwGIew5K2uYd/0TkaPGCQUXgIAWLDC+HetBV4gYHfS
 r004m59Si1v5VJkpstQ96aRZ4nqK5r1kjdjRrk7VbhyjLN6e3E8E6t1gPEUJNmUoY3RT
 PhdNKUNcOLOjZBZYMmZGb9nvj7/wx5VrnGVbPyO0oqVwm2oKdhdKdPujehC9tVPeWQzH
 e3Xg==
X-Gm-Message-State: AOJu0Yzi6k8JYwmvCbARpI1YUjS03JOhyo3ANhDsqfbq7SCj4QBYGRV4
 UYc9HBjxbjm23mHymvy8jUD1wYzhav/mV4Dqm6YPQyDnmGN+zutyiXLZ7cFy/fu83SM=
X-Gm-Gg: ASbGnctRhaK+HPZBq9uuAFjXQRhkWCOBnRR2XxZieaV5GyTewjjNZ1F2UHA31PAqX2X
 Nwq5CBaRqLxbMk4l3HMIowISMLJFxGb9NsZecfOePoQz1WsEnFKgLTlLorMrH+GEllqDq0zBpMM
 YUXO4gn0BxKUBXnQKzzvXk7gO0o/t2k9iIGuVcb2IIRcGbIWwAIHfjIZucss5E3Ylg53p6N8F8t
 6DsbK6ETqBp2UnizCydTuULB/srgQ6HuyCbUvM+TFA/KGF1C8wfYL+oLTVzB5bLttunMB4Sogo6
 YmBU7UJb/3/i+MTZviJQp67f1KKk1WP1+Tt/TTjb9igPPCMKqcnyXb0tloPp05GFiGp4HvUaYb+
 gXQ==
X-Google-Smtp-Source: AGHT+IG+RVMysxOUJfOgSpCWXAGxsJabgQPJ/CbTIhkqh9lc5crJYKgrDoBeJUjQjtass0GaTBdKbw==
X-Received: by 2002:a17:902:ce07:b0:234:8f5d:e3a4 with SMTP id
 d9443c01a7336-23de2436d01mr14864655ad.2.1752084358111; 
 Wed, 09 Jul 2025 11:05:58 -0700 (PDT)
Received: from gromero0.. ([189.110.24.38]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c84599f07sm153380175ad.218.2025.07.09.11.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 11:05:57 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-arm@nongnu.org, richard.henderson@linaro.org, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org,
	gustavo.romero@linaro.org
Subject: [PATCH v4 5/6] target/arm: Implement FEAT_MEC cache instructions
Date: Wed,  9 Jul 2025 18:03:25 +0000
Message-Id: <20250709180326.1079826-6-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709180326.1079826-1-gustavo.romero@linaro.org>
References: <20250709180326.1079826-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x636.google.com
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

This commit implements the two cache maintenance instructions introduced
by FEAT_MEC, DC CIPAE and DC CIGDPAE.

Because QEMU does not model the cache topology, all cache maintenance
instructions are implemented as NOPs, hence these new instructions are
implemented as NOPs too.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 target/arm/helper.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 34e12bde90..36cf2b6415 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4996,6 +4996,34 @@ static void ic_ivau_write(CPUARMState *env, const ARMCPRegInfo *ri,
 }
 #endif
 
+static CPAccessResult cipae_access(CPUARMState *env, const ARMCPRegInfo *ri,
+                                   bool isread)
+{
+    int el = arm_current_el(env);
+
+    if (!cpu_isar_feature(aa64_mec, env_archcpu(env))) {
+        return CP_ACCESS_UNDEFINED;
+    }
+    if (el < 3 && arm_security_space(env) != ARMSS_Realm) {
+        return CP_ACCESS_UNDEFINED;
+    }
+    return CP_ACCESS_OK;
+}
+
+static CPAccessResult cigdpae_access(CPUARMState *env, const ARMCPRegInfo *ri,
+                                     bool isread)
+{
+    CPAccessResult ret = cipae_access(env, ri, isread);
+
+    if (ret != CP_ACCESS_OK) {
+        return ret;
+    }
+    if (!cpu_isar_feature(aa64_mte, env_archcpu(env))) {
+        return CP_ACCESS_UNDEFINED;
+    }
+    return CP_ACCESS_OK;
+}
+
 static const ARMCPRegInfo v8_cp_reginfo[] = {
     /*
      * Minimal set of EL0-visible registers. This will need to be expanded
@@ -5094,6 +5122,12 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 14, .opc2 = 2,
       .fgt = FGT_DCCISW,
       .access = PL1_W, .accessfn = access_tsw, .type = ARM_CP_NOP },
+    { .name = "DC_CIPAE", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 7, .crm = 14, .opc2 = 0,
+      .access = PL2_W, .accessfn = cipae_access, .type = ARM_CP_NOP },
+    { .name = "DC_CIGDPAE", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 7, .crm = 14, .opc2 = 7,
+      .access = PL2_W, .accessfn = cigdpae_access, .type = ARM_CP_NOP },
 #ifndef CONFIG_USER_ONLY
     /* 64 bit address translation operations */
     { .name = "AT_S1E1R", .state = ARM_CP_STATE_AA64,
-- 
2.34.1



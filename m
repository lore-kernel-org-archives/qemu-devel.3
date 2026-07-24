Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E098C531CC
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 03:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn6Jx-0004ZT-1b; Thu, 23 Jul 2026 23:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wn6Jv-0004Vn-Rn
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 23:11:31 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wn6Jt-0000U6-KF
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 23:11:31 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c9e0b89e228so997522a12.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 20:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784862688; x=1785467488; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d4ymIqCqxq1PLCOb909nXPImc42YibJwInzctDWldOk=;
 b=PzyHL7n0A/T1A4FiCDLZ85+YCMXwgAoghemJrjHT0K6EGxh4N2IY5NHwo16aqAzeX7
 zPxyl2EuPRtsLJELwrznT0DanEX5yeK9cO8c7HAAi9PvQckXaibUMDZbUlX4QNownwfq
 BH/E/8xNl6WdLkhZLJdQ8PHHPCGS2D+Em2EdcGtieBjDbAIW7b0IKXDEnupgjEsQRFAo
 tBkhTHaOk3cbGRORBxzwEF8rccZJR+isGMSjTtcBvI8BPvrrEf4IiFLtxPmhEIBmRWw0
 ocNNbTjqnRk2l3CWXSPrmJBV5GVzf4pYTjN/q1SUg3db+5I01WtP9/EnYrVTrAJFWKyC
 xlZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784862688; x=1785467488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=d4ymIqCqxq1PLCOb909nXPImc42YibJwInzctDWldOk=;
 b=J0SXx5hRFtzrtfe/tTlRH5UpiZAUmqLdD08dVerzGi3NbpkThy81ug4s/65Qv236Fl
 7a8XVXQt64kvDW9ZlNdr7JN4zj1ur+lotQYP1XmEo0YY88g8fEUKBGmvoZ0opGglJohv
 75mdXZPE9QAP+VGs71rJRLtElLNC7z6g/5eCoc8aZ9zyRtGVXN6bFIywL8DSAV1p3z51
 XMzoZCsXNEvAdUkfvtCGKI5cv+V7clfXlvbchIt50Y8b2WBHymSe2CV2CSZAJyENtwXt
 llWm66PJgIl+Op0ejZe+vVbPB2mMEmQvTb11f+Wp3DtPwlP6s/jDMoEbQtSbMC5Ww/2t
 tf+Q==
X-Gm-Message-State: AOJu0YwfTCv2tXLXq1TA0SsYLMSx+54C9G2Jjd56xLY4q6kXNVY9iQZ8
 k85NfL+S4EHIOW8Xt8jm6cFTpy5b+O5R1aJtLUzXXDAqKkFYGAZwuYJ0IAVn0FChr5NobNBhzy4
 OdNvQ
X-Gm-Gg: AR+sD11GxRqm3l2hiEj8kkUTukDgJ5/GG8Lq5zeLNqLIZiIOvMhpqdq36zzS0zO92Ks
 8vMQNE8tkkdQjgpic4f1+koRUG9l/iBuP6Oitdr7sr1OKQELT+FMnZbFBAhAGKLcFKhTVWMP8jb
 ETJ7KePSXzFdn+TtwVCgY9N/aVd+1j0hlIHP60rA7nIKm0Y4D1F2aEpwOFyRijhHA+SPFgfFBgh
 yASHvpwReOeqDfgpkhZw8K9P7bUnXPKK4CEKbhBqPmHU2SpLLTTTntWtkfpMGBlvoxhDPhRgqKq
 WDNSONV9Ks0uNNvIVLwss4zOZaa5AUXKcYHSSFXrNZgWqqB0VV7BraNTm0RyNSBJEcM/LtFw3p0
 eJusRM+E1uumZ6XKBFANgklFbf8pPh+JlttLsBCsGlJaaPdHuEcvfX+IWFfWlx6jji/KhCbJO5T
 TZtq3RTR4DyIrb8vVtH1nnKG8IwuSmfF5IDA==
X-Received: by 2002:a05:6a20:3d82:b0:3bf:a0e5:999f with SMTP id
 adf61e73a8af0-3c44afd5fcdmr5948989637.22.1784862688022; 
 Thu, 23 Jul 2026 20:11:28 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbb8f0d872bsm3617697a12.7.2026.07.23.20.11.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 20:11:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 4/6] target/arm: Implement SCR_EL3.TID3
Date: Thu, 23 Jul 2026 20:11:21 -0700
Message-ID: <20260724031123.76597-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724031123.76597-1-richard.henderson@linaro.org>
References: <20260724031123.76597-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c        | 18 ++++++++++++++++--
 target/arm/tcg/op_helper.c |  4 +++-
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 971f0fbc08..022a63a511 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5894,8 +5894,22 @@ static CPAccessResult access_v7a_tid3(CPUARMState *env, const ARMCPRegInfo *ri,
      * Any other registers in the TID3 trap space should use access_tid3(),
      * so that they trap on v8 and above, but not on v7.
      */
-    if ((arm_current_el(env) < 2) && (arm_hcr_el2_eff(env) & HCR_TID3)) {
-        return CP_ACCESS_TRAP_EL2;
+    switch (arm_current_el(env)) {
+    case 1:
+        if (arm_hcr_el2_eff(env) & HCR_TID3) {
+            return CP_ACCESS_TRAP_EL2;
+        }
+        /* fall through */
+    case 2:
+        /* Note FEAT_IDTE3 does not trap AArch32 sysregs. */
+        if (ri->state == ARM_CP_STATE_AA64 && (env->cp15.scr_el3 & SCR_TID3)) {
+            return CP_ACCESS_TRAP_EL3;
+        }
+        break;
+    case 3:
+        break;
+    default:
+        g_assert_not_reached();
     }
 
     return CP_ACCESS_OK;
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 93336daf53..9b651104a7 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -1197,7 +1197,9 @@ void HELPER(tid3_udef_el1)(CPUARMState *env, uint32_t syndrome)
         target_el = 2;
         excp = EXCP_HYP_TRAP;
     } else if (is_a64(env)) {
-        if (!cpu_isar_feature(aa64_idst, env_archcpu(env))) {
+        if (env->cp15.scr_el3 & SCR_TID3) {
+            target_el = 3;
+        } else if (!cpu_isar_feature(aa64_idst, env_archcpu(env))) {
             syndrome = syn_uncategorized();
         }
     } else {
-- 
2.43.0



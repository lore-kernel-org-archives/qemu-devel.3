Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF546CCFA04
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 10:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFrcW-0001eq-JD; Mon, 03 Nov 2025 05:17:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFrcU-0001aA-IT
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:17:02 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFrcL-0003ZK-Qv
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:17:02 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4710683a644so33137305e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 02:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762165006; x=1762769806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=REj67eGgPV90SX9WQX5yE1JHREa2u08WkjMgsUYxfus=;
 b=PEjclthLw9SJRtvXsVS6RRdiDOtuoAODTrUwAjJ4L3g33IFJEhjLowExIg4iGW3Bd1
 gLzzrj9Yb4HaWuwUQfF49MY9qC6z8zyo8xS+PFzkLQyYWQF3r3kdDlZls0xNkGEP5fOV
 4+VzsH1vK9K3PsK+NpOlBt9uKmS+cppBsQVz6bBnxQyGwIeMgVyN4gRtS0T19NxcwEnE
 wulufDOi1bSCokgfW00XajO+pjOCpAVII7Cu/MA6mJk/Fhfat7MhvL08f++49Hcsfi/d
 j+c6SalF9cIXn34mHN2uWG5wYZflxCreEhLSqR3/xqqaoKexIjooLokTq6TAevJbHeIi
 gFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762165006; x=1762769806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=REj67eGgPV90SX9WQX5yE1JHREa2u08WkjMgsUYxfus=;
 b=ZBL1X73VFmlQH0J5U+7mkhK25mw+2sDxbHNu3m/Xk2ML3gMRP4wEcIpjo2fC+JNRj/
 zxacPOdGiakSHseNCAc9U+JYFawzc4RyR5gJ4bF1x74qTiT5rghYpV0NT78Mpx1ri0Vz
 /cqn8F9BVGhLOhNzLO983ooIaj4OIAMiOQeuySY2E7g31mY6w6JO9/G27knG4ANT9XTN
 /BCaGse68pXodh/NFNte//Sl4RCSdQyq9LsOVI639p/L/BMMV3HZfiJhbrjE7R8a8quF
 6Ah7mBKXidxR3/IedV2W8CYZkg2QDzgvSTPDx3lhNdayP952VC9gxzH33mODf3q6tQL2
 1Gfw==
X-Gm-Message-State: AOJu0YyDwJbrHgEBcUEvUfIPtEy6RIbD7TNBAfz8AiiHJahynMUwGVYH
 hPk8lwa/2lHRGoejvBNJOv2RX3c9ewPHHGDJtg739AcuTqJhdqstCYOy5kaFyXyBmvkuPYCRGKP
 gGllZpBGew3Is
X-Gm-Gg: ASbGncuo4q4coDUowS/2oD4m/lcA6YODK9s8N98G3+QbiuY3Aj2Yy/sDRV4JR4SHKgM
 II4Q/eDLHYzqhdjzDtPJm+dfVPnpeW3O+YBX5NniT5yRvHfovstidJWGyCptapJaOnqp6WPgNfg
 Rs1ulhX2CtPplU+z5STK4WTnB6BC1hyeRE7BND9zwfuiI/LzhqZJ5rG2iN408noCNB+5jj+mDKp
 AL8DvQdoo99gEXa+pLux8zJWoTxhgR1YrVaJ9cteEEst9DsvB4ehvaSLcT8Rsw7iDSVtqF//Uok
 FzluQHPPzXjDQiqkQlesRysfvH9MQ0r6HkWbY/b40UfMVjUCJiFMKfDxhlLL/b+iarlLHgLJxNv
 oZrzOt5WG2VVc9Mx4qbyEEASRoh1ALHqj3GGG2Gbm1HrryTkvnwZ1SgNb2ZKpaqUgMpp8nq+ltT
 vj/PbCziZiAeOAqaR+LFhT8MJlu4JT2v1a16s+olqMJT/rmg9WyMi46o79DoIHzTetn0gdow==
X-Google-Smtp-Source: AGHT+IGRzIrhYQgnZNa1UsjJasERFS3g5yhWVoTj0s36vUq0vHO7BoWVWAI+8mAzPdhsjDz+Utb7Ew==
X-Received: by 2002:a05:600c:420c:b0:477:115b:878d with SMTP id
 5b1f17b1804b1-477262baebfmr87459415e9.15.1762165006253; 
 Mon, 03 Nov 2025 02:16:46 -0800 (PST)
Received: from localhost.localdomain (ip-185-104-138-122.ptr.icomera.net.
 [185.104.138.122]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429cab8575bsm12193533f8f.31.2025.11.03.02.16.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 03 Nov 2025 02:16:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Peter Collingbourne <pcc@google.com>, Cameron Esfahani <dirty@apple.com>,
 Mads Ynddal <mads@ynddal.dk>, Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v4 14/23] accel/hvf: Have PSCI CPU_SUSPEND halt the vCPU
Date: Mon,  3 Nov 2025 11:10:23 +0100
Message-ID: <20251103101034.59039-15-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103101034.59039-1-philmd@linaro.org>
References: <20251103101034.59039-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Return EXCP_HLT to the main loop.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/hvf/hvf.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 51fd8c7175b..59a2ef53629 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -301,8 +301,6 @@ void hvf_arm_init_debug(void)
 #define TMR_CTL_IMASK   (1 << 1)
 #define TMR_CTL_ISTATUS (1 << 2)
 
-static int hvf_wfi(CPUState *cpu);
-
 static uint32_t chosen_ipa_bit_size;
 
 typedef struct HVFVTimer {
@@ -1008,7 +1006,7 @@ static void hvf_psci_cpu_off(ARMCPU *arm_cpu)
  * Returns 0 on success
  *         -1 when the PSCI call is unknown,
  */
-static bool hvf_handle_psci_call(CPUState *cpu)
+static bool hvf_handle_psci_call(CPUState *cpu, int *excp_ret)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
     CPUARMState *env = &arm_cpu->env;
@@ -1091,9 +1089,8 @@ static bool hvf_handle_psci_call(CPUState *cpu)
             ret = QEMU_PSCI_RET_INVALID_PARAMS;
             break;
         }
-        /* Powerdown is not supported, we always go into WFI */
         env->xregs[0] = 0;
-        hvf_wfi(cpu);
+        *excp_ret = EXCP_HLT;
         break;
     case QEMU_PSCI_0_1_FN_MIGRATE:
     case QEMU_PSCI_0_2_FN_MIGRATE:
@@ -1910,7 +1907,7 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
         cpu_synchronize_state(cpu);
         if (arm_is_psci_call(arm_cpu, EXCP_HVC)) {
             /* Do NOT advance $pc for HVC */
-            if (!hvf_handle_psci_call(cpu)) {
+            if (!hvf_handle_psci_call(cpu, &ret)) {
                 trace_hvf_unknown_hvc(env->pc, env->xregs[0]);
                 /* SMCCC 1.3 section 5.2 says every unknown SMCCC call returns -1 */
                 env->xregs[0] = -1;
@@ -1926,7 +1923,7 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
             /* Secure Monitor Call exception, we need to advance $pc */
             advance_pc = true;
 
-            if (!hvf_handle_psci_call(cpu)) {
+            if (!hvf_handle_psci_call(cpu, &ret)) {
                 trace_hvf_unknown_smc(env->xregs[0]);
                 /* SMCCC 1.3 section 5.2 says every unknown SMCCC call returns -1 */
                 env->xregs[0] = -1;
-- 
2.51.0



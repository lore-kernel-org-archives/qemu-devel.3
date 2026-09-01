Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 838ACC624D5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ONI-00016Z-9K; Tue, 01 Sep 2026 09:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONF-00015W-Qk
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:01 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONE-0007Cn-99
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:01 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c259e5c22ffso368088966b.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268679; x=1788873479; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kLokBAeBm6DcfQnHRcIg7xh0aKwQc9QxK3xRnb9ycHE=;
 b=QJGPWsXDd7bBpcN6wDAgxthP+l8KfWQfbOlY4qGyIRPp+ZB3mBeoey9I39f/3zBWzb
 RNr9LOPj3IJ1plhhKPZNSznEwKZ8Pb1OVXAZDHhKN1KxFeUJ43pvtt8nisgmEEanYYt3
 90TuefaNUTgA8Eldr2sMVkLr3VqKdesM6UfDL2WCsAYSjTtw7kVzHBodo+SvVNYCEEzh
 Mx3vsZidkl50zmyt2R+AzaByD286x45WfQaQN6QMip2CI/10gULsp5NWBiBfVffz5cAK
 N/EPux0foG6t4dt5QJGmr6XGGIJmwKuu50iAZ8mBCrudpQanNQ6vlBensubPJJboWrIv
 RXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268679; x=1788873479;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kLokBAeBm6DcfQnHRcIg7xh0aKwQc9QxK3xRnb9ycHE=;
 b=P802Ft5XKgGtYwv7dMPa1b0m06fVd8GvVUKwuBdQ7Lp1JY93KkltN3oMxBAyfm/DvA
 Jo3AWgH7d+xmTh1nYLVfsXtPv5FVMwfiJVJvsqWbzpr+J3cRTkwDcb+TYA2x7YofSEQV
 CEhzoA02ma0pz464GFbsIKkuQU0Q+hO3l091GVBN4bue9gfb9s/29GL+WI38WbvyqPww
 U2TEy8dO4LUaRNjusgp7Sj1o4iSi2YcnGqsPUrohBGtIrIDOYxPiJD7zTKftdOERqEYk
 jy/dAacd96py4RAk9SZ9s8prpSGl/fnnY68NTxK4DK8+Z3W/Ulng4BsMJNYVbJ65jo12
 kI4w==
X-Gm-Message-State: AFuF++nra7+Cieyot8do8yqHpLm70yiVJbbq8TTdjngJA+PtMuRVs0vo
 QY0u/5QB4/VT1lprn0W17l8CUGDY0sEZR9OdbeFXLfgXm+ZGCulSxlUCfEyT9i6JtyUYTHxOglL
 UCukCx0g=
X-Gm-Gg: AR+sD12P4K58u9dfhL5dow53jyBVTRQmaTGwJ9mcRCdf7Mp6v9jQlW0g9ZTqPzl6lBJ
 zWTcf5fmfDaRkjrw3Vo8o/cRkMt2fLalAyZERiIwliTh+38RdajqmoVlCdidiJSlftEAwripVmz
 IL/fMLCclRbKOzgs6kB2nDFaJHyMfB+j7bMFsyIYas7+dOY9p5AirJqXeBY9bfkghSCUqWmDps9
 +IFpQ1gC2fqE6WLTblUdEX+T8unQlF8/dvEOn2yZn0z4ixNSNQxqfZiXyTMir4ZNlRpxfTZYbGt
 aWSsJnhv7H2RuSCxm2vWvNzGThAI54qx0A+GwuPTKV/d7ZstId4ofF8kCwYY+QjtgDiRc80nq0P
 6Ic+pZMD8rwQ75HLVYWJxZV67RD7n8o0Q8ruHzBzDRPq01grhRLt0JC5ZnG4a7g9aanF+V1Efz+
 zkA3jAEUs4QMyB0MJc88bjjphLVDSIv5lCHqHYXpwErfi+GX4T/Vxe7N+mkLhRmzQgY69v7yaRT
 WMLLw99Q8KfzGolSVNPsdjJGgGkBYxILadns/yRlu+aVDMHbTFgdfwUyIv8FOowk2z9Wg==
X-Received: by 2002:a05:6938:a090:10b0:c25:8e4f:edf6 with SMTP id
 a640c23a62f3a-c258e501bbdmr816600166b.1.1788268678574; 
 Tue, 01 Sep 2026 06:17:58 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.17.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:17:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/58] target/arm: Rename and adjust aarch32_max_v8_tcg_initfn
Date: Tue,  1 Sep 2026 14:16:58 +0100
Message-ID: <20260901131732.2263947-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x631.google.com
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

Rename from aarch32_max_tcg_init and take an Object pointer,
in preparation from being used with TypeInit.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260827041557.775080-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-max.c        | 2 +-
 target/arm/internals.h      | 2 +-
 target/arm/tcg/cpu-max-v8.c | 4 +++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu-max.c b/target/arm/cpu-max.c
index 4df52bcb08e..9ed45c8764f 100644
--- a/target/arm/cpu-max.c
+++ b/target/arm/cpu-max.c
@@ -108,7 +108,7 @@ static void cpu_max_initfn(Object *obj)
 
     if (tcg_enabled()) {
         if (!aarch64_enabled) {
-            aarch32_max_tcg_init(cpu);
+            aarch32_max_v8_tcg_initfn(obj);
         } else {
             aarch64_max_tcg_initfn(obj);
         }
diff --git a/target/arm/internals.h b/target/arm/internals.h
index f6b4e173a54..fc7d5ad6f2c 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1838,7 +1838,7 @@ uint32_t *arm_v7m_get_sp_ptr(CPUARMState *env, bool secure,
 bool el_is_in_host(CPUARMState *env, int el);
 
 void aa32_max_features(ARMCPU *cpu);
-void aarch32_max_tcg_init(ARMCPU *cpu);
+void aarch32_max_v8_tcg_initfn(Object *obj);
 int exception_target_el(CPUARMState *env);
 bool arm_singlestep_active(CPUARMState *env);
 bool arm_generate_debug_exceptions(CPUARMState *env);
diff --git a/target/arm/tcg/cpu-max-v8.c b/target/arm/tcg/cpu-max-v8.c
index 5c0ba28edf8..5a9845d88f3 100644
--- a/target/arm/tcg/cpu-max-v8.c
+++ b/target/arm/tcg/cpu-max-v8.c
@@ -101,8 +101,10 @@ void aa32_max_features(ARMCPU *cpu)
     FIELD_DP32_IDREG(isar, ID_DFR1, HPMN0, 1);         /* FEAT_HPMN0 */
 }
 
-void aarch32_max_tcg_init(ARMCPU *cpu)
+void aarch32_max_v8_tcg_initfn(Object *obj)
 {
+    ARMCPU *cpu = ARM_CPU(obj);
+
     aarch64_aa32_a57_init(cpu, false);
     aa32_max_features(cpu);
 #ifdef CONFIG_USER_ONLY
-- 
2.43.0



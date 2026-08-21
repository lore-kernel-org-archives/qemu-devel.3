Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD50C5DF8E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxN0M-00064n-5M; Fri, 21 Aug 2026 07:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN0F-00062P-8a
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:01:43 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN09-0007FO-Uh
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:01:39 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-49954b88fffso7245975e9.0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 04:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787310092; x=1787914892; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xsRT6OD4srdGJd/K1CS+c7IiUzkXHHJdkUb3E/3eSzY=;
 b=ZxYMfs8/2AYHIwT9jSjn6DZbfSD9pQEfc/8Zs5qRjF2YXBYpbNV/1OrHbzkry4q6TY
 FuGXdshmGYyfvPPtw5x/Mf+nfrC3CZoJstSKHYjzty7S4r2LX0cbPccWTwQtBg52n3w9
 77Z65jxOOfu4sfWXyU3UCtafziDIll0QnvOmUAdjJ/YjQtK6+J0NCL2sFTPZ409bxHEV
 FjGEqFiSvYEWrz/dBupNZzEf+SgvSUtD0qjrgiwEgF/IBvYydS7EWm99glZJ5rwzVlqm
 5OwUq1wEgNd0ue7criy4Owu1zRa7TdTXygngOVxV3L978nQKfNmFKY0JzaXYgHh3rS5k
 DNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787310092; x=1787914892;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xsRT6OD4srdGJd/K1CS+c7IiUzkXHHJdkUb3E/3eSzY=;
 b=US0hyIP6x4JHgtuAxsAHdwXautyNtq5JK1nn7iDOL68G0kWyoU137Oz2zuVcUaHwud
 WhGMfe9fpycjPZ996xR2SdETo4z4RJOw34bWxvJoAFehQGTqIyqh+egUUu7NbwrUFpPi
 DQ3lWhSO1SbCNjHh5jpici5zVgljn0nrHtCFjOc9STlOM06/FS4VuwT56pZkFWMZEEku
 2mZAYWsMStsnWBIC4OmqQESyspAqHdt7a/zPJ3FWoJJ+GHIzIWmsXty3S3HHnkxZXqAa
 3fBhmh+O7mk34u3NyGF0KIgj79laxn45odXa2s/YR7BMLFy9S0Ixeq4cx1iW/j89Tzzs
 pPFA==
X-Gm-Message-State: AOJu0Yw8LZwIzRQu36fZfSawAHgB7dsHKYFRHMEWo9u0zmLV2n1kvuf5
 ilyT5yOew8JDWDKhmF+b4goW/RbIhup7FMv3ycfO/cnh0bJ/lyS7nY1bgDbcT7iHoKy9wN5Bsi4
 3f1Oo
X-Gm-Gg: AR+sD10KsJc8xzN/pbODTYKg9rp/cYSBDmIUOBLsYoXjAjL0DxYe7g/8iiycsBsXHc0
 akH1tqaNdfGSJ248e3z26C6v0wszjDXpSJJxMgPiue5I6kqJgDCEVJ8tsvhm5P4H0hgkw0tD+rX
 B+ZjP+0dSFFp2roB+ckKIJ8bTuMmJRbhw4rKo9DtGEj+xlq7sPRSB84HzH76eufUPgTOfdQGBo8
 viAgCZv/S6sMm5SpP5lbRYDkj/iEnhTiWizoWDh/F8GQIUhA3awIWQxf8jfbarZgsLu2kRhr7MX
 CQRV47C1ZGc09c2c6yymc/nXVLOHsRUJ0K0/B3MLDt5El9Rzcnmkxg45A0G5k5qxnYAYaiOXof0
 X8dZg+yKa2PT/slVtTPN/o2K/2s1vZRrcGxk9osh68ZLubaHplBBOW4UbOKRPub8s9oCFAhemy0
 hoYiAnAMZTWJTLdkANhnrFJKaqQt/AvzVPNkJeqFBP7NA2LXFfeVVYxFB20wmJttQBcnll4T/qa
 Zn7qfzBSHcvGl2KvWgwQ27q72O4PySqa9+uHo1mm+gb/yLTbZZTBbym00jeywwTE08l9w==
X-Received: by 2002:a05:600c:8108:b0:493:a966:d5b5 with SMTP id
 5b1f17b1804b1-499b82f40b6mr88299185e9.2.1787310092503; 
 Fri, 21 Aug 2026 04:01:32 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e7e20sm22875985e9.5.2026.08.21.04.01.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 04:01:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/43] target/arm: Pass aarch64_enabled to aarch64_aa32_a57_init
Date: Fri, 21 Aug 2026 12:00:24 +0100
Message-ID: <20260821110101.3971391-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821110101.3971391-1-peter.maydell@linaro.org>
References: <20260821110101.3971391-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

Invert aa32_only argument to what is actually used.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260812204435.295067-4-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-max.c   | 7 +++----
 target/arm/cpu64.c     | 2 +-
 target/arm/internals.h | 2 +-
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu-max.c b/target/arm/cpu-max.c
index bd858f010cd..edb5b9e6c36 100644
--- a/target/arm/cpu-max.c
+++ b/target/arm/cpu-max.c
@@ -16,10 +16,9 @@
 #include "target/arm/internals.h"
 #include "target/arm/cpregs.h"
 
-void aarch64_aa32_a57_init(ARMCPU *cpu, bool aa32_only)
+void aarch64_aa32_a57_init(ARMCPU *cpu, bool aarch64_enabled)
 {
     ARMISARegisters *isar = &cpu->isar;
-    const bool aarch64_enabled = !aa32_only;
 
     cpu->dtb_compatible = "arm,cortex-a57";
     set_feature(&cpu->env, ARM_FEATURE_V8);
@@ -207,7 +206,7 @@ static void cpu_max_initfn(Object *obj)
          * '-cpu max' for TCG: we currently do this as
          * "A57 with extra things"
          */
-        aarch64_aa32_a57_init(cpu, !aarch64_enabled);
+        aarch64_aa32_a57_init(cpu, aarch64_enabled);
         if (!aarch64_enabled) {
             aa32_max_features(cpu);
 #ifdef CONFIG_USER_ONLY
@@ -227,7 +226,7 @@ static void cpu_max_initfn(Object *obj)
 
     /* Ultimate fallback: -cpu max as cortex-a57. */
     assert(qtest_enabled());
-    aarch64_aa32_a57_init(cpu, !aarch64_enabled);
+    aarch64_aa32_a57_init(cpu, aarch64_enabled);
 }
 
 static const ARMCPUInfo arm_max_cpu = {
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index e3ee0253a09..faaf3ab879d 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -688,7 +688,7 @@ void aarch64_cpu_lpa2_finalize(ARMCPU *cpu, Error **errp)
 
 static void aarch64_a57_initfn(Object *obj)
 {
-    aarch64_aa32_a57_init(ARM_CPU(obj), false);
+    aarch64_aa32_a57_init(ARM_CPU(obj), true);
 }
 
 static void aarch64_a53_initfn(Object *obj)
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 9c9196475bd..5e7f41a50d1 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1813,7 +1813,7 @@ void aarch64_max_tcg_initfn(Object *obj);
 void aarch64_add_pauth_properties(Object *obj);
 void aarch64_add_sve_properties(Object *obj);
 void aarch64_add_sme_properties(Object *obj);
-void aarch64_aa32_a57_init(ARMCPU *cpu, bool aa32_only);
+void aarch64_aa32_a57_init(ARMCPU *cpu, bool aa64_enabled);
 void aarch64_host_initfn(Object *obj);
 
 /* Return true if the gdbstub is presenting an AArch64 CPU */
-- 
2.43.0



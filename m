Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B13E2C5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:02:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxN0M-00068C-OY; Fri, 21 Aug 2026 07:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN08-00061b-19
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:01:39 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN06-0007Eh-FF
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:01:31 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so7633065e9.0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 04:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787310089; x=1787914889; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zATQX0WfZw8uVd/tDh0GkOsMfEIq683ZB8385k60BBE=;
 b=Y24moYCCTPkdzV3HzoZq9hFBW/QKOdsiC6QHA3sbSHqgqaWL8VfI+RiRfiv3Rcbl5R
 nT3iHjhW/IHS5Vl2IJhuAe8Tl3jRsN+3n8VR+tOagj3KzSOISaJ/AM2GK34QDT91qasx
 K4qMH6f8uTeKQvsiRWo/fyQx1N7oY0u9y7DaLzfMJLac2xVxi75FNfQkwnzcHexoavfO
 6OUwkZARoz4/T5U4T15DQ+CmKjM+OiN1gUYBF+FM0tIghNUkCVZEvCoI4hABJK4CPvSj
 ppuJEL0wLSaQkezZZL0Ua82XLOvU972R9lfUxKHcPnCGh+jeL2BROqgtFOg3KAZQC8jL
 3A5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787310089; x=1787914889;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zATQX0WfZw8uVd/tDh0GkOsMfEIq683ZB8385k60BBE=;
 b=XsIEAs5xojYYJ77m9xGc1wkRKguSc38iEJ8VJPwUqczj53RjFTZdfxtDYyZSuYiYCd
 ex53+R4cv+vtt4J78q6BxqqBNhatA25gvnmb+t50XrXphyZYxUadV8llqE3okDK9RF7P
 T9ZGoW2pxIW+Px9Sgkvhj5icdwSHX7ktI9hdb9XsKVF8LJW/OoEeFhJ1JuPrnIMkwx3N
 9uamlAUBCq2y64wnITptqbvzt5RwpacSDdeQ3sFFztdghTJpf7BJRA3+FLUXjyu/QrjV
 PefkOz0pcZ+bP9BUF367FIWkwhUO5DJlT3bIIJ1yhBdNrVxVgwDGsJq+b+EQCPwvXyrJ
 6zJw==
X-Gm-Message-State: AOJu0YwwQ9I7OJuE/V6CC6M5fD8S01kcnCmlP2kkqYx6o5vb0UCuYIY+
 2iRAgUvG1VVZ9yH0Yw7wqxRTGFwN9HBbUHHBOj1/Ln5VANtNaQroPFZIdW3N8bUVIlSJjOmeqmh
 icIeQ
X-Gm-Gg: AR+sD13OF9b5Mlb+tFhfv5K5swr77+tJix0zS58upmzm4Lf2D6YzhXeyS0lJW8b5Zdd
 idI+iAxZHdaeKtGYb5tEqcE5bIG+ODXGQum5UznwiErtVL8ZMlzWAg7TFrJxyjahXEO1gMvoOGZ
 mJkV6lfXkeBAbt/qqrSE3NpRljfuw44Bla8ZNdAE4n2aWaExF/ZzcohNgEaR22B512QUWwW55Hl
 9gygD2nqVGa0DUXmd3KkP0dTCDGNbz2sGUemey2iy+LINF+tH3Jo4ABvL16VgVzo1ifHpof4vJ7
 oof0t7NGn9Izp2h72az/3os6PwLdGrCOijDEda4h9UoFTj93B3e+AKjhfl145zDKQNiDsac2syE
 t1uzipjrM0XyBAyaCW4Q9JO+1mhG/v+uWmfCQC4t0rKwnobedT4dQq3UEMn/VJhK0t0lFaIGEfY
 pUpmJPGcxErLKxC3Oqx+g7kNmdJeuwCVi4wfPBfAMYhI1zrEM01h5Z9mY1O/9j2bIUPDhL+bbxY
 EWKZ1MboC/6q0oG0Yg/Nl5iurZWbPqoZ4hfM7LipZl/TzTF6YhazVs=
X-Received: by 2002:a05:600c:5486:b0:499:a277:e8c8 with SMTP id
 5b1f17b1804b1-499b8464cb8mr70840965e9.13.1787310088910; 
 Fri, 21 Aug 2026 04:01:28 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e7e20sm22875985e9.5.2026.08.21.04.01.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 04:01:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/43] target/arm: Pass ARMCPU to aarch64_aa32_a57_init
Date: Fri, 21 Aug 2026 12:00:23 +0100
Message-ID: <20260821110101.3971391-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821110101.3971391-1-peter.maydell@linaro.org>
References: <20260821110101.3971391-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

There's no reason to pass Object when ARMCPU is more appropriate.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260812204435.295067-3-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-max.c   | 7 +++----
 target/arm/cpu64.c     | 2 +-
 target/arm/internals.h | 2 +-
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu-max.c b/target/arm/cpu-max.c
index 0a310d1b15d..bd858f010cd 100644
--- a/target/arm/cpu-max.c
+++ b/target/arm/cpu-max.c
@@ -16,9 +16,8 @@
 #include "target/arm/internals.h"
 #include "target/arm/cpregs.h"
 
-void aarch64_aa32_a57_init(Object *obj, bool aa32_only)
+void aarch64_aa32_a57_init(ARMCPU *cpu, bool aa32_only)
 {
-    ARMCPU *cpu = ARM_CPU(obj);
     ARMISARegisters *isar = &cpu->isar;
     const bool aarch64_enabled = !aa32_only;
 
@@ -208,7 +207,7 @@ static void cpu_max_initfn(Object *obj)
          * '-cpu max' for TCG: we currently do this as
          * "A57 with extra things"
          */
-        aarch64_aa32_a57_init(obj, !aarch64_enabled);
+        aarch64_aa32_a57_init(cpu, !aarch64_enabled);
         if (!aarch64_enabled) {
             aa32_max_features(cpu);
 #ifdef CONFIG_USER_ONLY
@@ -228,7 +227,7 @@ static void cpu_max_initfn(Object *obj)
 
     /* Ultimate fallback: -cpu max as cortex-a57. */
     assert(qtest_enabled());
-    aarch64_aa32_a57_init(obj, !aarch64_enabled);
+    aarch64_aa32_a57_init(cpu, !aarch64_enabled);
 }
 
 static const ARMCPUInfo arm_max_cpu = {
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 28167355773..e3ee0253a09 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -688,7 +688,7 @@ void aarch64_cpu_lpa2_finalize(ARMCPU *cpu, Error **errp)
 
 static void aarch64_a57_initfn(Object *obj)
 {
-    aarch64_aa32_a57_init(obj, false);
+    aarch64_aa32_a57_init(ARM_CPU(obj), false);
 }
 
 static void aarch64_a53_initfn(Object *obj)
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 4026f67579e..9c9196475bd 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1813,7 +1813,7 @@ void aarch64_max_tcg_initfn(Object *obj);
 void aarch64_add_pauth_properties(Object *obj);
 void aarch64_add_sve_properties(Object *obj);
 void aarch64_add_sme_properties(Object *obj);
-void aarch64_aa32_a57_init(Object *obj, bool aa32_only);
+void aarch64_aa32_a57_init(ARMCPU *cpu, bool aa32_only);
 void aarch64_host_initfn(Object *obj);
 
 /* Return true if the gdbstub is presenting an AArch64 CPU */
-- 
2.43.0



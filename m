Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB8BC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 04:53:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuOwS-0001XO-QL; Tue, 18 Mar 2025 00:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuOvY-0001EX-Qt
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 00:51:50 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuOvV-0008T9-8y
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 00:51:44 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22359001f1aso50939575ad.3
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 21:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742273498; x=1742878298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OcGAZaWPVIysHTdBCRYBHO7NUCxy0k+KHYN46Zgiu4k=;
 b=svl+vludRYMhf6J+uegtqj6L20Ass6bCQXR0fCmRQS6PU+lZnx3CKXEiYoaK4WC9i9
 vxeaUPMZjkMSArQb3+QAidL1D6NRvGJXOSHN7goKYMUmnkfh8ULP1RB/n0kGUwh2Oljo
 bToRhLwqc59ajv5CtMDQApN12Azhb7eM4woSygzrIR0eehHeumKxJGffKW4RmSlDQpIE
 yH5iUt5EBy3lfLUO0q48Lb/CdMrDfAc4Q6f3UJPGvsl2WOHsUaDTZlE390871686qVUV
 ByXVNdceScwa6kn/9gIJWk1BEPuL7hYdFqYfAK7r68z1em3qezQuQT3vcpKJoIk9X09O
 IMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742273498; x=1742878298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OcGAZaWPVIysHTdBCRYBHO7NUCxy0k+KHYN46Zgiu4k=;
 b=YnuHAWQuYl1Dp5RSX4swMvFiDeVvwqdJdxi2+NlMLFN2dTzBy4FiXdKCwXygRkOXDr
 5diy1CFWn4Nxm1F5yavXftIWfL5nC9H1pfEGv6P7QU2zctc819fq4Sokeo1OAS3rmQhC
 oO4T/Pdp4cawWL/eSrArt8HBO4FznEXO2L/EGCHGB08Glz1eeGIJu1Q7Dmw82BAhKrtN
 qi1t/qupm7xSffjqykTDG5sYzZqU399DjNrnboqTo+S0Zge6E8mTR+4FAI7ACeCK4/oM
 cKPWlW6G5E2xMkUgWPFaTuiFsIbdfGLG755H2BHhzq4z3Amwsaw2CIcjBh02/MJvuoAj
 JDOQ==
X-Gm-Message-State: AOJu0YyY6tScicFMEVrgsIZ22E1b1GEqsYbp6wxAlOcaRI+laz5JQP5p
 i254ZdBnRFbpcVQ1/qk+RNdFl2oTRzkWgCRRXoHnnSGbEpGibf7o8hnThVRdhwhPDgltwVyLER/
 e
X-Gm-Gg: ASbGncsixLXxz1Q+9j4+J8e+fDJh3dDKGcEnwUEm1RJABfvHMtkh0LHR6hwUIlvgswc
 xRV2GMG/eoHJIFWh/FAasuQflVKlZHtLIUOxqtToR8piNc5b0LqcZc92y8n9gYJkyadufufTmNE
 DHtVr18oWaPrUfhJBL1gybT2thpoLXrWm40iJb/ZjycqOlSx3RQRGM8BswqZJMfvE/vMbrqPwds
 4qTHawv5AzDynQ5csWhJvYMlycHAfwvTST/vspRi6hvPAOxJ6r/7jZVPlpFUG+0FX0NJBACaUNG
 4EVDOWx67sLdES5mvRSSRB4Y95O8h3bUyuB13ihgrp2j
X-Google-Smtp-Source: AGHT+IGd5D4o5uKL9Q2v7Y3e6Bm9G+stqVZhHdXsULQqp3gKY9DtvnzsLjdYrwnF2yMZJulAsCZvKw==
X-Received: by 2002:a05:6a00:1954:b0:736:fff2:99b with SMTP id
 d2e1a72fcca58-737572df1b9mr2862896b3a.23.1742273497827; 
 Mon, 17 Mar 2025 21:51:37 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711694b2csm8519195b3a.129.2025.03.17.21.51.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 21:51:37 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 05/13] target/arm/cpu: move KVM_HAVE_MCE_INJECTION to
 kvm-all.c file directly
Date: Mon, 17 Mar 2025 21:51:17 -0700
Message-Id: <20250318045125.759259-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
References: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

This define is used only in accel/kvm/kvm-all.c, so we push directly the
definition there. Add more visibility to kvm_arch_on_sigbus_vcpu() to
allow removing this define from any header.

The only other architecture defining KVM_HAVE_MCE_INJECTION is i386,
which we can cleanup later.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/system/kvm.h | 2 --
 target/arm/cpu.h     | 4 ----
 accel/kvm/kvm-all.c  | 4 ++++
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/system/kvm.h b/include/system/kvm.h
index 716c7dcdf6b..b690dda1370 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -392,9 +392,7 @@ bool kvm_vcpu_id_is_valid(int vcpu_id);
 /* Returns VCPU ID to be used on KVM_CREATE_VCPU ioctl() */
 unsigned long kvm_arch_vcpu_id(CPUState *cpu);
 
-#ifdef KVM_HAVE_MCE_INJECTION
 void kvm_arch_on_sigbus_vcpu(CPUState *cpu, int code, void *addr);
-#endif
 
 void kvm_arch_init_irq_routing(KVMState *s);
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 7aeb012428c..23c2293f7d1 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -33,10 +33,6 @@
 
 #define CPU_INCLUDE "target/arm/cpu.h"
 
-#ifdef TARGET_AARCH64
-#define KVM_HAVE_MCE_INJECTION 1
-#endif
-
 #define EXCP_UDEF            1   /* undefined instruction */
 #define EXCP_SWI             2   /* software interrupt */
 #define EXCP_PREFETCH_ABORT  3
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f89568bfa39..28de3990699 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -13,6 +13,10 @@
  *
  */
 
+#ifdef TARGET_AARCH64
+#define KVM_HAVE_MCE_INJECTION 1
+#endif
+
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
 #include <poll.h>
-- 
2.39.5



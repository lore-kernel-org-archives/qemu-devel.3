Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3EDECD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 13:26:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKyjt-0001RP-5A; Thu, 07 May 2026 09:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKyjr-0001RA-9h
 for qemu-devel@nongnu.org; Thu, 07 May 2026 09:26:03 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKyjp-0007PB-Gq
 for qemu-devel@nongnu.org; Thu, 07 May 2026 09:26:03 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-65c37eafcbeso915593d50.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 06:26:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778160360; cv=none;
 d=google.com; s=arc-20240605;
 b=UEMI/pOJh9CxxA0Z0/Ltnw7+Wwk3/DYgd1DzMLJDMbA3aqjuLYIlX0xxoba5mPK6Cm
 pozFXlSjHOLUks+Vwwdn+SGfHBpQlq6SUctMkOj4BBr1bcQWOaBFMc9gJTitKXffOsl2
 dOpi3POnNpQtH+gay+Vw5Ir5H56vJwTXyCcF7T7kk3SAMtPdwqtQ5xTbvN8++o/O/z8D
 1Vepha0qX0Xfd3a1UNMiTbx64weAX0S9+gOyYbP2oAxYWPuNUdUtcJI/edJuAm+h1KxP
 pBmPm2qNdH/tjjGsg70ASl9tx8AOPrAui8wapWx+hBvMgyLhlIXFctjdt46dxSs8UNJo
 y26w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Jvi0wZDRtms50VaJzC2TWWz961jRC0TW7x1auq6beF0=;
 fh=TSh1mpsFu2ob9O5mDvGPBktzym+JYeTZdNdbjARW/Tw=;
 b=Zlv2hLdRXMP2+s02WkEMKuJYzOAu9Icz5q/k0HjML5qswfzC3Wyg+w+jjF32lWIuzp
 EVwJ/RnRU5Y6w5KjaopWEldMLRY3RJlZgiuZP7xjoJsiw5Qc+0N/kCOLiKl9dOJy9Yz7
 Yoqbj/indxKOYyDnLUjdRHMPaXqHAdLcRKiV2yA3WA8vZhbnEe+Ks72VP8wpIDGHNrg7
 DG1JYwDSyEJSysW0lkqhLS50OCidMNUjBPdyYfnBAfRVxPeVDtDo+53iiEz1J9M3l0gj
 092BU99uWdzAfkdZ+KfxvyrBqumjzDkF9vE91ZZi/qsMt0v44PD3OCMt+8Nzb+1307pf
 bfsQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778160360; x=1778765160; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Jvi0wZDRtms50VaJzC2TWWz961jRC0TW7x1auq6beF0=;
 b=rfeH7vZUpe80WymOXtgug0n8qIAVzML5M+VFV7GS0imHudfr4edN8ZrDUEy9yx8+uj
 KZxEBOcRkdObSrfo8AQtMpW+yHUOeU5ApwvrMKrAxLsK5bKexk9l/fzXvaUPf+UsZsou
 aa00jQriD/3U1a9TdkbA+fnKYb6Y9LWyg198enACMJOV5DGLMDg28KlDIzLylHXMJrnK
 QHkBrd5QQ4fszQP9LdrDDQK5fw7qQJ1VlC5NdoWpBODpA+YCw0uDTRoQsDuJ1X+JjsUV
 u9SaQjRe7O+z+LoWf/pEdgQEkDn1LGasmBy2imWfT8rHvz02J1B1QDTKPQLSTwAnE8vr
 ldGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778160360; x=1778765160;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jvi0wZDRtms50VaJzC2TWWz961jRC0TW7x1auq6beF0=;
 b=hlvrspsAxDTA0/Y14MtSugZnENPCbKew2PQ4Pg/PJqvC8/4JVbyac+GdSpHYc+TOMr
 v9bTmnv53PYXEMM6bsexeK/aH21adHy3SfxnQoIGHZvkEvEVQCbiY1LKQPCBmmPEEQQ3
 yGP++BLQBAIJeTfY2jXzMIRsk2gkSQZdzlqy8L6+co/hCyidGmeos7jb/Kln9jLchYXM
 FcbOd2z654utDs4VYHnKe0ULL0qxv5J+Ubcprglp0AodMBGMJYfml2DFUHnnJX16vWm5
 88MclfHCqY/fflZut2X48eUix1I5MK9uzCG46f2gw9jdbszos1F/G5Ikh/uwuefEEA3e
 +85A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/irvZozT3ph/nGzW+X7dN6Q1cN4nmFzFxWRqXFmZTpR7vK40hYPmVOirGzh7hpRcF3sR5FQTIz1JYa@nongnu.org
X-Gm-Message-State: AOJu0YyCWc69PgjBA7aXI0m3qoZoZiojlt55blGdBATDeb+A56he/nHL
 0Sl52+6ttY685HqFz0NxtBwr6tmRxX0bSbpD9Yz0BQwxxToKOk+ihtLX/00iWC5tLXrwa8uDMi0
 /L8inaHqCF2haZ96w4p9TMG84b/HKn1lkpG3tR4WS8Q==
X-Gm-Gg: Acq92OGI5CFs2nQ7yi3Ps69mI/U2iuwIwSY/DpbGczXBvfXmDFdWPLC/1Mq6XY80EaC
 b2rrpPTr51dXUzvNbHQyHWS8wPXRzd8yFkJYnBlttULkYaxOzlX0GfuCCW25ra8YgJDW9Jg3yBS
 TlieRyqNqzxsIh7aAXSrmfELVxASgrUXbRrj+L3UgmPwFhz0LOzQGpfE30RISdWHWMOvM/0Jc1a
 yiiKv4/q2a1hYUVahyPKoutYbqxJ4vtzlEhs02K/T7ShoVdRhj65akeYDteMTRrnCPlFMJ4VVSG
 0AOVJMlVbOEihPFvyi0TSgNsBqRBV3WDtrTHSqCjRnwZykJJoiymVuRFiJl/FQVthTEDgMUGXEq
 +Yg==
X-Received: by 2002:a05:690e:429a:10b0:65c:2101:e535 with SMTP id
 956f58d0204a3-65c7988d460mr6707450d50.3.1778160359993; Thu, 07 May 2026
 06:25:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260327111700.795099-1-peter.maydell@linaro.org>
In-Reply-To: <20260327111700.795099-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 May 2026 14:25:46 +0100
X-Gm-Features: AVHnY4L9wyJC6X6RZCqN49q7XrdXQggxtVgyg0h1TUildE1Jce-hLYt_m6IqC-c
Message-ID: <CAFEAcA9zCPyJpvTtuN528V9UGVbQifVW9Usq2V402ofmre22SA@mail.gmail.com>
Subject: Re: [PATCH v2 00/65] arm: Implement an emulation of GICv5 interrupt
 controller
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Fri, 27 Mar 2026 at 11:17, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This patchset implements initial support of emulation of Arm's new
> interrupt controller architecture, GICv5.
>
> I've incorporated the review feedback from v1, so I figured I
> might as well send this out, though obviously there's no huge
> rush to review given we're in freeze.

I'm taking this into target-arm.next. In the process of
testing the pullreq I discovered that it doesn't build
in a --disable-tcg config. I made the following changes to
fix that, which I'll squash into the appropriate patches.
(My choices here are aimed at keeping the amount of fixing
up smaller; some of them will end up cleaned up when we add
the GICv5 KVM support, eg the "if TCG" clause in the virt
"select ARM_GICV5" will go away again.)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 36de9aee3e..5b198402d5 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -10,7 +10,7 @@ config ARM_VIRT
     imply NVDIMM
     imply IOMMUFD
     select ARM_GIC
-    select ARM_GICV5
+    select ARM_GICV5 if TCG
     select ACPI
     select ARM_SMMUV3
     select GPIO_KEY
diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index a3241fc1eb..636d00b7e8 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -37,6 +37,7 @@ config ARM_GIC_KVM

 config ARM_GICV5
     bool
+    depends on TCG
     select MSI_NONBROKEN

 config XICS
diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
index 0b5303f370..b3bd3eee7b 100644
--- a/hw/intc/arm_gicv5_common.c
+++ b/hw/intc/arm_gicv5_common.c
@@ -215,13 +215,3 @@ static void gicv5_common_class_init(ObjectClass
*oc, const void *data)
     dc->realize = gicv5_common_realize;
     device_class_set_props(dc, arm_gicv5_common_properties);
 }
-
-const char *gicv5_class_name(void)
-{
-    /* When we implement KVM GICv5 we might return "kvm-arm-gicv5" here. */
-    if (kvm_enabled()) {
-        error_report("Userspace GICv5 is not supported with KVM");
-        exit(1);
-    }
-    return "arm-gicv5";
-}
diff --git a/include/hw/intc/arm_gicv5_common.h
b/include/hw/intc/arm_gicv5_common.h
index 74fa68d8c0..32f6cc9b8b 100644
--- a/include/hw/intc/arm_gicv5_common.h
+++ b/include/hw/intc/arm_gicv5_common.h
@@ -13,6 +13,8 @@
 #include "hw/core/sysbus.h"
 #include "hw/intc/arm_gicv5_types.h"
 #include "target/arm/cpu-qom.h"
+#include "include/system/kvm.h"
+#include "include/qemu/error-report.h"

 /*
  * QEMU interface:
@@ -192,7 +194,15 @@ static inline bool
gicv5_domain_implemented(GICv5Common *cs, GICv5Domain domain)
  *
  * Returns: class name to use
  */
-const char *gicv5_class_name(void);
+static inline const char *gicv5_class_name(void)
+{
+    /* When we implement KVM GICv5 we might return "kvm-arm-gicv5" here. */
+    if (kvm_enabled()) {
+        error_report("Userspace GICv5 is not supported with KVM");
+        exit(1);
+    }
+    return "arm-gicv5";
+}

 /**
  * gicv5_raw_spi_state
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index f2646ae4ed..330e9be473 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -39,9 +39,9 @@
 #if !defined(CONFIG_USER_ONLY)
 #include "hw/core/loader.h"
 #include "hw/core/boards.h"
+#include "hw/intc/arm_gicv5_stream.h"
 #ifdef CONFIG_TCG
 #include "hw/intc/armv7m_nvic.h"
-#include "hw/intc/arm_gicv5_stream.h"
 #endif /* CONFIG_TCG */
 #endif /* !CONFIG_USER_ONLY */
 #include "system/tcg.h"
diff --git a/target/arm/tcg-stubs.c b/target/arm/tcg-stubs.c
index aeeede8066..8d97449cfc 100644
--- a/target/arm/tcg-stubs.c
+++ b/target/arm/tcg-stubs.c
@@ -43,3 +43,7 @@ void vfp_clear_float_status_exc_flags(CPUARMState *env)
 void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
 {
 }
+
+void gicv5_update_ppi_state(CPUARMState *env, int ppi, bool level)
+{
+}

thanks
-- PMM


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E3BCCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 21:44:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEDxA-0006dU-TV; Wed, 29 Oct 2025 17:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEDx7-0006ar-B8
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:43:33 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEDwu-0005vS-4C
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:43:33 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-475dd559b0bso4201605e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 14:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761774188; x=1762378988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=idKPFW9DNb94tsTYsft1e7s0DZqqwVrbPK/YrVaEB84=;
 b=meQm/PPu7QsvoIbC6cAQpoBB+u3ei6QtkZyzoOSrEJmq/KyhYoeI1rMj6QEu7yOR6i
 q2nuCrRlWjODQ2h+GbopuKCDmRtYIja2D+v7AGEUJ8kk27Rdj1DvIXCDvh1lmh+3cyfQ
 yofDPdjHsCz2syXOKLVlh/BKiIalyTSH3caYYmQa36ZPBXWe2RbmgoO4vXI555VMRSNM
 4iROSie3xuDaB8UzTfnI57l4HtP29gQYdfuh880FGtnp3WcPsWLD0zrVtfxb+FCg+hEc
 GkvoFpvhhArhtngZEGn92T+u9UWlyx2NnWbBxpoN84Nz6rfHXx4SK53wIscyVbfgqbjw
 OwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761774188; x=1762378988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=idKPFW9DNb94tsTYsft1e7s0DZqqwVrbPK/YrVaEB84=;
 b=eV6UHgskxhO4DJ/rOL9l9MItaZS3G0s9rYcqJ7S9ru5eB+uws/8AVpmihVaahXz0zq
 cKtrV6vTue2KowPO8IrgmB47MnReNCGViPUkYJuRamGxPlrhoQhzmKHfhC86dR0IhX4s
 DtSqE36ty14o5Szvq0GhooQa/oybQyqNeLYa2gLmmggkMVCTr5PrJFLHm3aQX+W4PpDS
 4KpP/p4P+we2jJYhs73QS6Bw41I1KcLYSqFeuqonmSOSPKK1VkzWXHC5EoozP8Wa0iJm
 CF/GPEM+O2pua4lY3ij6Rzga5pdfSAEindk07cpzXn4eiKlVOkMwWe/Qj2fHnIlE4nOD
 Qx/w==
X-Gm-Message-State: AOJu0YwWUt6/8JgsgjnyTjQS2GpJOxXRZT8NIpFW3MncyYWVxDvrZCAq
 VnNlec4p4lvp7MpYEHLeEmWDWh9TNkE8OH2hz87N9O+diQqmEFGEHuDBzaUIjhKhGkHkcSqfwBU
 blnXxhqc=
X-Gm-Gg: ASbGncugVtrzvaLcXbsqUPtqHxlw4+xgkc8TB3Quqc7hYiWKE6VByvIbidOWwHZOpw+
 9WLf/mKMmPGIhRtxtxF03sCksL+y0j2und5jTbeb9+6R0tM+WORLKPCJqEu9wEvkhs5c6yGPuvE
 fp7odIBPmUxFuddLzauoqLvsOzyDFI41QstBhPrx/YQOByQsPVLy72XP4nDCN1HPrzW66FCT4Rv
 gYlNRJiQlg+3b9R86aDRoBmDLWTjaKdo34tokTpgclzkgvnXz0WqyZJI+JFOxpQm769mM9Kc1Ob
 VU1cL3RLSvWGjxXix9hKrSOCE2iVTfFrLHskJ3lz2dRrgqrqBHp2Q+YQI02gKkJUR/x/vsOjneo
 M+K1kXXMirLDxlQ/rw5dvTqk0EGE6hPDzGlG9EE2HcW13SH8+Wwuro+J3PQNQIoxxZwbziX+DiE
 Ruk8ad2y3M01MhOqjUjFGyRwLiYBs5aOas0OPeqWCQUtuB9MR9B2+Nfgp2DxhK
X-Google-Smtp-Source: AGHT+IGPYe8+TsAzWt3PeFAWy5OcSA6+QmmYiUYpLYR9+7sl7OvK+zAYiXOLP6Lq5n3d8cMf5MgL8w==
X-Received: by 2002:a05:600c:4ecb:b0:46d:b665:1d95 with SMTP id
 5b1f17b1804b1-4771e1edb27mr41335165e9.32.1761774187879; 
 Wed, 29 Oct 2025 14:43:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477289a5625sm4258775e9.5.2025.10.29.14.43.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 14:43:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PULL 03/23] hw/arm: Add DEFINE_MACHINE_ARM() /
 DEFINE_MACHINE_AARCH64() macros
Date: Wed, 29 Oct 2025 22:39:40 +0100
Message-ID: <20251029214001.99824-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029214001.99824-1-philmd@linaro.org>
References: <20251029214001.99824-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

A machine defined with the DEFINE_MACHINE_ARM() macro will
be available in both qemu-system-arm and qemu-system-aarch64
binaries.

One defined with DEFINE_MACHINE_AARCH64() will only be
available in the qemu-system-aarch64 binary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20251021205741.57109-4-philmd@linaro.org>
---
 include/hw/arm/machines-qom.h | 28 ++++++++++++++++++++++++++++
 target/arm/machine.c          | 18 ++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/include/hw/arm/machines-qom.h b/include/hw/arm/machines-qom.h
index a17225f5f92..3f64d5eb024 100644
--- a/include/hw/arm/machines-qom.h
+++ b/include/hw/arm/machines-qom.h
@@ -9,10 +9,38 @@
 #ifndef HW_ARM_MACHINES_QOM_H
 #define HW_ARM_MACHINES_QOM_H
 
+#include "hw/boards.h"
+
 #define TYPE_TARGET_ARM_MACHINE \
         "target-info-arm-machine"
 
 #define TYPE_TARGET_AARCH64_MACHINE \
         "target-info-aarch64-machine"
 
+/*
+ * A machine filtered with arm_machine_interfaces[] or
+ * arm_aarch64_machine_interfaces[] will be available
+ * in both qemu-system-arm and qemu-system-aarch64 binaries.
+ *
+ * One filtered with aarch64_machine_interfaces[] will only
+ * be available in the qemu-system-aarch64 binary.
+ */
+extern const InterfaceInfo arm_machine_interfaces[];
+extern const InterfaceInfo arm_aarch64_machine_interfaces[];
+extern const InterfaceInfo aarch64_machine_interfaces[];
+
+/*
+ * A machine defined with the DEFINE_MACHINE_ARM() macro will be
+ * available in both qemu-system-arm and qemu-system-aarch64 binaries.
+ *
+ * One defined with DEFINE_MACHINE_AARCH64() will only be available in
+ * the qemu-system-aarch64 binary.
+ */
+#define DEFINE_MACHINE_ARM(namestr, machine_initfn) \
+        DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
+                                            arm_machine_interfaces)
+#define DEFINE_MACHINE_AARCH64(namestr, machine_initfn) \
+        DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
+                                            aarch64_machine_interfaces)
+
 #endif
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 44a0cf844b0..0befdb0b28a 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -9,6 +9,7 @@
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
 #include "target/arm/gtimer.h"
+#include "hw/arm/machines-qom.h"
 
 static bool vfp_needed(void *opaque)
 {
@@ -1212,3 +1213,20 @@ const VMStateDescription vmstate_arm_cpu = {
         NULL
     }
 };
+
+const InterfaceInfo arm_machine_interfaces[] = {
+    { TYPE_TARGET_ARM_MACHINE },
+    { TYPE_TARGET_AARCH64_MACHINE },
+    { }
+};
+
+const InterfaceInfo arm_aarch64_machine_interfaces[] = {
+    { TYPE_TARGET_ARM_MACHINE },
+    { TYPE_TARGET_AARCH64_MACHINE },
+    { }
+};
+
+const InterfaceInfo aarch64_machine_interfaces[] = {
+    { TYPE_TARGET_AARCH64_MACHINE },
+    { }
+};
-- 
2.51.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0909CCD19F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 22:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAy5C-0006dJ-5W; Mon, 20 Oct 2025 18:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAy5A-0006cb-MS
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:10:24 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAy57-0006IW-U8
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:10:24 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47103b6058fso34344315e9.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 15:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760998220; x=1761603020; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I1ysdGDIf3f6arKVkWg/9D5MuwWbAw8n7VA67oxLh1o=;
 b=NKBbsPhMzU4BJpyxuuYZEaspXFn2xFP2KzAeLrotyuAg5Qon7vRXnlN1S6dV2nDO76
 PUKC0Ga/qz9cbqJM9yokyM6i76bIojXqpNBzmNsLWVb1R38lO9Mhwxn/HMOpohmu8iYm
 uWhmo2EnWxYsAqof1Pr/KNlENpPnSZ7ctaIJDN1eTmmMvQkL0iFhknK7q3KQViBs8Cmn
 WyWlwa17gVr4FhlF7dW5XgkanjveFLyX4hE6fPMXfmVTfnlffVv+p1UwnGeEPQ5r3u77
 KQTn/pMxHc6Udyh0v/ZfI74ZXeb9y7J1+ffhMalEn2iW5UQk/LitRbZm1Dbcrq/SvXyL
 i3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760998220; x=1761603020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I1ysdGDIf3f6arKVkWg/9D5MuwWbAw8n7VA67oxLh1o=;
 b=qkw6DPlbcwGk2/UEq0+0bYtRVsX2rl7J6QESl8/j7PAuKfGXyycylYfQobutuJ+i/S
 FMnn4FO5ihBvdalQzP9DUXmUSZgVzF2wCQvvQVfuts0gON5jvn8lWEc2enry1tRE4ch6
 Gt0yg/w7OxzIESz/FlVv+MPObnlOUY1BslUvBTBp4bQ/b+I+pJww4TodzdBgXtpSjKac
 8rk5Fd8okqYcQW3G79QnCmJCky1p25zvA2DV4VzJ5tYxTW44/MqPoeyd8lQo5gNxeOhz
 NSAO1xF2pfzkUBcZPOUalh67AZ2Kc4Hn/3DM3iCaCuH2GyhY5CV76Pbi+7eEwi8mzH1g
 PCyQ==
X-Gm-Message-State: AOJu0Ywv76WifnERTtzSzhnyOBPbdBrAKUPsCPQ4zu+VYFZKKG0d6HUu
 3L8djB+miRjcNnGBB5clE5lKJvTVIQnxShoDTXc0dsyKt/XTNL/ROX0uGgON/0GtviNd8UCeRGp
 omAO29uE=
X-Gm-Gg: ASbGnctYnDxxBWSLz9k7sgyympINH3RYkFGX2hOsRkl7dPEQldxLhS+GPbGQ0o0CU9A
 98/AMsplZRV8ZkBQbjdXynGZmzHZVmJNSjTE5UIO9so9Q3SrkNxwB1Rs+AUTft/7mS7e+bF8hPR
 PAfuBDhQYBqICd2M27a5Mu2vc2brtCuU5oFHEaj35rjAM64rqv7idP76pdgJ+COCMoJXk3r0wH4
 tjXSEf2xPyMeXBZ44cNIZzpV+OcxJB5YUJoYcx8k29wHiYmmY0OyzgZd6HjrmyoJQ+1RaUMkJu+
 PyXXCsxB8XtePksOPUobEeJkNF8ojhjOyj2D74MJ6NBtC+n/7lKqvwJ05R/jpHLENnIALC1+ftV
 MFAIBozXYASNoHaVUGfjM7iHCLHpe82k1LQ4KFg7r6ah5wzYrMs6s20CmZxyCcqi/wQ9MTUai+N
 YcKk3rMQuu8AlayorS1Rwh/NZCLn2Mi9q3O9o3w1MI1s8J/egVHa6DPOp2jk+f
X-Google-Smtp-Source: AGHT+IFTfKWW0dhKAZi3fGZWw1LfxdZ0TA5SyJNtF8Ukj0uDOtBu7BFOe0R1SNgijUt61Y3pFYJX5w==
X-Received: by 2002:a05:600c:548c:b0:45d:5c71:769d with SMTP id
 5b1f17b1804b1-4711726289cmr122823695e9.8.1760998219984; 
 Mon, 20 Oct 2025 15:10:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144b5d48sm252593355e9.9.2025.10.20.15.10.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 15:10:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 07/30] hw/arm: Add DEFINE_MACHINE_[ARM_]AARCH64() macros
Date: Tue, 21 Oct 2025 00:09:16 +0200
Message-ID: <20251020220941.65269-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020220941.65269-1-philmd@linaro.org>
References: <20251020220941.65269-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

A machine defined with the DEFINE_MACHINE_ARM_AARCH64() macro
will be available on qemu-system-arm and qemu-system-aarch64
binaries.

One defined with DEFINE_MACHINE_AARCH64() will only be available
in the qemu-system-aarch64 binary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/hw/arm/machines-qom.h | 13 +++++++++++++
 target/arm/machine.c          | 12 ++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/hw/arm/machines-qom.h b/include/hw/arm/machines-qom.h
index a17225f5f92..109a8bc4985 100644
--- a/include/hw/arm/machines-qom.h
+++ b/include/hw/arm/machines-qom.h
@@ -9,10 +9,23 @@
 #ifndef HW_ARM_MACHINES_QOM_H
 #define HW_ARM_MACHINES_QOM_H
 
+#include "hw/boards.h"
+
 #define TYPE_TARGET_ARM_MACHINE \
         "target-info-arm-machine"
 
 #define TYPE_TARGET_AARCH64_MACHINE \
         "target-info-aarch64-machine"
 
+extern const InterfaceInfo arm_aarch64_machine_interfaces[];
+extern const InterfaceInfo aarch64_machine_interfaces[];
+
+#define DEFINE_MACHINE_ARM_AARCH64(namestr, machine_initfn) \
+        DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
+                                            arm_aarch64_machine_interfaces)
+
+#define DEFINE_MACHINE_AARCH64(namestr, machine_initfn) \
+        DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
+                                            aarch64_machine_interfaces)
+
 #endif
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 44a0cf844b0..5c42a82be6c 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -9,6 +9,7 @@
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
 #include "target/arm/gtimer.h"
+#include "hw/arm/machines-qom.h"
 
 static bool vfp_needed(void *opaque)
 {
@@ -1212,3 +1213,14 @@ const VMStateDescription vmstate_arm_cpu = {
         NULL
     }
 };
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA640C369D3
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8L1C-0002ak-7D; Fri, 25 Apr 2025 11:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L0c-0001X5-Nn
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:30:43 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L0a-0003uP-9P
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:30:33 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cf848528aso16829025e9.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745595030; x=1746199830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jvs44ehSMS7vr5Ngp7xi3bJceK1a1pBELdrshQJvya0=;
 b=xOxYV4byykdUB/31gInDlyo79quNgSyGvIWHGw6LeY7NgG6jTaM0HJ+5iRDdtTM9RF
 m8+6dO477Tvnq37jksU7/wdzKtF2glyX48BZrM5zFTpUWjw50Z2Oaeav2wN56++Bm5ot
 QJYOOYx7Qd0Z6AHYAEUFPSytCq83dJjpVzwdq39FN+DozEaCqF7PSYB6d7uB0a8Z4uZQ
 wOnuN3lAhcNT3+5NYNMHO+NDwf3rIMRLyztppJRyjSbVhVkzkxKpevv1cKg7eDpfHesw
 QCmsJEnUFZmlJVqGMuS277sCORHPQWnMVGXe5bHjHLdlfML8UTt/l0qSHLErT0vTATPG
 56vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745595030; x=1746199830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jvs44ehSMS7vr5Ngp7xi3bJceK1a1pBELdrshQJvya0=;
 b=Kvv1OvaU+FxDJSswOX9XYKdEeKsI9Za+xUbf3DsrXQBkSkpRpwsl2Wsl2WF7RbOWFm
 VQ2NnsN15bjGwDBZQ9rXnjScit/qnWfoR4xbXw9Pt6828rDWg4S9eciEwA3+mXaDQdlE
 8oQZJfcqwpjRFby/OTUH+eh8k860Vm0lRCIRiXd9gR+S7HL8xCkfRhc39y95ZoZyC9U8
 Oay1aVxIz5gWlw6Kom1yM5rp4kH77r9MsrXa2iS5po3BcPK8+7FaKtL0MToYzVovmP8x
 dFr4xttWTKSDY4jB7Otp9qYPGJkWAd56lqTwPTdZrKVY9ZPE0wUrWthFnnesm830TSE/
 AohQ==
X-Gm-Message-State: AOJu0YzU8z83H70m+PoyQGqat2V+OW/nZh2W82GMXR7XR6F+4yGfo9PN
 n6cwF5/0GuLX0u3HhgTRfN09CUynuGdu1LbAPoB02xoteOyuAptc43luY8gXiKpbEkfiKU/A072
 Q
X-Gm-Gg: ASbGncvOeOT5UChLKEzvBN92qiWld+kNXwsKcWeyNczKQp1yYBunX02pBKmBTXoGqqm
 44OdtI9k7dDJqeBLSikt8W98ByuPrzkdQVnaKpqbwokKgLm5dAYek5W1hp90A1EvLDWP2kWtP00
 JSZPsoku1EFXfpCo3yVUHxqoCL+5QvSVz1hmZwy6hLtQ2/kqDXtw1SPG68sL1g5CT4fVvknd73q
 Ql8Mg/qjlG2vjSEWWNn+V9cLMssV5umk8aNZI0oxSnJtP2w4mptgzLhyRyixnOzoQaRE2tS1NIV
 xmfTbXMQUk7kfBugdGcgU3SuL/lLft2N5pdpEMP5JWpJPa4Mvc+eLUi0SHwl6ULrkAr3Z/GrZ0H
 SZXemDv7/WlnVl4Q=
X-Google-Smtp-Source: AGHT+IH+Ngl9OZstdsZLuLUTczfqV5MXeo7jPlYtHmwfzO9QDr2VUhA/NNC0yPEUcSulmeAcOs39iw==
X-Received: by 2002:a05:600c:3d8b:b0:440:6852:5b31 with SMTP id
 5b1f17b1804b1-440a65d8109mr31817015e9.10.1745595030141; 
 Fri, 25 Apr 2025 08:30:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a536a1ddsm28165085e9.30.2025.04.25.08.30.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:30:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 21/58] target/arm: Handle AArch64 in TYPE_ARM_CPU gdb_arch_name
Date: Fri, 25 Apr 2025 17:28:05 +0200
Message-ID: <20250425152843.69638-22-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

Instead of having the TYPE_AARCH64_CPU subclass set
CPUClass::gdb_arch_name to a different function, make the
TYPE_ARM_CPU implementation of the method handle AArch64.

For the moment we make the "is this AArch64?" function test "is the
CPU of TYPE_AARCH64_CPU?", so that this produces no behavioural
change.  When we've moved all the gdbstub related methods across to
the base class, we will be able to change this to be "does the CPU
have the ARM_FEATURE_AARCH64 feature?".

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250317142819.900029-4-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/internals.h | 6 ++++++
 target/arm/cpu.c       | 3 +++
 target/arm/cpu64.c     | 6 ------
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index d24acdd672e..08f4bd16791 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1826,6 +1826,12 @@ void aarch64_add_pauth_properties(Object *obj);
 void aarch64_add_sve_properties(Object *obj);
 void aarch64_add_sme_properties(Object *obj);
 
+/* Return true if the gdbstub is presenting an AArch64 CPU */
+static inline bool arm_gdbstub_is_aarch64(ARMCPU *cpu)
+{
+    return object_dynamic_cast(OBJECT(cpu), TYPE_AARCH64_CPU);
+}
+
 /* Read the CONTROL register as the MRS instruction would. */
 uint32_t arm_v7m_mrs_control(CPUARMState *env, uint32_t secure);
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 00577f97eb6..bed0e58f3c0 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2649,6 +2649,9 @@ static const gchar *arm_gdb_arch_name(CPUState *cs)
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
 
+    if (arm_gdbstub_is_aarch64(cpu)) {
+        return "aarch64";
+    }
     if (arm_feature(env, ARM_FEATURE_IWMMXT)) {
         return "iwmmxt";
     }
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index eaf5705cdc2..fbb7e7b3d64 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -813,11 +813,6 @@ static void aarch64_cpu_finalizefn(Object *obj)
 {
 }
 
-static const gchar *aarch64_gdb_arch_name(CPUState *cs)
-{
-    return "aarch64";
-}
-
 static void aarch64_cpu_class_init(ObjectClass *oc, const void *data)
 {
     CPUClass *cc = CPU_CLASS(oc);
@@ -825,7 +820,6 @@ static void aarch64_cpu_class_init(ObjectClass *oc, const void *data)
     cc->gdb_read_register = aarch64_cpu_gdb_read_register;
     cc->gdb_write_register = aarch64_cpu_gdb_write_register;
     cc->gdb_core_xml_file = "aarch64-core.xml";
-    cc->gdb_arch_name = aarch64_gdb_arch_name;
 
     object_class_property_add_bool(oc, "aarch64", aarch64_cpu_get_aarch64,
                                    aarch64_cpu_set_aarch64);
-- 
2.47.1



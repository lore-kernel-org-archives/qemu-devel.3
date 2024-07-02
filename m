Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25BE3C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 05:02:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOVeS-0007Ix-V0; Tue, 02 Jul 2024 01:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOVeQ-0007Ic-MH
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:01:58 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOVeO-00070K-Ue
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:01:58 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-52cdfb69724so4660797e87.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 22:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719896515; x=1720501315; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ojuMSOD3mJ6z5l/dHTXyuiUf8CYGwAbSuIgUM0ljX7g=;
 b=gH2Kv6GVBmyBUo1pg2skAixpDRIvTjbeLtLtha2JP7ldtjj0bnHcpdyK8xHC3xutdC
 0YJ9tposCWfnWCPAluzT+rqy3I39tJcRxRqKP5yjCeF+8783ONYtj8JPl8noL/WHzH8o
 gMCzEIdJEWKhm23URhK5di/vm8IC4ZdpraOVijCoPL5bwVVOYU5fsZ13fCA22gAVX7H/
 UTzRZYMdmJngU6XUUdhXJtJ2FK3neuDL9ALzrKVH+JAJHckDd/xCSN2PjEg43XzzSpZm
 ApSNuThLREb4g704TQ2rnELYS+kw7ti52a9kW4zV/EiWUGE9LkOt9CHz1S7W1+wmXpRs
 rUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719896515; x=1720501315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ojuMSOD3mJ6z5l/dHTXyuiUf8CYGwAbSuIgUM0ljX7g=;
 b=EVK886pTR4LWBrmvVKeaqFXnuJ97shjmQRd1KX2P5SV0fSEdTYAAvzDJbT0Q9z1Uu8
 TOPnVvwmDeSXzu063uH+N9Qdruz/eV6r3FbRZ/awEoRzPQntHdizygkHntLp3Yqfi4nq
 oZVV5O33WCir0hrlUSJFffvYdBMXTeeMP0hHL1awDgJikgZVRjrhdHEpoSi6twncx1sm
 lfqE3RLxIYl36cTp9FwG1sf4YUwbR6dzmtwDgNdw101liAC5+pD5gYbVMeTD9pB02Koz
 z9YZ2mXg4SpEBRypUNd04aGKKvzye7gBr7/skoNmW2rLQMHwvbGUAg1S45uMNnT6ybmx
 IsDQ==
X-Gm-Message-State: AOJu0YwtjAiNTqu41qI19RLXJngroHeQh8sGUCSmYyp1oovCWVUbgWgg
 9rvIR5JAxCNJPOAVADmNVvBLcLBOjq/8mwxbKCsDHydMeSdJ85doNlm+q0n0Cp3C30hvzQvAYqr
 b
X-Google-Smtp-Source: AGHT+IHQB3zMTuVtzT4hTy8sDXNSZcOFo2IkIpW+3n0LBj9MHpCvAQnzSNfU2VQvlGpQPwZjL7wUlQ==
X-Received: by 2002:a05:651c:244:b0:2ee:7255:5032 with SMTP id
 38308e7fff4ca-2ee72555309mr15962701fa.34.1719896493894; 
 Mon, 01 Jul 2024 22:01:33 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4257bc89832sm109373675e9.42.2024.07.01.22.01.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 01 Jul 2024 22:01:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/22] hw/arm: convert 'virt' machine definitions to use new
 macros
Date: Tue,  2 Jul 2024 07:00:53 +0200
Message-ID: <20240702050112.35907-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702050112.35907-1-philmd@linaro.org>
References: <20240702050112.35907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

This changes the DEFINE_VIRT_MACHINE macro to use the common
helpers for constructing versioned symbol names and strings,
bringing greater consistency across targets.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240620165742.1711389-3-berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0784ee7f46..08990b9abe 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -101,33 +101,35 @@ static void arm_virt_compat_set(MachineClass *mc)
                      arm_virt_compat_len);
 }
 
-#define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
-    static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
-                                                    void *data) \
+#define DEFINE_VIRT_MACHINE_IMPL(latest, ...) \
+    static void MACHINE_VER_SYM(class_init, virt, __VA_ARGS__)( \
+        ObjectClass *oc, \
+        void *data) \
     { \
         MachineClass *mc = MACHINE_CLASS(oc); \
         arm_virt_compat_set(mc); \
-        virt_machine_##major##_##minor##_options(mc); \
-        mc->desc = "QEMU " # major "." # minor " ARM Virtual Machine"; \
+        MACHINE_VER_SYM(options, virt, __VA_ARGS__)(mc); \
+        mc->desc = "QEMU " MACHINE_VER_STR(__VA_ARGS__) " ARM Virtual Machine"; \
         if (latest) { \
             mc->alias = "virt"; \
         } \
     } \
-    static const TypeInfo machvirt_##major##_##minor##_info = { \
-        .name = MACHINE_TYPE_NAME("virt-" # major "." # minor), \
-        .parent = TYPE_VIRT_MACHINE, \
-        .class_init = virt_##major##_##minor##_class_init, \
-    }; \
-    static void machvirt_machine_##major##_##minor##_init(void) \
+    static const TypeInfo MACHINE_VER_SYM(info, virt, __VA_ARGS__) = \
     { \
-        type_register_static(&machvirt_##major##_##minor##_info); \
+        .name = MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
+        .parent = TYPE_VIRT_MACHINE, \
+        .class_init = MACHINE_VER_SYM(class_init, virt, __VA_ARGS__), \
+    }; \
+    static void MACHINE_VER_SYM(register, virt, __VA_ARGS__)(void) \
+    { \
+        type_register_static(&MACHINE_VER_SYM(info, virt, __VA_ARGS__)); \
     } \
-    type_init(machvirt_machine_##major##_##minor##_init);
+    type_init(MACHINE_VER_SYM(register, virt, __VA_ARGS__));
 
 #define DEFINE_VIRT_MACHINE_AS_LATEST(major, minor) \
-    DEFINE_VIRT_MACHINE_LATEST(major, minor, true)
+    DEFINE_VIRT_MACHINE_IMPL(true, major, minor)
 #define DEFINE_VIRT_MACHINE(major, minor) \
-    DEFINE_VIRT_MACHINE_LATEST(major, minor, false)
+    DEFINE_VIRT_MACHINE_IMPL(false, major, minor)
 
 
 /* Number of external interrupt lines to configure the GIC with */
-- 
2.41.0



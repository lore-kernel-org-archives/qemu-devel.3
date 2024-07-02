Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A41A6C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 05:03:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOVf4-0000T5-CT; Tue, 02 Jul 2024 01:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOVf1-0008Tq-K3
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:02:35 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOVex-0007Ea-9r
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:02:34 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-52e829086f3so3575683e87.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 22:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719896549; x=1720501349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JbdsfJ44aAB8rxW6wAXXI/854m0o2ZFI+jAaNwL715g=;
 b=FBFI41WO3Y5PjrYn8KHPhZQXGFbPrmytEnrd7/qJQbiHEj6bVjgmJXb/IzvNIvJvUH
 rCAp5tvTeuonI9zWClXeEf7jpOID4LtMGeUcf/nL0kcW3sQrHtqPyxQwJaLgAW+zA5ff
 FP5pJwUWFFYm23fRUZWC3lKGpBnJZFnxxVHFk5nEbZ32IjysywBCZKCtB+TTBHOqaIA+
 a5PYGGmTxIPvdZf2d3xFku5n1YaHlb/SahjFMuBWMW5LWQN42kE9auQ+XmNZ4z6wCBWT
 N4s1nEuhDZpFu3H1SBYsjEwk5LKw8o24jNuVz+PV5o2KdsNYYWrq8jJZ1Mdh1mQJ93wJ
 M32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719896549; x=1720501349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JbdsfJ44aAB8rxW6wAXXI/854m0o2ZFI+jAaNwL715g=;
 b=uHI05vyDXxW0iDvaawxSqCBaq1ZqNSTBuxxhh3A5tpdID1IbwWfBFGuNaZ0B8+PrCt
 tccruV3z3fn21TG1BThR3SYx1fxcSL/VwhIZ+SZzNwZnyypcBiM+bvpTau/2DYfI94zM
 DZueJDAeItLLuT9HfYwngsu/KDL/yT/So8+NTQcdd1RonZj7/fVtWHoaOTJILZd8gFww
 TjsL7+iLqwO7DBF0EnGWs8GzjznF2arOs5+AAxMtdZq3M/jJFyj9ltpl0CHhaNV0wMvb
 0ou0SxCQloL1j8JgwEqxpcPdi0NsjyUmj0dAaJHyv2vvRPm6H4Zz5LNUhJ31YaHaUjot
 r/OA==
X-Gm-Message-State: AOJu0YzVKUviFamP2E5n1XlbUNLk/SAQ+ZAaqyz3Kf4OwtMvvp4LgVC6
 9qmpChyCQ6aov0SmX/ys5bhItzV/TOKdYSmfX9vfNmVOg5Yvt2VAawCxF8NlVKGEaV22BwURhzd
 T
X-Google-Smtp-Source: AGHT+IHcSruALdXDiIhrnburbKhsGcwxE0dO3V+PQeZp6k6vmsrjg8P3WukjH+jfgclugP65Ugy08g==
X-Received: by 2002:ac2:4c41:0:b0:52b:bee3:dcc6 with SMTP id
 2adb3069b0e04-52e826fa995mr5628932e87.51.1719896549046; 
 Mon, 01 Jul 2024 22:02:29 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a1108b0sm11916332f8f.114.2024.07.01.22.02.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 01 Jul 2024 22:02:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 12/22] hw: skip registration of outdated versioned machine types
Date: Tue,  2 Jul 2024 07:01:02 +0200
Message-ID: <20240702050112.35907-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702050112.35907-1-philmd@linaro.org>
References: <20240702050112.35907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12b.google.com
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

This calls the MACHINE_VER_DELETION() macro in the machine type
registration method, so that when a versioned machine type reaches
the end of its life, it is no longer registered with QOM and thus
cannot be used.

The actual definition of the machine type should be deleted at
this point, but experience shows that can easily be forgotten.
By skipping registration the manual code deletion task can be
done at any later date.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240620165742.1711389-12-berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h       | 1 +
 hw/arm/virt.c              | 1 +
 hw/m68k/virt.c             | 1 +
 hw/ppc/spapr.c             | 1 +
 hw/s390x/s390-virtio-ccw.c | 1 +
 5 files changed, 5 insertions(+)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 83d2e66498..4e55d7ef6e 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -340,6 +340,7 @@ extern const size_t pc_compat_2_3_len;
     }; \
     static void MACHINE_VER_SYM(register, namesym, __VA_ARGS__)(void) \
     { \
+        MACHINE_VER_DELETION(__VA_ARGS__); \
         type_register(&MACHINE_VER_SYM(info, namesym, __VA_ARGS__)); \
     } \
     type_init(MACHINE_VER_SYM(register, namesym, __VA_ARGS__));
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 02e13b4a3d..b0c68d66a3 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -123,6 +123,7 @@ static void arm_virt_compat_set(MachineClass *mc)
     }; \
     static void MACHINE_VER_SYM(register, virt, __VA_ARGS__)(void) \
     { \
+        MACHINE_VER_DELETION(__VA_ARGS__); \
         type_register_static(&MACHINE_VER_SYM(info, virt, __VA_ARGS__)); \
     } \
     type_init(MACHINE_VER_SYM(register, virt, __VA_ARGS__));
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index 37bb36b385..cda199af8f 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -356,6 +356,7 @@ type_init(virt_machine_register_types)
     }; \
     static void MACHINE_VER_SYM(register, virt, __VA_ARGS__)(void) \
     { \
+        MACHINE_VER_DELETION(__VA_ARGS__); \
         type_register_static(&MACHINE_VER_SYM(info, virt, __VA_ARGS__)); \
     } \
     type_init(MACHINE_VER_SYM(register, virt, __VA_ARGS__));
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 55268489d3..044e6a8d9d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4824,6 +4824,7 @@ static void spapr_machine_latest_class_options(MachineClass *mc)
     };                                                               \
     static void MACHINE_VER_SYM(register, spapr, __VA_ARGS__)(void)  \
     {                                                                \
+        MACHINE_VER_DELETION(__VA_ARGS__);                           \
         type_register(&MACHINE_VER_SYM(info, spapr, __VA_ARGS__));   \
     }                                                                \
     type_init(MACHINE_VER_SYM(register, spapr, __VA_ARGS__))
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index c25dc3e13f..336cb8c6d4 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -847,6 +847,7 @@ static const TypeInfo ccw_machine_info = {
     };                                                                        \
     static void MACHINE_VER_SYM(register, ccw, __VA_ARGS__)(void)             \
     {                                                                         \
+        MACHINE_VER_DELETION(__VA_ARGS__);                                    \
         type_register_static(&MACHINE_VER_SYM(info, ccw, __VA_ARGS__));       \
     }                                                                         \
     type_init(MACHINE_VER_SYM(register, ccw, __VA_ARGS__))
-- 
2.41.0



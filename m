Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1150EE77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:25:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6KM-0004Y1-B0; Sun, 12 Jan 2025 17:21:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6KC-0004NN-V0
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:20:53 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6KB-0006sQ-B3
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:20:52 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-385d7f19f20so1901655f8f.1
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720449; x=1737325249; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bHPlQnm3HsPVLvOhysF1ew4D4qv91kBHvXEYj4oE07s=;
 b=ajjHndTvXUg6vWDIFD7LqbQ756CN6ykYQqyH7xFb4A7Jl7QXLBw9o4kFDIPZwLxgQ5
 VrdGLlxi/HvMKC/botmTr0Kg8LdA7yGLZ6dteYZUxdzL/2NWx3oAKml2aC96AvCAOMLh
 5lOH7ZlsXebmwt5uP2ouKS/gwdS7QdyMrV9uA30o/T8J1HkKO7igfMTjCDZRy7SRZD4r
 840X94ftBjAUi5iQGWrGp8mbDqsRAXXzCII41A6sLt4CWtjyrgW/+QNWsgTPr4kXv3rd
 7/JJOLTYI44RvM1EB6DVDbT20AQlGP35CqTZ7otFHva44PqOujYbl9obiMI5QDYvG9IE
 SKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720449; x=1737325249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bHPlQnm3HsPVLvOhysF1ew4D4qv91kBHvXEYj4oE07s=;
 b=mDMaXADIbRCfdR/CW/HmbXnL9eYalE6NfT/kSlDTmBeef7vdK+pY5qd8YkXsgGGeed
 5vaC4FxxQ1AWmQH32sZ8Nbn5iKoXhdGe/fUvfvoGvV6+sfyqDjp/MXE1AQM3qiPN7Rjj
 rvFxUfDMxvJ+ooj4v7GYSketTqmkZ+SCbdUtsW0FU0CcEhFO2yEZYKOSF8y159o4Vap3
 2QbN1xt70gvqmiCqeHFEhIbdOMZsDZPSnRcbenQWtDiKujAmG2f1KLLzfpRTie3x6GGa
 qXtQ2fE0Hr8/y8zqibiu6V1LUWNVs1wNeQEz5okp5NshpBB8pRctYTQkRpMH0OcqHPt7
 sagw==
X-Gm-Message-State: AOJu0YwMVCwAcauTULTh/uTw4YgRgWeVK4WQj/TFwha383/0p4cwDz2S
 HcwOSD6SJ4xuGNyNVOgRvpYu7RqPK+26lRZALQ+MzkO0tMlZ1bhJF66dL2UrJqx0hYIGUlsfFoq
 Gt9A=
X-Gm-Gg: ASbGncuZscP+VUBrWE4zFQMUIptvCEVPmEVYpt4ixqcKA9bi21b4A9jHj/m1z8zosz7
 eFcUG2HoeDDi0lRpG/sHul72tYcfAsq4bF4VyavjDF3nCck8BFhYO75eaMFY2BKOa85JT/2t6bB
 rmqA7tI6eGzqGjLbkmHxvu3OwAl68MZdtswA+RN2XDzj68ubHRO/K+gw7dJp1VZFFF5vSKAD4Bp
 tLWNPp3fF8YmXvRQfUvlXBZ55tw9nPu1+HzL0q81sWqf8FkaIMMq5Wi1aYjmp8Jmp/N+6qlAf5P
 T/9qAjb2mM2/l9V4a6GTeuSahhcc7Dc=
X-Google-Smtp-Source: AGHT+IHNzDlXQ3SHUg63MX495FPtMXRghNJvwv+YPDDNCePCRGZtV0Ghwpt118309Npa1SpBZeVIfA==
X-Received: by 2002:a5d:47c4:0:b0:385:f892:c8fe with SMTP id
 ffacd0b85a97d-38a87306ddcmr19966676f8f.21.1736720449570; 
 Sun, 12 Jan 2025 14:20:49 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9d8fc51sm124668755e9.7.2025.01.12.14.20.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:20:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 41/49] target/hppa: Speed up hppa_is_pa20()
Date: Sun, 12 Jan 2025 23:17:17 +0100
Message-ID: <20250112221726.30206-42-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

From: Helge Deller <deller@gmx.de>

Although the hppa_is_pa20() helper is costly due to string comparisons
in object_dynamic_cast(), it is called quite often during memory lookups
and at each start of a block of instruction translations.
Speed hppa_is_pa20() up by calling object_dynamic_cast() only once at
CPU creation and store the result in the is_pa20 of struct CPUArchState.

Signed-off-by: Helge Deller <deller@gmx.de>
Co-developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20241231190620.24442-7-philmd@linaro.org>
---
 target/hppa/cpu.h | 6 ++++--
 target/hppa/cpu.c | 8 ++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index c1d69c1a835..083d4f5a56a 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -266,6 +266,8 @@ typedef struct CPUArchState {
 
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
+
+    bool is_pa20;
 } CPUHPPAState;
 
 /**
@@ -297,9 +299,9 @@ struct HPPACPUClass {
 
 #include "exec/cpu-all.h"
 
-static inline bool hppa_is_pa20(CPUHPPAState *env)
+static inline bool hppa_is_pa20(const CPUHPPAState *env)
 {
-    return object_dynamic_cast(OBJECT(env_cpu(env)), TYPE_HPPA64_CPU) != NULL;
+    return env->is_pa20;
 }
 
 static inline int HPPA_BTLB_ENTRIES(CPUHPPAState *env)
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 7278b7ca6b5..b0bc9d35e4c 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -193,6 +193,13 @@ static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
     tcg_cflags_set(cs, CF_PCREL);
 }
 
+static void hppa_cpu_initfn(Object *obj)
+{
+    CPUHPPAState *env = cpu_env(CPU(obj));
+
+    env->is_pa20 = !!object_dynamic_cast(obj, TYPE_HPPA64_CPU);
+}
+
 static void hppa_cpu_reset_hold(Object *obj, ResetType type)
 {
     HPPACPUClass *scc = HPPA_CPU_GET_CLASS(obj);
@@ -282,6 +289,7 @@ static const TypeInfo hppa_cpu_type_infos[] = {
         .parent = TYPE_CPU,
         .instance_size = sizeof(HPPACPU),
         .instance_align = __alignof(HPPACPU),
+        .instance_init = hppa_cpu_initfn,
         .abstract = false,
         .class_size = sizeof(HPPACPUClass),
         .class_init = hppa_cpu_class_init,
-- 
2.47.1



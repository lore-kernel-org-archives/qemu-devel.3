Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C5EC369CB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 05:02:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9d6h-00012x-Tf; Tue, 29 Apr 2025 01:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9d52-0007en-KD
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 01:00:31 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9d50-000613-I6
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 01:00:28 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-224171d6826so83316315ad.3
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 22:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745902824; x=1746507624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oGLga5UEOZhK97fJQViOQTJRGL03WkVBEBC/7bd6T1M=;
 b=m+j7P9eGV5XuVPSZmxsguyTLebdZ+0Nsr2IwvUZrEImsStahtZ6pQYTXYmxw/wODsk
 mARN96YIMWsOQTW9deAPPwtguj6zPFZKcOuCHmTZW1dyKyi0ur10Qu+adW4dFbZCPbxR
 xu22xIxjWwVdOt0XO37vdRPKt+gHMp7FfEQf9DXAaFh+FXf/ncavwNbvBrqN9izq6Hvl
 3EHNXlw1Ik1MB8z5qsA0mWQ3ilJYlU/T6EYrNsKcU6gRHXVB1DcCBRHLBJhl80h4FJ1e
 +qKOAhKksCigYVDO+PVhhYfi4gJueTl1AXKiopjGVsg2nH52GdbDrF6fAqmrv1AiiwJX
 AyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745902824; x=1746507624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oGLga5UEOZhK97fJQViOQTJRGL03WkVBEBC/7bd6T1M=;
 b=k4oY53snaYgD0YbCqqPcBWRs6BggkVnPsDIjMMtE7VqBTdOosphy5m6SGTv6V/jB1d
 9Dnj01vS9wThtz0+NImYZWOhncx8jjXk3hM1kUu+li7JPvqWHxfVgz83c84TGR/iL5IY
 eqDCT+FJe5hLZG7oaGgNN9IPwkC1vPv9hfJrCOviuHQzwfTWLeQxuo+LnQUn9ZTPotVO
 Kj823JczLbLStYXxcIbnsfGp6nDHUvqAN1MHu4TqJY4yGfZ367t8bW802WH7Xvys0j0W
 UK0UWwU1dM1CE0Sc6PVZ2IAQLUqWGp/9ya8oRe98XqQmtUggL3V79Whv+4QC0aqMQCD7
 QC0Q==
X-Gm-Message-State: AOJu0Yyq6m9WSE6h/czSyZ9wtJYzVu8WxQsUmWbPX4Q3sLFiFSTkZPwK
 vMQoZOxC4Sb4LSY9Kr7ReriyRLsxp+jpeTE0jsTksb+S5oENEC0CDpSy610+QNXh8Pi3YVKq/FD
 B
X-Gm-Gg: ASbGnculgWkXUHa5jNwPrj6V/zKrWVS4+sE1LxjTVDrr9XCAQsX3XuQpFlWhbhkymmJ
 2/X0SwspzkJ5BbSiRLrapLcc5HmiJVl9WsNQD/Ucye/vNmKmrDo88zC9iNc2EXcqo08BBRgrHRl
 njXIZ5SCd18q8/1F2iiMRyIF8/AoF01W/SYKJwOzmJXE7V4BxbEUjZUPSrY2vNWWrYAfK0S8OoM
 agYPl1oNsEmhHVNv88mB2Gf5GuBO6GfzZ8VP0wMkQy4z8W5cy9gpMAUpw85nmM9BC74ddB1Nx/1
 TFkJXprzR4h/qBAzjEtKE1s9+p/+A9ogmvjvg4/R
X-Google-Smtp-Source: AGHT+IFyx8N8uA4PzRLCM0NcJk2OWep5SdanjS9wPYwbq+EMM4JH4KwnmPdpBJL4WqQPXBMcgSf+qg==
X-Received: by 2002:a17:902:e5cd:b0:21f:71b4:d2aa with SMTP id
 d9443c01a7336-22dc69f83d4mr156777235ad.5.1745902824466; 
 Mon, 28 Apr 2025 22:00:24 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4dbd6f7sm93004015ad.76.2025.04.28.22.00.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 22:00:23 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, anjo@rev.ng, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 09/13] target/arm/cpu: get endianness from cpu state
Date: Mon, 28 Apr 2025 22:00:06 -0700
Message-ID: <20250429050010.971128-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250429050010.971128-1-pierrick.bouvier@linaro.org>
References: <20250429050010.971128-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

Remove TARGET_BIG_ENDIAN dependency.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index e7a15ade8b4..85e886944f6 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -67,6 +67,15 @@ static void arm_cpu_set_pc(CPUState *cs, vaddr value)
     }
 }
 
+static bool arm_cpu_is_big_endian(CPUState *cs)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
+    cpu_synchronize_state(cs);
+    return arm_cpu_data_is_big_endian(env);
+}
+
 static vaddr arm_cpu_get_pc(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
@@ -1130,15 +1139,6 @@ static void arm_cpu_kvm_set_irq(void *opaque, int irq, int level)
 #endif
 }
 
-static bool arm_cpu_virtio_is_big_endian(CPUState *cs)
-{
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
-
-    cpu_synchronize_state(cs);
-    return arm_cpu_data_is_big_endian(env);
-}
-
 #ifdef CONFIG_TCG
 bool arm_cpu_exec_halt(CPUState *cs)
 {
@@ -1203,7 +1203,7 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
 
     info->endian = BFD_ENDIAN_LITTLE;
     if (bswap_code(sctlr_b)) {
-        info->endian = TARGET_BIG_ENDIAN ? BFD_ENDIAN_LITTLE : BFD_ENDIAN_BIG;
+        info->endian = arm_cpu_is_big_endian(cpu) ? BFD_ENDIAN_LITTLE : BFD_ENDIAN_BIG;
     }
     info->flags &= ~INSN_ARM_BE32;
 #ifndef CONFIG_USER_ONLY
@@ -2681,7 +2681,7 @@ static const struct SysemuCPUOps arm_sysemu_ops = {
     .asidx_from_attrs = arm_asidx_from_attrs,
     .write_elf32_note = arm_cpu_write_elf32_note,
     .write_elf64_note = arm_cpu_write_elf64_note,
-    .virtio_is_big_endian = arm_cpu_virtio_is_big_endian,
+    .virtio_is_big_endian = arm_cpu_is_big_endian,
     .legacy_vmsd = &vmstate_arm_cpu,
 };
 #endif
-- 
2.47.2



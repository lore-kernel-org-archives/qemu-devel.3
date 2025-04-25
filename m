Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B78CCC369D3
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:32:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8L15-00022X-0z; Fri, 25 Apr 2025 11:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L0l-0001bB-Gg
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:30:48 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L0j-0003wz-NU
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:30:43 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-39bf44be22fso1640024f8f.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745595040; x=1746199840; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mlzJ4A4jALjtU+0r3cIdS3NAsSdBaVqAytVllxW1gkI=;
 b=haGZqoR2i4Vhw6wPRnh1bR67hwwjr+/k4QiBvGriqC7t4qRCenYQhYCfV42hLf9iT/
 XGfeCKelQISSOxUwa0OdPMXDcobEkKXEnOOmHAkO8WXGdF96AbAhplgg6nuvAkfur21l
 u8LwnIxf+AwIXWhGofAJfBSKCOI3rn6I9dEJ4/BNnqeAlMnBAPzqOcEP1eXyoRC93aPr
 YIjUfyIfPHjwkNUg/dIbDaf4AFs8EWMf+px5BgapGHzMA1xmLfeLEfTGza6QcGT36BIt
 UwYEnZZykpbPB910Nk86SD2MU0xynyNWatlvw0doPmctJwJ00uu5r/EBR8REkGgYjlzz
 KovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745595040; x=1746199840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mlzJ4A4jALjtU+0r3cIdS3NAsSdBaVqAytVllxW1gkI=;
 b=Sg03h0jtdw6SYB/Oy9O1SGYFRqRIOVwvL99NJBwmhh8dDR4JL0TKsJelWkSUg4HaOe
 EhKD8jIqF7Mnw+oGYRHU+jrzRBTPYC0uut6zeh861mIK/HyylWkNj4S3dHbA2bun6kUk
 r8yeu88+iq3EbkmRhET6rqsCYzqlTdVhzJ2+c9zo7LC88UyEy0+gogW4Ocys5Eb2kepc
 BoXORj1VccN/zZE+2XN2lFgqO42GKn7xiTNc5isstL+tID+8AXrqGn0gQyfnsHIGPci4
 OyAJcailSngeyZqBbJeBCsyoXTmueugT8pyIBriUmyn0rrBBcDtbLv0JA7ve5G6yI0Ln
 yjyA==
X-Gm-Message-State: AOJu0YwmzvRNKtareqr0X3p+SY1iISRX4QoKWJxu5Vq9SW6MhcGJG/wF
 NkFh5C8XDiGWnUoaIt7ue6KXy9OkkBPtA2iHs18/aH0hh4Wzl9isRIjz5QmIKETBvKf/BP34ShP
 b
X-Gm-Gg: ASbGncsW0AONYzN5KVFZ7fVEwHrY1sYMxiwVlpi/BRjY78jVPyRNJlacDZk/ETGPvZV
 kuiLFOUvN70es8ZIx+n2WESUG6yTMeM2A55XwzT/ay2DzFeCjPsAHdiup/s3n1qGn/jYF0y/x0b
 Mr/X6J7+d1VH9f0yrfgF2YdY6h3rAh+0qH+9S0QSpZva8nU3rHXqOvg8KQ+IAUimJfYIZpeq5uU
 whfvSD20cITnd1ceCyzeLGmfMbjiTGIbOdW3YN/6SxCxEOLS3pfRgJLRiQm56hNhD1kLuSojmvd
 iBPnReHrhO6xlrWq/73p/hKLyZ6pntHd/6suYZV7EhkU95yqCcFHhNOJPqth9kWJ6c69AgeKVn3
 3s9lkwDJ6LUYF59w=
X-Google-Smtp-Source: AGHT+IE6vPf9xNnWijRG4N4GrEi4epGED/SiKnjulZ7msqAbDByeQIF4QoAspisS64Onyc9cLe7P2Q==
X-Received: by 2002:a05:6000:4212:b0:39e:f9d8:e016 with SMTP id
 ffacd0b85a97d-3a074f0dbc6mr2163346f8f.44.1745595039908; 
 Fri, 25 Apr 2025 08:30:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5e198sm2704997f8f.97.2025.04.25.08.30.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:30:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 23/58] target/arm: Handle AArch64 gdb read/write regs in
 TYPE_ARM_CPU
Date: Fri, 25 Apr 2025 17:28:07 +0200
Message-ID: <20250425152843.69638-24-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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
CPUClass::gdb_read_register and ::gdb_write_register to different
methods from those of the TYPE_ARM_CPU parent class, have the
TYPE_ARM_CPU methods handle either AArch32 or AArch64 at runtime.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250317142819.900029-6-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu64.c   |  5 -----
 target/arm/gdbstub.c | 12 ++++++++++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 5135ef63cb2..00629a5d1d1 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -815,11 +815,6 @@ static void aarch64_cpu_finalizefn(Object *obj)
 
 static void aarch64_cpu_class_init(ObjectClass *oc, const void *data)
 {
-    CPUClass *cc = CPU_CLASS(oc);
-
-    cc->gdb_read_register = aarch64_cpu_gdb_read_register;
-    cc->gdb_write_register = aarch64_cpu_gdb_write_register;
-
     object_class_property_add_bool(oc, "aarch64", aarch64_cpu_get_aarch64,
                                    aarch64_cpu_set_aarch64);
     object_class_property_set_description(oc, "aarch64",
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index 30068c22627..ce4497ad7c3 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -44,6 +44,12 @@ int arm_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
 
+#ifdef TARGET_AARCH64
+    if (arm_gdbstub_is_aarch64(cpu)) {
+        return aarch64_cpu_gdb_read_register(cs, mem_buf, n);
+    }
+#endif
+
     if (n < 16) {
         /* Core integer register.  */
         return gdb_get_reg32(mem_buf, env->regs[n]);
@@ -66,6 +72,12 @@ int arm_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     CPUARMState *env = &cpu->env;
     uint32_t tmp;
 
+#ifdef TARGET_AARCH64
+    if (arm_gdbstub_is_aarch64(cpu)) {
+        return aarch64_cpu_gdb_write_register(cs, mem_buf, n);
+    }
+#endif
+
     tmp = ldl_p(mem_buf);
 
     /*
-- 
2.47.1



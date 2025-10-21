Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1376CCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:53:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJIn-0002m5-Jh; Tue, 21 Oct 2025 16:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJIQ-00029s-Tf
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:49:33 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJIO-0001Fb-SX
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:49:30 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47117f92e32so40259965e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761079767; x=1761684567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=x+PjU2MklfbFewUcVF0ps3xlghKX/9R0SWTbCRF7v2o=;
 b=vONn6SOLLf31T63h0NQLcJMAF+bvsOJn+o6NJjvOuzEe/tcURPg8EOTUL1brUjaW56
 jEFSotg6WB/8xxGywtU1vi9ySrdvIj1N7LDbPKXokS8rEnXts3xyrXP84AS7zX9eIr/Z
 DoV8MIKcT6SnEcMxspRQ3eqGvChF1gZcvZNkB40udH81/mEeY33mWQPQ31T3gvybJWSv
 zRyussCRPbaM3s7pNX2pBaho8nKRr0XfPR9WzHOjfXct3+Kw2mRdrvzPQ++Owag/OjUh
 huvY/U5hUdq/PfNg/n+ypomwrC6z/YBB02K8bWE8Iv4XrgBrILmnYNgziVEfaHxXb4Sh
 epaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079767; x=1761684567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x+PjU2MklfbFewUcVF0ps3xlghKX/9R0SWTbCRF7v2o=;
 b=sENpL+JFep2yohyr6gK62yriVVXwOVu3HkXPIcb4MPfkvckeGZPZcuWVecyprX52T5
 w35faHx5hKAVRfEtyGUoXCA/FC8WaHf31/uk1JfdiYnIb1hXmL1cWdmk9SFx9dRYRHop
 qibqEsEZfpdVPTi3dDX8wpxfQT89zYn6JYanApgX/erkIQP9Hnga1TM3POSxTTMIY4ZS
 GZ0xWxwechrKX9+f6Xy2R8wr7ACDDStpDziFu81XzE4oy5jxhTm/K4HVAVZH8BIThuDq
 zGolVw1WGA1oBtNejBQp5VrM1TegharfJytciVbiLZcTu7TYFMEPf7nTqzEgSb2VhQ6H
 tGzg==
X-Gm-Message-State: AOJu0YyD1sAR63v8QZdI7i2261fbMJz1k2PIJz6P2Bec+oEfCF1ryeb3
 TSsV7Drs+vmu5SyjRgtk00JSAAhOJC4oSBwf+/B7rwYe1OsUu1VBR7BOsENVC1LWbO9L1pCMgnv
 5U4rQVYI=
X-Gm-Gg: ASbGncu0UEg0vgnwE0PMHinDkFDXp1vuPGX5TB98bGvLFnrIliguSbRIUD6Haf5H+1X
 EdC176oqmI/tEMyps9YzfFM2+pP7n6GoX4Nr6gw0zes7W+7w6t5ImWbaE5nzP+t5aCN8aNjp/nQ
 +Ns2iazNT1eQCusM2QZTKBOoYtB6fK4G7GMn127lnywVxp9ZDtIe58NM4fQQO/nzf4N1jMg0tkm
 HavjmT8X2pWQNnJolFEug1uYSA0hXx/7yDB+0bGAiuBXsSyLgo5pcUU0HxbfovcOuw17G6eR6Fq
 BstxMAnrcrjEMUJm1XY4c4/OnYXny+E7QxEwUZJ20NnYzwmwD2votVMOhxVAWBGPpuqREmtx6X8
 ShwMXQA2NEo2+O+uF/0nnk/HGS2nSx6fWEjyzQhtZ4JYM5REDu0R+rB57WxlmiXytsgl+bHFyen
 czP26qlpimO+yL1p0+nYQz4kyOGkATfbxfMaRS1KSvCogVCaLJwg==
X-Google-Smtp-Source: AGHT+IFW8RvIRYkD9WUJa4fXbIu+drS5wxPOWxUAzNAbpM6odumKt2njizWORZ0bW2YSBx0kE/rGSQ==
X-Received: by 2002:a05:600c:4f95:b0:46e:345d:dfde with SMTP id
 5b1f17b1804b1-471178ac017mr120956265e9.16.1761079766971; 
 Tue, 21 Oct 2025 13:49:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47496d23237sm22851335e9.10.2025.10.21.13.49.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:49:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/45] hw/i386/apic: Ensure own APIC use in apic_msr_{read,
 write}
Date: Tue, 21 Oct 2025 22:46:45 +0200
Message-ID: <20251021204700.56072-32-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021204700.56072-1-philmd@linaro.org>
References: <20251021204700.56072-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Avoids the `current_cpu` global and seems more robust by not "forgetting" the
own APIC and then re-determining it by cpu_get_current_apic() which uses the
global.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251019210303.104718-9-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/apic.h               |  4 ++--
 hw/intc/apic.c                       | 10 ++--------
 target/i386/hvf/hvf.c                |  4 ++--
 target/i386/tcg/system/misc_helper.c |  4 ++--
 4 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/include/hw/i386/apic.h b/include/hw/i386/apic.h
index 871f1428885..6a0933f401c 100644
--- a/include/hw/i386/apic.h
+++ b/include/hw/i386/apic.h
@@ -19,8 +19,8 @@ void apic_sipi(APICCommonState *s);
 void apic_poll_irq(APICCommonState *s);
 void apic_designate_bsp(APICCommonState *s, bool bsp);
 int apic_get_highest_priority_irr(APICCommonState *s);
-int apic_msr_read(int index, uint64_t *val);
-int apic_msr_write(int index, uint64_t val);
+int apic_msr_read(APICCommonState *s, int index, uint64_t *val);
+int apic_msr_write(APICCommonState *s, int index, uint64_t val);
 bool is_x2apic_mode(APICCommonState *s);
 
 /* pc.c */
diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index cb35c80c75b..ba0eda39217 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -881,11 +881,8 @@ static uint64_t apic_mem_read(void *opaque, hwaddr addr, unsigned size)
     return val;
 }
 
-int apic_msr_read(int index, uint64_t *val)
+int apic_msr_read(APICCommonState *s, int index, uint64_t *val)
 {
-    APICCommonState *s;
-
-    s = cpu_get_current_apic();
     if (!s) {
         return -1;
     }
@@ -1079,11 +1076,8 @@ static void apic_mem_write(void *opaque, hwaddr addr, uint64_t val,
     apic_register_write(index, val);
 }
 
-int apic_msr_write(int index, uint64_t val)
+int apic_msr_write(APICCommonState *s, int index, uint64_t val)
 {
-    APICCommonState *s;
-
-    s = cpu_get_current_apic();
     if (!s) {
         return -1;
     }
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 8445cadecec..33f723a76a7 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -527,7 +527,7 @@ void hvf_simulate_rdmsr(CPUState *cs)
         int ret;
         int index = (uint32_t)env->regs[R_ECX] - MSR_APIC_START;
 
-        ret = apic_msr_read(index, &val);
+        ret = apic_msr_read(cpu->apic_state, index, &val);
         if (ret < 0) {
             x86_emul_raise_exception(env, EXCP0D_GPF, 0);
         }
@@ -638,7 +638,7 @@ void hvf_simulate_wrmsr(CPUState *cs)
         int ret;
         int index = (uint32_t)env->regs[R_ECX] - MSR_APIC_START;
 
-        ret = apic_msr_write(index, data);
+        ret = apic_msr_write(cpu->apic_state, index, data);
         if (ret < 0) {
             x86_emul_raise_exception(env, EXCP0D_GPF, 0);
         }
diff --git a/target/i386/tcg/system/misc_helper.c b/target/i386/tcg/system/misc_helper.c
index 9c3f5cc99b3..0c32424d36a 100644
--- a/target/i386/tcg/system/misc_helper.c
+++ b/target/i386/tcg/system/misc_helper.c
@@ -299,7 +299,7 @@ void helper_wrmsr(CPUX86State *env)
         int index = (uint32_t)env->regs[R_ECX] - MSR_APIC_START;
 
         bql_lock();
-        ret = apic_msr_write(index, val);
+        ret = apic_msr_write(env_archcpu(env)->apic_state, index, val);
         bql_unlock();
         if (ret < 0) {
             goto error;
@@ -477,7 +477,7 @@ void helper_rdmsr(CPUX86State *env)
         int index = (uint32_t)env->regs[R_ECX] - MSR_APIC_START;
 
         bql_lock();
-        ret = apic_msr_read(index, &val);
+        ret = apic_msr_read(x86_cpu->apic_state, index, &val);
         bql_unlock();
         if (ret < 0) {
             raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
-- 
2.51.0



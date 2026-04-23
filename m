Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6676FDEE2C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 17:06:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFxTv-0002vD-JO; Thu, 23 Apr 2026 13:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFxTi-0002Bj-NK
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 13:04:39 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFxTd-0005yd-Rk
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 13:04:38 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so112941725e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 10:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776963872; x=1777568672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MqoR8+5+ajlcuLd5JxwnxOpo8CeItjayYOK0zAMELiY=;
 b=PfafYJePD/a7VyyNmEGRgNb50P1rq7nFm5dt2k5vOXQh1U4j9Lizvz8DDRGEAvYwGP
 81V1PDiUrxsnnU1wjLzV1o7FmZAmfmrhyqulefN60ldFnih9IpKq5XVWXLvy0F1r7CPR
 9lM2XdU+OWZ3lYndqa9yyrsSuHJdv4HoY9EGBWB7Us9u9HPS3vCV9NZYjLj+oMnuoLSa
 BLsbLwnTzxSYXkVpnhLjxvc90D+zn0nhPTcuKaLiIIP2BLfCcrItZ7EY2J3VsL8yrwXq
 MXS4YI8JWy8Y7S0vneNaEdzJIEMwS8L21e6G6y6e8beSuixwywu6snVSCkJVNKMDNr5s
 nTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776963872; x=1777568672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MqoR8+5+ajlcuLd5JxwnxOpo8CeItjayYOK0zAMELiY=;
 b=lG7e+RaCXJpDbUggjXjzx61i47xKqnUo/L/hiSejRHJWqbSDlaYFSdeXQtyBHHp0mh
 oEDhnHPKBCS0ZvzzFIvU9N4LFiJPAk8HZ7fESKFB2MIEa/PWjrvYVj7/hgNpBybz9n0U
 3AfLPH+47GUCA3MrqhK27eLov+I68GZ10N2f4pMjb1IXIDVHhzWSf/RmQXDtykaYsOX3
 36r1Y7v0LmMB+qF48dLIubArNIu6SrqBgmHOcwd/0zyPy6nhc9X9h3ebWSAYHO7PNXYr
 1pz2kek2S+wSZvnrVUiSNP4zA3dodQ1SCNThM/FG7tOBb+sBT7qkWKuNvKLZH7t97PIo
 zljA==
X-Gm-Message-State: AOJu0YwGc8rgOQC11dINxOxYcza+Ey7NISWTZWGqE4bMb1pnydlpLPvu
 wvMDBrSxNNJ3XLeXbxoCxetXqUS9pI5GbuRP9GRpxDS2epOTO8ns3mtlT90xZEOymMhwflWQgur
 QWMy2Agc=
X-Gm-Gg: AeBDiev1OpjAcmHOsvyQb2joSjyJSMIyzklZOWIv9OWDz0UaIEW3mN7rtrJbV/MSoec
 wfxcGlGgM97omyN3v3X6YXE0K4I+JnmzACpHnGOvinSOptvm+h2uyAfv2g9ZDvKSVXla3kc/hUq
 v7Bk1ef+9xUkyU2mHOuA3Aj5+BgzKoanGk+dwr7+kl/86d/LRt0Akilft9stEhPBFefgUxyZPog
 TIwPcJYTvCW7cMi8x+lGw7F6xn72ZAS72bQYF7pWJHdz9bZGT3oKVbpWOENjksdQLOdTeDdcVqQ
 OPdAFS5/kHDbDN4+5yJV7awGeesYOMi6SKPhXS9dUxDi1vLILdoZzILrsrSDQkFQMK+4iT0ffXE
 Y8zGi9g5BQGWXa2LY4qxyfNgEoP+TBkft75uqiOWxPl6rkMZBtdVZPDtz8g7hlnZWsHusvfYAIC
 /6jUQaNdljoUC0eoKyn7lOQe4GZmKm4iyfwGLVENUc6b5MDC7x627FCy9i5sP78fqRv+xiE63l9
 1jv6EgticQ=
X-Received: by 2002:a05:600c:3110:b0:487:2439:b7be with SMTP id
 5b1f17b1804b1-488fb7389dfmr418371755e9.6.1776963871992; 
 Thu, 23 Apr 2026 10:04:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e44f69sm56847463f8f.25.2026.04.23.10.04.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 10:04:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 16/16] Reapply "target/arm/hvf: Sync CNTV_CTL_EL0 &
 CNTV_CVAL_EL0"
Date: Thu, 23 Apr 2026 19:02:28 +0200
Message-ID: <20260423170229.64655-17-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423170229.64655-1-philmd@linaro.org>
References: <20260423170229.64655-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

This reverts commit 28b0ed32b32c7e5094cf2f1ec9c0645c65fad2aa.

Still not working...

  **
  ERROR:../../target/arm/machine.c:1045:cpu_pre_load: assertion failed: (!cpu->cpreg_vmstate_indexes)
  Bail out! ERROR:../../target/arm/machine.c:1045:cpu_pre_load: assertion failed: (!cpu->cpreg_vmstate_indexes)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index a905d9bc370..01b2a904c3c 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -201,6 +201,9 @@ void hvf_arm_init_debug(void)
 #define SYSREG_PMCEID0_EL0    SYSREG(3, 3, 9, 12, 6)
 #define SYSREG_PMCEID1_EL0    SYSREG(3, 3, 9, 12, 7)
 #define SYSREG_PMCCNTR_EL0    SYSREG(3, 3, 9, 13, 0)
+
+#define SYSREG_CNTV_CTL_EL0   SYSREG(3, 3, 14, 3, 1)
+#define SYSREG_CNTV_CVAL_EL0  SYSREG(3, 3, 14, 3, 2)
 #define SYSREG_PMCCFILTR_EL0  SYSREG(3, 3, 14, 15, 7)
 
 #define SYSREG_ICC_AP0R0_EL1     SYSREG(3, 0, 12, 8, 4)
@@ -731,6 +734,40 @@ static bool hvf_sysreg_write_cp(CPUState *cpu, const char *cpname,
     return false;
 }
 
+static void hvf_arch_get_vtimer(CPUState *cpu)
+{
+    hv_return_t r;
+    uint64_t val;
+    bool b;
+
+    r = hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CVAL_EL0, &val);
+    assert_hvf_ok(r);
+    b = hvf_sysreg_write_cp(cpu, "VTimer", SYSREG_CNTV_CVAL_EL0, val);
+    assert(b);
+
+    r = hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CTL_EL0, &val);
+    assert_hvf_ok(r);
+    b = hvf_sysreg_write_cp(cpu, "VTimer", SYSREG_CNTV_CTL_EL0, val);
+    assert(b);
+}
+
+static void hvf_arch_put_vtimer(CPUState *cpu)
+{
+    hv_return_t r;
+    uint64_t val;
+    bool b;
+
+    b = hvf_sysreg_read_cp(cpu, "VTimer", SYSREG_CNTV_CVAL_EL0, &val);
+    assert(b);
+    r = hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CVAL_EL0, val);
+    assert_hvf_ok(r);
+
+    b = hvf_sysreg_read_cp(cpu, "VTimer", SYSREG_CNTV_CTL_EL0, &val);
+    assert(b);
+    r = hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CTL_EL0, val);
+    assert_hvf_ok(r);
+}
+
 int hvf_arch_get_registers(CPUState *cpu)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
@@ -767,6 +804,9 @@ int hvf_arch_get_registers(CPUState *cpu)
 
     ret = hv_vcpu_get_reg(cpu->accel->fd, HV_REG_CPSR, &val);
     assert_hvf_ok(ret);
+
+    hvf_arch_get_vtimer(cpu);
+
     pstate_write(env, val);
 
     for (i = 0, n = arm_cpu->cpreg_array_len; i < n; i++) {
@@ -929,6 +969,8 @@ int hvf_arch_put_registers(CPUState *cpu)
     ret = hv_vcpu_set_reg(cpu->accel->fd, HV_REG_CPSR, pstate_read(env));
     assert_hvf_ok(ret);
 
+    hvf_arch_put_vtimer(cpu);
+
     aarch64_save_sp(env, arm_current_el(env));
 
     assert(write_cpustate_to_list(arm_cpu, false));
-- 
2.53.0



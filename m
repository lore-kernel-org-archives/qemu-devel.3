Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC849CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 12:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBuXF-00016M-8T; Thu, 23 Oct 2025 08:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBuTz-0005HN-Qr
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:32:00 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBuTt-0008O9-EF
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:31:55 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-4270491e9easo529109f8f.2
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 05:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761222705; x=1761827505; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P9xBVWd6FRt+OGCLZ6nEzr4EP/14LH00UlqrogCUybs=;
 b=szpLmfg2FC2G7G+igeW45fL7idbOcuRAt1Pc3SO7bF6x7DShjORFITgZgnBX16E2nR
 UihLWS9qucJ+p+vKF0BeRPVk6hj4B/DpuUNsmhqlczO7kNV1J1bOYxzEILLJB+CheXLs
 vBrjIMByAmyOt3QV4ScXBdGaeF5tO6+3boD7VfFh/VKUF1MW8BlehrQ1ui7GSdlc97fR
 QF1aKMRrr0nhRgF9Tiu7J1BzGjI1yCcbijC4xlibIUdDoh9dWGv5XKVABgETOAYUkhVo
 XV3pzdf9zq0fFL5fc5+Z+t1zSqWupgR8B2MMygkG0ic7mc2UuUrVUjUEOl3j+Mb8x4y+
 mImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761222705; x=1761827505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P9xBVWd6FRt+OGCLZ6nEzr4EP/14LH00UlqrogCUybs=;
 b=JGPAD3dDR1j/Skw+xg/YoHOQ9Yiq9S8/nltgxqZS9tTRZOSO1tvam9pfEVvzdiiD6s
 5ZqlJmfjYTVTiGWM4/XEjqnBX1Oa3UNy1ULhM3aup7m6vGYDkmOC6q9Mg83NnJsmzfiX
 5/4PMzsYlPBI6ESp21z8EZLnZxEb4tfXz4XMMwcqjVXZ+0WwfFeO0DeQJhDpRfH+JI7y
 YY5+FtRuXdjKoWHSrDRqx86mRNrYbQ8itD7bWgWGgEmNRxrXqff/xyr5SaCV5Hhe9KAU
 7Cl1e886TONWZYXPPTXD+eBscUMCflSZj1yrT80M099hw6dKbaIDI7ECX+4jWyJFDHXu
 XzpQ==
X-Gm-Message-State: AOJu0YzGYNnIwS/Z9PWlRxMuoL9s4t1gtLoXhB2dCnYdjv8sV6HCih40
 +lVFAogs+51dhTQt4UQwubB+IIOFh8PuXS3iy76qQpkYrPOBQX0z6CjTuJC2gZbPqieWFh7vtIW
 IIkXNaSI=
X-Gm-Gg: ASbGncus+aWK+vOebWOvP7gjY7SN9jSz8aalVLgyMh6V3KWFdwGm7AOhhfdn4hkhC9F
 p1dneWPGgYdxHVfZGND5O3nle9VxIVyOmtf5U8/NT1oixsoZ8ktfh4t25eTyaWkaPTuaT6IpXjd
 oj2LMrWooOUDizPMWXSNHIUydLNdUaiTtQVcQmwHnwoVBVVe76fN4AUFHHQkwvY6oKWJ09gZQdW
 m04+S7UrXhvIAh4ScEF7mlcr1B5MzRdxiR0fhhlFln1Gt8cncfUWzwrUGXkoTaM7/62D+dj05PL
 H/6DPQ5BeJbMeaWkCzRgotcQRwrAwhTLZzwiQZhMLrYVkVtQ5EuZLC4BNtkYf/f6c416QBxDtr5
 Hd4w5wABapehSCZZ+N2CsNiYSPMJez4YcTZ05HmyWDS7oR5DqmiAcp+Tehts4K64gJKpBagicaK
 mpwED4GPVqU6cvYnU9FYRLJbfasCGAlVWVg0T7ph0cbT0P+AC+9g==
X-Google-Smtp-Source: AGHT+IFepACm3K4zjIZUTmac3W2rSbj15b968A/27aOp77LvhZzzmOLCvTNXq2XWyWm8tmCnMF9LEg==
X-Received: by 2002:a05:6000:428a:b0:428:3cd7:a336 with SMTP id
 ffacd0b85a97d-4283cd7a3a7mr14311255f8f.63.1761222705120; 
 Thu, 23 Oct 2025 05:31:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429897ff371sm3744166f8f.21.2025.10.23.05.31.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Oct 2025 05:31:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Cameron Esfahani <dirty@apple.com>
Subject: [PATCH v2 50/58] accel/hvf: Sync CNTV_CTL_EL0 & CNTV_CVAL_EL0
Date: Thu, 23 Oct 2025 14:31:34 +0200
Message-ID: <20251023123142.8062-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023114638.5667-1-philmd@linaro.org>
References: <20251023114638.5667-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 36fa67caf62..dbf6b83532d 100644
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
@@ -2009,13 +2012,49 @@ static int hvf_handle_vmexit(CPUState *cpu, hv_vcpu_exit_t *exit)
     return ret;
 }
 
+static void hvf_sync_vtimer_pre_exec(CPUState *cpu)
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
+static void hvf_sync_vtimer_post_exec(CPUState *cpu)
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
 void hvf_arch_cpu_synchronize_pre_exec(CPUState *cpu)
 {
+    hvf_sync_vtimer_pre_exec(cpu);
     flush_cpu_state(cpu);
 }
 
 void hvf_arch_cpu_synchronize_post_exec(CPUState *cpu)
 {
+    hvf_sync_vtimer_post_exec(cpu);
 }
 
 int hvf_arch_vcpu_exec(CPUState *cpu)
-- 
2.51.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73210D116EA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 08:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOuJp-0000nh-Qj; Fri, 28 Nov 2025 03:59:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1vOuJl-0000kS-7E
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 03:59:05 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1vOuJj-0001vW-Hb
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 03:59:04 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-bc4b952cc9dso1535730a12.3
 for <qemu-devel@nongnu.org>; Fri, 28 Nov 2025 00:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764320342; x=1764925142; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wA8ftR/kb1Oim39xcdfO7uzt5fZqUKGg2tRmo12HFOQ=;
 b=UxqIlDvsezxEzthqDDeeJ8rXAq6l+PnHrlMTRN/ySBbax1+DX/+H+A4DattxbxHpdA
 CSnu650hjVpN1BxNO+DRoIbRpjbzqbRB7qrUqOVcewZ7UurgoBP390ozabfacKM9bJpo
 mg8z36ZA2vgNIG/IWuP32Ai8qnT6F/bQmdquoK1YGI8mBKpbFQZSyLr1v6wCS6Zkplcm
 y+uu4hp/KbtSGhQHX/jSwHwRrv+1+aPXn47zavL7jVpaNWSUpbESAkbRk8YKSXAK3ZNJ
 cidRUUfAtTQOB/koO20helOF5LeX7zxfx+juJREr7KL0d3kaeyZ005i0sjxHZhibMSMo
 XUiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764320342; x=1764925142;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wA8ftR/kb1Oim39xcdfO7uzt5fZqUKGg2tRmo12HFOQ=;
 b=j1ko47ql4Oe5c82qiWQg2Ujh8kH1r0rEYEvm1w/FQGBBqxv3m/UW9fOk0J0Y40lcKP
 5GBZsnu0GaflNp1rT5C57a5EGIc718a7UGlpBDQ97uQ6vZPYeveS+ExF+IH8xh4ApL9v
 TYeXXG1JLHSfKFpUru5Yoi0cJDbO/TW8/tUyZtUo9b6hXBFp6AOh0khlNeUkUwpTCa04
 xoVKVvCB4P36Nvy5Hd4xCc3+yapw6BBWPRDp0dgdtCGGjYDTyohdeT04ymrhOWQ+HO0T
 EOpo1F8uypsc0n+UlZxCbsV6x08rxoA4WykIgY5qTvCkB/lQKLyoqv6xnidhtI7OiFhu
 2SBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZ4t/raS5Zy13DJTfEVhWqVFDFGuKKhjasNzgbKiP0aclAMxHKV4DA89D+48SrUyIHXjECvc8V+hAd@nongnu.org
X-Gm-Message-State: AOJu0Yxv00K7lV6vHhi+TuXVvNao6UxHBUN/83dq2WYX0RuxC5hj9aXk
 FepHANLCrcZClFkkUVKLgw6g6g+eKjc08VSBqTCyqXvCLxH8TvGkvIDC
X-Gm-Gg: ASbGnctcfHamJMWDVtlQPWjcVQ25VF3TS+y9pSRfcoSq9ela4matvdFtFGNKuyF4nm4
 LdoC97GRW6r38qv+AhTZZD3rA4oAkUiIlEf2H5j6k70ETVG2DvCUhUheaCEdHRgpRBUfjxatmDD
 sGbJ02s19wLgon5ykFsuSSl6kFVFNGdJK3nOnXahc/DVcYOTPbWQTwYyNsC3zx7d53JzZQk4iSK
 5mhDUuJFbREW03+a7CaP/Lh1dl8KXE7PBtXXL35yX+L5jfre+3H6e66Ch5uUOeBnyzNZlgxeAq8
 JZcwM99LEJPUSqInkLHPRoojpcJyD9a1/rVJfK3YcXGbvglslJPfiHvQYqn/ahTURp544al9YEh
 2V0eV2w5zZqPXamkQhrypwEe/wyLmD4jEX/cIQWopYNrgk2eeID1e8xoF+3ClHaPCrPnlF3Dya1
 2VWUGD2VZl3VLlzDjQwVztWO6rPD9ylEs3OclvnFKK4vZy+vDNnkl0
X-Google-Smtp-Source: AGHT+IH3p+0Vsp5qqiY2uhm7w2jM5eIR0sJw+9TU4oPQ0qyb6ZnutBBoHMLUAzdwhgxTq95ZnB2cTw==
X-Received: by 2002:a05:7300:818e:b0:2a4:6bb6:c84a with SMTP id
 5a478bee46e88-2a719536b13mr20049560eec.6.1764320341756; 
 Fri, 28 Nov 2025 00:59:01 -0800 (PST)
Received: from C02G720XMD6P.sg.corp.seagroup.com ([122.11.166.8])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-11dcb049cdesm16652511c88.8.2025.11.28.00.58.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 00:59:01 -0800 (PST)
From: phind.uet@gmail.com
To: philmd@linaro.org, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>
Cc: Nguyen Dinh Phi <phind.uet@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2] Fix i386 HVF compilation failures
Date: Fri, 28 Nov 2025 16:58:54 +0800
Message-ID: <20251128085854.53539-1-phind.uet@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=phind.uet@gmail.com; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Nguyen Dinh Phi <phind.uet@gmail.com>

Recent changes introduced build errors in the i386 HVF backend:

- ../accel/hvf/hvf-accel-ops.c:163:17: error: no member named 'guest_debug_enabled' in 'struct AccelCPUState'
  163 |     cpu->accel->guest_debug_enabled = false;

- ../accel/hvf/hvf-accel-ops.c:151:51
  error: no member named 'unblock_ipi_mask' in 'struct AccelCPUState'

- ../target/i386/hvf/hvf.c:736:5
  error: use of undeclared identifier 'rip'

- ../target/i386/hvf/hvf.c:737:5
  error: use of undeclared identifier 'env'

This patch corrects the field usage and move identifier to correct
function ensuring successful compilation of the i386 HVF backend.

These issues were caused by:

Fixes: 2ad756383e1b (“accel/hvf: Restrict ARM-specific fields of AccelCPUState”)
Fixes: 2a21c9244740 (“target/i386/hvf: Factor hvf_handle_vmexit() out”)

Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
---

V2:
  Move #ifdef to only cover the accel field
---
 accel/hvf/hvf-accel-ops.c | 5 +++--
 target/i386/hvf/hvf.c     | 6 ++----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 3e5feecd8a..54ead44ae6 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -148,10 +148,10 @@ static int hvf_init_vcpu(CPUState *cpu)
     sigact.sa_handler = dummy_signal;
     sigaction(SIG_IPI, &sigact, NULL);
 
+#ifdef __aarch64__
     pthread_sigmask(SIG_BLOCK, NULL, &cpu->accel->unblock_ipi_mask);
     sigdelset(&cpu->accel->unblock_ipi_mask, SIG_IPI);
 
-#ifdef __aarch64__
     r = hv_vcpu_create(&cpu->accel->fd,
                        (hv_vcpu_exit_t **)&cpu->accel->exit, NULL);
 #else
@@ -159,8 +159,9 @@ static int hvf_init_vcpu(CPUState *cpu)
 #endif
     assert_hvf_ok(r);
     cpu->vcpu_dirty = true;
-
+#ifdef __aarch64__
     cpu->accel->guest_debug_enabled = false;
+#endif
 
     return hvf_arch_init_vcpu(cpu);
 }
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 16febbac48..2023a7bfbb 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -728,7 +728,8 @@ static int hvf_handle_vmexit(CPUState *cpu)
     uint64_t exit_qual = rvmcs(cpu->accel->fd, VMCS_EXIT_QUALIFICATION);
     uint32_t ins_len = (uint32_t)rvmcs(cpu->accel->fd,
                                        VMCS_EXIT_INSTRUCTION_LENGTH);
-
+    CPUX86State *env = &x86_cpu->env;
+    uint64_t rip = 0;
     uint64_t idtvec_info = rvmcs(cpu->accel->fd, VMCS_IDT_VECTORING_INFO);
     int ret = 0;
 
@@ -966,10 +967,7 @@ static int hvf_handle_vmexit(CPUState *cpu)
 
 int hvf_arch_vcpu_exec(CPUState *cpu)
 {
-    X86CPU *x86_cpu = X86_CPU(cpu);
-    CPUX86State *env = &x86_cpu->env;
     int ret = 0;
-    uint64_t rip = 0;
 
     if (hvf_process_events(cpu)) {
         return EXCP_HLT;
-- 
2.50.1 (Apple Git-155)



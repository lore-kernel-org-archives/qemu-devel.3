Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B20D10F4D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 13:45:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOFpJ-0002Vk-1T; Wed, 26 Nov 2025 08:44:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOFp5-0002MF-6d
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 08:44:45 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOFp0-0000eu-9P
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 08:44:40 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4779aa4f928so55363225e9.1
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 05:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764164676; x=1764769476; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=opiub8bHokm5FkeSx/igEXrcRHxOwN8/+eMddbC16cs=;
 b=cQ01svm9W0oV507pMmFdOWlbDEm+Y8XhFlZoAGNiPur1i6s0dRqz7QXNG44b20SzQR
 WWkfo0xecU1HRI6sgqD/PubvUzdD667j2W2mY2OhINWQWbMXScaBIhZHlLEQKShfedvr
 Htc31RGqo+FZqEHXOH32mJU8BULZRvDVmGaiXq+D60+Vpik9/vwPZiQNkSBDFp/IVqt0
 B02pifwtgPi3UifveciBDlGUtT4/20yCPZjopTLyejgfRcYOzqWA0mx5SPgtKFn/p9dU
 imsfyNlNfR5kuTucYd/VWdgY0qFKPIezPb7YdHK3+DX4ZpTFTth49ujUTK/uzG5ZuMCP
 N72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764164676; x=1764769476;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=opiub8bHokm5FkeSx/igEXrcRHxOwN8/+eMddbC16cs=;
 b=ZSs/q0T8JB9b3HTGRQOqylUhuunp7FjUyomKfZJ343PGhImTlVbuysIGQyEU7YqVV8
 2WGSSNwK+VO+UMSANenp/uKrxU44rz4wrXo5QPZYzxS3YTkPj9nxXl1OF9aHpobsX5zE
 U7FwYKR2XuwixOtKQYmpaE8UlR7ujscWJx67+4G9muawjK7hDtKHF1JCje6S5TVC1N1u
 EaN5nwA7lrtKsK3oPoCr7HA/XnDx0tfUCnekIcHPBtReTqAOWuRjgZ2Yv8ICAxhFSmbN
 At3uucKHVzFP5H0BsCgzXLXbkfTQIIR8Bra365cR+/GHVWkhstKZYpveJLXtuK1Aq7m7
 le5g==
X-Gm-Message-State: AOJu0Yzm8OUcaG+W/OKTKpgKcRx+s/dy6OY5Cmj9oPL0uF3CuHreuIL5
 x2HMEWRTs8O3WRu96Jq7zasFVMYY/CMeAR740nrLBgbyRpIcA556cX5tA2qWzRhb6VvYX69s42w
 FWpXCVlk=
X-Gm-Gg: ASbGncs/GDN6qT8jZB8t4jQ3QmkIvBwq32guI/7Jjtie8MUa7ywCngFevzBIvOvqH5m
 gySZs/fVMkZ5R3RWxF52oM+GxHu4aopU4Meys0sniIeWsORxyoRDOZbWlnLGJUIN/wsKs7ZKWpJ
 wir7eHg3b+djoD6HXmsIEAcR7g8k7jkdcy3iLVHy+rTWwwSD0jc8qwquMHSLsNShStMAXkwamcP
 1CYG29LiIZ923un2fp5eGXfhhdGc8pjQQLyCIYgFb2GGnX7dwPgrQFaQjrOLKV0vDg/zrzKsetV
 KsbGPqP6EtxQrrUHsA/lxTbCfxgL3rEQ5NWT5bp7mKuPYELY1p5I537UJq9WKx9hHBPqW4YYmnv
 k0O/AkvpYJFHQIu24qecKcHvtK37sWPKbWRnjgPJE2J8bkrucrbH/RGXpnWEgxcdBX5Kp1QOppS
 TlysZuBFpcqDynXV2u5u7ZCGNBzGN6QKaHH0mM74PQsglBKw==
X-Google-Smtp-Source: AGHT+IFlEUSkVjYWrzoF/H17sSGosg+YvB4U7fgnsLLHm6YER2tSAKlnXy6cRQshcLeLKnkFkr96wA==
X-Received: by 2002:a05:600c:1c87:b0:477:98f7:2aec with SMTP id
 5b1f17b1804b1-47904acef12mr78375085e9.3.1764164676327; 
 Wed, 26 Nov 2025 05:44:36 -0800 (PST)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790b0c3a28sm46249025e9.9.2025.11.26.05.44.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 26 Nov 2025 05:44:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 Nguyen Dinh Phi <phind.uet@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.2 v2] accel/hvf: Fix i386 HVF compilation failures
Date: Wed, 26 Nov 2025 14:44:34 +0100
Message-ID: <20251126134434.14355-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[PMD: Keep setting vcpu_dirty on AArch64]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Superseeded: <20251126094601.56403-1-phind.uet@gmail.com>

Untested. Once tested, worth to apply as buildfix before tagging?
---
 accel/hvf/hvf-accel-ops.c | 5 ++---
 target/i386/hvf/hvf.c     | 6 ++----
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 3e5feecd8a7..e4c62522e10 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -148,10 +148,11 @@ static int hvf_init_vcpu(CPUState *cpu)
     sigact.sa_handler = dummy_signal;
     sigaction(SIG_IPI, &sigact, NULL);
 
+#ifdef __aarch64__
     pthread_sigmask(SIG_BLOCK, NULL, &cpu->accel->unblock_ipi_mask);
     sigdelset(&cpu->accel->unblock_ipi_mask, SIG_IPI);
+    cpu->accel->guest_debug_enabled = false;
 
-#ifdef __aarch64__
     r = hv_vcpu_create(&cpu->accel->fd,
                        (hv_vcpu_exit_t **)&cpu->accel->exit, NULL);
 #else
@@ -160,8 +161,6 @@ static int hvf_init_vcpu(CPUState *cpu)
     assert_hvf_ok(r);
     cpu->vcpu_dirty = true;
 
-    cpu->accel->guest_debug_enabled = false;
-
     return hvf_arch_init_vcpu(cpu);
 }
 
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 16febbac48f..2023a7bfbb0 100644
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
2.51.0



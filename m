Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5108FD1039A
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 09:47:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOC6o-0008Tb-NN; Wed, 26 Nov 2025 04:46:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1vOC6g-0008PP-MI
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 04:46:40 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1vOC6c-0000K6-Fk
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 04:46:35 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-298144fb9bcso72120295ad.0
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 01:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764150392; x=1764755192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HK/yrgSuo/WENJyaNy6OiL/V9KG0j/NfRPq/oqFoc+g=;
 b=SEZnw57wHt6ORelkj/VF0E0nx5L18Y1RKUhB9iQmGusV6C95LRpwW9vb1smExJ7DK8
 B7Zc8XnwTm+KJRD0Jpi0l10nG0eBuw9W6G8s9fW3pWSwqZaGpy9dNC3/qZtO8CQcnIoE
 vQZTnEPygN9MxuDlTK2fpKIM7eH0nPdMt22znDp5dkgXuLAr6omSp/vr6oO2WZUhZptr
 FjVfTYbxvNeliM8AJnmS9mwXU1CMSQqjblooXJgplSC9EQvs4+jSCjVwNovSoxgle9wS
 F1WDZpwXm9XVgnSTvXmBlNxKCfDOAaNpHbmvlVUynXkOWZ6DLWHItoJvv1SZz05Nq8hc
 Y0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764150392; x=1764755192;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HK/yrgSuo/WENJyaNy6OiL/V9KG0j/NfRPq/oqFoc+g=;
 b=Hbs+u83YFCqDqcwhMW52yK+1ZM53bC1MuC1LQDuTwupQ2NtCIPMaUfp4XOeqt3w08c
 fpysqe993s3TVJKyEvH0xv2TEL0lGtpozx8NmO5tHo8b5WXpHNf5eelhidZbig2JQi+3
 aHCyNTez89tlNeVsCla1BQXEQZxIrj4dk60Dz0hOAPRq39nrFALB26EW+9/4c3Ykp4Yg
 rFyaEGlwYCz6VUliTokvG9RSbWDOQOq7cIpVASBSCj9S4kPtd9O/yGUl6bcauFxppQ7k
 tEilpd8H6DmKgo6umzogUNuFBsmi5Ijglz+G4vLz9QMbedOXd2oiO8D4vN8YTQfoNwIt
 Jv5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSUgeq1brW0X5nFOUXUjNmvJsTyO0NSz7iakGq4whxGrcluCO9N7DxCrft+t2ExvJqxGBh5ut5glLc@nongnu.org
X-Gm-Message-State: AOJu0YzjHi7iuPf2np0y7rJoRuBKSRt/G3WGmc8rB6+6MKmD2bCP7si2
 2GDk5yHHS+lA+QMbNUOOgzvvLJAdczQ5FAJ711wvWVQLh8o9qeG7OGY5
X-Gm-Gg: ASbGncuHKsF1kkeDznS6HcCnyIe1G27p54GI2MTKTPQv3ljDlfrzGXV6HWc7FtbmCX8
 D65dG+jpT5oUtgsoU+WSAvXiJin7zdKEORFYmS+rLG9SQGmrR5un8hJX1EgmSWTvVhNdF2YQHir
 meox3J7HiPVeAbR6HJwNNcOU1ikLs3HOLvbJ7LswcLMtozAC7CysJx/BwiTcsvjWgLIAsZFbyA/
 3vuU2kOMzf/deFnB7h65qV3tzdK7duljY8IphJC1Z0/jGobNAiwpIAc4eLsSWOApkAVLbW9M9Uj
 7DYWfQJzel8AVpK3V5uJ9lZCU3UrdXHJ+AbyLwHIoSU7BOx1PWKKqUmCkPDnGsHgSI65KCKBeGg
 V+lgsvrefW9sBQWDM6Wkd/axBX89e6HC5U+IT082DVU8tBJfehSxDo8EV6/NtY3UWHqXKOBlR7+
 ZAAAFWg++jwOTEQMUUnsivhitcUv08dHIuPyKn2J3QlKxm7PLEKltrk7Zhf4v3x2A=
X-Google-Smtp-Source: AGHT+IH9qvZa4TyMZ7apxLmz9BlLEW+XeeFrfJZRJIT6pwmtnehIpCjZfz9xnGU5WWaQXvjgpkGK+Q==
X-Received: by 2002:a17:903:2a90:b0:295:2d76:72fe with SMTP id
 d9443c01a7336-29bab1949f0mr72595085ad.45.1764150391564; 
 Wed, 26 Nov 2025 01:46:31 -0800 (PST)
Received: from C02G720XMD6P.sg.corp.seagroup.com ([122.11.166.8])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-bd760fafe57sm18780627a12.33.2025.11.26.01.46.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 01:46:31 -0800 (PST)
From: phind.uet@gmail.com
To: Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>
Cc: Nguyen Dinh Phi <phind.uet@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] Fix i386 HVF compilation failures
Date: Wed, 26 Nov 2025 17:46:01 +0800
Message-ID: <20251126094601.56403-1-phind.uet@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=phind.uet@gmail.com; helo=mail-pl1-x62d.google.com
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
 accel/hvf/hvf-accel-ops.c | 5 +++--
 target/i386/hvf/hvf.c     | 6 ++----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 3e5feecd8a..e2cb8f202b 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -148,19 +148,20 @@ static int hvf_init_vcpu(CPUState *cpu)
     sigact.sa_handler = dummy_signal;
     sigaction(SIG_IPI, &sigact, NULL);
 
+#ifdef __aarch64__
     pthread_sigmask(SIG_BLOCK, NULL, &cpu->accel->unblock_ipi_mask);
     sigdelset(&cpu->accel->unblock_ipi_mask, SIG_IPI);
 
-#ifdef __aarch64__
     r = hv_vcpu_create(&cpu->accel->fd,
                        (hv_vcpu_exit_t **)&cpu->accel->exit, NULL);
 #else
     r = hv_vcpu_create(&cpu->accel->fd, HV_VCPU_DEFAULT);
 #endif
     assert_hvf_ok(r);
+#ifdef __aarch64__
     cpu->vcpu_dirty = true;
-
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



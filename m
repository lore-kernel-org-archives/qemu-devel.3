Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED3AC8303C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:00:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2dq-0007Sd-6Y; Wed, 02 Jul 2025 14:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2de-0006xJ-63
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:56:59 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2db-0002Yi-FU
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:56:57 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-450ccda1a6eso38531705e9.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482612; x=1752087412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Nod2XnKcLFCGDw4Al66TFSscA1L5ljopnzhztAklYo=;
 b=JQnfOcsE1xtTL7AX33fllG+eKj942+nHD2cjbJwQCmYSURDNAfzN817IFu0G/ZcQa8
 CCroNL93fK7KXQbc3JRZIa4MuGJSS7QWZNzCQ47t4mtJbVD/8pe7wcCM59VNIBef2jPn
 4oyYi7L5ZfE0WPQRQEl5u1X+kt7yFQdDxl/vzy2h706STMC68uEzdCTuV66P7AcACq1K
 p1cJW9/91P1/ZfIOCxqym7v+5jPv2SfTR7OFxAhinB7oie1IOgE+xS5wfBnV+IdoM9N4
 kOSLTvgcvdr3183BQAeIoASazXKjDKlz2Y84NSabZ0xEWWYhWh+YlbDVbel/osT0Kfby
 KkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482612; x=1752087412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Nod2XnKcLFCGDw4Al66TFSscA1L5ljopnzhztAklYo=;
 b=tAUQvepADqrT7ZRK1HL4nX7sn+sNC036WArt1+v07/6pAV2fy+jvmN8S5f5J0UqKDu
 8V/Va1hyX0wACyI/wboPQ0H1CKzDWOkiEpSNpSyirGrIZFuz05ih68EF2MilB7gbOs4D
 ulubqjrHQpFdCHFXSoqL2GdDTEyQTuItVfvsVMiKsZ+0oZpxP3gPZAJpm/dRbYCrbsYP
 rl3RhL36RIn3/ORvsqh9mllL2EU9ReBquvDbysAJy3QHF/xkOQN7hCGQqIgKIiyRRgyj
 LvDuJ5Luon2gzPoF4uecmAQLo0u+sOYct5Nye6Tr+RrpxeaHw55GclrlNx0ik+Rcfi/q
 AY8Q==
X-Gm-Message-State: AOJu0YznkD07+8bAuORoCyGFSNFqJZ70bI3PBj1hXk4EedQ8cIpXbjhq
 znPp/Y7X0//xcS6u/mq2Hwx0aG7eut+15Aj0d2jucMLUPIR3pXHGryEvhDYIf0Rl6mV18mW57vw
 k6P+C
X-Gm-Gg: ASbGncs9swF6r3/TyBymI1OWFlwZz3lxCavfkYN4EG6KrF0b9jYFIhpXlNs0ulsmZaV
 GhqTBnLDIuRa9P0nB7qf8oXnbcVOaPwLpFkivkHyLOzH4aYKxG7acCg5+dEmf6Fes2nglugMK6b
 BIpZJt7bUx0QYSGItbzihcVSReE7/5vbyjOT01tuONWZg6qe0p55MwdzJGOpfHHIdlMONVSqkhX
 1LUoYGs7IVgG1qRVT42kVpNyb71sHG0+2EMLJMRVHL60ZjACEQ7bTfGAq+wJDawkvdvR6T0lUnH
 0usXFG/2QaH4bT/ZB4isHQNWU+5SQMPasJBaboB8Evg1zApEZB6DGFExMRHUBkXj9olpO3Ccrcn
 4W2nCA/EX5tdyYE3vmWLhmen2PalYgJCLqL6NN5tfH+JAzRM=
X-Google-Smtp-Source: AGHT+IFZ8fHigbRG8FdijhO/T1f62xW3/hEUWdHkiy02kTJS3wIyp67PHyXo2QHSx1jrj+guibRCDg==
X-Received: by 2002:a05:600c:1c16:b0:43c:ea36:9840 with SMTP id
 5b1f17b1804b1-454a9c9e5fdmr7457655e9.22.1751482612197; 
 Wed, 02 Jul 2025 11:56:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a997e367sm5682865e9.15.2025.07.02.11.56.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:56:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH v4 27/65] accel/hvf: Implement get_vcpu_stats()
Date: Wed,  2 Jul 2025 20:52:49 +0200
Message-ID: <20250702185332.43650-28-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/hvf/hvf-accel-ops.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index e7f40888c26..c07ebf8a652 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -358,6 +358,12 @@ static inline int hvf_gdbstub_sstep_flags(AccelState *as)
     return SSTEP_ENABLE | SSTEP_NOIRQ;
 }
 
+static void do_hvf_get_vcpu_exec_time(CPUState *cpu, run_on_cpu_data arg)
+{
+    int r = hv_vcpu_get_exec_time(cpu->accel->fd, arg.host_ptr);
+    assert_hvf_ok(r);
+}
+
 static void hvf_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
@@ -583,6 +589,16 @@ static void hvf_remove_all_breakpoints(CPUState *cpu)
     }
 }
 
+static void hvf_get_vcpu_stats(CPUState *cpu, GString *buf)
+{
+    uint64_t time_us; /* units of mach_absolute_time() */
+
+    run_on_cpu(cpu, do_hvf_get_vcpu_exec_time, RUN_ON_CPU_HOST_PTR(&time_us));
+
+    g_string_append_printf(buf, "HVF cumulative execution time: %llu.%.3llus\n",
+                                time_us / 1000000, (time_us % 1000000) / 1000);
+}
+
 static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
@@ -601,7 +617,10 @@ static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->remove_breakpoint = hvf_remove_breakpoint;
     ops->remove_all_breakpoints = hvf_remove_all_breakpoints;
     ops->update_guest_debug = hvf_update_guest_debug;
+
+    ops->get_vcpu_stats = hvf_get_vcpu_stats;
 };
+
 static const TypeInfo hvf_accel_ops_type = {
     .name = ACCEL_OPS_NAME("hvf"),
 
-- 
2.49.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC75D58D42
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 13:22:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFZ1O-0002Ov-1w; Mon, 25 Nov 2024 08:20:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tFZ1M-0002OU-PD; Mon, 25 Nov 2024 08:20:56 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tFZ1L-0005mc-2M; Mon, 25 Nov 2024 08:20:56 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7f450f7f11dso3127345a12.2; 
 Mon, 25 Nov 2024 05:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732540853; x=1733145653; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sqaNHjbs+zjnDOYMt7ANdJoaQkZJVs438F2kZ6VrU3M=;
 b=fYd5Y32KfzO36uxE+H9xXGTrBlTsNRyvS01aB/eGES+KNiGzqQwixbAqchVLvqbtsM
 01MLgQv/Jii/BbRaU3XQeOSMU0i8Nyvtdg+geaEMWmvQq173HqUKXzf0yH4SV9RcnM3i
 k1Zne0pNj1afp6t6Lgeo7li8qM51GaLRAqHAwEE5Q5hfsTUhR2os1UQQxjEilAinhjsO
 BsbONoLQxf7clY1iJYXjMVQ6Ezy83vmtd6b6jmqX83XlkDm/RMLbMcHitH1rNV0ANrTC
 FuLjKmRruWSAPWIOIpLeB610aOh6719NrF9JUnl/oxsUhUzMM2frTs+MlQmw2Mf+PxwN
 TSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732540853; x=1733145653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sqaNHjbs+zjnDOYMt7ANdJoaQkZJVs438F2kZ6VrU3M=;
 b=FfJWnqdcQgqKy1ZiuR6gtHkyLNZp9n+KSe7T88xECJbQITMeXnI7OnTMZO178GHdEi
 2kkjK4DSk63D/jgaV5kDxFMhcDjufpi3ltxuBq0OD86OECABE83MtiKlbRDQu+BACbgm
 aOyl+GbIc8Du/bpPsoO6ph/3lASH4/P/kfKf0iQE/Em4DxhqIbARQlzKlCMitElOU5eq
 Q3aJHfCaxKSQkkmI+Z9+ppMBK4PAAs6Bx6xclzK/kmtHHhHypcbd4ucyNxOcSLmzjSyz
 5hoxIeBmPyqXj35TTaIuqY8iRfVlM3xr8sZ1lINLYF1i3/dMzCccakTzYVGBCj3fpNDa
 laTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDCCEGhRdYGiMKRnnG626rw5v9VPgqnXUB0jDMhUv8wpSNGAQa2IWzVn3/lcFyKIfqCyL0YZljoRA6@nongnu.org
X-Gm-Message-State: AOJu0YxOpoqbt6cbTUEJb+hQCVXj4eYcBFLZBzcaQuklqV8sI4i6ejuK
 un/aj8xZYlhhkhcdPL7DtU6lDR6KVGyqw0NNTWPApVmUvuQJJwIX7C/+0w==
X-Gm-Gg: ASbGncvYnswW9FrStgkOXeRc28X6efo11QwUgXB6SO8SFU/nhiVAW745pbrKhxYz9Hs
 8T5vSSbqQRPajj9bNifmXZjW4+il458VAzlm7WMlhAuZISL309dbZOZP0jV74GPOzY7WXu5IgV/
 sInd6koV0kg2Gf8Odus999zwuzRBkMhxoeEeoEvTY0chStB6TJ4YZy4jq1iIZMxeeUMAE3U5q5A
 5C0fQcdAwSnt8n7WyH9CmSP4v9uR5S8GFUHzzKmc5GtkERMDO636ZevGjYQHIexxv9Nc28q5Qh4
 MICsjw==
X-Google-Smtp-Source: AGHT+IF0McQZgADLLRMWhG0XKnaFEtO23s/RHEpP29nmkbGXLoZutu92EFDWzyw1zIsL3ZsLAHAiiQ==
X-Received: by 2002:a05:6a21:3395:b0:1e0:d104:4dbd with SMTP id
 adf61e73a8af0-1e0d1044ea9mr2101319637.46.1732540852809; 
 Mon, 25 Nov 2024 05:20:52 -0800 (PST)
Received: from wheely.local0.net (124-171-72-210.tpgi.com.au. [124.171.72.210])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fbcc1e44d5sm5616721a12.32.2024.11.25.05.20.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 05:20:52 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Chalapathi V <chalapathi.v@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>
Subject: [PATCH 1/4] target/ppc: Fix non-maskable interrupt while halted
Date: Mon, 25 Nov 2024 23:20:38 +1000
Message-ID: <20241125132042.325734-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241125132042.325734-1-npiggin@gmail.com>
References: <20241125132042.325734-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x532.google.com
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

The ppc (pnv and spapr) NMI injection code does not go through the
asynchronous interrupt path and set a bit in env->pending_interrupts
and raise an interrupt request that the cpu_exec() loop can see.
Instead it injects the exception directly into registers.

This can lead to cpu_exec() missing that the thread has work to do,
if a NMI is injected while it was idle.

Fix this by clearing halted when injecting the interrupt. Probably
NMI injection should be reworked to use the interrupt request interface,
but this seems to work as a minimal fix.

Fixes: 3431648272d3 ("spapr: Add support for new NMI interface")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 70daa5076a..9f811af0a4 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -2495,10 +2495,16 @@ static void ppc_deliver_interrupt(CPUPPCState *env, int interrupt)
     }
 }
 
+/*
+ * system reset is not delivered via normal irq method, so have to set
+ * halted = 0 to resume CPU running if it was halted. Possibly we should
+ * move it over to using PPC_INTERRUPT_RESET rather than async_run_on_cpu.
+ */
 void ppc_cpu_do_system_reset(CPUState *cs)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
 
+    cs->halted = 0;
     powerpc_excp(cpu, POWERPC_EXCP_RESET);
 }
 
@@ -2520,6 +2526,7 @@ void ppc_cpu_do_fwnmi_machine_check(CPUState *cs, target_ulong vector)
 
     /* Anything for nested required here? MSR[HV] bit? */
 
+    cs->halted = 0;
     powerpc_set_excp_state(cpu, vector, msr);
 }
 
-- 
2.45.2



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB89D65530
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 17:13:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFz7d-000771-82; Tue, 26 Nov 2024 12:13:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tFz7V-00075c-OO; Tue, 26 Nov 2024 12:13:02 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tFz7S-0004GF-TZ; Tue, 26 Nov 2024 12:13:00 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21288d3b387so44430925ad.1; 
 Tue, 26 Nov 2024 09:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732641177; x=1733245977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MFwnfpRE5s9kBlFwkAN4WzmxhF94qqxmX+Vft12AREU=;
 b=h0IZs1PPOOrj3TgDeWUxKs6f0XTMgMLt0f/OIysoSpvSA6/LrdkiPWSHUVk9OLXIkI
 ixtNNN0SBPZ8fKgbTCwgPJ0YPmkeKMAKyfR2HGEzZQwxf9St9hqjmSBN2vpvQsIIj2d5
 D2b5dA27a8HggHwajsowiyLduyAGpJwJZ7TcogvnbbeUzK1rBfJvJ2V7YMkCZdnVHFcT
 o/6wHusNAfGmv9Fz0MduQSrN9F97yVdc6VbakpUXGgXByweVMV0KwOaapEoetFyjCF0O
 WIDB84L+fXQ29N8YgH5wjvxWonngDDxA3KDKITn+DC9SMr8UbWJDRsoLEvukaZAbNbGH
 Dnug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732641177; x=1733245977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MFwnfpRE5s9kBlFwkAN4WzmxhF94qqxmX+Vft12AREU=;
 b=cNQbAQ5u3alTU05D8EHkdW1DUx46sa+tB9fa2n3q6zHn8b+qhXaqlMwvaXrrHJyEES
 pCIWh2aFrYpQbBoc5J2H3+bRQAIXb8YDRoadprakooInvUS2ygCVKqbg12nKCyYmRBRL
 WBnMBPf1fFMAoSdThKRqo0QGNHZ16zzsH4ac6MRIkl5DNRwq9148Iiyndlw6sJp1uFQY
 Ez0f+qfBEhDKTkFo/BUXXA2Gzkgf0d4wdCVWihZY3OyMJHj7hAwxDR5bcByckyELLZdt
 +EvMQVj8xoF84Kberj4FRyHPNKiDdxmlPme312arsknj3ViOap7GUo1KNsKJUMLuWew1
 jxQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBfqQV65BHLhbPO3dVS3l4jkLzADldVf4C4C016YDA1ZggdGTnzA8229Twg9HxZr8n4u+iwqBhrQ==@nongnu.org
X-Gm-Message-State: AOJu0Yyvt3Pom3P1DABzZLwyr2ZZgcRqVUKJhmGK11FeRmvAncVyr9aP
 MsYiUxUqmWlZlAw7Vw4V8Fh6ZltxPqG+3uVoD4c3Dz2SKVJHkK5DNnnofQ==
X-Gm-Gg: ASbGncvxE4PMO7tilDP0nUStD346ISqiP/GfKgXxDZL76PSDQvmnm6WYqkfonjiW2cq
 U8B1+4jB/WcTDmubCUebhJYm7bhyZhV3ziaJvjNVknLRSWjl4gYfafGhOIAkJmKhJ2C3Ta4k4rr
 9vyoh451VGM1sHtxIdW7LcEBX7vtvSNRgtIqxiTqBqPHcJzIeJtR2sCaMRIdf42jqr3mZ9k48s8
 pfUXxyzOcdZ3n4u9EvcVRLAFs5YfWFIm8TZVuhetA35Ur4FBXzamQ9mF4leE84btP/qgnXTmmBF
 iB3QIw==
X-Google-Smtp-Source: AGHT+IHlI/Nru3XV0Pdq5Am+g0v8Xht1j7PQIAUZNF8cyeySgX8UHtb9kZTqoYNl164ZV6XKe+Kslg==
X-Received: by 2002:a17:902:e84f:b0:20e:5777:1b83 with SMTP id
 d9443c01a7336-2129f5e9444mr309502725ad.24.1732641176691; 
 Tue, 26 Nov 2024 09:12:56 -0800 (PST)
Received: from wheely.local0.net (124-171-72-210.tpgi.com.au. [124.171.72.210])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129dc21c28sm87321175ad.246.2024.11.26.09.12.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 09:12:56 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Glenn Miles <milesg@linux.ibm.com>
Subject: [PULL 1/6] target/ppc: Fix non-maskable interrupt while halted
Date: Wed, 27 Nov 2024 03:12:30 +1000
Message-ID: <20241126171235.362916-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241126171235.362916-1-npiggin@gmail.com>
References: <20241126171235.362916-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
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
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
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



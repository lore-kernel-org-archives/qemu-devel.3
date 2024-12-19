Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE9D1E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 03:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO7PF-00075E-VI; Wed, 18 Dec 2024 22:40:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tO7PD-00074w-3h; Wed, 18 Dec 2024 22:40:55 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tO7PB-0004Id-Kp; Wed, 18 Dec 2024 22:40:54 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21644aca3a0so3872185ad.3; 
 Wed, 18 Dec 2024 19:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734579651; x=1735184451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zBCJnxrt9+FDevqEKtofQsJcdCi8uOcbq538B+v/z+s=;
 b=Pvp8JsgV1jhq+2f1FWoxb/XbRjLczR3GSWsgJYwbvIFbPbZoIqvFEDEj0QfIpJxngg
 Z91D9dojK7d+f2Xt82v9OLELMGfd6btLLT9IX9vee2jeOinus/52JELtFFID2anUsB8A
 r8lZlCily01lKMwpuRHIj4NNZqjY5enE7O7lfaoIMGVojuxd3zCqzGVqyq00AV9uaSn1
 iuBxigm/liVfN5/00CD/xFPppPegUYvDucIoSzKVWVY4dxLI7m31m8Wju/JgwzLltvaP
 zh3GqkQ0nW2c5hbYJCHFvQyUotW6guRzG4l/aPOVYXVUFFjOH8s9855uG50B37OQst+W
 sZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734579651; x=1735184451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zBCJnxrt9+FDevqEKtofQsJcdCi8uOcbq538B+v/z+s=;
 b=AZHMn6MStqFrsEDnt8KXYdWHPSKxg1TDM2afzcfAQ9OZnGyv6XB1hY7o/TjolA8ej8
 kfofFpuPJdGNyj+7iOY6AOVFWOPyZVTwgzFwNXjQ6Lbbasy6pJgFnV9Dsv9OP5ywHNR2
 S3o6MBPJ5J3ZSDMjFV/jYMxtzopSYFrJ1xXL5/pBIxEhILwjtU9m6BGAzoh2pwJC7vkm
 tl0vr24He2TYite/5tm76uPX/ce8vHbcwooTXji1TxNTSjhyQlIjNm2GTg910CnzaHCT
 1UVsh/iKr6FHmmS46ZUkXqyYrRLo5+pvHhsF70XU1/3GZ6tcGu4Vos1JPIaKtK/wwOUc
 8LcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX63kWYSC0dxP75ODTTCK9tTuqucclryWq0AX1RKDwsp1pO1OBPdNqLKsyJfUb2OX7Ej2CQ6BjJJVvD@nongnu.org
X-Gm-Message-State: AOJu0YwtDBWP8D75OibeGU4zIy+ITzmyUf7wl8d6aQNGbyR5rBJX2QAR
 WrbnoXDMNInfx51uG1oeh8w4jtFz+/WyHTjmsbOQiRzZe+qNe80vLS2B8A==
X-Gm-Gg: ASbGnct1StQP0TEEBCtCXMFCFOcWrCeM62E7eI+tqWRmyxmuy2ktYUnLPIQWM7wvsGq
 ft8gZQVHFombVgiQERecvM1F9yGCIXd8iOUI1YuzKeXhqp4FVGDioluqCMK5uuU1l+kzQpmJk0s
 JUgc8N26B247hMJgIF3cdcbBG9EnVjriaHpLXZdr1S+tf7Zwjn3k2P6uRB22s8vbckAZuNlLC/7
 TOYlwgGdJl1wyir0gMkwwLJf98ZvS2OxK0n1J7hGFT7ZMRsgVISLL8lvVkGb8h0fs6l0wd8xkOo
 fLYNLMsPAg==
X-Google-Smtp-Source: AGHT+IH5eQF7myZlAt9nZCuaVN975lEjTetbEhkahQ07N+9tQX6lQiH999/pfejp/Ri7CRb1+Mp3iA==
X-Received: by 2002:a17:902:e881:b0:216:2d42:2e05 with SMTP id
 d9443c01a7336-219d9672024mr33052425ad.22.1734579651416; 
 Wed, 18 Dec 2024 19:40:51 -0800 (PST)
Received: from wheely.local0.net (14-200-18-130.tpgi.com.au. [14.200.18.130])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc970520sm2881595ad.75.2024.12.18.19.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 19:40:51 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 3/5] spapr: Generate random HASHPKEYR for spapr machines
Date: Thu, 19 Dec 2024 13:40:33 +1000
Message-ID: <20241219034035.1826173-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241219034035.1826173-1-npiggin@gmail.com>
References: <20241219034035.1826173-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x635.google.com
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

The hypervisor is expected to create a value for the HASHPKEY SPR for
each partition. Currently it uses zero for all partitions, use a
random number instead, which in theory might make kernel ROP protection
more secure.

Signed-of-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ppc/spapr.h  | 1 +
 hw/ppc/spapr.c          | 3 +++
 hw/ppc/spapr_cpu_core.c | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index af4aa1cb0fb..db44893689b 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -201,6 +201,7 @@ struct SpaprMachineState {
     uint32_t fdt_initial_size;
     void *fdt_blob;
     uint8_t fdt_rng_seed[32];
+    uint64_t hashpkey_val;
     long kernel_size;
     bool kernel_le;
     uint64_t kernel_addr;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index fa05e0c5156..34934afd551 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2888,6 +2888,9 @@ static void spapr_machine_init(MachineState *machine)
         spapr_ovec_set(spapr->ov5, OV5_XIVE_EXPLOIT);
     }
 
+    qemu_guest_getrandom_nofail(&spapr->hashpkey_val,
+                                sizeof(spapr->hashpkey_val));
+
     /* init CPUs */
     spapr_init_cpus(spapr);
 
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 88d743a3c3f..bf9f29f4ff3 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -273,6 +273,8 @@ static bool spapr_realize_vcpu(PowerPCCPU *cpu, SpaprMachineState *spapr,
     env->spr_cb[SPR_PIR].default_value = cs->cpu_index;
     env->spr_cb[SPR_TIR].default_value = thread_index;
 
+    env->spr_cb[SPR_HASHPKEYR].default_value = spapr->hashpkey_val;
+
     cpu_ppc_set_1lpar(cpu);
 
     /* Set time-base frequency to 512 MHz. vhyp must be set first. */
-- 
2.45.2



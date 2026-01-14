Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98586D31A0E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 04:52:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfspB-0007j9-7K; Tue, 13 Jan 2026 23:49:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfsos-0007Co-61
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:49:27 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfsoq-0004Bx-KX
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:49:21 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2a0f3f74587so61242375ad.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 20:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768366159; x=1768970959; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rNzsJq6kudxVf3nVXDeExz5WeTdkRECgPvPbcRQeMNU=;
 b=BbYH36/2crQkwit/3DXSz1vilxz9aQqtMMkqliAhfFk7FmheG1VYLxbFsqCZeD/NqH
 UIV4kvxX1f7v48OV4Yb9L4s/F42WD3C/TI9MLu76QZNm0tos9TIOpqZiUJC9TOX+IkFR
 Os9tYpGmjOZ4dWn3qMH8oo+2T3fKeLksDp1sfPbRBnFnHNss+c95q1188yIEM9SL4OCJ
 XDr2ZHJQWfDAlcXKtrjjZtYRk4x4qrJSGX9dCxQ+Yr7Mfu+v/JnxYahDCQ8F0pf0GON/
 3RFkdnPvb31atKRBaJBPSS10d3kh8tFGGCNrAQN98hRAEJJiPfqK6+i/Na5bqumVtJAW
 Bs6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768366159; x=1768970959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rNzsJq6kudxVf3nVXDeExz5WeTdkRECgPvPbcRQeMNU=;
 b=LtlCEzGT1OhHmGnVGn2h3PVofulXVJnBNQKd21Xn1Ezz2p0sJu+y35U16Rei7UzaEl
 oOq96gNMG5DSjFHJCbtABK8KdUqZAdlFvoDvzJ/RRf3VTVZuO4aWmXHRYrUNzCA9fnqJ
 seaOopKf3e6KZtTO/clSsX834Pz4/t4o3NYr8dAo/CHSjM67a3ej8F9fsDbdMA/uoJs4
 A9Lhc9Cp2qcuNFc5ZC4k7AQg9xxlf1RaZta+lXJ71iqHuGRsvEjG7LHRE0ulbb8NqNiR
 7jeAvMNfLiZ56H2IxRbFZKMIus+DjRmERiVovhHq0NkiPdrxkG95DFUULSlht97n1QWr
 AcgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfhVs3ohfVOd+tfeRSB2L2VMOjwnGrIIbfw0EzWR94HnbhF1I+DyrSVzf2sBXBxjasI5aIlWiRgmo6@nongnu.org
X-Gm-Message-State: AOJu0YyRJKntD9/yP3aXmipPjToIZ78eBYRU6oGK7a+6cZMVMAhHuOP9
 Dsfp9I1eNZZbn4CRTtjGfDLNG8y8qnDdKdjpy+OGluoK8lRnTWYL5naZ0bUY1A==
X-Gm-Gg: AY/fxX5WiZX/RCd+EzjVYPmRblq0MVNCuuC9yvx7KPoU0ZDwJ0J9iD6G8E4DDRRMiMj
 riVzwlD6pJF0Y6GwPDImlQJ8n7RxgDHokE7jsHqwBrHKrZnPT1Y1piBEFZij8hCKPuJlOeGgJ/a
 MSbLUPvzgAD0OqoF/x15FpASuHARe9J9U0t7UVaPffdi9WGZPVSWtfv6/KrqyMJEdn280/Nzh2R
 FTWy3raeYgcaKdjB7MFm67oVMohtFrGnrJusU2NU/ovSN9gnGtBuk5sS1xHcGVNPpV/lyje6ZXr
 t0NPLEy0e2GmL0PMsDcIdZze3LhK6Yj0HpnhLTQloBIRKMfdXgtXsglK9I4a9QRT230EjlQHxb4
 r8DH+ETc+fV9cmTeiS86WPHxqn6lZygn29pwMIT27H5YbbJ2KuUYYb3RKSEz01xSxr6CWxQ7dyY
 n5onKtAOZPUtExuJc9+xVGmsLfQCnMFPEqQjjyGKo9TeO8SRmbiXQQ7a+E5No=
X-Received: by 2002:a17:902:ce91:b0:29f:e787:2b9b with SMTP id
 d9443c01a7336-2a599e47481mr13685485ad.41.1768366159235; 
 Tue, 13 Jan 2026 20:49:19 -0800 (PST)
Received: from lima-default (123.253.188.110.qld.leaptel.network.
 [123.253.188.110]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c49037sm216111905ad.36.2026.01.13.20.49.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 20:49:18 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, bin.meng@windriver.com,
 vivahavey@gmail.com, Alvin Chang <alvinga@andestech.com>,
 Yu-Ming Chang <yumin686@andestech.com>, Joel Stanley <joel@jms.id.au>
Subject: [RFC PATCH 23/25] target/riscv/debug: Support heterogeneous mcontrol
 access types
Date: Wed, 14 Jan 2026 14:46:56 +1000
Message-ID: <20260114044701.1173347-24-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114044701.1173347-1-npiggin@gmail.com>
References: <20260114044701.1173347-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
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

Similarly to the last patch, mcontrol/mcontrol6 trigger types may
not implement the same read/write/execute match capability. Add
configuration to describe what access type matches are supported.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/riscv/cpu.c   |  1 +
 target/riscv/debug.c | 26 ++++++++++++++++++++------
 target/riscv/debug.h |  1 +
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5708da5054..d349457c87 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2967,6 +2967,7 @@ static const RISCVSdtrigConfig default_sdtrig_config = {
                          (1 << TRIGGER_TYPE_AD_MATCH6) |
                          (1 << TRIGGER_TYPE_INST_CNT) |
                          (1 << TRIGGER_TYPE_UNAVAIL),
+            .mcontrol_rwx_mask = 0x7, /* WP/BP */
         },
     },
 };
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index e8d343bf42..d7c171736f 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -449,7 +449,11 @@ static inline bool type2_breakpoint_enabled(target_ulong ctrl)
 static target_ulong type2_mcontrol_validate(CPURISCVState *env,
                                             target_ulong ctrl)
 {
+    CPUState *cs = env_cpu(env);
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cs);
+    target_ulong index = env->sdtrig_state.trigger_cur;
     target_ulong val;
+    target_ulong rwx_mask;
     uint32_t size;
 
     /* validate the generic part first */
@@ -475,9 +479,12 @@ static target_ulong type2_mcontrol_validate(CPURISCVState *env,
         }
     }
 
-    /* keep the mode and attribute bits */
-    val |= (ctrl & (TYPE2_U | TYPE2_S | TYPE2_M |
-                    TYPE2_LOAD | TYPE2_STORE | TYPE2_EXEC));
+    /* only set supported access (load/store/exec) bits */
+    rwx_mask = mcc->def->debug_cfg->triggers[index].mcontrol_rwx_mask;
+    val |= ctrl & rwx_mask;
+
+    /* keep the mode bits */
+    val |= ctrl & (TYPE2_U | TYPE2_S | TYPE2_M);
 
     return val;
 }
@@ -573,7 +580,11 @@ static inline bool type6_breakpoint_enabled(target_ulong ctrl)
 static target_ulong type6_mcontrol6_validate(CPURISCVState *env,
                                              target_ulong ctrl)
 {
+    CPUState *cs = env_cpu(env);
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cs);
+    target_ulong index = env->sdtrig_state.trigger_cur;
     target_ulong val;
+    target_ulong rwx_mask;
     uint32_t size;
 
     /* validate the generic part first */
@@ -596,9 +607,12 @@ static target_ulong type6_mcontrol6_validate(CPURISCVState *env,
         val |= (ctrl & TYPE6_SIZE);
     }
 
-    /* keep the mode and attribute bits */
-    val |= (ctrl & (TYPE6_VU | TYPE6_VS | TYPE6_U | TYPE6_S | TYPE6_M |
-                    TYPE6_LOAD | TYPE6_STORE | TYPE6_EXEC));
+    /* only set supported access (load/store/exec) bits */
+    rwx_mask = mcc->def->debug_cfg->triggers[index].mcontrol_rwx_mask;
+    val |= ctrl & rwx_mask;
+
+    /* keep the mode bits */
+    val |= (ctrl & (TYPE6_VU | TYPE6_VS | TYPE6_U | TYPE6_S | TYPE6_M));
 
     return val;
 }
diff --git a/target/riscv/debug.h b/target/riscv/debug.h
index f9e840d615..c9f7225954 100644
--- a/target/riscv/debug.h
+++ b/target/riscv/debug.h
@@ -137,6 +137,7 @@ enum {
 
 struct trigger_properties {
     uint16_t type_mask; /* Trigger types supported (0 = no trigger here) */
+    uint8_t mcontrol_rwx_mask; /* mc/mc6 rwx access match supported */
 };
 
 typedef struct RISCVSdtrigConfig {
-- 
2.51.0



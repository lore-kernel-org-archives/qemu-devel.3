Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6247C28B30
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:15:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzK6-0006ZP-TI; Tue, 11 Mar 2025 09:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzF1-00062l-6z; Tue, 11 Mar 2025 09:01:53 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzEz-0000MD-HX; Tue, 11 Mar 2025 09:01:50 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2feb91a25bdso8351929a91.1; 
 Tue, 11 Mar 2025 06:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741698107; x=1742302907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TQn7KOWUQFcqU1w4jtYKqmuC8Pu69FDqNY7Y/CrCA40=;
 b=EPoUpjeiPKGvD2rSrb/7jfGlD2ezASk+OL+EFviNCTw4p2mJSY/pRPkESWDAxmhAHr
 2KEFRKVAusFZfHtKTzezHPf0zFsEEGA88dt8K7ENZbpHUs5l95PH4pdCpYMCDIe2gcK7
 SU8eFKrW/ELWj/gyXNq4bFL3679nNP0f5FE9rwssHV4kOrymuBVAdsgJ4KJOhEwimZoM
 p/VpOnA6DuVJbr9yS2pVD/Ymyu9itNbzL/y/l/v9SG2skULiwvSdMkEQi/eGzGJs8fxv
 JhKQwK3ONVbF06DvlE3lW/fSgQc06SEUZdm7N1azlv/Bo4iWYlag8/QwICWczOH7WZxB
 0Uxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741698107; x=1742302907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TQn7KOWUQFcqU1w4jtYKqmuC8Pu69FDqNY7Y/CrCA40=;
 b=qVMeetIcAJufjtf8Ec+2/xdPOZWx2pVRGcKdOVK2U4xf8KUkncaOtvuK4gtDxoK0df
 jbaWI/G5wJ/Aj4PEXuFz16dENJkEladrip5gLvT/afwZ0hNxygeW8U/vR8FQD/L198H4
 jWID0BoTMUcbQeQrKhDdmJShamOpxXevtPCN7IgJ9SshDr5r0dcpTbtcZIodjIp/Xapc
 +AsWmkacwP/EBp3XxTDDt+GnbqyaqsMWiBCMJPwtcOx2gVUjXSR38++rEA0lR+2gBQNV
 397Ux++9GVFcmv8ZoYLpwY41NlKLh3TS4bYgmudpAV4APmEsUsO+VqFPVpLl52tg39xw
 5xRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNjBlRKvRUFKpTo8SYofTBu+cXSkComN2ji3eOyZ+q3dEVqA5qXZqJ084SUY1y6kZQqGvC+H8mNw==@nongnu.org
X-Gm-Message-State: AOJu0YxzCdZTUqmZfT3V/CGJUJqDzLTci0sVjMq1xbaNbpRUokachoe3
 j2kwuhKLfagPPZClrCtLbMWKcg+GwxzFPz2p176shLjgsoK/qqQI+pZ8NQ==
X-Gm-Gg: ASbGncugDu2bPeQ7n/rlnHBxUpQfh4DC4r611nsiEUbYzkU6QujqIGNAeaBZ8UO5yxa
 +0hYqFf+KAz7TYh3ZK5pW2dkCOZMYPPF2sw6PwI4no2C01YTF45dHIfZHrNmnTCCcJ0NKhAM1Tr
 5+cKDNUvDLPl2p9OMIW5sxh6OkKYfu9S0Z5v+8th84GnY0YOG1GwFx/zghU9eNEWp2zq4rrE45f
 WYxkva/DG9rwZjf+QDFe96YUI7/4rR9ZqjNtBiXwJXYhUSL7PHTNufIWhNc6HyGNtGDvHn3r87h
 tTov+T/5SaNHTHvQu9+FFXJK2RidPNk1p6YLw0lh+wIBXFxZ/c4=
X-Google-Smtp-Source: AGHT+IHivNbFtL7rTgJkaCQzrNnXxu0MUV9IllhCiFP4VhSb7Cv5sQSyZnueukBT4lrE3TaIIqOloA==
X-Received: by 2002:a17:90b:2648:b0:2fe:e9c6:689e with SMTP id
 98e67ed59e1d1-300ff0c9bacmr4862348a91.8.1741698107206; 
 Tue, 11 Mar 2025 06:01:47 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.06.01.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 06:01:46 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 66/72] spapr: Generate random HASHPKEYR for spapr machines
Date: Tue, 11 Mar 2025 22:58:00 +1000
Message-ID: <20250311125815.903177-67-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102c.google.com
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
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241219034035.1826173-4-npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c          | 3 +++
 hw/ppc/spapr_cpu_core.c | 2 ++
 include/hw/ppc/spapr.h  | 1 +
 3 files changed, 6 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index fcd2ca515c..a415e51d07 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2917,6 +2917,9 @@ static void spapr_machine_init(MachineState *machine)
         spapr_ovec_set(spapr->ov5, OV5_XIVE_EXPLOIT);
     }
 
+    qemu_guest_getrandom_nofail(&spapr->hashpkey_val,
+                                sizeof(spapr->hashpkey_val));
+
     /* init CPUs */
     spapr_init_cpus(spapr);
 
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 9e0e0648a7..0671d9e44b 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -273,6 +273,8 @@ static bool spapr_realize_vcpu(PowerPCCPU *cpu, SpaprMachineState *spapr,
     env->spr_cb[SPR_PIR].default_value = cs->cpu_index;
     env->spr_cb[SPR_TIR].default_value = thread_index;
 
+    env->spr_cb[SPR_HASHPKEYR].default_value = spapr->hashpkey_val;
+
     cpu_ppc_set_1lpar(cpu);
 
     /* Set time-base frequency to 512 MHz. vhyp must be set first. */
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index d227f0b94b..39bd5bd5ed 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -203,6 +203,7 @@ struct SpaprMachineState {
     uint32_t fdt_initial_size;
     void *fdt_blob;
     uint8_t fdt_rng_seed[32];
+    uint64_t hashpkey_val;
     long kernel_size;
     bool kernel_le;
     uint64_t kernel_addr;
-- 
2.47.1



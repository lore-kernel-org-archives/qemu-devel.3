Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7928AE77188
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 15:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSHs0-0000pT-5x; Mon, 30 Dec 2024 10:39:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSHry-0000oy-I2
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 10:39:50 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSHrw-000325-2q
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 10:39:50 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-385e3621518so4392044f8f.1
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 07:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735573186; x=1736177986; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V4fyXlhxQAEqDO8KjATP3LRp5cmZQUPuZTn5SNaOG44=;
 b=ZwzI7iR5zB8P47g/xtTUd7DBIGObZ6c7CrIbmIZfNBVSYnAbB5o/rjiprDMZsn5tIZ
 uuRkcGySs5FbLIuElL6Y+AZqJKET8D0YAKXjcu20UBkp8Ti+oksBycKnHTmOk5keVEb1
 e9NfU1cvb3/AJ4LVZTn9X7AJiR+hj2u1ngD+NioxS3CXr67fuFW0y18uM1xD+SZ9BHq/
 piZGRyr3l31hfWdMhCzBuyj4u3dP8peQP34F2QPAwrietP/9FK7aUufCiAXiHdJUQ4BV
 qyBPq4j1JaTgIU1rxrdNbKHV7tj/5NBp86ygtQ+cVRj+qzd9nx8crELBRKNVyTgxqGrl
 znsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735573186; x=1736177986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V4fyXlhxQAEqDO8KjATP3LRp5cmZQUPuZTn5SNaOG44=;
 b=dnt+eQtoQTdvw+SgPRxgoQkn6neQtlv7PjRa0JdCCWitSYMcsMy0dacIj4RLe5bUPj
 MUZcx/7gUWDICIjCLXVgeTB+EFw/LzKV0C4tNQnA8g/9mluNAzyVmWl7D1Zbl+rQ/bwV
 D8ZvW2dzyBozjniPkKOcEapRsP5d5yKABlTlJyFb3606wMIOo1oYlooeuZ9vjaUsLVHF
 FiPcS79Vbw7ORU+HY9yd1cV5t3tRWHseSNcR3htBrBxnKThdqFY1g+aECcxuuTPahn9c
 H3IZtC8kCSV5zvbKdUfz+w/esas85ZKlVcVZt1jEUCzPqNFcs7So+fndGSHabsvRyreT
 RQLw==
X-Gm-Message-State: AOJu0YzL5yjyaP9BzNQLCVT0ck1G9U0uTkF7ICFzBSDiZGHuelngFZLK
 qzK0+Qbr53hJrJjH3qTR2O4ivhpT1PgWwx4jtLx6kI8J8khdf4PXyw+dxw10KY30sJfHdUgh47e
 +
X-Gm-Gg: ASbGncvMhkP0rJVjpQ53gVSGcQN8Jw2cLfBIMm8Q3Ja0X0nfkOJ2/7WBE/N7FfemkRS
 LngG10FYAfLgZyqZjEd5LFu1FaAyqDuy5zSJ7r1cyqYHyK70NKNsxiCBgfpkjUFPIkUSG4IDjlL
 pzGGGqxjZPnQaQH+1Yx8EHKBkwyNMtBA6fkbkKmgAQvInkmVAXtiRHx/dkRLnMtgfxaTg+fBFdc
 NhRIZLz2hpDuCPIBbuT3yZcO4FGTYvQYd+uzwyYvZsoryCpO7NxfTbSHcFqVQu8RmS3Wv57Cabb
 FjopcUXa1p9N7sC9Am43zNYjn1VJO7U=
X-Google-Smtp-Source: AGHT+IFdVrExOtPviKBtzmUgWj/2NvtoQOnLUa5BI2B1gGmpJYSyAAb0yEKJF6NFTfhIJV2Ec5rsuQ==
X-Received: by 2002:a05:6000:480a:b0:386:1cd3:89fa with SMTP id
 ffacd0b85a97d-38a221fa8c6mr35175811f8f.33.1735573186365; 
 Mon, 30 Dec 2024 07:39:46 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366127c4bbsm357117475e9.32.2024.12.30.07.39.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Dec 2024 07:39:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-ppc@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Song Gao <gaosong@loongson.cn>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/3] target/cpus: Remove pointless re-assignment of
 CPUState::halted
Date: Mon, 30 Dec 2024 16:39:29 +0100
Message-ID: <20241230153929.87137-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241230153929.87137-1-philmd@linaro.org>
References: <20241230153929.87137-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

The CPUState::halted field is always re-initialized in
cpu_common_reset_hold(), itself called by cpu_reset().
No need to have targets manually initializing it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/mips_cpc.c        | 1 -
 hw/ppc/e500.c             | 1 -
 target/arm/arm-powerctl.c | 2 --
 target/hppa/cpu.c         | 1 -
 4 files changed, 5 deletions(-)

diff --git a/hw/misc/mips_cpc.c b/hw/misc/mips_cpc.c
index 772b8c0017d..4ec8226c416 100644
--- a/hw/misc/mips_cpc.c
+++ b/hw/misc/mips_cpc.c
@@ -38,7 +38,6 @@ static void mips_cpu_reset_async_work(CPUState *cs, run_on_cpu_data data)
     MIPSCPCState *cpc = (MIPSCPCState *) data.host_ptr;
 
     cpu_reset(cs);
-    cs->halted = 0;
     cpc->vp_running |= 1ULL << cs->cpu_index;
 }
 
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 4551157c011..8b90b5b2448 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -785,7 +785,6 @@ static void ppce500_cpu_reset(void *opaque)
     cpu_reset(cs);
 
     /* Set initial guest state. */
-    cs->halted = 0;
     env->gpr[1] = (16 * MiB) - 8;
     env->gpr[3] = bi->dt_base;
     env->gpr[4] = 0;
diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index 20c70c7d6bb..8e948171c7c 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -67,7 +67,6 @@ static void arm_set_cpu_on_async_work(CPUState *target_cpu_state,
     /* Initialize the cpu we are turning on */
     cpu_reset(target_cpu_state);
     arm_emulate_firmware_reset(target_cpu_state, info->target_el);
-    target_cpu_state->halted = 0;
 
     /* We check if the started CPU is now at the correct level */
     assert(info->target_el == arm_current_el(&target_cpu->env));
@@ -194,7 +193,6 @@ static void arm_set_cpu_on_and_reset_async_work(CPUState *target_cpu_state,
 
     /* Initialize the cpu we are turning on */
     cpu_reset(target_cpu_state);
-    target_cpu_state->halted = 0;
 
     /* Finally set the power status */
     assert(bql_locked());
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 9b355bfe902..b4092037888 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -203,7 +203,6 @@ static void hppa_cpu_reset_hold(Object *obj, ResetType type)
     if (scc->parent_phases.hold) {
         scc->parent_phases.hold(obj, type);
     }
-    cs->halted = 0;
     cpu_set_pc(cs, 0xf0000004);
 
     memset(env, 0, offsetof(CPUHPPAState, end_reset_fields));
-- 
2.47.1



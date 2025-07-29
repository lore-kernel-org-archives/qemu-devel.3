Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB866C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:38:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguVl-00037j-9T; Tue, 29 Jul 2025 20:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFg-000253-Rp
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:01:10 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFa-00046K-O3
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:59 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-74924255af4so5226255b3a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833652; x=1754438452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HdPPSlK4mzA8oiZ4wEtFFpfnz4mF9UVBC9u+0lQw7dA=;
 b=EXXabUWVhSfnmTfRHOiHs5nZ/wJZ4BbBY0vr6Ij5n/1vIwqeNqoJixe+AFXKeintAx
 Y04XVtsAUzO39/yzSpHM3ijAfSIALifIaVvi08XBkTak8ZYAdGJpKVDsNBjkf3dWG400
 bKLlY0wxriD2prDn9BCfOfLVzQ5AxOAhjhp2MbLu8wUpSv5YGEtBh41ca3dJ/cHX7nMF
 1JeKhDWQ4giEa8WNkPmPBy4jwyXwha5AHDP9XKDel8riMgijL7dqZ0svrDOAwZdQ69ti
 QMag+UPQsyqUEMk6nwqvznfnPAGg8viGKWmCskQ5Jg35UO8aKJL8V8qC8f8fujTRKIWw
 zM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833652; x=1754438452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HdPPSlK4mzA8oiZ4wEtFFpfnz4mF9UVBC9u+0lQw7dA=;
 b=gWa/0bD79qOMvn/DjG2i/AJWnDOWjS1gPV7xm9hGffZMplrj8TBe1tkTZRR1pxZyN6
 G8a+pUw9sEX0gdv/UnZ5BK5LcA0TX342ayB7qsb8P7Ebv6D5cIdlMVovCAO//3C/Fqh7
 sZMooD9DtZD1gz4g68Ev092AdFMnjjl497p/on13edZ/fpRXKLw/3ozzUDCdbcF6QMGU
 btVcZU7YXHKMdWa+UvdYdpJe9pqZDmHQiLC7tnyYfrc1skNKqKBSu0lnxcLjYrH0TcLf
 6DFH5tPQV+EOFnn2lxB2aQpV9h+78Lhzx6BLxrLCq5ehbWGZl9aKUGxA7TDzwe8vr23h
 meOA==
X-Gm-Message-State: AOJu0Yz1Rdk6PuI2pj/E9rrIe6Vm/O6cHJo/hG5/4RV2qwdF11USlXgx
 50jcn680J/jp0xph/EqtTSP8JtkELXLW0bpvmCOx9oYDNyoASGmHXNrpwH5zSSErvwiVJpbicRT
 4pexa
X-Gm-Gg: ASbGncvsb6+J0YEmwO1T4k0yn/Hhpf2bhuMWYtBtLMKXLEHer4tvSTyIcNM2Ib7IETN
 3WplCdI0W1Btffv53basRamL1yicL//vc2VIEqW6jNYUyXjXxIQI9799yobHjqPXtggmZL3vuWN
 M2QTd/9blDhUpHdqvBv6+HiPbQ97fYnmJpYnlr4CtkKPvy+V3EhieEmkHA2zvU/Up9zg49rX4fr
 xTm4eYt8aZSdIsAzhOIive7Ds4L1T9AWuOJBSpTmovQQIFQnmQrsVuFziDjPD3E6K1xzAPgZZAH
 NEnn+eXzH0SvdkvAQnGOqzvunTmrkaP98t8odAWQ3aLwNK/HZozCa+IPBbZDPxOao2VdRgWzNH5
 L92VD1hGokQpHQ9VilTWRh25jzGIuYKig3Ry6wUQb4NsVoxbwyca28oWfkQ8//t5BHr1TD94flc
 nr1FYliTev/A==
X-Google-Smtp-Source: AGHT+IEozTaThIc/wIBw6it4/PXzR9VS1iGuWW3Hl2GRXajAp0gmaB7D/nFBp21MdQ82ULNhrnSCdg==
X-Received: by 2002:aa7:9885:0:b0:742:b3a6:db16 with SMTP id
 d2e1a72fcca58-76ab308b5f3mr1577158b3a.20.1753833651944; 
 Tue, 29 Jul 2025 17:00:51 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-764090e178bsm9026087b3a.62.2025.07.29.17.00.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:00:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 30/89] linux-user/microblaze: Create init_main_thread
Date: Tue, 29 Jul 2025 13:59:03 -1000
Message-ID: <20250730000003.599084-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Merge init_thread and target_cpu_copy_regs.
There's no point going through a target_pt_regs intermediate.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c             |  8 +------
 linux-user/microblaze/cpu_loop.c | 39 ++++----------------------------
 2 files changed, 6 insertions(+), 41 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index e295dda0bd..9e6ec4f20a 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -646,13 +646,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUMIPSState *e
 #define ELF_CLASS   ELFCLASS32
 #define ELF_ARCH    EM_MICROBLAZE
 
-static inline void init_thread(struct target_pt_regs *regs,
-                               struct image_info *infop)
-{
-    regs->pc = infop->entry;
-    regs->r1 = infop->start_stack;
-
-}
+#define HAVE_INIT_MAIN_THREAD
 
 #define ELF_EXEC_PAGESIZE        4096
 
diff --git a/linux-user/microblaze/cpu_loop.c b/linux-user/microblaze/cpu_loop.c
index 87236c166f..d8277961c7 100644
--- a/linux-user/microblaze/cpu_loop.c
+++ b/linux-user/microblaze/cpu_loop.c
@@ -127,39 +127,10 @@ void cpu_loop(CPUMBState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
+void init_main_thread(CPUState *cs, struct image_info *info)
 {
-    env->regs[0] = regs->r0;
-    env->regs[1] = regs->r1;
-    env->regs[2] = regs->r2;
-    env->regs[3] = regs->r3;
-    env->regs[4] = regs->r4;
-    env->regs[5] = regs->r5;
-    env->regs[6] = regs->r6;
-    env->regs[7] = regs->r7;
-    env->regs[8] = regs->r8;
-    env->regs[9] = regs->r9;
-    env->regs[10] = regs->r10;
-    env->regs[11] = regs->r11;
-    env->regs[12] = regs->r12;
-    env->regs[13] = regs->r13;
-    env->regs[14] = regs->r14;
-    env->regs[15] = regs->r15;
-    env->regs[16] = regs->r16;
-    env->regs[17] = regs->r17;
-    env->regs[18] = regs->r18;
-    env->regs[19] = regs->r19;
-    env->regs[20] = regs->r20;
-    env->regs[21] = regs->r21;
-    env->regs[22] = regs->r22;
-    env->regs[23] = regs->r23;
-    env->regs[24] = regs->r24;
-    env->regs[25] = regs->r25;
-    env->regs[26] = regs->r26;
-    env->regs[27] = regs->r27;
-    env->regs[28] = regs->r28;
-    env->regs[29] = regs->r29;
-    env->regs[30] = regs->r30;
-    env->regs[31] = regs->r31;
-    env->pc = regs->pc;
+    CPUArchState *env = cpu_env(cs);
+
+    env->pc = info->entry;
+    env->regs[1] = info->start_stack;
 }
-- 
2.43.0



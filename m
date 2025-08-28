Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3AA9CA0FF2
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 12:12:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urbS3-00037J-73; Thu, 28 Aug 2025 08:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbRP-0002Mh-BW
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:21 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbRN-0007Cb-JC
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:19 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-32326789e06so766631a91.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756382954; x=1756987754; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=18XPWlgCmnlwnh9DfuZh3Fkld5xrETQF6kR7JJI1/ao=;
 b=bZqd0YylapEYMlKe6xA7dNnbUBNmXWpzTgD3l64rM4ln6pOp9CAkNCqVLq6LK5PJLd
 eAS6idgs/Y3qpVWWdoOCWJSJys6CJE4jIkUquMJeQ8K2wcQW/atT94Nny1pwJr3Su5py
 EovplQLYUZ1xUspAkSUUXY9Y6YCPWf5c9wD/8EncxXtfax9HMWN+eZtiKHX6SuZM65cv
 odzOR0QUiadYA1a40HKetWv5GPb5/zkzMjml7kVVvjYmnxc/UKSwQwIstHu5y3FAAXXU
 Rrw+WjORi+BFf+QpeLYIp831vzamgO5t/n+qBCf7sDr9pJ3RXxtT/GnhBbSFmxV+JK+L
 kipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756382954; x=1756987754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=18XPWlgCmnlwnh9DfuZh3Fkld5xrETQF6kR7JJI1/ao=;
 b=UzXAFwedyYBuxEoKcf0H/u8X1/BMngbGRHGshvsfnHHHI01C9/LIdQqsVxvbtnIaXO
 vZzhPko7dRyBVyfyFklrcMZIBtm7aLHjIMpEMQZjCc8uEFyGoM52r1QlMusapkckjPaa
 XPuaUXQgAJbpNyYLicAEORK6YxeN+NdlV9AGMc71PKOMVVqAgcagdDtMyW9984MmeTJi
 OOmXBsjYE2UeQ3oETDCJKgAmFmxl7dSX117hUHYmsutQrJ4sWDg987nXlOxGZxadSjSo
 TyH5Gnyq1y5l2SPxdG2lLRa5r1/VOE65rRjqn4lomQCttlTufLT0tQwbiO87pnYpnQDE
 HgJQ==
X-Gm-Message-State: AOJu0YzQhhS+RqtgQSO+2ocEbLUj8j0g8SXjY6e8l+keB41tEiKC7Stz
 TxLHe7YOIsayBlCRBxwn9vH04gid8AMEF1ItqBKjuDkYyl9MJQMiaQWJROF/BGlqi8w+FaqCw4B
 cAxZFfJc=
X-Gm-Gg: ASbGncs+7v2Hq/xe3QSwoSYug/F/8kSpB3xtm8jMavwiEAFlVDauBoUBTJ1P3Ni4gIA
 4wO739uLspgfSj1p7zSontMr6eUvQR+UtWMMzgOend7jA863/MA0IGDl/93qsIhYGcQv6+V6mXE
 pNl0HSVns1g9vKrHLkZpWAVvk0uIFNYvPmEb91jku7PAGqbTaYis+gN16Thm0Y2M59DP1K2eetH
 jF5LkhF4Zy9IP3ZgkNJGFEtnfGykIT3COnamMvsgzrsda3aRpew+TV3Wo7liWo9oP3ahV4bX/Uj
 bK8wgB1Lst9wcOyFsYstQ/4/ftyMtKaxAphvuh1Dpb5bXmksuWRfzzQ4QnawEFMx0aH5AIgm3ml
 xl03xjaiIx0E8JDc2gId4eF4dxSzwevz1Dlhf
X-Google-Smtp-Source: AGHT+IG06hEeov2LGQ/ZvnPiwVafpaWWIKkD2q6PhiGtzM0JpaKk0vcqqufEKEiQMDElxqVJwRLROw==
X-Received: by 2002:a17:90a:e7ca:b0:325:7825:f5a3 with SMTP id
 98e67ed59e1d1-3257825f735mr21511086a91.36.1756382954029; 
 Thu, 28 Aug 2025 05:09:14 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b49cb8b4b98sm13933222a12.19.2025.08.28.05.09.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:09:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 13/87] linux-user/xtensa: Convert target_elf_gregset_t to a
 struct
Date: Thu, 28 Aug 2025 22:07:22 +1000
Message-ID: <20250828120836.195358-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 98c17d32e6..930701f08f 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -873,7 +873,9 @@ static bool init_guest_commpage(void)
 
 /* See linux kernel: arch/xtensa/include/asm/elf.h.  */
 #define ELF_NREG 128
-typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
 
 enum {
     TARGET_REG_PC,
@@ -888,23 +890,23 @@ enum {
     TARGET_REG_AR0 = 64,
 };
 
-static void elf_core_copy_regs(target_elf_gregset_t *regs,
+static void elf_core_copy_regs(target_elf_gregset_t *r,
                                const CPUXtensaState *env)
 {
     unsigned i;
 
-    (*regs)[TARGET_REG_PC] = tswapreg(env->pc);
-    (*regs)[TARGET_REG_PS] = tswapreg(env->sregs[PS] & ~PS_EXCM);
-    (*regs)[TARGET_REG_LBEG] = tswapreg(env->sregs[LBEG]);
-    (*regs)[TARGET_REG_LEND] = tswapreg(env->sregs[LEND]);
-    (*regs)[TARGET_REG_LCOUNT] = tswapreg(env->sregs[LCOUNT]);
-    (*regs)[TARGET_REG_SAR] = tswapreg(env->sregs[SAR]);
-    (*regs)[TARGET_REG_WINDOWSTART] = tswapreg(env->sregs[WINDOW_START]);
-    (*regs)[TARGET_REG_WINDOWBASE] = tswapreg(env->sregs[WINDOW_BASE]);
-    (*regs)[TARGET_REG_THREADPTR] = tswapreg(env->uregs[THREADPTR]);
+    r->regs[TARGET_REG_PC] = tswapreg(env->pc);
+    r->regs[TARGET_REG_PS] = tswapreg(env->sregs[PS] & ~PS_EXCM);
+    r->regs[TARGET_REG_LBEG] = tswapreg(env->sregs[LBEG]);
+    r->regs[TARGET_REG_LEND] = tswapreg(env->sregs[LEND]);
+    r->regs[TARGET_REG_LCOUNT] = tswapreg(env->sregs[LCOUNT]);
+    r->regs[TARGET_REG_SAR] = tswapreg(env->sregs[SAR]);
+    r->regs[TARGET_REG_WINDOWSTART] = tswapreg(env->sregs[WINDOW_START]);
+    r->regs[TARGET_REG_WINDOWBASE] = tswapreg(env->sregs[WINDOW_BASE]);
+    r->regs[TARGET_REG_THREADPTR] = tswapreg(env->uregs[THREADPTR]);
     xtensa_sync_phys_from_window((CPUXtensaState *)env);
     for (i = 0; i < env->config->nareg; ++i) {
-        (*regs)[TARGET_REG_AR0 + i] = tswapreg(env->phys_regs[i]);
+        r->regs[TARGET_REG_AR0 + i] = tswapreg(env->phys_regs[i]);
     }
 }
 
-- 
2.43.0



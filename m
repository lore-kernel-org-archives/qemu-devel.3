Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65CFECA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 12:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urbR8-00028D-2R; Thu, 28 Aug 2025 08:09:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbR5-00026w-6P
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:08:59 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbR2-00079A-An
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:08:58 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7704f3c4708so1043916b3a.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756382935; x=1756987735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IwLQkscBvVNvwc673PSbY9v8qD5Nq2dzCHYPuN8qxPU=;
 b=OX7z24IJYA6KzFjviLEo5WkiPmf4YN3O+FUXg9jlMT4eZxFVfPY/+Z5DkDnyzhhE3P
 v797yVNJ92TKVcyQzvizqZfkjdr/IOAjzluPrMttz3jNa4Hgm0n3x/AGqE56FtitHkyp
 gR6XFt1H4smyfuKDRXWXKlY46ZObn2sdYeRhfCePR34H0IglxZRQuFSZTqrAzX6EIkak
 N9RxFe9vDWGhTlbm+s2+MGy39UXlIy9UmcCM8SX9n8KAAI5ZviO0RTn53JHJRvk1Tpcy
 7p4XuhoHGoowTypGaK2v+89IcBxn2pM5NYcD91VNgJDilYsXoPFUs6sU5WUxx4GIpndx
 512Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756382935; x=1756987735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IwLQkscBvVNvwc673PSbY9v8qD5Nq2dzCHYPuN8qxPU=;
 b=iBo6pUQIFYOoo+F5T+V/XGgSQ0sZEJbu468UChuTdZao5vZD5B0Fc7nkGmJVEiYKQd
 VpIBS9xgk4yLb00TEMGsB6SyFHF0j9q8d38ZqD6ATYPceaMsm+550zycacTsxig6rJ9q
 F9FtWFF5FQjrVbey+cabEhz1x4mlAqfCVc2MIwGoJvV8OnxAKFBXUMm2AzDD9OI8DjBO
 xa5ynZOWZE/T0VlWO5q1Xi2jZ/cqFfYJOn15PrjPq0+oy+U7gdXmSNGNTIdR5DD4Db3r
 BsoLr30oyeNkhrebdbOLm9YvdmFxTTJ0s3BJNsv4uzm9Kz8vc9XrtM7gd3qAyQSM4ecQ
 86ug==
X-Gm-Message-State: AOJu0YyC9Kdnjx63Vsr5OwJkIAnTND1jxin/jXJJ+BVYERapIwy1/7RH
 gdXIP4TF5Hlpj2CYe0OxFLsEsCBskHksClPQNrM38yJ/RMrHrdSEvMCnhSk6VOZWCt0SSA4cAKt
 ypITMz0g=
X-Gm-Gg: ASbGncvWkFwZY8n/KOqUPV1mJKO+wiJQufejnMBJ5JniF1O1Bhi1kajhu0qN6ufILPD
 clZECpMPvcMxDdjU6PQWlcb5ukPKqCkmlhq2M1cisqstacoxMlFF0iAwUPbcFowUxFGLVhqpmsc
 vMexa6TI7CP+zlOn4gsAR/SmGbdPkW1531tA2u8ZenPF0f4Jy/LQfgfGu7phyPhlE6S1pz5uEIM
 B4Z/x0HelhEhGBd1p5Xcp5qixjUZcRpxG9/HjwETpseKkHm88IeMKhF49HZVcYuIeSie0c+KXOA
 qAHfMU1tUyLH/YfeapBsGxg8+fovhZoT2ekpUdbLMQ19jRRJLE90hHZbWdsxRMKp4geHCGMhFXT
 DpuwZ8gCefc8vxUAzz5f5aXpDJA==
X-Google-Smtp-Source: AGHT+IElX5MKHiC3QY96XfI26sd1yfDlci2fl1xXvaXb4nv1xUzmSNakm30i603iHoQRIxNyRWBU/Q==
X-Received: by 2002:a05:6a20:7d9d:b0:243:78a:82ab with SMTP id
 adf61e73a8af0-24340d5e496mr33336068637.51.1756382934629; 
 Thu, 28 Aug 2025 05:08:54 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b49cb8b4b98sm13933222a12.19.2025.08.28.05.08.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:08:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 05/87] linux-user/ppc: Convert target_elf_gregset_t to a
 struct
Date: Thu, 28 Aug 2025 22:07:14 +1000
Message-ID: <20250828120836.195358-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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
 linux-user/elfload.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index da57c6c2ce..0dd76937f9 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -470,25 +470,27 @@ static void elf_core_copy_regs(target_elf_gregset_t *r, const CPUARMState *env)
 
 /* See linux kernel: arch/powerpc/include/asm/elf.h.  */
 #define ELF_NREG 48
-typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
 
-static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUPPCState *env)
+static void elf_core_copy_regs(target_elf_gregset_t *r, const CPUPPCState *env)
 {
     int i;
     target_ulong ccr = 0;
 
     for (i = 0; i < ARRAY_SIZE(env->gpr); i++) {
-        (*regs)[i] = tswapreg(env->gpr[i]);
+        r->regs[i] = tswapreg(env->gpr[i]);
     }
 
-    (*regs)[32] = tswapreg(env->nip);
-    (*regs)[33] = tswapreg(env->msr);
-    (*regs)[35] = tswapreg(env->ctr);
-    (*regs)[36] = tswapreg(env->lr);
-    (*regs)[37] = tswapreg(cpu_read_xer(env));
+    r->regs[32] = tswapreg(env->nip);
+    r->regs[33] = tswapreg(env->msr);
+    r->regs[35] = tswapreg(env->ctr);
+    r->regs[36] = tswapreg(env->lr);
+    r->regs[37] = tswapreg(cpu_read_xer(env));
 
     ccr = ppc_get_cr(env);
-    (*regs)[38] = tswapreg(ccr);
+    r->regs[38] = tswapreg(ccr);
 }
 
 #define USE_ELF_CORE_DUMP
-- 
2.43.0



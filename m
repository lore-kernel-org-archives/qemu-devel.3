Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1BD0CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNjl-00075k-8o; Sat, 30 Aug 2025 11:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7We-0002fU-2L
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:24:52 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7Wa-0002b4-OQ
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:24:51 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7704f3c4708so3116926b3a.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506287; x=1757111087; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f5I/NtM7Pi+1byAnsGGTmyqoepcDZYWEIZxl5JuqsYk=;
 b=DxzyeTe+o4lcbIR9v+7saHyJdzQCCMY8W9oNb6UhghPRcAVQl2YvRfsFd3nmopl3yQ
 u3oAmpFLoGeRIfMOEUleYjxjHQh/ZNCcDFu1CWtqHl9CnalooTMTkKl0vzN9cDOwbmqx
 g4ES87DmJZqTZdV0FsCBY/yFG8vyeYs3fffdUraztAc2F/06djy0qBUVD4Yn8TMG1MYk
 5jdGuSKAhO2jWFKWREXeNNs5ql7eoAo9E0jIbG/5H/74tK7zGs5Qj23NLJ72cfZyZ92n
 wtMZ7wfwu9dQ7+148jPfglXZqwY+NpzC7RTrZd9KXt3EZC3F+m84spvYkIvaUpT/cB2U
 KW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506287; x=1757111087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f5I/NtM7Pi+1byAnsGGTmyqoepcDZYWEIZxl5JuqsYk=;
 b=c3qcdmALcItF+SzlEwJK6d08gN6OnaEuBnmdpSqt2Go7m7zA5iRsQCUCtf+4OrtrMj
 E8ASo/hZK2Apy5MkuiwabsH3kLbvNhzn/6HsvEe50UA/CDrfqgnEW3ekn8S1PqVigWhs
 +mSjkGtRD3d61V162PL3z1F5NkfJXsDockoDojpJlBdLu0Rzs0tvQKg5W1Pic6i0Xgxa
 7IGT1yayvqhlVskbJ9GOEoQUs/+OaypQuQkmVaT3RfLaQIOvg1zrqdtwmUvuF1BIP5L8
 klsfiOGEK8LDy+Ucp7UYp8b/D2QLdpYHAowAvK2VBAMYWhVscUeqL2XpV/gJYk6HVVEj
 h0hg==
X-Gm-Message-State: AOJu0YwucgDMrE5lb3m46j7nAv+EKaQKovmhtbJBYAay+v//YG2/BAUH
 IOu73RMMztGbf0voOp0bvMbhdBi6AbjCohYcqWvxBbOvJfl2IHQ8fVx8D/TsCKz5Qn7YPnYnoXo
 /xGfQgl8=
X-Gm-Gg: ASbGncuIhRlT0UGo6kEN/ih11KFCHbN956hHmg+3QyvUUYDcUdMllMzdPwuwy3wdiGm
 l05yVtSyeC6btJeITpuRDEBKTHY4JPQ32Zn33ait+iNwEuSsIJM9156SSD0c/tcNc/XSgFtKeYa
 ZVVwTrZTttFeqFyGWmKRJ9nvuqmo5qTWZg8q5FlDZkvC9l7z2acgIjmIc7OY55p90nWVRXTtYdd
 G4gpR7Nfhbc+znA9V0615v1GOSrTchgdXraedcUMhi35g56Dyz6M164UyV5Y+qtDVOijSb/SdN8
 JhCBWilYsOkX/twNcQLmPd9aEduwHFimE28OlCuRd2x00+UmfXXPl1zPpKozOFT9fbv90EIwyyd
 LDPnSVXysBQsW7+jEALfz7axY85GVGyLd4YYbp8vr9l9MuyifCVge3k8A9Rvfzi950LIuJyY=
X-Google-Smtp-Source: AGHT+IHTehE9+fW/jscaj6Rdo1FqDTGrBWryGjvOxEmdYxNNZHcl748Terk6JGHjaU2tKTod3sTamQ==
X-Received: by 2002:a05:6a00:1495:b0:772:2850:783d with SMTP id
 d2e1a72fcca58-7723e387ed0mr284737b3a.22.1756506286787; 
 Fri, 29 Aug 2025 15:24:46 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a71c60bsm3302493b3a.103.2025.08.29.15.24.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:24:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 05/91] linux-user/x86_64: Convert target_elf_gregset_t to a
 struct
Date: Sat, 30 Aug 2025 08:23:01 +1000
Message-ID: <20250829222427.289668-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

A structure typedef may be abstract, while an array typedef cannot.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 60 +++++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index fce4c05674..ba205c5a19 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -154,7 +154,9 @@ typedef abi_int         target_pid_t;
 #define ELF_ARCH       EM_X86_64
 
 #define ELF_NREG    27
-typedef target_elf_greg_t  target_elf_gregset_t[ELF_NREG];
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
 
 /*
  * Note that ELF_NREG should be 29 as there should be place for
@@ -163,35 +165,35 @@ typedef target_elf_greg_t  target_elf_gregset_t[ELF_NREG];
  *
  * See linux kernel: arch/x86/include/asm/elf.h
  */
-static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUX86State *env)
+static void elf_core_copy_regs(target_elf_gregset_t *r, const CPUX86State *env)
 {
-    (*regs)[0] = tswapreg(env->regs[15]);
-    (*regs)[1] = tswapreg(env->regs[14]);
-    (*regs)[2] = tswapreg(env->regs[13]);
-    (*regs)[3] = tswapreg(env->regs[12]);
-    (*regs)[4] = tswapreg(env->regs[R_EBP]);
-    (*regs)[5] = tswapreg(env->regs[R_EBX]);
-    (*regs)[6] = tswapreg(env->regs[11]);
-    (*regs)[7] = tswapreg(env->regs[10]);
-    (*regs)[8] = tswapreg(env->regs[9]);
-    (*regs)[9] = tswapreg(env->regs[8]);
-    (*regs)[10] = tswapreg(env->regs[R_EAX]);
-    (*regs)[11] = tswapreg(env->regs[R_ECX]);
-    (*regs)[12] = tswapreg(env->regs[R_EDX]);
-    (*regs)[13] = tswapreg(env->regs[R_ESI]);
-    (*regs)[14] = tswapreg(env->regs[R_EDI]);
-    (*regs)[15] = tswapreg(get_task_state(env_cpu_const(env))->orig_ax);
-    (*regs)[16] = tswapreg(env->eip);
-    (*regs)[17] = tswapreg(env->segs[R_CS].selector & 0xffff);
-    (*regs)[18] = tswapreg(env->eflags);
-    (*regs)[19] = tswapreg(env->regs[R_ESP]);
-    (*regs)[20] = tswapreg(env->segs[R_SS].selector & 0xffff);
-    (*regs)[21] = tswapreg(env->segs[R_FS].selector & 0xffff);
-    (*regs)[22] = tswapreg(env->segs[R_GS].selector & 0xffff);
-    (*regs)[23] = tswapreg(env->segs[R_DS].selector & 0xffff);
-    (*regs)[24] = tswapreg(env->segs[R_ES].selector & 0xffff);
-    (*regs)[25] = tswapreg(env->segs[R_FS].selector & 0xffff);
-    (*regs)[26] = tswapreg(env->segs[R_GS].selector & 0xffff);
+    r->regs[0] = tswapreg(env->regs[15]);
+    r->regs[1] = tswapreg(env->regs[14]);
+    r->regs[2] = tswapreg(env->regs[13]);
+    r->regs[3] = tswapreg(env->regs[12]);
+    r->regs[4] = tswapreg(env->regs[R_EBP]);
+    r->regs[5] = tswapreg(env->regs[R_EBX]);
+    r->regs[6] = tswapreg(env->regs[11]);
+    r->regs[7] = tswapreg(env->regs[10]);
+    r->regs[8] = tswapreg(env->regs[9]);
+    r->regs[9] = tswapreg(env->regs[8]);
+    r->regs[10] = tswapreg(env->regs[R_EAX]);
+    r->regs[11] = tswapreg(env->regs[R_ECX]);
+    r->regs[12] = tswapreg(env->regs[R_EDX]);
+    r->regs[13] = tswapreg(env->regs[R_ESI]);
+    r->regs[14] = tswapreg(env->regs[R_EDI]);
+    r->regs[15] = tswapreg(get_task_state(env_cpu_const(env))->orig_ax);
+    r->regs[16] = tswapreg(env->eip);
+    r->regs[17] = tswapreg(env->segs[R_CS].selector & 0xffff);
+    r->regs[18] = tswapreg(env->eflags);
+    r->regs[19] = tswapreg(env->regs[R_ESP]);
+    r->regs[20] = tswapreg(env->segs[R_SS].selector & 0xffff);
+    r->regs[21] = tswapreg(env->segs[R_FS].selector & 0xffff);
+    r->regs[22] = tswapreg(env->segs[R_GS].selector & 0xffff);
+    r->regs[23] = tswapreg(env->segs[R_DS].selector & 0xffff);
+    r->regs[24] = tswapreg(env->segs[R_ES].selector & 0xffff);
+    r->regs[25] = tswapreg(env->segs[R_FS].selector & 0xffff);
+    r->regs[26] = tswapreg(env->segs[R_GS].selector & 0xffff);
 }
 
 #if ULONG_MAX > UINT32_MAX
-- 
2.43.0



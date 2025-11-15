Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C62CEACF9
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Nov 2025 00:27:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vK47y-0001S4-Ro; Fri, 14 Nov 2025 19:26:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vK47w-0001QL-4Q
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 19:26:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vK47u-00019L-KO
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 19:26:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763166409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+VnR7WQ4phvEKh0Jwt424ldKYy6fvpgQ+MNLeSCq/oA=;
 b=W+tOpcYySLT0wwPOtWESQNvrV26QWmx1VDfwOCQgciGFHZBBut7wkjLWtKRQkS3M8oVKaU
 FFsKnLXyNTmY45wEhOviYYzwSWH1Rm1LMBCUwzkYkZFWThNLmMtJDTvAksYbRI755GD+Aj
 lLySRlKlS4OZEedA5q0NGDAUqr37tj4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-Adxj8P3TMh6phsuGN7WcLQ-1; Fri, 14 Nov 2025 19:26:47 -0500
X-MC-Unique: Adxj8P3TMh6phsuGN7WcLQ-1
X-Mimecast-MFC-AGG-ID: Adxj8P3TMh6phsuGN7WcLQ_1763166407
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47788165c97so15900365e9.0
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 16:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763166406; x=1763771206; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+VnR7WQ4phvEKh0Jwt424ldKYy6fvpgQ+MNLeSCq/oA=;
 b=q93j1vLAL49dQghNJhq4OrG2IPlOhThoLw+5wWSHQsfrVIyI/b2l9H5YDABx/udmDT
 XIQYDhRvUiR9ylbq6qO2sW+FB9R2mV0R6onSSSBEMNG48NLyecxka2tNL5nxCyB6gwHU
 eGkwvC1cVpPFvFSDoeJQYv7O/WMx0kHwRlaKRSevxsTLPsYsKuPxy91tRNMXEdeuA07d
 ON3Y8WRMW6LSLJ4fAj5RwJFkxnfeLuE4CNh+u3dDrZaa7xME0dclMkZ77n47bzWhNTLM
 ZjDCu/vasbbpqraZM/yJ9Oemturvdc7E0m4Q7sxlXWVbqrdXUwFrixCqh1c+Vrr3sKTI
 uh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763166406; x=1763771206;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+VnR7WQ4phvEKh0Jwt424ldKYy6fvpgQ+MNLeSCq/oA=;
 b=Mat2WeeMWUuCBnyHv0g83HgzMX/Xcz56thaam7T8JQEzGoePUwwLULtLCy1N+tvPFS
 cWJf9rWDjwKmhyCW0HEaXY1h9W9uaRsNlZGr33pkmMJSkBODkHeBMei0MeDXDcrWWWNf
 4Qs3w8QCwZtjjW2z02mQ2L2v4pkE+1Mepn8xRo3/7MX49Bm4SHUvbWPvKrP2RsNigFeK
 iL+hCr5h9DvyoZCX5AVxhTwljeIdzKPdpg25cvmYwarzMHd+u25vxYrj4Cnd2LO+1n3J
 FxxO5prRkgsHAYJfBbtlrZCnhVWk5BdDXfy7i0S0IIpCW+PP3nGSZickAuQ1GwKhYZJK
 s5kg==
X-Gm-Message-State: AOJu0Yz0DL1sTQ5YBJAVdAbF4PC+XwocnxpXmy0tTxeRPqjilnF5LoGE
 X6NMrElQowqCBVX476iJ3kQdNtpZK7PwSmZ9HpItp/PgGsTsgOGPLTY24Y7iNeMtxqFSciBfrUn
 cKm+zy1wH1pAfsTqTCUnOuqXZUdZuYeug5+AABRyp+JjTKg3O9i0zo7e6vSG5fNRnDH4Wov+T9r
 xPTOklS45/165oHFFwtPWkRt/ntZblI6dLvhxEGM+t
X-Gm-Gg: ASbGncvKbn+gGdEfet6dCku6j9loCR1B1s/EuaNwGEXJTzZPyPLVzIjosm426AaJqjR
 Anpj1QCvWbJvMWNT+Lpl6V1VL6bzytxtWfcYMb3+Th9BsWCCv+J7jRUIa7QAhznJz+Je/e0oJZN
 YEPt2N6pl6Nzjai0NTSz18AsU3E9CRyie//8VWuHej6mGXmjcH+BNW828nUXixSSFGY4PrcH5Lh
 +sBRV689hOSRldn+7MV4SV+iR3tULZx3Qf/Tt1g5I8XZ+BhEzyC0vBdPYbA5HN4hNcOhQQm0mRF
 2JiCp+7F7K61qfZ4j77YEDz5WMsxgydlfIdCSWLHn9bMw2UNUrJrHrAm7CrTUtaL/pnkq+LSzsP
 w9hzZi5BKegoMjazWWkya2SE32Ok9pFGSJY/NdMWlg+Mk5f04GIm1UiEbtCNutgEtRBIyXkyYVc
 TYP5bu
X-Received: by 2002:a05:600c:4706:b0:475:d8f3:71c1 with SMTP id
 5b1f17b1804b1-4778feb5327mr42374045e9.27.1763166405804; 
 Fri, 14 Nov 2025 16:26:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnycSQXWLd0/dVvgvIyqE8vpsmk/k3t9A3kjpe6jFzhpZiVe8kedIbDAgrPj07/sEOBv4eNg==
X-Received: by 2002:a05:600c:4706:b0:475:d8f3:71c1 with SMTP id
 5b1f17b1804b1-4778feb5327mr42373875e9.27.1763166405326; 
 Fri, 14 Nov 2025 16:26:45 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4778bcf9f27sm54769025e9.11.2025.11.14.16.26.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 16:26:44 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH] target/i386: svm: fix sign extension of exit code
Date: Sat, 15 Nov 2025 01:26:44 +0100
Message-ID: <20251115002644.103889-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The exit_code parameter of cpu_vmexit is declared as uint32_t, but exit
codes are 64 bits wide according to the AMD SVM specification.  And because
uint32_t is unsigned, this causes exit codes to be zero-extended, for example
writing SVM_EXIT_ERR as 0xffff_ffff instead of the expected 0xffff_ffff_ffff_ffff.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2977
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/helper-tcg.h        | 2 +-
 target/i386/tcg/system/svm_helper.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index be011b06b7c..e41cbda407a 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -99,7 +99,7 @@ void cpu_load_eflags(CPUX86State *env, int eflags, int update_mask);
 
 /* system/svm_helper.c */
 #ifndef CONFIG_USER_ONLY
-G_NORETURN void cpu_vmexit(CPUX86State *nenv, uint32_t exit_code,
+G_NORETURN void cpu_vmexit(CPUX86State *nenv, uint64_t exit_code,
                            uint64_t exit_info_1, uintptr_t retaddr);
 void do_vmexit(CPUX86State *env);
 #endif
diff --git a/target/i386/tcg/system/svm_helper.c b/target/i386/tcg/system/svm_helper.c
index 505788b0e26..4b86796518f 100644
--- a/target/i386/tcg/system/svm_helper.c
+++ b/target/i386/tcg/system/svm_helper.c
@@ -128,7 +128,7 @@ static inline bool virtual_gif_enabled(CPUX86State *env)
     return false;
 }
 
-static inline bool virtual_vm_load_save_enabled(CPUX86State *env, uint32_t exit_code, uintptr_t retaddr)
+static inline bool virtual_vm_load_save_enabled(CPUX86State *env, uint64_t exit_code, uintptr_t retaddr)
 {
     uint64_t lbr_ctl;
 
@@ -723,7 +723,7 @@ void helper_svm_check_io(CPUX86State *env, uint32_t port, uint32_t param,
     }
 }
 
-void cpu_vmexit(CPUX86State *env, uint32_t exit_code, uint64_t exit_info_1,
+void cpu_vmexit(CPUX86State *env, uint64_t exit_code, uint64_t exit_info_1,
                 uintptr_t retaddr)
 {
     CPUState *cs = env_cpu(env);
@@ -732,7 +732,7 @@ void cpu_vmexit(CPUX86State *env, uint32_t exit_code, uint64_t exit_info_1,
 
     qemu_log_mask(CPU_LOG_TB_IN_ASM, "vmexit(%08x, %016" PRIx64 ", %016"
                   PRIx64 ", " TARGET_FMT_lx ")!\n",
-                  exit_code, exit_info_1,
+                  (uint32_t)exit_code, exit_info_1,
                   x86_ldq_phys(cs, env->vm_vmcb + offsetof(struct vmcb,
                                                    control.exit_info_2)),
                   env->eip);
-- 
2.51.1



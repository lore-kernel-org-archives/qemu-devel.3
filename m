Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B66C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:23:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguWY-0003nV-Tl; Tue, 29 Jul 2025 20:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFj-00026S-P0
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:01:10 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFg-00047y-Hd
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:01:03 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-76aea119891so169677b3a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833659; x=1754438459; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HbNh72NRBcxI6GfG8dOhhgQoRzJWWLer1NVuaQWZvIA=;
 b=M8iO8o1YURggQxOChc7p3DLhZX5aP/xMHFEAc53WxYEvoxhocIZZ/NFSUkWtLPSVc9
 IjrUONdtTdYKWGvuaid2xt6xJgo7Un3FqQjzsB9eBAn6XDTJrIGfVVP9ZAZ8HG4IFOPr
 clR4CtNKo7D+WHEYRGPhQWJ/CubD50T6B9oAbl9wuKSjuDzkW48Ntk0tJ2iCNs8ihYkm
 1go82QnLLsKhPcZMMFnVv/RKvTTbUUcdjLoR/vtXuIbHc4suOaR0Hvx76VoMjsubdSL+
 oKuVNYnNY/WAlwv+ZNFT6/ssZYLng6ms7Fh4DsSeZkrDlgYAY3cO87GXRTmuNQEpRW8r
 KvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833659; x=1754438459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HbNh72NRBcxI6GfG8dOhhgQoRzJWWLer1NVuaQWZvIA=;
 b=QoStqv5Rc7Fx3mJJHzJAURQcYyJjij6z2/kohRNT6JQHrw5zsqu5cdX8vhfSh3b/BJ
 LKMDRxQ0FANKDXJoQek01ivYCgCank6gdJtqRNHjrwqoXmnNyGqOeLAzZM4xJsnJM44j
 glZsK9pxfxRnBRidAj+sdysS9FibEgfZfjRbW96FtAOIfg4jkhdPObn2kuTJjnJ+UXGt
 y7DTMrQOjgELNUNDq7OAv4niAQfmjua6we0uNvIEK5hnY1bs6juJObCDHPAPirz3GYd5
 77bQEiEOCfVtF9xHoMn1IemAHPbqtHQYqC/QZgMy12MZrfAb8cE7FVSb0UYHrqjg3LVK
 ajPQ==
X-Gm-Message-State: AOJu0Yw1i9E4yHe6G9N9e/WJqA/r1IhzR5Q7yqEQXDbxi7B95tKhHafA
 xGT/fnXN6xGdGboHV1KiajYg9QM/Z7jzdghezlGy6pC55f7rNAJPaoHSKx2Dn8GLjsNf90d0W5o
 SUtOC
X-Gm-Gg: ASbGncsmjExGjLXwpKUgS90k5aKXIDDmyyqSoa7FrEWGcScn+XAXtaE5emU0k6ZK6A3
 hfcoo7bdgZY2ggn9tha1Qyep8RHCUCctKztYoytI/UJFCWEiFbzghnaJSOB1V7NOBWTrMOdrhJS
 cNnzyVzO3J0dujMExvibZ0aaq9l/DzemPZ5SlRPwUe8mSr+Tj1ztXk4jqB/ZsHzFrCJ5Ke06x7O
 bolXQFHkUp6RcVlUzlb9OFVuBvBoq1xOcY7lnn6+HNqkBFkc5ywsKH6JeteNmjsn9yE+7+zfqcF
 ii6Tco70nIpe9atvb8vkOqJQ+K76X2QfDafVmU4YvFPCh7AFRXQ1tWml0gFWZ4GLuKtA8HYl0s+
 3qC+108tSFkliwlXXhT5QTK/w1o1uG/flUbgFTTd+JChQaoCsFyTIxjPZbNqFzKcDTiZjspk6Gj
 x2DdSYSDtpbA==
X-Google-Smtp-Source: AGHT+IH4eZfTBiSZjV2FuJjgLEY2DG3AYMTK1z3tGO0YELYS3ZUEVGwQDSo1UlIiNn8oaLNBIZu7xw==
X-Received: by 2002:a05:6300:210c:b0:23d:7a30:a82d with SMTP id
 adf61e73a8af0-23dc04be53dmr2101557637.5.1753833658189; 
 Tue, 29 Jul 2025 17:00:58 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-764090e178bsm9026087b3a.62.2025.07.29.17.00.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:00:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 35/89] linux-user/s390x: Create init_main_thread
Date: Tue, 29 Jul 2025 13:59:08 -1000
Message-ID: <20250730000003.599084-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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
 linux-user/elfload.c        |  9 +--------
 linux-user/s390x/cpu_loop.c | 15 ++++++++-------
 2 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 67c00f75fd..62452d7c45 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -804,14 +804,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUM68KState *e
 #define ELF_DATA	ELFDATA2MSB
 #define ELF_ARCH	EM_S390
 
-static inline void init_thread(struct target_pt_regs *regs, struct image_info *infop)
-{
-    regs->psw.addr = infop->entry;
-    regs->psw.mask = PSW_MASK_DAT | PSW_MASK_IO | PSW_MASK_EXT | \
-                     PSW_MASK_MCHECK | PSW_MASK_PSTATE | PSW_MASK_64 | \
-                     PSW_MASK_32;
-    regs->gprs[15] = infop->start_stack;
-}
+#define HAVE_INIT_MAIN_THREAD
 
 /* See linux kernel: arch/s390/include/uapi/asm/ptrace.h (s390_regs).  */
 #define ELF_NREG 27
diff --git a/linux-user/s390x/cpu_loop.c b/linux-user/s390x/cpu_loop.c
index c9124444ed..49e44548f8 100644
--- a/linux-user/s390x/cpu_loop.c
+++ b/linux-user/s390x/cpu_loop.c
@@ -180,12 +180,13 @@ void cpu_loop(CPUS390XState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
+void init_main_thread(CPUState *cs, struct image_info *info)
 {
-    int i;
-    for (i = 0; i < 16; i++) {
-        env->regs[i] = regs->gprs[i];
-    }
-    env->psw.mask = regs->psw.mask;
-    env->psw.addr = regs->psw.addr;
+    CPUArchState *env = cpu_env(cs);
+
+    env->psw.addr = info->entry;
+    env->psw.mask = PSW_MASK_DAT | PSW_MASK_IO | PSW_MASK_EXT |
+                    PSW_MASK_MCHECK | PSW_MASK_PSTATE | PSW_MASK_64 |
+                    PSW_MASK_32;
+    env->regs[15] = info->start_stack;
 }
-- 
2.43.0



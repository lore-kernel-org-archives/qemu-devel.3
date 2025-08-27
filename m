Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F5FCA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 23:27:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urPTM-0006Jf-VE; Wed, 27 Aug 2025 19:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPT7-0004sc-VR
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:22:18 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPT6-0004Om-0p
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:22:17 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-77053017462so310952b3a.1
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 16:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756336934; x=1756941734; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pUBD8oIvbmmAV90/hCSe5xxGHDkQPpbW/W14D5nKNic=;
 b=v64bCHa4qxLrU0ssmIQrb95p71OS+Htig7Jwe/cw1YR3KKqpwrS4DM2AZPgPzHiQgQ
 Jh6IUyoJ596fMephntTw5tZxcLLT1S4Iz4WCd90ypTANfh5hWqCzl8kOzmceQnPo4E+e
 Ab2RMbPT+th030sM3Qkxcucoklq1G4HM89FWHw8h5QRm0+N3DnfTcXpZXUPajR5RPdvo
 4t2htfn9NgJYzBS4jpgq6TFUGfnahD6NzVHuRBFZFzViASumZz4e2u1HYO9skLk89HvW
 8k9cZ2y9ZN2algVFLcAZi0DU6tSbdoBkInJVU0Xx5vG4xzVLr2sZdWoGsVYKUPic3qMi
 0mew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336934; x=1756941734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pUBD8oIvbmmAV90/hCSe5xxGHDkQPpbW/W14D5nKNic=;
 b=RN9hM+mjD7ljr7umuBp9zFUzGoW9a9zzu159Tksh+4dvPFeFpG8X2+QTxnFYxVSc5A
 lq6juYg+/r7tzb9xNfrf+28KD9jnckYxorpw+LtGfVYpWh6ycN36JPs5uTEUI98Lkm9i
 XsGXKE0gQhMKnHviz6BbE2QPvBL4GTcrN3lDB6eDxehLx21q8JOmHoA1qCplLI620LYh
 txi7gRROSsemorDvXpAb6xKjEMmRliSmMjMfONRDLNdUhzVKhZ5IHXm/J0WV6J+WkfeF
 tT6yI4VcbywUPQc8ONi2ywap3Ubd/hI5zhJ0AsPO/pCTYHNI80RdE3s3xT5+uWFQN/Yj
 JXVQ==
X-Gm-Message-State: AOJu0YxhIRodfdq1+aHtHvq4XchYM77SBN3ogupsdA0m0WFLmt4R1bQs
 5m/HpwPb1OXtpspdu2oA6/GDkmoHKgAAapZB57BZLUBu8SbG6Uadw38y97xxbzxDgnN1EIP4rJ1
 2mMqttdE=
X-Gm-Gg: ASbGncsTOtWqisCYTQ9c78dCxlcLa4yiqTGqkAuI0W0rGNfBo/DPnMr+ckqavCXRb6V
 abhvpLvcYed+i9Vg9T1ttgzhg/gjpXOXjvMb9GkdB023O8GQzHg1UdB0qgDaP2Uce8OjoT2KgVE
 KzbXQPmO2LX5Crg5p1PwH53T7fncKu6VbV6IF8H2+TDIQc9se8uPrRTs/CdQjoLGTsTGhCyRioN
 wjZ61u1dmtrp1J11vh+cw5uTqcBJ6onW+8OWh2DsX5JmbSTKjYC5OgL/3jvPBI8WKuqAe1aeFkU
 +A/gTNkFA8cDrbjSp9YqV4D20qgez2Uw6vXz2zqwthsC1KNYDTKHLUYSxhjx/fA0Ua3lHrpsDCL
 yUvHSz0N3825ANBQuaSAj3mhhuyjQuk0Ge9hT
X-Google-Smtp-Source: AGHT+IFAWe9GyDC7Do0OEmT+c0OUJI9GFafwndIiAG9itS0tp005sOu099By8eKI7H6/AMznTI3pFw==
X-Received: by 2002:a05:6a00:9288:b0:76b:d67b:2ee0 with SMTP id
 d2e1a72fcca58-7702f9d7f70mr32610187b3a.6.1756336934485; 
 Wed, 27 Aug 2025 16:22:14 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7703ffebd33sm13986886b3a.29.2025.08.27.16.22.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:22:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 39/46] linux-user/s390x: Create init_main_thread
Date: Thu, 28 Aug 2025 09:20:16 +1000
Message-ID: <20250827232023.50398-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827232023.50398-1-richard.henderson@linaro.org>
References: <20250827232023.50398-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c        |  9 +--------
 linux-user/s390x/cpu_loop.c | 15 ++++++++-------
 2 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index a7de852d4d..16aa09214e 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -798,14 +798,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUM68KState *e
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



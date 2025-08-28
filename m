Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 414F3CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 12:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urbRj-0002fV-Dc; Thu, 28 Aug 2025 08:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbRI-0002Im-NO
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:18 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbRG-0007BH-Gd
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:12 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-770593ba164so737513b3a.3
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756382947; x=1756987747; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lAavnXJ7yE/1AsmSwZsfUnpmtJ7slf2ooM6FGZiMZ74=;
 b=rKgLoNeIWKXULW/yQBC1JdOcnrVvdUC8auawGuwnH/7TwKFmiksebMq/v+QH4uNMT/
 dELnYsCQthgH7r97Bi7WpHMUoThjwU7khQLJdbkhReIZ7o7CxfR0aTX0TXR0+rjUKZ0q
 zRmJWbNbmqBGccaPfjfDMtFlcDrugeJjWVGeXxxrqEXFgacTLEX6P172oOqZ36V8cGYH
 Lp4mneeM9UnVgTfvTJHlQ41KP7j1e1ZbJOic5WfE/D8NmnRZ85YWYM0OvudGLCbfjZkJ
 y1FyZugL9qp0/FpruFBP+BQSF9ofAjCKCD6QdAwBHZybpZ8PGbKppzt6FJxWtSH/nSya
 GFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756382947; x=1756987747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lAavnXJ7yE/1AsmSwZsfUnpmtJ7slf2ooM6FGZiMZ74=;
 b=ix7B43JmMcuk1yRmerBY+HcjzhbZ2EUnDgmJo85RYP7JYYWIVLXL9boWdrgJnbJIEb
 haIKnQsu5K+5sYNvhafp3as0mdFKCoGbso+Xq9zHvc+QCEwLP5m2ohLn4Mgzvw2Hv2iS
 ZtAK39C/59jD6QTIFkRtZvhoU6ejOu1ZvqqhFBEDZ5ZV3Tk3DTn9d23HsAX20fkD56ja
 7zZBd4hOV4C9AxCboBfYef+eCeW2g9JtlaPsI5oaNLIZZClP77nUlktji0I8sv7qdt2W
 uhyIDFoS3+ED611iKgssj23YQjk/mkYTXWOagPcwBRmY8EtxR9PQSTpeYDaCVDPJuPdb
 SAMQ==
X-Gm-Message-State: AOJu0Yw8VuVC0fy8cPcownQvm1ydIKC3ORHIbRF9wpZpJn9RYMJJ1mqN
 VaDVOI1oyWkGS7AliCE4OI8grCDdk5Glt/Tpc2xqXRD63/ZFcVbn8nm5JEaUlI3dSGUd+YdQIG9
 KSlbzEHo=
X-Gm-Gg: ASbGncu61ODKczVM3OwEdXYLrtKRw00iXkotSRp3ew9J5skq+gHbFpS8i/gc/bgIGcn
 OJ5fCWNiV6VAz0QufZitjLvrHAI1ZLS/dCUW5XbFpl8POzbSsu2dM5MGR0dKSwWmttyF1koWpq9
 4ihkqVxDyhMqQYVfzxSjkvhTwqAc8284tkdkbvZ3W73zIV7KzCzGmFoCVErnMbS4cZ0YrJ3YqF9
 iVV8T0mU3pDn9NNrYAqHQLgPM1F5skOSyxr4PN0ypmCa42ROJcluGSuqDA31Xh8d3YsOUwULL0U
 8ICcmZl5mN6kloHkRgNpO8T6YugmKFrFH13wBWnBWKBE16HJsI2OCcJut9x897GklUvvaKw9hxW
 mvZ1SnT8GpS+bUmiiTbrlrghPAHAa3qsdKbz9
X-Google-Smtp-Source: AGHT+IE6WAFc+Nkh0mo7jvD7njkBAPU8DVa/OBN/XtkQiXZXhZCy/HyYhNNghsb329Ld3g3kOexXKQ==
X-Received: by 2002:a05:6a20:258a:b0:243:aa41:648a with SMTP id
 adf61e73a8af0-243aa4168e3mr4799163637.20.1756382947197; 
 Thu, 28 Aug 2025 05:09:07 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b49cb8b4b98sm13933222a12.19.2025.08.28.05.09.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:09:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 10/87] linux-user/sh4: Convert target_elf_gregset_t to a
 struct
Date: Thu, 28 Aug 2025 22:07:19 +1000
Message-ID: <20250828120836.195358-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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
 linux-user/elfload.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index da034e5a76..cc9140bf32 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -678,7 +678,9 @@ static void elf_core_copy_regs(target_elf_gregset_t *r,
 
 /* See linux kernel: arch/sh/include/asm/elf.h.  */
 #define ELF_NREG 23
-typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
 
 /* See linux kernel: arch/sh/include/asm/ptrace.h.  */
 enum {
@@ -691,22 +693,19 @@ enum {
     TARGET_REG_SYSCALL = 22
 };
 
-static inline void elf_core_copy_regs(target_elf_gregset_t *regs,
-                                      const CPUSH4State *env)
+static void elf_core_copy_regs(target_elf_gregset_t *r, const CPUSH4State *env)
 {
-    int i;
-
-    for (i = 0; i < 16; i++) {
-        (*regs)[i] = tswapreg(env->gregs[i]);
+    for (int i = 0; i < 16; i++) {
+        r->regs[i] = tswapreg(env->gregs[i]);
     }
 
-    (*regs)[TARGET_REG_PC] = tswapreg(env->pc);
-    (*regs)[TARGET_REG_PR] = tswapreg(env->pr);
-    (*regs)[TARGET_REG_SR] = tswapreg(env->sr);
-    (*regs)[TARGET_REG_GBR] = tswapreg(env->gbr);
-    (*regs)[TARGET_REG_MACH] = tswapreg(env->mach);
-    (*regs)[TARGET_REG_MACL] = tswapreg(env->macl);
-    (*regs)[TARGET_REG_SYSCALL] = 0; /* FIXME */
+    r->regs[TARGET_REG_PC] = tswapreg(env->pc);
+    r->regs[TARGET_REG_PR] = tswapreg(env->pr);
+    r->regs[TARGET_REG_SR] = tswapreg(env->sr);
+    r->regs[TARGET_REG_GBR] = tswapreg(env->gbr);
+    r->regs[TARGET_REG_MACH] = tswapreg(env->mach);
+    r->regs[TARGET_REG_MACL] = tswapreg(env->macl);
+    r->regs[TARGET_REG_SYSCALL] = 0; /* FIXME */
 }
 
 #define USE_ELF_CORE_DUMP
-- 
2.43.0



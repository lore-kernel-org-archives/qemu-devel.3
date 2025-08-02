Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 954E6C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLOv-0004NB-D1; Sat, 02 Aug 2025 19:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLOF-0003bJ-9b
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:11:51 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLOD-0001mf-Kp
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:11:47 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-4338d05970bso2037645b6e.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176304; x=1754781104; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uE6kEEA2yLsGbbdqUp9jlCxO7X+3Igj3rF1vo83t+uQ=;
 b=vmUgJiXGBvrTr8+vvfU7SNE6eIe4gpxh7coCnMsePB7KTDPk7FLBPr77T7aFGX3brv
 UwI3sWDPdX7UP1X+CLHIqdFbqNZebeR5W5arq39UKIqJsQszfErthpTIPKaEY6mcknv+
 jo7zCPjnLXx2eEjVOpgv5mv9JVxIcysyVQDuRPZSBlbSmiQGJEFTRLQXgmbRZBpE8VBU
 G3Yy7wbBD0kysYJ8LTKSZsrmQt8j2Y0Vuv7+g/2TG0DdSJGgacKG3BBPpJJjlCgo7Ati
 XFGpnxWuEEWjdQMgmX+h8pqOP62vn5TxD4viKUErrgT6TiqgBY7knpfEEA6YPtyLZIhC
 hXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176304; x=1754781104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uE6kEEA2yLsGbbdqUp9jlCxO7X+3Igj3rF1vo83t+uQ=;
 b=IS0CUggOC4sCmFjUxBO/6LGY+nHHryQLyT/92PVJJ+4UK+g/HZanKYGluGPoeKEF4Y
 uJAtNs3oAwkb7vRw6V0V5podRDr56KbeglErAGKchS7vGLxIktkwVBQSp26xT91JCTbm
 6mkEklB+vJ5t6s+/ChH/X69YHTuP2aHO+Ciey4zCojIIDu9U2Y2VJLWEPF5RYDLOW/DU
 NN50oSbQhD7Voxm4/tQQxihgvSUDhV2eMFK58F+0lgO5I/2eaCVLSyhvZHx/CLry6K26
 VWYUeDAPBqm7pyjhYQzc4mG2x8ZyEi89lKJJW/ygwHOaThlTiuyyhIRSY7VsUpCg5Umm
 eSzw==
X-Gm-Message-State: AOJu0YwhZeJ7xqAlz0ha4QEFclIvGOFj6lR9QlUTcFxUa1+tFcZoBCZC
 HzF0o4bAJ7x9celIkpp2OwDAuifesxbcJ7va7tX2HTrmI4KNDsjkyKPNlXzcMcj4YnHRUeEVnqV
 7VOVpHcA=
X-Gm-Gg: ASbGncvFtNJucf+cXHwA5hFZU424bqKHvZRj/TBZPE4FVkzGviOt9gLI8cUyYuWG/j6
 sHwnx6p4szHHpVWvkCVfuuaM7nQX7+rM5OZpA6BtZrnHz9FjRUpLvwZyzklqUwIFXLQ6ojgwaMn
 7zHkrxQ6ebJjyq5DJT0DYBKCy1tCV2e4kcQKjIZHp9eMVkvVgMiFTVmQr8UU3bMyMlfUOpC+f/1
 l8CjHrHpbZPvQRwYx40kXB1plIwE+tRwRRjk7JUIYMQNlRyKYJ0FNlMnmvYmS8mMf4nvxkWvOfj
 Lhe45KW4uyVHim/mO/MzmVbwHgHXq/DRXI/QH6Cnaj9Z/ILVGS9Gs3V7csirwAHVtCDsXLflNP+
 GXlrZw4f4HC6oqzRrrW/UOg3GPZsHb/km2SVYyIYxL+Er9X9MlxP1
X-Google-Smtp-Source: AGHT+IGc5oMo9FTSpBZmuGUpCt2Yl+ep6BeXgqBvJCsEIO6zOrpNKP7d4V3Wzx/NGwRor+Nrn51ytA==
X-Received: by 2002:a05:6808:3509:b0:406:7af5:30f2 with SMTP id
 5614622812f47-433f0363587mr3557172b6e.34.1754176304480; 
 Sat, 02 Aug 2025 16:11:44 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693ed9sm1084454eaf.20.2025.08.02.16.11.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:11:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 60/95] linux-user: Move elf_core_copy_regs to
 s390x/elfload.c
Date: Sun,  3 Aug 2025 09:04:24 +1000
Message-ID: <20250802230459.412251-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
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

Move elf_core_copy_regs to elfload.c.
Move ELF_NREG to target_elf.h.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/s390x/target_elf.h |  3 +++
 linux-user/elfload.c          | 28 ----------------------------
 linux-user/s390x/elfload.c    | 25 +++++++++++++++++++++++++
 3 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/linux-user/s390x/target_elf.h b/linux-user/s390x/target_elf.h
index cebace949a..f83fdbbddf 100644
--- a/linux-user/s390x/target_elf.h
+++ b/linux-user/s390x/target_elf.h
@@ -10,4 +10,7 @@
 
 #define HAVE_ELF_HWCAP          1
 
+/* See linux kernel: arch/s390/include/uapi/asm/ptrace.h (s390_regs).  */
+#define ELF_NREG                27
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index bc1a06a651..80f5c967da 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -453,34 +453,6 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 #define ELF_DATA	ELFDATA2MSB
 #define ELF_ARCH	EM_S390
 
-/* See linux kernel: arch/s390/include/uapi/asm/ptrace.h (s390_regs).  */
-#define ELF_NREG 27
-
-enum {
-    TARGET_REG_PSWM = 0,
-    TARGET_REG_PSWA = 1,
-    TARGET_REG_GPRS = 2,
-    TARGET_REG_ARS = 18,
-    TARGET_REG_ORIG_R2 = 26,
-};
-
-void elf_core_copy_regs(target_ulong *regs, const CPUS390XState *env)
-{
-    int i;
-    uint32_t *aregs;
-
-    regs[TARGET_REG_PSWM] = tswapl(env->psw.mask);
-    regs[TARGET_REG_PSWA] = tswapl(env->psw.addr);
-    for (i = 0; i < 16; i++) {
-        regs[TARGET_REG_GPRS + i] = tswapl(env->regs[i]);
-    }
-    aregs = (uint32_t *)&regs[TARGET_REG_ARS];
-    for (i = 0; i < 16; i++) {
-        aregs[i] = tswap32(env->aregs[i]);
-    }
-    regs[TARGET_REG_ORIG_R2] = 0;
-}
-
 #define ELF_EXEC_PAGESIZE 4096
 
 #define VDSO_HEADER "vdso.c.inc"
diff --git a/linux-user/s390x/elfload.c b/linux-user/s390x/elfload.c
index 79ceaba51d..38d72a36f9 100644
--- a/linux-user/s390x/elfload.c
+++ b/linux-user/s390x/elfload.c
@@ -66,3 +66,28 @@ const char *elf_hwcap_str(uint32_t bit)
 
     return bit < ARRAY_SIZE(hwcap_str) ? hwcap_str[bit] : NULL;
 }
+
+enum {
+    TARGET_REG_PSWM = 0,
+    TARGET_REG_PSWA = 1,
+    TARGET_REG_GPRS = 2,
+    TARGET_REG_ARS = 18,
+    TARGET_REG_ORIG_R2 = 26,
+};
+
+void elf_core_copy_regs(target_ulong *regs, const CPUS390XState *env)
+{
+    int i;
+    uint32_t *aregs;
+
+    regs[TARGET_REG_PSWM] = tswapl(env->psw.mask);
+    regs[TARGET_REG_PSWA] = tswapl(env->psw.addr);
+    for (i = 0; i < 16; i++) {
+        regs[TARGET_REG_GPRS + i] = tswapl(env->regs[i]);
+    }
+    aregs = (uint32_t *)&regs[TARGET_REG_ARS];
+    for (i = 0; i < 16; i++) {
+        aregs[i] = tswap32(env->aregs[i]);
+    }
+    regs[TARGET_REG_ORIG_R2] = 0;
+}
-- 
2.43.0



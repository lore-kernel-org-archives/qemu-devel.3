Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3446AC87FCA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:33:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugucX-0007PI-L8; Tue, 29 Jul 2025 20:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguIy-0004c5-Ka
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:24 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguIw-0004ck-LS
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:24 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-749068b9b63so243473b3a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833861; x=1754438661; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cHKDA3MYY+3w5ibCRid/5s78R4F3SfCi8Nz9mUhj/44=;
 b=KSZz1sDWBPlekf6fW0v075X4V8+uMKwrUqekvqVtY9qd6wTuvIlkxckRXqu2VmSheu
 XQgJK1TkNXrYJXxQMc1iGDo01k0QRvIOfBMW0kVAWmcGRUpS7eqdtIc/9tp6Dh7rBHxY
 Hd5zWyFq4LmGw01me/eXsKlSR+IJslReNNI1R+PGNh0ttFraT/TEHcW5b90l5/Ce1PEZ
 rdpVRZpFGaqiD8vPBFbXzAvXj5jqJ4vx+Ut9WBvUqhja0zpXekKVcRwWQYtoSuoAEkbd
 /xxbUvzQWqXT2yR61w4YnmIL286Kk209B0ybFnomAqy5M/ijGInieR5GFAQ5/I6QJjlh
 DUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833861; x=1754438661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cHKDA3MYY+3w5ibCRid/5s78R4F3SfCi8Nz9mUhj/44=;
 b=HdbXj4yymEQ5aQbwdAEWiQC4Irq+p9T5t9ClCeR97llkmqZ4LsBVExOfioAyNluDSH
 NPzmO1WA3gKVoxC5JJGd36DMNO9EtiQFStg2kyclt8IH9A+O90fmWFBG7Men5E+5uigg
 RTR+ubpwUGekXgG+Aux875wu6yLovRvVoyZNp7biote4/v3ft6m9Rb+m/WRUM+lFJRw+
 s9mkM0ZqQ0yxTKoxfHU902L5TcRgRDvjWgwMoXYJonSIvHd3iSule9ZDWZ07bShApncb
 Hw0nE2MVNr3CgrgVXYFqcvDW/u25+pOKHpU90yb7drReiMKwxF4a65Fvul25EH7ajMP3
 SzjQ==
X-Gm-Message-State: AOJu0YxMccroOqpzALckv1DXqLofb1LIk2WKLrPJw1xcVgt77V59kaYE
 l/MJgxWj9WVoElOQkaj85Z1vEnddk9CyYqUrXpkG+Y6x47eyLt/DxhSqUZmyeWCF5m1bI7lVP68
 QmCNr
X-Gm-Gg: ASbGncvdDBXafv415w5S3+dN8rAZI7kew01rKHZS5ycADii9IL0HmUI4pJcGcDaiE3x
 g2+sbEynSIylD5HT1hOQwdgeeCqvToR77GJpOfPMZ8P0vqwcuC6tBlcxx3Z63Rzwh3cA3/MI1xJ
 Qpm4uOuQpDTqdbFWFkP8I48fiXiRyCVjIAj4IVPZu3x+uyZDAkoMYkthb0sDhS39AA3BuKdZPD6
 soWY4Kwqt2LppPox/Gyazto2lXwdui7B5grrEuBiKnA32sVt8Be4qmvs8Qxok+Y4a95ytGY5so1
 zKx5Xa0XRBt3Rx7wkTfGtI9ibNUMp2po7NFxjEn7SUktRUYNKiji5SxncSBmSjeDs8JkMS/5vU1
 OhxNWUjvxPvYI/qfid/CvXL1rB+GIun2oNywWq3z9ecbD0AbUbJa3ItL0Pv6PPmB+B69xtQACL4
 WlM5tdGLkA6w==
X-Google-Smtp-Source: AGHT+IHR77/pxwKVNnLZ1nAh3kZkP3+f72PlKFhaWkVHSgUyPJ5vWubAUDHo/OBR1rB8G7OTLzQKeA==
X-Received: by 2002:a05:6a00:3a1e:b0:74d:f997:1b45 with SMTP id
 d2e1a72fcca58-76ab0921c40mr2401481b3a.8.1753833861114; 
 Tue, 29 Jul 2025 17:04:21 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640ad06762sm9101302b3a.80.2025.07.29.17.04.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:04:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 51/89] linux-user/m68k: Split out target_coredump.c.inc
Date: Tue, 29 Jul 2025 13:59:24 -1000
Message-ID: <20250730000003.599084-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
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
 linux-user/elfload.c                  | 29 +-------------------------
 linux-user/m68k/target_coredump.c.inc | 30 +++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 28 deletions(-)
 create mode 100644 linux-user/m68k/target_coredump.c.inc

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 836f01e579..d9def102e3 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -469,34 +469,7 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 #define ELF_CLASS       ELFCLASS32
 #define ELF_ARCH        EM_68K
 
-/* See linux kernel: arch/m68k/include/asm/elf.h.  */
-#define ELF_NREG 20
-typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
-
-static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUM68KState *env)
-{
-    (*regs)[0] = tswapreg(env->dregs[1]);
-    (*regs)[1] = tswapreg(env->dregs[2]);
-    (*regs)[2] = tswapreg(env->dregs[3]);
-    (*regs)[3] = tswapreg(env->dregs[4]);
-    (*regs)[4] = tswapreg(env->dregs[5]);
-    (*regs)[5] = tswapreg(env->dregs[6]);
-    (*regs)[6] = tswapreg(env->dregs[7]);
-    (*regs)[7] = tswapreg(env->aregs[0]);
-    (*regs)[8] = tswapreg(env->aregs[1]);
-    (*regs)[9] = tswapreg(env->aregs[2]);
-    (*regs)[10] = tswapreg(env->aregs[3]);
-    (*regs)[11] = tswapreg(env->aregs[4]);
-    (*regs)[12] = tswapreg(env->aregs[5]);
-    (*regs)[13] = tswapreg(env->aregs[6]);
-    (*regs)[14] = tswapreg(env->dregs[0]);
-    (*regs)[15] = tswapreg(env->aregs[7]);
-    (*regs)[16] = tswapreg(env->dregs[0]); /* FIXME: orig_d0 */
-    (*regs)[17] = tswapreg(env->sr);
-    (*regs)[18] = tswapreg(env->pc);
-    (*regs)[19] = 0;  /* FIXME: regs->format | regs->vector */
-}
-
+#include "target_coredump.c.inc"
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE       8192
 
diff --git a/linux-user/m68k/target_coredump.c.inc b/linux-user/m68k/target_coredump.c.inc
new file mode 100644
index 0000000000..99821759a3
--- /dev/null
+++ b/linux-user/m68k/target_coredump.c.inc
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/* See linux kernel: arch/m68k/include/asm/elf.h.  */
+#define ELF_NREG 20
+typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
+
+static void elf_core_copy_regs(target_elf_gregset_t *regs,
+                               const CPUM68KState *env)
+{
+    (*regs)[0] = tswapreg(env->dregs[1]);
+    (*regs)[1] = tswapreg(env->dregs[2]);
+    (*regs)[2] = tswapreg(env->dregs[3]);
+    (*regs)[3] = tswapreg(env->dregs[4]);
+    (*regs)[4] = tswapreg(env->dregs[5]);
+    (*regs)[5] = tswapreg(env->dregs[6]);
+    (*regs)[6] = tswapreg(env->dregs[7]);
+    (*regs)[7] = tswapreg(env->aregs[0]);
+    (*regs)[8] = tswapreg(env->aregs[1]);
+    (*regs)[9] = tswapreg(env->aregs[2]);
+    (*regs)[10] = tswapreg(env->aregs[3]);
+    (*regs)[11] = tswapreg(env->aregs[4]);
+    (*regs)[12] = tswapreg(env->aregs[5]);
+    (*regs)[13] = tswapreg(env->aregs[6]);
+    (*regs)[14] = tswapreg(env->dregs[0]);
+    (*regs)[15] = tswapreg(env->aregs[7]);
+    (*regs)[16] = tswapreg(env->dregs[0]); /* FIXME: orig_d0 */
+    (*regs)[17] = tswapreg(env->sr);
+    (*regs)[18] = tswapreg(env->pc);
+    (*regs)[19] = 0;  /* FIXME: regs->format | regs->vector */
+}
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42405C79FB7
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 01:35:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Tgo-0003L2-8B; Wed, 09 Sep 2026 21:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x4Tgm-0003Kb-FA
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 21:34:56 -0400
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x4Tgk-00023d-VP
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 21:34:56 -0400
Received: by mail-yx2-x10.google.com with SMTP id
 956f58d0204a3-66e56a1b327so1743242d50.0
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 18:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789004094; x=1789608894; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EepW7BVjwaHm6f3geK9JiE92QCiwBl/wJ9Adx9HIkQU=;
 b=o+4BjxCCUlHPEAkFB+5l/Mg3HmRD1qP5CBoeIkxXOt4kn8cENCuEbrWdxog0QeY1v0
 +5060gHmTFMrr5D4yj8b7mCgpg4eg9Cudi+eKccmCjf0JPdfcPKXrjqvCAvxpRCj2Ha0
 7UYLTvoOQ8CE/h01eZYcra4sSEBhE/Bl8X3O9AMz5ls9HRDIhauINp7rjTtDuDDGY82X
 rszutDC/+ZWCI+M7/5bjvw8Nr4njvYqoNiSgw6GN0FyaGA98oBf5vqRdrmeXj9F2GHRM
 lFl3q3JKtKP7VY7MXvzjfzr0vMqSkB1nYoW21Q8IyYT4q06m5lZFHz7XEUipyDYcPSJN
 H4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789004094; x=1789608894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EepW7BVjwaHm6f3geK9JiE92QCiwBl/wJ9Adx9HIkQU=;
 b=mjPA1RniUZnDlLzhYq4Ohi0Lq/LlrsDAPK2z206gTmdPzd0v0oWvvecOAyVaixcZKt
 nO44NhvxRZH/jdQbEDSyF2Fk4JjShbua9Vsw8ZvrGPX4AINgnog9NTu7cueYAO6Gq64L
 //dL1wwGrWOFcP9/k7l50Vzh4CvN/JPFCZktGZ2OHmXi2XxRFKzxywe99IAdn86hWJ6b
 Y+fGWEtgsEIuTdmD8jhBvM0Aez3OFaKFvDWAkEygqCOkLoAEmMhSYqWVHFsIC04ywxSp
 VqQwvOf2ZVmZ34FjZcrUOR9BJzPF7KH7u3zQlfRZrrreyGS3WQXkWNuPqYp7E48Qo9c3
 99nw==
X-Gm-Message-State: AFuF++nXNtLKEQFec88+yCkj2bV7SNkN6DXQbT+If7b68AEc8nnDArKO
 TfGWRPf9Vc2ojpY82mj2NHmaoVOwImWxLO6PB9D5fcEMlw+6fhGyXH7QITDY0ZDQ
X-Gm-Gg: AYBFou32LnT+KS5rLjmdaKTuhR1RDoLtjCGqBkuBcl5Fv5ltyL2RGU3E/kYz82ORcFn
 zpQV43XtHiqZBiqQCMXlhDMZyutDDYohL4/0zfAWt2vUmQYmfLuyezt0LWIVtY+CcmyioD4lOdw
 0YpPALkEf/c94U3aMWgjvnrCYCo/SUmwBWxQEOkRA8pbKuZSdC9Bh8wOCEQDAI/AMQkaaHXnFZR
 0c7O69L+wdeP1vu2/cXqta8X6jJWOlghYueAS8Jzv0Qm7NWKW+t0hmPdJP+LjoNWD5krCpZuQkg
 0TbN8W0lhnXjTmqWcDo7Vdrgo+aRsxvgVJf5v5jhldaYw7lENnD5Ito4+tVg4UuPY/unl2JhZpF
 lB0hFinNCcXTRxOdJ/gzbx6vlA/0uavxy6ZQSGME4LEk1VpEkjYAquvWOmAqtPTEQXqmBFXtBwQ
 s3A+IdyKE9d3L53Zj5cQhbOWUsoNcfS3TYqg5ANNZjEhwer4SuIkW3043kw6oJy5exTpKnm/xJ4
 zPz3Uu/tg==
X-Received: by 2002:a05:690e:1247:b0:66f:da5b:b87c with SMTP id
 956f58d0204a3-6710371d934mr3071151d50.41.1789004089224; 
 Wed, 09 Sep 2026 18:34:49 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66fb48b374bsm13226841d50.3.2026.09.09.18.34.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 18:34:48 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 3/3] linux-user/x86_64: write the floating-point registers to
 a core dump
Date: Wed,  9 Sep 2026 21:34:42 -0400
Message-ID: <20260910013442.1517793-4-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260910013442.1517793-1-mattst88@gmail.com>
References: <20260910013442.1517793-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:41::10;
 envelope-from=mattst88@gmail.com; helo=mail-yx2-x10.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

A guest core carried only the general-purpose registers, so a debugger
opening one reported the x87 stack and every SSE register as
unavailable.

Implement HAVE_ELF_CORE_FPREGS for x86_64: define target_elf_fpregset_t
to match the kernel's elf_fpregset_t, i.e. struct user_i387_struct from
arch/x86/include/asm/user_64.h, which is the 512 byte FXSAVE image, and
fill it with the existing cpu_x86_fxsave(). As on the signal path, the
helper writes in target byte order, so there is nothing to swap.

QEMU's FXSAVE writes zero for the instruction and operand pointers and
never writes the opcode field, as it does everywhere else, so those
three fields are not recovered from a core.

Checked with gdb on a core from a program that faults with live values
on the x87 stack and in xmm0 and xmm1: "info float" reads back the stack
and the tag word, and the xmm registers and $mxcsr read correctly.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 linux-user/x86_64/elfload.c    | 11 +++++++++++
 linux-user/x86_64/target_elf.h | 20 ++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git ./linux-user/x86_64/elfload.c ./linux-user/x86_64/elfload.c
index 121a8167ac..4560106faf 100644
--- ./linux-user/x86_64/elfload.c
+++ ./linux-user/x86_64/elfload.c
@@ -42,6 +42,17 @@ bool init_guest_commpage(void)
     return true;
 }
 
+void elf_core_copy_fpregs(target_elf_fpregset_t *r, const CPUX86State *env)
+{
+    QEMU_BUILD_BUG_ON(sizeof(*r) != sizeof(X86LegacyXSaveArea));
+    /*
+     * The helper stores the image in target byte order.  cpu_x86_fxsave()
+     * folds the softfloat exception flags back into env->mxcsr, so the
+     * const has to go.
+     */
+    cpu_x86_fxsave((CPUX86State *)env, r, sizeof(*r));
+}
+
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPUX86State *env)
 {
     r->pt.r15 = tswapal(env->regs[15]);
diff --git ./linux-user/x86_64/target_elf.h ./linux-user/x86_64/target_elf.h
index 840bddf5ec..23f84f6a91 100644
--- ./linux-user/x86_64/target_elf.h
+++ ./linux-user/x86_64/target_elf.h
@@ -27,4 +27,24 @@ typedef struct target_elf_gregset_t {
     struct target_user_regs_struct pt;
 } target_elf_gregset_t;
 
+/*
+ * Matches the kernel's elf_fpregset_t, i.e. struct user_i387_struct from
+ * arch/x86/include/asm/user_64.h, which is the 512 byte FXSAVE image.
+ */
+#define HAVE_ELF_CORE_FPREGS    1
+
+typedef struct target_elf_fpregset_t {
+    uint16_t cwd;             /* FPU control word                   */
+    uint16_t swd;             /* FPU status word                    */
+    uint16_t twd;             /* abridged tag word, not the x87 one */
+    uint16_t fop;             /* last instruction opcode            */
+    uint64_t rip;             /* instruction pointer                */
+    uint64_t rdp;             /* data pointer                       */
+    uint32_t mxcsr;
+    uint32_t mxcsr_mask;
+    uint32_t st_space[32];    /*  8 * 16 bytes for st0-st7          */
+    uint32_t xmm_space[64];   /* 16 * 16 bytes for xmm0-xmm15       */
+    uint32_t padding[24];
+} target_elf_fpregset_t;
+
 #endif
-- 
2.54.0



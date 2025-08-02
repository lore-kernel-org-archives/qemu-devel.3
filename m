Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF0CC87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:23:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLOs-0004Fn-3l; Sat, 02 Aug 2025 19:12:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLOd-0003sA-Vj
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:12:14 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLOc-0001qj-8O
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:12:11 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-741a254d4a0so886343a34.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176329; x=1754781129; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cBh0dJ0blSoCHT9xDRizOiJZ4DluKa4hv5tDy/lDBuE=;
 b=cWPLp/XgsBoXrvYLCoBqKOypJQvXKbjiP85EtDyFIYWlBkJ6Gn78gd4uwYCpdwImjO
 rFDUELqQ4896xggV73EieK2n/ETWjF0PHaXMj0g8ZM4YIIp/09GMp0pCU6+ZThKdLodj
 5A01bqQXLpWzMxDe0E/xGsIkEfI0LiQyiYpSRG/efTZFXvnqvUnDmb4PjwjYSpgjTTXI
 QVkL9mr8RdUk70k5bqsZcDluddxuWxC4DzFSUEkadvNlBYQqZw8U7i0wFR2xswtfXV74
 eUboBL1ekTXczFm68C3/9L1Pjc8/+a9duxDwUEXf2N+f/MBZ2YEHWy370Ekp4YPqdaiU
 JTeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176329; x=1754781129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cBh0dJ0blSoCHT9xDRizOiJZ4DluKa4hv5tDy/lDBuE=;
 b=HFGcOZRAZVAKeLu+0fX+sDKbzHhLeb3ahck7xTHAtQLXmw8FbvHmLzY6fbVMRR9t0l
 BK6Qx/SO7kr/Ek5lpKIqJPDjVf0MgFd7I5+vgxs8ERmTlkRAkI0lZdIzgBccQpltkRjb
 hTow/fJSWUb4IRrSu82STBXy25tnsZBj+Pds60HBCCgWfkvobLjUrCjNY1kSJ7IUMmY/
 /b/lc38GDYoCD64RLaBi1F6CSdtTuYzoSG+AVlG3oAynY+IGprN+akmZoi7Wla5+it13
 OlD4IHD9U9mQalus2mA34L4poPK2UQp8eRPNxxNWFxl/WFqUjgS5hzW16Z33Te7L50bD
 6ugQ==
X-Gm-Message-State: AOJu0Yy6j7+a43iuOh68M3en8MJKXo18WHYHHNA4LEGLc6iUCs4Crg0l
 Mxmv3RTLEcl/zmfAP+Lk/PQ6lm+JRpKeeXTuvjzWqxTEQSR9wuKkxcRC1m0c6qYliFtjZHatLzo
 toz8hlt4=
X-Gm-Gg: ASbGncsCgIocZ/mfznYroZupD5R5WY9KPt6fdd9P4gu0g83mWxAH4mJ9Ph81o0iY6U+
 0Cvia4tw0BMyvMaZXIyVaDHK6K34+PNoAzKdcPQ0oXEXCsb/Ks8DP20oq2dbmyVXDAuZcIyfgXT
 yt3RUD6imgbwDVsfFUIRPSCMYAR9zfN44vy40p8Zp802S3iZxvFDDjTtSqmBZi4A8WhRp/BzxTV
 Ac0oROwzfk6NV7WCJHG1u+p5Ikikk3fZR2wVCUFJtGCdHLHFHd/DoEYkJdiEMk3j0ajF1oI4oV/
 4E4GlFkn1ZNU76yTfUb50MEHfeN7DJHZZ8BzL0oj9j0BaSaNdcjw13mgeNq4w2EOH1y2Pvd7S5D
 PNP4IWHRwgrSqKZc69k92Kj1wh22kk4rWqkdGziobpZxKOPdIzXS2
X-Google-Smtp-Source: AGHT+IFQ67CPp43hXmebAdGul71evRqxTiIJ97/jB21H2ijxTzchfsd5euD8990R3v7Gt+H/1TaiRQ==
X-Received: by 2002:a05:6808:2185:b0:426:8e15:6a4a with SMTP id
 5614622812f47-4334f66b360mr5889030b6e.0.1754176328899; 
 Sat, 02 Aug 2025 16:12:08 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693ed9sm1084454eaf.20.2025.08.02.16.12.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:12:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 67/95] linux-user: Remove ELF_EXEC_PAGESIZE
Date: Sun,  3 Aug 2025 09:04:31 +1000
Message-ID: <20250802230459.412251-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x334.google.com
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

Use TARGET_PAGE_SIZE instead.  If the target page size may vary,
using a different fixed size is wrong.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 32 ++------------------------------
 1 file changed, 2 insertions(+), 30 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 8cf9a1d77f..e700bc7642 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -167,8 +167,6 @@ typedef abi_int         target_pid_t;
 
 #define VDSO_HEADER "vdso.c.inc"
 
-#define ELF_EXEC_PAGESIZE       4096
-
 #endif /* TARGET_I386 */
 
 #ifdef TARGET_ARM
@@ -180,16 +178,12 @@ typedef abi_int         target_pid_t;
 #define ELF_CLASS       ELFCLASS32
 #define EXSTACK_DEFAULT true
 
-#define ELF_EXEC_PAGESIZE       4096
-
 #else
 /* 64 bit ARM definitions */
 
 #define ELF_ARCH        EM_AARCH64
 #define ELF_CLASS       ELFCLASS64
 
-#define ELF_EXEC_PAGESIZE       4096
-
 #if TARGET_BIG_ENDIAN
 # define VDSO_HEADER  "vdso-be.c.inc"
 #else
@@ -258,8 +252,6 @@ typedef abi_int         target_pid_t;
         NEW_AUX_ENT(AT_UCACHEBSIZE, 0);                 \
     } while (0)
 
-#define ELF_EXEC_PAGESIZE       4096
-
 #ifndef TARGET_PPC64
 # define VDSO_HEADER  "vdso-32.c.inc"
 #elif TARGET_BIG_ENDIAN
@@ -280,8 +272,6 @@ typedef abi_int         target_pid_t;
 
 #define VDSO_HEADER "vdso.c.inc"
 
-#define ELF_EXEC_PAGESIZE        4096
-
 #endif /* TARGET_LOONGARCH64 */
 
 #ifdef TARGET_MIPS
@@ -300,8 +290,6 @@ typedef abi_int         target_pid_t;
 #define elf_check_abi(x) (!((x) & EF_MIPS_ABI2))
 #endif
 
-#define ELF_EXEC_PAGESIZE        4096
-
 #endif /* TARGET_MIPS */
 
 #ifdef TARGET_MICROBLAZE
@@ -311,8 +299,6 @@ typedef abi_int         target_pid_t;
 #define ELF_CLASS   ELFCLASS32
 #define ELF_ARCH    EM_MICROBLAZE
 
-#define ELF_EXEC_PAGESIZE        4096
-
 #endif /* TARGET_MICROBLAZE */
 
 #ifdef TARGET_OPENRISC
@@ -321,8 +307,6 @@ typedef abi_int         target_pid_t;
 #define ELF_CLASS ELFCLASS32
 #define ELF_DATA  ELFDATA2MSB
 
-#define ELF_EXEC_PAGESIZE 8192
-
 #endif /* TARGET_OPENRISC */
 
 #ifdef TARGET_SH4
@@ -330,8 +314,6 @@ typedef abi_int         target_pid_t;
 #define ELF_CLASS ELFCLASS32
 #define ELF_ARCH  EM_SH
 
-#define ELF_EXEC_PAGESIZE        4096
-
 #endif
 
 #ifdef TARGET_M68K
@@ -339,8 +321,6 @@ typedef abi_int         target_pid_t;
 #define ELF_CLASS       ELFCLASS32
 #define ELF_ARCH        EM_68K
 
-#define ELF_EXEC_PAGESIZE       8192
-
 #endif
 
 #ifdef TARGET_ALPHA
@@ -348,8 +328,6 @@ typedef abi_int         target_pid_t;
 #define ELF_CLASS      ELFCLASS64
 #define ELF_ARCH       EM_ALPHA
 
-#define ELF_EXEC_PAGESIZE        8192
-
 #endif /* TARGET_ALPHA */
 
 #ifdef TARGET_S390X
@@ -358,8 +336,6 @@ typedef abi_int         target_pid_t;
 #define ELF_DATA	ELFDATA2MSB
 #define ELF_ARCH	EM_S390
 
-#define ELF_EXEC_PAGESIZE 4096
-
 #define VDSO_HEADER "vdso.c.inc"
 
 #endif /* TARGET_S390X */
@@ -376,8 +352,6 @@ typedef abi_int         target_pid_t;
 #define VDSO_HEADER "vdso-64.c.inc"
 #endif
 
-#define ELF_EXEC_PAGESIZE 4096
-
 #endif /* TARGET_RISCV */
 
 #ifdef TARGET_HPPA
@@ -396,8 +370,6 @@ typedef abi_int         target_pid_t;
 #define ELF_CLASS       ELFCLASS32
 #define ELF_ARCH        EM_XTENSA
 
-#define ELF_EXEC_PAGESIZE       4096
-
 #endif /* TARGET_XTENSA */
 
 #ifdef TARGET_HEXAGON
@@ -2677,7 +2649,7 @@ static int wmr_fill_region_phdr(void *opaque, vaddr start,
     phdr->p_flags = (flags & PAGE_READ ? PF_R : 0)
                   | (flags & PAGE_WRITE_ORG ? PF_W : 0)
                   | (flags & PAGE_EXEC ? PF_X : 0);
-    phdr->p_align = ELF_EXEC_PAGESIZE;
+    phdr->p_align = TARGET_PAGE_SIZE;
 
     bswap_phdr(phdr, 1);
     d->phdr = phdr + 1;
@@ -2785,7 +2757,7 @@ static int elf_core_dump(int signr, const CPUArchState *env)
     offset += size_note("CORE", sizeof(struct target_elf_prpsinfo));
     offset += size_note("CORE", sizeof(struct target_elf_prstatus)) * cpus;
     note_size = offset - note_offset;
-    data_offset = ROUND_UP(offset, ELF_EXEC_PAGESIZE);
+    data_offset = TARGET_PAGE_ALIGN(offset);
 
     /* Do not dump if the corefile size exceeds the limit. */
     if (dumpsize.rlim_cur != RLIM_INFINITY
-- 
2.43.0



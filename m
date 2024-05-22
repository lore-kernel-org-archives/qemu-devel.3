Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B22C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 03:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9cuI-0003RE-BZ; Tue, 21 May 2024 23:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9cuH-0003R1-Da
 for qemu-devel@nongnu.org; Tue, 21 May 2024 23:44:49 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9cuE-00049z-Or
 for qemu-devel@nongnu.org; Tue, 21 May 2024 23:44:49 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6f1242f1dcdso2651313a34.3
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 20:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716349484; x=1716954284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ClmjZOy3QQNiKciKtrEnKHv+DzIwPzBDEJYBBNDBr+E=;
 b=EaseiIvlNAgFLx9w/lZSWwTK7QD1NDoEm43To1yrYMKdOf4Pm0heydnuY8FABHz3XZ
 PnR+o7PlSX1F/XFdPhMnAHoSeQpu21xeStYmVWrR4XOHvJ0+wrqE963S3S3k7bnLUTny
 ppd5GAGw613gQ/AvG9g5x4fzKH3OqffIvovgKGmRWhUU1UekBBG9UtlUZYVON+zqQNRl
 rUfR+NsDVmOpEBd8c0uu66+HzwJa1ulrV4fllxvoPxb0NHlnkL813fKvKm59XSd4v53n
 fvNXfy2k9qqiJ3gvjgkz+UTgbcwhALF/8BzgDZvvBVSZBziagO1YeJpYA500mo+IcjF2
 1hjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716349484; x=1716954284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ClmjZOy3QQNiKciKtrEnKHv+DzIwPzBDEJYBBNDBr+E=;
 b=uYR+VFMCGFAWmxCV0ZMHC6ZzMp/lpkutKxATGc3oxZK27wwp684HaRbs6qv0MQYvjY
 Cb6mZLgkTdgBhnAgY3gJSdL3ot2R3lHkVDmbURz74i/HkCe/8Ks48/Kdt2dHMZaaUf3d
 G25Af8yhc+HrJS/QzYq6A55FDNzcaUIQMQ0GCvtCJ4l5iILh0oJnXG5oyO6ugUzGKmiR
 +zxBfDq4HoMFQU8KWm2ipQBQ5WyDnp1UEGTHbD4Rqb+g8LMwS0dPw+NwwY5hI9Nyystu
 Vj8EdnSvDDQXTPrxOKdOHCVT+wkSI26FWvPw9kbiuwmTIOAerL5tlsplyvoFJrmv0kA5
 XOIg==
X-Gm-Message-State: AOJu0YxHDYAinTDS27Q0DZft1V2Fh90u5J0LxTBibMFaFdS/DtXxiOX+
 P1fShcOIq4e+aEERSfZW3cvRhjdBFPB7CYpHBQUEQoXAGwRlj/kHFp9l4Q0p8AnfSALU/D86l8U
 t
X-Google-Smtp-Source: AGHT+IEvfh3LfDGQx1RVE09ovmRHUf4g5MePJitgJP2E6RyGEPEY80LLbo4/XosJdxTRzicwiTWgFA==
X-Received: by 2002:a05:6870:59d:b0:221:1c2f:23ee with SMTP id
 586e51a60fabf-24c68b5de72mr976548fac.22.1716349484414; 
 Tue, 21 May 2024 20:44:44 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2af2bafsm21416617b3a.162.2024.05.21.20.44.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 20:44:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	mark.cave-ayland@ilande.co.uk
Subject: [PATCH RISU v2 1/8] risu: Allow use of ELF test files
Date: Tue, 21 May 2024 20:44:35 -0700
Message-Id: <20240522034442.140293-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522034442.140293-1-richard.henderson@linaro.org>
References: <20240522034442.140293-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
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

By using elf files, we make it easier to disassemble
the test file, to match comparison failures to code.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 5 deletions(-)

diff --git a/risu.c b/risu.c
index c28b4a5..c9c3a38 100644
--- a/risu.c
+++ b/risu.c
@@ -24,6 +24,15 @@
 #include <sys/mman.h>
 #include <fcntl.h>
 #include <string.h>
+#include <elf.h>
+
+/* TODO: Improve configure. */
+#ifdef __linux__
+#include <endian.h>
+#define HOST_BIG_ENDIAN  (__BYTE_ORDER == __BIG_ENDIAN)
+#else
+#error Need HOST_BIG_ENDIAN
+#endif
 
 #include "config.h"
 #include "risu.h"
@@ -346,8 +355,11 @@ static void load_image(const char *imgfile)
 {
     /* Load image file into memory as executable */
     struct stat st;
+    void *addr;
+    int fd;
+
     fprintf(stderr, "loading test image %s...\n", imgfile);
-    int fd = open(imgfile, O_RDONLY);
+    fd = open(imgfile, O_RDONLY);
     if (fd < 0) {
         fprintf(stderr, "failed to open image file %s\n", imgfile);
         exit(EXIT_FAILURE);
@@ -356,20 +368,55 @@ static void load_image(const char *imgfile)
         perror("fstat");
         exit(EXIT_FAILURE);
     }
-    size_t len = st.st_size;
-    void *addr;
 
     /* Map writable because we include the memory area for store
      * testing in the image.
      */
-    addr = mmap(0, len, PROT_READ | PROT_WRITE | PROT_EXEC,
+    addr = mmap(0, st.st_size, PROT_READ | PROT_WRITE | PROT_EXEC,
                 MAP_PRIVATE, fd, 0);
     if (addr == MAP_FAILED) {
         perror("mmap");
         exit(EXIT_FAILURE);
     }
     close(fd);
-    image_start = addr;
+
+    if (memcmp(addr, ELFMAG, SELFMAG) == 0) {
+        union {
+            unsigned char ident[EI_NIDENT];
+            Elf32_Ehdr h32;
+            Elf64_Ehdr h64;
+        } *e = addr;
+        size_t entry;
+
+        /*
+         * TODO: More complete parsing of ELF file, verify assumtion, namely:
+         * Single PT_LOAD covering the ELF header, code and data.
+         * For now, simply update image_start from the elf header.
+         */
+        if (e->ident[EI_DATA] !=
+            (HOST_BIG_ENDIAN ? ELFDATA2MSB : ELFDATA2LSB)) {
+            fprintf(stderr, "%s: Endian mismatch: EI_DATA = %x\n",
+                    imgfile, e->ident[EI_DATA]);
+            exit(1);
+        }
+
+        switch (e->ident[EI_CLASS]) {
+        case ELFCLASS32:
+            entry = e->h32.e_entry;
+            break;
+        case ELFCLASS64:
+            entry = e->h64.e_entry;
+            break;
+        default:
+            fprintf(stderr, "%s: Bad elf header: EI_CLASS = %x\n",
+                    imgfile, e->ident[EI_CLASS]);
+            exit(1);
+        }
+        image_start = addr + entry;
+    } else {
+        /* Raw binary image. */
+        image_start = addr;
+    }
     image_start_address = (uintptr_t) addr;
 }
 
-- 
2.34.1



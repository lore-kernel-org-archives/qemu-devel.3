Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A380DC04FFE
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 11:56:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5lJ0-0000NZ-IA; Sat, 11 May 2024 07:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5lIy-0000MQ-BD
 for qemu-devel@nongnu.org; Sat, 11 May 2024 07:54:20 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5lIw-00070X-KJ
 for qemu-devel@nongnu.org; Sat, 11 May 2024 07:54:20 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2e5218112a6so18706701fa.2
 for <qemu-devel@nongnu.org>; Sat, 11 May 2024 04:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715428457; x=1716033257; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HpcdEdoUPPV0pGSNw4XA78udWGrbKRqXBRNX1k+qgFI=;
 b=GCqB3v4/zunCpwCFjyevBNANzScPlhgiENPS0Y4TbsOYRTiTDdpWhUhSksdm4NuZKb
 kq0LcMI5GnYRYr11t7ZR9E7AbclNDK5TsU6PMtOB4osxKx8nbltj4HXI5prG9XT4Z4FE
 VGiHBclEASdEu3SBd6Sg4xzCNRZrPMtod1Kh+jfVv1YbjIRPReEvMisczCghNHgMmuky
 0yW/vTVk6KZbUWB+iCqatFp2qgJvi5J8GvpxQdeUcS8ZNYKmkv/yD9zQ0CJQz4gjz+wd
 J96owNjqN+f+j7SYxJlTzhdD7dXdD9OA1QOqasY5BwEYv7C9052cbc5oBS1wYsbkEa45
 9WDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715428457; x=1716033257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HpcdEdoUPPV0pGSNw4XA78udWGrbKRqXBRNX1k+qgFI=;
 b=v3zNriyAhHNM0jM/ENoyVfqktVUhTRUZxi/YJXBG49WOyjUCCklP7mIwQ0/gMm/xTz
 73bLRALby0uJCrYpQ+c98dv9WMdjZZKLwl+WwtzBRoFrUhW0PXpax3EOs/+mRDjfxP60
 52mTQaw/NnqOeJnHPnfTx/PNti9peRl4ZQE92/apIchxrZvGm1BaSwKA5iOSzUHgs7M2
 iEgHWeLgrM8KrTIoeEI5XaaP0GkhWDccJFtGz1ypfqfx4m9zTqnfy3V/7tfMjCCOz/PA
 i62bqrxChpj6bqU/Uqg7X68e/EZ14PCu1ztfH24mfTkz31+nfmUFtYjKlbcGFlEKzytn
 wi2A==
X-Gm-Message-State: AOJu0YyAiXWY1kYwep2aWBblHMBTJ6SCAqfL6rqIJHPMiiYNtE7hYEjL
 oN92qNx+ZpbGyKXwstf890FICoVlXzpDE9ordZ8nB54RZOOv1WAJ/+5QSewPAFaKZk+BRutVQlV
 6JX8=
X-Google-Smtp-Source: AGHT+IGx81vB/JJP5fudw8OsZJWVoabCGGS0f6VSU4LywGDIHddoFzD7onoYIPCjDy3US4ZPYvteTg==
X-Received: by 2002:a2e:9b4e:0:b0:2e1:bb65:8306 with SMTP id
 38308e7fff4ca-2e5204b1d89mr31245551fa.44.1715428457056; 
 Sat, 11 May 2024 04:54:17 -0700 (PDT)
Received: from stoup.. ([195.76.196.165]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbf20sm6764797f8f.93.2024.05.11.04.54.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 May 2024 04:54:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 15/17] risu: Allow use of ELF test files
Date: Sat, 11 May 2024 13:53:58 +0200
Message-Id: <20240511115400.7587-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240511115400.7587-1-richard.henderson@linaro.org>
References: <20240511115400.7587-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x234.google.com
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
 risu.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/risu.c b/risu.c
index c28b4a5..e3845f6 100644
--- a/risu.c
+++ b/risu.c
@@ -24,6 +24,8 @@
 #include <sys/mman.h>
 #include <fcntl.h>
 #include <string.h>
+#include <elf.h>
+#include <endian.h>
 
 #include "config.h"
 #include "risu.h"
@@ -371,6 +373,57 @@ static void load_image(const char *imgfile)
     close(fd);
     image_start = addr;
     image_start_address = (uintptr_t) addr;
+
+    /*
+     * TODO: More complete parsing of ELF file, verify assumtion, namely:
+     * Single PT_LOAD covering the ELF header, code and data.
+     * For now, simply update image_start from the elf header.
+     */
+    if (memcmp(addr, ELFMAG, SELFMAG) == 0) {
+        const unsigned char *e_ident = addr;
+        bool swap, is_64;
+
+        switch (e_ident[EI_DATA]) {
+        case ELFDATA2LSB:
+            swap = __BYTE_ORDER != __LITTLE_ENDIAN;
+            break;
+        case ELFDATA2MSB:
+            swap = __BYTE_ORDER == __LITTLE_ENDIAN;
+            break;
+        default:
+            fprintf(stderr, "%s: Bad elf header: EI_DATA = %x\n",
+                    imgfile, e_ident[EI_DATA]);
+            exit(1);
+        }
+        switch (e_ident[EI_CLASS]) {
+        case ELFCLASS32:
+            is_64 = false;
+            break;
+        case ELFCLASS64:
+            is_64 = true;
+            break;
+        default:
+            fprintf(stderr, "%s: Bad elf header: EI_CLASS = %x\n",
+                    imgfile, e_ident[EI_CLASS]);
+            exit(1);
+        }
+
+        if (is_64) {
+            const Elf64_Ehdr *h64 = addr;
+            Elf64_Addr e64 = h64->e_entry;
+            if (swap) {
+                e64 = __builtin_bswap64(e64);
+            }
+            image_start = addr + e64;
+        } else {
+            const Elf32_Ehdr *h32 = addr;
+            Elf32_Addr e32 = h32->e_entry;
+            if (swap) {
+                e32 = __builtin_bswap32(e32);
+            }
+            image_start = addr + e32;
+        }
+    }
 }
 
 static int master(void)
-- 
2.34.1



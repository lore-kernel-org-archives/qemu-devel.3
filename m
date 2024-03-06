Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2D2C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 06:17:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhkWJ-0004yT-Hh; Wed, 06 Mar 2024 01:12:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhkW8-0004ug-JH
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:12:40 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhkW6-0006Fw-Sb
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:12:40 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1dc3b4b9b62so4130215ad.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 22:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709705557; x=1710310357;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g0+eTNzDAfP/I8pMSpLdPirrAbqQUuAszFkDupkQLY8=;
 b=i/8c8RhlncBkFKQClT6JXGGPFAU9mOZK0f2Mgf+RDz+HGV34ItR4NGrs5JSc+5J3Cd
 EaQuRXtCWRASZI9/Vv8I/FE2HWMP0yHMvsIptCpyWtzDrgBNXCuy2ZGhIzgitCx4Js+7
 AJrR3AqvV9JtmYIqgIShOPVftJLLcQT/eb0O7ZJNx8KCv0K8fNDo92O0E/hMtKSyUk62
 wM0jSZ+yj6grhif2W8YjypWoB9KuaioS4oNa1dATtBxgQI4A+G5wio3sl7Ued/cTukOA
 jaMr+tXq9YCOH+A/xWN14iHqbRjy0cWPydmJb96DNMEWcwpsI0qEmNLK1JnDPb374I+R
 LolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709705557; x=1710310357;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g0+eTNzDAfP/I8pMSpLdPirrAbqQUuAszFkDupkQLY8=;
 b=e4PgjZDJuBEslITeOPVqYkz9de4T0fVcXUIrJs+pNvkHqS4M4yUoWnXBdd3gpPKAtm
 PWbJDcc8XluFynrJ9AtLtDcZDQzomtCwl8tR/IYog+3OEKDxSldohPL6lAbnFLbKiYKo
 +/CvSomuOVpEvbvX9vtjk7FHZlGqeeKkvZTEKTV8Po+NU0LSOrFy1BqAuYDtnGhTRq9f
 wWUPpmkYWALBHKzV0lQfslOfj0OGSjFk3yNwBEQGnfmdXlPMlfUoqCJboqtRnQmUEML9
 BqXVFB20rwEsXAXJrmRIJ+i9RkQiGP8qXRTs1xJ0oZXyzB59h2wysbIuDRwzTI6Vv6Sw
 zhPw==
X-Gm-Message-State: AOJu0YyA55iFWFcpWJehq+tXJReFyUYdbrDkmfSkbUK8Sb0VFDPQdZAA
 eg3L+XS8LZZWLsQXXvqRz3ed/1BYNMZ4PGeMywKI/EvgEkRAEarizW6r6gux6Kc=
X-Google-Smtp-Source: AGHT+IHbM2F+BRdhsU+fa3EHe9K3ovl/QnbPrj4jXua0I4f0FoAjjkmltm2aRhioi7iMJ3BnaLDQDQ==
X-Received: by 2002:a17:903:2594:b0:1db:dd24:9962 with SMTP id
 jb20-20020a170903259400b001dbdd249962mr4412087plb.21.1709705557499; 
 Tue, 05 Mar 2024 22:12:37 -0800 (PST)
Received: from localhost ([157.82.206.27]) by smtp.gmail.com with UTF8SMTPSA id
 z3-20020a170902708300b001dcc0d06959sm11598502plk.245.2024.03.05.22.12.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 22:12:37 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 06 Mar 2024 15:12:14 +0900
Subject: [PATCH v3 08/19] contrib/elf2dmp: Fix error reporting style in
 qemu_elf.c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-elf2dmp-v3-8-d74e6c3da49c@daynix.com>
References: <20240306-elf2dmp-v3-0-d74e6c3da49c@daynix.com>
In-Reply-To: <20240306-elf2dmp-v3-0-d74e6c3da49c@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

include/qapi/error.h says:
> We recommend
> * bool-valued functions return true on success / false on failure,
> ...

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 contrib/elf2dmp/qemu_elf.h |  2 +-
 contrib/elf2dmp/main.c     |  2 +-
 contrib/elf2dmp/qemu_elf.c | 32 ++++++++++++++++----------------
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/contrib/elf2dmp/qemu_elf.h b/contrib/elf2dmp/qemu_elf.h
index afa75f10b2d2..adc50238b46b 100644
--- a/contrib/elf2dmp/qemu_elf.h
+++ b/contrib/elf2dmp/qemu_elf.h
@@ -42,7 +42,7 @@ typedef struct QEMU_Elf {
     int has_kernel_gs_base;
 } QEMU_Elf;
 
-int QEMU_Elf_init(QEMU_Elf *qe, const char *filename);
+bool QEMU_Elf_init(QEMU_Elf *qe, const char *filename);
 void QEMU_Elf_exit(QEMU_Elf *qe);
 
 Elf64_Phdr *elf64_getphdr(void *map);
diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index 7a3a7225905e..cb28971789e4 100644
--- a/contrib/elf2dmp/main.c
+++ b/contrib/elf2dmp/main.c
@@ -535,7 +535,7 @@ int main(int argc, char *argv[])
         return 1;
     }
 
-    if (QEMU_Elf_init(&qemu_elf, argv[1])) {
+    if (!QEMU_Elf_init(&qemu_elf, argv[1])) {
         eprintf("Failed to initialize QEMU ELF dump\n");
         return 1;
     }
diff --git a/contrib/elf2dmp/qemu_elf.c b/contrib/elf2dmp/qemu_elf.c
index 055e6f8792e9..a22c057d3ec3 100644
--- a/contrib/elf2dmp/qemu_elf.c
+++ b/contrib/elf2dmp/qemu_elf.c
@@ -60,7 +60,7 @@ Elf64_Half elf_getphdrnum(void *map)
     return ehdr->e_phnum;
 }
 
-static int init_states(QEMU_Elf *qe)
+static bool init_states(QEMU_Elf *qe)
 {
     Elf64_Phdr *phdr = elf64_getphdr(qe->map);
     Elf64_Nhdr *start = (void *)((uint8_t *)qe->map + phdr[0].p_offset);
@@ -70,7 +70,7 @@ static int init_states(QEMU_Elf *qe)
 
     if (phdr[0].p_type != PT_NOTE) {
         eprintf("Failed to find PT_NOTE\n");
-        return 1;
+        return false;
     }
 
     qe->has_kernel_gs_base = 1;
@@ -107,7 +107,7 @@ static int init_states(QEMU_Elf *qe)
 
     qe->state_nr = cpu_nr;
 
-    return 0;
+    return true;
 }
 
 static void exit_states(QEMU_Elf *qe)
@@ -162,7 +162,7 @@ static bool check_ehdr(QEMU_Elf *qe)
     return true;
 }
 
-static int QEMU_Elf_map(QEMU_Elf *qe, const char *filename)
+static bool QEMU_Elf_map(QEMU_Elf *qe, const char *filename)
 {
 #ifdef CONFIG_LINUX
     struct stat st;
@@ -173,13 +173,13 @@ static int QEMU_Elf_map(QEMU_Elf *qe, const char *filename)
     fd = open(filename, O_RDONLY, 0);
     if (fd == -1) {
         eprintf("Failed to open ELF dump file \'%s\'\n", filename);
-        return 1;
+        return false;
     }
 
     if (fstat(fd, &st)) {
         eprintf("Failed to get size of ELF dump file\n");
         close(fd);
-        return 1;
+        return false;
     }
     qe->size = st.st_size;
 
@@ -188,7 +188,7 @@ static int QEMU_Elf_map(QEMU_Elf *qe, const char *filename)
     if (qe->map == MAP_FAILED) {
         eprintf("Failed to map ELF file\n");
         close(fd);
-        return 1;
+        return false;
     }
 
     close(fd);
@@ -201,14 +201,14 @@ static int QEMU_Elf_map(QEMU_Elf *qe, const char *filename)
     if (gerr) {
         eprintf("Failed to map ELF dump file \'%s\'\n", filename);
         g_error_free(gerr);
-        return 1;
+        return false;
     }
 
     qe->map = g_mapped_file_get_contents(qe->gmf);
     qe->size = g_mapped_file_get_length(qe->gmf);
 #endif
 
-    return 0;
+    return true;
 }
 
 static void QEMU_Elf_unmap(QEMU_Elf *qe)
@@ -220,25 +220,25 @@ static void QEMU_Elf_unmap(QEMU_Elf *qe)
 #endif
 }
 
-int QEMU_Elf_init(QEMU_Elf *qe, const char *filename)
+bool QEMU_Elf_init(QEMU_Elf *qe, const char *filename)
 {
-    if (QEMU_Elf_map(qe, filename)) {
-        return 1;
+    if (!QEMU_Elf_map(qe, filename)) {
+        return false;
     }
 
     if (!check_ehdr(qe)) {
         eprintf("Input file has the wrong format\n");
         QEMU_Elf_unmap(qe);
-        return 1;
+        return false;
     }
 
-    if (init_states(qe)) {
+    if (!init_states(qe)) {
         eprintf("Failed to extract QEMU CPU states\n");
         QEMU_Elf_unmap(qe);
-        return 1;
+        return false;
     }
 
-    return 0;
+    return true;
 }
 
 void QEMU_Elf_exit(QEMU_Elf *qe)

-- 
2.44.0



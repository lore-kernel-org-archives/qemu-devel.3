Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84667C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgBxo-0004v5-GP; Fri, 01 Mar 2024 18:06:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBxf-0004ru-As
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:06:42 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBxb-0004DX-DN
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:06:38 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1dc1e7c0e29so10569735ad.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334394; x=1709939194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wXgOJaiR1gNovC/J+sG7U6tnXruxoEFoxj+FOnROhG4=;
 b=VUZKnmVb4gRnkIfqOOA3tmn2P7jczQKV0KdZk/F77Wj+QrSKvo4d5e/TrtMnHXpyVv
 /fMJERW/1zXpqFop1Uwd4/LTSfaqmQVr/hlXfJeWJCtU8okQx7GTj9l8Ngfzf+vsRX2e
 Ync08Dly4gQ1E89W0LPI3XyjialFHo7QP2rRE6bAW67zmWXpWgJlir/Ah+2xE12Yz6Z8
 LGj1Da5h2xYx2O3FlKImpp/TqhrmnBrjR2o8UDi9Wyku7WgR6oTIZ7r0EurnRsh9eCIh
 2jGPJI6Xykicngj3VLHLmfp9KSisC/M2tWzyAWFCL5ukgtDbR3AldZhbT1ALRKDIHnVG
 Q+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334394; x=1709939194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wXgOJaiR1gNovC/J+sG7U6tnXruxoEFoxj+FOnROhG4=;
 b=KViexqNvB2Fyy7ukrXSgZlbv3CrkIBZmuFrIG3e1l0bwUqkVEzKcn6OdIEI4ORSus0
 1e020yWhV9wxnHypPgGQEAEbBma1nJORRvxxemlvhmKM58Qu60h+zCewGaLxcjjY4tSg
 /IMwOjSuqMKmlSNIxAT9kUCuCt3Oyc0Fv0pzazhUZrEpLP368ti0IIsHbeF8hmdCC2lw
 Z4qpAbs8VtTFWXecO6TDBBoqXr6EQ+Xjv3ygnlPHeAcPPKTdlOPvxpUpbpE48J49B2g7
 YEKXvnrPLu6I7jeb8y4k0pwbzGP4qYRVDxX1ekYWKwmTFx3ApoRAB4rz/tbX83S5Lzkc
 /UGA==
X-Gm-Message-State: AOJu0YwhTlTi3ydRoxWKm8JVTw5YATNe3TpMcLPyTwoQ1UhNG7tBAGTT
 l9rnYLDOwbGi0pE80ywc03SsT6WKQZIwJD+plu6lr0XboytWC2RDktbDCUGrmDaqnrvVKDDA5NN
 w
X-Google-Smtp-Source: AGHT+IF0r/H/bNsoIxp487FatF2QSINwXu5gAR2ULcUadQF69X45vs/chCu6KBG3ldusgIr/k4NBPg==
X-Received: by 2002:a17:902:ccc2:b0:1dc:f16c:de0c with SMTP id
 z2-20020a170902ccc200b001dcf16cde0cmr2469911ple.65.1709334393861; 
 Fri, 01 Mar 2024 15:06:33 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 lc11-20020a170902fa8b00b001dc668e145asm3988580plb.200.2024.03.01.15.06.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:06:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/60] linux-user/elfload: Size corefile before opening
Date: Fri,  1 Mar 2024 13:05:28 -1000
Message-Id: <20240301230619.661008-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Verify the size of the corefile vs the rlimit before
opening and creating the core file at all.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 83 +++++++++++++++++++++++---------------------
 1 file changed, 44 insertions(+), 39 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 6f9da721d7..bad01bd2ef 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -4270,6 +4270,16 @@ static int vma_walker(void *priv, target_ulong start, target_ulong end,
     return (0);
 }
 
+static size_t size_note(const char *name, size_t datasz)
+{
+    size_t namesz = strlen(name) + 1;
+
+    namesz = ROUND_UP(namesz, 4);
+    datasz = ROUND_UP(datasz, 4);
+
+    return sizeof(struct elf_note) + namesz + datasz;
+}
+
 static void fill_note(struct memelfnote *note, const char *name, int type,
                       unsigned int sz, void *data)
 {
@@ -4428,27 +4438,9 @@ static int dump_write(int fd, const void *ptr, size_t size)
 {
     const char *bufp = (const char *)ptr;
     ssize_t bytes_written, bytes_left;
-    struct rlimit dumpsize;
-    off_t pos;
 
     bytes_written = 0;
-    getrlimit(RLIMIT_CORE, &dumpsize);
-    if ((pos = lseek(fd, 0, SEEK_CUR))==-1) {
-        if (errno == ESPIPE) { /* not a seekable stream */
-            bytes_left = size;
-        } else {
-            return pos;
-        }
-    } else {
-        if (dumpsize.rlim_cur <= pos) {
-            return -1;
-        } else if (dumpsize.rlim_cur == RLIM_INFINITY) {
-            bytes_left = size;
-        } else {
-            size_t limit_left=dumpsize.rlim_cur - pos;
-            bytes_left = limit_left >= size ? size : limit_left ;
-        }
-    }
+    bytes_left = size;
 
     /*
      * In normal conditions, single write(2) should do but
@@ -4622,16 +4614,15 @@ static int elf_core_dump(int signr, const CPUArchState *env)
 {
     const CPUState *cpu = env_cpu((CPUArchState *)env);
     const TaskState *ts = (const TaskState *)cpu->opaque;
-    struct vm_area_struct *vma = NULL;
+    struct vm_area_struct *vma;
     struct elf_note_info info;
     struct elfhdr elf;
     struct elf_phdr phdr;
     struct rlimit dumpsize;
     struct mm_struct mm;
-    off_t offset = 0, data_offset = 0;
-    int segs = 0;
+    off_t offset, note_offset, data_offset;
+    int segs, cpus, ret;
     int fd = -1;
-    int ret;
 
     if (prctl(PR_GET_DUMPABLE) == 0) {
         return 0;
@@ -4646,10 +4637,36 @@ static int elf_core_dump(int signr, const CPUArchState *env)
 
     /*
      * Walk through target process memory mappings and
-     * set up structure containing this information.  After
-     * this point vma_xxx functions can be used.
+     * set up structure containing this information.
      */
     vma_init(&mm);
+    walk_memory_regions(&mm, vma_walker);
+    segs = vma_get_mapping_count(&mm);
+
+    cpus = 0;
+    CPU_FOREACH(cpu) {
+        cpus++;
+    }
+
+    offset = sizeof(struct elfhdr);
+    offset += (segs + 1) * sizeof(struct elf_phdr);
+    note_offset = offset;
+
+    offset += size_note("CORE", ts->info->auxv_len);
+    offset += size_note("CORE", sizeof(struct target_elf_prpsinfo));
+    offset += size_note("CORE", sizeof(struct target_elf_prstatus)) * cpus;
+    offset = ROUND_UP(offset, ELF_EXEC_PAGESIZE);
+    data_offset = offset;
+
+    for (vma = vma_first(&mm); vma != NULL; vma = vma_next(vma)) {
+        offset += vma_dump_size(vma);
+    }
+
+    /* Do not dump if the corefile size exceeds the limit. */
+    if (dumpsize.rlim_cur != RLIM_INFINITY && dumpsize.rlim_cur < offset) {
+        errno = 0;
+        goto out;
+    }
 
     {
         g_autofree char *corefile = core_dump_filename(ts);
@@ -4660,9 +4677,6 @@ static int elf_core_dump(int signr, const CPUArchState *env)
         goto out;
     }
 
-    walk_memory_regions(&mm, vma_walker);
-    segs = vma_get_mapping_count(&mm);
-
     /*
      * Construct valid coredump ELF header.  We also
      * add one more segment for notes.
@@ -4674,26 +4688,17 @@ static int elf_core_dump(int signr, const CPUArchState *env)
     /* fill in the in-memory version of notes */
     fill_note_info(&info, signr, env);
 
-    offset += sizeof (elf);                             /* elf header */
-    offset += (segs + 1) * sizeof (struct elf_phdr);    /* program headers */
-
     /* write out notes program header */
-    fill_elf_note_phdr(&phdr, info.notes_size, offset);
+    fill_elf_note_phdr(&phdr, info.notes_size, note_offset);
 
-    offset += info.notes_size;
     if (dump_write(fd, &phdr, sizeof (phdr)) != 0)
         goto out;
 
-    /*
-     * ELF specification wants data to start at page boundary so
-     * we align it here.
-     */
-    data_offset = offset = roundup(offset, ELF_EXEC_PAGESIZE);
-
     /*
      * Write program headers for memory regions mapped in
      * the target process.
      */
+    offset = data_offset;
     for (vma = vma_first(&mm); vma != NULL; vma = vma_next(vma)) {
         (void) memset(&phdr, 0, sizeof (phdr));
 
-- 
2.34.1



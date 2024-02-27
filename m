Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 272F7C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 18:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf2VR-0006WC-Jy; Tue, 27 Feb 2024 13:48:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rf2VQ-0006VZ-4p
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 13:48:44 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rf2VO-0001T1-Dm
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 13:48:43 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6e4ca46ab04so2862653b3a.3
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 10:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709059721; x=1709664521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PXNbhyM3M1ZvaxsPU8XRtEyhAyhYazBaocnAfgHjiNM=;
 b=tZKCD9EcLCeJpd6jK0rsk/Llmj4h6oZbe6kdgW7K+BDGg1KAGtyznYuZKjs9LMVTtT
 UOFi/z/ceoQfLg1S4U+JlnV18R6WHmhflANj1sRjUNQXsHmhvWX648AKT45ty9KrupLJ
 hG+O9SiHsWUxpbZes47/CTPr2rv34kjB5YSFMguxEQZGkLf8bl5AAZm0Lh47Pfp9w8xh
 g2/h53CBS6pP+fEG7Hf7DLGNGH0KlDyhWSHRv1hXuXvRfVueOHe8yaEdSGRFecMPB5Dz
 CjWkcUGcbRIo5UmH5rs8byL4YlrPTwMfcqs7b8sY3jFWCeKa0EMo/gQdOcPKX+CW8p4G
 3NPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709059721; x=1709664521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PXNbhyM3M1ZvaxsPU8XRtEyhAyhYazBaocnAfgHjiNM=;
 b=lzKJyFyt/BSZA7veABBLR2J+HmjQHIkuyQn6FByiZx+9hn2eWPScjptxI06ZWBLJy7
 WQvTysdOXMHKTSqDyAtRqSo9nC7lsjbcBtw4CRh8RuEht9snJamS1DXlJWgujdNHVsyN
 nZ60nlJInxV17t6fiJGX0Ca5RtM1Bo8fgayu/bAPMcOvau3rIXv3DtfOl9ynHcy/QJv6
 pm6f42SqpOAGy7g9kB1iDIZDxtTPyiJjihQj3qmuajhWvwtzcJEBEXHGuS+J/ydSjic4
 dfhdzhW23OLqvnQYBsaBQX0pDDlNK0o8a1mk3LKCHEi96oNKyKJokv9eK6zJ7J5Z6Nln
 nohg==
X-Gm-Message-State: AOJu0YyU33+/LNfZXjrbcrVk+kTXQNQ1U8M1q7d+RJ3Os69OxwEczHCK
 8fwvceb8ZrexgywKf1+wbWyh/QE5MfvcuJpeFKEFByYW4V9I4iACXA3ZWsjPaHthvsTvV3JQAdQ
 /
X-Google-Smtp-Source: AGHT+IF30TBkxuhs2mX9HYQ8yuqG1edE8Jc0TsI+BIaFzV3uILEv74NbmnTG0GCbyyRnDLE49XWsNg==
X-Received: by 2002:a05:6a00:ce:b0:6e5:2cc9:c898 with SMTP id
 e14-20020a056a0000ce00b006e52cc9c898mr7190892pfj.26.1709059720912; 
 Tue, 27 Feb 2024 10:48:40 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 h26-20020aa786da000000b006e555d40951sm533465pfo.188.2024.02.27.10.48.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 10:48:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
Subject: [PATCH 03/14] linux-user/elfload: Tidy fill_note_info and struct
 elf_note_info
Date: Tue, 27 Feb 2024 08:48:22 -1000
Message-Id: <20240227184833.193836-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227184833.193836-1-richard.henderson@linaro.org>
References: <20240227184833.193836-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

In fill_note_info, there were unnecessary checks for
success of g_new/g_malloc.  But these structures do not
need to be dyamically allocated at all, and can in fact
be statically allocated within the parent structure.

This removes all error paths from fill_note_info, so
change the return type to void.

Change type of signr to match both caller (elf_core_dump)
and callee (fill_prstatus), which both use int for signr.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 48 +++++++++++++++-----------------------------
 1 file changed, 16 insertions(+), 32 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 7b3a2c20f2..cc43487a37 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -4066,10 +4066,12 @@ struct elf_thread_status {
     int num_notes;
 };
 
+#define NUMNOTES 3
+
 struct elf_note_info {
-    struct memelfnote   *notes;
-    struct target_elf_prstatus *prstatus;  /* NT_PRSTATUS */
-    struct target_elf_prpsinfo *psinfo;    /* NT_PRPSINFO */
+    struct memelfnote notes[NUMNOTES];
+    struct target_elf_prstatus prstatus;  /* NT_PRSTATUS */
+    struct target_elf_prpsinfo psinfo;    /* NT_PRPSINFO */
 
     QTAILQ_HEAD(, elf_thread_status) thread_list;
 #if 0
@@ -4117,7 +4119,7 @@ static void fill_auxv_note(struct memelfnote *, const TaskState *);
 static void fill_elf_note_phdr(struct elf_phdr *, int, off_t);
 static size_t note_size(const struct memelfnote *);
 static void free_note_info(struct elf_note_info *);
-static int fill_note_info(struct elf_note_info *, long, const CPUArchState *);
+static void fill_note_info(struct elf_note_info *, int, const CPUArchState *);
 static void fill_thread_info(struct elf_note_info *, const CPUArchState *);
 
 static int dump_write(int, const void *, size_t);
@@ -4514,44 +4516,33 @@ static void fill_thread_info(struct elf_note_info *info, const CPUArchState *env
     info->notes_size += note_size(&ets->notes[0]);
 }
 
-static int fill_note_info(struct elf_note_info *info,
-                          long signr, const CPUArchState *env)
+static void fill_note_info(struct elf_note_info *info,
+                           int signr, const CPUArchState *env)
 {
-#define NUMNOTES 3
     CPUState *cpu = env_cpu((CPUArchState *)env);
     TaskState *ts = (TaskState *)cpu->opaque;
-    int i;
 
     memset(info, 0, sizeof (*info));
     QTAILQ_INIT(&info->thread_list);
 
-    info->notes = g_new0(struct memelfnote, NUMNOTES);
-    if (info->notes == NULL)
-        return (-ENOMEM);
-    info->prstatus = g_malloc0(sizeof (*info->prstatus));
-    if (info->prstatus == NULL)
-        return (-ENOMEM);
-    info->psinfo = g_malloc0(sizeof (*info->psinfo));
-    if (info->prstatus == NULL)
-        return (-ENOMEM);
-
     /*
      * First fill in status (and registers) of current thread
      * including process info & aux vector.
      */
-    fill_prstatus(info->prstatus, ts, signr);
-    elf_core_copy_regs(&info->prstatus->pr_reg, env);
+    fill_prstatus(&info->prstatus, ts, signr);
+    elf_core_copy_regs(&info->prstatus.pr_reg, env);
     fill_note(&info->notes[0], "CORE", NT_PRSTATUS,
-              sizeof (*info->prstatus), info->prstatus);
-    fill_psinfo(info->psinfo, ts);
+              sizeof(info->prstatus), &info->prstatus);
+    fill_psinfo(&info->psinfo, ts);
     fill_note(&info->notes[1], "CORE", NT_PRPSINFO,
-              sizeof (*info->psinfo), info->psinfo);
+              sizeof(info->psinfo), &info->psinfo);
     fill_auxv_note(&info->notes[2], ts);
     info->numnote = 3;
 
     info->notes_size = 0;
-    for (i = 0; i < info->numnote; i++)
+    for (int i = 0; i < info->numnote; i++) {
         info->notes_size += note_size(&info->notes[i]);
+    }
 
     /* read and fill status of all threads */
     WITH_QEMU_LOCK_GUARD(&qemu_cpu_list_lock) {
@@ -4562,8 +4553,6 @@ static int fill_note_info(struct elf_note_info *info,
             fill_thread_info(info, cpu_env(cpu));
         }
     }
-
-    return (0);
 }
 
 static void free_note_info(struct elf_note_info *info)
@@ -4575,10 +4564,6 @@ static void free_note_info(struct elf_note_info *info)
         QTAILQ_REMOVE(&info->thread_list, ets, ets_link);
         g_free(ets);
     }
-
-    g_free(info->prstatus);
-    g_free(info->psinfo);
-    g_free(info->notes);
 }
 
 static int write_note_info(struct elf_note_info *info, int fd)
@@ -4694,8 +4679,7 @@ static int elf_core_dump(int signr, const CPUArchState *env)
         goto out;
 
     /* fill in the in-memory version of notes */
-    if (fill_note_info(&info, signr, env) < 0)
-        goto out;
+    fill_note_info(&info, signr, env);
 
     offset += sizeof (elf);                             /* elf header */
     offset += (segs + 1) * sizeof (struct elf_phdr);    /* program headers */
-- 
2.34.1



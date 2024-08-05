Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6940C52D70
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 00:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saldY-0007Z6-8Y; Sun, 04 Aug 2024 20:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saldW-0007Rl-Fj
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 20:31:42 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saldU-0002IY-TS
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 20:31:42 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-70d2b921c48so7633708b3a.1
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 17:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722817899; x=1723422699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8WJQORCpqGoeFxGSwBWz+2gItcHfSAbHK8FGjbSdfpM=;
 b=g53sSO+RsOfxs0qHyP53M+L/fOnR+O3Ag8kiudkpuAHWWoLv+Ig+e3mwbYt7k+o8TO
 TRsoRbzOZghwfMztIjKkVM5vm6B/HEcU8sgJ8coRZlAn4/E7eCwu5/LpmjWK0b7C7uZc
 KSSrgDR7VjKf1dEroFhP5iLQNxP6pEbS35f+LNCuTY2rQAPrpvYDM2q9+Kt2FoODsj2P
 htcYfBiH4wURX6R+UQ5P6cgvVmnNZm9b7KJKjo58QKnoXV9GsQ4PgO7zEVQeHflDPWmd
 1Dgsq+Ku9ziq+e0SFiIB6b7cLHp7k1vw31ZMY+tbqZ0ucw1q4KtLodSBZlU0ms/nX+49
 0E0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722817899; x=1723422699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8WJQORCpqGoeFxGSwBWz+2gItcHfSAbHK8FGjbSdfpM=;
 b=D9UDyadZCHeBYZs6YXW8Dpe7G+qYGVbn7wd/OPVv1TjqPVxEvJQVTbNgvf7fau084C
 KkdC7bwqM9OPUw504SbqUeENUuQJAgWiXdgvlMulNi3/mqEezMqk70p0E9o6/LYOG83A
 gQZVXskX2tzqYyiTJ/ixttcAtYhw+396j+xU4mAsVzyFiiV864QSjBlrtoc9BBlqMlTN
 ulJLbEll5EtBABTQ53K8yxgjyVC5QYrv5CCX1u2R3QdAbOynsqML148cz+fY/JdmCvCm
 +BkYtd1iaDv3wkG1eskmH4QjK7kkDKtG/6W9yVYvH2amZLUnOsnpW+NjizK5oZ/ui2cw
 KGOA==
X-Gm-Message-State: AOJu0YzOJxAVXKhb2Kepo+47SgQlBKBRJgH/63Avq/fvk4Jjv3eRPoIa
 p0X9zKGOO6BRGvKM5jij+VLlcWxfsn8Lkure1pt0RI4021yRsGgRxcbEEHT5HliZikHy1/CKq6W
 Znn0hBg==
X-Google-Smtp-Source: AGHT+IHRVeJYIAOugczrEUp3rwDRJdt4EzDd+zTnObXo5TGnvEWwuh9O7O3BIZqsRwjwEp/04Nt1qw==
X-Received: by 2002:a05:6a20:7f84:b0:1c4:8da5:5825 with SMTP id
 adf61e73a8af0-1c699429e34mr10679109637.0.1722817899175; 
 Sun, 04 Aug 2024 17:31:39 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ed16cb3sm4576038b3a.179.2024.08.04.17.31.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Aug 2024 17:31:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
	qemu-stable@nongnu.org
Subject: [PULL 1/6] linux-user/elfload: Fix pr_pid values in core files
Date: Mon,  5 Aug 2024 10:31:23 +1000
Message-ID: <20240805003130.1421051-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805003130.1421051-1-richard.henderson@linaro.org>
References: <20240805003130.1421051-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Analyzing qemu-produced core dumps of multi-threaded apps runs into:

    (gdb) info threads
      [...]
      21   Thread 0x3ff83cc0740 (LWP 9295) warning: Couldn't find general-purpose registers in core file.
    <unavailable> in ?? ()

The reason is that all pr_pid values are the same, because the same
TaskState is used for all CPUs when generating NT_PRSTATUS notes.

Fix by using TaskStates associated with individual CPUs.

Cc: qemu-stable@nongnu.org
Fixes: 243c47066253 ("linux-user/elfload: Write corefile elf header in one block")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240801202340.21845-1-iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 0d4dc1f6d1..b27dd01734 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -4102,8 +4102,7 @@ static void fill_elf_note_phdr(struct elf_phdr *phdr, size_t sz, off_t offset)
     bswap_phdr(phdr, 1);
 }
 
-static void fill_prstatus_note(void *data, const TaskState *ts,
-                               CPUState *cpu, int signr)
+static void fill_prstatus_note(void *data, CPUState *cpu, int signr)
 {
     /*
      * Because note memory is only aligned to 4, and target_elf_prstatus
@@ -4113,7 +4112,7 @@ static void fill_prstatus_note(void *data, const TaskState *ts,
     struct target_elf_prstatus prstatus = {
         .pr_info.si_signo = signr,
         .pr_cursig = signr,
-        .pr_pid = ts->ts_tid,
+        .pr_pid = get_task_state(cpu)->ts_tid,
         .pr_ppid = getppid(),
         .pr_pgrp = getpgrp(),
         .pr_sid = getsid(0),
@@ -4428,8 +4427,7 @@ static int elf_core_dump(int signr, const CPUArchState *env)
         CPU_FOREACH(cpu_iter) {
             dptr = fill_note(&hptr, NT_PRSTATUS, "CORE",
                              sizeof(struct target_elf_prstatus));
-            fill_prstatus_note(dptr, ts, cpu_iter,
-                               cpu_iter == cpu ? signr : 0);
+            fill_prstatus_note(dptr, cpu_iter, cpu_iter == cpu ? signr : 0);
         }
 
         if (dump_write(fd, header, data_offset) < 0) {
-- 
2.43.0



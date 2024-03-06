Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BECCC5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 14:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhsS8-0007fk-6A; Wed, 06 Mar 2024 09:41:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhsS6-0007VB-Hy
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:41:02 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhsRx-0001U2-9B
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:41:00 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33da51fd636so3751129f8f.3
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 06:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709736049; x=1710340849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fupeVcwCDkBVKZ33Doy2sEKI/KbVAY0Qy8ZqQctJp/I=;
 b=GnJyQVAhsiRoBU59M1p680pB31XjYXajt4ziQ4cAi1kmwOolTJdZsTxv0+rhblMtxz
 grRCMEbqlEnO/EOcL4g1Askft4c/mjEI5PHIDteyZ42J3vTGnRr9NGk8IbiXbDQdDYrC
 DtXUmmaI5bpsbOq5C01bXWobNv4wmrlloQN/KbD8+wZZyaLsMUyZQCK9Jf/dPWLOkKxj
 yH4sGSOu9k1pcycMXrltoMzprIDaLr/EwEb30bj7ygAFvmyZb3adOIFKh1SEGoXsRVAJ
 9MUaZGInNn/NIrEJpxRA8W+Rtu1ga4V+7h2tf8Oy/j6wxhw7XRuiVoEfcjgPSvdZ8EUA
 VBVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709736049; x=1710340849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fupeVcwCDkBVKZ33Doy2sEKI/KbVAY0Qy8ZqQctJp/I=;
 b=pSzgQxnWV4JhoLtZsl27y+gPkLRtE6Qsf3/JjErj358LdLpq/TJkPgztv4NtK8QOjh
 oskGQub9IH0wKs2Q+ba4Q7+YLn5+IIJ6k0WyH71xe5GFzKU6YRLtwLocwLAxK4T/Ha7z
 BTBMr61LbgrUMcHWwxr7mp7exJBcvyljssUzO7jr/XdCrK3XI8/7W5RtpyIkxzv/OFvb
 ZLtJnupoe4aluR9I8DV6gCPRIKCFjVzURfM6Qs3Ph/8cQgM5NYjRqkfZ8eSc4AoFbGEO
 v7b4HaL17c6tif8XM2t/0eT0Y9TUZZxjCJq1jb8zOjSnVxKBc/YjsY+ejVN/pwS+As2S
 TSdg==
X-Gm-Message-State: AOJu0Yy1UM68FfzU4X8UAihgQq/hOztmFnq5HbYzrrxV5HK4eBQpRcT1
 bybqWdipCJH5HuV4W2ifuanoeiJOIMrCOuOOBvZaID6jEXqAgX2qT3jQhz60G1A=
X-Google-Smtp-Source: AGHT+IF7PFiuN5R7mYMhzGksXx9+oFiv7PDyWO90+vgRlcEaIqnBUYXPB85loHtKZJIE/E3gE+pI9A==
X-Received: by 2002:a5d:55c4:0:b0:33e:17fe:8c23 with SMTP id
 i4-20020a5d55c4000000b0033e17fe8c23mr10714673wrw.22.1709736049684; 
 Wed, 06 Mar 2024 06:40:49 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bv16-20020a0560001f1000b0033e0523b829sm18239207wrb.13.2024.03.06.06.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 06:40:45 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4DF0D5F95B;
 Wed,  6 Mar 2024 14:40:42 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 07/29] {linux,bsd}-user: Pass pid to gdbserver_fork()
Date: Wed,  6 Mar 2024 14:40:19 +0000
Message-Id: <20240306144041.3787188-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240306144041.3787188-1-alex.bennee@linaro.org>
References: <20240306144041.3787188-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

The upcoming follow-fork-mode child support requires knowing the child
pid. Pass it down.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20240219141628.246823-7-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240305121005.3528075-8-alex.bennee@linaro.org>

diff --git a/include/gdbstub/user.h b/include/gdbstub/user.h
index e33f8d9a9a6..3f9f45946e0 100644
--- a/include/gdbstub/user.h
+++ b/include/gdbstub/user.h
@@ -54,7 +54,7 @@ void gdbserver_fork_start(void);
  * gdbserver_fork() - disable gdb stub for child processes.
  * @cs: CPU
  */
-void gdbserver_fork(CPUState *cs);
+void gdbserver_fork(CPUState *cs, pid_t pid);
 
 /**
  * gdb_syscall_entry() - inform gdb of syscall entry and yield control to it
diff --git a/bsd-user/main.c b/bsd-user/main.c
index fca9b302043..0dbd1cf8801 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -138,7 +138,7 @@ void fork_end(pid_t pid)
          */
         qemu_init_cpu_list();
         get_task_state(thread_cpu)->ts_tid = qemu_get_thread_id();
-        gdbserver_fork(thread_cpu);
+        gdbserver_fork(thread_cpu, pid);
     } else {
         mmap_fork_end(child);
         cpu_list_unlock();
diff --git a/gdbstub/user.c b/gdbstub/user.c
index 536fb43b03e..c61e1a0d1f6 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -375,7 +375,7 @@ static void disable_gdbstub(CPUState *thread_cpu)
 }
 
 /* Disable gdb stub for child processes.  */
-void gdbserver_fork(CPUState *cpu)
+void gdbserver_fork(CPUState *cpu, pid_t pid)
 {
     if (!gdbserver_state.init || gdbserver_user_state.fd < 0) {
         return;
diff --git a/linux-user/main.c b/linux-user/main.c
index cab95f5b0aa..70314e0ab6a 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -165,7 +165,7 @@ void fork_end(pid_t pid)
         }
         qemu_init_cpu_list();
         get_task_state(thread_cpu)->ts_tid = qemu_get_thread_id();
-        gdbserver_fork(thread_cpu);
+        gdbserver_fork(thread_cpu, pid);
     } else {
         cpu_list_unlock();
     }
-- 
2.39.2



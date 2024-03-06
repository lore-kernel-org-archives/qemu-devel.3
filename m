Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B9DC5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 14:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhsS7-0007c0-Ef; Wed, 06 Mar 2024 09:41:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhsS4-0007Po-2N
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:41:00 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhsRx-0001U1-9C
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:40:59 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-412fe981ef1so2084735e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 06:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709736049; x=1710340849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TfLkzlar7jFNAHdEcKzQrpi4P+XZLYByWr1iR6oEsZM=;
 b=nXCXTuQBXiNCzY5ypn5ei1gd47hbyLj0+HmiziBDqcZTRY86Oj/OKn62ON4fr2Z5a9
 bgZGT+OjhclWsdEpHWoMAtUoT3YoX383q6xzm1bZiPkSdPxqfQdYnzm7ZW+IfmANMce8
 Bi4dZFIiY5Rk5nd93m9/3JIEKpMsDo0LHMg4bqE3QzYplL35KouHt2o2ew2ReHssq6kY
 Kc1JZyGWE/V6BitRXrBCH7axMdaomvmo14s7xkwgJGb1HfPNopB1Ex1KzsRd+M2qiXxj
 PLMtEELg1PGtdNKbtKrBFZNoOmoy1vm497iylxq9Umxh3xSdagw3zYqFOnizzdLRcs8P
 NaAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709736049; x=1710340849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TfLkzlar7jFNAHdEcKzQrpi4P+XZLYByWr1iR6oEsZM=;
 b=hrE32IyVaJRkSSgFnr227aNsOLz8bsTMy0lvEy3ZTCTaROaXaySYEuOFSq53XpF6jD
 AM9ofL0Tq/uq4KvLbJXFdTghnzBqtRAxb+GdlRW7PHLUmsmideXOF64iP+zhXvLyy1Na
 YzigakzeBADBTGqtLeYa579RzTrERkf/+0R3HlPxIZwCBboMZbvgiVpIIPFZ0kjY5fE+
 znxPjguTVUPEXZNXb+rVLruUMSGoEBSiBM/hBbG39dywp0pkssyD07cqpdQ3MtxV0s2b
 ECa6YndVa6B8qI51bVxMdVV2HqGlnpi3Zzr111mqfaJf7r9X/3Bo9i+yq9V+m5MTtq44
 QYWA==
X-Gm-Message-State: AOJu0YyERXNrRneEzlFIA0psKZdnlrPwATdfX+INOvL82KqKBRBUMo8z
 UH/zqcsizkFyF/ek04xaWLowBV0r1zz5fPaz9/PevYTazPaG5fn502TAa9sIx4o=
X-Google-Smtp-Source: AGHT+IEirMYpYkgI8PcKMl+C0xMEPlaAhgCfdkjRful75F6wVIbDp+l5gSmRhedvMyBjAlq4Q4BX2w==
X-Received: by 2002:a05:600c:3589:b0:412:e992:6c32 with SMTP id
 p9-20020a05600c358900b00412e9926c32mr5486655wmq.11.1709736049525; 
 Wed, 06 Mar 2024 06:40:49 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a14-20020a05600c348e00b00412f74d25b6sm1772554wmq.39.2024.03.06.06.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 06:40:45 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 639525F9CB;
 Wed,  6 Mar 2024 14:40:42 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 08/29] gdbstub: Call gdbserver_fork() both in parent and in
 child
Date: Wed,  6 Mar 2024 14:40:20 +0000
Message-Id: <20240306144041.3787188-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240306144041.3787188-1-alex.bennee@linaro.org>
References: <20240306144041.3787188-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

The upcoming follow-fork-mode child support requires post-fork message
exchange between the parent and the child. Prepare gdbserver_fork() for
this purpose. Rename it to gdbserver_fork_end() to better reflect its
purpose.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20240219141628.246823-8-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240305121005.3528075-9-alex.bennee@linaro.org>

diff --git a/include/gdbstub/user.h b/include/gdbstub/user.h
index 3f9f45946e0..4c4e5c4c582 100644
--- a/include/gdbstub/user.h
+++ b/include/gdbstub/user.h
@@ -51,10 +51,11 @@ void gdb_signalled(CPUArchState *as, int sig);
 void gdbserver_fork_start(void);
 
 /**
- * gdbserver_fork() - disable gdb stub for child processes.
+ * gdbserver_fork_end() - inform gdb of the completed fork()
  * @cs: CPU
+ * @pid: 0 if in child process, -1 if fork failed, child process pid otherwise
  */
-void gdbserver_fork(CPUState *cs, pid_t pid);
+void gdbserver_fork_end(CPUState *cs, pid_t pid);
 
 /**
  * gdb_syscall_entry() - inform gdb of syscall entry and yield control to it
diff --git a/bsd-user/main.c b/bsd-user/main.c
index 0dbd1cf8801..3dc285e5b74 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -138,10 +138,11 @@ void fork_end(pid_t pid)
          */
         qemu_init_cpu_list();
         get_task_state(thread_cpu)->ts_tid = qemu_get_thread_id();
-        gdbserver_fork(thread_cpu, pid);
+        gdbserver_fork_end(thread_cpu, pid);
     } else {
         mmap_fork_end(child);
         cpu_list_unlock();
+        gdbserver_fork_end(thread_cpu, pid);
         end_exclusive();
     }
 }
diff --git a/gdbstub/user.c b/gdbstub/user.c
index c61e1a0d1f6..866a25f9c06 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -374,10 +374,9 @@ static void disable_gdbstub(CPUState *thread_cpu)
     tb_flush(thread_cpu);
 }
 
-/* Disable gdb stub for child processes.  */
-void gdbserver_fork(CPUState *cpu, pid_t pid)
+void gdbserver_fork_end(CPUState *cpu, pid_t pid)
 {
-    if (!gdbserver_state.init || gdbserver_user_state.fd < 0) {
+    if (pid != 0 || !gdbserver_state.init || gdbserver_user_state.fd < 0) {
         return;
     }
     disable_gdbstub(cpu);
diff --git a/linux-user/main.c b/linux-user/main.c
index 70314e0ab6a..41caa77cb52 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -165,10 +165,10 @@ void fork_end(pid_t pid)
         }
         qemu_init_cpu_list();
         get_task_state(thread_cpu)->ts_tid = qemu_get_thread_id();
-        gdbserver_fork(thread_cpu, pid);
     } else {
         cpu_list_unlock();
     }
+    gdbserver_fork_end(thread_cpu, pid);
     /*
      * qemu_init_cpu_list() reinitialized the child exclusive state, but we
      * also need to keep current_cpu consistent, so call end_exclusive() for
-- 
2.39.2



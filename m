Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3DCC54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 12:14:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhTee-0004ry-Su; Tue, 05 Mar 2024 07:12:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhTdN-0001x2-HW
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:11:05 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhTci-0001Sf-J7
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:10:59 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33e4d36f288so236858f8f.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 04:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709640616; x=1710245416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZqnQ8XijekxyIBL7Xx6BaJyRk5an5hw3I1N1rasyLAw=;
 b=SNT8Biws1so53AURPPYtJTpSUkquhCfCQQ5aX9S4+TRjdDkz8JRDWFj2qNgp83688Q
 STusXn+KR9JfTCJSBFT1FqKph5egXIMFE+YPcYv/coY0pql4zen4evn+fVF4DFEH6dWz
 bVIdYJV2+vs3HOxxZ5HRgINA9ZV+WRiQG0SnrVyWFubX2Q3t7hO9Y4aRXJ4CozZyGYCX
 vjJmF59KOaQ2srb9XgXuFJosvcVUEzCuVMLV8CShrqQIkuGQ/nvwNoC5XYNx1s9gu+3G
 X7hjEm5dV2VCdzx2+tNxWGpkzVbQQ8FAxUi5WFV2Uo0SRuUkyPmRcFTMh3oEutuZLy56
 fw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709640616; x=1710245416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZqnQ8XijekxyIBL7Xx6BaJyRk5an5hw3I1N1rasyLAw=;
 b=NgBDEtjbC7cotgc6BvABGlMFcJLtSQJPum9UY6ckqCgw8/L+4Up+1DMRqF9CJbhXkY
 Dxm6sekMcHXqbYhn2l/DjyxBtvze8EwJWR7l7Grbtf6dpzjt1o70Fh1gMJjCU+Js0tOR
 j74Pmhi+LF7fmgb2LRSBauNbOCe2AuIcr6GsJx5Ipfr1BjAThxys+LgCu9HWiuGPLan9
 LPa+UC0CTMG43bSWwxTNHpnGXOdAWsz5KGb6sYlhDv+YALBXIf2o0JmwyaMZZZNgkjF8
 JhfZs8ujl+EMIegOiVzhzcmVf77/QMCFqU4sFOlgR54KwgdgRs5OKy/W46LGrfSCR6NH
 C/zA==
X-Gm-Message-State: AOJu0YxgQYIql22f3XgB77lwWqe3nyvBpr9EeycBc/XMysct/0WArEY2
 MmORVo8mtDuUKbMrwTaKOwpIovNnkPp05EW7GMke5UOaC4jqCOD8POYNuwR4DEw=
X-Google-Smtp-Source: AGHT+IHFTyPejUIURcNk9BVacfFz4duAbKnfNHNZfVjg4uLkBpbZE3sIi9/Mzh5DMg6sBUfe0ye9hA==
X-Received: by 2002:adf:b212:0:b0:33e:21ac:b89d with SMTP id
 u18-20020adfb212000000b0033e21acb89dmr2303195wra.6.1709640616176; 
 Tue, 05 Mar 2024 04:10:16 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 i10-20020a05600011ca00b0033b60bad2fcsm14828244wrx.113.2024.03.05.04.10.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 04:10:12 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 496475F9CB;
 Tue,  5 Mar 2024 12:10:06 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Brad Smith <brad@comstyle.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <bcain@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Beraldo Leal <bleal@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 David Hildenbrand <david@redhat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Warner Losh <imp@bsdimp.com>, qemu-riscv@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 08/29] gdbstub: Call gdbserver_fork() both in parent and in
 child
Date: Tue,  5 Mar 2024 12:09:44 +0000
Message-Id: <20240305121005.3528075-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240305121005.3528075-1-alex.bennee@linaro.org>
References: <20240305121005.3528075-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
---
 include/gdbstub/user.h | 5 +++--
 bsd-user/main.c        | 3 ++-
 gdbstub/user.c         | 5 ++---
 linux-user/main.c      | 2 +-
 4 files changed, 8 insertions(+), 7 deletions(-)

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



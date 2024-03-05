Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD90C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 12:14:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhTel-0005PB-It; Tue, 05 Mar 2024 07:12:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhTdJ-0001uW-GG
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:11:03 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhTch-0001RA-6F
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:10:48 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33e17342ea7so2937944f8f.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 04:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709640613; x=1710245413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z3nYyAloWCoquTZDPSpE+htB2DaRlvaFvDRPXpKYUIk=;
 b=YlFCKI8D4IjhTyxkzLiRopaNtPIX37FxRBi1OzfI+a2AT1584F69fMVJ3KKOqx7QjF
 opGcuuKMB+fqM+Zxu14VpLoaqh5q5RwaaWRb2BewYcV48M0nbJY5cSu84AzHqw7tUxSu
 JfHaF8T/UJ4XsAINnvuGx1JOcIOhNd+LIbx1Ssp3SzcuTKsUWScOUn49pN62ERdQtL+9
 RjkzGORywaC+fweFJP6JvoLgSzMULbFUDolRUhNQtZv0afdCtPuO9zwhPIn4fF2iWkVz
 Mu2OGYh23Io5P9ixAGmDNOF2kB7cYeZIkJA8Kg8rxZz1gwDq9lmq1VGYzd7msGmAlw2x
 bQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709640613; x=1710245413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z3nYyAloWCoquTZDPSpE+htB2DaRlvaFvDRPXpKYUIk=;
 b=GvOoWiKGkthPFkXKrCtnJ6VAtFfPVGjB3Mb51eAAmDkn8LvdX+DLDdIba/sCke/ht4
 hi+nJUTnrf76mzAuUw823mQK80jHVTEXtZBWenqB63nFCRHdHBG4fF5XeNGk78WWxG74
 4Ewb406I0M6+2H1z1mCAoVMrKoQIH4B4NGFCL0ObP5iVnrdXOZ5xnDwIGICyN0d4TNDk
 JkgyhMVAGfBaLDBY55v8O0t+QZOpx4pz3PU+UWBCZUGnbI8BYqAPg31FtiEA4ALNCJ2T
 RLGBFRHBCyMQe0GvRKaSNGsorT7fGMTgOnyHUmUwnh8vbydKZcNX0PV6XHqzu1HBevMT
 +v8Q==
X-Gm-Message-State: AOJu0YzMsgXZQlSxWLfIMO/92H1cjy8GoCcB5+le5awOX0HqxhKJP5Dd
 Hj68lZkP30Ah44PhYLWoUnSGnaUE+pwTf0504zhWhEsNuQTYZMQ/d+fN3hoaWMU=
X-Google-Smtp-Source: AGHT+IGxzfpc7Is8XIMk/vDb0IbU6uTaw89SmYiDYHhlZ4rm1tdamaAIUJBzXb/EBdpD9hAZjm5PWQ==
X-Received: by 2002:a5d:55c4:0:b0:33e:854:8b24 with SMTP id
 i4-20020a5d55c4000000b0033e08548b24mr7488915wrw.12.1709640613497; 
 Tue, 05 Mar 2024 04:10:13 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 i10-20020a05600011ca00b0033b60bad2fcsm14828243wrx.113.2024.03.05.04.10.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 04:10:12 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 314165F95B;
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
Subject: [PATCH 07/29] {linux,bsd}-user: Pass pid to gdbserver_fork()
Date: Tue,  5 Mar 2024 12:09:43 +0000
Message-Id: <20240305121005.3528075-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240305121005.3528075-1-alex.bennee@linaro.org>
References: <20240305121005.3528075-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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

The upcoming follow-fork-mode child support requires knowing the child
pid. Pass it down.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20240219141628.246823-7-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/gdbstub/user.h | 2 +-
 bsd-user/main.c        | 2 +-
 gdbstub/user.c         | 2 +-
 linux-user/main.c      | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

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



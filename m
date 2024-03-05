Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA4FAC54E49
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 12:11:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhTck-0001Yl-FP; Tue, 05 Mar 2024 07:10:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhTce-0001Uo-TM
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:10:17 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhTcZ-0001CO-24
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:10:15 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-412eb6e15ceso5331625e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 04:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709640609; x=1710245409; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eXVZ712kv8O0GudxyxBx9w6g4YMMrljfTMdLsClf+YA=;
 b=RcINmoG+xMHt9q/k+fAZ8LS0fjeBljWIr4vE7yejfzIcLiy4EDXIQWu4wgzso6JaAh
 uAzoj1QkErBlHgWww87wPtYbRcDPeD1MRqv4rpEpB5RoK7ZnzdpM+gXDlgOakkDE1cRT
 rx1bADQs0UgF1g7X/gwT2rMNpLqJiOqRA/ZTIjBiLqmJnXabyacRneeGw3CW3EE40dLi
 71GsG4u5izvSbkCcKiRCm7hRcYPf7Ha0CYnTBtWjqB0WTXM9iCmdaUUGLoo0kyjzPsQI
 si8Q+9oRIi+awF2dS1CZ82ueE9d0nCNLSTyHUXUP3zR/o3Egj0LwkAMzegaV0p4c4kRQ
 JfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709640609; x=1710245409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eXVZ712kv8O0GudxyxBx9w6g4YMMrljfTMdLsClf+YA=;
 b=itms4X9ZxrfW+S+rD4LDp1HI2ECcGnU5v9TG3jMU/sAAunjkmoB3hLOPzqW4V2cy4t
 H8Dj0AWcsmr7N06fRsKgW5lLYvQ+MIRuwa/MZp/Qih9z3NqKoj8+NF7US41b6Gq4gGmI
 EVDATVn/pbhwFx6IZBCGmvsvvp4TApuL/TKwoY2TIxHIi+VrFLp8sJVf+pTaemG8dY/G
 Cmmt5NfIB65JAJX9tYak+6juITTVtOlAokSMHIuiqiRnrQZOq9ut3ZeiU/hM/GKBa45e
 ZMzUeGGFDx5doSwC90FeLHiXUO66icgHLF/6vDkgn6Z83eFDxUko9sOQwXFUdBEozsAg
 M+TA==
X-Gm-Message-State: AOJu0Ywx/Bad/IhSWGxKgzQtOZnSQqkm0EbQEhEnmQzzE7rh4XIgL65T
 CX9dTr2zHsN68EsvLwvhE8cx0numrH2dveuONrV8msFM3BqBTVa6N1PmP/gPD0M=
X-Google-Smtp-Source: AGHT+IHQ4i0dFCyKCBlBz10LPdPw3naUXzQQwwBcn89plaep75sEakGwaM/+QbeQmq87VPUT584+Ww==
X-Received: by 2002:a05:600c:1da6:b0:412:e95f:51bb with SMTP id
 p38-20020a05600c1da600b00412e95f51bbmr1999744wms.32.1709640608816; 
 Tue, 05 Mar 2024 04:10:08 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a12-20020a05600c348c00b00412ef5a0c78sm758146wmq.43.2024.03.05.04.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 04:10:08 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 009A65F956;
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
Subject: [PATCH 05/29] gdbstub: Introduce gdbserver_fork_start()
Date: Tue,  5 Mar 2024 12:09:41 +0000
Message-Id: <20240305121005.3528075-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240305121005.3528075-1-alex.bennee@linaro.org>
References: <20240305121005.3528075-1-alex.bennee@linaro.org>
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

The upcoming follow-fork-mode child support requires knowing when
fork() is about to happen in order to initialize its state. Add a hook
for that.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20240219141628.246823-5-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/gdbstub/user.h | 5 +++++
 bsd-user/main.c        | 1 +
 gdbstub/user.c         | 4 ++++
 linux-user/main.c      | 1 +
 4 files changed, 11 insertions(+)

diff --git a/include/gdbstub/user.h b/include/gdbstub/user.h
index 68b6534130c..e33f8d9a9a6 100644
--- a/include/gdbstub/user.h
+++ b/include/gdbstub/user.h
@@ -45,6 +45,11 @@ static inline int gdb_handlesig(CPUState *cpu, int sig)
  */
 void gdb_signalled(CPUArchState *as, int sig);
 
+/**
+ * gdbserver_fork_start() - inform gdb of the upcoming fork()
+ */
+void gdbserver_fork_start(void);
+
 /**
  * gdbserver_fork() - disable gdb stub for child processes.
  * @cs: CPU
diff --git a/bsd-user/main.c b/bsd-user/main.c
index e39eef3040f..517c6b3ec2f 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -113,6 +113,7 @@ void fork_start(void)
     start_exclusive();
     cpu_list_lock();
     mmap_fork_start();
+    gdbserver_fork_start();
 }
 
 void fork_end(int child)
diff --git a/gdbstub/user.c b/gdbstub/user.c
index 3ce20b7bbfc..536fb43b03e 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -356,6 +356,10 @@ int gdbserver_start(const char *port_or_path)
     return -1;
 }
 
+void gdbserver_fork_start(void)
+{
+}
+
 static void disable_gdbstub(CPUState *thread_cpu)
 {
     CPUState *cpu;
diff --git a/linux-user/main.c b/linux-user/main.c
index 699da773714..755c566d6d2 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -145,6 +145,7 @@ void fork_start(void)
     mmap_fork_start();
     cpu_list_lock();
     qemu_plugin_user_prefork_lock();
+    gdbserver_fork_start();
 }
 
 void fork_end(int child)
-- 
2.39.2



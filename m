Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0AA6C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 12:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1XN-0007n8-9N; Tue, 12 Mar 2024 08:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk1VX-0005Rt-O5
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:45:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk1VU-0000tl-4c
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710247523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mOZ+n16hSmdhLc1QeYUQIA8GPqXkcZgaeKwVr7g+qTU=;
 b=Ku1HuOoxoGRig4YQVkKwd6HJFgpVXciV6Znd1pjO+nVLdwW7e0GUnyPZ/RtU/DqjdraLvo
 CU4S+GbCM7ixXaspFwOSP5GGm5QyZJDCwBXV/vf13leFAMareQKsP5Zbnao0hMVLWDQPTh
 yMkUa729FeAzQGDXWEyoa1PpgPzzFZQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-GfFjSG8COkutb5_eOVSdDw-1; Tue, 12 Mar 2024 08:45:21 -0400
X-MC-Unique: GfFjSG8COkutb5_eOVSdDw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6DE66800264;
 Tue, 12 Mar 2024 12:45:21 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 12E53492BD0;
 Tue, 12 Mar 2024 12:45:19 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>
Subject: [PULL 55/55] user: Prefer fast cpu_env() over slower CPU QOM cast
 macro
Date: Tue, 12 Mar 2024 13:43:39 +0100
Message-ID: <20240312124339.761630-56-thuth@redhat.com>
In-Reply-To: <20240312124339.761630-1-thuth@redhat.com>
References: <20240312124339.761630-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Mechanical patch produced running the command documented
in scripts/coccinelle/cpu_env.cocci_template header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Message-ID: <20240129164514.73104-30-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 bsd-user/signal.c   | 3 +--
 linux-user/signal.c | 6 ++----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/bsd-user/signal.c b/bsd-user/signal.c
index e9f80a06d3..3ac50c2d71 100644
--- a/bsd-user/signal.c
+++ b/bsd-user/signal.c
@@ -463,14 +463,13 @@ static int fatal_signal(int sig)
 void force_sig_fault(int sig, int code, abi_ulong addr)
 {
     CPUState *cpu = thread_cpu;
-    CPUArchState *env = cpu_env(cpu);
     target_siginfo_t info = {};
 
     info.si_signo = sig;
     info.si_errno = 0;
     info.si_code = code;
     info.si_addr = addr;
-    queue_signal(env, sig, QEMU_SI_FAULT, &info);
+    queue_signal(cpu_env(cpu), sig, QEMU_SI_FAULT, &info);
 }
 
 static void host_signal_handler(int host_sig, siginfo_t *info, void *puc)
diff --git a/linux-user/signal.c b/linux-user/signal.c
index cc7dd78e41..1aebf3fc47 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -623,7 +623,6 @@ void signal_init(void)
 void force_sig(int sig)
 {
     CPUState *cpu = thread_cpu;
-    CPUArchState *env = cpu_env(cpu);
     target_siginfo_t info = {};
 
     info.si_signo = sig;
@@ -631,7 +630,7 @@ void force_sig(int sig)
     info.si_code = TARGET_SI_KERNEL;
     info._sifields._kill._pid = 0;
     info._sifields._kill._uid = 0;
-    queue_signal(env, info.si_signo, QEMU_SI_KILL, &info);
+    queue_signal(cpu_env(cpu), info.si_signo, QEMU_SI_KILL, &info);
 }
 
 /*
@@ -641,14 +640,13 @@ void force_sig(int sig)
 void force_sig_fault(int sig, int code, abi_ulong addr)
 {
     CPUState *cpu = thread_cpu;
-    CPUArchState *env = cpu_env(cpu);
     target_siginfo_t info = {};
 
     info.si_signo = sig;
     info.si_errno = 0;
     info.si_code = code;
     info._sifields._sigfault._addr = addr;
-    queue_signal(env, sig, QEMU_SI_FAULT, &info);
+    queue_signal(cpu_env(cpu), sig, QEMU_SI_FAULT, &info);
 }
 
 /* Force a SIGSEGV if we couldn't write to memory trying to set
-- 
2.44.0



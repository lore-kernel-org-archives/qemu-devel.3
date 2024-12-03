Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A28E6C61A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 09:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIP70-0005io-8z; Tue, 03 Dec 2024 04:22:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIP6y-0005gQ-Lf
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 04:22:28 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIP6v-0002hC-Rk
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 04:22:28 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a9e8522445dso749761566b.1
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 01:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733217744; x=1733822544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PERYJEjYxWhdPat57HCXQqDRHV3hL1ijs4gpAo4T2SI=;
 b=NmzR3xqCApj5XI6D4BnGs+0oazOQGo81AygrtsTJBFLdjtW1Ekkz1sb5lL3IfVDX4p
 vXXN3gUKc006cBAyloSHuaL8alRSmKHve39lgF0FSoWljzc1zUqIyu0nZXCry98RZsPx
 gSBI1uWqBaiWKzZtU/KtGZC+KhWrB8TgqpvE7khFkZq9iscO9hlpHkD2mup3dSWo01y2
 zrCcbUZ6LdAOyEt8Q6Wk4bL5/qKaT0flnAlpJd8oUiWzlc43ca2AGYWk92f7wSnhGhwr
 Udw9DE+yhST/VvgRMpJtqkGMTt28suxNlc5t30FBJBYcsSM83D9hzcJ/YaCRl9cI1X56
 SN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733217744; x=1733822544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PERYJEjYxWhdPat57HCXQqDRHV3hL1ijs4gpAo4T2SI=;
 b=wO1bSEVsRB0IsYNmTJOr7efx8ITdUGdTkyusbmfHMNnFMkKM+VJFbdzTtOeTZS0O0+
 USwBvyepgucuDrqysxZD22xDQMBePQ20/yaV4XsVFL8+bPyMgDclkXkc3bLDuzQDfJRn
 CCgeoyI/JuHZXw5wGvudEsh76bYYRx9cjCMrq3JUs+1AHFIoGfdlmOcV+1PJ5b6iPmBn
 8yPy+osA3RyTVSfGXF3zFiflKECa7QkLf/18VHV4RltIuPXR3lqnr9459Wtvk9R1lftr
 E2yAHHQ0IX5bkG02OyLyus/xRUCNSgmhSimSxVmWyc5WzSHf4c4lzl94QzcSuzmrsqvu
 /2TQ==
X-Gm-Message-State: AOJu0Yzw5wGnZLguQt37oegAqUeAH956n15NoWBlj4qsgDX2b3aYkXK6
 xVNfBdIqJsrZKEg8UaXzjTLIPGTqpPe20X6dBfGUhPBYdHj/t1KLeiL3/k5ZU6qIablt4tL024J
 iPJs=
X-Gm-Gg: ASbGnctJwAC9uCCL2p19fasvYudsCvC2LGPT8Id5oAh7mI7kyCnTLSXij3BwfqMZqU0
 xAoY4e6FCQhJMpIOUzVnmbiq9riDTv0+qLPKAksY1LjMw9IznhZSHHr7OoMiOxiAjErXn71M42+
 uZN35BX0PpsoaCemAyAesdp554weBjMhutiqyxZ4WNcdvsRRInfTqdqA0R3cjlyjf1oB9232WF1
 thm0VT0Gd/oYXgF08qryVR+rhHr0wJl4KIHpCcecuBEEwKIouWV04/AO7U2r6ZYmj1trAO0
X-Google-Smtp-Source: AGHT+IG/10KRcSJmHbz27onCyU5ZPCzMEQmMKXxzXO8/y/6O5dpHc4TRW51Ux3lkFGHoBQyD1B/v6w==
X-Received: by 2002:a17:907:7623:b0:a9e:26ad:d0a with SMTP id
 a640c23a62f3a-aa5f7f18ec8mr118492466b.58.1733217743897; 
 Tue, 03 Dec 2024 01:22:23 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.146])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa5997d5646sm594152766b.62.2024.12.03.01.22.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Dec 2024 01:22:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 xen-devel@lists.xenproject.org, qemu-ppc@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/7] accel/tcg: Remove mentions of legacy '-machine foo,
 accel=bar'
Date: Tue,  3 Dec 2024 10:21:51 +0100
Message-ID: <20241203092153.60590-6-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203092153.60590-1-philmd@linaro.org>
References: <20241203092153.60590-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Since commit 6f6e1698a68 ("vl: configure accelerators from -accel
options") we prefer the '-accel bar' command line option.

Update the documentation when TCG is referred to.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/removed-features.rst | 2 +-
 linux-user/s390x/target_proc.h  | 2 +-
 accel/tcg/monitor.c             | 4 ++--
 system/vl.c                     | 2 +-
 tests/qtest/qmp-cmd-test.c      | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index ee6455aeeeb..d96dc5e80bc 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -216,7 +216,7 @@ The ``enforce-config-section`` property was replaced by the
 ``-no-kvm`` (removed in 5.2)
 ''''''''''''''''''''''''''''
 
-The ``-no-kvm`` argument was a synonym for setting ``-machine accel=tcg``.
+The ``-no-kvm`` argument was a synonym for setting ``-accel tcg``.
 
 ``-realtime`` (removed in 6.0)
 ''''''''''''''''''''''''''''''
diff --git a/linux-user/s390x/target_proc.h b/linux-user/s390x/target_proc.h
index a4a4821ea5c..f443d8f8080 100644
--- a/linux-user/s390x/target_proc.h
+++ b/linux-user/s390x/target_proc.h
@@ -7,7 +7,7 @@
 #define S390X_TARGET_PROC_H
 
 /*
- * Emulate what a Linux kernel running in qemu-system-s390x -M accel=tcg would
+ * Emulate what a Linux kernel running in 'qemu-system-s390x -accel tcg' would
  * show in /proc/cpuinfo.
  *
  * Skip the following in order to match the missing support in op_ecag():
diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
index 093efe97144..0430b6e1514 100644
--- a/accel/tcg/monitor.c
+++ b/accel/tcg/monitor.c
@@ -204,7 +204,7 @@ HumanReadableText *qmp_x_query_jit(Error **errp)
     g_autoptr(GString) buf = g_string_new("");
 
     if (!tcg_enabled()) {
-        error_setg(errp, "JIT information is only available with accel=tcg");
+        error_setg(errp, "JIT information is only available with TCG");
         return NULL;
     }
 
@@ -226,7 +226,7 @@ HumanReadableText *qmp_x_query_opcount(Error **errp)
 
     if (!tcg_enabled()) {
         error_setg(errp,
-                   "Opcode count information is only available with accel=tcg");
+                   "Opcode count information is only available with TCG");
         return NULL;
     }
 
diff --git a/system/vl.c b/system/vl.c
index 54998fdbc7e..c056fcb740c 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2385,7 +2385,7 @@ static void configure_accelerators(const char *progname)
         for (tmp = accel_list; *tmp; tmp++) {
             /*
              * Filter invalid accelerators here, to prevent obscenities
-             * such as "-machine accel=tcg,,thread=single".
+             * such as "-accel tcg,,thread=single".
              */
             if (accel_find(*tmp)) {
                 qemu_opts_parse_noisily(qemu_find_opts("accel"), *tmp, true);
diff --git a/tests/qtest/qmp-cmd-test.c b/tests/qtest/qmp-cmd-test.c
index 2c15f609584..83f4a2b451b 100644
--- a/tests/qtest/qmp-cmd-test.c
+++ b/tests/qtest/qmp-cmd-test.c
@@ -49,7 +49,7 @@ static int query_error_class(const char *cmd)
         { "query-vm-generation-id", ERROR_CLASS_GENERIC_ERROR },
         /* Only valid with a USB bus added */
         { "x-query-usb", ERROR_CLASS_GENERIC_ERROR },
-        /* Only valid with accel=tcg */
+        /* Only valid with TCG */
         { "x-query-jit", ERROR_CLASS_GENERIC_ERROR },
         { "x-query-opcount", ERROR_CLASS_GENERIC_ERROR },
         { "xen-event-list", ERROR_CLASS_GENERIC_ERROR },
-- 
2.45.2



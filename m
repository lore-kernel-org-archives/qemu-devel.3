Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A74E7FDCF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 11:53:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnExf-0008Uw-KZ; Tue, 03 Feb 2026 06:52:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vnEx9-000822-Af
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 06:52:22 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vnEx4-0005C1-Bu
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 06:52:19 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b886fc047d5so1038093366b.3
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 03:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770119532; x=1770724332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tIRBj03rO3D6/ePpgDjzJBDK2sDnW8f3X2SZv5WEDqc=;
 b=YeW91Pb76dHjCiaYbNFvdcAU9wEKRZWa1VsLBlBg36aDYPz38psySanO21TgWbPR2b
 SmDOu8NcSFYfIW2EwnYTE4KwqiejZiNSfzZYyI9I/Y6xCYsFyvbD26cw1P0JMn6mNw9n
 LZXJD7cbAEcGYn1LPPF+8eHd5emOsKW+f7sJO0szKNtpBIq2V0yKqF58p8c6j3oLrmJp
 jKT/DhwdV6scG2bToThjHhOljMABZctGj5QsG6Iem3PB/co1ftUrjn4IoykDtF/Uxv8E
 SX+kkN4m87MamJjeZqEdxMMMsyK4J+BkjrFPGfn3sLoqVAaO88CRNTpZD9K8QhS6jPNC
 qMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770119532; x=1770724332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tIRBj03rO3D6/ePpgDjzJBDK2sDnW8f3X2SZv5WEDqc=;
 b=Wv0AsMQP75rY67YLocV3qdLDAzRJmQ3y6Um7GXsHUS6eHn6rem3FttLI92dtypqfys
 hNL7dPbDC9rR5J4U/1o83lBxUMnVkKDAgejvOf/sZwmngIhruj29km5Ebc0aDVM07w5h
 DwkMEHtNO9/xVCo1hI+e+zWbMeif+sCq+fYQjA+vpW9jmsGn5GY2gojxnYsmp0ft1jbw
 jDoZy3Pwlk8eDnye/Z2+SOOvbAU8GCE0F3KGGiIAGwYDSZXrWWB2IjIxPWRuNt9G4w/O
 zYSCIQFRTb86yvSrz1ui/sh7viPQQDDHJY2ooBHBwFdw4WUIWmTZtjLnLltZxMu9OdZ5
 HmOw==
X-Gm-Message-State: AOJu0YxsOVYRVkeGnw8Cs1EnYpl6NDemYy5AVKlRmiPd78zgOvx+HTT2
 D1XD4Rqv0ybzZQ+gH0bRxDtEL7gZlG4MPTAbgGTAx+xcSapXQQN1IH6hR7Z0ArBG8sk=
X-Gm-Gg: AZuq6aK+semdYgkJpeDFgZT1CvbB4MWPL3NrudIgeHDaWxUFe+syon4K+yO2dV3+RVf
 YSM3Xu3sUOpZGDh/SuD5Ezkg91VjUa1/EhvD11wNc8h2XZ7pHatOAQQldd2uaWgRV1FOJX9wXye
 baFS8gD1M6DO/gW4bqVvsdHTzuJ2j4NuygJXEQASaClmVpxKrzBd7gtPNvEgSFOz3dVC89t+rr0
 P1sWFKu0Qdi1Ew+Kko3A25y8NtkamZpfFNyr+uFR+krH/LiFnP3cHRakZQtVN/k+uI4nPba2tAy
 HKAL9Twl6VUf0vZ4fZfFYzxdrnnBJeUfE59xHONg0TodGnu5aN22ttank+0sQe3uKHZDyTftxbo
 y6/8J56qGQbMecKyUDxzB1bkoEEdkVqh9CppFiw3kRCSqtdLmStJTTiSE1+1e/gV72UUtLAaid3
 JxgaQtbQ8Sv2A=
X-Received: by 2002:a17:907:7f88:b0:b72:70ad:b8f0 with SMTP id
 a640c23a62f3a-b8dff6531eemr919591466b.36.1770119531829; 
 Tue, 03 Feb 2026 03:52:11 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8dbefc667asm1038953166b.22.2026.02.03.03.52.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 03:52:07 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 214FB6051B;
 Tue, 03 Feb 2026 11:52:03 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 11/11] gdbstub/user: rename and use bool for running_state
Date: Tue,  3 Feb 2026 11:52:01 +0000
Message-ID: <20260203115201.2387721-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260203115201.2387721-1-alex.bennee@linaro.org>
References: <20260203115201.2387721-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is just a clean-up to document what we using the running variable
for in user-mode.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub/user.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/gdbstub/user.c b/gdbstub/user.c
index a16f37616b1..97eb13e796a 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -87,7 +87,11 @@ enum GDBForkMessage {
 typedef struct {
     int fd;
     char *socket_path;
-    int running_state;
+    /*
+     * running state of the guest, when we process a packet that restarts
+     * the guest we set this to true.
+     */
+    bool running;
     /*
      * Store syscalls mask without memory allocation in order to avoid
      * implementing synchronization.
@@ -241,8 +245,8 @@ int gdb_handlesig(CPUState *cpu, int sig, const char *reason, void *siginfo,
 
     sig = 0;
     gdbserver_state.state = RS_IDLE;
-    gdbserver_user_state.running_state = 0;
-    while (gdbserver_user_state.running_state == 0) {
+    gdbserver_user_state.running = false;
+    while (!gdbserver_user_state.running) {
         char buf[256];
         int n = read(gdbserver_user_state.fd, buf, 256);
         if (n > 0) {
@@ -611,11 +615,11 @@ void gdbserver_fork_end(CPUState *cpu, pid_t pid)
 
     gdbserver_state.state = RS_IDLE;
     gdbserver_state.allow_stop_reply = false;
-    gdbserver_user_state.running_state = 0;
+    gdbserver_user_state.running = false;
     for (;;) {
         switch (gdbserver_user_state.fork_state) {
         case GDB_FORK_ENABLED:
-            if (gdbserver_user_state.running_state) {
+            if (gdbserver_user_state.running) {
                 close(fd);
                 return;
             }
@@ -728,7 +732,7 @@ void gdb_handle_query_attached(GArray *params, void *user_ctx)
 
 void gdb_continue(void)
 {
-    gdbserver_user_state.running_state = 1;
+    gdbserver_user_state.running = true;
     trace_gdbstub_op_continue();
 }
 
@@ -750,7 +754,7 @@ int gdb_continue_partial(char *newstates)
             cpu_single_step(cpu, gdbserver_state.sstep_flags);
         }
     }
-    gdbserver_user_state.running_state = 1;
+    gdbserver_user_state.running = true;
     return res;
 }
 
-- 
2.47.3



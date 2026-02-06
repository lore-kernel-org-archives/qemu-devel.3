Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA538EE6B46
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 18:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voQDC-0008En-Ua; Fri, 06 Feb 2026 13:05:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1voQCu-0007zq-Cz
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:05:29 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1voQCs-0001SZ-Ux
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:05:28 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6505cac9879so3093217a12.1
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 10:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770401125; x=1771005925; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8GQHCXcw7F2TcL9IvvM3htlqgvvrWvp6j+kXPyYlQag=;
 b=FtIi1ZakrIirSbQps3CpnZN5Vx7zZRmdCXRnKmNfX5hHOye6bt48R746aq5+M7igjd
 dhgW4737kg6w6P5RXhg2GUFSarJCvdYrae+aghOj6aqu0JM2FVOf3HSuKgC0Ip5ONS79
 5SCFl1d+I5Z5Ng2b1FJvkv88Zq+sTdOcWc8MpRmT75Oj07kl1YsosOQDoW5stUQ1oc+/
 u2R83XrtsyWGCAJk0LYVMyXcrL2Uzl0dSZaoIEjq8z8kb6htvFPN88j99/4uWMg2uyRs
 qV/0jEsj3nT7kFGLDY8yrZmSBHuZiXLgLGikqUqu3KBPVL1M+eo60vbldOMFS27mj9x1
 lO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770401125; x=1771005925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8GQHCXcw7F2TcL9IvvM3htlqgvvrWvp6j+kXPyYlQag=;
 b=m6iDUk3rOhl7npoQOUCjXSwvk1BOCmKytjbERj4GDibnvOrlBCtYvYczkfDXIsN3bP
 UnKjISbSkmPR4GPfKKUaFnIEah0COFnSRrq/BlB9eJrnJf2aIM5uV21hmyP+BJvXHASC
 nwzvX11JsASf4KPRzMBAz4NCggqtWH2Bb4ZO0ufzdEX9+aeVBTgKtz1hhc3gy2b0YcX7
 79/ujkgjw9+F53ioACNTpkOF00xhB9+wSq9FL+v+T7Cpy4Ylf7YsWb1sVkKwy985ixIS
 vFwXHibOBUIanIXIJo2FcSqpK2PzX5787bnRWMu5snmlzImf4ve+Nfg5hkqAiKouMx03
 0LmA==
X-Gm-Message-State: AOJu0YxnfHV0j26OUrazmDuSW9Htq0MtxVNOu33W+/iwDkYV6aETFISo
 ml7DzERrUohH2VaZA4f+qPjCZxmaTeda82bnHUoIgiP65eyQDwybn2zXRB9pyUt/JetopjCDY/r
 nWybp6Ao=
X-Gm-Gg: AZuq6aL7TIhdHNmjxriVqQwX1DXrOjt3T/rIXabfdoAqnhokBaa7xIHSIiMGwz0A5Uc
 W+wWITFw0eUIoM1bFv84rnV7+fk2JkhrAJleeL4C2/Qxz7TFrGlN8/x0NbCwKtB8ellWpmo4UlG
 Qlfz9g79ZiMgDSgioEG6d3Lh6js/GbIfVONLkDCGfjEer+dyMOEU8l1BF/rwbvkQ7cK5YvySqwm
 EWDp8GivoPv893dh6+TULFWvE1Dx6VJ+PcAmE96oApyxu01i+SF7Hbeg9lnstteobOoE9ZPskgs
 m0Mzl9xlOa8MI1yX2KZ3xoh9hZ7pPSyaPuWRAY/Yyv4oe71vCx/Z2oUfRLSjtgjP4jPOTenkA6Y
 kl9tIt0Th5SJpEUBt12W/u6wAuoj/9fU2jiklfBLvulzvYCKDaT67VhtUZoZtgBi2roaBC1wV0X
 1CeiTPoreCJaM=
X-Received: by 2002:a05:6402:5201:b0:659:38ea:c4e3 with SMTP id
 4fb4d7f45d1cf-65984184879mr1798226a12.25.1770401125321; 
 Fri, 06 Feb 2026 10:05:25 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65983ec70fdsm678004a12.15.2026.02.06.10.05.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 10:05:21 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 390C3607C3;
 Fri, 06 Feb 2026 18:05:18 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/10] gdbstub/user: localise variables for reading gdb socket
Date: Fri,  6 Feb 2026 18:05:12 +0000
Message-ID: <20260206180517.1335861-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206180517.1335861-1-alex.bennee@linaro.org>
References: <20260206180517.1335861-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52d.google.com
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

Keep things tidy by moving the declarations to the block where they
are used.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260203115201.2387721-6-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/gdbstub/user.c b/gdbstub/user.c
index 14369b9ce5e..a16f37616b1 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -198,9 +198,6 @@ void gdb_qemu_exit(int code)
 int gdb_handlesig(CPUState *cpu, int sig, const char *reason, void *siginfo,
                   int siginfo_len)
 {
-    char buf[256];
-    int n;
-
     if (!gdbserver_state.init || gdbserver_user_state.fd < 0) {
         return sig;
     }
@@ -246,11 +243,10 @@ int gdb_handlesig(CPUState *cpu, int sig, const char *reason, void *siginfo,
     gdbserver_state.state = RS_IDLE;
     gdbserver_user_state.running_state = 0;
     while (gdbserver_user_state.running_state == 0) {
-        n = read(gdbserver_user_state.fd, buf, 256);
+        char buf[256];
+        int n = read(gdbserver_user_state.fd, buf, 256);
         if (n > 0) {
-            int i;
-
-            for (i = 0; i < n; i++) {
+            for (int i = 0; i < n; i++) {
                 gdb_read_byte(buf[i]);
             }
         } else {
-- 
2.47.3



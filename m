Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B0DBCCF2DE
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 19:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhufI-0006me-TQ; Mon, 19 Jan 2026 14:11:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vhufG-0006kZ-F1
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:11:50 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vhufD-0001TJ-Vp
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:11:50 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2a0a33d0585so28451685ad.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 11:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768849906; x=1769454706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rrBMb4pzsR09kFtei/WUANIUl/9qDP19I1CZ/cFKqvE=;
 b=HXN5CkW4UklF9GYXEiyG9p8VtZUmRyTx83ZJOjJ9TTRv8UXE3kmBX8BR4Bw1ZchoiV
 WtsaeRRWDk70ftCiDU7msBypvulvogzTM2sPq796DBFeMeQlSiZFeHDKAWlQE8Ei1C/Y
 HJ6VXDR4cQ3La0/1/f0ijnY8GcfZzNmoh9l/N38oHfdb0EfG3e4K3l8d37IOSXve5wVh
 4J922E9VzGKON6Ixpd8cO+K7A690TzDpewkCkEwnUfpDzA55jUVtFfVxoFT/Ym9HiZJk
 MbqtCMnN7AoeU4s9BsRbFzW79G2lq+fPmqXK984S8L4SngnNUZPv7DCg8xEE8rThkADI
 8gBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768849906; x=1769454706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rrBMb4pzsR09kFtei/WUANIUl/9qDP19I1CZ/cFKqvE=;
 b=rtUlBFoVsENqPkXAGINPqarGaVb0Hdh0iaaGeScQ2Zq5tg5kNNprgZ9wIXdxYKTzls
 6n84k1UYCkuyvZDLjP4KcqPAq159BaQFq/EzbvLMMDrI3pA6clPr1kEY8soYEvmKmkxO
 RJkoubnTWUZX4qqW6GIPuL7SNS7NH2aOtYLmSOgLV6WhpYyI/vquDvIFYQ1eUGM7qhfk
 u5qbtcAk4oOmi35y7flexKqpkjMCuRQsrzc1Z5cfewXYWB35z4UEpEJtMQFHkj9/Gm21
 O4czL5pGFUMrKndmoXLxcT8EvXBtUDlzCfVWdFt3g8v43QmoKyS5jTfxHsMTc8WpQAcX
 5+vw==
X-Gm-Message-State: AOJu0YxlIDcQevxd02a/SDYfsXuzO8taH7d8p0jJEsmk1p5hSrjVV49f
 rGLiZ5QRSlaQg+y5bcZ4sqPNV4+9LyBVnYZF+mygAv0HdZXe2FjaOHZrFCQgAi+r+mWZEMqvwba
 K83kA
X-Gm-Gg: AZuq6aL9PVFtD3hnvYma9N2TKUIdT98Pq3dPYa1sSjQbNIqO0q9PAHzybONw6elcOd6
 t8PtyIi8kebNllfW2bS9aJ/wgLhUK64KYnZO1lw56R+aJW6NTIgyFPGsIL+K4uux281x1VB4T27
 2toLd7dEAOD62qPIljlcvGCsAybpTne2C5+c3ze/u9PhXrPqa8MZNqqEzSKSLBP5cGw6UHbNtA4
 FhTLsLlJHZfMrUTihDwPTRFF5RkJOt62MR+LelWnU8fnpLJIm2Qx2JJQy9WjRAhJWwGj/1zo3kn
 xyy8hgvp6fWv/DyC0qiazlMyqTMu4tP5bWZCf7hMcZdbvf7Eq36Ev61wPwA0sosld0oHyI0oV/7
 +fCmuZ/jg1iUMSN2C9VgJmN4SqKDG023q6urgsko1L+Y/G89cWeelXLgec5VJMLXIVc2/8SL96X
 e1F2lCodXaHRNObVSCsthvIJEqRQBTWj7tx16yynIQ1TA8URUIzrayHrTptfqcURX3
X-Received: by 2002:a17:903:37c3:b0:295:5132:1a99 with SMTP id
 d9443c01a7336-2a718918e9bmr111193215ad.44.1768849906368; 
 Mon, 19 Jan 2026 11:11:46 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a719415f0asm47011795ad.89.2026.01.19.11.11.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 11:11:46 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 01/11] plugins: move win32_linker.c file to plugins
 directory
Date: Mon, 19 Jan 2026 11:11:27 -0800
Message-ID: <20260119191138.811069-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260119191138.811069-1-pierrick.bouvier@linaro.org>
References: <20260119191138.811069-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 {contrib/plugins => plugins}/win32_linker.c | 0
 contrib/plugins/meson.build                 | 2 +-
 tests/tcg/plugins/meson.build               | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename {contrib/plugins => plugins}/win32_linker.c (100%)

diff --git a/contrib/plugins/win32_linker.c b/plugins/win32_linker.c
similarity index 100%
rename from contrib/plugins/win32_linker.c
rename to plugins/win32_linker.c
diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
index eb944b5159a..6f72b2ce0c9 100644
--- a/contrib/plugins/meson.build
+++ b/contrib/plugins/meson.build
@@ -10,7 +10,7 @@ t = []
 if get_option('plugins')
   foreach i : contrib_plugins
     if host_os == 'windows'
-      t += shared_module(i, files(i + '.c') + 'win32_linker.c',
+      t += shared_module(i, files(i + '.c') + '../../plugins/win32_linker.c',
                         include_directories: '../../include/qemu',
                         link_depends: [win32_qemu_plugin_api_lib],
                         link_args: win32_qemu_plugin_api_link_flags,
diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index 561584159eb..a6e78438510 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -2,7 +2,7 @@ t = []
 if get_option('plugins')
   foreach i : ['bb', 'discons', 'empty', 'inline', 'insn', 'mem', 'reset', 'syscall', 'patch']
     if host_os == 'windows'
-      t += shared_module(i, files(i + '.c') + '../../../contrib/plugins/win32_linker.c',
+      t += shared_module(i, files(i + '.c') + '../../../plugins/win32_linker.c',
                         include_directories: '../../../include/qemu',
                         link_depends: [win32_qemu_plugin_api_lib],
                         link_args: win32_qemu_plugin_api_link_flags,
-- 
2.47.3



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71DE8D58D5E
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 15:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFatw-000435-13; Mon, 25 Nov 2024 10:21:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFatr-0003zX-5R
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:21:19 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFatp-0001mi-8B
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:21:18 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-382442b7d9aso3503802f8f.1
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 07:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732548075; x=1733152875; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nUCdTQ7gpHma3kBEA41WeT+vE2SwWkH8lZ6tNfxSmDY=;
 b=HA8uIE3GXftq8ve7I9mgZfH3vg0ydwBJBCY64qI3v9JjnIeJobu+N43qTt+Sbe1gVb
 tQIWorfSpLGsDAf80udEg9K7wR+ul/lfC0mD+/yh3ncV8MqW/OaML6hnXSgUQzy3ooOY
 Wdaf0P10iy3+/lgyTuPVml2EINXFpCYwwHejN1hUKldCizTJgVqHoCShxyKAjp1hLA4P
 QCy7mJw1h9ulMMJEm38g+8eBIljvodC2okv6NtOrsLeW0PhTWt4KmWO9jywsgMlsgh3j
 +DidX81JIDfEesYiQ3pXGUYda23Ciz5Q1LlEQrhyRqHrlvjbYGRQw5RjdvCADyU/4B+1
 1iig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732548075; x=1733152875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nUCdTQ7gpHma3kBEA41WeT+vE2SwWkH8lZ6tNfxSmDY=;
 b=Qcia0lM4/LnQbgDxnWJ1lsVlAN5Tpb+vVcImskFKhBPGveouBeWEuC7gX+FoB8t7+r
 tgZZr8MaKb18cWpbc70u5IQJ8FvrVKtNdHevkKwiK5pP7dNDu33Ww2KIuoIhFUUU5W5u
 U2zh/b9QFZJGfi/dNsQu31qcxzA4ercIqApB0YkTNiDTgq4QfRQEjx62xBsLiJbmzEyq
 HtcZdxuHZPt5/avG4kMUQPuosNplEm6zfEcAax6pck04JpyvII1qIr6Uu1Px9RG5yq+h
 Yx/Npo0uLqkbcVuN4mnY2dAq9Tvrje0/lIpqVG5q9U8qXkcpWyMLoIEjSXY5EOcYg87f
 Ouvg==
X-Gm-Message-State: AOJu0YyFyPzUC0uM2j3xizx8upTttmb1zNOz/Mhni5Qts9KMyYfDjI7O
 mNv407fmr/SgSdhsQESDf7Ri01OGwOnlYxC/K2MdIjFROx/fC6IJST9PXEGgDyc=
X-Gm-Gg: ASbGncugVn3lrTkEg7h1i1apwJEhj+N8ooixFbOvZHtffZUNV3FCAXc327gAN8M1OSZ
 AJMGaGpislVyIddCPYs7TO6RK8baYDOouHJYPE5w6GoU4p4YNpLqzu2xd6DWlbnrY/O3AbXNmXN
 FuHUuKvsNWWDthM1cHIoOhE2h3V/L4dzC146JSHS1rOgQyrgixpe2IYuUp1yDNjpvV0ZblfuKo7
 OLRpqzWOLOdEy89BVdhHfK87HtCPwVfYom9DlEs636tYeSy
X-Google-Smtp-Source: AGHT+IEDBwQA24S8ZXvPjnlgY0jY3GAX2llgHQx11r2y4G/hFZga0O2iRIRwrhRPqegqlX14UCrgvA==
X-Received: by 2002:a05:6000:2807:b0:382:372a:572d with SMTP id
 ffacd0b85a97d-38260b71395mr7712934f8f.27.1732548075569; 
 Mon, 25 Nov 2024 07:21:15 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fb25d74sm10795103f8f.47.2024.11.25.07.21.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 07:21:14 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 43775610F1;
 Mon, 25 Nov 2024 15:21:07 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 16/28] tests/functional: remove time.sleep usage from tuxrun
 tests
Date: Mon, 25 Nov 2024 15:20:53 +0000
Message-Id: <20241125152105.2100395-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241125152105.2100395-1-alex.bennee@linaro.org>
References: <20241125152105.2100395-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

The tuxrun tests send a series of strings to the guest to login
and then run commands. Since we have been unable to match on
console output that isn't followed by a newline, the test used
many time.sleep() statements to pretend to synchronize with
the guest.

This has proved to be unreliable for the aarch64be instance of
the tuxrun tests, with the test often hanging. The hang is a
very subtle timing problem, and it is suspected that some
(otherwise apparently harmless) I/O error messages could be
resulting in full FIFO buffers, stalling interaction with
the guest.

With the newly rewritten console interaction able to match
strings that don't have a following newline, the tux run
tests can now match directly on the login prompt, and/or
shell PS1 prompt.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2689
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20241121154218.1423005-17-berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241121165806.476008-17-alex.bennee@linaro.org>

diff --git a/tests/functional/qemu_test/tuxruntest.py b/tests/functional/qemu_test/tuxruntest.py
index ed2b238c92..ab3b27da43 100644
--- a/tests/functional/qemu_test/tuxruntest.py
+++ b/tests/functional/qemu_test/tuxruntest.py
@@ -124,16 +124,12 @@ def run_tuxtest_tests(self, haltmsg):
         then do a few things on the console. Trigger a shutdown and
         wait to exit cleanly.
         """
-        self.wait_for_console_pattern("Welcome to TuxTest")
-        time.sleep(0.2)
-        exec_command(self, 'root')
-        time.sleep(0.2)
-        exec_command(self, 'cat /proc/interrupts')
-        time.sleep(0.1)
-        exec_command(self, 'cat /proc/self/maps')
-        time.sleep(0.1)
-        exec_command(self, 'uname -a')
-        time.sleep(0.1)
+        ps1='root@tuxtest:~#'
+        self.wait_for_console_pattern('tuxtest login:')
+        exec_command_and_wait_for_pattern(self, 'root', ps1)
+        exec_command_and_wait_for_pattern(self, 'cat /proc/interrupts', ps1)
+        exec_command_and_wait_for_pattern(self, 'cat /proc/self/maps', ps1)
+        exec_command_and_wait_for_pattern(self, 'uname -a', ps1)
         exec_command_and_wait_for_pattern(self, 'halt', haltmsg)
 
         # Wait for VM to shut down gracefully if it can
-- 
2.39.5



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F026C25B75
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 11:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Txv-0005KD-4c; Mon, 13 May 2024 07:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s6Txh-0005AP-Ax
 for qemu-devel@nongnu.org; Mon, 13 May 2024 07:35:21 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s6Txe-0001QT-EP
 for qemu-devel@nongnu.org; Mon, 13 May 2024 07:35:21 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2df83058d48so55161941fa.1
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 04:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715600115; x=1716204915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+bpzsiTQ+FU6Gt5FKC4227ayMzpXN9CSi3lSLOCpI+I=;
 b=BlQE/N0VyiXgchighd1VEj4pNlJCjPTxjzpEsifPRLEYEuV4CB7upwIIV5KIc/VSWp
 Fd58T0HjiGuO2/GaZUYgpnxUDUUwIgiYKfWq5ouHXOMj1Q68+aaN0HRyRJ3WaJqwxC+1
 U5osT1KrzOhb0W62tsqiL25nAi723P70PA0hE3amTbiz66T1uU2R5j7hhwvUGzeUmfd0
 bu/DbWrfwcV8EbKky2rJrpYyD6nHImzDp5pCrEtvnWnMGFfW9TPGdD/k9FBW6Um9jmQb
 deJlqKPR3bB7glb7Tj7L6sHI31DzFuY2rumUnclaORXtrYfwV7SmymLbnMnzUeGHNXQk
 7lWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715600115; x=1716204915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+bpzsiTQ+FU6Gt5FKC4227ayMzpXN9CSi3lSLOCpI+I=;
 b=gs/KvdWnNGPlr5rEbJm/ECQNomm/2JTQNZRt/i6/QnYt8Rawv7hBTudTvRPGItbWZb
 nLZjlxrADcf1eflINQ2NuJwy8aL/XZzvAlt183GeoFCvlFWLtoJiQDyoXfNbkmhXOxWc
 zuEEYTp0ADHdRi/ZQiNaqoqhKXSlCJUenTEVGz5aQTzrhFmnWbuYiSYZTaZFWcRcNC4u
 eVc5+x4sZ5/1IVIrzCGZmQrVeHXU2UrP/NAM3Vtbkog2nS0A/o1+kkK3eHoMkcb00c00
 XPIiZMYlOiEt3E71XvnMvW0sgfOeMd0X6OJ7HdmAfe0uIgUinQXCM5f9n+ZWzv6ywj4r
 b4xw==
X-Gm-Message-State: AOJu0YwHORrzsCzq1awK4Oq6UbIyZUkkMB4ZSusJwBxo8gchf5boRdQ3
 ndMrdSOXSPZXO/TYGZSGWqts4nq4/EmEPmqsE6ZS1kwVmJZAWkQ3wVlyatBc9wY=
X-Google-Smtp-Source: AGHT+IFdAn8dx0/lO56uhdqPRiNBNSVEH3OBExGim20uiVBDDj6n5I2PjMUyRDqLMBx6vt3NQkdc6Q==
X-Received: by 2002:a2e:97d0:0:b0:2e3:6ef5:d567 with SMTP id
 38308e7fff4ca-2e51ff4d239mr57211281fa.30.1715600115329; 
 Mon, 13 May 2024 04:35:15 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35045583669sm9317707f8f.106.2024.05.13.04.35.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 04:35:14 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5DC5C5F8C8;
 Mon, 13 May 2024 12:35:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [Semihosting Tests PATCH 1/3] .editorconfig: add code conventions for
 tooling
Date: Mon, 13 May 2024 12:35:11 +0100
Message-Id: <20240513113513.640007-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240513113513.640007-1-alex.bennee@linaro.org>
References: <20240513113513.640007-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22b.google.com
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

It's a pain when you come back to a code base you haven't touched in a
while and realise whatever indent settings you were using having
carried over. Add an editorconfig and be done with it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .editorconfig | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 .editorconfig

diff --git a/.editorconfig b/.editorconfig
new file mode 100644
index 0000000..e1540ae
--- /dev/null
+++ b/.editorconfig
@@ -0,0 +1,28 @@
+# EditorConfig is a file format and collection of text editor plugins
+# for maintaining consistent coding styles between different editors
+# and IDEs. Most popular editors support this either natively or via
+# plugin.
+#
+# Check https://editorconfig.org for details.
+#
+# Emacs: you need https://github.com/10sr/editorconfig-custom-majormode-el
+# to automatically enable the appropriate major-mode for your files
+# that aren't already caught by your existing config.
+#
+
+root = true
+
+[*]
+end_of_line = lf
+insert_final_newline = true
+charset = utf-8
+
+[Makefile*]
+indent_style = tab
+indent_size = 8
+emacs_mode = makefile
+
+[*.{c,h}]
+indent_style = space
+indent_size = 4
+emacs_mode = c
-- 
2.39.2



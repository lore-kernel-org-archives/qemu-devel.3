Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9963DC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 11:24:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCdsl-00055v-N2; Thu, 30 May 2024 07:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCdsj-0004yz-RS
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:23:41 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCdse-0002gF-Hd
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:23:41 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-52b7ebb2668so685039e87.2
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 04:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717068214; x=1717673014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oZxIGZlTq6Y3xT2BvJ15fFream5O9L7a1aAvj3sA9CY=;
 b=SUSiDT3xEk0RxK9BzlFio2IMaRyfMsRjc3nx6IKbODfUPkSLq8C7V6oGvZITxJeAMF
 0szo29diFUBt1/ivOTrGlTvec0RzEy54ZrG6uaHOLQqQImGDe31W4PMfnS36TvpCT5/i
 nl3OUsIZe6rU9Ljyd7MAg+7BY4/FTog0SIOjtecnJYZtDXFbHY98bxcTpGKgmXD5Ls7m
 P8FIsepf0xEmaB+Qf9UfLiF52/iVNsfj/zyB7XII0qzAGe5QQzHFJZI4DcCWOzm4KjRF
 qalmr1f9EXlutComIr89GtkKIJ838kuFJavSlthT56JKkSiJa1zhifxEjVTKFefmvA+L
 YzlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717068214; x=1717673014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oZxIGZlTq6Y3xT2BvJ15fFream5O9L7a1aAvj3sA9CY=;
 b=twmW6+kX96upb34cmU5VO6GMUfenaQLW3isYkP4H+5OhEuhU5FvOsjlNDLZy7g7RKA
 by0gxjBxtQ5h1aOwxUXQP7qrhQbANYmWTcKeuPgwgCzTj0VQSDI3Ak19F/QmjGbEUcJ6
 Z7cIPm4eVGV4hGUV1AGS6P5jqTyGL1eIlKGUyev7w0J+WdAhcMsuKBh9/BssgIZjrJ4g
 rIjZsvSob6w2dzAoX2oc2azICQVT3zwOREVVtDKyACVoDs+5PLsN93GQmZwRZT1Axuti
 s8dE6nhMAykvnBKZ68XWCX74oiu0k4X5p3ICUfLqvj3gp64DMWVyO0gOvSyQYPd+faJ4
 WFHQ==
X-Gm-Message-State: AOJu0Yw0cIlmKhgcl3IU7TjGQfLAnA+PzrTET+Co/IUHx3pgALw3nXeK
 rEcWlD6Xz27XXuyQ23QX1eLHdiYPAmK2+5wqZNhtp1cbnasUK/6BKiPOcnJ4ZWI=
X-Google-Smtp-Source: AGHT+IHz+5QSXgu3C7cPewo9Wd0ndcHczrM83YQnZZdCVJYBllnyUP95R0fARidB6uBbgzS6ZHy3OA==
X-Received: by 2002:a19:8c51:0:b0:51f:9549:9c0d with SMTP id
 2adb3069b0e04-52b7d49970cmr1427260e87.48.1717068213909; 
 Thu, 30 May 2024 04:23:33 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cc8b980sm808318366b.154.2024.05.30.04.23.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 04:23:33 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C287C5F8D5;
 Thu, 30 May 2024 12:23:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [Semihosting Tests PATCH v2 1/3] .editorconfig: add code conventions
 for tooling
Date: Thu, 30 May 2024 12:23:30 +0100
Message-Id: <20240530112332.1439238-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240530112332.1439238-1-alex.bennee@linaro.org>
References: <20240530112332.1439238-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x130.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01, URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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
v2
  - drop mention of custom major modes (not needed here)
  - include section for assembly
---
 .editorconfig | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 .editorconfig

diff --git a/.editorconfig b/.editorconfig
new file mode 100644
index 0000000..c72a55c
--- /dev/null
+++ b/.editorconfig
@@ -0,0 +1,29 @@
+# EditorConfig is a file format and collection of text editor plugins
+# for maintaining consistent coding styles between different editors
+# and IDEs. Most popular editors support this either natively or via
+# plugin.
+#
+# Check https://editorconfig.org for details.
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
+
+[*.{s,S}]
+indent_style = tab
+indent_size = 8
+emacs_mode = asm
-- 
2.39.2



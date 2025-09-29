Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C12CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 13:46:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3EB0-0007Nf-Bl; Mon, 29 Sep 2025 09:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v3EAy-0007KJ-0B
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 09:44:24 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v3EAj-0004iw-6p
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 09:44:23 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46e37d10ed2so44946115e9.2
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 06:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759153437; x=1759758237; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GPSTf1Nqxqut7hMCbWBenb7Umki+Ui9sveMve5KSzJc=;
 b=Eha4wphJmA9/CsLhb2U0v8qwosqP9tLtabwr5rs2LGOt2FsZS1WMjWFZvHggqCpGor
 rHzZZmQL4j3E7V1bK9WM0fboV5wyWPc9x5MuejKv5oFl1NzW71th14JqyIXIXeUcJqMf
 xkMomgh1DlEqs2hfh8ig6dAfUeX47eoEoohmUIcYzhftQeKpKqw5ioaRJH+fPz+q7zAo
 45wAcUF5Z6aVRTV90SKylbyceS+XTLHuubz6qHQfxvSHxI9aJMPgYzRNhUgXtS00hmip
 fa2O4AuVD8jBrIpl3rhYQo91ySjXvzCai4MSQEAXVGQQkbrz0i5QYIW6bQSSZc0P7H3w
 /1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759153437; x=1759758237;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GPSTf1Nqxqut7hMCbWBenb7Umki+Ui9sveMve5KSzJc=;
 b=NnhYqQl9j4OQMPMhw1gUAWT/4UzXGCqSCsgqsur6uVyBjsus1cAsVM5oZT+CnqlwBz
 N8MbBbYd5Sy1nDdEUWlN3jBM+MoS3M6gSNKz96uoIhK0xjAzMPQvx6dk6Txm0izgr8a1
 ORMSeASRUChQ/nUzSFfE5t4ACy2izJbKyCHeb/lHVgJodcDa7S3wVI9wq4hTWN0VevKh
 SRzuU7evUS4vwaRSBgPc9U08ySdwC1bgu//OKDev9GdaGkVTKGZysJGFxFlmunHGJ0Cb
 K/v/grzZm/4dVb6LBoWbLloGDvMxIYDrLle9KUebt6Au9EnXUJDFAdxnFi56NmfU1zem
 ulEQ==
X-Gm-Message-State: AOJu0YzqFik1VqndOF8k68n8rb+sKcDeBGXqdQafk/50Tr5Tmu8Ncug1
 bkWy9VSGHiB95tFsRT9pOHQUG5OmN9Br/HKX3Y/QJErX3Akkp7ptlrFSb8lEqPvtaYA=
X-Gm-Gg: ASbGncuGYe8KPS80mlrNRsSoDbArcI687s2ryr7XlBG9yCxW+0Yu7x9BKumXON2usxD
 d/Yks95MgwQQ4xJplcIXQgBpt+ESDo1msCAsPfWAQBP5rP5pqPDBMsBDNacWFqXAwdzoY9RdTjH
 I1Z7vWH7Cbs1YkOAg9FY5rFVTUcH582ukiowv0LwmhncvRwn40+IQmoOEDAasMXYWqp/9zb9FgR
 X1JZv2+D91AuMzvq+/AgjgHrZssmDsYzJH4dFWUSK6KTYZFhMs/OubuqP6usQYB6dLuQynePx+x
 XBvwkDoARQEfE6DlzIeQQ6ckRSBtWvnRc2tDDEPhuvYVBsTvnXLbXhVGyW1ppslcOxIMaoY9znC
 AC8nKiQfj6oav+3gBO1xk4vxMDU8SLn0pJ62xlF0EzROh
X-Google-Smtp-Source: AGHT+IE9/Pn1KTFugl9ikHm89RkR7TfY1cVxR4TpjYAJjzDoIzbc00+nwutiFLMHrcsmABfz30vErg==
X-Received: by 2002:a05:600c:8b27:b0:46d:27b7:e7e5 with SMTP id
 5b1f17b1804b1-46e39d7a4b7mr114179535e9.32.1759153437400; 
 Mon, 29 Sep 2025 06:43:57 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc6cf3835sm18532433f8f.46.2025.09.29.06.43.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 06:43:56 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 005A55F83A;
 Mon, 29 Sep 2025 14:43:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH] .gitpublish: use origin/master as default base
Date: Mon, 29 Sep 2025 14:43:48 +0100
Message-ID: <20250929134348.1589790-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This is very much the result of my recent fat finger but I think it's
safer to assume that origin/master points to a recent commit (or at
least a commit a given branch is based on) than master.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitpublish | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/.gitpublish b/.gitpublish
index a13f8c7c0ec..a3adb21ffa1 100644
--- a/.gitpublish
+++ b/.gitpublish
@@ -4,48 +4,48 @@
 # See https://github.com/stefanha/git-publish for more information
 #
 [gitpublishprofile "default"]
-base = master
+base = origin/master
 to = qemu-devel@nongnu.org
 cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
 
 [gitpublishprofile "rfc"]
-base = master
+base = origin/master
 prefix = RFC PATCH
 to = qemu-devel@nongnu.org
 cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
 
 [gitpublishprofile "stable"]
-base = master
+base = origin/master
 to = qemu-devel@nongnu.org
 cc = qemu-stable@nongnu.org
 cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
 
 [gitpublishprofile "trivial"]
-base = master
+base = origin/master
 to = qemu-devel@nongnu.org
 cc = qemu-trivial@nongnu.org
 cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
 
 [gitpublishprofile "block"]
-base = master
+base = origin/master
 to = qemu-devel@nongnu.org
 cc = qemu-block@nongnu.org
 cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
 
 [gitpublishprofile "arm"]
-base = master
+base = origin/master
 to = qemu-devel@nongnu.org
 cc = qemu-arm@nongnu.org
 cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
 
 [gitpublishprofile "s390"]
-base = master
+base = origin/master
 to = qemu-devel@nongnu.org
 cc = qemu-s390@nongnu.org
 cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
 
 [gitpublishprofile "ppc"]
-base = master
+base = origin/master
 to = qemu-devel@nongnu.org
 cc = qemu-ppc@nongnu.org
 cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
-- 
2.47.3



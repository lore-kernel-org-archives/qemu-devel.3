Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B384CD4840
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 16:18:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMTKo-0002GP-Tf; Mon, 11 May 2026 12:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wMTKW-0002Bu-R4
 for qemu-devel@nongnu.org; Mon, 11 May 2026 12:18:05 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wMTKV-0001C4-60
 for qemu-devel@nongnu.org; Mon, 11 May 2026 12:18:04 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-441209fb77eso2752875f8f.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 09:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778516281; x=1779121081; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gD0QpXr/F9S7p8iJhZWmtNBW302odxa2Kjp+IZa5kj0=;
 b=eTBsHRVxKEMVd1pHdAi0/LR8TwbupTnxTTk3MslJLO1slIbc5kLq35O4EgjYOAMRX+
 dNA7/JxaXHG6ik7kM3EflmQv//jwbaTnAU+Cu5oLTIkpX7wrOrvgiay1P4K5HC2hbyDE
 qxTAzrL7nv1aHgmxLluYSoPX+a2g2nlIgXbGz+afk6/G7wCCDhpkheCK7vqNv8B6Tgp6
 sWCalrpa4OKO+NyaJvo8oMNcV3uZmEH4PKw9DdNtKtMYaQarKA51BmqxIl8IOyyytxnA
 gWmtxy0d4jjGK3kMOY4kOHFaQWVCZYcUgQZUTXysoUpL2l+SnGQJw6mkicLgPo0631R0
 qiVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778516281; x=1779121081;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gD0QpXr/F9S7p8iJhZWmtNBW302odxa2Kjp+IZa5kj0=;
 b=S+iURVQnfNTHq3VqRLlynb6BGbR/KWDyQCVTbGVHxO+a6D5HzILvPLY9KUWLPS+4v0
 vurdjfHv4A22mkc9EAErjKOHKl1XGnRVmDax0AYZVt6S/0ol3mLCkAYkZB0wD7z/7h1N
 2fzaEVuuKtI/blXF/zA/mCVBRkjzJzEp22MSLXmAl0wnDlwRGGzQ6QWzUHw3+3dggmej
 1XYY1oayCu121rzVmYhnAS4CsjKE/Cg8TV5ae/dRw8lg9U+5Xre2IbSgLY9VVbMQZSG1
 +ddT88WbGNWxGooSLmDmBwUILtjcLscQqk7ehmlGIopGVmJAO1XeG7bEXqX7I+IHNXvO
 CPaw==
X-Gm-Message-State: AOJu0Yx2wT3Ei4NPYPZHK3fthBpSB0vvRxVOSgT0i9K4Y9Wfpv75d4+F
 98VeLk8I/vGFEnEUFruxmiQZb8jIvMtrOnDtkaDwht59dqyHQnvus9vUrrrVqpS04VU=
X-Gm-Gg: Acq92OHJiAT83yJS+5ovrYzqoyrh9fjvmrd+YJHNkgESP3J5qedUkJEtgyeT4nsS3Um
 LobqXkrrbZKvnPGR3fAH7jm/1dl8uDnvOPTx0SQGubhcp7JHhHCFRsSlaeJ7nrimAB3yvmI4iH8
 mBzWsd+3VAIu7YLbhGBofLQ25rW8ne3Yc1vp4bOFlYXtPFVocRCXpaNzmt/XVO0BkYhNVKbvHx8
 ROGNgfLwCQorikjlOJ0yJ9adOHkiENo1w6KSB0CBd7HVEjndMlgdSL9vRP0oXlRIt5a5NM5UKPo
 on5gp03vVYdtiGEakvFixEev9hKQHuVvShARKeXnP66JjLdCTFflgCrbPTblosjRol5GYe72lmF
 OOoPk6wSqBth+FGlDLw7Ihlx6h7EeFbVCm0tbXbf7etreKk0olj5nbGydAv86lARsHdO9FGlSUV
 g6g/kzpwoottcUKWaZkka3LWaywpk25+Ol6A==
X-Received: by 2002:a05:6000:18a4:b0:43e:531f:720c with SMTP id
 ffacd0b85a97d-45ac2a0cb0amr319880f8f.11.1778516281008; 
 Mon, 11 May 2026 09:18:01 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548e6a5b65sm27513216f8f.8.2026.05.11.09.18.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 09:18:00 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6CE815F7C1;
 Mon, 11 May 2026 17:17:59 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH v2] gitlab: update issue template for binary test cases
Date: Mon, 11 May 2026 17:17:57 +0100
Message-ID: <20260511161757.105994-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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

Binary test cases are sketchy because they can be vectors for phishing
and other malware. Lets strongly hint that source bases tests are
preferred and binaries should have their provenance declared.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - typos
---
 .gitlab/issue_templates/bug.md | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.gitlab/issue_templates/bug.md b/.gitlab/issue_templates/bug.md
index 53a79f58284..e20f586008d 100644
--- a/.gitlab/issue_templates/bug.md
+++ b/.gitlab/issue_templates/bug.md
@@ -55,6 +55,10 @@ https://www.qemu.org/contribute/security-process/
 <!--
 Attach logs, stack traces, screenshots, etc. Compress the files if necessary.
 If using libvirt, libvirt logs and XML domain information may be relevant.
+
+If attaching binary test cases you should describe where they were obtained
+from, preferably linking to the original source. We greatly prefer test cases in
+the form of source code that can be audited before compiling by the engineer.
 -->
 
 <!--
-- 
2.47.3



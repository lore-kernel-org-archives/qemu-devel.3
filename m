Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACCB2CD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 20:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXPls-0005ob-DN; Wed, 10 Jun 2026 16:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wXPlr-0005nC-Hd
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 16:43:31 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wXPlq-0003qP-3V
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 16:43:31 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-490b8a97b11so80459245e9.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 13:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781124208; x=1781729008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ngYhxDvb+8oUas7oVCWnHd5LEJw2/QGnt9A2biWJF3g=;
 b=BCgUIZPsAhup6MJ9PfEoafB0EsgBwMSEHwAEjdpmjAn6IXc/0C1/XkkdFLH0GH3O/t
 Ww2m1tdywSvM9WexFZJbo8evald/md7ainjdCfwdQKmb800HcQPdruDisIZLFt2gOF/G
 5/ZrdKthfClWiHb46THWJemMrzR0oGdx8P4mzYKa4jsIEbDKIDvFlt48BtgByuTomV76
 vGUAQ470yIPW5fSpU8BgKW6cwxhu0vPbXuo/42g7rJoo8BEFViygV54K3nxSIqNABr2/
 iiTjLjBXoTNUhuhpcynQwwWBGVCNQZfVEv6xZPh7QINTWLtBlfrUT3+btsK5qmxkl+If
 Mifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781124208; x=1781729008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ngYhxDvb+8oUas7oVCWnHd5LEJw2/QGnt9A2biWJF3g=;
 b=pOEKmlzoSfk/8B+RtNPIVgUKjnjae5SngTAyBNeMCdnvzqcQGQktvQTMirblwoudI9
 c2YmmkGgBlzh/rAN0zJjkEcbVTqXnPjAk8qiNS+TxfrEWfJDcqS3TK30fhb989YsORl9
 KxOXsaAvikcHFNhVYfOmry3eOz3xBiujTF9JmDf415kYi+xPs0kMkVXBs/JrV8/sD7tk
 eOFFRJBAZEy59IOnq0OglXQ40Owf2/YKlLO2SvJSY521QD8dII/+HcK7YE5pQfUUDrlQ
 CybXo2Hg7ASntLieI1fQcAgs5TlOL4hkb57V7UKcJFBPWFUYzL70sHBD9hff8578Cr0+
 EfVQ==
X-Gm-Message-State: AOJu0YwflcS74Aye2ilzJ9ZUuDtlKFVPxMzwpYleiRtu3AowJrNHUTqm
 qHAxXNZzoLSJGHN3PuU5e+Qcv5ntYkJj39oQVgKKxPJ8JcFmnPFQ9Yz+Jm9fQoFpO04=
X-Gm-Gg: Acq92OGhWbsVmBJ5llMJQ7mYitjcknuTzVcIQjEfWCZnw8lzeWnqSxtODHfCSJkCnaJ
 ibT3Xv+Z1nQaSsUkznG+1mQVflSTSxZGwYYOoTw0TaG3pKXgvpYgOKz23pRjepXnkN+Bl9y4GsD
 hLMiUz9IBicaJ1faqhRQjeUVngaBAgaRnCVbe9PwInCMaYT/GJy8T+teMUToYEJ3WX64E6y+uDt
 lAbSusuP7YOwHe75ngOeMSaX6YDSb3ctrQD3YrC2H5HxLcZRc/dEF0kda0HbCQ/8wETlmoeh4gS
 MXCwyye9EP527dhAE5O62qHhTHNjf4ItDovtBAHlT5dF44wVmFk8L3qOTw5j1jy963FhO5KVEw7
 Wj6gOa3e/a4D20EjSl2eAt1Qt7s/PNpWtLRqpMmOzgwll5KiSokdgxe7goPwVCDz06obxssdCwn
 72A4qmypDmWyZbT5X1wZAtXfqel5NondJdew==
X-Received: by 2002:a05:600c:6995:b0:490:b473:8f78 with SMTP id
 5b1f17b1804b1-490c25dd66emr421828215e9.17.1781124208335; 
 Wed, 10 Jun 2026 13:43:28 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e2ca1a43sm10639925e9.8.2026.06.10.13.43.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 13:43:27 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 88F015FC9A;
 Wed, 10 Jun 2026 21:43:23 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 6/6] docs/system: add FEAT_ECV_POFF to the emulation list
Date: Wed, 10 Jun 2026 21:43:22 +0100
Message-ID: <20260610204322.828645-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260610204322.828645-1-alex.bennee@linaro.org>
References: <20260610204322.828645-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

We already had this implemented since 2808d3b38a5 (target/arm:
Implement FEAT_ECV CNTPOFF_EL2 handling) but it has its own feature
name now. Add it to the list.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 18c63559679..3622e3889c7 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -60,6 +60,7 @@ the following architecture extensions:
 - FEAT_E2H0 (Programming of HCR_EL2.E2H)
 - FEAT_EBF16 (AArch64 Extended BFloat16 instructions)
 - FEAT_ECV (Enhanced Counter Virtualization)
+- FEAT_ECV_POFF (Enhanced Counter Virtualization Physical Offset)
 - FEAT_EL0 (Support for execution at EL0)
 - FEAT_EL1 (Support for execution at EL1)
 - FEAT_EL2 (Support for execution at EL2)
-- 
2.47.3



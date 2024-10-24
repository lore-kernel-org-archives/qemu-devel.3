Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC92CF537D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 09:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3ua2-0001DO-7h; Thu, 24 Oct 2024 05:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3uZl-000193-Ly
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 05:56:18 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3uZk-0003ok-5R
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 05:56:17 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c96936065dso743619a12.3
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 02:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729763774; x=1730368574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=71XaNHfUGhL3lLQ52efa8tYMyfFJrkhKl2IJh8FAjpc=;
 b=D0GFp8oOG8h01qoSTimBU4G8oXqDBKvf1KOU3guNO4AlNV5XMqiGs7ZFpmO8WrO00g
 wtIOGDMHgAvfzveFvRd+B6phzs4Bv9XqyZJ+6ebKmS2EB1hqmiJHhI4Mff71nNu2xP0+
 Mj/c79WaztfLx8wCND5EeFce+yKhH0w2xUB4jmv4JaF6xrSm9SvlI3iImKP0CwSXpp8b
 ovs8fsNm53lQ5pBg+shPt96m+gaqzPDgxXlFkYc36Dm9rkG4zbIdC+NPKUOrGWtMIqQs
 ABvkWzQ6Y/Rx20O4IjhC1ptFI8ttupK09MJA/P0/czTFUbFE4jJ0O83Ckj40SNxyxE7H
 FQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729763774; x=1730368574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=71XaNHfUGhL3lLQ52efa8tYMyfFJrkhKl2IJh8FAjpc=;
 b=LSS3hYVepsesocFlumQPSoKThtXtqD1XvGCWgyCu/8LZcIt9MEy5smXRY5nmnjiH5r
 Wz7JAYXInJh7rczmAtmGYCFBsidx6uD/0bYm6MdbK33roeNVLYQjn1wLunLPjC4MPaLI
 uj147N3xZuMCF6Kl+XZ7pBKutshfgru0waa7v4kp/fEtGQSxUFsfYqZV/RjngWBbChQX
 /9VjQEXn2gUMgAxrxUCYd1OB6YN7z8KP9CVoxLTGsB29ct4c33kY7ZCLb3HUJBsd40Sm
 Yej7BRv7ihq5IqWzWtJuqlbGtlzSkeR7G2SmjCC+lmuaSX2a1TYrDOZRdzaYmq9CyOg4
 Irtw==
X-Gm-Message-State: AOJu0YwVXCpWHP5VtWBHJknAUHDg6bnC7d+Dbt/DLEjZNswQ2HvKZhti
 DgYY+BPoUG3jRDEo9qE34Wn40XgZOi/9/PpkWPXXzp/8Kkz90/8wJ0uDLUeO8DNChW3+ZPPhBnz
 D
X-Google-Smtp-Source: AGHT+IE/wBZQD87Dey/aX/z0U9zV0xenAh70yHxCbHrpfIqTMaF32FGJLkaPo6a5EdiJIUm4xcQ60A==
X-Received: by 2002:a05:6402:84a:b0:5c9:3ff:2734 with SMTP id
 4fb4d7f45d1cf-5cb8ac86aa0mr3955509a12.12.1729763774311; 
 Thu, 24 Oct 2024 02:56:14 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cb66a6a45dsm5735432a12.42.2024.10.24.02.56.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 02:56:12 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3E07B5FBDC;
 Thu, 24 Oct 2024 10:56:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PULL 14/17] tests/tcg/aarch64: Use raw strings for regexes in
 test-mte.py
Date: Thu, 24 Oct 2024 10:56:00 +0100
Message-Id: <20241024095603.1813285-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241024095603.1813285-1-alex.bennee@linaro.org>
References: <20241024095603.1813285-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Use Python's raw string notation instead of string literals for regex so
it's not necessary to double backslashes when regex special forms are
used. Raw notation is preferred for regex and easier to read.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20241015140806.385449-1-gustavo.romero@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241023113406.1284676-15-alex.bennee@linaro.org>

diff --git a/tests/tcg/aarch64/gdbstub/test-mte.py b/tests/tcg/aarch64/gdbstub/test-mte.py
index a4cae6caa0..9ad98e7a54 100644
--- a/tests/tcg/aarch64/gdbstub/test-mte.py
+++ b/tests/tcg/aarch64/gdbstub/test-mte.py
@@ -23,8 +23,8 @@
 from test_gdbstub import arg_parser, main, report
 
 
-PATTERN_0 = "Memory tags for address 0x[0-9a-f]+ match \\(0x[0-9a-f]+\\)."
-PATTERN_1 = ".*(0x[0-9a-f]+)"
+PATTERN_0 = r"Memory tags for address 0x[0-9a-f]+ match \(0x[0-9a-f]+\)."
+PATTERN_1 = r".*(0x[0-9a-f]+)"
 
 
 def run_test():
-- 
2.39.5



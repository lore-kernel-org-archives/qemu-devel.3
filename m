Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7724CC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 16:07:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOJZH-0000mS-0z; Mon, 01 Jul 2024 12:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZ2-0000e9-Q9
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:37 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZ0-0005Pk-4M
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:36 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42565cdf99cso28820345e9.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 09:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719850053; x=1720454853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9i1t7NGFbpDxWQ4N6M+2vJDuEoC6XNQqU7Rbq4fgGT0=;
 b=Yxk3v8LXp9vWM9eFBAgOwkHgkwOzvqu6hSuqmFf9ykAcsftNdT4+YVDZKx1vWJKS9O
 d76QIAmZkVPKgy8kgWW74JN4OHrRXoveGbbvR0vB4hwFnuP+8dwDicV8gELmI5paX7Ls
 Pv83TzQWAx4+X6Zz4PM7kPkS3oOp99IEH3CTfZTZeBBj9jq144gBNBKiPmpmtTWw23wf
 NGXInL2jpfuVm0/qT0wtk/2AGzkcXN9ISgqt0CdnIZrX1HYEUtXdWqpi1PPzaA5MkroF
 Q4cnND8leNeeC6P807mhqNWAaxFJNJ73YdJzXZlR9D2xBzeH5iQ0RnAjRpuCPD9ZebCC
 A/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719850053; x=1720454853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9i1t7NGFbpDxWQ4N6M+2vJDuEoC6XNQqU7Rbq4fgGT0=;
 b=B/qfooQ7x3dQOD1gy9/puCkC+nmPuYFdkdSEwNmkWSqo9DVkjffig36YgM+RN4bGv3
 z0HUoGL7t0xhElEBdSIuAWVS6eVCOvVOTAxBv2gXLBdP+SNFJDdYsTm8myWVQAvsuFF+
 OH5WXyu1+HMViESXQ6Cm3FQQsSQtOvfd2F/YkrGKI34iChNMHVua1fQXEOIoa6fMkh4w
 l6VYpdRQ9GWiQvfSuEYGkw2Fnk2nefqhj6VRI3y+Q6mWGNnRZkyXb8Yd7Bqb8b0XU9xl
 CFBH49EPjkRQm5AFoJPoE2LnHlR4LIJORCEN1LWm6vfSxKUW/wsDL0qnirCcYHzH2RbW
 VnYQ==
X-Gm-Message-State: AOJu0Yx9i+OHoA8n9MPSjBhpZJqvCENvGnzcCYCHwKF+h8TImj+KwKFF
 LOfjbmyQKyt9fsaGN/FTHakctxU6VaUSe+u7XqB4v5avm8hJOGPXqzglHTdJboFaPuM5tDyY+3O
 8Eao=
X-Google-Smtp-Source: AGHT+IHdPkpjWFdDlg5BEwLZvOWHGRldvIf6ZxdgQzN9jJqNE5h9pWnUlKoJFAVyLvq+9pyOIuNEOQ==
X-Received: by 2002:a05:600c:6d4:b0:425:5fd9:370f with SMTP id
 5b1f17b1804b1-4257a006636mr51411945e9.9.1719850052625; 
 Mon, 01 Jul 2024 09:07:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af557fesm161952135e9.11.2024.07.01.09.07.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 09:07:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/29] tests/avocado: use default amount of cores on sbsa-ref
Date: Mon,  1 Jul 2024 17:07:05 +0100
Message-Id: <20240701160729.1910763-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701160729.1910763-1-peter.maydell@linaro.org>
References: <20240701160729.1910763-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

The version of the sbsa-ref EDK2 firmware we used to use in this test
had a bug where it might make an unaligned access to the framebuffer,
which causes a guest crash on newer versions of QEMU where we enforce
the architectural requirement that unaligned accesses to Device memory
should take an exception.

We happened to not notice this because our test was booting with "-smp
1" and through luck this didn't write the boot logo to the framebuffer
at an unaligned address; but trying to boot the same firmware with two
CPUs would result in a guest crash. Now we have updated the firmware
we're using for the test, we can make the test use all the cores on the
board, so we are testing the SMP boot path.

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240620-b4-new-firmware-v3-2-29a3a2f1be1e@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/avocado/machine_aarch64_sbsaref.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/avocado/machine_aarch64_sbsaref.py
index e854ec6a1af..e920bbf08c1 100644
--- a/tests/avocado/machine_aarch64_sbsaref.py
+++ b/tests/avocado/machine_aarch64_sbsaref.py
@@ -75,8 +75,6 @@ def fetch_firmware(self):
             f"if=pflash,file={fs0_path},format=raw",
             "-drive",
             f"if=pflash,file={fs1_path},format=raw",
-            "-smp",
-            "1",
             "-machine",
             "sbsa-ref",
         )
-- 
2.34.1



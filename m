Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D8A6C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 12:30:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0gAZ-0007Z9-Bk; Fri, 04 Apr 2025 08:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u0gAX-0007YY-DV
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 08:29:09 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u0gAV-0007p6-Ca
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 08:29:09 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22423adf751so19623375ad.2
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 05:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1743769745; x=1744374545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kEOFIV1qt1V2bKvkYxtGDBDLbtt18qBSOEpiQi49TN0=;
 b=ouHjispTVj/QggDz+JIF9hkCa8k3V4KUEJhS1OuLwUBUQW+XVdTrlkqH71jp6x3Qyo
 VPE1Na407iqP9lFFt9SceaN3HkGB6YKF8ETx49otu5ReNt7PWWEGStzGXFPW88J+xd6L
 UdLrHDtNusg/z4QlnzygxtJkPjKnjy746FIu4X5Vtlqjjl6gaX9kGGb4NDMDQtvgb1tI
 hqLkhsqnBLZUF3rGhUklX13+R6Et9z7rULnmwzEfn8s/jwkHnkCCt/wD1bQ7Qs4/9WyB
 Ycgv3GPhihnHT5x+00t+kswUr9kMN244df7upJkH41CSPpmYiey5cNV6I3Q+yCfS9e/s
 CCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743769745; x=1744374545;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kEOFIV1qt1V2bKvkYxtGDBDLbtt18qBSOEpiQi49TN0=;
 b=vDdvRt0g7XNhTBFAhyQRy0SIa43vWOjLCnK5IHx9Hq/2y0sjnqhzj0tUyRHUYICSZ8
 c7+k5YZ/GUm8fAMLWXypYiZ4ayjnj0MgcQgwAg8jGNv9fVXMMEjNofZhbSWT6CoCif73
 MTX16ooGTGSqojpoLOkfyYiuWtavZ/HAkhaCIrHlY4k0jk0SlqXiCR6oaPqzwQ0a3r4k
 +px4N7V6WCxRYi8P6VdfAquneGnDMp4+7H30Iw8I22hsi7SVcwDtgrzp++8a3JhBziun
 htnzXRvLiWITgYMY9upaoii5L5/IkwCk/cgRDhmq79MTq0EqwDJcn7ph0+kOb5bdstpC
 Aizw==
X-Gm-Message-State: AOJu0Yyr8vKzwitnKcFvTLElTlFdGqordrzxFj7Dh1y/i6xWIXIHDMLQ
 F2cDCGsOZva5/m2yVPAacGXm50wemhNVLeaPG8AqOYRVq9T2IzTGw6wzHsc72QOkbZBqsE4RFWU
 H
X-Gm-Gg: ASbGncuEcXJuBdnFpK8CzIqwk3nIxOMcGtrwq0HyjYBTxDkkG4Zf+VXd0K6aPhxATHH
 9fJDfR9Gzjny7f4hGGZZXdHDUqHcOZ1IpJkIsPi5/YYmpOnbGD5lr2g8oiwhIMJJ/fmyzy0yMFi
 7aHGcNvaCWQbaULUMFJ7TRWyF6nNIYMTQptpYlcJP1NFvYHa+SEfoEqugKBO3Lkn5afDDpNVKcF
 M+HQFIPrEiXUvBM8mjf2RMRbhelEH1TqM7zmHg/jx6oVKdNh2hRGYaTC78H8qQG9XMOeMiKU/MW
 UlFU1f510XCqKcnfwtRMJFthnPNg55yCZx0fBNtyGH/wli2ABvjkj0yZXXXAiwisscdtY8Jglg=
 =
X-Google-Smtp-Source: AGHT+IGOXam7jhWMQiL1PtP9JtkbsuRFA2AEdyVL49jx4sE7XOyZmeiRQLaQWWyva8zsN10K6ZzQWQ==
X-Received: by 2002:a17:902:d48a:b0:220:f7bb:842 with SMTP id
 d9443c01a7336-22a8a0b3707mr31781065ad.42.1743769744688; 
 Fri, 04 Apr 2025 05:29:04 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.170.227.223])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739da0b4851sm3306137b3a.146.2025.04.04.05.29.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Apr 2025 05:29:04 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH for-10.0] docs: deprecate RISC-V default machine option
Date: Fri,  4 Apr 2025 09:28:58 -0300
Message-ID: <20250404122858.241598-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62d.google.com
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

Commit 5b4beba124 ("RISC-V Spike Machines") added the Spike machine and
made it default for qemu-system-riscv32/64. It was the first RISC-V
machine added in QEMU so setting it as default was sensible.

Today we have 7 riscv64 and 6 riscv32 machines and having 'spike' as
default machine is not intuitive. For example, [1] is a bug that was
opened with the 'virt' board in mind, but given that the user didn't
pass a '-machine' option, the user was using 'spike' without knowing.

Being explicit in the command line is desirable when we have a handful
of boards available, so deprecate the default machine setting from
RISC-V.

[1] https://gitlab.com/qemu-project/qemu/-/issues/2467

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 docs/about/deprecated.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 76291fdfd6..0f41a99c67 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -304,6 +304,23 @@ online to check that this board did not completely bitrot yet). It is
 recommended to use another MIPS machine for future MIPS code development
 instead.
 
+RISC-V default machine option (since 10.0)
+''''''''''''''''''''''''''''''''''''''''''
+
+RISC-V defines ``spike`` as the default machine if no machine option is
+given in the command line.  This happens because ``spike`` is the first
+RISC-V machine implemented in QEMU and setting it as default was
+convenient at that time.  Now we have 7 riscv64 and 6 riscv32 machines
+and having ``spike`` as a default is no longer justified.  This default
+will also promote situations where users think they're running ``virt``
+(the most used RISC-V machine type in 10.0) when in fact they're
+running ``spike``.
+
+Removing the default machine option forces users to always set the machine
+they want to use and avoids confusion.  Existing users of the ``spike``
+machine must ensure that they're setting the ``spike`` machine in the
+command line (``-M spike``).
+
 
 Backend options
 ---------------
-- 
2.49.0



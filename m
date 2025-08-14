Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF78CA0EE3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 07:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umS3H-0007ki-9L; Thu, 14 Aug 2025 03:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1umS3C-0007jd-ML
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 03:07:03 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1umS38-0003ze-1j
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 03:07:01 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-45a1b065d58so3776995e9.1
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 00:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755155212; x=1755760012; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e59BaxHwubmbKhg2MtSdXVTimX1acxMLoXeo1of+jh4=;
 b=NJUrcH22M0Kp4fQ32jNVNKKzQznQC8byjaiF35GpFyejTcaNEpxe8BnGgeeJrGmjRa
 oYZE4qIhzSXuPHljfuC4sDAEJRBvOIyhdspu9BNsu0XgGCxsI1aICwLx6gkGNIiUaIRc
 3Cg2kcTW8m0TaDECWUKvJO8skk2ENnKb5SNJPD/MTNRn2Ultnd6TOAkDzJOe5gtPxAOZ
 j884Psj31qWZV7LvscVDhsjmrRgY8GdKLfTYM8YNZ6elpZNISaVMkDbNlZVRBw6V1kJz
 8PfUz5ZALGvNAuMbAX5l41kQX7pINLEdzlFDEfRfdJl6Et70Hmjtl+bcnqIu0wi6PLu3
 C1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755155212; x=1755760012;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e59BaxHwubmbKhg2MtSdXVTimX1acxMLoXeo1of+jh4=;
 b=QVKfQ/q7zCAOfdBtLrHJhQDqRC7vyHi2vm06DTStCR/akfnuW6cG1gILoF8lI2S3lT
 qPycowJOAPdqtkdibH3kN3sjKKL5vIyAIArIoa618az+/p44OiPLBr1Jx7elaJTVw1Nf
 3MGRg3gbXiuPBktjvxM0fMyIIVMYyVEU+gWJ2XCx7JCKIdnK/wuOuCECDrkCQpTimdGN
 IWPSXPZJU59dRrUdQQFx/TGKl6ML4tKOsW5HR+eYYiYEzajEO1l6OKNHZDvMoN635/UO
 JimQYOhYKGdKeAbGUCJHrt6FrokTd0o1iGIfD2DeIXfM77QDQM7hTnJd1FmVvX+AdzgW
 Zp0A==
X-Gm-Message-State: AOJu0Yy3PcL4g/u8ix+/udT/q3DBdAqMFzgFG607t3sBknVfSTQSjngN
 yChz7f1XMDo7iL8Qvg/6JpysWpxbGqWkhB65xU+gUw5PvigevZPaB1OI4+dwZ09gz9nKRFxzq2Q
 roUA6
X-Gm-Gg: ASbGncv9QGzl9z9k+f2GsuIEfb+hK4XsBZkWEJWxDYiAkl2CxHCge7P8Pm+jNdoC5Un
 tsQDfCVIpGaGutONMg4mpughdCm1t7W3bVB89PZgTBtFqKpxRNoBGWZTXsy9yqDTFO895+Itr+x
 lF3pclhtw+TYbQCY+8iQFyqa/jz8itxNXPI1VavZFHQUPTKQd8RF0/kfaH06pR3BOpiIwyhGtnb
 zevMiRo2lDaOzIYGZckLyLVULiU9J5JaaBqYKiyFIK7PGlvBsascGkRC0wXcX+XwpQMUQZYpARR
 JM7xvFTA4hFS9OIVvBKfb94rxPiQz7JleuUH2/VOt1iK5nalMv3MDUwW2CdaqD7YaB/PRVffuie
 PmUg8rNZEX+M0PIiOiFGQe4Xz49mYAAa0zyVsFa0VUL1gOPRRJUctpXu7PtxrcE8hYfn2iu2URe
 QKsg==
X-Google-Smtp-Source: AGHT+IH/mFU61Di3WC8xQgH6rPurg1C5x9q8btrdDcNw7Tjkt/guFWZ5989SF8ZwxaQhBYlqtcepKg==
X-Received: by 2002:a05:600c:3b11:b0:459:10de:551e with SMTP id
 5b1f17b1804b1-45a1b6556b9mr12212945e9.27.1755155212031; 
 Thu, 14 Aug 2025 00:06:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1c78b33csm9885825e9.25.2025.08.14.00.06.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Aug 2025 00:06:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH-for-10.1? 0/3] linux-user: Select default CPUs for MicroMIPS
 and MIPS16e ASEs
Date: Thu, 14 Aug 2025 09:06:47 +0200
Message-ID: <20250814070650.78657-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

We weren't parsing MIPS ASE in the ELF header, so couldn't
automatically pick an appropriate CPU.

Since we'll have a rc4, I propose these sensible patches
for 10.1, but both ASEs are available since 15 years in QEMU,
so this isn't something broken since the latest release, and
I don't mind holding it for 10.2.

Regards,

Phil.

Philippe Mathieu-Daudé (3):
  elf: Add EF_MIPS_ARCH_ASE definitions
  linux-user/mips: Select 74Kf CPU to run MIPS16e binaries
  linux-user/mips: Select M14Kc CPU to run microMIPS binaries

 include/elf.h                | 7 +++++++
 linux-user/mips/target_elf.h | 6 ++++++
 2 files changed, 13 insertions(+)

-- 
2.49.0



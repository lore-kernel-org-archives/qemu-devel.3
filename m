Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 053C0C52D7C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 08:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbc8d-00075S-9L; Wed, 07 Aug 2024 04:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbc8b-00073O-D0
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 04:35:17 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbc8Z-0000kq-Ig
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 04:35:17 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4280b3a7efaso9965765e9.0
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 01:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723019713; x=1723624513; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=x2VGju5Eu0OJpSsrhobgPWGCNyayfyDXDVJziFmSvGE=;
 b=aGzXPP7GLImf2NnjjbI4LumIg9uUBK8BWD6pWa7AnO0WaohoV4Tr4G5urJlltgNHXZ
 62UYztY4kHodyGZsJJyWggCbhbuvpiRtP+m6RRV2cq1WYkK/3kMLmImg7BYECOKLH8I8
 MnUBKP7PB3NJVM4uYxsp++57PTMtQC07zr1dja3NCmHYntkyJpeYWmnmPkWq8oKAgOtu
 iCKW5jbiAbVwanArEqWRf4Qb9pjOsPnHrVmYGq8SJB5FGFUhc/j5hzf4cs7dq7KUcUq+
 5qR4OJoxtWYd313uXdS9e5kAG6dKHtJ8V1crUSU37Ss6E2V4fRFC/cyxCyOWoXSPJJ+I
 DlWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723019713; x=1723624513;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x2VGju5Eu0OJpSsrhobgPWGCNyayfyDXDVJziFmSvGE=;
 b=TUSQWR28ipf9zT81cMz4is+EY+ZPmDHJAHeiHWD8oaMs0Spo7gEYKEkYkAZPKZXB9/
 LefzBP6VsUHT8TvsOxZUKr5XNjTT1/f2BPSbMH5X0Ty1kHPvwjhypw7eqTdrGQUgHZyS
 d6+lJpWX9mxNI/k2LxBx9sJRtkkoKIg/fXE3Biy+wCnZXLOpiiH+rlWZTWfHuQPwmJMI
 raWSHLzX1/txNZH49DNTUPyax/PPmW9YBANqjFKLiqAqzlJ8GPd4hq7JptqWbh4YUlHy
 wINBiykOI/izGIWx0wViqD9F17edHpRq0uOmNVBNCM/4GTEjodGTuPRXRpN44I/5k5M+
 bicg==
X-Gm-Message-State: AOJu0YydZ8cgdHkgrSWJyCoKpiimf39af880baAMgj16vqJqxMDV92GJ
 ZsI2U/3oE2WhG2oIctCCaSSDAr8FQBxo0HbGm9Ue/hkHoj88daLQZARKeX34RuQ6MAGQ0/xiIMa
 o
X-Google-Smtp-Source: AGHT+IHf9LDWo0G3KplzJ6dKgV7aw1xBoBLFq48SzLDhTwipecC/YbnVoxashB4y07N0rs2EKyyP7g==
X-Received: by 2002:a05:600c:4746:b0:428:1799:35e3 with SMTP id
 5b1f17b1804b1-428e6b2c884mr113000675e9.21.1723019712630; 
 Wed, 07 Aug 2024 01:35:12 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.120])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429059621d1sm17388815e9.10.2024.08.07.01.35.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Aug 2024 01:35:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Zach van Rijn <me@zv.io>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/3] linux-user: Trace sendto/recvfrom
Date: Wed,  7 Aug 2024 10:35:05 +0200
Message-ID: <20240807083508.28134-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Strace format added while debugging
https://gitlab.com/qemu-project/qemu/-/issues/2485

Philippe Mathieu-Daudé (3):
  linux-user: Display sockaddr buffer as pointer
  linux-user: Add strace for sendto()
  linux-user: Add strace for recvfrom()

 linux-user/strace.c    | 38 ++++++++++++++++++++++++++++++++++++--
 linux-user/strace.list |  4 ++--
 2 files changed, 38 insertions(+), 4 deletions(-)

-- 
2.45.2



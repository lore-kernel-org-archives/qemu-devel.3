Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78814C5321D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 09:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh4T3-00071F-6k; Thu, 22 Aug 2024 05:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sh4T0-000701-AR
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 05:50:54 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sh4Sx-0001rm-Qv
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 05:50:53 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-428243f928cso4133885e9.3
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 02:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724320249; x=1724925049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xgNZ3qu8BfekzFKdpP04agkBzefBMguhYRPSsrfbJm0=;
 b=hnPfbYl+ZkhHTOVvrQE5tPC9t8cUSwmT8VSqbboyeERuuVuhk1/AIDTxQUDs1CXO+w
 yaEl8OGXBW3FSq43i0ttXbWoqrRaVk4QrRTom5vZ8x7eNsNhZjReFOpaXzMgYLUYENb8
 pQxDmvu25E/hEX4peCbxvIzFpsV+T/AWDnuS7lx6jPhaUcG11lRWIQRwRSbSjAPh8pZ1
 OdvykpdBwenjU2fCfQt6JjjsfifuIxOBEPsMmC3J/ZkimfJi9dxUmhKKIgH1GDFudO5q
 oELNy/nB2lU3orEt7BV1jBZuqoB5401SGDUYZ/sz+k2VFe41KdTS8LZlKEGHB+y67fsE
 xMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724320249; x=1724925049;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xgNZ3qu8BfekzFKdpP04agkBzefBMguhYRPSsrfbJm0=;
 b=hpeRWoZ7gQd5PJjKSNJY4ioYUkw5iVcW4A46Sc9zCrRne9BBl5wqr/Lq/4UvuLzQMu
 JYMhiAGBUxe9y2FnUkr3TWDs7mHtmChThS3fCwEUuGllRooM663ohut+2bNhFw6t805j
 bq5VV1wWnR73Lb08qM4bw6G7+rzUJgw8irxkg7lH2jUl708VVGSAWPT1H1zgIaQr6Oa+
 UG+LNWJUGIiZkt4jEXIXNPGU2xtmegwtyDtg8r5STuBrrUNcqH5k2d5XYvJHziQnXI+Q
 xbenndVM1y1eohKqvv7ovLFgTt6AAURUoQpyQv2y622/EeZU1ZyDFBJjG3Fmbq4c2+kN
 02PA==
X-Gm-Message-State: AOJu0YxB+dJ/8nOopYQnB06BWaUCaws0QeDNsCYK2vdVan92s7bad9w4
 WN1ctBAMyJzy3OaxvH4fuhfbTNVB/yE/LXg/SIanJVWVh4jSyP1V6Hm0Keh3fhElpEXpXxzqDfk
 U
X-Google-Smtp-Source: AGHT+IHdhHKWcY2dTLERPnr4HMez5ff3z1qPbkI84rr6hSUyoMN099CSUbCSMzHNJNT7Pn2im3Qwzw==
X-Received: by 2002:a05:600c:314d:b0:426:6945:75b8 with SMTP id
 5b1f17b1804b1-42abf0a917cmr34150815e9.31.1724320248734; 
 Thu, 22 Aug 2024 02:50:48 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.153])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ac515914bsm18361595e9.12.2024.08.22.02.50.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Aug 2024 02:50:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH v2 0/4] linux-user/flatload: Take mmap_lock in
 load_flt_binary()
Date: Thu, 22 Aug 2024 11:50:41 +0200
Message-ID: <20240822095045.72643-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Fix for https://gitlab.com/qemu-project/qemu/-/issues/2525

Supersedes: <20240821153836.67987-1-philmd@linaro.org>

Philippe Mathieu-Daudé (4):
  accel/tcg: Make page_set_flags() documentation public
  linux-user/flatload: Take mmap_lock in load_flt_binary()
  tests/avocado: Allow running user-mode tests
  tests/avocado: Run STM32 bFLT busybox binary in current directory

 include/exec/cpu-all.h                 | 13 +++++++++++++
 accel/tcg/user-exec.c                  |  5 -----
 linux-user/flatload.c                  |  3 +++
 tests/avocado/avocado_qemu/__init__.py |  2 +-
 tests/avocado/load_bflt.py             |  2 +-
 5 files changed, 18 insertions(+), 7 deletions(-)

-- 
2.45.2



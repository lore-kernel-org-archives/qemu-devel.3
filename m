Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD93E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 19:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tShZW-0004H9-IV; Tue, 31 Dec 2024 14:06:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tShZU-0004Gy-PW
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 14:06:28 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tShZS-0007sA-Uo
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 14:06:28 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38634c35129so7807327f8f.3
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2024 11:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735671983; x=1736276783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=62j49jGyn7Mnek1kENskjDxd1b9k/L3QaHaFnCdk9vk=;
 b=ZyR7cBN9Jpv7PpsTdds26pHSV8JAqALWsxpvOr1nq4xLsFSbn8cRx1f5/Mufq+rswJ
 n8mSsB/OKdy1jxgZKPlcoaBAH30cFbCaUds2r8dfrzD0qCbB3G51glqutp98bRo8t66r
 gFvvwPle1ZfQ5p4V7yFltN/2GWHWHu6kQN4w7LTOb82h83X/N2pGqXn61pog8eYKC/9Q
 U6xrY4r179+ErIKSvbE35a3V4YdD4Ik4iTyjSAIutp2+YekdCVtX+klRq8ZRtboUq0os
 GuUK0ynqdTBoq6G3zqk0DpHgNbpmOz3Uk5AilxIPoxV5R4vE4zQfZ0nioUyCY5qo1CZz
 kZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735671983; x=1736276783;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=62j49jGyn7Mnek1kENskjDxd1b9k/L3QaHaFnCdk9vk=;
 b=Sf7IHVNyfyooOTM534nflFng4DhC8yhdYQ6ozZhoDWYoRtwFCUOxbLU6cKwPmDxSiR
 NXP7ZJtDmw4F5fUPSLNYzm3ZY5MuKxlegjvkk3Dk6vlrC94T9n7nNh5+jHuAdXGG9cQw
 0i7sK6HhaMnzVgD3DtcRvA48tyPw3dU2j+YNgoD7Hp9Gcb/OosDXn2VW3dnIK6THl5xD
 y+PZJ8+5PJqJ4D4NdzmEdysMfZcTWGovUdNEIhCYBc9GIIqrN9E6WOpJ8AfR2NqKV4CR
 R37Yzx/QV3ftnnXMlXkBR/ZHmrm/LtAlZvHwfDs2cWuawBpsyLPEVYf0eFNi+fm69y3C
 n0AA==
X-Gm-Message-State: AOJu0YzPc7EVkq4aMu7Te6/sMBl5QwrXhpQFwiE6ySRV4V4JOQev2Wr0
 fHnFCGEBDrAg3E1FN6LOYHtDEweClDYnUt7x9NGn8OfWImL4qUuIjIiH06koAy9inTPybMn9Y8p
 VH1k=
X-Gm-Gg: ASbGnct90bZzFWOexcSkT2y2oQei6OXiFSjF4qpLLjPoLtUKsblxZyVl1ITqK0uQ8+E
 YKmRMqlY2+ibkBX3aaQZFsqo21fGaxhU7hKA/cXk8QT1pmPSwd//ePSu8Ci4jNiOTe5qno2K44/
 MWaat6nALcXPekrEDHtOrSRexF4nbxvc1+SBIHeHphyEeJSOlydZdH4DSnAbnCzsFP3pPfWCu8f
 H5KTM41laTwdMWqIG0eTz+0exzi7jRn7F4rgvngD/LsBIHhON6+gEDc8eIWWk+FLnH0oYAPZbWO
 z9MiOTcyNPNB+/sSKSl7supDoLzNyoc=
X-Google-Smtp-Source: AGHT+IHNNacgYby/orf6e1ioySK7rAD6CNC8xGRdN1PiI/FYg71kXAMMMA/TnOjQp5EU/JHf02Vlcg==
X-Received: by 2002:a5d:588b:0:b0:385:de8d:c0f5 with SMTP id
 ffacd0b85a97d-38a221eabecmr39024824f8f.16.1735671983266; 
 Tue, 31 Dec 2024 11:06:23 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436840b35b5sm249447525e9.39.2024.12.31.11.06.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 31 Dec 2024 11:06:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 0/6] hppa CPU reset and speedup
Date: Tue, 31 Dec 2024 20:06:14 +0100
Message-ID: <20241231190620.24442-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Respin of:
https://lore.kernel.org/qemu-devel/20241229234154.32250-1-deller@kernel.org/
"Add CPU reset function and speed up runtime and translation."

Since v3:
- Added tests, dropped R-b tags

Helge Deller (4):
  target/hppa: Convert hppa_cpu_init() to ResetHold handler
  hw/hppa: Reset vCPUs calling resettable_reset()
  target/hppa: Set PC on vCPU reset
  target/hppa: Speed up hppa_is_pa20()

Philippe Mathieu-Daudé (2):
  tests: Add functional tests for HPPA machines
  target/hppa: Only set PSW 'M' bit on reset

 MAINTAINERS                           |  1 +
 target/hppa/cpu.h                     | 11 +++++++--
 hw/hppa/machine.c                     |  6 ++---
 target/hppa/cpu.c                     | 22 ++++++++++++++++-
 tests/functional/meson.build          |  4 +++
 tests/functional/test_hppa_seabios.py | 35 +++++++++++++++++++++++++++
 6 files changed, 73 insertions(+), 6 deletions(-)
 create mode 100755 tests/functional/test_hppa_seabios.py

-- 
2.47.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B79C02198
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2025 16:39:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgnrT-0000zg-PF; Sat, 08 Feb 2025 11:39:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tgnrS-0000zO-3S
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 11:39:18 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tgnrQ-0008MY-KA
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 11:39:17 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4364a37a1d7so30232825e9.3
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2025 08:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739032754; x=1739637554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qaigCbdh9lLsPPD1nebNreJyZCsil1fOMv0TEy5XZiw=;
 b=XvrNqe3jiiy3p8oSO+EbqZJWzbUyK5/8lTOhF+W9L63SpSyhauv1490/1q3nPCSJnh
 xHjiwyHejZqWogBtsOBxIL8I8/PIlxj3vos+AJiivrVryVjo5PrZ8jsmFbLrNU+MMoVH
 gHjKEdBwQO6phIDKU3tTi14G/Sr9YjZZQFuPznOwcz+SvaeWX3M4zDz2KtYb4hdPYZmG
 pgtm90UGpr4A8IjEhrqiXp9Cp/rKcLnzAEiQg+Ai9CW5ly1g2TNl5gVoJVFkhYCE7yNt
 gzDtHDNT8J3BRg9O3lc5ppJ0VvmvBHaWgEl1oBDoPdXAWmF4Tu7KbqVMMq1pAOrpMTNv
 mRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739032754; x=1739637554;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qaigCbdh9lLsPPD1nebNreJyZCsil1fOMv0TEy5XZiw=;
 b=ZxdxAI+tqFzJqsbJ2+K9JGGvtNuJGnAz6BEUwRtMM/IH4Ti6mIu+oO4tKpDGgMSgT9
 3LOQxeo/wz+xOG69ztmPSWq+K20xLBgsRlKvOCWWK0pJeKJL5kqs1LvQ3AoduNPkUx2L
 GsFyv74c8le3KiJ0az0RtjywfU7tBNNl4bcWGRDLQWswhGzDp5aGmjr82zbbmlT+suIk
 6XgdspZ58B8cZEVWhtMdTIB66mKYiwrjfEzPDiD5nISK8KJsASakYegwciaCeu+ym3GV
 ILVDMGLuLr2w4RGQX/nHPQvHwMK3LAaXRi9ExoL2vsSFdu00LfnA5z6uxbcscBLaFeiM
 I38Q==
X-Gm-Message-State: AOJu0YwBKtdtjJmZItnI9An0ICt2ezfnHFTFvfa6uRJyX/R9WMFwBzOr
 Hy2noPCWiFloh4dsYI6yWZLaz7UKWFGPZ4IcQJgVeScw8Cqist80HgrbEjw5xilvdMn/yBNUqi2
 4BBA=
X-Gm-Gg: ASbGncvtKzQ9AzxfXHHKBvjcvMBxy8nELQwtl418VdbhRQ6czomY3zQWZBYa96Qj3DN
 j9C9lEbY4eAfkGxlho3CO1p5JgOnyuvjUQjKEo80dXd20MUa82QjhsKY+/ruDGASC94o/MdpYu0
 ol5ncmEZdHS3fgtDgmtLKWgpTV84GnSL/F8inlW/OXNC+G0zYO1hDFZ3gpWodZccmqlhXyODY8I
 GOPLCcPrBz8vrZZgb4L7vbWChvY+5lbX2qJ0ILKArVgCizXoOsgDvbQYQAqhtkRrtLHnOaMrnJC
 KmqkzAs9qDvfad6XoGGKb+l1NlFzYInVsPQ+XwFsOiT+3wFhRm2F/jn3dnKTjR+0Iw==
X-Google-Smtp-Source: AGHT+IHygbNeN/nzmn3uAxT66ZJ/KOZhj/7LBKvwVV9M/SHGpg95uFH5ZT36qRSQPZfOiTvu5G8SYw==
X-Received: by 2002:a05:600c:cc8:b0:434:a94f:f8a9 with SMTP id
 5b1f17b1804b1-439249c6dfamr55862665e9.28.1739032754064; 
 Sat, 08 Feb 2025 08:39:14 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd44c5e3dsm2007425f8f.62.2025.02.08.08.39.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Feb 2025 08:39:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 0/7] hw/char/pl011: Implement TX (async) FIFO to avoid
 blocking the main loop
Date: Sat,  8 Feb 2025 17:39:04 +0100
Message-ID: <20250208163911.54522-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Hi,

This series add support for (async) FIFO on the transmit path
of the PL011 UART.

Since v5:
- Rebased (few patches already merged)
- Do not forbid disabled UART/receiver (Peter)
- Use fifo8_peek API for wrapped buffer (Mark)

Since v4:
- Rebased (loopback)
- Addressed Richard & Juan migration comments
- Split in smaller patches

Since v3:
- Document migration bits (Alex, Richard)
- Just check FIFO is not empty in pl011_xmit_fifo_state_needed (rth)
- In pl011_xmit check TX enabled first, and ignore < 8-bit TX (rth)

Since v2:
- Added R-b tags
- Addressed Richard comments on migration

Since v1:
- Restrict pl011_ops[] impl access_size,
- Do not check transmitter is enabled (Peter),
- Addressed Alex's review comments,
- Simplified migration trying to care about backward compat,
  but still unsure...

Philippe Mathieu-Daudé (7):
  hw/char/pl011: Warn when using disabled receiver
  hw/char/pl011: Add transmit FIFO to PL011State
  hw/char/pl011: Introduce pl011_xmit() as GSource
  hw/char/pl011: Trace FIFO enablement
  hw/char/pl011: Consider TX FIFO overrun error
  hw/char/pl011: Drain TX FIFO when no backend connected
  hw/char/pl011: Implement TX FIFO

 include/hw/char/pl011.h |   2 +
 hw/char/pl011.c         | 140 +++++++++++++++++++++++++++++++++++++---
 hw/char/trace-events    |   9 +++
 3 files changed, 141 insertions(+), 10 deletions(-)

-- 
2.47.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ADAEC28B28
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 01:29:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trRwd-0003ve-42; Sun, 09 Mar 2025 21:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trRwW-0003vE-SN
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 21:28:33 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trRwV-0006PC-2q
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 21:28:32 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3913b539aabso713392f8f.2
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 18:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741570109; x=1742174909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZuKji3TX6tvR6tij8RWO++VDOISRmSy52iwsHPgl6P4=;
 b=uQZPGoMH/H93jcc7fZNQgfLwAieWXXY3FzYPNwu1S33/ljKV24SMbKUw17oPiRR0yw
 SaSgj4RjD2GXF8qUIn8ZpXBIu4DFsC3oivT+VJMel57VKD5YHKUqGmexnmQJLE0omhTX
 9+TBoLaD1AOCUhd9mxKVqcK9r37EobjIrpwmPYgCXA4VAdzlB8CxUEhM5IZlrNFqHD33
 CfZ9v2dr+izxXX0J2nRYLfj0V/dzcfMuDqJGAhRffACNi+8dA4UmVhWUtRrjsr0Wa8m6
 xyYkrEAi2rGTo4Lqvzzm69CIw5a7huq3J3wlnRcep1zQeDZZwHqs+UJqJVxsCmENPJ9L
 xGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741570109; x=1742174909;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZuKji3TX6tvR6tij8RWO++VDOISRmSy52iwsHPgl6P4=;
 b=r+wo6Z6w1cJ8h7KSZ/NyX5eRDVJpOScSX5yM6RcowNaXO06Sm2V9XY46NW3wW5P+uy
 clFVs+LAoC5DA8CtYD3yd69V3LbgPpwThjCP3d1OL2HDFPKriTj6QoibAdN32mQQupYe
 X3ITJm6O/fMkPxIKNp2I5UtiVm3GRPFNb9Wwf8yRTbt9u28Y6tPFBxZnwypaJA3NXy/z
 6R2Y/WYg0oHX797sg7ZwuHV3JUcycFxBBvo4fOCHnpPGkeARacTsmEA9FN6ISQDn8Gu0
 arJu02rGz0Aw8Y+0meLHCkvsthPsarYwObSs6Q1FsRwk3VmSVgjjDhCpPhuOdQj6vkr2
 tbUA==
X-Gm-Message-State: AOJu0YyGNghRUeHASqXv4GP7OxxWjo1efV6eri7fKs8yRGquExYzf0ot
 WohWMthQ8+XqjUkOghadve7nGzReg5oypWUXwpk/JYOvKuCo8fVJB4cEcX3ZXFADuFxVpt8Ghhx
 XiL8=
X-Gm-Gg: ASbGncvP7RrXrgsqlSP9MzGXktzl2ei/jjAKp7x3fXkEA+r9ptMfR2i57jVqaZJJHPn
 VYv9wDfnoHOchAt5gfQ6JO5Hre1aRih6+jpo6kjVq7IJdDtmcum2/5JSn/+n/rjGuaETDgZMQ4/
 0QdDMRSLQJ1urZSsz4ML1ZKy/J0jER6bEPAIZ3UhZ0qph8wI5gqZlcvFsGK6IWWijbEVRnOhgNZ
 JZOjzjDTs81oTY6GFeYoBpWsh1RYIk+d74dzuLnGbtXZ6NFLjpWKIrLogvKb6qUidjbMEemjVKZ
 FZ2aVxxitBhgtP1vI6Q+NQIwR71XJJJHL2ZeIaDVjDuj+jYopRL1taHoGoF+0kYRKPCaJBDmoBI
 KfvmXCARv9myKqZyhL4c=
X-Google-Smtp-Source: AGHT+IFtgpsGprqlaqk5f63nyyVzGzsREmLq/AX4qELWJT65J+3LyUsh5oPaAL9dZz2jHK1qh1lD/A==
X-Received: by 2002:a5d:5e10:0:b0:391:122c:8ab with SMTP id
 ffacd0b85a97d-39132d5f36emr5316062f8f.22.1741570109152; 
 Sun, 09 Mar 2025 18:28:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfb7934sm13527928f8f.12.2025.03.09.18.28.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 18:28:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v7 0/7] hw/char/pl011: Implement TX (async) FIFO to avoid
 blocking the main loop
Date: Mon, 10 Mar 2025 02:28:18 +0100
Message-ID: <20250310012825.79614-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Since v6:
- Incorporated Peter's fixes in corresponding patches

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
  hw/char/pl011: Add transmit FIFO to PL011State
  hw/char/pl011: Introduce pl011_xmit()
  hw/char/pl011: Factor pl011_xmit_cb() out as GSource
  hw/char/pl011: Trace FIFO enablement
  hw/char/pl011: Consider TX FIFO overrun error
  hw/char/pl011: Drain TX FIFO when no backend connected
  hw/char/pl011: Implement TX FIFO

 include/hw/char/pl011.h |   2 +
 hw/char/pl011.c         | 150 +++++++++++++++++++++++++++++++++++++---
 hw/char/trace-events    |   8 +++
 3 files changed, 150 insertions(+), 10 deletions(-)

-- 
2.47.1



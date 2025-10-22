Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EEB8CCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 14:50:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBa9K-0002YF-Jj; Wed, 22 Oct 2025 10:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBa9G-0002RN-E5
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 10:49:11 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBa9E-000728-Js
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 10:49:10 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46e6a689bd0so66208735e9.1
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 07:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761144545; x=1761749345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=F3zHkTRS4YsgXhoe7EfiVrU0sWi7Uwcw6W36RGchC98=;
 b=tAJ/Soq0206f3zgfONL5y1U1zshikiPW9wkp/J8NGGWa36EfC1IuDx9NTOus2lYzBD
 P90Bj2uiFr1ZzVPo7iLaAUKdghjLhBl9tLp0gsO3/y5vAP05cmpA/lsBKbz0cZJpyPbh
 akGM5qFiorJiJKqibs5g5EorzXrHDVZIHyBELuoqlMI/m2GPjrt2U0ndCcr5YoGPn7v2
 JoxsfgteVr4oHVrQgPffcGgr0l4Pg682javab2vVkH4uIYKhN+22PsLjl2PdFMCOKab+
 K62vd0OdCF9anZBbz1Fx5uTpDisp6X1eyFL/jDBPAFCAgbE/QK4W18dtIddT1f6lnb9t
 9jUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761144545; x=1761749345;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F3zHkTRS4YsgXhoe7EfiVrU0sWi7Uwcw6W36RGchC98=;
 b=Sr1r6ReTJQ77GkxNtkJpeb7UJ9a2DFYARe/Yx/LCtTFd4rRoYBrmMaitV+U7FQ9XKC
 rCMcYJhv51TGB0W1k4gOCtofl5llmems6L9geVFatWBSRWS8N4UFr5xDioqxnNsr/RGk
 LfUclFqRyiu4KbGqc4iUGCKnTkB+F/IokyMYzaUqzfQ/yJBgyTWDdKrE33VTtnBzDMDD
 NO9bQczo0uiOL/arPFpCo6MNCLLMCXoh3/0xH7bw0dkCzlKHy0glSB9UJDjJxdLGEeEL
 0VHMM3eIpQLsacwByqUp90lQ57dPvYzWrWsvgrVwgVej2d2wn3pHBO1qeadGdLJwnRb4
 LaBg==
X-Gm-Message-State: AOJu0Yyt953UhaLoBspEH0tX+AGIUnrn3LqXGh5ra3vlHa7N1xklG+Ig
 5ZrWudKAnD1Z4H+ZVUTeRxiDiXtIF95dQIrH3PDVbCTViBx+2BMFqkp7IKQk+FifBN9D7TjaTs5
 wuOdFIPw=
X-Gm-Gg: ASbGnctZChM1CcXMfVspEb1NCg4+77RdKiKQe8MjHDOmQUrTI5/L37tSEY5MQbKpqBi
 bLt8J9t/KPZ3Z9dX5dpRZtUYfBIFjxZLVglQSZ8pGvjA2EGkVb9Mwv9jwxr0RBqk++DM1aIPWYs
 nj/+NdZTHhBXI31mpK7eCla8ibHcvzK68WFHlFUj9u78/92tCb5eCdTydAOKVOlYmRU/yyrALiD
 tVPkPO43IPj/gtuE2x+tCbc2ERkg5Lwl1w1Z9bWFQqKH3ZV2p2oF+C00gPgBSMlE1h2v0fD2i/U
 p4M5QM98OnMN/DuZSq7pUhgsRyKy3MXXTIDzhicQF5g4vW9szR1QK3wHiZF6jao7IEG3VUz7t8h
 TljpSFe7ca0o4L/62FZHA09lPWMbszPvff3TxB1q2H2FRV7/zatLYmnVKx1mwREONYLXsE9F1OW
 7j0xDt2c+3FJsBPBHN+hDpTa2S1JeV60t/5V0/+62U9lkSWxlSc4Irpz2l4gcy
X-Google-Smtp-Source: AGHT+IHoJfYOMuxPBm32x6jq4mwgQ5a2jOq+eHUXAc7GbdtckP18bL6WXHsnvCIVjlewVHkFdRDFeQ==
X-Received: by 2002:a05:600c:3513:b0:46f:b42e:e38c with SMTP id
 5b1f17b1804b1-47117925e9fmr152284105e9.39.1761144545103; 
 Wed, 22 Oct 2025 07:49:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c42b48c9sm52894385e9.15.2025.10.22.07.49.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Oct 2025 07:49:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/7] chardev: Improve @docstring and clarify qemu_chr_write()
 uses
Date: Wed, 22 Oct 2025 16:48:55 +0200
Message-ID: <20251022144903.74612-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Few chardev fixes:
- preserve %errno
- allow partial writes in qemu_chr_write()

Improve chardev methods documentation.

While @c for frontend and @s for backend is accepted, it
confuses me, so I prefer to document for my own mental health.

Based-on: <20251022074612.1258413-1-marcandre.lureau@redhat.com>

Philippe Mathieu-Daudé (7):
  chardev/char-fe: Improve @docstrings
  chardev/char-io: Add @docstrings for io_channel_send[_full]()
  chardev/char-pty: Do not ignore chr_write() failures
  chardev/char: Allow partial writes in qemu_chr_write()
  chardev/char: Preserve %errno in qemu_chr_write()
  chardev/char-hub: Retry when qemu_chr_fe_write() can not write
  hw/char: Simplify when qemu_chr_fe_write() could not write

 include/chardev/char-fe.h | 24 +++++++++++++++++++++++-
 include/chardev/char-io.h | 18 ++++++++++++++++++
 chardev/char-hub.c        |  2 +-
 chardev/char-pty.c        |  2 +-
 chardev/char.c            |  7 ++++++-
 hw/char/cadence_uart.c    |  2 +-
 hw/char/ibex_uart.c       |  2 +-
 hw/char/sifive_uart.c     |  2 +-
 8 files changed, 52 insertions(+), 7 deletions(-)

-- 
2.51.0



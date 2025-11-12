Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51971CCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 13:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJBFh-0001bI-FC; Wed, 12 Nov 2025 08:51:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJB6b-0003wc-S1
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 08:41:52 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJB6Z-0001IW-PP
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 08:41:49 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47778b23f64so6110485e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 05:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762954906; x=1763559706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nS/Ln0BNI6uKG++MK7P76+B6DwdwSKMtQYckUs76g2E=;
 b=UHpXSeWOLmRt1c43OJ/YketCK/WxVQ7A082gffpmjF21jzdCTkiZW0avGfJR28Jcp+
 SF3s019LIIPTMCWL1Sy6QEnjaWAT+D4eDVZTD5+SPGj/cjdhGmG2NllMqXNbrOio0Jw4
 IAQk1/ZKDxHTaNBaqi02RGzbyYSLuBHmYBnJm238Dv93rRIkhz0VjzGhe0xKNSVKjGKr
 Wl+PKDbtjxjNczjxoJHb14B3Wlc9a9uADfu5ImT/8v+5D/db77nYpYFeAsb4eNpdwCPt
 c9LIL7FzCwK0HLvjIKW5NdiR7SFsFv5KAgNLu97sazQGkfwcgUHh65nI0IVcvA7L8J9A
 BBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762954906; x=1763559706;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nS/Ln0BNI6uKG++MK7P76+B6DwdwSKMtQYckUs76g2E=;
 b=iDxijjhV2uPG/EC8jAHFaKAWDid23lSPOD9RV5vJqvF7Xr28T7OywRZSbbK+gkJxjY
 TyLu0px0nzb9rlWrs+6hjVPSXjPYVvULSqDpXU25xSRIrzi4MN9ZhtL9PCDipyeSf2Xg
 hjOdsply8BZ/+qV25yiZPiM/04xTWrt8NSUop6+zLzvgOmtb71QdFm8AjnaSIM07MmsA
 Zh+DqbwQGTWmTKAHcy3+qLQK6kH7TavmXScmlGQfQLG/nyJIYQVrwJGyCgaTViKcPTeI
 xma4lkFc1HfzvuL/pEGjgYWJ9cWn+M0GQuEC/YDsqlGMLIpw+laOk4kqQtnyhEt12dDs
 F/8w==
X-Gm-Message-State: AOJu0YwwA4iGmAemi3yx5WMckSjiRobZzPFqdeUEgWfsBcRNfIOpHp3y
 mdQlOMfpTAbMyXjwKyHn+rvq+76Lm0cQO3vCbzuNnun1VISDEnD1o0l5AvC5mROUcsRcmBErZ9V
 NZ3rem+qdNA==
X-Gm-Gg: ASbGncvfOzSNSzTQySiz4SQt6kb3g4yUvtcMKi3zupUrMQ8Hvsi4JDKxTG3lUxXyKOc
 RICoASe1Jp5qoAeti1AiJPQSYzdqTvdPb/iC4LjvjT+OMSZEfTHTLEk+4Ewuwg69WM5cx/VGpjt
 b4vlTg+0ade83m+L25vmEwBjmm0igcjP0GJzNMd0N9iDNoBeoDTtVCepNDnWVEI/EjmyuBMJdGX
 2T251IcMGBTE2muJGhERLJa5NV3IOfP/U1RS7Mj5EQWBmYlKwDDwiJI9z5cRd8wecK48FJ047LZ
 rXgJAsdrm+M8kJuBJ6CV8uHZmz3JNgiO6OR4G6FzVqxn/sB2dFctL7KiZlfgnJ7GkvN/rRHIw8R
 dxw1co0KjXYGPQLbSma98UApj7UkFFXrTcXa6wBxr4/jaSapBTR4ID7gaZVGKlPD7xrQnF3Z7Ly
 mLFxrsQrcPretB4YZT+3YeZqiAIJozkQUKL3qw4KPvJIVXJ3mUvMMnM5s=
X-Google-Smtp-Source: AGHT+IEUSQRXRrizilrcNPN8fbViCTQWQV3F73Zrgm0QGtyNo6VYwhHPkzir2DsDqIRRpmluIRHOKw==
X-Received: by 2002:a05:600c:a41:b0:477:589e:6c2f with SMTP id
 5b1f17b1804b1-477870c6610mr28331915e9.22.1762954905670; 
 Wed, 12 Nov 2025 05:41:45 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b2e96441dsm26568016f8f.23.2025.11.12.05.41.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Nov 2025 05:41:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 00/10] chardev: Improve @docstring and clarify
 qemu_chr_write() uses
Date: Wed, 12 Nov 2025 14:41:33 +0100
Message-ID: <20251112134143.27194-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

v3:
- Addressed Marc-André & Daniel comments
- Document qemu_chr_fe_write()
- Rename replay arguments

v2:
- Document ChardevClass::chr_write() and qemu_chr_write[_all]()

Few chardev fixes:
- preserve %errno
- allow partial writes in qemu_chr_write()

Improve chardev methods documentation.

While @c for frontend and @s for backend is accepted, it
confuses me, so I prefer to document for my own mental health.

Based-on: <20251022074612.1258413-1-marcandre.lureau@redhat.com>

Philippe Mathieu-Daudé (10):
  chardev/char-fe: Improve @docstrings
  chardev/char-io: Add @docstrings for io_channel_send[_full]()
  chardev/char: Improve ChardevClass::chr_write() docstring
  chardev/char: Document qemu_chr_write[_all]()
  chardev/char-pty: Do not ignore chr_write() failures
  chardev/char: Allow partial writes in qemu_chr_write()
  chardev/char: Preserve %errno in qemu_chr_write()
  chardev/char: Document qemu_chr_fe_write()'s return value
  hw/char: Simplify when qemu_chr_fe_write() could not write
  system/replay: Rename some method parameters

 include/chardev/char-fe.h | 33 ++++++++++++++++++++++++++-----
 include/chardev/char-io.h | 20 +++++++++++++++++++
 include/chardev/char.h    | 41 ++++++++++++++++++++++++++++++++++++++-
 include/system/replay.h   | 16 +++++++--------
 chardev/char-pty.c        |  2 +-
 chardev/char.c            | 11 +++++++++++
 hw/char/cadence_uart.c    |  2 +-
 hw/char/ibex_uart.c       |  2 +-
 hw/char/sifive_uart.c     |  2 +-
 replay/replay-char.c      | 14 ++++++-------
 stubs/replay-tools.c      | 10 +++++-----
 11 files changed, 123 insertions(+), 30 deletions(-)

-- 
2.51.0



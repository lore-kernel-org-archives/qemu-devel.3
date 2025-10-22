Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DED1CCF9E2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 15:08:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBaRK-00007x-Qj; Wed, 22 Oct 2025 11:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBaRJ-00007o-Kx
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 11:07:49 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBaRH-00019L-PG
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 11:07:49 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4710022571cso59487445e9.3
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 08:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761145665; x=1761750465; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=741mPyG7Ws82CP12XuRIk4udW4zd+s4zP/CIYSMvu2c=;
 b=Jf2m68henQyw/gMbGifTk5DcBL3ZLC+wD5e3PH0QiKyd2bLtNyVAI4P98AqOamY6I1
 OJKPLIkW0+dyKYcxZMTO1pmYWzDPhUWTxBQjq8bKFNzznizwEIGTgGGkQhym0NG3EZsb
 h1vkQwJ9ZdyNLeXWqqZB8ta39PD1f5HncSUL1Ee/VdQiqiBN+u1eNFeBzXn0bR/T9lDq
 L8b4dEQNRYMXfzAqj3iReqlhxiS0ZkkZaOsGY/s2Cg5S7b2sMzaxNUL8xlUCdnG5B5eZ
 CNrTpBUzlSK/h9uKuCpWeIUf+vfbJDUolhYasHKDif5ftpMjucy8RQ+3vm7DsPWnzIkK
 7WhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761145665; x=1761750465;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=741mPyG7Ws82CP12XuRIk4udW4zd+s4zP/CIYSMvu2c=;
 b=s4WH0CQt4gIuCKzuY4LBLtR89nIBIBIJa8dJlTzz1r/IQ5CxFv2s2ChULvUXWfzk3g
 pJXJBhTYFAxRErCPPcHrIWhlS4hZDfC4zTCtb+dD2myZhMK4EKs/nsC7xskRjoyy5oAC
 W9zPX3VOMEQhw1rU/NJc4Z16gdWJtZQmFlHBt9+/qoIishl70X+4IFTV6qnn8CcIrIlI
 5P1McV0mergGLXVvVzM/EcbxSv21ZeodRLcLZVl3jkoL0syVW4WIRmIzsK8HwBByaUOy
 XZQEVQrbVNZY4LbF/owAq5pqba0SXD17GvFSRhjv1CKJqLC6SoEEtpESqbIzoLxCGoCg
 IyPw==
X-Gm-Message-State: AOJu0YwQYrzV0pk//LlGdJp5/H40NWAMKEAWSkgBYXj6tIrW3SSi0dDV
 BaNSMb8sjoS193SI2EB/lHT2EIdordm+SWpV229xSaW6F9TiABx53dsOzSwQHfE3mu432CWzMUR
 tLW+/NGI=
X-Gm-Gg: ASbGncs2oZeNOt7RgHLQRpOEszvAe+/QvupqRKzrPXfXdG4KMCN6VMhsqlV0XBZZtlX
 xEJfkH93iNGpegbuQO8yWFRO5kCxVW+wAn0HwWZSAmsVVYXgXdq5BQRDzWzAZAjR/+Z74++jPp5
 MaOUp/ihfzsYb0lwgoFO6jRtqfWWIX/Y5Q7Huni+/+VLD4mIfvX5kBpW0d6zDyPGiX/rlAlXcXg
 DUPwA6VmccTTqXiKjFqB3gjZZBRSgKNcp7RiNw8sB1peu471f4fILEWkKX56uFB8LZYncGZG276
 CDd2yhtlBp/FhpuMvCBFkGSxoQEBUUiXrgExAgQEx8mOCQQUhJR0dIN7Ogah2wP+yL0SyZElEQy
 JLqOgV+OqscZoNHbJqyzc9iiHwuKydUD7ARfRoVE+zwJ0axIr8EBIZpPbVe/TY/xIjQTN2bRqVi
 VniS2AuJouTrscap7WNdKV60fUyNRpl2NWoACtT/xiA3XgcByfrg==
X-Google-Smtp-Source: AGHT+IG36aBy54Abgq1JyrsOME5NLqF0vOw5hlJNh88XQ751TonZSB9/lORTHwaZp+L5GHWM150X8A==
X-Received: by 2002:a05:600c:3e05:b0:471:16f3:e542 with SMTP id
 5b1f17b1804b1-47117870720mr184679845e9.2.1761145665205; 
 Wed, 22 Oct 2025 08:07:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c42d9524sm46335915e9.18.2025.10.22.08.07.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Oct 2025 08:07:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/9] chardev: Improve @docstring and clarify
 qemu_chr_write() uses
Date: Wed, 22 Oct 2025 17:07:34 +0200
Message-ID: <20251022150743.78183-1-philmd@linaro.org>
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

v2:
- Document ChardevClass::chr_write() and qemu_chr_write[_all]()

Few chardev fixes:
- preserve %errno
- allow partial writes in qemu_chr_write()

Improve chardev methods documentation.

While @c for frontend and @s for backend is accepted, it
confuses me, so I prefer to document for my own mental health.

Based-on: <20251022074612.1258413-1-marcandre.lureau@redhat.com>

Philippe Mathieu-Daudé (9):
  chardev/char-fe: Improve @docstrings
  chardev/char-io: Add @docstrings for io_channel_send[_full]()
  chardev/char: Improve ChardevClass::chr_write() docstring
  chardev/char: Document qemu_chr_write[_all]()
  chardev/char-pty: Do not ignore chr_write() failures
  chardev/char: Allow partial writes in qemu_chr_write()
  chardev/char: Preserve %errno in qemu_chr_write()
  chardev/char-hub: Retry when qemu_chr_fe_write() can not write
  hw/char: Simplify when qemu_chr_fe_write() could not write

 include/chardev/char-fe.h | 24 +++++++++++++++++++++++-
 include/chardev/char-io.h | 18 ++++++++++++++++++
 include/chardev/char.h    | 35 ++++++++++++++++++++++++++++++++++-
 chardev/char-hub.c        |  2 +-
 chardev/char-pty.c        |  2 +-
 chardev/char.c            |  7 ++++++-
 hw/char/cadence_uart.c    |  2 +-
 hw/char/ibex_uart.c       |  2 +-
 hw/char/sifive_uart.c     |  2 +-
 9 files changed, 86 insertions(+), 8 deletions(-)

-- 
2.51.0



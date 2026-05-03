Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B655BFF886F
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2026 05:59:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJPqu-00011x-N5; Sun, 03 May 2026 01:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1wJM5v-0004sE-4U
 for qemu-devel@nongnu.org; Sat, 02 May 2026 21:58:07 -0400
Received: from mail-dl1-x1233.google.com ([2607:f8b0:4864:20::1233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1wJM5t-0000QW-DB
 for qemu-devel@nongnu.org; Sat, 02 May 2026 21:58:06 -0400
Received: by mail-dl1-x1233.google.com with SMTP id
 a92af1059eb24-12c726ef332so4732485c88.1
 for <qemu-devel@nongnu.org>; Sat, 02 May 2026 18:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777773483; x=1778378283; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=r0aJxiFDsApRbUYKQFWya19YjRrC0xxvy142a2wjPBo=;
 b=ZCta2gSE9F+aYICVNu5YaFVJx2RgY65iAZ7IRv2jWl60AlYTepeIW/qjsmtoegrag2
 8YtpdyUy4A2qQIsj7yVZZ4qW4hET5YBt8XDKMMp1MYDI4e+g3yEVkF2+Uo066GDy+SfC
 vyLhTm3W94hEIFLn/ZSA3lsJspjvcNoAgw5MEMp5ylzQT++WfYavEnDWP4rjXSWLfhV8
 X1RrWXjSCGo9tjOTng3U9NsKyLcnfrhrI2+qxRoc7uv+dpyV3xRamJpCWSsxpUDKaEC5
 Al9uEU8nFebOlrqlgA7e3YuXEu545E+uqfTxZnm7hfZGuVYp2FM67nwvuEbwmqt4cRD8
 b5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777773483; x=1778378283;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r0aJxiFDsApRbUYKQFWya19YjRrC0xxvy142a2wjPBo=;
 b=LsPetQMNimJlL8SgRy0q9OciqCw5HwUS3gzQKs3n8P1dbV9HA4LC4mj/02MRNvo8JD
 SQiyIeuMyB7n5ArJ68GLi1AImLg8HdcEOShRq6DIv8C4CmYAX4xVu4o+wKyVbn54mZJK
 kLmhlO/Rftysd8aj5etTwJqV0cNCRo1g9b0JGYO1EkkfUopSEN092bfNyhk2fvE6O7yD
 3z8f15MB/yRnS4iIAdL/XILLdUgVB7MQmBnQqgeOCFkaj82NUZyLVLahjV8U1UvvZAJK
 BOg2PxKBGheH+FS2zWo8v612Ivjt5VJXfuDZtvihEzvVq0JZJ0RiRUMaLh1va239m43m
 3nBQ==
X-Gm-Message-State: AOJu0YxOcYAquQMF/ruWjQogE1dM5A+T5ySSR7/RDOEeX+84ysPvox8v
 Cy1LvVjgQOo0k97w01+c6XObDAU86my5WggeO8hW9+tEoQfULqb7pFYJR5N07A==
X-Gm-Gg: AeBDiesSTZ3tQy/OARrvTpRvQNMoTLbXqmyeMkUYc2TgUWdCqIGIKCJnXpLU18JxeWs
 OoRNzPoNzZJqTCsGdcTj+qtPJSVdjEowk9eMferM3csbo5YIZ3RoEzWajcPbQ5G3RbrMEjB70oV
 kVt7OgOKAvwb5PNwcO4ndEtfUMXd5ZJjwNPlPKlwlp1MNZRXXydMACeXj6isUg4qe57EN+sfQxu
 yiG/ggAt+keNQLs5gDk1kMZfxQWBBwdujV1e/Q0yJkwx//8NF3yVHZxKlTsDGM1bcyhodHa0wmw
 aSieV9f4Y5i3DKlP/8Lrl0un4o9L42QSusL+H3QhPl3bZj2UU7cYbuV5HqqP+78N1Rz/49jWdT5
 hpMKm/5HJp4p8BXwFMmMsUujoyipZcQJ2Rv9G+hSW9OC0DXFdD5bh4V3TgJo9VhkHuVWRWCtmV4
 JjRvJQrdFuIh20Qq/23EgBPyAbgG1T7cQghEDPjpDg808uRsKFHbG9eUrq8q43
X-Received: by 2002:a05:7300:a49a:b0:2d2:129a:1694 with SMTP id
 5a478bee46e88-2efb9e7bb88mr2096779eec.18.1777773482936; 
 Sat, 02 May 2026 18:58:02 -0700 (PDT)
Received: from newsled.lan ([76.133.142.170]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ee38d79eb9sm14361735eec.8.2026.05.02.18.58.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 02 May 2026 18:58:02 -0700 (PDT)
From: 54weasels <54weasels@gmail.com>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	thuth@redhat.com,
	54weasels <54weasels@gmail.com>
Subject: [PATCH 0/7] m68k: Add Sun-3 Machine Emulation
Date: Sat,  2 May 2026 18:57:49 -0700
Message-ID: <20260503015756.99176-1-54weasels@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1233;
 envelope-from=54weasels@gmail.com; helo=mail-dl1-x1233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 03 May 2026 01:58:47 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This implements a barebones Sun 3/60 that can boot a standard firmware, pass all the diagnostic tests and fully netboot both NetBSD 10 and SunOS 4.1.1
It has the minimum necessary devices: memory/MMU, diagnostic and error registers, interrupt, TOD clock, DMA, IDprom and configuration eeprom. I/O is the console serial and lance ethernet.
There are a few modifications needed to emulate a proper 68020, support another external MMU and sun3 specific ways of u sing the escc and ethernet devices.
Next steps are implementing SCSI, graphics, and patching through the keyboard and mouse.

This is part of the Sun 3/60 preservation project: https://github.com/54weasels/sun3_60

54weasels (7):
  target/m68k: Implement Physical Bus Error exception handling
  hw/net/lance: Add Sun-3 Native DMA byte-swapping support
  hw/char/escc: Expose diagnostic RS232 I/O routing
  hw/timer: Introduce Intersil 7170 RTC implementation
  hw/m68k: Overhaul Sun-3 MMU and Boot PROM mapping
  tests/qtest: Add Sun-3 hardware interaction tests
  tests/functional: Add Sun-3 firmware boot and diagnostic test

 hw/char/escc.c                      |  33 +-
 hw/m68k/Kconfig                     |   8 +
 hw/m68k/meson.build                 |   1 +
 hw/m68k/sun3.c                      | 499 ++++++++++++++++++++
 hw/m68k/sun3_eeprom_data.h          | 259 ++++++++++
 hw/m68k/sun3mmu.c                   | 705 ++++++++++++++++++++++++++++
 hw/net/lance.c                      | 111 ++++-
 hw/net/meson.build                  |   3 +-
 hw/timer/Kconfig                    |   3 +
 hw/timer/intersil7170.c             | 216 +++++++++
 hw/timer/meson.build                |   1 +
 include/hw/char/escc.h              |   3 +
 include/hw/m68k/sun3mmu.h           |  65 +++
 include/hw/net/lance.h              |   3 +
 include/hw/timer/intersil7170.h     |   9 +
 target/m68k/cpu.c                   |   5 +-
 target/m68k/cpu.h                   |  18 +-
 target/m68k/helper.c                | 130 ++++-
 target/m68k/op_helper.c             | 176 ++++---
 target/m68k/translate.c             |  31 +-
 tests/functional/m68k/meson.build   |   1 +
 tests/functional/m68k/test_sun3.py  |  34 ++
 tests/functional/qemu_test/asset.py |  11 +-
 tests/qtest/meson.build             |   1 +
 tests/qtest/sun3-test.c             |  67 +++
 25 files changed, 2294 insertions(+), 99 deletions(-)
 create mode 100644 hw/m68k/sun3.c
 create mode 100644 hw/m68k/sun3_eeprom_data.h
 create mode 100644 hw/m68k/sun3mmu.c
 create mode 100644 hw/timer/intersil7170.c
 create mode 100644 include/hw/m68k/sun3mmu.h
 create mode 100644 include/hw/timer/intersil7170.h
 create mode 100755 tests/functional/m68k/test_sun3.py
 create mode 100644 tests/qtest/sun3-test.c

-- 
2.50.1 (Apple Git-155)



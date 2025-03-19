Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 205A9C35FFC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 13:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tutjW-0002a1-Gk; Wed, 19 Mar 2025 09:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tutjM-0002VR-VG
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:45:15 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tutjL-0003sS-3N
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:45:12 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4393dc02b78so30598785e9.3
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 06:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742391909; x=1742996709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZyQkdaxvYZkbr3ISbB/6D4Tnum5jD+nCQ6mZa/A8PFM=;
 b=wV4lEDltXB7y/0IFIKlPQhz6YFf+a2PV9SRpn8IqTULDGm1KPmCho3CHrVVSbzYD7k
 PAqSB/u/UzNy6V3zBFiuwWKS5eyhQO9kzeL9ap0ERl8hSCusBixg4C7u1Ep2MU08tgD+
 6i46I8LivjzT011P7yiHWti/HYgkN8JPSWbbg2zI9Sxrb3mkNW96ACKPET5v1BwX95NR
 VJvw3JOvWMSBv0qEEcWNrMiVjrj+uM1Mr8SC3IXtzh0hdJAIct7Vxj4hOKb+Kfmrj9+T
 zxSJed1MIg2QhVEJehDmN973sydTgF0itReireNo3pmeJ+5mK5vdrI1DZDdFs8kOV44r
 W/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742391909; x=1742996709;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZyQkdaxvYZkbr3ISbB/6D4Tnum5jD+nCQ6mZa/A8PFM=;
 b=Enz1IAHv9cDlIXty3DalB/ferJgoZ+9CgFvAT1COXBuDe1MYzxu4hOThutYNm0+4Ff
 F3OJxx3mxB+eERTduapaQuesJOsBcb1du8HnpjZx+CWo7D4ef5rU8ZPlpSSIoQGENGfz
 twYHxxCJgUTFNV4RkJsTvqgOPrp/4Y9IIzPUxJSldkg0JePoX0/8JrNMkgrYNoI3jGNX
 KS33fhwoAPGPI0X3rru1vII5W3xJDYKjpwgrr6y4mspQrTOEliGqvOx412tI+p6xqvlc
 3BCSJ3Vv6p+UT/2Q4dvEDUC8BXTe4c1BSrgAEawQRXvF1w3wCbnfcJ6sfA9mbNHUkRQ2
 Imlg==
X-Gm-Message-State: AOJu0Yy7L9aCYdl1C2oO4/8eNGzg03tOUFpkPCqMndG/EZf1KBYeFGO6
 TZSVyN7h+LTI+7FBdOqQvigj0g5Cw2M+8kHvrQpN3wjEl6H1jRsS2XRyEAZC6G/4CZN8zGguNJm
 P
X-Gm-Gg: ASbGncspqzroUJE+U4yTsMh6OI7Y18UtfmuRcYZl4bacKwLiimpD5jksAJ21s6QxFhN
 K+sRduWqP5jMz2bCfE7C8s9S/funHv23+0aPYH7zjtldLorxt/zsRGYzZ8VOfWgSRL5J/UX8s5k
 wQWzjY0yDcHkeMLThvcUjwzyuEs7Drng0/p03M/YA2aUbfHHbCaGw+EwkIg3oj2NMt+e4SM6PYD
 0FQ2kJQ5+sdGth49HdxHPCTf0ztvYTrP6oT5PizTkGQFjodEoVHYNe6IH6NK/JsVDgc02UZmSiG
 94r1j8/xIHtTrXxS+k5iJcqs3zS06euLWYXX5Sgpy09lhfwzQjBtF3sOGLC9kjf8ytJLLFxCYoG
 9ALrDg36aKZ0NrTEPBTI=
X-Google-Smtp-Source: AGHT+IFBw+cLu2V0/RfWUFrL+LgLhzkclG1snH+orPgyinmpJ+Xqj9orGYc8tIj8yZzQEL0M9ZXYWw==
X-Received: by 2002:a05:6000:18a9:b0:391:489a:ce12 with SMTP id
 ffacd0b85a97d-399739c8d52mr2161740f8f.26.1742391908927; 
 Wed, 19 Mar 2025 06:45:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43d803f6sm19935515e9.0.2025.03.19.06.45.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 19 Mar 2025 06:45:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 00/12] tcg: Make tcg_gen_insn_start() target-agnostic
Date: Wed, 19 Mar 2025 14:44:54 +0100
Message-ID: <20250319134507.45045-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
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

Instead of TARGET_INSN_START_EXTRA_WORDS, use
TCGContext::insn_start_words().
Define TARGET_INSN_START_WORDS_MAX and reduce
TARGET_INSN_START_EXTRA_WORDS scope.
Unify tcg_gen_insn_start() prototypes.

(preparatory for heterogeneous emulation)

Philippe Mathieu-Daudé (12):
  tcg: Declare TARGET_INSN_START_EXTRA_WORDS in 'cpu-param.h'
  tcg: Always define TARGET_INSN_START_EXTRA_WORDS
  tcg: Have tcg_gen_insn_start() take uint64_t arguments
  tcg: Declare local 'insn_start_words' variable in tcg_gen_insn_start()
  tcg: Use TCGContext::insn_start_words in tcg_gen_insn_start()
  tcg: Use TCGContext::insn_start_words in translate-all.c methods
  tcg: Check TARGET_INSN_START_EXTRA_WORDS range at runtime
  tcg: Declare arrays using TARGET_INSN_START_WORDS_MAX
  tcg: Restrict TARGET_INSN_START_WORDS definition to translate-all.c
  tcg: Unify tcg_gen_insn_start() to handle 1 or 2 arguments
  tcg: Unify tcg_gen_insn_start() to handle 0 or 2 arguments
  tcg: Uninline tcg_gen_insn_start()

 include/tcg/insn-start-words.h   | 17 -----------------
 include/tcg/tcg-op.h             | 26 --------------------------
 include/tcg/tcg.h                |  4 ++++
 target/alpha/cpu-param.h         |  2 ++
 target/arm/cpu-param.h           | 14 ++++++++++++++
 target/arm/cpu.h                 | 14 --------------
 target/avr/cpu-param.h           |  2 ++
 target/hexagon/cpu-param.h       |  2 ++
 target/hppa/cpu-param.h          |  2 ++
 target/hppa/cpu.h                |  2 --
 target/i386/cpu-param.h          |  2 ++
 target/i386/cpu.h                |  2 --
 target/loongarch/cpu-param.h     |  2 ++
 target/m68k/cpu-param.h          |  2 ++
 target/m68k/cpu.h                |  2 --
 target/microblaze/cpu-param.h    |  2 ++
 target/microblaze/cpu.h          |  2 --
 target/mips/cpu-param.h          |  2 ++
 target/mips/cpu.h                |  2 --
 target/openrisc/cpu-param.h      |  2 ++
 target/openrisc/cpu.h            |  2 --
 target/ppc/cpu-param.h           |  2 ++
 target/riscv/cpu-param.h         |  8 ++++++++
 target/riscv/cpu.h               |  6 ------
 target/rx/cpu-param.h            |  2 ++
 target/s390x/cpu-param.h         |  2 ++
 target/s390x/cpu.h               |  2 --
 target/sh4/cpu-param.h           |  2 ++
 target/sh4/cpu.h                 |  2 --
 target/sparc/cpu-param.h         |  2 ++
 target/sparc/cpu.h               |  1 -
 target/tricore/cpu-param.h       |  2 ++
 target/xtensa/cpu-param.h        |  2 ++
 accel/tcg/translate-all.c        | 26 ++++++++++++++++----------
 target/alpha/translate.c         |  4 ++--
 target/avr/translate.c           |  2 +-
 target/i386/helper.c             |  4 ++--
 target/i386/tcg/translate.c      |  2 +-
 target/loongarch/tcg/translate.c |  2 +-
 target/m68k/translate.c          |  2 +-
 target/microblaze/translate.c    |  2 +-
 target/openrisc/sys_helper.c     |  4 ++--
 target/openrisc/translate.c      |  2 +-
 target/ppc/translate.c           |  2 +-
 target/rx/translate.c            |  2 +-
 target/sh4/translate.c           |  2 +-
 target/sparc/translate.c         |  2 +-
 target/tricore/translate.c       |  2 +-
 target/xtensa/translate.c        |  2 +-
 tcg/tcg.c                        | 15 +++++++++++++++
 50 files changed, 109 insertions(+), 108 deletions(-)
 delete mode 100644 include/tcg/insn-start-words.h

-- 
2.47.1



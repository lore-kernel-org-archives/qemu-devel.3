Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D99ACD0D171
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 20:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdZoE-0000ag-UE; Wed, 07 Jan 2026 15:07:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdZoC-0000Xz-OQ
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 15:07:08 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdZoB-0002Cu-3q
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 15:07:08 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47d5e021a53so18402695e9.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 12:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767816425; x=1768421225; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zQsfOcBtztkKTS8NBf1eTI+RcbLFjbRfS/iwerIX93o=;
 b=knZLu2nw6kq3ICiYpdG2Z1mPNYUKZqTl1B/0x7RIfC7rHI0+twLq7r3nzwdvdG0dL1
 FfG6ijMM86yEDkiM3A0nO10HYcmtS5gHZQeR+joRfT20DTS+o3qln4kjUGh9vmwRbaY2
 wV8isuXP0CDBGmLrxpnLASXmD6kKjhIRi2DoI4WLm/hWieUxDEBIlPod/r2nqyTNNule
 /I0a6QTdXc0SUDGbc48xXTeSqp4tcDdklHvnoc/COcN/+13+bdLywkexuN6e7zQhDuvb
 vOl4o15Elzp2TbGsNENLvBszR8f7jaWUpUOYo3uo64lB2tW55RWnuWLz1KlB1nyhN+oW
 iaiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767816425; x=1768421225;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zQsfOcBtztkKTS8NBf1eTI+RcbLFjbRfS/iwerIX93o=;
 b=e4AQnKUKq/MEDVtyeQ4IvRXviOlukEMZWWzle+Qpig2DbgmVWPzcRDn//ioJgBLAqt
 PUpg908xQhkUo1AOFy0a2xtsXhSvbZbf1qGOoMUW9zrRbZBX4dO4GuexPUwxnjoN80sB
 vMDmpum0fjr0EhaH2AFgQ1OBLYlxZFluWe9gQlVBcc7PkegG9NznNn7kkobiabuNunGB
 KKWbXHxRz9DZo0gJJascPS22XYhgIEnGclk/RBU0abtdhqaBA1chE0eIsOyaq+6GygzV
 5uZ1xXqR61C3ERvOLFOa6zvNU2AOmWNIMXTHfvMMU0ep4VjidIajGEYyKubjgQipdItk
 O0Xw==
X-Gm-Message-State: AOJu0Yx8ZD8b6J1m7gKqkZlihy8d4quKv5ClFsiVaGBtSg06ruGP5rEo
 4TStxpdXKp7lZvc76zF9HoWZ/gSHE0gnml14J/oXW/MmBh/4vP1fEFQfmtwL6E7WV3fxbzAuV8r
 UIJjg9SU=
X-Gm-Gg: AY/fxX7YGHFQB0HdFnGuNX7/zDQdNwIcbWkvRjcEGNOFr2ZIyDZOkOXtOOrR9b7MbGS
 PrD8TTuw+R7VqtPNsn7iz5dHVcCjFj9AURMH6qMuBaJNuUyYyRdQ4XKFp1JHUoxwI2Y+LOyPpL4
 Dk1QwdYgZc9h5Zm4DjBU4OL/0djy6+SZQkd0DQF79Z3rWT+NkK/OwPgBjSaMSSLQlaJdyVwg+fs
 6Grjqbdtwp3iLLH8D1vmxqVZSmXzF88q+cUjKnVJvTnm6pbfrbzvFTKHzqwQTyeIfs4fUlO6fQb
 kFw7tnpu5gK48iMMmdxB3HA05DGdy5cLJcYj2jrc0ltmDyUNgxpjYGuUw1lNYf6eIdST6C+BRbO
 lJPLxTjTYkPjcIo7Ug/XBErb7NEPzah8/zP5PRPb2HCYMoUhjql0gCjbCBNJL0dNpzcH1B8JnAI
 DeYpVqTFyfmbX1QIbj0niW4++FIX4mwwpqZrcOyUx10n2jkyXk0CRiMUjsDzMm
X-Google-Smtp-Source: AGHT+IFa1VrsuClRRrkscZkuyD26uOls4IADvkCuaU8/QvJWqi9TuCEat2lOuJkkyFtodV1OJq8jZg==
X-Received: by 2002:a05:600c:a08:b0:479:3a86:dc1f with SMTP id
 5b1f17b1804b1-47d84b41012mr40452955e9.37.1767816424687; 
 Wed, 07 Jan 2026 12:07:04 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f6ef868sm113078665e9.11.2026.01.07.12.07.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 12:07:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Stafford Horne <shorne@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/9] target/misc: Protect few system binaries for target_ulong
 use
Date: Wed,  7 Jan 2026 21:06:53 +0100
Message-ID: <20260107200702.54582-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
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

Omnibus series for architectures with few maintainers.

It took some time but to remove the target_[u]long uses but we
now have some system files in target/ clean of it (rx, sh4,
tricore and openrisc).
Move the source files to the meson target_common_system_arch[]
array to forbid further uses to creep in.
Keep cleaning hppa & m68k. More to come.

Philippe Mathieu-Daudé (9):
  target/rx: Build system units in common source set
  target/sh4: Build system units in common source set
  target/tricore: Build system units in common source set
  target/openrisc: Remove unused 'gdbstub/helpers.h' header in helper.c
  target/openrisc: Avoid target-specific migration headers in machine.c
  target/openrisc: Build system units in common source set
  target/hppa: Avoid target-specific migration headers in machine.c
  target/hppa: Remove target_ulong use in disas_log() handler
  target/m68k: Replace MD_TLONG -> MD_I32 in monitor.c

 target/hppa/machine.c       |  3 +-
 target/hppa/translate.c     |  2 +-
 target/m68k/monitor.c       | 60 ++++++++++++++++++-------------------
 target/openrisc/interrupt.c |  1 -
 target/openrisc/machine.c   |  3 +-
 target/openrisc/mmu.c       |  1 -
 target/openrisc/meson.build |  2 +-
 target/rx/meson.build       |  2 +-
 target/sh4/meson.build      |  2 +-
 target/tricore/meson.build  |  2 +-
 10 files changed, 39 insertions(+), 39 deletions(-)

-- 
2.52.0



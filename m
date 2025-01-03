Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD1CE77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 23:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTqvN-0007f7-UN; Fri, 03 Jan 2025 18:17:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTqvM-0007el-EG
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 18:17:48 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTqvK-0004IC-Cj
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 18:17:48 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43618283d48so92160235e9.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 15:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735946264; x=1736551064; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=szkGz0WM5rxmvwHK12PmnZs8QzF1mTZhvs0Jlss6M8Y=;
 b=mPoZ+uA487w3eDj0mD8pSvDuGMGwGD4kXtou72T0AW+tlBrkhb59Ba2iT+9WOa5FfI
 bjbd5E/Qy82Ydy077q9I93TsAogk90okpSW4OUmpImZvY7LOh6U8AT+L/gmvb6b5uEen
 TJgINs9hg5GhDtgkq8IUGfBcctkyNsNpAOA9k3nv/o5G0z5demSoJdGfhNNpkykq4fWf
 DtBMkIrMU3Y9t6DXMlVnRtfpOSctvfrnrXfaIPlvrTNbH6kYwT/go7DjlikvdxtLgfmF
 GhrSW8W5DTr/F8hLD6sl6fOAmQns8KL76GI/DK6JwW3GihRs599ilma4T06YsyOuBVcI
 O/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735946264; x=1736551064;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=szkGz0WM5rxmvwHK12PmnZs8QzF1mTZhvs0Jlss6M8Y=;
 b=b5Di5mLozKTslDdEN3g3E3D8/2s2bsZBA4cgKjBzIAWZMrfcxaRCNrmMK03xyNbjC/
 deX6EQYxCgR8JBmRYKsO4iGiSjWXY7K+vUyEinE4UGacy36fP0e066+0h7SzxC6trb35
 PWVdoQxToOUlHKYkckQQBF4Ya71NKanRN9akBG+U+mFA9j0cHZZsQf5BHEt/OSa60DtW
 44BbsXm+IDLOlglAmx4pvSW+FWbajJfpFj4uwT/UNBb4pAIN1H8IAY+DyGgVD6LfvMju
 i0SEaqIowYGgAGmYxsr93OudEY9CIGmSOHpymAxwnVxJab3xmyKS/E8fW9/pww2qCVUg
 VV0Q==
X-Gm-Message-State: AOJu0Yzf4vHLgEaBw6TxClIL8nD96xdiS5nPpLbazaG3O8Z8Xdqc/Vfv
 VDNKVJJoXAKkKHxfhES47pFctH0KQI4c19OmVjiPOHWnBIOlsjUo3U5NGkF98ckR8mKgIG+uFd9
 DZOw=
X-Gm-Gg: ASbGncu8u5OMGMNaBx28i5me0aMMNcPXaO8HrJx8Xk+59sKoK+9cOyhJNcR+1F9i6rY
 JoEcUUwIi7DPBAuxu9BrMwMzSBNei7yWREC5CTmems9gmYYYDtUYfnHRH5QTNQyDdTJ9fqJTB+v
 RK91+m+tWEaO4PdncGoe7HGa7ltLt/8xWCNnKmEZ3yI/NBNHhSzstYZlNlRw8OEziAZJ0nF8Pgo
 JamEQ+N9q3cRlzHENNstbkL4lzlBORUq6DzgPrg95mszBq1KGOAPJc5VoXsrWrm1s8iP6pIHNfF
X-Google-Smtp-Source: AGHT+IF0X9pbnMFGgfA9ZREOHTC1eNv6jFBzhIUzuP0y+ex4qpWybc3x8yHj50HhJFhD1Bxs1zR4sg==
X-Received: by 2002:a05:6000:186e:b0:386:378c:b7ec with SMTP id
 ffacd0b85a97d-38a22405d3emr44439572f8f.58.1735946263892; 
 Fri, 03 Jan 2025 15:17:43 -0800 (PST)
Received: from localhost.localdomain ([88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366127c4b0sm496588385e9.35.2025.01.03.15.17.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jan 2025 15:17:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 0/6] disas: Allow linking multiple disassemblers in a
 heterogeneous binary
Date: Sat,  4 Jan 2025 00:17:32 +0100
Message-ID: <20250103231738.65413-1-philmd@linaro.org>
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

Hi,

This series is an experiment to link multiple disassembler
in the same system binary. At least in my prototype I wanted
to get 3: x86 host and microblaze/xtensa targets.

Instead of having meson.build select one pair of host+target,
we let targets to be selected by Kconfig. By default each
target keeps selecting its disassembler, so there is no
change in current uses of 1 target per binary.

Unfortunately I couldn't generalize to user emulation
because we don't use Kconfig there.

Philippe Mathieu-Daudé (6):
  target: Only link capstone to targets requiring it
  target/hexagon: Add Kconfig file
  target/xtensa: Move xtensa-isa.c to common_ss[]
  disas: Have each system target select its disassembler
  Kconfig: Expose host CONFIG_CAPSTONE definition
  disas: Select capstone targets by default

 meson.build               |  4 ++-
 Kconfig                   |  1 +
 Kconfig.host              |  3 ++
 disas/Kconfig             | 60 +++++++++++++++++++++++++++++++++++++++
 disas/meson.build         |  1 -
 target/Kconfig            |  1 +
 target/alpha/Kconfig      |  1 +
 target/arm/meson.build    |  1 +
 target/avr/Kconfig        |  1 +
 target/hexagon/Kconfig    |  3 ++
 target/hppa/Kconfig       |  1 +
 target/i386/Kconfig       |  1 +
 target/i386/meson.build   |  1 +
 target/loongarch/Kconfig  |  1 +
 target/m68k/Kconfig       |  1 +
 target/microblaze/Kconfig |  1 +
 target/mips/Kconfig       |  1 +
 target/openrisc/Kconfig   |  1 +
 target/ppc/Kconfig        |  1 +
 target/ppc/meson.build    |  1 +
 target/riscv/Kconfig      |  2 ++
 target/rx/Kconfig         |  1 +
 target/s390x/Kconfig      |  1 +
 target/s390x/meson.build  |  1 +
 target/sh4/Kconfig        |  1 +
 target/sparc/Kconfig      |  2 ++
 target/tricore/Kconfig    |  1 +
 target/xtensa/Kconfig     |  1 +
 target/xtensa/meson.build |  3 +-
 29 files changed, 96 insertions(+), 3 deletions(-)
 create mode 100644 disas/Kconfig
 create mode 100644 target/hexagon/Kconfig

-- 
2.47.1



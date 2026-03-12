Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A3C11258BE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 13:43:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0gJ5-00047Y-Ep; Thu, 12 Mar 2026 09:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.wainwright@lowrisc.org>)
 id 1w0gIz-00044M-EO
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 09:42:25 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.wainwright@lowrisc.org>)
 id 1w0gIx-0002PW-Gs
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 09:42:25 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-439cb5af25bso1095654f8f.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 06:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lowrisc.org; s=google; t=1773322935; x=1773927735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lj48Mbd5e45okQpPrVOYGjYsiWA5GGrpQidYKkYcn54=;
 b=ckxLpQgtzgTUZ2wD40Dc5e4twlUel4tHpFWaxzOVovILLbeW+oveY7L8RnHk8thpA6
 pAH/7cc3JhHle3/ZQjBWTXYOpUYaHvsCEeP5C2v7LAL30wjv5vaGpe2mqVvvGfDsYOrG
 dpYWBlmDa6SLm7JWHg8COVCYHllyWkIP0XBsEzrRzyHDsXFWm8oirOvIyZXjv07BafEl
 tMHeJ7eMEMtNiUrT4sfoMkC9rnR9VaTPjvCB8V16c3XPEtQ4TnV3P/9tKI6OJlCQZsKw
 ANQlp56ERqMLxWHcGwig4ejHRziqDvBeOdcPHBDIgq2+GQhTElm676Qsq5KVDZUKdgEe
 U58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773322935; x=1773927735;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lj48Mbd5e45okQpPrVOYGjYsiWA5GGrpQidYKkYcn54=;
 b=oN4dEMyBJo2op14JhS92oJuzMxTKDSwDXviL/Y1MMd5XCAtETqOj4iPXIj9SEqObeh
 1FjdPiA0R/+jA0PrFuhFAwYIfL/eH+8J0fmOPIjO6xobzvt4tfDei/TWMkC0TDsFx3/i
 fGOXEoZe+MSRV70uBkp2VIGCgORXmGV2AbhbNwZ846qgVSBRGTOs6E89NwY0U2gSI8ga
 UwSqAVWXPGgIPUEL80alzMlA1pB2T7stpswsN2/wUhcqwYef5RcRxpD419YdgwI9cJJG
 BTos6B97Oz5KfyEnwf8rCS/Vz66BZkNJ1UHT6z/TAgaYtekONiJpP3Hr/fqTyKEQM50j
 LqEQ==
X-Gm-Message-State: AOJu0Yxvygg/g32bcfzugGiqslSsCYKxlZME930LrBoRsk3Toae+PTu+
 lIBiiTdt7jvebfyOMCSuWrnx+3UzXnYhpg0xpjWlpAxzb4PrY6pqOY6CGR0lgkXdIq4=
X-Gm-Gg: ATEYQzyoGq+2sDqnbfmy83zm/OxTvhrM2jDiRX3Qd8OtjysKCNKXze9S1i3SdWqnglG
 jfujMgYafqFefHm8Mmg9VXKqQ1RCwfXiahvLtjY/Jo63DFG5S3nZwkPwWCPG1dY10933bZDq3pe
 vb4nRdBZQqjzAQfL4EsghmFJ/WPIUS3YGScpRzWas3OipoNugo/4g4IzckjY30ugm4E4yuX0Zfu
 DRJsWanfSPwxXAa6rYQBf8U5GRQbKZ1CDWHUX+KbF/KKjZQVu8pCf8FAqchQuitX6v56atXe7H3
 u8NKQHzbWcPGtmRyMoxxix/ut2NVD29wI/M/9w8kbFFBfiygr8g/t/rLVIdIy9I/mV/3gbUnB9J
 ursmeAAxQs3TO/NP9y2XtDF1hk7xQ23cv8WcUdZH3+3rZwudPclUy63IbWVha9F2pH3nPzRleTf
 qEchq81ZXkxJlduVc+DznezqSMRMgJDGQWfCzl8s9zqtvR5S0O6Z9Mjlst
X-Received: by 2002:a5d:638f:0:b0:439:fcf4:32d0 with SMTP id
 ffacd0b85a97d-439fcf43ca0mr5507353f8f.54.1773322934873; 
 Thu, 12 Mar 2026 06:42:14 -0700 (PDT)
Received: from localhost.localdomain ([193.35.234.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe1a737csm7589814f8f.10.2026.03.12.06.42.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 06:42:14 -0700 (PDT)
From: James Wainwright <james.wainwright@lowrisc.org>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, alistair.francis@wdc.com,
 James Wainwright <james.wainwright@lowrisc.org>
Subject: [PATCH v4 0/3] target/riscv: add unratified RISC-V Zbr0p93 ext
Date: Thu, 12 Mar 2026 13:42:06 +0000
Message-ID: <20260312134210.5823-1-james.wainwright@lowrisc.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=james.wainwright@lowrisc.org; helo=mail-wr1-x429.google.com
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

> Looks good but you didn't change the names in the commit titles,
probably worth updating those as well

Good catch, I missed those messages. Updated.

Thanks for the reviews!

James Wainwright (3):
  util: export CRC32[C] lookup tables
  target/riscv: add draft RISC-V Zbr ext as xbr0p93
  disas: diassemble RISC-V xlrbr (crc32) instructions

 MAINTAINERS                               |  5 +-
 disas/meson.build                         |  3 +-
 disas/riscv-xlrbr.c                       | 79 +++++++++++++++++++++
 disas/riscv-xlrbr.h                       | 19 +++++
 disas/riscv.c                             |  2 +
 include/qemu/crc32.h                      | 18 +++++
 include/qemu/crc32c.h                     |  1 +
 target/riscv/bitmanip_helper.c            | 20 ++++++
 target/riscv/cpu.c                        |  4 +-
 target/riscv/cpu_cfg.h                    |  1 +
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/helper.h                     |  2 +
 target/riscv/insn_trans/trans_xlrbr.c.inc | 45 ++++++++++++
 target/riscv/meson.build                  |  1 +
 target/riscv/translate.c                  |  3 +
 target/riscv/xlrbr.decode                 | 30 ++++++++
 tests/tcg/riscv64/Makefile.softmmu-target |  5 ++
 tests/tcg/riscv64/test-crc32.S            | 64 +++++++++++++++++
 util/crc32.c                              | 85 +++++++++++++++++++++++
 util/crc32c.c                             |  4 +-
 util/meson.build                          |  1 +
 21 files changed, 388 insertions(+), 5 deletions(-)
 create mode 100644 disas/riscv-xlrbr.c
 create mode 100644 disas/riscv-xlrbr.h
 create mode 100644 include/qemu/crc32.h
 create mode 100644 target/riscv/insn_trans/trans_xlrbr.c.inc
 create mode 100644 target/riscv/xlrbr.decode
 create mode 100644 tests/tcg/riscv64/test-crc32.S
 create mode 100644 util/crc32.c

-- 
2.48.1



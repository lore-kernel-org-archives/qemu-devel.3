Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30067CCFA1A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 11:48:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vImrB-0006QN-1h; Tue, 11 Nov 2025 06:48:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vImqH-0004d4-Hn
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 06:47:21 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vImqD-0004NC-V8
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 06:47:21 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2953ad5517dso41793115ad.0
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 03:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1762861629; x=1763466429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xVSefwdylmHt/m8ehGWs07UoxaxH3X0P/5IAlbElPkA=;
 b=Xxta+nb/9qrg+X2N0aryAycawGL2PhZzoKWWeND47n2e62WrdG+YTgJHUVXD/smXe2
 LYBOOD3maFnGrPv0tqwmOG/lVogsOLWkE8QS2/rN8FbSUNSpT/CEXpZdps6nVwP6pFSr
 eJPin2tAV+eeEHGIzittm4JHhgs0LNIOxcf20zgcyqXqtUHjAWREFNcjXf51JT2FHcMh
 K92uIgln8v7X22uT4ontM8iHR24n22iafxJBpckZzGJyeDN53nwuJXKVdeolO0YPZIDI
 I38XiXqxgStc0AX/rBrzd+h8kSvBxcC64rsrOkZ017RB6pyhvImR7W1NGz1SwPaZbLgB
 GQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762861629; x=1763466429;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xVSefwdylmHt/m8ehGWs07UoxaxH3X0P/5IAlbElPkA=;
 b=oB7JFlFpCtTwIsiWjrQIaOfO74X3Dr0nY4tenKv5ZbW+xT2hwTiOlHX/7UjpIK0JRR
 6rlSy0IGJoO5mRM8wEmEeQ6wU49tPM41gwLsvJoYG9E1+/Mxpq2hwPRlBuIy5iUuvIHy
 eeRkdXb2PQK7W6HvXNoE7Lj8SjERTO+N2TOLz97sbGnpSD3TQXAHJv/3b9EBLfE/xoeY
 /tqRymTBfZGPNpZgykS8zT2DRPJ2qIY7qEwieGHaqOZBVaQq02JZrBeSelc+ahgr6AxU
 jcFjVC7hREuwMe3UCDNLuFmDb6C074iGXbsxgIGXjSjoHsGSHLuRSkXOfybSbHaUeYvg
 U7vg==
X-Gm-Message-State: AOJu0YyGqGXNU6JY67HEZB5Kz7gcHYyoxU4dExxzk1D0lGNQyAsQKMgG
 7iDTVrmsuySzLASe238h9rsIrzHazGtfeuIZfqrtU+AI5MV/V9KscKR+HkfeKv45VWj/odBJ4rv
 u1/EyL+Q=
X-Gm-Gg: ASbGncuYQOsHgRkgHx6k6ThukEqInFvKJGDLqvgSoFbIu+7511XdQfie0nbKiT3tQ0j
 Cf4+xccUaZiISz2wZh8JTAGJwG/KOgVlG7LRDha00m3F38RVbY/x26iz4GsuobxIkKztAYauvS7
 gG2xh4BGygY4ht6MUuWsBzxtbN+1R4m1RfHT2Mghg5DJ71HRy39L0MRDBgkOmPnOlZ9+u3gW++R
 nCMNcPw0AFlzrBdcqEBmTrHbbGOVYpMAFor8OAyIhJ3RwIGOJiM4WBp+ha5rGD3VdvYqzHKyvoy
 uV7ziJISPfANqqnX5IKHMYOkj/ixEqBYn+VpsTufS6KpqXhHyt0CZXcuIqYN5QF/1wqOQJSJr3U
 NtETyXwQainV2gePYw55lOmJjn0nDOQbDZBz96j5zxT2EHlw82LKu0hRx4Voqeox2Xoi7bJTulf
 g/MrYl4OFSGs3P9mBNNTmk8xKVZAo=
X-Google-Smtp-Source: AGHT+IFgow+W0V/VHh9HrzfmJaiZ3oV9k2iUXsy+7kZSHMDHg7znSvR6NSJgigYnmTjUj28yIvb5Ag==
X-Received: by 2002:a17:903:40c9:b0:297:d6c1:26e with SMTP id
 d9443c01a7336-297e5406088mr139598465ad.6.1762861629017; 
 Tue, 11 Nov 2025 03:47:09 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([179.93.21.233])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29651c747d1sm177533125ad.63.2025.11.11.03.47.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 03:47:08 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 00/17] hw/riscv, target/riscv: initial e-trace support
Date: Tue, 11 Nov 2025 08:46:39 -0300
Message-ID: <20251111114656.2285048-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x630.google.com
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

In this v2 we're addressing a review comment from Konstantin in patch
14. We're also doing changes in the FDT (patch 5) to keep up with the
changes that the kernel support is making [1].

I've been thinking about adding partial support for N-trace in this work
as well. From what I can tell the difference between N-trace and E-trace
are the encoding of the packages, with everything else staying the same.
In this case we could add hooks in the code to be ready to support
N-trace encoding in the future.

No other changes made. Patches based on current master.

Changes in v2:
- patch 5:
  - changed tr_compat from "ventana,veyron-v2-trace" to "qemu,trace-component"
  - renamed trace encoder prop handler "cpu" to "cpus"
- patch 14:
  - removed updiscon generation in gen_jal()
- v1 link: https://lore.kernel.org/qemu-riscv/20251002112335.2374517-1-dbarboza@ventanamicro.com/


[1] https://lore.kernel.org/linux-riscv/20251101154245.162492-1-apatel@ventanamicro.com/

Daniel Henrique Barboza (16):
  hw/riscv: Trace Encoder initial impl
  hw/riscv: Trace RAM Sink initial impl
  hw/riscv/trace-encoder: add trace start/stop logic
  hw/riscv/virt.c: add trace encoders and trace ram sinks
  hw/riscv: add e-trace message helpers
  target/riscv: add initial trace instrumentation
  hw/riscv/trace-encoder: write e-trace packets to RAM sink
  test/qtest: add riscv-trace-test.c
  hw/riscv/rv-trace-messages.c: add encoded trap message
  hw/riscv, target/riscv: send trace trap messages
  target/riscv, hw/riscv: send trace ppccd packets
  hw/riscv/trace: add format2 msg helper
  hw/riscv, target/riscv: send resync updiscon trace packets
  hw/riscv/rv-trace-messages: add format 1 msgs with branch info
  hw/riscv/trace-encoder: send branches info
  hw/riscv/trace: update branch bit in sync messages

Mayuresh Chitale (1):
  hw/riscv/virt.c add trace encoder and ramsink fdt nodes

 hw/riscv/Kconfig                              |   5 +
 hw/riscv/meson.build                          |   2 +
 hw/riscv/rv-trace-messages.c                  | 373 +++++++++++
 hw/riscv/rv-trace-messages.h                  |  40 ++
 hw/riscv/trace-encoder.c                      | 609 ++++++++++++++++++
 hw/riscv/trace-encoder.h                      |  62 ++
 hw/riscv/trace-events                         |   9 +
 hw/riscv/trace-ram-sink.c                     | 263 ++++++++
 hw/riscv/trace-ram-sink.h                     |  83 +++
 hw/riscv/virt.c                               | 135 ++++
 include/hw/riscv/virt.h                       |   2 +
 target/riscv/cpu.h                            |  11 +
 target/riscv/cpu_helper.c                     |  26 +-
 target/riscv/helper.h                         |   6 +
 .../riscv/insn_trans/trans_privileged.c.inc   |  11 +
 target/riscv/insn_trans/trans_rvi.c.inc       |  15 +
 target/riscv/meson.build                      |   3 +-
 target/riscv/tcg/tcg-cpu.c                    |   5 +
 target/riscv/trace_helper.c                   |  62 ++
 target/riscv/translate.c                      |  19 +
 tests/qtest/meson.build                       |   2 +-
 tests/qtest/riscv-trace-test.c                | 120 ++++
 22 files changed, 1860 insertions(+), 3 deletions(-)
 create mode 100644 hw/riscv/rv-trace-messages.c
 create mode 100644 hw/riscv/rv-trace-messages.h
 create mode 100644 hw/riscv/trace-encoder.c
 create mode 100644 hw/riscv/trace-encoder.h
 create mode 100644 hw/riscv/trace-ram-sink.c
 create mode 100644 hw/riscv/trace-ram-sink.h
 create mode 100644 target/riscv/trace_helper.c
 create mode 100644 tests/qtest/riscv-trace-test.c

-- 
2.51.1



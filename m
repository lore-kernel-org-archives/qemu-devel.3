Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D58FCA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 08:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utide-0002kW-OV; Wed, 03 Sep 2025 04:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1utidb-0002je-Qi; Wed, 03 Sep 2025 04:14:39 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1utida-0001h5-1r; Wed, 03 Sep 2025 04:14:39 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-24456ce0b96so8388995ad.0; 
 Wed, 03 Sep 2025 01:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756887274; x=1757492074; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yCb97mwKl0zDXDe9mlZ6s8SrOQ+RIl2akiT0e1loX4I=;
 b=E/uk+RyM8NCEbKfxF+Tlt3xgmfK843148tlLBGCPqYWfTpj9XCNdRnRLsf2yw57+yI
 eP820js3sd8EoegAkcft1JJHD3bn+E/enF9RKIv2/wfpq2k8OaUchjukner2vkkX2O0v
 huDNOAMGdTqrUmK2EaFmt6uaIFW+5fINihlg1aIrDpk9ORjbo6KVBmXyE4pLkGsxoMEf
 m8RXPJrM2SCOHeBejqM3Jm/QlnYzsBhSt/ti0uUHC2fRcc3vTuTz2POsoD5lf2u9tIld
 BY2pB/ej6Cp4pOQIClvRDAwGjtM8jV86Zr1886QebnaQFcn0zo2F4ZhZBMaCz+WK4b0W
 dZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756887274; x=1757492074;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yCb97mwKl0zDXDe9mlZ6s8SrOQ+RIl2akiT0e1loX4I=;
 b=sG6DBoxOOeyrZB00hXo4Dub62VjoCnMDYGzjAZGIuHNew9PSuz8vk5j2HeoBzGdwN+
 GchQ9xaC9DIhJk0rj1pvzSkA+VS85ZWocUOvtXoabN7B3LzlTv+eaVtxokat2j8Yz0Y3
 SUXzRe3M+Y1XXMycwmNQfcfaaRmg86LUUCpMOT0VvsaLfDyBALmqn0d7Y5Eoq2hSNFdk
 KbvDtRulae1Z0n0mXZgLTtw+w/CQXLMNrEFcVrlKpcTosbCLKR5Tqv+0tWgalAZ6DB75
 uu6FKhwED7i2QuUTU8k/DvJbNZ/ADTwAzXvNataNFhwPUpYYknAxv4afcfxwHajRtQRQ
 I4qA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcr5LvynZvrkeG10t98oFEsapw89huGFUidBzJpEwZRu+I4Thqev8SeZrRJBcSP0XjCSzmRjKJLlBW@nongnu.org
X-Gm-Message-State: AOJu0Yx0ibGvezr2x61LpPBnUb2zWYgfoIZt7h4YJoox8hYMGWu8YNMG
 jrZy2hSSLvjAyUKSuTLhY8KSKM8qNB1CoNsDJyo4NM6uS20audkkcL+qS3g4Rg==
X-Gm-Gg: ASbGncuen8jyLliueDL+sh//i60CwyfrRIOJYnXI/l7BHnqKhDW26FGdI9ly8YUVjZc
 WZ728GWzrcGcg4lFGjOEATiXhItzYi1eAc4LHHu/+oGwMiT0DKBI78ukHWjQdnClsec9HaddYsv
 xu1C0032cYKr2uYQf9uUyBbTLltuqojHE16UtAGZiIbR7GwKKgU2HNSYwHUHRwnmhcuq0YQR4s2
 b36B6iWoWot+dUu9/y/xP85wfTYZXpIcSFtfTYe6Pa6KxjLHKb9T+SGU5r8okdUKnfRuKRQll3h
 ETXqs+fGm6aXG7OHERpSi27kP7cH2hTC4sSauVbr/mbmFGgpJ7xfuBdgkraNYMXkUUMicCvC94a
 HVs9sqCyieqTVxBqaF15yn9cp2UOGuRaqL60T8eMB2GfzLhpdjyEL4uLkvJM8YGXp7+Fo
X-Google-Smtp-Source: AGHT+IHJS5Lax5RuypX7/uvbB9Mw436f1+AytLFHTlk0k26/tlhMWv0Tr6dKvIUkYZlWi1Z7G0vmPA==
X-Received: by 2002:a17:902:ecc3:b0:24b:eef:643c with SMTP id
 d9443c01a7336-24b0eef6874mr83328945ad.5.1756887273762; 
 Wed, 03 Sep 2025 01:14:33 -0700 (PDT)
Received: from lima-default (123.253.189.97.qld.leaptel.network.
 [123.253.189.97]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24c9a46bcf1sm8806555ad.3.2025.09.03.01.14.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 01:14:33 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-riscv@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Subject: [PATCH v2 0/4] linux-user/riscv: add vector state to signal context
Date: Wed,  3 Sep 2025 18:14:13 +1000
Message-ID: <20250903081417.338515-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Changes in v2:
- Fix 32-bit compile
- Moved sizeof_rt_sigframe change to its correct patch (patch 2 is the
  one that extends the size of rt_sigframe, patch 3 is adding new
  extended state to the frame which is added dynamically).

This series adds vector state to the linux-user signal handler,
and adds a basic signal handling test case. As a sanity check, I
also verified the signal handling test works in the same way when
run under a real Linux kernel.

The signal handler test has some gross header hacks in it to make
it work for me (debian arm64->riscv64 cross compile environment),
I would not be surprised if it breaks in other environments, any
ideas or breakages let me know. May just have to define the types
by hand for now if it becomes intractable.

I couldn't find much in the way of previous discussion or work on
this, forgive me if I've missed it.

Thanks,
Nick

Nicholas Piggin (4):
  tests/tcg/riscv64: Add a user signal handling test
  linux-user/riscv: Add extended state to sigcontext
  linux-user/riscv: Add vector state to signal context
  tests/tcg/riscv64: Add vector state to signal test

 linux-user/riscv/signal.c                | 197 ++++++++-
 linux-user/riscv/vdso-asmoffset.h        |   4 +-
 tests/tcg/riscv64/Makefile.target        |   5 +
 tests/tcg/riscv64/test-signal-handling.c | 507 +++++++++++++++++++++++
 4 files changed, 700 insertions(+), 13 deletions(-)
 create mode 100644 tests/tcg/riscv64/test-signal-handling.c

-- 
2.51.0



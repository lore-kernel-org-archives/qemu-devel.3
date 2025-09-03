Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B2E7CA1007
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 03:02:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utdl2-0008R4-UR; Tue, 02 Sep 2025 23:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1utdkh-0008Iq-V5; Tue, 02 Sep 2025 23:01:42 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1utdkg-0006pP-Ct; Tue, 02 Sep 2025 23:01:39 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-77251d7cca6so2524268b3a.3; 
 Tue, 02 Sep 2025 20:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756868496; x=1757473296; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IHJKI//T0L/m29VrZQuoIsgd9V8APvn71LpbwpU1NEw=;
 b=ZMFX4lJyjjH3yjxtuVa+ss37EEEgM33us5HdQALy77MiL/09eGRDUP9Egv3NSaJirw
 1eZ/GC+5M79Vf907hQNmToaFhUXSIrAVEG+t5RT3wmNTtZP07j9/lnw+xuNp3pBeZrZ/
 yu7MTYuJcKeIAD9kM7k1AOG07wgomYSlOTvLxpqZHOu4sd6sPX/aRlNEHeSonIXNImeK
 iHQDn9xwaIaejd3E3AXEaGvNednocYG8V62PwDZi07rbR+xvWqXvKMon9CycDmfaFztB
 fpTtw019r9KdxyXPGy0qzxqtlb40eentHwsI/bWfzwFOol4QMMwhZiNzsnqMgj6M4QKh
 I0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756868496; x=1757473296;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IHJKI//T0L/m29VrZQuoIsgd9V8APvn71LpbwpU1NEw=;
 b=KvqQA3fWs50zHOfX3KSsSEYQ+FQro9clLqs3Zs7UnwmvBcgddOI++9NU5S/P+1aAND
 55PXU8F+r422EPTgdVRVID8MATwyrw0VJ6enfQ7a/8/IfsKslTEjB58Ec9r5D+HMld/l
 oFi4peRiyUYIRHJ/eN4XtzuQ52aXX7Vh4+yKtmvGOXj2VMF5HcU+msScJBZKpKngbBIZ
 vUcb6X7EZ8rr1wW6uVwx9y3mkw0D4OOz4NZ3j8FwfsUqLctZYyBW/1FZoNWr69AFd5M8
 JbqYFHRE7lC70mSZmmSffYAMdzT5OeQSf7FXOUxmeyGq7Fq3ehX6LM5PvTRVljNmCI2v
 gZ5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV48CUxuzynvx32oAIHhLUx0sBIkLyR1/07DUZO2HQgAOGbKknXBpj7MRU5D01u4SZT6S/nLl+MUz3C@nongnu.org
X-Gm-Message-State: AOJu0Yz5l3kBXGjnYznu6mCImOtJ1+2IToJcDrSXbuq9fplogzODqOx4
 YfJq282+gJOMQjSBGl8EEG+v1TmDjq/etC63c1hsyUN3CaogqtSab5Nxq7hYOw==
X-Gm-Gg: ASbGnctQYo+2o2jEaFNlsLZeU6EmhGUHaAIGMIQlsMkJSjL6L/AMuhXEQ91/p3+qUBb
 zZaZ3Fhe02pLgUjvcBS9er5CGdFzBnxsJGe17m1pMw5IRUv6DZ4zobLs0qTsDMgmaqw4YSArZcE
 oZvhlhI9E35ye+j3+4SmMFVI/BA5V1XGkHfKgN6MOZIHMovasAcFjslemF10SP7iq+LzIOetUGg
 Au+3fYfcT6v/SIkwfFXeeunUTc2KjellIJxW5tJToig9zV8q9PhAOkttb6lt+BnowuV2x1SLp3y
 8+4+yVSCSdUX7MWyEdNtzFR/vMoLpS5pY2+Z3aoiQLeOdu1IWW1PyVh+P0B5rEHHcV9Ev73HXtk
 6AZosFFK0Wi2dRx1a/VMWEU5TesKf9dE8eAH6PVrOizc4iv/hW5+SBhT6ozSHzblyNq0F6Wl8uG
 6Scq9Z4NL9
X-Google-Smtp-Source: AGHT+IHsXog3Vhl+PdZLZpgVafwCsue4/tXYBXxfEBSk21xNxVMSenAc6/HtRcSiRffbt846EIbaTQ==
X-Received: by 2002:a05:6a00:2283:b0:772:60f2:5af with SMTP id
 d2e1a72fcca58-77260f20bf8mr10051753b3a.11.1756868496116; 
 Tue, 02 Sep 2025 20:01:36 -0700 (PDT)
Received: from lima-default (123.253.189.97.qld.leaptel.network.
 [123.253.189.97]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7725e419913sm6971760b3a.55.2025.09.02.20.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 20:01:35 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-riscv@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org,
 Chao Liu <chao.liu@zevorn.cn>
Subject: [PATCH 0/3] target/riscv: corner case fixes
Date: Wed,  3 Sep 2025 13:01:10 +1000
Message-ID: <20250903030114.274535-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
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

There is ongoing effort to run generated test verification on the 
QEMU riscv CPU which has turned out a few corner cases.

I added some fixes for these, as well as tcg tests. The
interrupted vector test also catches a bug in
"Generate strided vector loads/stores with tcg nodes." that
I referred to in the v5 thread for that series.

Thanks,
Nick

Nicholas Piggin (3):
  target/riscv: Fix IALIGN check in misa write
  target/risvc: Fix vector whole ldst vstart check
  tests/tcg: Add riscv test for interrupted vector ops

 target/riscv/csr.c                        |  16 +-
 target/riscv/vector_helper.c              |   2 +
 tests/tcg/riscv64/Makefile.softmmu-target |   5 +
 tests/tcg/riscv64/Makefile.target         |  10 ++
 tests/tcg/riscv64/misa-ialign.S           |  88 +++++++++
 tests/tcg/riscv64/test-interrupted-v.c    | 208 ++++++++++++++++++++++
 tests/tcg/riscv64/test-vstart-overflow.c  |  75 ++++++++
 7 files changed, 401 insertions(+), 3 deletions(-)
 create mode 100644 tests/tcg/riscv64/misa-ialign.S
 create mode 100644 tests/tcg/riscv64/test-interrupted-v.c
 create mode 100644 tests/tcg/riscv64/test-vstart-overflow.c

-- 
2.51.0



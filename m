Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E87C44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 12:21:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm9Sz-00020n-Nm; Tue, 21 Jul 2026 08:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wm9Sn-0001wh-22
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 08:20:45 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wm9Sk-0003mT-HF
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 08:20:44 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c999f162c9aso7047687a12.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 05:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1784636441; x=1785241241; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XXIhvTqq9Eipcf9U4LdfAxixy8SIppPnstIw922mqg4=;
 b=aHrEpUEv+P2be1VMuaU+HhCMYXshdBNImwJVe3/S9AfwgAZb5ba7gMjKaESZ/NMBoD
 OkuL745CTk36+4siMxcRTkDZPyYZ26B5Et71/8NnpMWOaV0VVpEUDwqRsxit5Adet+wR
 KpgRQYk9sH0nh2TMdo9XkDSpJWBwQPk0jz4gWn+R6qiyfr2/MYYXgu/ZsPCXJEQJjzCt
 Rzbg+9If97PFqIQp6DN5+hXJzQOo5zQ9mb3s6IsLou3pn+JvJ0Xzn60x5BkIZxDBPU8A
 i6m92J+cui23txUxrmRbuF2ezuml8q/Y+0gdhpWLpgOJPmD464QXj8W/PrBD5Vpq6IFO
 XtTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784636441; x=1785241241;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XXIhvTqq9Eipcf9U4LdfAxixy8SIppPnstIw922mqg4=;
 b=cww2+44je7KdHAVCxqZB600nDXo+dSBdaxC/PXEGNghVtOYhFHHPKxtShAHSnxlrF4
 gWIyypFqorpTx1RxzXRJOT96pOgOxGPklPvuNimBIpSXth7vVTZgwNwitqRxtLy7Iso6
 OpW88yk/1n5acqsxjUhmS8lTjJcpqp4efR0jBtsIq+x7MtuD8NQLBGC8yvch+hFPwwfW
 9BaHjDZ24RxR8iBCJsb8nz66ZRuI8y9zy1WxrQPEI5Gi8nvXCxkgkoZVnaoXPp9psABQ
 vppMdP4EIyoHY27aZzGjtK0RgQGVZDB559RSpqBuoi3dzLmboI3b4q4m1s18avUoRHvW
 ZNMw==
X-Gm-Message-State: AOJu0YyRlfjA1cBszTfUDTKPjJBPZrEBcYDpx2VhJQtoC+IUsOuphY2K
 92PEnEJYMSvf4sCCSVeIClT0RT01Odv+FOBE6bNP2IhhUrLTRuLEX0KaAhf5kYmTQPEcWmXqYXj
 tHCUpR/oeDyFSeuZAw0skBP72y/YDvBcLpEXzIkwf90qn+iVF1NZLWqStmhG+1qNVxCkcwAsd7C
 +BZargEOvsFelwvr9KoxbP5u94P+pjpRsqPvQsgQk=
X-Gm-Gg: AfdE7cnB1EAcy+A9AL+GM5pAfg+71MuG825tJOJ1NtsFHYE0XtMXAbdQ8JW5Sy5hmIo
 PO3mzxJgsBQVCO6k13a+eyBsO6GlZQljzya7YDPq2VoUgWm4uhqLSb0MqpZ2YPUcY2jpBJ8Z9rU
 zCn+8tiL2Fr7H2AYXknn7bIfEBmjBD+yCb8BzQ9xqbsIk64oAzKTJV1Evw+pRcJeel57wJwdyNb
 tKXBFofoM9EtMVONNxSlYu9cVyL/H2xJnMzwDQCAwGkScQm8cYPIeunLoUktdoy6MYf+qdiGCI8
 lv5/IQSBaXf8lljfU+SpOURVsORvuflkQgLY6q1V5g0slPM+QWYRb9b2pGUikz7E/oxFwSZftOD
 aWv6myJD3bvvHLXraAjy9s9C6MplSSCXpYDvNBc0H1Yk4QfVmJWzLrEWMrvbKqelYA6gpwyerkE
 tdxhWg4WFwB/7uoAkZp+gcaxZEXJewJBdeKNzUhlWxn6yO94IRGoHq3wvEDEg+tF5uKedv1vNsf
 uvzTg==
X-Received: by 2002:a05:6a20:9397:b0:3c3:83e8:c211 with SMTP id
 adf61e73a8af0-3c3ada1fe89mr19704643637.63.1784636440444; 
 Tue, 21 Jul 2026 05:20:40 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cb517aad95dsm5904568a12.7.2026.07.21.05.20.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 05:20:40 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Max Chou <max.chou@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PATCH 0/5] target/riscv: Add SiFive Xsfvqmaccdod/Xsfvqmaccqoq int8
 matmul extensions
Date: Tue, 21 Jul 2026 20:20:28 +0800
Message-ID: <20260721122034.1567146-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=max.chou@sifive.com; helo=mail-pg1-x52e.google.com
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

This patchset adds SiFive's custom int8 matrix-multiply vector
extensions Xsfvqmaccdod and Xsfvqmaccqoq. Each extension provides 4
signedness variants (unsigned/unsigned, signed/signed,
unsigned/signed, signed/unsigned) for a total of 8 instructions:
sf.vqmacc{u,,us,su}.{4x8x4,2x8x2}.

The toolchains support Xsfvqmaccdod/Xsfvqmaccqoq extensions:
 - LLVM 18.1.0
   - llvm/llvm-project#68295, commit d1985e3d1fed, merged 2023-10-20.
   https://github.com/llvm/llvm-project/pull/68295
 - GCC 15
   - commit 139bd3198a73 ("RISC-V: Add the mini support for SiFive extensions"), 2024-11-17.

References:
 - SiFive Int8 Matrix Multiplication Extensions Specification
   https://www.sifive.com/document-file/sifive-int8-matrix-multiplication-extensions-specification

Frank Chang (2):
  target/riscv: Add SiFive custom int8 matmul extension implied rules
  target/riscv: rvv: Add SiFive custom int8 matmul instructions

Jason Chien (1):
  disas/riscv: Add disassembler support for Xsfvqmaccdod/Xsfvqmaccqoq

Max Chou (2):
  target/riscv: Add cfg property for SiFive int8 matmul extensions
  tests/tcg/riscv64: Add tests for SiFive int8 matmul extensions

 MAINTAINERS                                 |   9 +
 disas/meson.build                           |   3 +-
 disas/riscv-xsf.c                           |  79 ++++++
 disas/riscv-xsf.h                           |  18 ++
 disas/riscv.c                               |   2 +
 disas/riscv.h                               |   1 +
 target/riscv/cpu.c                          |  21 ++
 target/riscv/cpu_cfg.h                      |   5 +
 target/riscv/cpu_cfg_fields.h.inc           |   2 +
 target/riscv/helper.h                       |  10 +
 target/riscv/meson.build                    |   1 +
 target/riscv/tcg/insn_trans/trans_xsf.c.inc |  98 ++++++++
 target/riscv/tcg/tcg-cpu.c                  |  16 ++
 target/riscv/tcg/translate.c                |   3 +
 target/riscv/tcg/vector_helper.c            |  74 ++++++
 target/riscv/xsf.decode                     |  30 +++
 tests/tcg/riscv64/Makefile.softmmu-target   |   7 +
 tests/tcg/riscv64/test-xsfvqmacc.S          | 260 ++++++++++++++++++++
 18 files changed, 638 insertions(+), 1 deletion(-)
 create mode 100644 disas/riscv-xsf.c
 create mode 100644 disas/riscv-xsf.h
 create mode 100644 target/riscv/tcg/insn_trans/trans_xsf.c.inc
 create mode 100644 target/riscv/xsf.decode
 create mode 100644 tests/tcg/riscv64/test-xsfvqmacc.S

-- 
2.55.0



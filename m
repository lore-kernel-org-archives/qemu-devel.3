Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4918C41513
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 15:49:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU6sp-0006VS-3R; Wed, 17 Jul 2024 11:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1sU6fN-00036f-3k
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 11:34:05 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1sU6fL-0004lv-3V
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 11:34:04 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-368440b073bso211185f8f.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 08:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embecosm.com; s=google; t=1721230441; x=1721835241; darn=nongnu.org;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N+ZTCTDtsPvM+z8F1C+LwAra8ZB+wrMRdsWgS+nPMOA=;
 b=RgpFrWQP4W+LzsYwVUVCzcL/++lUCShRIhaF3QPqgolDm4e4+VsIkhbRQfXXtC2nh6
 4lIeQgLxkCZlhO959fBPV7/+DV09vZFKC0KGXAs1NU5ZDf6xVfBfxGdw2f5lFemGR+rd
 BD61Uq25W4GY9lciHwA4e4Aqx0z1L+JSCE9fE021YMAGOUDtgGffqFLQ/zlLrwKVixID
 du0V7kulsbXIaDlsxugAuVs1yaibeB16A5EVgd1TkfOrbCu2SeHzP5mbCQnua+dlN8GS
 FiPVG13FKEbfrszUxzQQMgFBAXBTGbPuthMevscbXuqm6kmF4/U4ZbwGR2tJzBwvCEG4
 lbQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721230441; x=1721835241;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N+ZTCTDtsPvM+z8F1C+LwAra8ZB+wrMRdsWgS+nPMOA=;
 b=kSqHWCWsyDDxs0ZN/QUZmnHSC+Wg2nQtdIhA63zN8v1/ZEu7tR0u+nNZBXaWTzFipg
 BBAVweKBvHuBeXZ1viphFmxAqWHvjJyCd3VQqjCH5utZuvKlvHsRBQ0euYPtBAPBVwiu
 dmfwzsQV1B85ZStGrxKEz4Ydo+q9oMADlrYFAPo8PAm6XiCLhOXhe6sJx/3DdDdkdR92
 PpU9IcLr/ZHERKawBOWujG6QunQ5C2+EscXdRUYOdWl9DghrG3YVEyvAJTOjxNxM8fwI
 ksw1xSFS1nPsvVhd7GEGVri6r24D4za66EsOR3jcBHkZagG2Ch18z6LfDi2Dhgl6iz7/
 t1uw==
X-Gm-Message-State: AOJu0YxK0HiX9B6cSmsLJpZipgpWhmmExewTnF214dy3lJYmnUxyN6PL
 YWRf0HlgzRp+0gQCcEQh3RAlmW1Qy+cjblsPXc4R3mkz9biSi83fRCof9A9eFl+pQBr+X/i3KqF
 ZhgDjFw==
X-Google-Smtp-Source: AGHT+IHlmlrvBECmCgQko/Z3tK7w4ct4kXB4pUFWvsoYAfOA6HmKLwKBhnwzMphNQh1JWP1GgJBdLw==
X-Received: by 2002:a5d:6dad:0:b0:365:aec0:e191 with SMTP id
 ffacd0b85a97d-3682753bd5dmr4877115f8f.21.1721230441002; 
 Wed, 17 Jul 2024 08:34:01 -0700 (PDT)
Received: from paolo-ThinkPad-T490.sou.embecosm-corp.com ([212.69.42.53])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427c779839bsm2369475e9.7.2024.07.17.08.34.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 08:34:00 -0700 (PDT)
From: Paolo Savini <paolo.savini@embecosm.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Paolo Savini <paolo.savini@embecosm.com>,
 Richard Handerson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Max Chou <max.chou@sifive.com>
Subject: [RFC 0/2] Improve the performance of unit-stride RVV ld/st on
Date: Wed, 17 Jul 2024 16:30:38 +0100
Message-Id: <20240717153040.11073-1-paolo.savini@embecosm.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=paolo.savini@embecosm.com; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 17 Jul 2024 11:47:57 -0400
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

This series of patches builds on top of Max Chou's patches:

https://lore.kernel.org/all/20240613175122.1299212-1-max.chou@sifive.com/

The aim of these patches is to improve the performance of QEMU emulation
of RVV unit-stride load and store instructions in the following cases

1. when the data being loaded/stored per iteration amounts to 8 bytes or less.
2. when the vector length is 16 bytes (VLEN=128) and there is no grouping of the
   vector registers (LMUL=1).
3. when the data being loaded/stored per iteration is more than 64 bytes.

In the first two cases the optimization consists of avoiding the
overhead of probing the RAM of the host machine and perform a simple loop
load/store on the data grouped in chunks of as many bytes as possible (8,4,2 or 1).

The third case is optimized by calling the __builtin_memcpy function on
data chuncks of 128 bytes and 256 bytes per time.

These patches on top of Max Chou's patches have been tested with SPEC
CPU 2017 and achieve an average reduction of 13% of the time needed by
QEMU for running the benchmarks compared with the master branch of QEMU.

You can find the source code being developed here: https://github.com/embecosm/rise-rvv-tcg-qemu
and regular updates and more statistics about the patch here: https://github.com/embecosm/rise-rvv-tcg-qemu-reports

Changes:
- patch 1:
  - Modify vext_ldst_us to run the simple loop load/store if we
    are in one of the two cases above.
- patch 2:
  - Modify vext_group_ldst_host to use __builtin_memcpy for data sizes
    of 128 bits and above.

Cc: Richard Handerson <richard.henderson@linaro.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Alistair Francis <alistair.francis@wdc.com>
Cc: Bin Meng <bmeng.cn@gmail.com>
Cc: Weiwei Li <liwei1518@gmail.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: Helene Chelin <helene.chelin@embecosm.com>
Cc: Max Chou <max.chou@sifive.com>

Helene CHELIN (1):
  target/riscv: rvv: reduce the overhead for simple RISC-V vector
    unit-stride loads and stores

Paolo Savini (1):
  target/riscv: rvv: improve performance of RISC-V vector loads and
    stores on large amounts of data.

 target/riscv/vector_helper.c | 63 +++++++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

-- 
2.17.1



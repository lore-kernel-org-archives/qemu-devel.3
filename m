Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6F5C48260
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 00:41:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb8jn-00063w-Eh; Fri, 16 Feb 2024 19:39:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rb8jl-00063V-57
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 19:39:25 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rb8ji-0008Ex-Un
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 19:39:24 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d7354ba334so23827955ad.1
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 16:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708130361; x=1708735161; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RbDO3sPzg8eILeJOf7qSldp6GCpCxh4ZuKVF22f84ro=;
 b=Jr4oo2smIK/f8+ihjzS3ZGuI1cIqu2e9W6jlotbx1+gmnx2oNwYnQWNLhHNmhoOHUB
 pbT1dLGsLPNFfBFZ2Qp2xbLToVMHZgAH//pgGsp96aRbpNblgNAku5ruwhCihYUG0nh0
 qXXtKUn0whJsoSgfACJ6Eqm65/2DGSKE8aymgIFhp03VtafQ+oKJy069yi7C84aY1K/p
 0qps9fBRossJmkZHAmjsSmif3KbRK6QDs9jmN6FuerMaCUbHrGDsCebeznkQbVOyWLZh
 dJITp3/U7H5rAmpOvslwc4N4pkL2naG75+G9AR67PnWuqVyFJ5kbknBjsaHiXy+JcDX1
 Alqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708130361; x=1708735161;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RbDO3sPzg8eILeJOf7qSldp6GCpCxh4ZuKVF22f84ro=;
 b=d4200ynCKt32qAP/G6DB13FHQyf6khSpdnyY6QFMXdaU6pcKDTxrWtOjjHhpw2SLFO
 bqxLhntyKO+wKpwXGTlEzo6rQUb37WbgWNTRnzNYG0GkiDR655WDyLHcXTuZqov6/sai
 HEqNrsPlxU42VeICHQ37Sdk7EKMZ68KgZmrKOH4Bwzwnjbfom30z5kbOHp3ZQZUc25ph
 VCcd9FtB+Q71WtoqO7Ws/tMVDy+BpobkoXWtulpTNrB09UVaICLvGGRiQ3TlbiQ5+SCE
 vXKJbxho+Jxa66I53Wge9tjuu1CwL38MyybG8lmpvm/ezS/BzWDSvIjDLv923GvjIHB1
 RNEg==
X-Gm-Message-State: AOJu0YylE5zPvuomEhcLmXe5wCF7gOKr2jmW2kdVSnNZl4beXfAFxnaT
 qxCOEJur5I7CrNgWhn+A+dfa4+Cqask7dok7LI8i5kEgxmHoskMpbMt4SoqElaXW5c2w08KJw0v
 e
X-Google-Smtp-Source: AGHT+IFlK5FP6paG4Z/iP9NJU9C607Pck8MmPa01XaKYNh1ZYOCL0+K3DAgvxPxd5H8NMQIXsCvSnw==
X-Received: by 2002:a17:902:ec81:b0:1d9:8ac8:d784 with SMTP id
 x1-20020a170902ec8100b001d98ac8d784mr7832418plg.7.1708130361235; 
 Fri, 16 Feb 2024 16:39:21 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 z6-20020a170902ee0600b001d90306bdcfsm419325plb.65.2024.02.16.16.39.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 16:39:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: amonakov@ispras.ru,
	mmromanov@ispras.ru
Subject: [PATCH v5 00/10] Optimize buffer_is_zero
Date: Fri, 16 Feb 2024 14:39:08 -1000
Message-Id: <20240217003918.52229-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

v3: https://patchew.org/QEMU/20240206204809.9859-1-amonakov@ispras.ru/
v4: https://patchew.org/QEMU/20240215081449.848220-1-richard.henderson@linaro.org/

Changes for v5:
  - Move 3 byte sample back inline; document it.
  - Drop AArch64 SVE alternative; neoverse-v2 still recommends simd for memcpy.
  - Use UMAXV for aarch64 simd reduction
    3 cycles on cortex-a76, 2 cycles on neoverse-n1,
    as compared to UQXTN or CMEQ+SHRN at 4 cycles each.
  - Add benchmark of zeros.

The benchmark is trivial, and could be improved so that it
prints the name of the acceleration routine instead of its
index in the selection process.  But its is good enough to
see that #0 is faster than #1, etc.

A sample set:

Apple M1:
  buffer_is_zero #0: 135416.27 MB/sec
  buffer_is_zero #1: 111771.25 MB/sec

Neoverse N1:
  buffer_is_zero #0: 56489.82 MB/sec
  buffer_is_zero #1: 36347.93 MB/sec

i7-1195G7:
  buffer_is_zero #0: 137327.40 MB/sec
  buffer_is_zero #1: 69159.20 MB/sec
  buffer_is_zero #2: 38319.80 MB/sec


r~


Alexander Monakov (5):
  util/bufferiszero: Remove SSE4.1 variant
  util/bufferiszero: Remove AVX512 variant
  util/bufferiszero: Reorganize for early test for acceleration
  util/bufferiszero: Remove useless prefetches
  util/bufferiszero: Optimize SSE2 and AVX2 variants

Richard Henderson (5):
  util/bufferiszero: Improve scalar variant
  util/bufferiszero: Introduce biz_accel_fn typedef
  util/bufferiszero: Simplify test_buffer_is_zero_next_accel
  util/bufferiszero: Add simd acceleration for aarch64
  tests/bench: Add bufferiszero-bench

 include/qemu/cutils.h            |  32 ++-
 tests/bench/bufferiszero-bench.c |  42 +++
 util/bufferiszero.c              | 449 +++++++++++++++++--------------
 tests/bench/meson.build          |   4 +-
 4 files changed, 319 insertions(+), 208 deletions(-)
 create mode 100644 tests/bench/bufferiszero-bench.c

-- 
2.34.1



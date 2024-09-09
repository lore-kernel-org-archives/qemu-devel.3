Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CD8ECE577
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 17:28:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sniBk-0003wj-AJ; Mon, 09 Sep 2024 13:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniBg-0003v2-M5
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:28 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniBe-000606-PV
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:28 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-206b9455460so37857185ad.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 10:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725902905; x=1726507705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XU8WqVqDSNan7RvkUkavozqeS1/zb6eo+5KVt+8RynU=;
 b=dWNX3r7R4KMLbW9HxD9xhzGoFJ5PrlxI2ljK283Bfgih7bE0cYNuEA+Moc8XOeEtJ2
 4PS79JpkdC22SVlMWhvJcf+IriMNy1Xr3rSJlZ39edF5VbhCqwU0W1S5TJJaDlbReTXn
 eYBJacI/Jb4X4U3RS5yLyvE6FMcad94EJlLUTauu0VU8XKsMEAPIgsWHVkhGvFxS26l+
 soBrc+IsT7t5eqWxYMQHZu2cvRyYITW204J3JanuRHyNOof0CGG67clLVnMWGOsC+yAa
 xjVerBq7TwmjLBQBe4Cxw9SwURhZ76/FbwFbokTeOOXAFyPYe/R1YDqSSfboEn2XKWEq
 BZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725902905; x=1726507705;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XU8WqVqDSNan7RvkUkavozqeS1/zb6eo+5KVt+8RynU=;
 b=rk5kl9cXUiEXBW/hFcXYUpWHs+cGuYwVXdjy0BGAmsfx6m+ALmaVuolGHbkvkQw1zF
 h4CFnVRqujR7LCwCqih70YNTbUgNMOVV2quNG282/K+dqC551mToPo5wNrZSknEwPhEa
 fdJXDbFghlcbAgxf28njFk+uK6QbQ6p3MvDi3l2tpHljOPrJb5WRoue47h7LRJHohXFs
 iwsqPBzIIEsUKmNRNNm18x8Q8LZjwdSMpFkS/7ev8et//1Y+O8sLWib+whkn5mZrYCT7
 lG/VFx5B1Fa07CQ5UEIDPMwRbdsEHUcsQ8ZGpv18IYEYsYS/+sc6MWGFvT1D6UeDxrM5
 cMag==
X-Gm-Message-State: AOJu0Yym48VP0D9RlEhA7f1TXDGdn3zwVQR5JZlP7BCZgGm2o8oHUAzr
 4ragIjgfAZ9bcpQ3CQNVppPQMUXJx+ZZHukG936sfIOMPQgjjl6qYwQl4RSvNok/kZO/WQ2hJyx
 k
X-Google-Smtp-Source: AGHT+IHxgTjg2HsK1EE9uMqWwxFHRx2M9X1pkwijhYsjbkIlGOpi9Ka/V7MZMYve1yL9Mzt/4q5mnw==
X-Received: by 2002:a17:902:ea01:b0:207:1845:bc48 with SMTP id
 d9443c01a7336-20743c55a5dmr4371905ad.30.1725902905059; 
 Mon, 09 Sep 2024 10:28:25 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e11e02sm36539875ad.14.2024.09.09.10.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 10:28:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	daniel@0x0f.com
Subject: [PATCH v3 00/26] target/m68k: fpu improvements
Date: Mon,  9 Sep 2024 10:27:57 -0700
Message-ID: <20240909172823.649837-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Supercedes: 20240812004451.13711-1-richard.henderson@linaro.org
("[PATCH for-9.2 v2 0/4] target/m68k: Implement fmove.p")

Changes for v3:
  - Implement FPSR.EXC.  In particular, packed decimal sets a
    different inexact bit.
  - Lots of cleanup to the address/load/store translation, in
    order to be able to pass down insn+ext only to gen_store_fp,
    and not store it in DisasContext.
  - Implement FPIAR stub.


r~


Richard Henderson (26):
  target/m68k: Always return a temporary from gen_lea_mode
  target/m68k: Add FPSR exception bit defines
  target/m68k: Restore fp rounding mode on vm load
  target/m68k: Keep FPSR up-to-date
  target/m68k: Update FPSR.EXC
  softfloat: Set QEMU_NO_HARDFLOAT for m68k
  target/m68k: Invoke update_fpsr for FMOVECR
  target/m68k: Introduce M68K_FEATURE_FPU_PACKED_DECIMAL
  target/m68k: Merge gen_ea into SRC_EA and DEST_EA
  target/m68k: Use g_assert_not_reached in gen_lea_mode and gen_ea_mode
  target/m68k: Use OS_UNSIZED in LEA, PEA, JMP
  target/m68k: Move pre-dec/post-inc to gen_lea_mode
  target/m68k: Split gen_ea_mode for load/store
  target/m68k: Remove env argument to gen_lea_indexed
  target/m68k: Remove env argument to gen_lea_mode
  target/m68k: Remove env argument to gen_load_mode
  target/m68k: Remove env argument to gen_store_mode
  target/m68k: Remove env argument to gen_ea_mode_fp
  target/m68k: Split gen_ea_mode_fp for load/store
  target/m68k: Move gen_addr_fault into gen_{load,store}_mode_fp
  target/m68k: Merge gen_load_fp, gen_load_mode_fp
  target/m68k: Merge gen_store_fp, gen_store_mode_fp
  target/m68k: Implement packed decimal real loads and stores
  tests/tcg/m68k: Add packed decimal tests
  target/m68k: Make vmstate variables static
  target/m68k: Implement FPIAR

 target/m68k/cpu.h                |   27 +-
 target/m68k/helper.h             |    7 +-
 fpu/softfloat.c                  |    2 +-
 target/m68k/cpu.c                |   38 +-
 target/m68k/fpu_helper.c         |  351 ++-
 target/m68k/gen-floatx80-pow10.c |   33 +
 target/m68k/helper.c             |   18 +-
 target/m68k/translate.c          |  800 +++--
 tests/tcg/m68k/packeddecimal-1.c |   41 +
 tests/tcg/m68k/packeddecimal-2.c |   46 +
 target/m68k/floatx80-pow10.c.inc | 4935 ++++++++++++++++++++++++++++++
 tests/tcg/m68k/Makefile.target   |    4 +-
 12 files changed, 5763 insertions(+), 539 deletions(-)
 create mode 100644 target/m68k/gen-floatx80-pow10.c
 create mode 100644 tests/tcg/m68k/packeddecimal-1.c
 create mode 100644 tests/tcg/m68k/packeddecimal-2.c
 create mode 100644 target/m68k/floatx80-pow10.c.inc

-- 
2.43.0



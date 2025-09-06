Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75EC3CA1002
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Sep 2025 05:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uulJz-0000Ah-3z; Sat, 06 Sep 2025 01:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uulJw-00009O-V7
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 01:18:41 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uulJl-0006oQ-A0
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 01:18:38 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-45ddddbe31fso1622265e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 22:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757135902; x=1757740702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Wapd2VeopBfnZY/WYDZqQKc4ECTuHkCcOAubJcTmaL4=;
 b=brJ0cSvRA4esFgtepbgV56rMIhoKveTd6E8fbvxieaMj4WISJ9CLSBqACS2mpqx8Nc
 cPvO/UuKW38hmAVUI5yNhw0RXr45/UQnjcHcQOjv58yxNQ+4Lsguux6ZDc8dBrKvnCT9
 PH9hG+MN/V0e7QhUpaUDXITanrvzTLtmmPWOCcHLAN1ZQ9GhQQzt7NvGD3rzclWefqxj
 lczdiA3/Ceget1h8ncEHuQ87bfxzdVusbnxsm8MdXvE18gjVTwdhXr7ZDFD26vrvVYUx
 a/jtvTL/Krgp9iGdIobcMKFn0veXGjGzFYxoD0adqcCaUI0Rf1PY7LVFXpMiTdUQX8S2
 6pHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757135902; x=1757740702;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wapd2VeopBfnZY/WYDZqQKc4ECTuHkCcOAubJcTmaL4=;
 b=TFct70/+rD3fJT32ekA2IAPX/uAODg4ZJxUD8EPrMVTV1iP3mgLfviw5r2NWsCthlZ
 OWOOUHunEXLNHzUCG9nJvAFNgTDSZnpczjvZ5YmHDSc+gVHu0YnTh/qNNt0P15Q9rO4/
 qjZqUgIKWahdUvbE8gIJbdhfaRLSQ6BCCK5qO/kaODLyrmGnLaKEzJtxU1n2xe4QlAMU
 /qL3uTKhWZpUBoYwxlTUvahiK68ynyVh4nBFWmEodo67/B2xsUCwZqLz3+4iO2q178j+
 hDROgc3Pk23JGa6t1Axatpj1xjccKRjNVjWgyFx2WK7/6FBOgqHE6J3bqUM2CflMrrNU
 kQzw==
X-Gm-Message-State: AOJu0YwrhRCIPMWNpVxszJvCBNDypUloers7vidQe8C3323h9LdAudQ8
 ZN3Tk60b8LuA4fV72tRlYtGyY2t6DdWUL6K9rGGsehYcImiG5KUS+pFBMVKw3UgOXbjNaF2pg1Q
 RaVY44ck=
X-Gm-Gg: ASbGncuLNpDhGixC7HYcZlBp3ROlIRfbkG4c1HbFas9AHxlViRnrC4rWrDGCTuLS2tY
 FBk91uPugCksV6uEJPxIhn+iF99EWmkVDgBhm3zshGK8+s+pd29u/Kzs0m1LOtRBjZWaqh62ttD
 zvjifxYE5fbaZQh6150hjXZvZv7hbY1UgTZAiQndm+nmDWg6UGH4gRg7pg8YMLrOcadU3F2YMl+
 28/V3IGv3YKJ24Q4peQVGPN6eNRr/yEm/L64WVOsT878ozsnq87wui8btEpcKsk5s3x51YFWI3b
 G62A3IqjxVucm5SHV8i8upioQbYV2XXOiw31P1f0rwwznSYoM4n1sD2txd0RqbopZwoI14Cco2h
 O56TxazNlbil0YW1h1NpcB0TiAW5gavnzVGFTUZetJ6ONNQ0WYoOlJ/inSUjj63YEOMPaVSdTrC
 s6I3iqRp4=
X-Google-Smtp-Source: AGHT+IGb4SDS2OclM1pc58OJToVO7Crx1ZiXeuuzlK65cFD8T7HVrkk85ZtSIzjtilrwELSHtm+4Wg==
X-Received: by 2002:a05:600c:4514:b0:45b:772b:12b9 with SMTP id
 5b1f17b1804b1-45ddde9dcd3mr7875145e9.15.1757135902523; 
 Fri, 05 Sep 2025 22:18:22 -0700 (PDT)
Received: from stoup.21wol.it (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f306c22sm441197735e9.13.2025.09.05.22.18.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 22:18:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	philmd@linaro.org
Subject: [PATCH 00/11] accel/tcg: Improve tb_flush usage
Date: Sat,  6 Sep 2025 07:18:09 +0200
Message-ID: <20250906051820.160432-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

It is too easy to mis-use tb_flush().  For instance, because of
the cpu argument, some parts assumed that it needed to call the
global flush function for every cpu.  It is easy to forget that
the flush is not complete when the call returns: we have merely
queued work to the cpu run loop.

(Phil, I suspect this second case is what's biting split-accel.)

So: remove tb_flush and expose only the core as tb_flush__exclusive,
to be used only when we are already within an exclusive context.

In some cases (gdbstub, alpha, riscv, ppc spapr), we can eliminate
the need for tb_flush completely.

Lightly tested so far, and I'm off on holiday next, but I thought
this might help others working on split-accel in the meantime.


r~


Richard Henderson (11):
  gdbstub: Remove tb_flush uses
  accel/tcg: Split out tb_flush__exclusive
  target/alpha: Simplify call_pal implementation
  target/riscv: Record misa_ext in TCGTBCPUState.cs_base
  accel/tcg: Move post-load tb_flush to vm_change_state hook
  hw/ppc/spapr: Use tb_invalidate_phys_range in h_page_init
  linux-user: Use tb_flush_exclusive to start second thread
  plugins: Use tb_flush__exclusive
  accel/tcg: Introduce EXCP_TB_FLUSH
  accel/tcg: Use EXCP_TB_FLUSH in tb_gen_code
  accel/tcg: Remove tb_flush

 include/exec/cpu-common.h       |  1 +
 include/exec/tb-flush.h         | 18 +++++++---------
 target/alpha/helper.h           |  1 -
 accel/tcg/tb-maint.c            | 38 +++++++--------------------------
 accel/tcg/tcg-accel-ops-mttcg.c |  7 ++++++
 accel/tcg/tcg-accel-ops-rr.c    |  9 ++++++--
 accel/tcg/tcg-all.c             | 21 ++++++++++++++++++
 accel/tcg/translate-all.c       |  5 +----
 gdbstub/system.c                |  4 ----
 gdbstub/user.c                  |  3 ---
 hw/core/cpu-system.c            |  8 -------
 hw/ppc/spapr_hcall.c            |  4 ++--
 linux-user/mmap.c               |  4 ++--
 linux-user/syscall.c            |  2 +-
 plugins/core.c                  |  6 ++----
 plugins/loader.c                |  2 +-
 target/alpha/sys_helper.c       |  6 ------
 target/alpha/translate.c        | 21 ++++++------------
 target/riscv/csr.c              |  3 ---
 target/riscv/tcg/tcg-cpu.c      |  3 ++-
 20 files changed, 69 insertions(+), 97 deletions(-)

-- 
2.43.0



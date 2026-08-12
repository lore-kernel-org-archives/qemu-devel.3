Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4894C5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 20:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuFoc-0003UN-Dg; Wed, 12 Aug 2026 16:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuFoY-0003TA-01
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:44:42 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuFoW-0002Dn-ES
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:44:41 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-84862b0d5f8so1350700b3a.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 13:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786567477; x=1787172277; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=68LE8+61OFW02iv+EYPpEpeOsk4G9IcBG+Tp4v4ly/E=;
 b=ax1RKfFdUq3p8rX+Kjh9aU9ZUDTUiT72io6psgEIIAXcI9R2l6J3b9WkDUnv0LlXa2
 opyjvXtsQmp7HVhVwj/IuRjNMWR8sFs6RhutN0hQCoA2+2DsKaGUXzYoIa/8OUlF5/45
 ieJzc5pof54qiDh11Bw2ynBlEWCJZW3mXvh0TltQobzqFvoPABzZ+UNqzVFcgMeH0+5W
 oGenSuG3/uJkVlsoqj22uSKJTLwdpBjiOZaFac6iS7THIqIdQscdw15N5SimcWLQV1NV
 h++tlI8HkK1G0E5b1n+DNcDQsflNsjCh+MBfIpsbSBinZ1JX6hRKNFlpyYpM1MJEypwV
 r4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786567477; x=1787172277;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=68LE8+61OFW02iv+EYPpEpeOsk4G9IcBG+Tp4v4ly/E=;
 b=l23/SbSE5xhMhCkLD3Nl7aQ63ll9+cLRVstMzWbAkjS7jKWQLAg0A+UPnwCUzD4J3w
 6kpUC6kd4vzQyD218OGA89YSYIXJa4XmMVkzAR/3YFpaJecMaDL1JAhQoKHd8BDTfEFa
 ROmMyhe6NcFWgI+HFUKXQLXTQqkQwFhU0jedNaYp0PDJ+WDGNsuES3ljaNd65clial2W
 JOwqM4vL/UMbkYPVWvxE0nvGkHPcK7uLrQQGn+G8Zp7QJSi73YNNUavcva9a/PV0WRf9
 QAlMq1JzndcttwH/9ptNhwESh4PyletAqSAFXyfQcLPy8as2pb3P2mTjOIRn/QGsXlaQ
 e+kQ==
X-Gm-Message-State: AOJu0YzWTy1ReH9CK4XB3Dp5mjEsFABC0umGSPz7fFZB5rzGBj0KuyBg
 AnX2fBLQmReFgjiUsgcYuF96f3VnGlnrYLAHtX2+qZXAZzxhj4M3SS7vpRgb9PDYaaBfziwV6NU
 IUui7
X-Gm-Gg: AR+sD11VAhEvqz9yUovRBGdnaGRJ8Lhtuc18SW7RoIE9BFLVv3hzJBcIH+Vcdrm9oA9
 DxAZ6rSQ+D+sGsvUYkxdE/x598JzBnrKgKZyuS9BdMwy3WPtxGVwG/qxx5K2yTVNuKUF6NbBqBm
 MtpaFOYngPACzi5RWLgKmnxvDkzGh3agu2p0JcyJzrYXsEYwbkt8qpsvwvQ3+j+btXBQ6x/z8BJ
 jseCn+znULIS2Ye6IgRtSMZBlpsw4ENDJR/sDAbX2gXSfbSdaa3wjujrXy3qeewNS53jdooDag0
 Pr65gb+Uj+iOApFfN6ucUJe/ImhxsR0a1+MxzfkqxkIleqZavpaiavmG+PtGhKoE1eCBv5GL/eJ
 Ir5fYvgRuKsP29G17g5azMAtL96f0+cvvqWy9DuFeqgeU++9fBcW7NZr9ciT+dqflM1b6agM28W
 RpEAjfthyNpESWFSWNGZAj5Y3YDjqiZBAUsUc5vFy1CHRdrGiJLgmRxu7kONZ2rGtQGowoONLsX
 8/6NyaZ+u7K48neBjq6yMXm1gahaHs=
X-Received: by 2002:a05:6a00:4211:b0:84a:29a7:f3b1 with SMTP id
 d2e1a72fcca58-84fc6d4c6d5mr760781b3a.16.1786567476962; 
 Wed, 12 Aug 2026 13:44:36 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84fc4787325sm125308b3a.23.2026.08.12.13.44.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 13:44:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 00/10] target/arm: Introduce cpu types max-v8 and max-v9
Date: Wed, 12 Aug 2026 13:44:25 -0700
Message-ID: <20260812204435.295067-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

This is something that we've talked about for quite some time,
having separate "max" cpu types for Armv{8,9}, because Armv9
prohibits some deprecated Armv8 features.  Retaining all features
simultaneously has the potential to cause confusion.

Changes for v2:
  - Re-reorg cpu_max_initfn, avoiding the build failures without tcg.
  - Move aarch32 tcg parts of cpu_max_initfn to tcg/cpu32.c.
  - Separate patch updating feature comments in aarch64_max_tcg_initfn.
  - Do not avoid aa32_max_features for v9 -- the registers still exist
    and describe the features that might be present at EL0.

r~

Richard Henderson (10):
  target/arm: Tidy cpu_max_initfn
  target/arm: Pass ARMCPU to aarch64_aa32_a57_init
  target/arm: Pass aarch64_enabled to aarch64_aa32_a57_init
  target/arm: Sink aarch64_aa32_a57_init into aarch64_max_tcg_initfn
  target/arm: Split out aarch32_max_tcg_init
  target/arm: Move aa32_max_features to tcg/cpu32.c
  target/arm: Introduce cpu types max-v8 and max-v9
  target/arm: Use -cpu max-v8 with aarch64=off
  target/arm: Annotate arch revisions in aarch64_max_tcg_initfn
  target/arm: Separate cpu types max-v8 and max-v9

 target/arm/internals.h                        |   5 +-
 hw/arm/sbsa-ref.c                             |   2 +
 hw/arm/virt.c                                 |   2 +
 target/arm/cpu-max.c                          | 131 +-----
 target/arm/cpu64.c                            |   2 +-
 target/arm/tcg/cpu32.c                        | 111 +++++
 target/arm/tcg/cpu64.c                        | 397 +++++++++++-------
 target/arm/tcg/stubs32.c                      |   2 +-
 tests/qtest/arm-cpu-features.c                |   4 +-
 docs/system/arm/emulation.rst                 |  11 +-
 .../aarch64/test_virt_aarch64_off.py          |   4 +-
 11 files changed, 379 insertions(+), 292 deletions(-)

-- 
2.43.0



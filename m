Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47AD2C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:30:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyyik-0002WA-Qi; Tue, 25 Aug 2026 17:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wyyif-0002Q4-M6
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:30:09 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wyyiZ-0003Kb-Hm
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:30:06 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3964e76d0f4so408313a91.3
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 14:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787693401; x=1788298201; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rVDi7mhUq/yDrXgJJOw/OpfyGAuucS2TTqfrK9JSIbc=;
 b=f1SaUMfd/gHnrKcDLejT9u+8qCuSVABGDxbt7L98Z4OXTByggbCulzyN6kjJBOkr8L
 bfBY12J/xvK98MI+16UMjsBehuoe0SDUY7asd6nQV0a/KH8kSAelnmsO5oXLmCgFNrm4
 QNYGQ2ax782lYQUmMuyspcD47mSNlun1CPsshzUhpTnVxmipoRbkZK0ivDAUfc9OULLm
 A1J6DTpR2QwA2gLBO5XhhFB9qt1861tfqjtWjMRA8lcZrbqnMalfWMpYbK5aeIIrTchS
 y11dDERp9q9/SA93dU+nH3IrVPGaUcY2PW8D0oB7wyNiFKexwG/nUgVm3ffFHwtpSof7
 TGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787693401; x=1788298201;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rVDi7mhUq/yDrXgJJOw/OpfyGAuucS2TTqfrK9JSIbc=;
 b=srXzMMd9KUkx1kzdun1UsjcVoR/XBm9y3GCZbtf1lVkPjdmCzRcA4obh5RA+QCCmcL
 b9Q6RV/ef65FBkNTDmXxl9z9V1McAWXFXRlieR9DYO+vUFmc8iolravg58iKBgMAnLKi
 4+i1f3aPRBtoxDLluy3ed+rD8vJG1uvzmlFuNJS46vq/CoKHrAgfkCLqaizue3YK0XYv
 Fzy1TQAVG+RSLrXab2J81F4oKrNZXqE38Y+SvxYDvwywpePStd3q9f4Y14VSddICfO3H
 RawWuVlACwOLfYK+N2G/hRTfV2leGKvF64vo0GIiGalwJDVK7nsy+1SBLUICRSpaoAmC
 OCpQ==
X-Gm-Message-State: AFuF++k5LJQqBwNIS3ldxMWDq6iSzSUMnxasp1BEdoVM/JdMFMXG1BnW
 xLBcfWS7mM8KaHklpTZrRQtQNWAnM364PgdaTPrRyY/DKI+NsJkjxV9DH0Q9tH6zvB5MeUP46t7
 ehHp9
X-Gm-Gg: AR+sD13EpWjFfRRuv2Wd70T5f6qcuvgzDsTFlWUeyGANUjVKH+ReV9dbalwPtpjfeTm
 XcJmwDnXVE4w1Tu1WY570EijUcRmXE6QpLo5sNIjwcXUouz+2BbCNsm3Y7WO0fZE6azH1YnkKro
 xxG2/63O3o7imhw0JcxkJuD724lXIb/aPkNqKL4MTtfRD4PGEc3+RvZSwklB+NaDtmAFwuvO3dL
 E3T1lvBYGeWXn6JmQYTRGjtVusGsPgeyVv2nEUoaqd1V8R5AtQBJXD9oZIWwZiwbUgOWfdzCiE0
 p5hSbdPEPnUogFl0yWl+m+cKUubHdOmPevRxfdMYewer6yyrCOdkCVl0Z2Wjm2KXWLNJsjMMelK
 FW50agHea+Ar4ulgPv53tYqxl3cCeCMPsr7s5/k/S1Mue86FyMYQ6Vk/CS+xXAxZNbOg+4bgU7g
 E9LZfxJTGrkxPE3g050RVLM+31NuiKaJY7QWxJTEB4ciBn7qiiIkOzqnbSv3D1xkvlpLA+QcWC0
 Bmv5gcveyLgnuLORg==
X-Received: by 2002:a17:90b:4e8f:b0:38e:2517:5d1f with SMTP id
 98e67ed59e1d1-3966d4032e5mr4382127a91.9.1787693401252; 
 Tue, 25 Aug 2026 14:30:01 -0700 (PDT)
Received: from stoup (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396689fa52csm1207163a91.12.2026.08.25.14.30.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 14:30:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v3 0/4] target/arm: Introduce cpu types max-v8 and max-v9
Date: Tue, 25 Aug 2026 14:29:56 -0700
Message-ID: <20260825213000.221822-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Changes for v3:
  - Several patches merged.
  - max-v8 is also present for qemu-{system-}arm.

I realize the registration of -cpu max-v8 will need adjustment
for single-binary, but in the short term I've used an ifdef.


r~


Richard Henderson (4):
  target/arm: Rename and adjust aarch32_max_v8_tcg_initfn
  target/arm: Introduce cpu types max-v8 and max-v9
  target/arm: Use -cpu max-v8 with aarch64=off
  target/arm: Separate cpu types max-v8 and max-v9

 target/arm/internals.h                        |   4 +-
 hw/arm/sbsa-ref.c                             |   2 +
 hw/arm/virt.c                                 |   2 +
 target/arm/cpu-max.c                          |   4 +-
 target/arm/tcg/cpu32.c                        |   8 +-
 target/arm/tcg/cpu64.c                        | 160 ++++++++++++------
 target/arm/tcg/stubs32.c                      |   2 +-
 tests/qtest/arm-cpu-features.c                |   4 +-
 docs/system/arm/emulation.rst                 |  13 +-
 .../aarch64/test_virt_aarch64_off.py          |   4 +-
 10 files changed, 139 insertions(+), 64 deletions(-)

-- 
2.53.0



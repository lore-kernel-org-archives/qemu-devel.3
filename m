Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B866CCCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 09:23:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ73P-0007J9-LM; Wed, 12 Nov 2025 04:22:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vJ730-0007CO-4a
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 04:21:50 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vJ72w-0000Jq-KZ
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 04:21:48 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-429c4c65485so434197f8f.0
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 01:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762939286; x=1763544086; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/nGFF+MjVXiDzjAlaDUncuREYsFKvVKrdEDHV+SFLVM=;
 b=ZgtRerGuSsKzavNjjKR5O+4ydO4yma2uNaTxyX/xKWCANmt8O32xMh1zXb8SWgz1Sj
 3fDvD971DyeGrfyrNyUXIWpZUW+VmAN4A97oDjodxUfX6q/lLRGJyiwwTd6Lxer09Yaa
 cHPFkSrwPBGLRsUX9c76E5nDplxYyZn51gsBQWXiOj1+xTCcfflt9g7c1OXAPrqfo0Pq
 lAihznithKgosC7rBBTmInxDpsPVCcb868IYiQVJydRmZPP2zdAY3DHVjH2BgX6YIOco
 +sM9ULPPxpfONcEtwEI/I7sKBY0S5nZ9/5/TE1c4Wh2rERYMKfUcmBzJZMuIcu5Mjk09
 uC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762939286; x=1763544086;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/nGFF+MjVXiDzjAlaDUncuREYsFKvVKrdEDHV+SFLVM=;
 b=jaNg33oUZqW1evDusUpTqVJ5ldJzIDj4aFEsiaH0if5Ish/KfDbpqODF5vXFblSxJP
 F6JX+Ntra19aMnzedfv6CcSonnFb8fWrizmajhZsXuMQKiUgtjy5kvGFkDUrTRp5nxRU
 l13m5Vdxu+lIUMVCCoYZhgwMaIKPOt+zkl0OXna1h9ox89WEcM4wmJKgP07yO+Qh9Ek2
 71nCMMGaJIEmCSGKPdQ0NWpeUceTBSOZpO8Sy66f6aYwoDhpqV2Tw4ESD7ri/hotxifs
 lUgQ+FksIxfARBInGe+jOgjCACALeoNbo9djdqkCggz1gS1XYSEWv5K56zKt5dUumXkx
 8Srw==
X-Gm-Message-State: AOJu0Yx9XcnqYV8kivgTTtCcpx1lS4YqRuBh/MR5ruBtN5xG7yLENIVt
 Mk5p9YTOccRiVTv6/Y3dVbTcVXuvrw5wiVnT/laAxIN38Q0qaACFGOEwZi8vVqRvQMCSnKqVUTG
 siS3OXeo=
X-Gm-Gg: ASbGncuVsCwWa6td+R2Bc4KzXgs7TipA8YoZnN12eV+XwcCriMENCDC3hZpezh6hmdn
 IBRHVqDOqpWfCNKokBYgPL+ohBYaqQKCGKWykYzKKKWCxT1RjhbJsN23e3OZOv09N322aTPER58
 exnZO72TmmOT6brR6+1yHdqLO3hkgjll5lLYfp2Cby4JbJcJi0y+rvEd8aVHqIeSXgSABOU83Ds
 oDW7EDN1sZhEIUCLkx+BIY8bsGq2PD43bXv0SYz0a66tHi8r+yw5GC/UYsYs5C9BsLcSWZgo1su
 c+u05eWOshslyyTC18nRUN/3ogDCmvvjQGGALa7Q5p4eUdMGEuoyB0uDci7Zlaky6rISZq1ip5T
 3fKuuIdOryrQRrjf/v6M8MA8XQL9YD2+jZnvKB8M+j1pbCmplDSVhoX/X62MRH3Ys10rcdeyBOX
 pt
X-Google-Smtp-Source: AGHT+IHZdSqvqGsdUFG2bKcDfLnMz+Y27Pznq8v++VPSgR983rRWKmRpjgKWPa0IozRSPbFh4HGHfA==
X-Received: by 2002:a05:6000:1863:b0:429:b5a8:5c65 with SMTP id
 ffacd0b85a97d-42b4bda84afmr1984607f8f.30.1762939286109; 
 Wed, 12 Nov 2025 01:21:26 -0800 (PST)
Received: from jimm-x1.. ([2a10:d582:31e:0:df7:7499:aeed:c296])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42abe62bf35sm32572495f8f.7.2025.11.12.01.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 01:21:25 -0800 (PST)
From: Jim MacArthur <jim.macarthur@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH 0/3] Basic ASID2 support
Date: Wed, 12 Nov 2025 09:17:49 +0000
Message-ID: <20251112092048.450090-1-jim.macarthur@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x431.google.com
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

Enable the ID_AA64MMFR4_EL1 register, add the ASID2 field for cpu_max,
then enable writes to FNG1, FNG0, and A2 bits of TCR2_EL1. Any change
of ASID still causes a TLB flush.

Jim MacArthur (3):
  target/arm: Enable ID_AA64MMFR4_EL1 register.
  target/arm: Enable ASID2 for cpu_max, allow writes to FNG1, FNG0, A2
  tests: Add test for ASID2 and write/read of feature bits

 target/arm/cpu-features.h        |  7 +++++
 target/arm/cpu-sysregs.h.inc     |  1 +
 target/arm/helper.c              |  7 +++--
 target/arm/tcg/cpu64.c           |  4 +++
 tests/tcg/aarch64/system/asid2.c | 53 ++++++++++++++++++++++++++++++++
 5 files changed, 70 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/aarch64/system/asid2.c

-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B995CDB47C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 01:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcZGA-0004o7-DR; Wed, 24 Jun 2026 21:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcZG8-0004nO-7n
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 21:52:04 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcZG6-0008QX-E6
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 21:52:03 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-37deb2d3a82so668083a91.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 18:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782352321; x=1782957121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yMcw1k1S+xo5e7vFUSDsLh+Ut7vpYHDTd2ELVDievHM=;
 b=g/vhx9mRf6HftGrrW7Slo185nZYDu8iqtFhMRd+czruVBplSqzcBhy8wa65ZFZChWb
 5S/GoPBEgd35kgnLkCgdaePQr3oiE6bG7AYjcPeEakVWCkZF/TiOF9yTyTo6McyQuyrw
 3ZwPXMJHL5AZx3Cwmbz74A2kDw11Zl2mOz4oS4Hb4g500ePgJ4tK/tTwHhbRBRtmEAV8
 HxDqW91GuS5it9NHnT2Mgy8L+PI7SclWQE2/s+aAvy+NsF1+liqfnjYtz6L43IIcda+f
 nKoQRNeZ7f836FjAPFt2eD60Eus72xrmBhAnPdeUMXkgTw+WE+eSQuppU6229Z7dYpSx
 uSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782352321; x=1782957121;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yMcw1k1S+xo5e7vFUSDsLh+Ut7vpYHDTd2ELVDievHM=;
 b=IvXLJwl2pPHbhukihTQFS4gSohO6T6eGZrVLDygTb4UtIBLZjpHIJRYck1ipzkGFns
 hPd5j8eiNxMWEX52kNvSxqHz+6yPBwFwQsdiAkFTcyiLF2xWhZFXOSV4PTt5zcsv1a+x
 pLsKFdkD13PQaa5XfokuLTHVQHdAEhcn9NzDd/cr4bkQyVrIedvnR5N1QQVow9q2qupa
 ocIS9f6fKYIfvZ8TGHFwhwSYCpprr9iXfh2XmbFdwcc3Mp8YP7p5LttMnSyD+6qbQDhk
 VYFekH1gyAJMbJvbD1MnAT7fPNwTZG1C0jGmU6+5tMTfFGOF6QcFwpaotXN29MbFQDL5
 JE1A==
X-Gm-Message-State: AOJu0YyAzJ39ZQ2eIeifTvMpeY0hApAQh/K6LwZBj86NGUp1hGrIIVYW
 v1bAKbBrRX+aJ3AMYe+FHDL05pk/0X951S9mSWEfta3sOaTAtgxKEeC+TrPV9zTUEkfdpJtqc9I
 iAMis
X-Gm-Gg: AfdE7cnifDC8JyP4QRPo237Z4VrlW9wV6sH2yK7mvZ+U7KXPBk3lIFihy/1PiRoGXnb
 EMVtqJD2NZ1tRSQ0IYc3t77zZ5FcRSxdGax8S+iIfuLpVNwnH640qhrttyJOOS3VkuVzVrI8X7n
 snL5yWm8zvQPP9PnTovfpWUMzAN+KHEyC3oTZZ8TMWYuYqVW0gfMKxX5uOl+Tx44Rgvp/zjJAcf
 E24eAJUAsg8mSCZvl/Ze6lyB4NR19Bxqr7zhZXmACq7YbzRizuVpRrXaL0ym0RzbFOI/Ag4BNno
 SmWNv4SGsKBYg8cO5SfL7Px8O3Nb/4ASiavdSewwv6UQ4n5u3tXiPysXxLlgV8NA1xpZFargl4B
 A8UckBeso8LCeqRuVu08XHiZdxnt+7R46NQFrxevKfhkwh/j2POsSnSSNDFRW/rksY5CMszpm/g
 E4uyq0/FU8AxPlDxlt40wFm2Cn47kbw+gEfFRpOVmcO/93YBe8ZA==
X-Received: by 2002:a17:903:380b:b0:2c0:b6c7:227e with SMTP id
 d9443c01a7336-2c7fc7097e5mr6229705ad.5.1782352320358; 
 Wed, 24 Jun 2026 18:52:00 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7f5ac8908sm9060635ad.8.2026.06.24.18.51.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 18:51:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 00/10] target/arm: Implement FEAT_SME_F8F16
Date: Wed, 24 Jun 2026 18:51:48 -0700
Message-ID: <20260625015159.719300-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

Another minor feature working toward SME2.2.

r~

Richard Henderson (10):
  target/arm: Enable FADD/FSUB (half-precision) with FEAT_SME_F8F16
  target/arm: Rename SME FMLAL/FMLSL patterns
  target/arm: Implement FMLAL (multiple, multiple and single, FP8 to
    FP16)
  target/arm: Implement FMLAL (multiple and indexed, FP8 to FP16)
  target/arm: Implement FDOT (multiple, multiple and single, FP8 to
    FP16)
  target/arm: Implement DOT (multiple and indexed, FP8 to FP16)
  target/arm: Implement FMOPA (widening, 2-way, FP8 to FP16)
  target/arm: Rename FVDOT pattern
  target/arm: Implement FVDOT (FP8 to FP16)
  target/arm: Enable FEAT_SME_F8F16 for -cpu max

 target/arm/cpu-features.h        | 11 +++++
 target/arm/tcg/helper-fp8-defs.h |  2 +
 linux-user/aarch64/elfload.c     |  1 +
 target/arm/tcg/cpu64.c           |  1 +
 target/arm/tcg/fp8_helper.c      | 58 +++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c   | 72 +++++++++++++++++++++++---------
 docs/system/arm/emulation.rst    |  1 +
 target/arm/tcg/sme.decode        | 66 +++++++++++++++++++++--------
 8 files changed, 176 insertions(+), 36 deletions(-)

-- 
2.43.0



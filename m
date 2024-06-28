Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D2CC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 14:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNCWL-0002XJ-GT; Fri, 28 Jun 2024 10:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sNCWJ-0002WV-3x
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 10:24:11 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sNCW2-0004PS-E7
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 10:24:10 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42565cdf99cso6761765e9.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 07:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719584629; x=1720189429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=JfU3+6nOeaBoMP9gBKKz5KGzwhl6LY/esOxJus4DARY=;
 b=EK0jeUS5aCX9Vh+dCAwfH62R5IPDkeTJPC1wdtg5hH6Tlh8shaH/wGo7GKKM/1gZMI
 GYS7zuUzjPrvC67h9I7ZZcc8I0G5bQ919IDlfHBv5xptkdWdS5HzONV6HywHHTCdY/8W
 4B1sQiGXrwvIcnbF4Bh/bdjOxRgz5g9NdguL4vS1Ipyrq6gxnibJeZoD/wjzo7pnDIZ/
 ShL5UWAJTJ84NQlry8+CdbP5jcEoDWgen/fvnGst9VYInif6KNuaZ7pib2KKXn7HEkLU
 ujFcUJe3rMxeanGNWmGd3JO0MyKbIhAXii1/ldKvI5mRYU6Kw6YSofndC+NcrnoJGc+z
 yynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719584629; x=1720189429;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JfU3+6nOeaBoMP9gBKKz5KGzwhl6LY/esOxJus4DARY=;
 b=AAs296XpLHsW+Y46DXVejLNy1VUTJc1p0rzrbzVjcJ7idaRdY60gwZsk5s95CLUVGz
 O+1o3TYCGi5TWeSLKKIRS0bOsuITz5U0bXGsQ9Hpu4NzArepT7I/cBEzQdDp0UI5aQAU
 GfmX62PSz3OzSCfEQkg/s3Lnlj2hXGBcVGUEcAqkIjiZ/K+FKeoT/IS0OP31jBcR/oHw
 /Qa14AHjbPDfBw6T7PfKc0H+3pH3W4RUNhSWQE3zQhXeYGW/vXFhoeCzLkBtZX8gWPwy
 X1c9Tr8kpySOLOdilKrNpiNTm8NbvDCADNCxI2qX1ranepTjQMwLyv2WICEOLM0el7u2
 Hniw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkVpANwwur3jpf3kfPfNkgiRZNgpiyV1c/vOZ3gmKfyNhMZZ23xBEBQQhlK76v32o15wqOKCFIeVxH6CGXvzYjbKsSDUU=
X-Gm-Message-State: AOJu0Yx/uRZZSZsTlvo9LzUPbbhJSSiDQg/SJqjT5E3GkcyAMSksSP7J
 wF3GTls/vMAqVNsVsTXbr0W1BSSsUEjoOcOvv0IIrwZHVUZkvgXgQSFRKSxHYqc=
X-Google-Smtp-Source: AGHT+IFL7H5ygJ0nsZ6pfiH8X0erhyLlw7RCFs4kMJrUOsuHEhz18mpMSeowh5yq7UKQKfgcUwb2mQ==
X-Received: by 2002:a05:600c:929:b0:425:65c5:79a9 with SMTP id
 5b1f17b1804b1-42565c57a7emr48275565e9.30.1719584629250; 
 Fri, 28 Jun 2024 07:23:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af55c0asm37180945e9.15.2024.06.28.07.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 07:23:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 0/9] target/arm: Refactor FPCR/FPSR handling to prepare for
 FEAT_AFP
Date: Fri, 28 Jun 2024 15:23:38 +0100
Message-Id: <20240628142347.1283015-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In AArch32, the floating point control and status bits are all in a
single register, FPSCR.  In AArch64, these were split into separate
FPCR and FPSR registers, but the bit layouts remained the same, with
no overlaps, so that you could construct an FPSCR value by ORing FPCR
and FPSR, or equivalently could produce FPSR and FPCR by masking an
FPSCR value.  For QEMU's implementation, we opted to use masking to
produce FPSR and FPCR, because we started with an AArch32
implementation of FPSCR.

The addition of the (AArch64-only) FEAT_AFP adds new bits to the FPCR
which overlap with some bits in the FPSR.  This means we'll no longer
be able to consider the FPSCR-encoded value as the primary one, but
instead need to treat FPSR/FPCR as the primary encoding and construct
the FPSCR from those.  (This remains possible because the FEAT_AFP
bits in FPCR don't appear in the FPSCR.)

This patchseries does the necessary refactoring to our handling
of FPCR and FPSR to allow us to implement the new FPCR-only bits:
 * we flip vfp_{get,set}_fpscr() and vfp_{get,set}_{fpcr,fpsr}()
   so that the former call the latter rather than the other way round
 * we make the migration code send FPSR and FPCR separately when there's
   a bit set which can't be represented in the FPSCR format
   (we continue to use the FPSCR format on the wire when possible,
   for migration backwards-compatibility)
 * we store the FPCR and FPSR in the CPU state struct in new
   vfp.fpcr and vfp.fpsr fields, rather than in vfp.xregs[ARM_VFP_FPSCR]
 * we make sure that writes to FPSCR leave bits in FPCR that aren't
   in FPSCR alone

The series also has a bit of tidyup of some of the macro naming etc.

thanks
-- PMM

Peter Maydell (9):
  target/arm: Correct comments about M-profile FPSCR
  target/arm: Make vfp_get_fpscr() call vfp_get_{fpcr,fpsr}
  target/arm: Make vfp_set_fpscr() call vfp_set_{fpcr,fpsr}
  target/arm: Support migration when FPSR/FPCR won't fit in the FPSCR
  target/arm: Implement store_cpu_field_low32() macro
  target/arm: Store FPSR and FPCR in separate CPU state fields
  target/arm: Rename FPCR_ QC, NZCV macros to FPSR_
  target/arm: Rename FPSR_MASK and FPCR_MASK and define them
    symbolically
  target/arm: Allow FPCR bits that aren't in FPSCR

 target/arm/cpu.h                  | 109 ++++++++++++-----
 target/arm/tcg/translate-a32.h    |   7 ++
 target/arm/tcg/translate.h        |   3 +-
 target/arm/machine.c              | 135 ++++++++++++++++++++-
 target/arm/tcg/mve_helper.c       |  12 +-
 target/arm/tcg/translate-m-nocp.c |  22 ++--
 target/arm/tcg/translate-vfp.c    |   4 +-
 target/arm/vfp_helper.c           | 187 +++++++++++++++++++-----------
 8 files changed, 356 insertions(+), 123 deletions(-)

-- 
2.34.1



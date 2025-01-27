Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 841F7C02191
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 23:26:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcYUd-0006Jx-R1; Mon, 27 Jan 2025 18:26:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcYUc-0006Jn-4K
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 18:26:10 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcYUZ-0005Vi-FJ
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 18:26:09 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ee8aa26415so8613859a91.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 15:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738020365; x=1738625165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gOVruBfOosdn8le90OoWbUS8+u4xO7r11rTTR1zWn7s=;
 b=C0LrkcsVAeI7lJhezahDqZ3hE9rw94XKnlgbkH/qPI+zF1e9o4qB+oedsYkW4l0Eun
 ndRqrZifEfv38Yh54/XTLlIX+pVrNXTvLvb2UloztmAbWW5bNgs1CklW8SDMWtx7JAD7
 R7vMKTk3/YxNxe3wlIATnAW2X9yYd3mbKe5E2ppPT4GI99gYz7rqZByySuAagqHw1EAC
 J0RUt1HWv2bKVz9A1/BY/J9PtbWqjgnYxKXJ6D+Ebbe1l7Sq6a9tDYZGhVlgejpCE/GU
 Ia/q5sETEXDV8Zn7RAOZ6K3d+jupEORMlqtVc2kNNlqJclkH/ftNQPOCMs7ihsSfhJ6Q
 mWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738020365; x=1738625165;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gOVruBfOosdn8le90OoWbUS8+u4xO7r11rTTR1zWn7s=;
 b=s59+7Fu4fFbTSGeRsxl6tuA99Hyx/xcEBGQHKmFhrWLOEqulb4qVglshVPXSHODR0c
 IdcPhRIYaB11QYuKP2lTViiuxYosXpcjbDsEAoskveXBh06evOinS46UqytjtnbYXBrF
 Cj5Pm4gpscO+8wG3/4148lgfIbywggN8Xa47TjUYGMBu9MpTale1OQ2Qyr7CiG8D6FWp
 mAV4tChVIf8lQSc+18CwYRZdenAfYh+t66OfcmNfGwvURqssI4BCseU8N9pV/sjAPD6G
 n/Mh47KYOvD6AgBefRA5DwHoK3lyofAT1ZdZIxm2aQ/xNjNQ/Rct1hR8/W/XQEPY6f12
 k2Qg==
X-Gm-Message-State: AOJu0Yx1xbK2D7nk1KS8G3yidDekPmQ6PqOTgLq2O5T1XVa3ksqGBZ7H
 Vaj1lOKzwdNxjbx2QMhVHqv4EcjOvuemivfM9mozWAfP08ZJdhN2IzcPFX/JMJCMu3ce693NY95
 A
X-Gm-Gg: ASbGncuSknbBtd4wJMn87A5HwajaiQSKXstjqW7WojVYQFwSxeg2T2JZzZfKVv5JtJt
 TWxyh4tb4KhEJyisJKn0MO2F/UyVVb2NNYGjZcDKyrh/PUPFRFZu+RngiwvJDMZtQigKXxUIgCi
 xwgiccnbmRyZOWJeWMuGvPF0a7kMhx9pZMnlB0qp1l/g+RWdZRKB8kjj4JrH+XIaMmxdM9QwzBs
 kPyczWUQRJMM/q6PVzdF1H9nPuGPejf4mdOSoJLX5Ht1opKHZj0CeJhnn+Cr3MEvaA1L2GB2lVN
 FX6+N263DQ0bUE0JxGjVYkpFwKYn/VyojuqSSEc=
X-Google-Smtp-Source: AGHT+IH2O/a3uxU/0+LPSuTijswevzTifnK5pC8ljgFGrio7pzYQqlmo/7XO3icMGL+clO9QJlFrVA==
X-Received: by 2002:a17:90a:c888:b0:2f6:f32e:90ac with SMTP id
 98e67ed59e1d1-2f782c90095mr64769850a91.11.1738020365616; 
 Mon, 27 Jan 2025 15:26:05 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7ffb1b31esm7833000a91.47.2025.01.27.15.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 15:26:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	qemu-arm@nongnu.org
Subject: [PATCH 00/22] target/arm: FEAT_AFP followups for FEAT_SME2
Date: Mon, 27 Jan 2025 15:25:42 -0800
Message-ID: <20250127232604.20386-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

Hi Peter,

After reviewing your AFP patch set, and starting to rebase SME2 work
on top of that (since I'd been skipping the FPCR.AH portion of SME2),
here are some cleanups which might be folded back into the original
change for FPCR.AH or left as separate follow-ups.

All of the FPST frobbing is because I add FPST_ZA (not included here)
which is like FPST_FPCR_A64, but with default-nans and whose cumulative
exception flags are ignored.  Thus it does not overlap FPST_FPCR_AH
semantics.

I've not tested this extraction heavily (i.e. just make check).
Do you have further tests for AH=1?


r~


Based-on: 20250124162836.2332150-1-peter.maydell@linaro.org
("[PATCH 00/76] target/arm: Implement FEAT_AFP and FEAT_RPRES")


Richard Henderson (22):
  target/arm: Rename FPST_FPCR_A32 to FPST_A32
  target/arm: Rename FPST_FPCR_A64 to FPST_A64
  target/arm: Rename FPST_FPCR_F16_A32 to FPST_A32_F16
  target/arm: Rename FPST_FPCR_F16_A64 to FPST_A64_F16
  target/arm: Rename FPST_FPCR_AH* to FPST_AH*
  target/arm: Introduce CPUARMState.vfp.fp_status[]
  target/arm: Remove standard_fp_status_f16
  target/arm: Remove standard_fp_status
  target/arm: Remove ah_fp_status_f16
  target/arm: Remove ah_fp_status
  target/arm: Remove fp_status_f16_a64
  target/arm: Remove fp_status_f16_a32
  target/arm: Remove fp_status_a64
  target/arm: Remove fp_status_a32
  target/arm: Simplify fp_status indexing in mve_helper.c
  target/arm: Simplify DO_VFP_cmp in vfp_helper.c
  target/arm: Move float*_ah_chs to vec_internal.h
  target/arm: Introduce float*_maybe_ah_chs
  target/arm: Use float*_maybe_ah_chs in sve_ftssel_*
  target/arm: Use float*_maybe_ah_chs in sve_ftmad_*
  target/arm: Use float*_maybe_ah_chs in sve_ftmad_*
  target/arm: Use flags for AH negation in do_fmla_zpzzz_*

 target/arm/cpu.h               | 107 ++++++++++++-----------
 target/arm/tcg/translate.h     |  68 +--------------
 target/arm/tcg/vec_internal.h  |  35 ++++++++
 target/arm/cpu.c               |  28 +++---
 target/arm/tcg/helper-a64.c    |  15 +---
 target/arm/tcg/mve_helper.c    |  44 ++++------
 target/arm/tcg/sme_helper.c    |   4 +-
 target/arm/tcg/sve_helper.c    | 150 ++++++++++++++-------------------
 target/arm/tcg/translate-a64.c | 100 +++++++++++-----------
 target/arm/tcg/translate-sme.c |   4 +-
 target/arm/tcg/translate-sve.c | 126 +++++++++++++--------------
 target/arm/tcg/translate-vfp.c |  78 ++++++++---------
 target/arm/tcg/vec_helper.c    |  26 +++---
 target/arm/vfp_helper.c        |  94 ++++++++++-----------
 14 files changed, 405 insertions(+), 474 deletions(-)

-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD614CD6E4C
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 23:16:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTSr8-0008QV-B6; Sat, 30 May 2026 19:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSr5-0008PT-75
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:12:35 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSr2-0007M5-Ub
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:12:34 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-36d98b74449so77435a91.2
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 16:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780182751; x=1780787551; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AyBp3EYY308YTIebHDB2PCJd9d4wtGq72cDq3rwyeGA=;
 b=FC7Qh5hwXcPOyBXScDCmF4uZKIXW6p9rUZrLiLucl2RxBdMBkibf71rBUMmokAqIPl
 7cVoosJRrFib38O7bUpa5gNAQHpK+zXAiOqgi+KK1c54wZOWpzQuMkb1kxD9ytADpTkK
 u/flC3PeIwxzKDKUMmMAUjiAIq7h2Fg2CAx72Ez1lILrJn5QNwNzj6oBniXbTSfn9+M3
 9UCm84LKuiVmM6cefHBQs2FLl9buCFSSnDs+teBGzVpf4JRLyWMYq68YI6ggEtF9g9Gq
 ZORW7XRqoKzOItFBiQtSjMXUx8gxL3KJeLAk4E54jYvQ/o8YmTGL/0xsbSUqPcGtwXEt
 P+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780182751; x=1780787551;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AyBp3EYY308YTIebHDB2PCJd9d4wtGq72cDq3rwyeGA=;
 b=Y7r9sfBx7bjS2Hu+4EA4Uj8Z0ObxmIdEwM8GsvgzhhUQ0TnMtgcT1LV9+3hVjpRYpK
 bjrY8EiXvgC2lIA5rvK+F+297AVtTTNz7GiVs8q/FtT8fOaOkomwGulI/ToYOZs/pKdk
 jMHAuu2GQcmUn9HZTHBXhZTPv0FFkRy6c4vKQdMIEssMk9NTIM2Hn1TpTVw2ih6wPHCt
 5u6W/oGMDgLJ2YfBu+1oNO9kxHIgpEFgM9OrsTYWuYxCSctHmhFIE6ICfP2npXTPt3Mk
 Nd9dtMygBgJ39SSK7wAQRBtyeUadaWTMcX54F/Yw8a3EwTh/O/laieOP8IJDkn49Unfl
 zbWA==
X-Gm-Message-State: AOJu0YygssunvxLaTTlZmmJnXS/bW95qgeFMspEgm3s8xHCkdib9eLrN
 JF9sLj/hxrArZmEmPzlMZcAxJLYKRHRcp7ujFPY5xAXrrCKqcKYOtp5gWDwpU0swuwY6SuB0i9r
 fiKdjdBg=
X-Gm-Gg: Acq92OFHN7QXpfK9ZqK3/zLgoDHe4vJldrh3g6gcXJWG7TZSyauolJiqOf9F9op2Xuy
 tK1olMy+vcDI8AxCMZjJ8deQR188dLDB6FxfZ4KhO+IrhsxPo7y/4eItLZyz8DycA55QJcAM/ko
 p1a1XmjnVq1cCoyZuQOHHwc7Cdh/4i4e0g/r0cFqqupLiscaRhnRsVpb6uof8rLgKl8N0I/Ht8a
 aXAUz/iIRl23UIafFW9haOTeACBnbPwa7qS/T2cuvwTwITg5v5mqItOKUCHeLJq+SRtXWsEBb41
 9AIbFEqxk1ELJKYgsei0WIfzfLCUegv6f7x8NSo5niLA/d9wOMqBR4WshUNae6jfhRrwNPrPtWO
 kD60NDoO8nV1liXdnNN83T33ZNfXRM9muu+AV69Ti4GZZhJ5RC1Vq9M6HZ7e1V2qQGQ1gQARRV8
 y8Gx9hQH9dBLwAL7IUoULsv+yOKU/kM/9xhsx4ynU=
X-Received: by 2002:a05:6a21:6494:b0:39c:787:f196 with SMTP id
 adf61e73a8af0-3b427eb0f80mr5634639637.16.1780182750910; 
 Sat, 30 May 2026 16:12:30 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c857729d3d1sm5634356a12.21.2026.05.30.16.12.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 16:12:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v8 00/41] target/arm: Implement FEAT_FP8
Date: Sat, 30 May 2026 16:11:48 -0700
Message-ID: <20260530231229.400441-1-richard.henderson@linaro.org>
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

Changes for v8:
  - 23 patches upstream
  - Rebase adjustments
  - Rewrite arm_init_fp_status per feedback

r~

Richard Henderson (41):
  target/arm: Introduce arm_init_fp_status
  target/arm: Set e4m3_nan_is_snan
  target/arm: Implement BF1CVTL, BF1CVTL2, BF2CVTL, BF2CVTL2 for AdvSIMD
  target/arm: Implement BF1CVT, BF1CVTLT, BF2CVT, BF2CVTLT for SVE
  target/arm: Rename SME BFCVT patterns to BFCVT_hs
  target/arm: Implement BF1CVT, BF1CVTL, BF2CVT, BF2CVTL for SME
  target/arm: Implement F1CVTL, F1CVTL2, F2CVTL, F2CVTL2 for AdvSIMD
  target/arm: Implement F1CVT, F1CVTLT, F2CVT, F2CVTLT for SVE
  target/arm: Implement F1CVT, F1CVTL, F2CVT, F2CVTL for SME
  target/arm: Implement BFCVTN for SVE
  target/arm: Implement FCVTN (16- to 8-bit fp) for AdvSIMD
  target/arm: Implement FCVTN, FCVTN2 (32- to 8-bit fp) for AdvSIMD
  target/arm: Implement FCVTN (16- to 8-bit fp) for SVE
  target/arm: Implement FCVTNB, FCVTNT for SVE
  target/arm: Implement FCVT (FP16 to FP8) for SME
  target/arm: Implement FCVT, FCVTN (FP32 to FP8) for SME
  target/arm: Implement LUTI2, LUTI4 for AdvSIMD
  target/arm: Implement LUTI2, LUTI4 for SVE
  target/arm: Enable FEAT_LUT for -cpu max
  target/arm: Enable FEAT_FP8 for -cpu max
  target/arm: Update ID_AA64SMFR0_EL1 fields to ARM M.b
  target/arm: Implement MOVT (vector to table)
  target/arm: Implement LUTI4 (four registers, 8-bit)
  target/arm: Enable FEAT_SME_LUTv2 for -cpu max
  target/arm: Implement FMLALB, FMLALT for AdvSIMD
  target/arm: Implement FMLALB, FMLALT (FP8 to FP16) for SVE
  target/arm: Implement FMLALL{BB,BT,TB,TT} for AdvSIMD
  target/arm: Implement FMLALL{BB,BT,TB,TT} for SVE
  target/arm: Enable FEAT_FP8FMA, FEAT_SSVE_FP8FMA for -cpu max
  target/arm: Implement FDOT (FP8 to FP32) for AdvSIMD
  target/arm: Implement FDOT (FP8 to FP32) for SVE
  target/arm: Enable FEAT_FP8DOT4, FEAT_SSVE_FP8DOT4 for -cpu max
  target/arm: Implement FDOT (FP8 to FP16) for AdvSIMD
  target/arm: Implement FDOT (FP8 to FP16) for SVE
  target/arm: Enable FEAT_FP8DOT2, FEAT_SSVE_FP8DOT2 for -cpu max
  target/arm: Implement FMMLA (FP8 to FP32) for AdvSIMD
  target/arm: Implement FMMLA (FP8 to FP32) for SVE
  target/arm: Enable FEAT_F8F32MM for -cpu max
  target/arm: Implement FMMLA (FP8 to FP16) for AdvSIMD
  target/arm: Implement FMMLA (FP8 to FP16) for SVE
  target/arm: Enable FEAT_F8F16MM for -cpu max

 target/arm/cpu-features.h        |  83 +++
 target/arm/helper-fp8.h          |  14 +
 target/arm/tcg/helper-defs.h     |   6 +
 target/arm/tcg/helper-fp8-defs.h |  40 ++
 target/arm/tcg/helper-sme-defs.h |   2 +-
 target/arm/tcg/translate-a64.h   |   1 +
 target/arm/tcg/translate.h       |   1 +
 linux-user/aarch64/elfload.c     |  13 +
 target/arm/cpu.c                 |  20 +-
 target/arm/tcg/cpu64.c           |  16 +
 target/arm/tcg/fp8_helper.c      | 858 +++++++++++++++++++++++++++++++
 target/arm/tcg/sme_helper.c      |   2 +-
 target/arm/tcg/translate-a64.c   | 160 ++++++
 target/arm/tcg/translate-sme.c   |  71 ++-
 target/arm/tcg/translate-sve.c   | 233 +++++++++
 target/arm/tcg/vec_helper.c      |  66 +++
 docs/system/arm/emulation.rst    |  11 +
 target/arm/tcg/a64.decode        |  39 ++
 target/arm/tcg/meson.build       |   1 +
 target/arm/tcg/sme.decode        |  25 +-
 target/arm/tcg/sve.decode        |  48 +-
 21 files changed, 1696 insertions(+), 14 deletions(-)
 create mode 100644 target/arm/helper-fp8.h
 create mode 100644 target/arm/tcg/helper-fp8-defs.h
 create mode 100644 target/arm/tcg/fp8_helper.c

-- 
2.43.0



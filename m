Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF27CD5BA4
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 12:30:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ2XM-00012W-J9; Thu, 21 May 2026 08:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ2We-0000xo-3u
 for qemu-devel@nongnu.org; Thu, 21 May 2026 08:29:23 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ2Wc-0001cI-JI
 for qemu-devel@nongnu.org; Thu, 21 May 2026 08:29:19 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48ff4f8ef0dso66384965e9.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 05:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779366556; x=1779971356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tj6Co7n4k9aSG9BmeRnqyz+yHY6OpmRBVFVuM2qxVjY=;
 b=ySdl1ZspylpRdYi3sbhGr+mUXH6hvvGjJnRuv6boPaBhINmUd5XYwTYXr0oxtpHKrJ
 U6U1+wkweBDpARi1z6bsv0Z5rpVHPjGJu5r5ChuBav5K7HuEKr2H3hmrxuv4CVI7BiZO
 VcDLatiIPiRCFEs2g5HxvK2A+48b49Y87Eo1lJLTq2rEi155EaWdSDgrqJgoIpfLWPdT
 B2zHiORlErkz3soYGKeSj4J1BZiKhlbs3beRFJdHsSUYANgvouPy4sSeT48H4UqrpxbW
 /13Rt20U+hc3sNxj2mO2EY8J9XGqdg+lTFSdneHDGjPt8Bf8EmI027GBss7fWuiu10DR
 IF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779366556; x=1779971356;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tj6Co7n4k9aSG9BmeRnqyz+yHY6OpmRBVFVuM2qxVjY=;
 b=KIrtlHSAtpGAl0Yu44NnZP+OY9asPI6LZZFcK21xaat3NMvgrifipf2hp9RHIugFWk
 2L+TEUfnmdT3ieafGzCVDAfRsswYwvB95eBGD3mZ2xiSmA0Ib2+GXEuVtwrCoVEQEJQk
 z7OPkl65HcEAtNw499MEUqMfxc1FJIvBDVJgGcAKMCHqcFtNF7JsnWdPTgncwD7aDPJs
 a3duekbVRADiUrQF3VWrl909O2+CmjfotRAoP9yoSZQfkHz4FzyD0X2sS4DtAEt7EX7G
 l+nuKbq5AEQ5pwD8VWVNBB1XuGdahObqd3caeGtspYWHtjxIrMgaosBqv3QmYl7Agor2
 oyHQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+x3GFDYLjIhfXEzZAK9/TOXBVOHfSepIo5SmyFEAw0lHT67db8WLEuEmLjMryibsmyNfcG/Ikw6P66@nongnu.org
X-Gm-Message-State: AOJu0YzIdxAI3nZF5UtUumjDrn7ucs+ySempghzoij7goFem/3ZqLkKi
 cszN0EHmXcpXeW/pq5J1sucBWh4sYdzjLA7Rqpvv3sQYngxHB02gTLha4rhV1sDi0d4=
X-Gm-Gg: Acq92OGpv8Yeo2gCCqE6i+BAiySbdPm/7u0i2xYEYMxReeaGWYO2QOprkltTnwt7FC0
 quN0zuATnpV/XmrnOhaInyyOKVO6cnct7h7ZjeERx4O+CbdgWbRzuoH3gj7q/mgh1xFqmbkttwd
 NcAbXRu/iSe9vvTKLVRzvHAH4Wcx5FTonm1ZbSJoQc7Jt/3lzipz4LyWca2RTAWG3bq9ruNVJbu
 bOvIYJfE0sWqlQ8ckIsK0GdHw0xgrK16H9r8DRvYAXl6LqziNgq4V7cc+qNXsIuX7z71hj5mo2D
 yfGpRstybJ5BX+BKh9v9T4Beiv86kvtV/8cZQW4l7AuuqjD2wpK1DPAUMZZJGaEVHwvd5LtDMcY
 Y3+oKhdmWi0LyOZVqALgYVvpDL8YecLY3EExI0VmtDnaZVRvn50N3EBVBFzRHinxESaeaeQXBNd
 AH1rtUpYfS8lmI3MZTjj5osrI9t/Ty/cbAIvBTpiiApT2XcdleSJQTP3/P8yYExFxKTJvSrPxGi
 WsadOnzyqireF5J6SWQDU3Q0eBnyY3mYsTGjrJ2dA==
X-Received: by 2002:a05:600d:10:b0:48e:526e:101a with SMTP id
 5b1f17b1804b1-4903606b81emr33861035e9.12.1779366556052; 
 Thu, 21 May 2026 05:29:16 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49035c72c78sm22054245e9.3.2026.05.21.05.29.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 05:29:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH 0/3] target/arm: Fix some FEAT_AFP corner cases
Date: Thu, 21 May 2026 13:29:10 +0100
Message-ID: <20260521122913.1565011-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

There are a few corner cases where when we implemented FEAT_AFP we
didn't update the instructions to get the FPCR.AH = 1 handling right:
 * SVE2 FMAXP and FMINP need to do the AH=1 style max/min
 * SVE FCVTLT to halfprec needs to use the F16 FPCR
 * FLOGB needs to report when it consumed a denormal

This patchset implements fixes for these.

thanks
-- PMM

Peter Maydell (3):
  target/arm: SVE2 FMAXP, FMINP must honour AH=1
  target/arm: Use FPST_A64_F16 for SVE FCVTLT_hs
  target/arm: Set correct fp flags for FLOGB when FPCR.AH = 1

 target/arm/tcg/helper-sve-defs.h | 14 ++++++++++++++
 target/arm/tcg/sve_helper.c      | 11 +++++++++++
 target/arm/tcg/translate-sve.c   |  6 +++---
 3 files changed, 28 insertions(+), 3 deletions(-)

-- 
2.43.0



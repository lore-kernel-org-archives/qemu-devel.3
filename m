Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 299ABC5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 08:10:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMMiB-0000fM-M4; Tue, 03 Jun 2025 04:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMi9-0000e2-Vu
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:09:30 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMi8-0005S1-1d
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:09:29 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a503d9ef59so1770256f8f.3
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 01:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748938166; x=1749542966; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PjImWFsY7byB/Cp7G2obzVIteKPKqcQa8suCMTRTKD0=;
 b=xC4sah0XgpTSoYH0BK+jbKRqOQRjfMLDgWR8yZ5Qre7q8ttbR7lr83S7eK0Gj3Iblu
 4kCsrJBV7Xg6iekSveCosGNiI718KPBCVWmJ8BVAjhGBQjnzHbyYDusxDNwhVwFgBlS5
 7a7WLkFsn1sCNhkhLyIAVlrBuUPPFb2vTaKOX8Ws1eirJKCHOVQVuX4SPdIk4Loarwnt
 FaLFkOtlYa4U37F/dbt5m1aM7iRLFhFY6ZoAUYvicPc/UvR0im565/Er5zzxg6r1n4wB
 /e6ImuFnCZgk766fE941JUmFJ0REcA6oqu7Z7kdBkX5zKoqBpLebd/1sTRyuOF5/omGg
 eRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748938166; x=1749542966;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PjImWFsY7byB/Cp7G2obzVIteKPKqcQa8suCMTRTKD0=;
 b=aCosYNBxhNFWNPy3nxwoAfiFBPU3PP/nrl02EUIDPRnbWhF1ZhmFFjMYFGHuOgtJXM
 08UwL6AjnUfulW8Sh2vwRNC5dp40LzvRVpehgYDCdMSNx4DwhxEZez7ECCs7hWWR8qBE
 2Kny/mIqGi4LAhF9oPaNMuhRo1odTnLIW/cCz+ehr2eKhhTcY9glhg5Z3s45suf89BA7
 PvBxaZ1/4NMKcfOXr3ua24pjRvVkvXONYUX2lrSoIyJ/8z8k9EBea6fD0MsejulnVg5M
 OT5dRbRPVWGWVrFWC+UQEgCKkmUia1eNvA3cx94BTzv6WYqAFqM5syynVjdHKw268S71
 LHkA==
X-Gm-Message-State: AOJu0YwKz31X42l3su+pRQzO3S3zNlWw7ukAeBB4s6orvx7JyDirwC0e
 w/GjGjYcB6x845VOSt3hP1xrEWPgctsRi+0PAZB/1vqZvm22/ZEfMwudvJbeH2R1LVkSNFyBBYW
 Aw8UJzJA=
X-Gm-Gg: ASbGncuBPqOvNXoXfq/32IodBNdQOQkDvOQwH8qByyiOlblljYhxYz9Kmt5evIsrV2r
 YmrZJyGQugHfmZbmxrcTBzXRmi1s9yj4w75/rCilqV7M342CzDktBiENwv1Kab5L7GPdZx1L4Ua
 Im+xt61z2CbtBWcFNIIHHRI5USPzYo4lsWFeletFDc8MtaNx9syDpcHKv0Kxa/D1TPH2zpbH2aM
 SvLrZSHO648T30EbG9GuH7rxTBtwz2rGjXKzBHPyxHfCqEQJ2norpfMoIvzQnsUuIrbot9AiW6p
 /LXvP4XAU9Kb4CvWQh3RJO4pB5e4Uogn75qmXQ8kWlgDOxijLeetmcxRmAeEvqXmLPhFgvvTP0w
 VayyiwcYQy/6J
X-Google-Smtp-Source: AGHT+IFTTInNHuwU0e545JcCoH0nykPtfhnX7SUSiU2HU5Jhy69WJKmrHVJiDrnql9lwCed5EmffBQ==
X-Received: by 2002:a05:6000:2888:b0:3a4:ec23:dba5 with SMTP id
 ffacd0b85a97d-3a4fe160cfamr8879657f8f.5.1748938166059; 
 Tue, 03 Jun 2025 01:09:26 -0700 (PDT)
Received: from stoup.lan (host-80-41-64-133.as13285.net. [80.41.64.133])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009ff7asm17668852f8f.90.2025.06.03.01.09.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 01:09:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 00/27] tcg/optimize: Track and use known 1's
Date: Tue,  3 Jun 2025 09:08:41 +0100
Message-ID: <20250603080908.559594-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42f.google.com
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

We already track and use known 0's; do the same for 1's.
This actually simplifies some of the logical operations,
where before required checking for a constant value.

Changes for v2:
  - Some simplifications suggested by Paolo.

  - Merge affected bit handling into fold_masks_zosa.
    There's an optimization ordering preference for
      1) constant result
      2) copy result
      3) computed result
    Having fold_affected_mask separate performed 2 before 1.

  - Rearrange the and->extract optimization, because it
    would perform 3 before 1 and 2.


r~


Richard Henderson (27):
  tcg/optimize: Introduce arg_const_val
  tcg/optimize: Add one's mask to TempOptInfo
  tcg/optimize: Introduce fold_masks_zosa
  tcg/optimize: Build and use o_bits in fold_and
  tcg/optimize: Build and use o_bits in fold_andc
  tcg/optimize: Build and use z_bits and o_bits in fold_eqv
  tcg/optimize: Build and use z_bits and o_bits in fold_nand
  tcg/optimize: Build and use z_bits and o_bits in fold_nor
  tcg/optimize: Build and use z_bits and o_bits in fold_not
  tcg/optimize: Build and use one and affected bits in fold_or
  tcg/optimize: Build and use zero, one and affected bits in fold_orc
  tcg/optimize: Build and use o_bits in fold_xor
  tcg/optimize: Build and use o_bits in fold_bswap
  tcg/optimize: Build and use o_bits in fold_deposit
  tcg/optimize: Build and use o_bits in fold_extract
  tcg/optimize: Build and use z_bits and o_bits in fold_extract2
  tcg/optimize: Build and use o_bits in fold_exts
  tcg/optimize: Build and use o_bits in fold_extu
  tcg/optimize: Build and use o_bits in fold_movcond
  tcg/optimize: Build and use o_bits in fold_sextract
  tcg/optimize: Build and use o_bits in fold_shift
  tcg/optimize: Use fold_and in do_constant_folding_cond[12]
  tcg/optimize: Fold and to extract during optimize
  tcg/optimize: Simplify fold_and constant checks
  tcg/optimize: Simplify fold_andc constant checks
  tcg/optimize: Simplify fold_orc constant checks
  tcg/optimize: Simplify fold_eqv constant checks

 tcg/optimize.c | 456 +++++++++++++++++++++++++++++--------------------
 1 file changed, 274 insertions(+), 182 deletions(-)

-- 
2.43.0



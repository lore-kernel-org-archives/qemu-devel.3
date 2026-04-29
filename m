Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD74DFF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wICyw-0002Ra-8I; Wed, 29 Apr 2026 18:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wICyu-0002RR-S9
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:02:08 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wICyp-0006Xl-RK
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:02:08 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-35e576110adso191043a91.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777500122; x=1778104922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KvlfIIN7elL2g+PyflDOk3BmNRsVZC84xtLf+1mvd5w=;
 b=xdXQMpF3UTBpJwtm4sYHgQEq1FSkrgJSbpxsRCTfYHSidfARs/jOlXuJRBhFKTil1c
 Gg1Jk9LcYAVWyPzzh0Jy9yEE4lgrR6ti+E1l+IWAzlEFlsP939usrG/8+L1zklQSe6ml
 yEC99JTmksBXRecK5CyY+38AS6DFI2MgvTNQppQLNRhZw/lYYkq8y3RjhzbyM/bYdu9y
 urRk8toY72XsxvF3xzXq1co2lU1vV7GpU3972icBED46sPKufmnR9w03W0aEhAq5jQmh
 QjwwFrQW2cXXnyERXQOADA1gQWqWO5JswOOX3k6EOYnKIsN5AzPX4SIjr4MSlvkVkY2M
 yAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777500122; x=1778104922;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KvlfIIN7elL2g+PyflDOk3BmNRsVZC84xtLf+1mvd5w=;
 b=R/HRTghjuap2PrEcUajTpBEEpPhidKst1VIthafxxXgUjjBTsY2kT5karrVc2GV0Ay
 WJHSHtMn4cDzzstQshLOBhE2rIvvMMF2L/mr4AdonT8Sy7P3Eagc/PYusqchY1IkaXS5
 UsbG/+M3qiqlH6DL1zE5tmhFPoBySWFpSrj0IwqvivfgSYRRLESVH5gtc15Spvz98UU+
 SCHr7YrJfq+qsHglekHx07QtblwEUIixr0P/KLc1gqF+gYSHm7h0sfSspXjRW46JGaQa
 xPwLgFFi2FSinaU3BeWHp3YxhOy697SiUDdX6XRxjL5zKPxSwYmEWE6YmGtjJC2JjygK
 x5cg==
X-Gm-Message-State: AOJu0YyVWcoT5/oUcHtgyU1DgWkw8XtzAN0OkURKJIrS/pBuDgiE3V5b
 zHp5NvFIifJARHdnNKcsju6m7JkuFVjFBJulaGaWxIpGbIQF6834uhDSyzMVtg/AFQtmDuk10G0
 hnR3sr4s=
X-Gm-Gg: AeBDieu4859zbjITVJ4tztEVinef977Z7rYvRQdxMYM1mpWLfOyPtcvETOtEKwzt6ID
 UqP/OCS5qZDqla6cj3at/kSVEkTKCvWqU3lxtSIAMY8XewvGnQRQaoKzsncjGKJRpzQNI8yj60w
 o8QCIFTBrJHAdydasVskg20Eg4O1pEbW4Gfq9raBXmTmYBMfm7JAkeoAWSk7VDeFq+HYogYM47K
 ygm6n0dxsL5seq4C+iQxNrMkHKrEFnee4sb9fyQjK7bCSIwAHc9q6FnyO37YVLBtaXyJQ0nLs9b
 H2VB00Ep3VnnmIyTcWHWZIetZIVPqcQrPWcy8PsDXD4+CMVvOKjLgrkMCT+5A+vfUac0EJSzKSb
 NA+AGsSH2SYRzAGGNZx0GJt51WVq3h2Y/o4Bnbdf11KMng1eqfhAZwiM2VXYBH30lW4+qwV6cGS
 Dq25ghugboonp0lnmOmTe94F2pA7Hm/3hFUlxcNeux
X-Received: by 2002:a17:90b:4a4f:b0:35d:93c7:e386 with SMTP id
 98e67ed59e1d1-364a1e3141dmr4661959a91.4.1777500121316; 
 Wed, 29 Apr 2026 15:02:01 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b98895ca58sm32162095ad.60.2026.04.29.15.01.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:02:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Subject: [PULL 0/3] tcg patch queue
Date: Thu, 30 Apr 2026 08:01:52 +1000
Message-ID: <20260429220155.24546-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

The following changes since commit 282771e1f9b9b6e0147adf5f9d676325175b1767:

  Merge tag 'pull-riscv-to-apply-20260429-1' of https://github.com/alistair23/qemu into staging (2026-04-29 09:22:51 -0400)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20260430

for you to fetch changes up to cc895e6dcf59a883ad09e27e726057b84431e622:

  tcg: Remove unused tcg_gen_vec_*_tl() API (2026-04-30 07:09:22 +1000)

----------------------------------------------------------------
tcg/aarch64: Replacement of I3XXX names
tcg: Remove unused tcg_gen_vec_*_tl() API

----------------------------------------------------------------
Jim MacArthur (2):
      tcg/aarch64/tcg-target.c.inc: Replacement of I3XXX names
      tcg/aarch64/tcg-target.c.inc: Manual replace of I3310, I3313

Philippe Mathieu-Daudé (1):
      tcg: Remove unused tcg_gen_vec_*_tl() API

 include/tcg/tcg-op-gvec.h    |  24 --
 tcg/aarch64/tcg-target.c.inc | 992 ++++++++++++++++++++++---------------------
 2 files changed, 508 insertions(+), 508 deletions(-)


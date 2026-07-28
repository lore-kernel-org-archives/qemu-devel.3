Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D988C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 13:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woi4y-0003Tz-D5; Tue, 28 Jul 2026 09:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woi4x-0003Tb-Es
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 09:42:43 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woi4v-00082O-NK
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 09:42:43 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-6685001353fso3380316d50.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 06:42:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785246160; cv=none;
 d=google.com; s=arc-20260327;
 b=QGI9hblrj2Ocubt8a9OhjNLc4rNzV8WAwYA2QZLguTxiAQNS73bmuX3PWRYMt4TTZN
 JGCXSMI+pBx9+1XQQBOcjyAKQ2gGT9008JooVo6iF583jlLtclb5VvqtxdV146iyWDLs
 HkcTw/88ykVQoVmes42g8iQPjjbKcdLyuwD7pArH590v/tzkVhnSNtAy+pxWL5DdTII1
 LPCAwRJNKIlNzAgvccUK0fdBqPAkkYRlSY1gIYz+vXhHSGobGXo7e5QUm1jmct7PmQAU
 xDF7HU0IUcQw84qMRjDAjVJvGkq+LaX8ClLcPKs5eTt6FfQwVIwi2m9YZWMmsFopyIPb
 Mthg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SCYe+ZjD2Jng54r68tIvP0VPioDck0U9z+5IT9qUR7w=;
 fh=GRGAhYIRyJLIexm/SQeD/ONQMnKo+TSDqNowgo15cfY=;
 b=DEz42tjf4SjMxUbEIjjTXcxDvwEhah2nQ4VWHGW+tL1soU8Fmj2jDQUK/lPCc/TazK
 1TY2+3J+cvjCi/WoEbMS8TSGOcMtkXtU2CXyGHfqm+psuug9ljYlI0g+LSIKyhYWYEAW
 mLBczpcQfLWDWBTJY2Myn1+r0Wv8SFcJge+4qlWH/LRqE7YSqjUlYbhVmroohKTEBpTd
 uIohxpgRCy/I0G5cqUgLqdLB8fdQXctZe4kYbvXRQpt9wBo2DPZdVu2a00pK6DlCeXhD
 MKfbugPRR5RjHnb2S4ejL5ncBpTgQapVHqRsX1iXZMB39Rc7alsifSOCqNm6alcrck/T
 RU0w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785246160; x=1785850960; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SCYe+ZjD2Jng54r68tIvP0VPioDck0U9z+5IT9qUR7w=;
 b=EUY4VLRnjBBlgJRu4P5vRAaFVXg4vmMdIe7C8+SrTTbW6dOmr1OIqMIQcByBWynUch
 NrgDwdV3CPk8lW3JY5xNYv181VdhUEix9OYduI+aiw0f/HdNqIdMsz7/cy8jnrzca+cc
 g4vbpwiMUmsQMgCMkG6DPgoa501omGEmfO9qjgFIpBIIaktC93fnHkw22Z9ieJmv/uBL
 qgk31j51Z0Agdd4i5uBPApRZSrFMlL0/cq/h/d9F3mNV11apZ0yo4aAycnhTFIMqfSzM
 iDolaAGrshGRej3djKECwvZkQsQ/xye9oiwZO/VRfUudLWisBLc+GsftJZas1SO4wzUN
 3HCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785246160; x=1785850960;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SCYe+ZjD2Jng54r68tIvP0VPioDck0U9z+5IT9qUR7w=;
 b=fBAp9WRnBOybPDF8mPZFd3Kbw214BXqrENH1y7hKejGV/GrztuGu/q3lyWSc/tfbBf
 FgEqsS4YGFPmUDbip0vn3F6OmxMUGLEYCMZAWa8AArmOLAUgfPPgTXVkpZJoXC8IkuEQ
 ODjljfey3uftEiWRKb20raNPxc5uBSQFV62XewkHrOuwtkWpqD/zNsxLSTQbnx287v4q
 Onma5qrT2GdHAHjE3NBa9HrbzC/WAHQBRiILAalMfjjL4XQvPlkRi12CrKSBDPyPR2rR
 +Upyd7Vl4N0EjW1DDEZcEYQyekDuLQnD0RUlmoRl8HEBSXIh6SBwWJwafp3GdQwdgW4V
 Q44A==
X-Gm-Message-State: AOJu0YyesXKByCnD3NvVfVMN/5VyASmdAen21zhP/gxVbwJKjKpZkfzP
 QqdTPgnpduXVUYSCYw7jLCyOBb94NXiR5zsbZY37siKXNiAixaT9ST/6dSIz1G4G2x+HgnQtBt6
 3CKBKhrVXm5XerOVOvsJJYaX0M18/ZZfDBhu3LHa75Q==
X-Gm-Gg: AR+sD108xNsm4vdVyz52SgMo2Af5MqvKL3UGw1N3eosbLb1nArUPzsCXTwzHWAlK+Lf
 3I3mnxSypHbYoxlVfQWPYA4g4l8MHbdH/G+CvnMaYeYLHD5BEINxUyUIT1QQeNgInZ1TBNJqbth
 mDZOOnplqVtWXowmRN/3//nI3FhPzvS/xm1yaEMmFbjjOLNP9ReJP/CFiBeME8wSk4zOWmqKAAE
 bTy5GWoh7sgKv8YcQuRMAdl2D6uvDHLhJ/Moom3lKt8iUYcGMucZmAwZaYakkXagMvZQIPoyN52
 C9rpfYO4JEXxoNyAppLoyEy+A/JJjJLPotHNFPbWcmIz3g==
X-Received: by 2002:a05:690e:418a:b0:668:92ca:f50 with SMTP id
 956f58d0204a3-6690547b235mr781834d50.12.1785246160194; Tue, 28 Jul 2026
 06:42:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260719174905.420725-1-richard.henderson@linaro.org>
 <20260719174905.420725-4-richard.henderson@linaro.org>
In-Reply-To: <20260719174905.420725-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2026 14:42:28 +0100
X-Gm-Features: AUfX_mworB3lQD34Z8Xc0sLWFplkTyGk2qXOLXmLz1QHeqSB8yP0kZZDdcaSnFc
Message-ID: <CAFEAcA89_cs7YQRrJFxhHscryJ+BK54dy6jDNqUK4O35oCTHrg@mail.gmail.com>
Subject: Re: [PATCH 3/6] target/arm: Fix b16b16 feature test for SME2 BFCLAMP, 
 BFMAX, BFMIN
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Sun, 19 Jul 2026 at 18:49, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> These are controlled by FEAT_SVE_B16B16 not FEAT_SME_B16B16.
>
> Cc: qemu-stable@nongnu.org
> Fixes: bc65d2bd1cb ("target/arm: Implement SME2 Multiple and Single SVE Destructive")
> Fixes: 930760eb753 ("target/arm: Implement SME2 Multiple Vectors SVE Destructive")
> Fixes: 8b61eff8e72 ("target/arm: Implement SME2 FCLAMP, SCLAMP, UCLAMP")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Yes, FEAT_SME_B16B16 is for the ZA-targeting insns, and the Z-targeting
insns (even the SME ones) are FEAT_SVE_B16B16.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

I'll try to put this one patch into an arm pullreq for rc3.

thanks
-- PMM


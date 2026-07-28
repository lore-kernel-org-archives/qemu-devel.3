Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE7AC54F4D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wojmD-0006Xy-Rm; Tue, 28 Jul 2026 11:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wojmC-0006Xd-Ge
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:31:28 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wojmB-0001Td-5v
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:31:28 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c1f7666a90bso104423966b.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:31:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785252685; cv=none;
 d=google.com; s=arc-20260327;
 b=gi+SvZ59/MSYtUKnnTm8kVLTRY3BrTd7C/gY83GW/izqFCaecBgjXMx8TFB01ow1cW
 78tivZ6HSV1yQvkYIea2ngW4oUGJbiNfdslYJOKuqYWqeHNZyGVqdqWo6r2ucuaA65VN
 zzfRf5znIJNiE+ZxRGSEliDu00lppcNV366tlbyiUubC6YICXyK9t7uuWYG86EYQ5/dj
 +qTF6/HHaIGVx+gn0562JDfSv8+x7JwBTwc5mKx4g48vvlEnxXUCHfol+RdaHUf/6EVu
 yk5rh2yGjVtnVfHqBOPTiABlzwNK1fhEsBpM3wc5FwFz3N2O2vmp0g66mEkVCGYAhH5/
 u4IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JD5E+y9qy4TbcJnbWAMo8UfKZ6hCsr1Z5zR4NiSyrEA=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=WetxszhxPaaRPp7VYzica3GPXQZ0qWoBXbKR8J5pLZ2NDXoZjE94CFds1w5Dat+cn+
 cM5ohH8XX6ZtOxr69LgztiH3nZuHkzFzyQalrqr7dIwXGtoBFF6aYjPOCGeNmqyP5NGR
 U3j2uhobmR1+yMaDE8pxQ8MhSY1uwwxNTWFjmX96dcx/mKrZPQIJ+hkRk4llvZr70HYk
 aXS2+vdWfpCvRZLMqrfaQ1RUTMyi+xmKT8WiTUxi8EtG6At3yuQGSxPAq4b7tHvmTtMD
 Yu9/05ELZLWubjACWoml63g8Wbo+bWJR+PdyHxxPXFFacjQbTWCD1UVOWAF7e+yHdnNQ
 f/Aw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785252685; x=1785857485; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JD5E+y9qy4TbcJnbWAMo8UfKZ6hCsr1Z5zR4NiSyrEA=;
 b=gCcuN33zxXakyqVkr+mBzzGYXtdBwqiOTbJLhzna/7ItGupxhjVwZkVts/d4Z3h1Id
 FItB+mBTNOZVICTqeSXR5KKrAh+WDEJVZFu9cU5VmupbFQzz2Ptnb3X5cHXDQ2tyPuWw
 SGTbQZWhM9mfAGZOKPdzWCsF9XAOcEbNN56D2WpZ1YJfSDEO2QRS47QNttpb+QZCXvMh
 4hpec1ETokLTkvpcJNAiWJMSUePZMyd9MRR6EZ8703bBnDHdfApcKPpL/8RYW84vjfAp
 Hd1v6xyc+W5mMFNQq+JY3UHRGaf/u14o3skCZlf7KRneO3qYGF2Rv8ISeUwHzYBjola8
 0SlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785252685; x=1785857485;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JD5E+y9qy4TbcJnbWAMo8UfKZ6hCsr1Z5zR4NiSyrEA=;
 b=JuiuzSxUI9wau3u0QlI4wSbEnEhriE+5B0kQg6wJuU1BofFGkMTh82nodt41I0ecwr
 0U+rs1nvK1MnXm8zMpFsHHclWrZC1wepGr1PbMC9TDJYqgh8PlPkUguHx6fkUXgzmYhm
 4rn4gUcCjMsUVkSBcPE6Ava+yeskdqMyVhoe1sfIo4SjlGgAKczOleh/nrqJG3HrPtAe
 DPXfwe/IaIX/02qSbIioVnlK9pDeA24/RqJDujNPZrZR/ZcJkl05A/tX1WqE+22rfS8z
 d2yGuRX/PtFUMO3g3FD5DSTp4ml8SwaTOhwEeJSHBfkuTAePA0qfJm28evALwuUmg16I
 uzEQ==
X-Gm-Message-State: AOJu0Yy3CMeRj9dmJsqF987b6siPop+UqqXQqF62gnYNJ71vpldEepSD
 L/H5Rp/5eq01oOFZxdyCy/gUi5SwlhaOqTiQ2dFRrC2P8anMQFNWnGrw3YJJXbM3bsjnpspB2i0
 KzSWeEsL18SBDU//V/9hfIEKSoYaxvcYuiFRkxbVq/UAgsbmBSfne
X-Gm-Gg: AR+sD11ubGIjQfiX9nXUtkBwCCtSZKViwc22FNA1+PcyIS2OMVAwAce/UuBa0/NyBH/
 c3GIr0BuF2zM7Dx7QHfQccOvvIOy4RkYOyNdY9mRwTekNnWAoWEfhffvisyxWS4ANbFA9/p6ogn
 RoD0O8MVTmKM6/W5GRNlJi4fkOteFJLnb2C/shbWAz4VTbUuS5trosxPUQD1+nsPNsyTiMlHV1x
 ow5rNaacpABv/7lWligGxNb9ydJ6pM2YkJphG0R3kfFKntbsBY2M3gHk9I63qK4Uouv3O62UbkZ
 D4LJHXbEUCAS3KT7OArkH93Vb/UkaVSfv79mHm4yImFGpw==
X-Received: by 2002:a05:6938:a08f:10b0:c1c:5aa1:de57 with SMTP id
 a640c23a62f3a-c1f71eaf157mr108025566b.13.1785252685212; Tue, 28 Jul 2026
 08:31:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260721184656.530230-1-richard.henderson@linaro.org>
 <20260721184656.530230-9-richard.henderson@linaro.org>
In-Reply-To: <20260721184656.530230-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2026 16:31:12 +0100
X-Gm-Features: AUfX_mx3mE50vKY_wiLQkC_DqmCg1Ew-KEdZvyc2ywP26KtO3g7O2tsJmbLTjJU
Message-ID: <CAFEAcA97=b1q86sbxe-ztLZnQrgw9ke2z1Qo2f32Q+5hKm+ffQ@mail.gmail.com>
Subject: Re: [PATCH 08/20] target/arm: Implement SME BFMUL
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x630.google.com
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

On Tue, 21 Jul 2026 at 19:49, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sme.c |  4 ++++
>  target/arm/tcg/sme.decode      | 24 ++++++++++++++++++++----
>  2 files changed, 24 insertions(+), 4 deletions(-)



Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


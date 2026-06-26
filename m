Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0004CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 09:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd2wP-0003n4-FD; Fri, 26 Jun 2026 05:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd2wO-0003mn-3O
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 05:33:40 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd2wM-0001uU-O4
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 05:33:39 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-664801de06aso816313d50.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 02:33:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782466417; cv=none;
 d=google.com; s=arc-20260327;
 b=c7Gy5x9GeoYrKI6ItRCIS7ae6e+b50bf37bRQHwSxcrJzSLCKnt+2aXEq5xTXUXPv0
 kD6H89IMDrw55jC1TvN74OB+sFO1iD56SBt+RxBin2OdP7zA1jxavYMySzJvIBLTxNPB
 0KeqSY50B8aTFRq/hf/NpK34qzYnj0om8vsnoMxy5s0GujNbiQlKumqT0h6XlMQICymq
 tTVrD4aF073DJraxD3XiSWawn0ROux0VcYR2OK8M9cgRhWC3CxQwDEjjhQuoCkWo4NdT
 M07T/8jlFljm0JxDLLw2ffJuKQUks+yOHM1dfINmfC+ChAuI3DVcb6LaW4pCnyQRcq7e
 bdgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+byf6u883ONY0gYqOfy0J0XXrdqQIC6C5SXphvAqWz0=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=giorlMnljUmFuqDFnCEoqgjuC4mWBe90CgJZF+Y9rTz3ItajE/VQg/AIVgc95otrri
 kbnkv8lBw0r/MD7Y3LCrt26CVhm4P559ry1FOwxfFhlQZ/CoE2GqyJL0thRSmHwsmaHn
 +hw5VtsRkCyDjIVn+Z9jLS7KH/xodN8LkR+mvx1nobH30PBKiStQqNtWBdUpCQByw/Jt
 8Itq8DTLIbXuUiXeq4wRF2oSTorqFXdrQaR0Z9/nJcNe6HlXUcN7OzWtY7proORD9RnO
 HF03f9HslUktU9P25O+ttYQjsNaXud6JeFaVkbgaGaiB/l6VeXjUmbR3nTFssUknszLh
 9Zgg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782466417; x=1783071217; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+byf6u883ONY0gYqOfy0J0XXrdqQIC6C5SXphvAqWz0=;
 b=hei5D2V/mSNY+Jl9fka638T4RcUtwr/7Co9xmgLk/AUONQIU4ld9mcUvOoNA6ejDSb
 EgdSdkYN2S+jV4XIhT1K5wJoL41d0GUJ5HC92ki/ur5fkfA3a/oeV/uQ/T38eqHHhZMR
 bWKfMTE/Y1Dkn9Bh3aGjT8VQQNcV/9BlOCPIBrZtPhNoYb6WCqZ+MnxOPsTyW96BDmi+
 e2Jwz7KS4CUjhxWS1RcuqSSZmglfigPBnqu2ZEZot9ZUv1TG+J68FeIfIWidFduy5bCo
 s4jRRGVHKDoJcWnABNMPRKGdaksB+hhO/rgLyhOBDpT24MmmWuARjDctw43dh2ZP9DGd
 RN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782466417; x=1783071217;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+byf6u883ONY0gYqOfy0J0XXrdqQIC6C5SXphvAqWz0=;
 b=V4rKpScgeu6y0TTm2p0521rf0qnCC70bKa9fG35FRgcv1iyPhe06z85KKGX5EMmztF
 JiA3sZDIJ2bxeKRK3mSt1KGhpHPFcGqUMLDyKC0v9bcnp4ML0z3Rskf7w+uhcS+gZA8E
 rhTX7Wb6/N0lfLLsOrscezS3lIzZO1A2xXwE9dRhcM3qaNQ7DwTNpgNXrbZyUThRKJQh
 wJexFiG4+0EyORDLmfR8xsMgsz+btX9Dvook2C2Ti4Oq5OsVbyB5/pO22+KO1g3esgz6
 snmQSKclIzxMghN9j/p7EFq+p03hvW/gGhwFCxHghvr/KpXM/Y1127y13CO9EVsweKSN
 iImQ==
X-Gm-Message-State: AOJu0YxVcLPoBqD0M4dSspohgIOVG6UGDogoM3nSCb/19VZ0ThYia+gI
 cLK6O17qeN2WDuQz5mTzEY3jKJlZkl+Lw16jzd5ZKBVha1PwfdTleHIXnMRDMiqEm6DeVokmfaO
 OFTRrF/GSxqR8IvoCA44RPjFRygZQpOkOVpyiupWmRQ==
X-Gm-Gg: AfdE7cnxlPpDqZ0Y1JoaeIf+c+mrJHy3DI1FqrH/ZKfEyZxA/pq/JIHCU/KAhB9oBuJ
 z1b44BjFlymZJ599r/oldx9XtsqsANwQt6KHw6IGHzd3D26SuSbw02ehU4pmMTJNT0jHtMwhQvy
 BsNknVFdCLlBIafgx/gpL7PBvJLfHSqCCwoAD9JVcgoEKg8JsVtztDDhGCMnF/YqSyKWCEWXV+e
 utmUx7l4libqmQF59YFWI7i9E8dkw/ReGUllCmOPP6148F4g6WNEBYjY6Ulu641zcQft1UmTY03
 Yjb/Y822sCkp6Q08yikYOHMxMqVKaVeV1Fnhy8kAFnssjJFFNts4L9On
X-Received: by 2002:a05:690e:4810:b0:662:b4ae:f382 with SMTP id
 956f58d0204a3-66487ea7608mr3628207d50.61.1782466417205; Fri, 26 Jun 2026
 02:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260625015159.719300-1-richard.henderson@linaro.org>
In-Reply-To: <20260625015159.719300-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2026 10:33:24 +0100
X-Gm-Features: AVVi8CcsmRKU4YkWZKfY-dNAxCtRUBrFbLyyvU0un9qjepoDUeF2K38Eln39AUc
Message-ID: <CAFEAcA9Kz4TxX5q59Kj7YRNPf+mpZ_hXfeCfVq2_wDwxeZz7gA@mail.gmail.com>
Subject: Re: [PATCH 00/10] target/arm: Implement FEAT_SME_F8F16
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Thu, 25 Jun 2026 at 02:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Another minor feature working toward SME2.2.
>
> r~
>
> Richard Henderson (10):
>   target/arm: Enable FADD/FSUB (half-precision) with FEAT_SME_F8F16
>   target/arm: Rename SME FMLAL/FMLSL patterns
>   target/arm: Implement FMLAL (multiple, multiple and single, FP8 to
>     FP16)
>   target/arm: Implement FMLAL (multiple and indexed, FP8 to FP16)
>   target/arm: Implement FDOT (multiple, multiple and single, FP8 to
>     FP16)
>   target/arm: Implement DOT (multiple and indexed, FP8 to FP16)
>   target/arm: Implement FMOPA (widening, 2-way, FP8 to FP16)
>   target/arm: Rename FVDOT pattern
>   target/arm: Implement FVDOT (FP8 to FP16)
>   target/arm: Enable FEAT_SME_F8F16 for -cpu max

If you agree with my suggested tweaks for patches 1, 6, 9,
I can take this into target-arm.next and adjust it there.
The only one that isn't totally obvious is the patch 9 one.

-- PMM


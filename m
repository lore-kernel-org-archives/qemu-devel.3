Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC0DECD6E0
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 19:47:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqGAn-0006oh-Ko; Wed, 11 Feb 2026 14:46:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqGAj-0006nt-Oa
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 14:46:49 -0500
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqGAg-0001CT-Uy
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 14:46:48 -0500
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-64ae5f0777dso2481311d50.3
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 11:46:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770839206; cv=none;
 d=google.com; s=arc-20240605;
 b=WM92/lcMpzJnyVAvYI/exoMVhRJo0NPc1st/C+M5q0lyiD8xo5merNRpCDY7PUkAmE
 xBe4Mj1IYXx58gITUyrwo6ABwfCd4nMvb7O1/JQSaQsb/ncnd0HhWcAnWVNaI9+krzbq
 y+cbjfIUhOJAWV77XtqrkM8meGINvkP7Xv/Dg6S6N933ZjvePpRvd8YAzK6CTBqFhCtD
 pVr6YjOWgbg2WEYHM8gQsBxuI36YaWmfQeihuiW97FrZxXiRD9zM1ihcC2nvTNg+OAzu
 w9Pq5iFrWCYRMVm0ykZiLgmIk2QwwmjUJDa5G16D/RtQE7cSdKVj2Nm6fia6y1f/uCen
 LUlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=CqCyFtPMiIAFo7P748VNObDS68gmsLHzRlM2pnKRLPo=;
 fh=PnYt+qEB9tAfMKoqBm2xjKOFpYyFFGPudh5cVIoieJM=;
 b=LZoQ70YzrO07zKswjdzwvaGr8mp/KLt8X9BifQ+eYmYw9TjGlwYw4OjAWBk4lLE/GL
 ztgwdByOwvRgPiTcHCxvxijOZ0WTeUHTZAI/KC5Exb2ThFUk8mSPMjeTwv8LLMLL2DuW
 eZzRzknqCaBqy6/Fk/lPgsX7wde1PHpZjbbf4s61UcvkAEebC/JWcQMIfLuSrt3wO0We
 XV3mCikhHAosrtaHeHtOZLMCp+xy9bGYwJvDQRNmyLN6y6FylnMgB7rw4z6boedGCL12
 +BL+9sn69xhB3EDqJoNsZ2y5LTX4FNx3cKUm4Ay0JDyjr7ugeW/BO4LpL277ei+S2oZu
 rqKw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770839206; x=1771444006; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CqCyFtPMiIAFo7P748VNObDS68gmsLHzRlM2pnKRLPo=;
 b=cg3pGoj0nnTbH6/00+Xup8OuDUgS8Nmxjkx5fiDUFzPdr28fZq6jooUdisPgmYr/21
 qBj0ctXlx/YwlpMP+5H33x06rSL36Rn7o7/wcbGymCUBcMxr3XrywwZKT1YWY32QHzfR
 qnnMZmKr0xA9s4jAAzwTc6LWTFVEmadSvgMWUrwFC53IXEMKzN/QNe3to8qWYEtbh93t
 Bd7e/kxJznX4nCaphuVqsc9Yqv41iScBl42SQpDh9iquI727I5eyofNZ7BZE1mEXYkhh
 WnpPY8bg6CBw/FP/Uuzrp6AyNOtaAfDNn1dn4z6F+gsp5zDIOGkvrJWSTaBrnv1OJVo0
 PHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770839206; x=1771444006;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CqCyFtPMiIAFo7P748VNObDS68gmsLHzRlM2pnKRLPo=;
 b=NHltwX03WD5Eq0FjhVsoL7A+T7HpyN6ipbPiCjP9e1SEmpJ313Bm9DztF+BUhrfsJR
 VGCB1l6OZvMDqMj+QKfzBysEbhE5ndTQjAGWxbQZBZMf9HkAsDRwz2oyZ7IW5HHlYbga
 fYJHwPbwCX2FOQ67WwZRPC9CfyXftAoe4kyDM2G3ysYK/4Wcl+f94RanZFSBqTMly9wG
 kQ34JIiE4PRV5uUdWtGdR3AwlFl7bSnWEJEJlKvdJ7dR+vJTF6NuKM8c4o2lSQ5IboaQ
 HJZT7nP3PmtCO+j4MaByFMtzDTji9dLKl0zUtBqdpgi3edqtYQJp5UhRns3GAumYjXum
 GhpQ==
X-Gm-Message-State: AOJu0YzSRlcqDb/cUCLcjrjBXhNXy/XtJ4Fkovdccz7y+eSlFb+Gr2Hh
 JNo4hBN05G1cR9ZOdkiJxZqV/0VNGBSBR1Sdb3UQdC2LfdnUE4gEfXPbfauEuT6Kc+DFH7s/zi0
 Ldi3GGNL+luF2dU1Cf4msrar5EiM7kOqNOWn0U+tMu4qwwXxiiYc/
X-Gm-Gg: AZuq6aLee4pkh/T6CZUBBflEiACDdhkfEqrSZwJd2/NLgCksolYwhUmrQR6CbL7s60t
 b8Jyt3mELSGobOlO+e1YFd7HoEe++uJIhBWYvYCtdIysRXjXR8alNUZay+Jv1RJcATAT+tgyrb8
 Pb7ETSTHoVvdTdRgsHES09s1XhGxRqZM6QpqSy8nqq4iH52/K4bl2XMC3tl1wKVit9UZOcpO0ZO
 EkTq7r0FcOJugAbuz/8aOALFhRA60cgqS9JdyFQb7TIumSVONFsDg4QHZc9QF1OVxHWp7mPWx22
 f6HEhxjNPMbgpsZ1gZg/OoVhtYhs0X05tBUPcozyI4dAr0wK71zjS9gVrqP2qAeH+IQ=
X-Received: by 2002:a05:690c:9:b0:795:1e5b:f72 with SMTP id
 00721157ae682-7973769e7aamr12673177b3.63.1770839205438; Wed, 11 Feb 2026
 11:46:45 -0800 (PST)
MIME-Version: 1.0
References: <20260210135206.229528-1-peter.maydell@linaro.org>
In-Reply-To: <20260210135206.229528-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Feb 2026 19:46:34 +0000
X-Gm-Features: AZwV_QjQqXtAbnYNUh1UnCRd8zwnzcxNhcn5ehx7-Brv-I7kR0fKuE-fBiT8xUg
Message-ID: <CAFEAcA9ctRKF=GO9vY9Mx5xjmaBm3FGq_x7e8Yt26ez2Lc-b6Q@mail.gmail.com>
Subject: Re: [PULL 00/26] target-arm queue
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Tue, 10 Feb 2026 at 13:52, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The following changes since commit 0b91040d23dc8820724a60c811223b777f3bc6b7:
>
>   Merge tag 'pull-loongarch-20260210' of https://github.com/gaosong715/qemu into staging (2026-02-10 09:12:38 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260210
>
> for you to fetch changes up to a2834b853d9e0f3e193671ab1f20b27329a02ece:
>
>   target/arm: implement FEAT_E2H0 (2026-02-10 12:52:39 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * Add whpx accelerator support for the virt board
>  * Implement FEAT_E2H0
>  * Implement WFE, SEV and SEVONPEND for Cortex-M
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM


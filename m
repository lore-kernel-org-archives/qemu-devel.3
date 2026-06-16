Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87418CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 13:40:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZU17-0007W4-Gy; Tue, 16 Jun 2026 09:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZU15-0007Ut-Ea
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 09:39:48 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZU12-0000qJ-N0
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 09:39:47 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-660323f7b27so4369776d50.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 06:39:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781617183; cv=none;
 d=google.com; s=arc-20240605;
 b=LuGe8ifigDky+R3tDfXi+BYWmZn199Pv+3T3tqFrXldpwz/TgcSaN4AZPeK2LYPp/S
 bupTAg/kpPhEJ8bMj8SCPq6yUdrVJU465CGUBqLR+mCEsRA0XgSprc1H4yHTP7uN75uV
 KZpbvAD0Ao+3J717TbztwGjsq2yMf5DJIPkFeMRs69iE4UwGegzUeiNT/XJLabZoFyBs
 k1i7AVLM8O/J70eHkYuhsm/a0R9WwE9Lj6gafWYNWv2hCfNMIctuK2e3CSmwiXyCYS3i
 3gSJL0dYaAFkxDu5oqzxBgPx/+A90xR06uOSqaOoCwKMYbYzSLXJ2HzSIycj5qBbtss8
 9doA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GiaeQrlhz4ymFke226tz2gQsOwBB2u4Ruin01X1keuM=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=YHf43P8CRK9tVQZbsLUAVr8tTI+QzGVPGWzp9nU529Ey9qZg0Azfh6ZXbIT7DOeIIF
 31NhcVACYfol5a3n6+XcpFF30weogYqCf/LyiabdJWwjMoBLfku14jKIXo+GAahFOcFg
 4VWdAMplJ4n2LDSonf3c3cVDqRs18CSiXgn6vQN9pD58cv5zUghs/MnuvUYBzxSmimN9
 qR7ZzHQSD/ETFPPSaDknwrkqJASHtt/vYy1sLguxPSiWU6qJApr01E69Ta07v/2WMSPw
 73e7bxyYre2r/2zCPS1Y2rn4Ojsn7zK07bW7JyEo+1dTfx/Hn4CEwn6gu0vpMKBFNVCI
 EM1Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781617183; x=1782221983; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GiaeQrlhz4ymFke226tz2gQsOwBB2u4Ruin01X1keuM=;
 b=l2A6nt2pTHCM1MlYGEwZMWmGSjFcFMhFnk1ZYyY7Rqc5XL3z1aFKyQJOaAKrV1TO9H
 sat0YiaG87Y/yGdH4oyMlB9IuadY37deYbFithW5vfnmtLL5VsTcQlaH5WVh3/QTD22x
 2bXHiSLcz7c/Er97cnlr0HhWJHoxKbg5pFgy6+LlVT0j5SYb5ySEhaKsFJUYetFubXwg
 9zLHGP3bongeGCh1ykNtC38l9ENwyhQvW/0PKwuBY50YuQ9TXmBbIYTE8ZWDsNoZTrVN
 kRMh0E+WS+VeAc74Ghoj06MbC3Za5x94vzFfP57cNubfH8IbFW1iG5OmSvMYPD+TW+u8
 bs5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781617183; x=1782221983;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GiaeQrlhz4ymFke226tz2gQsOwBB2u4Ruin01X1keuM=;
 b=Yd0xnh2IYLWx0G+Ns7zuro8+mXfgYXkpfWAuZooWEIaxPen2NNXTQ7t95Ho6dKo4YQ
 IWeDHPnMXAxkJ1EMyhxwnlkOb4cC5NmukwqaK6GcMmfrA3Ul/4Xs/OVtKYBwf4pKtzAz
 DOX84S9XfS6dXB0etyCsuSuia8LegtnTUc8CieuaFCEgKDxHOjUqgmVj96YBdwUCvUTg
 N2NuX1bTvqS4W7odY2ZEPtW6MVMfAP+kDMXFwlUHtfStKE+mTjgJmzZH1XR4XX9fh+7d
 U6E40VwS43RnlcCpEV+ssca3T4Sj9EG31Me49e4jaI8XumNQlDBzbV3sgIc8l903w0I3
 TzyQ==
X-Gm-Message-State: AOJu0YyCxt8S+1y2GFg49Vxjb7s89MmCvMzyGWoQF5pabmWu9qHJj9zy
 c/PWCaXT1QXo/5XbSv07dmHJusCHBTdGLGox6XZRGMAV3Djcy1Hz4WkE8SPH5PEdl+xgy8JP3ic
 dZ7Rb6PO9tW9F4c81BoQ7WG8Dk4VgpBu756pmDnOf9w==
X-Gm-Gg: AfdE7ckETDpgiGmKECQ7SNTV5b73EBRwCd5che1FyapQheioEpLwL5hXnMl1GBCEmr5
 y8Qs0KBNisMKD9YEBuQJSkoruPaNiUh1S/wUmS64BIthihvHXa7R/009vIlKYnD9fmM1OpF8pNs
 x7wDT3Hue+mxW3gH2YOMJBLkfmOKWced6tFw1y39Y847KccfVVVDTwXOCylfqB1xjwGE0PO7MTo
 Lskh7V4T8pAQyJTyrmxvhxgD4vWMHbOIBWbayEK29vNRg+5DJ5XAepNmu7/5n0aU0CUbgifFnWa
 BeADkET9d+VVuUIdvRxYx6iTOwake4pNwIImt5L1si4WBx7bllpnnd6PdN/6QXNN8mY=
X-Received: by 2002:a05:690e:d8e:b0:662:c136:d250 with SMTP id
 956f58d0204a3-662c136e08amr1113154d50.45.1781617182637; Tue, 16 Jun 2026
 06:39:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260604234852.573178-1-richard.henderson@linaro.org>
 <20260604234852.573178-22-richard.henderson@linaro.org>
In-Reply-To: <20260604234852.573178-22-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 14:39:28 +0100
X-Gm-Features: AVVi8CeiBqjbG3vHASB6Uoa1B_DNTbkZe8ygZlTUrILkzoS0-4nwEEfHo7dvjbU
Message-ID: <CAFEAcA-UjZnG2KW3xUACgho=78vu2OGERrZ2zvsCySPQKRrq5w@mail.gmail.com>
Subject: Re: [PATCH 21/25] target/arm: Implement COMPACT for byte/halfword
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Fri, 5 Jun 2026 at 00:49, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-sve-defs.h |  2 ++
>  target/arm/tcg/sve_helper.c      |  2 ++
>  target/arm/tcg/translate-sve.c   | 22 +++++++++++++++++-----
>  target/arm/tcg/sve.decode        |  1 -
>  4 files changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/target/arm/tcg/helper-sve-defs.h b/target/arm/tcg/helper-sve-defs.h
> index 75c0fc919d..11342e1e59 100644
> --- a/target/arm/tcg/helper-sve-defs.h
> +++ b/target/arm/tcg/helper-sve-defs.h
> @@ -733,6 +733,8 @@ DEF_HELPER_FLAGS_4(sve_trn_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_4(sve_trn_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_4(sve2_trn_q, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
>
> +DEF_HELPER_FLAGS_4(sve2p2_compact_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_4(sve2p2_compact_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_4(sve_compact_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_4(sve_compact_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)

Maybe we don't need the 2p2 suffix in the helper function name?
There's no "not-sve2p2 byte/halfword compact" operation we need
it to contrast with.

Anyway,
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


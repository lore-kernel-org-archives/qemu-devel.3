Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440CCCD6E49
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 13:48:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSb5J-0008Hn-Hu; Thu, 28 May 2026 09:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSb5G-0008HT-4i
 for qemu-devel@nongnu.org; Thu, 28 May 2026 09:47:39 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSb5E-0002bk-J0
 for qemu-devel@nongnu.org; Thu, 28 May 2026 09:47:37 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-7dc6d090381so8361917b3.2
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 06:47:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779976055; cv=none;
 d=google.com; s=arc-20240605;
 b=kDTp/smx7Clw1bDkUDobpWyOj9s6S0InF+Rhf7DGQ1NNp6K+oyZrHTO8UPiXI9vIPF
 /0K7RrQL6K3ZCdtaJtB3klwkVHmypKrqmIF+/EpAcMSWX7poETX2QyBKYuakusiY3hAG
 5Q2eR9kGenMvlaZ7RiXVbF8OvLEd2UcsaM6wNYQqamxlDhS8X4p9Kv0JlkAS8RkJBllo
 4tqebi0miRXixiWgVBbFGgljkugA6KWRqh9aVh6Ex2cjpHxameOf3zYlpKrhqFeYtCuP
 V1rtxsj0Wzv/zHuvGQagD4dKyO1c4699FV0KwmI6td5PvSwexTTp/FO6//L9DyKhCJA6
 EmLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wHL/sTz8VjARXw0cyfzzQUdONA9BFPkB/Za+alI3VaE=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=Le8CzHkgLXKXG/P3m1a0BRYjaplSmY9ur6DLPie0SPjqVSXCLTq8Z1PoLjH7fMgJnY
 5GiFynKS4rT1aCefmnXlHxswP4wHVgbVvbWkEBsf6n3ihL2hoarw5F5eHfRKQhUooU6/
 6T4K4H5KsMVYAqRwGDiu3t/k86vFfMcfRkUD2wOENt8AnlqN7St6jsZLPSlThcsb5b6k
 fcEMcGo1D8FSvKM+fpiQf3pw8Py4EIQJ/S5gqlzIRrYI2yEl+OYwL6ybWpt3HojQxdw+
 5q3atea5AHhYaz/2A6E+x7StZUH8IV6ZrSQv9bJflnRHTedLZGwKom7g7jEhl4vRP5K9
 BF2A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779976055; x=1780580855; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wHL/sTz8VjARXw0cyfzzQUdONA9BFPkB/Za+alI3VaE=;
 b=xXwt4gTOHtUnb3uYaERbM6fE8rTtSXF9t/bLeQuNU+IcT8M7FpMoSIzis7AY0UbpA4
 5ytx8ukU+gK837yMa30gim9x5C4SCAu0y/1UUBbDFVYUUX4Lz20ouhGIsqU6G7rslP16
 taRejrsHRNvSEYnJ/kjOCLpAwqsiU321fDZRSAj02X0xo4ada3breXVADFlKl0pM8x6W
 Kk1mKAyjtg3R4L6DZxGq3tawAiua6dObykwRzLRNUeo7qM4iLPdxpAIoGjKVYBVJdxV6
 1/5Vl3vD1QOt57VmTeL9hTDKnb36BArlZ6w8InRF0cL3I0eJyacioybDqqOBCjD/Z6st
 Dj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779976055; x=1780580855;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wHL/sTz8VjARXw0cyfzzQUdONA9BFPkB/Za+alI3VaE=;
 b=jAKtAtehJ377ckzjWn6Ah/DtSEnzc6cn5e8GcBI/cIEuI/YjwLFnePk7lGmqnHqPab
 LeUm6dOfSE/aDxINYRSRbUAsZKFr7ZiKuNUQKzecw0l68RAosDYk0/Ye0IpVQJ4TxkSC
 xCkuht82LlbSq1lk9P1LV00Yn/Wz6NdhaLlXXVTOpp16Usq/9E7VPFbPkgaagQxuCb4m
 A7c3Asr9y6wbTNI2T3PKUmjqqEGPg0YcLQvl6uE5P5WwGdWl33tcQ/SBqMqxqYslKUk6
 tXiRBzjKTx6cQnoMl1CMVceldWHYyBA2UWxYrNAI8QVK4Gm7bmU/4Jza3hChcFZGazm3
 zpvw==
X-Gm-Message-State: AOJu0YzyWPekj+7p1bQ2v9X/3X6Y+lwn95WXbJXMv0Ta9eye4QwUIyMr
 Z4qVwumGs+SznrRaBim9UiwrLYlyjdY1tF2ZoK27bJYuTJhohblQbkXlzkfuUmQz0WHkH3L8Jhw
 9NtJf1DigAdQDEQ7u2Ydcyj++UoSvDKnSNEO6VIH3Hg==
X-Gm-Gg: Acq92OEYzdtNlBQER4pgtFCCacZcJEqnbPMIhaYbdBW2jG9noZJYu6dgg4Mi+sTh6Vh
 bzT2AxU6n+eHwH5hpmkm7OhbV+Hl96HN+IVa6C4F8ev8apxaCydMa8zXaCCQ3LME0hsENar0/+U
 KaXTvA7RZo73HGpMjFYiP+dF6tYjTWQdg0FTWW7qMDAKkebrOCJufj0Ch7NUPWSjkM3/0n08CCd
 hKJPdfDONktsbc66CJk+cP7i5I2japzshzicTzJoROAqfEAlqCZ1wzsmYZqHbwksZ3tptu14lKU
 zBpxLAd9SMD8TdR3oZ/+q6JPiw9IYTFwKEBJbmP+lcWE+e21VZdNm4LdhV2vD16OnsMRmet/wra
 GkQ==
X-Received: by 2002:a05:690e:43d7:b0:64a:e781:891f with SMTP id
 956f58d0204a3-65ec98199dbmr20409595d50.28.1779976055229; Thu, 28 May 2026
 06:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260518174750.660258-1-richard.henderson@linaro.org>
 <20260518174750.660258-2-richard.henderson@linaro.org>
In-Reply-To: <20260518174750.660258-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 May 2026 14:47:23 +0100
X-Gm-Features: AVHnY4LUmfX7XMF6RiR96MH6PrnDF7cuZSqZTphCHlio16m-doyrBYgWd3ZTmAU
Message-ID: <CAFEAcA_No0Rm=egSsCADG9ujfz7ZG4+dzhkx9bjiB8JTLt7JpA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] target/arm: Add feature predicate for FEAT_CMPBR
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Mon, 18 May 2026 at 18:48, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu-features.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
> index 4e44245a8b..217ab29bb4 100644
> --- a/target/arm/cpu-features.h
> +++ b/target/arm/cpu-features.h
> @@ -1043,6 +1043,11 @@ static inline bool isar_feature_aa64_cssc(const ARMISARegisters *id)
>      return FIELD_EX64_IDREG(id, ID_AA64ISAR2, CSSC) != 0;
>  }
>
> +static inline bool isar_feature_aa64_cmpbr(const ARMISARegisters *id)
> +{
> +    return FIELD_EX64_IDREG(id, ID_AA64ISAR2, CSSC) >= 2;
> +}
> +

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


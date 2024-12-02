Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60867D78337
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 17:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIAEk-00056r-OU; Mon, 02 Dec 2024 12:29:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIAEj-00056f-EF
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:29:29 -0500
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIAEi-00015B-1Q
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:29:29 -0500
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-29e5bf419ebso702754fac.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 09:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733160566; x=1733765366; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FIlePWxHCp+IRiiOJd27NeNiRTcL6VaylAqEo4qjSN4=;
 b=IOJie7Qka2Z8IrcA8EyP8VtXS57UqC/j6x+ga5Fl8NIugXLgbSRnlqR6IU0V7fj//b
 guQcfaFpAFrXxxdJmLubclspcXuse76XG9of1bF81BmYp3nDiiH3MYSVOSf4BSvB49qp
 DzzoBZpvGsziGODZcnxJ6NH0QVGUsXHLxrZ/onLTPQeZOu0vFNLA6tJc4gEqI1bELfxz
 NQGUVRIYoQei16N5MUVvfXzPCg/LrCR5ka49lxxCLEF/dbwUx8H6bZqxbs2xggI4atTf
 RZgJQZHlbFrDiA3GZAItw1NcCgtsgffEIX5QBhn4WLA8k3hok2JJwqSyvhrIN5GnzSKr
 Zbmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733160566; x=1733765366;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FIlePWxHCp+IRiiOJd27NeNiRTcL6VaylAqEo4qjSN4=;
 b=rQ2KY1EI1QRbVG1KQsr1bdCo5ZhfipYJjnaKBxUUQBA+RzVAisJnCNLXoBzQENg4We
 Q+RchiUlhL1sT+mB1wflWuzUos2FrwCjs3Y6Ln3U8UrPRLyoBoHxMGIQTk8Gyuva9+Sr
 c64R5dBtbd6g6tj76+kOMf9qp1vmFwy1Hvg0PgkmTKVL8SH9/qLU0L5bAvkLxzVlJxA3
 7bkGp+J1aCTNJVtEoi7yiMvcoXXFm0eUQfBv5ORNFf5Or/jtifJ5hfSHiVTvTbtPOYU1
 W+GWNXFBDHnGL9Y0oluKiBF2grqwDIV83rJE5v1lolkeSMptS2u3XZJMhyatF7zny+WJ
 HEkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVYagmJ+oUIfTmwnv4ApNSA+X9ddoY6l+uuevVmswev4Hpr81B/ZtZxqinnWl0nxxwSN2Fjq3crMvB@nongnu.org
X-Gm-Message-State: AOJu0YwNS2pDsV/CpuDy+IrYDCK8Xb0lQ8oBDXQqfYCIove9ICuV/lg6
 lmiPnzramlP2ZdYK0aKK8BB0XuGjB593BgLux3k6viAZxYVhrFO+2qjiZ1mZLwBkOkUy3HmPit1
 pQSM=
X-Gm-Gg: ASbGncs3pyXevty91lAtQsNGals4e4P6MnewLIDGC0Am2L6peG4q6rZs3N58QcA3B+v
 KxE2kb3jxII/srm1O5F+96bVQ283Ybbnz1uBlewKHAAw5vxkbOFsPbAxRxHGOmE50KPYKuEvhyE
 6CQwubi7dHRvPIKWVkRs1IamP7FGWmTBkE5+QpR4V/5Xp4GhDOGxltWCie6fgGnrCdGgg5PFRoL
 W21AUT/xRP4Xr0baYNEDa001JNxmnQLprMZVpnrlmXEJFTUXlhcP/mBiPM8VMWnnLYxv6U=
X-Google-Smtp-Source: AGHT+IEWAZqChoSPaIFxgOgdPMjfSLRmlXgVJxKYBhGOY9Ku53c+Izz8G4r1HoJX5r/Iwg9D2rtfBw==
X-Received: by 2002:a05:6870:a199:b0:297:c04:9191 with SMTP id
 586e51a60fabf-29dc3f9bd39mr15961078fac.3.1733160566226; 
 Mon, 02 Dec 2024 09:29:26 -0800 (PST)
Received: from [192.168.170.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29e7786d4c5sm221196fac.53.2024.12.02.09.29.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 09:29:25 -0800 (PST)
Message-ID: <677dbbba-7207-4348-b6b4-ec03f1afe808@linaro.org>
Date: Mon, 2 Dec 2024 11:29:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-10.0 40/54] target/arm: Set default NaN pattern
 explicitly
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241202131347.498124-1-peter.maydell@linaro.org>
 <20241202131347.498124-41-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241202131347.498124-41-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12/2/24 07:13, Peter Maydell wrote:
> Set the default NaN pattern explicitly for the arm target.
> This includes setting it for the old linux-user nwfpe emulation.
> For nwfpe, our default doesn't match the real kernel, but we
> avoid making a behaviour change in this commit.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   linux-user/arm/nwfpe/fpa11.c | 5 +++++
>   target/arm/cpu.c             | 2 ++
>   2 files changed, 7 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


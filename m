Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36BCDC02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 13:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc2hH-0003T0-1W; Sun, 26 Jan 2025 08:29:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2h5-0003Sq-RS
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:28:55 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2h4-0004Bn-C9
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:28:55 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2167141dfa1so62822035ad.1
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 05:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737898133; x=1738502933; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JPpYW4vDdthsC6IqUMd9Txi2tZUg8bQYlIpjp1lyD7w=;
 b=Lv4Gbd3qH6jlSHmdgVSH5bsme9I2uyvjcuuOvxCrxxzpCKiDxA5gtr1DSoygYwjDwc
 QLiGzaoFQr4Bplp/ZwxEd2yTZ+6Vp/OkWJcHb3PwQy77Ati3zxDfTcI1uSrYUaZvvPvF
 ut32eRxRkeHGdB8iIjMVb0qQFVMM3d/tU4gqbq1ZOhtYemAQaaK2l6QLdRj3qWX/EOR6
 cOMu1VNqYRBoes1DKxWusf7nWG5Ifs6Uh0N9vJiGbsD6AQtzMySBbUK/QGLF6nJEYWmr
 PXg4CroOuW1rj7K/ctPSp//vkxshqF0//VSa6OUVTG6wraPiS1BkKKnscAAk8G18xCJ3
 zZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737898133; x=1738502933;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JPpYW4vDdthsC6IqUMd9Txi2tZUg8bQYlIpjp1lyD7w=;
 b=Gav2uNp7XsX98dDfyrmfncxxU2/OHkZ/SgVKv6zDr5wp79LxIse0BS1JUwoHQbGmmk
 Bo/pkg4ots6ohHjfDit9pITnc5g0MhX0cVZyo6l/DyG8OvVd+qxGBSiPZBvSyLDDNKQT
 XlyWX8HxKzzoovegz2B7IFevLuocJPhlLZ8jqoYKgOgf/Avm0Zh8q3GqMpRLepUr2dzU
 OMCYcu+dikSoATs1HxQGZRAotb2fKaSbaKGDslSXqG0ueny9/XJorXMjiOCb4BemrYVj
 H8hdSlAxvtGzBRY6eFPTmqXuh1oWT+QMp8DScavkOEnnqMNwnz9UtGrRMi4MEQ/G8Gwk
 j6Tw==
X-Gm-Message-State: AOJu0YxEJC+CaniUxq6gzPe2+LNinscLrx1FNjQLH6/ACzl15tG0V3l9
 LyI2l/tWTJ9yHWNTd2EMC8UVLkF6u8myoLtsv7vFmt8ybsWH7+NWnntMnW+NIbjZh3NoHhEhzyZ
 e
X-Gm-Gg: ASbGncsKE99QhySSupmznQelXuBiGztnGmkNuaKOFpcDkA0IRIDwfWQYHfS42azfcOr
 5t9sEiyX32KaGr7+hP+MF7OJ1obEdM2MyxDxVcE8HgODqWmCclnPXTomkeZrvFbeGf6f504s2CZ
 RXatTpW+POnGfLukS1kmDfB4pt0ZFEU5ksVWsfFNoqTmkiCx1RU/KKS6deOdk13HbVuGnwrlmzK
 EWJHOXxjKGS+PW8Sr6ROSBUyO2Mog4QeVS9W8goNo1HttvquLzk4cdqN3zG6+avCjeRFtjUqMJA
 P8o+D2GQf7oQSCn5i9KD/M0=
X-Google-Smtp-Source: AGHT+IEDkxyOvBy+vMQcdttedSFD7fUh4IfCf80d9P9+FjHFKMsxhQ15q4NbV/lhrcpi2hwBeA5xKw==
X-Received: by 2002:a17:903:11c6:b0:215:a56f:1e50 with SMTP id
 d9443c01a7336-21d99335921mr210887765ad.8.1737898133089; 
 Sun, 26 Jan 2025 05:28:53 -0800 (PST)
Received: from [192.168.163.227] ([50.225.135.10])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da424ec06sm45726805ad.239.2025.01.26.05.28.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 05:28:52 -0800 (PST)
Message-ID: <0560fde7-b65d-44df-8823-25159f9e82ae@linaro.org>
Date: Sun, 26 Jan 2025 05:28:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 71/76] target/arm: Implement increased precision FRSQRTE
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-72-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-72-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/24/25 08:28, Peter Maydell wrote:
> Implement the increased precision variation of FRSQRTE.  In the
> pseudocode this corresponds to the handling of the
> "increasedprecision" boolean in the FPRSqrtEstimate() and
> RecipSqrtEstimate() functions.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/vfp_helper.c | 77 ++++++++++++++++++++++++++++++++++-------
>   1 file changed, 64 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


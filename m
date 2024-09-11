Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B33EDE997
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 03:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soDu1-0000uo-FE; Tue, 10 Sep 2024 23:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soDu0-0000oA-1s
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:20:20 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soDty-0000Ut-EK
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:20:19 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7d50e865b7aso4766962a12.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 20:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726024817; x=1726629617; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KzAtKCVm58SuhCMocEjjGFyKEBflwt2HntpiuZhYIyg=;
 b=VSvKc23gSvWRSG3Cw57qYPH2Aqw+s9oJjoax0KQ5EIAYctDGInPxmwN8O4MCpA2xf+
 3dTG71MRtvxCvjbGpFA3P/YpoX7+oi2s9OKAd39rpNtw64MeKgI7s358VkRGapnyC+Qr
 vj5KLs8ra6uDkguQh1YHqBNHXliwDT92Wp2G7r9qHo+fn3Kft5V9/TboaAvz9dBnED9x
 ITLUcg78M8vf9qB0dIW7Azf/Fvjgrk72dagwEedQrICAd85hR7Xt8oqUHlItKu2moZoM
 aib+E5v+nbLVAeqKtQtIHlknwDfukXDWW4yaPbjPT2Y3EewzXkPwdb2f8Lq6uoJxJwrX
 C6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726024817; x=1726629617;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KzAtKCVm58SuhCMocEjjGFyKEBflwt2HntpiuZhYIyg=;
 b=tRGaqYDV6Om0ZO98XUJyOdN3mNWaB4gjcta/UoZLWKE9VHiPbvvMdbHARV1y/WFhqN
 JEmTBdqbkiAgjZH8E6VxqMjl7QYMzFcyb0OH0JthSQ4WJoZRtiKx9Iw/ZKlScWWHTek0
 4dcCUl80x1iGpWQgAA/Cr/mQ/GUUDf66PZl5Np/0R8ljIkXUUx4o7Uofe2qgFbGyiO5j
 9NMXIHtSLiHGbpB5q+ki9Ufx0U8Bm8HmLH5akr2QJZMxw+cw9iz0rbXr9pJeRo1dCSHl
 dFIZmf1rBwSchxz2SAn7h94X/mjDCao5dh+Srn4tttfqjcRXXbsgnEoh5FdyOjT/pi8W
 pQTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNC5PP9I/WVMV3DDsXH6DNfDgrpQCdXomG/MvI4YzRMzEp53Ai965jQ97iICFO/mXHuxwHAupj0PfB@nongnu.org
X-Gm-Message-State: AOJu0Yy3DeE85LzVxSpLj5sP2CxLb3ZRQDNW9t6y1c15eX9ypeLFE3bK
 hgpqXChKBm9Nq6I6rgp9In2Xo/3vDCLhT2+Dc8X9yrLJbPoxFozQ/HB75xFi8XjXcAi+QN2Ol3i
 7
X-Google-Smtp-Source: AGHT+IFRP/BXamS94kMl/qJG9vsZn/hKTH5soH52j1/T7vb4Zkw2n06cBPErmMHw96pyEPfh42Q1Nw==
X-Received: by 2002:a05:6a21:9d91:b0:1cf:3201:c3ad with SMTP id
 adf61e73a8af0-1cf5e1c8112mr5063917637.49.1726024816871; 
 Tue, 10 Sep 2024 20:20:16 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7d8242b3febsm5444246a12.55.2024.09.10.20.20.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 20:20:16 -0700 (PDT)
Message-ID: <06c0d471-803a-4c6d-a9b1-ef1d3201d09f@linaro.org>
Date: Tue, 10 Sep 2024 20:20:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/39] block: replace assert(false) with
 g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-16-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240910221606.1817478-16-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

On 9/10/24 15:15, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   block/qcow2.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 70b19730a39..bdc6337826f 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -5299,7 +5299,7 @@ qcow2_get_specific_info(BlockDriverState *bs, Error **errp)
>       } else {
>           /* if this assertion fails, this probably means a new version was
>            * added without having it covered here */
> -        assert(false);
> +        g_assert_not_reached();
>       }
>   
>       if (encrypt_info) {

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


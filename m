Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 779BDCEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 09:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKvMn-0008LN-W0; Mon, 17 Nov 2025 04:17:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vKvMb-000877-H4
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:17:34 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vKvMZ-0002ib-EL
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:17:33 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4775895d69cso21613115e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 01:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763371050; x=1763975850; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yjZSlKwCMVkYvZWKkgndQa7uJSmk64KeT2npAPFXg/k=;
 b=j1gVHvxOtOWl7DkQO/FjWtujb/D2FXHKquhW/aCUXNf7oH8/tamT3qb2LnniUmvHnk
 gCFhH3R+tu4Wcxl7xGmxCSmjppsEz5VR5qv2wdl1E86XJ0yTP+e/Z6xqpmVSNfGmwG5m
 NPdVsdbI8CKWeWmHKIPZYopW54RH9mzqE195g06EGquPaF/aELqbkCqUkR+6Mmz2WFC2
 lbEWbrFl4y4HrufctqDRxdUzGcMwLx4XwqF6ui6gtmG23LhQMrIWpbcw52nMl/qbK2mK
 3rw3R67ffLARVEoB5IqwohXZVL37EG+CxV4R2P5lHedjeAIHZA7ABenJto3uAY8S5CuY
 yW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763371050; x=1763975850;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yjZSlKwCMVkYvZWKkgndQa7uJSmk64KeT2npAPFXg/k=;
 b=Qd8o6pNrf96ivyXzpmzUXoU/k/6uAxZY6Kh1iZvW87E9UztN7myBtNTgQK/RX1TFPC
 1Z1HNO54GqjHVCHqOFwlCIsPkNKJ5bychei9/WtKZRdMh2oHkBU8X0oxhMEYYGgjwJRW
 o13V/K47G8mlxVrEsOhdiPBJthYiIQXbWCHJ1hs8Qn7eMfDoG4OxkuiX+jc1ipW9Hgqr
 S+BeqsHLZJO9/itUpLqeCUHJwnJKBmDW4zRe1kQOlIQkhkUTYBrVWzM/tvR2J5GCP/ty
 LaFiSDQ1SFSRW5hMeIMD5/oXQIJD7eRtN5pOEOWmiozgjPFCd6kSHlzMEnQbFSwC6uF+
 Qmuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0xYUWv2mI8uEyBfAX4JdKizklxBr1xSHcSEmrrvCfuo8FhxIr1BfO0RsUpdpFJeYpTUUqBCZiO5ps@nongnu.org
X-Gm-Message-State: AOJu0YyxHrqVUCz4Siq31yxKSUVJE0VM2IX0EB+/m1TrU3wGEDJCS3hS
 1NwqYihQUaPcr71pEtDv/DwNatkKBRP5Vz6Wq8S4eRenYcTPfqLzGtr1G5MH3EcQFo0=
X-Gm-Gg: ASbGncv43kIFdYez0QqmMWzH5iQgNHYFKhaRh/Qmq8JUPNFETDeXflLhYso6HQLD9Om
 Y5O8VjOkO0uThvtKxXHbSoyo7REb1G39FCBwTjKg7UCGx608spmRMQDHBCx7vNGpt+ONxHbzMDW
 AsPTyXjHeVVYw8vURRU/qH0kGTmZg75WJhHXwQ4bwETEJv29eyyReE0/mIetUD3cxeO2Ydc5m8U
 2EUYXF9COoWk3Z5DP33FZytkv9kSsNJz4VvkryjHphzSF+Lcfxx+tE6kX7zkmIsQqoL0Uyo1ouK
 2qxjbJLWQ+yvKp6Bf71l6s1Dlr7NDu5kwSVAkueqU/gPzPciRmGNUABa5QJJKh+WscdgmZyPl1I
 NuuymUM/cpBjeGylh5RlGxZRumifc7A8l9zTy7SelLjPn/gPvaCA3q8/tm9J+R2JnLa4UsAQMar
 8TEJVV1QSE/HfpzfkGf/hTgeJrUmz6EqqE85/WM+q+npQYpboY9FwzZv6SDh1JJ8en+B0+KF5Sl
 w/4tPeRvg==
X-Google-Smtp-Source: AGHT+IHFCTJo9gT+y8rYYk0n3ZEEsIs/zrO2w6tP293BzLjIzpYgA+KtAu7us4iCMN6XXHvjVI+XLw==
X-Received: by 2002:a05:600c:a49:b0:477:73cc:82c2 with SMTP id
 5b1f17b1804b1-4778fe6822fmr104074475e9.9.1763371049773; 
 Mon, 17 Nov 2025 01:17:29 -0800 (PST)
Received: from [192.168.8.105] (66.red-37-158-132.dynamicip.rima-tde.net.
 [37.158.132.66]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787e35b7esm305349905e9.4.2025.11.17.01.17.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Nov 2025 01:17:29 -0800 (PST)
Message-ID: <f81f4d3c-b9f0-46e3-97be-1ab6e1e50deb@linaro.org>
Date: Mon, 17 Nov 2025 10:17:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] scripts/clean-includes: Remove outdated comment
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>
References: <20251104160943.751997-1-peter.maydell@linaro.org>
 <20251104160943.751997-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251104160943.751997-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x334.google.com
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

On 11/4/25 17:09, Peter Maydell wrote:
> Remove an old comment suggesting a manual shell line to use to find
> files to run the script on. The script's exclude-list and its
> support for directory names make this irrelevant.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   scripts/clean-includes | 9 ---------
>   1 file changed, 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


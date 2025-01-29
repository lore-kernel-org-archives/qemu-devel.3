Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7476FC0218F
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 17:39:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdC2I-0005vI-FZ; Wed, 29 Jan 2025 12:39:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdC2D-0005uy-I7
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 12:39:30 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdC2B-0003PC-Py
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 12:39:29 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43622267b2eso73340605e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 09:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738172366; x=1738777166; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3nB7JJzZwiUw9jKSrtX6PVvItcdtUz8vfBsiS4h8YtM=;
 b=qNrKkB6qbXc2FVJhms8ReJR5p1qSPpd5ss0UUmpSZdpRXXpaz2heNCy1lKjemFpgYJ
 kM1ZtbdTTv6qqYfokAfNDOXKz8rPrUHDmomXkTs/PFhMpb7bJZQRWetsAcrEaT8NyKW7
 ahcriUpfZS2z99bg6080zWHyLkChhylIsubsqEaDDm+UiOu4jEKjQ31B/s8/4REIw/6+
 SzXixm1f7Sw3CuEja8jm9aVtTeaI+6DmxIW7YSZTDT5I/YSUARnH0uZ2jsYIjmgPLE/u
 tKJ8iTm8cDZKOBwzU3e8+sP/8S1GZlM1MZ6E/GCIRpKHfgzCnwW8CJK27piVJ59sWvuB
 oekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738172366; x=1738777166;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3nB7JJzZwiUw9jKSrtX6PVvItcdtUz8vfBsiS4h8YtM=;
 b=LFfFl2aWQzEiBbi9Asv8vHn2MZi0mLOCMEwh2KNs4Q0i9THpVYZzUeFCQOgt7WZIVw
 UI5kWWOAczqxI+u6P0GNoUYPmXrf6EJhR3/s6kAIVaslLUTY/m9/roTrb3jDbmCYqKdD
 wuL2nay9IDm/qZO3Om+7jc1qbIyqmzWbTieE4BepadNFw8AH1PE41mK87os6iaJkyi+q
 XO0+0Y/57aL1MN1DHGf58pIY/30ve4Ew+vV5Kq5rH8XotHTncpIHRhKo+sk6NhBVJd/S
 rCoqi8CoqRFK8qbdE+O3gzgBWwCRiRgPBvx0WIL/B4YFeCUU0hx3/T6Pu/uj1Llh5XnI
 oXyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUc7IebeO8x7etkyMNjHTXHXaPTpnjlav5a6F89AOB7ItX/EXaWJu5GcGZLi55oqkPBCXI5xC/7B5d3@nongnu.org
X-Gm-Message-State: AOJu0YwH34xdB2o0bFSgBTYNez96z8eIpEtw8B4NM0pOdSrpukqekoMI
 nXgK2DmIfSnSoNITTOopRALfC0WLrY7W4WAjnAQxauFlNB6G+y8ygHf7+e8pd/w=
X-Gm-Gg: ASbGncvsyHmUsuLlsE/IlQWn9BIV2NRc0uutDNuw02IB3HAYsrB+RPv9IJ2GAQYiY2W
 6EBht43KoYlxcfugFQqSUhmBBShh+sHwTjVreGm0eKELA4Mhl0C7t9pp61xGt8Biv/PmpN2eHgN
 uKogBDa7Loc84wBFJt6XIbaXMOwEZaa2DfJRFRL8Na/ChPtsiYx7Zca6GdM1G5DeblGDuisGOi+
 DU1+tZae+DjAVKn2bGs5CdUi4lLPi7i3N9WKZWODi1pH7PkqeNfWD7QSIaeehKUblVn7nHXCjBE
 uIL9/lsUxFErzoyZtcnQivr1tbLR3s/KmfeiDZ5y0wK4W/IPw6E0zs5UHM8=
X-Google-Smtp-Source: AGHT+IEq3RzJGNwh/hjgDTZ127qhFq6oE35EynOoK/XxVIRrydCVezUUeYr4JFJi1kdMSbkSzon+yg==
X-Received: by 2002:a05:6000:1f88:b0:385:e176:4420 with SMTP id
 ffacd0b85a97d-38c5194da70mr3558190f8f.10.1738172366138; 
 Wed, 29 Jan 2025 09:39:26 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1c3f5dsm18153543f8f.92.2025.01.29.09.39.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2025 09:39:25 -0800 (PST)
Message-ID: <d36b724b-17ff-4e97-ba3c-08c4c4d1955d@linaro.org>
Date: Wed, 29 Jan 2025 18:39:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/34] target/arm: Simplify fp_status indexing in
 mve_helper.c
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20250129013857.135256-1-richard.henderson@linaro.org>
 <20250129013857.135256-16-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250129013857.135256-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 29/1/25 02:38, Richard Henderson wrote:
> Select on index instead of pointer.
> No functional change.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/mve_helper.c | 40 +++++++++++++------------------------
>   1 file changed, 14 insertions(+), 26 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82BDBCA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 10:55:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utOeo-000590-5Y; Tue, 02 Sep 2025 06:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utOel-00058K-7B
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:54:31 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utOej-0003gX-5n
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:54:30 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-45b4d89217aso31961835e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756810466; x=1757415266; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6vbU/noPQ4DpytGCBJSdN3o1FeaehS8Wgf3dvsfk3iI=;
 b=Fp/6kfUu2ElJAvXZ0VL8lyvnAzU1/qgIiGOe75WkMLcFU7pKbyWSArw7RoLSyFeCcx
 Z7by5GzpnvnnNgUn31njoMi0zFBwCN0e+T9tG8R9uVfhBhXgWxY8mMnjQfAF39WRyMl2
 tlZls38YTKsEJCmUEIOgXlTIdgdDHLHqc1fskA1t8gE70d81/Z3URcO/KcH/abI/BObr
 bsxWYTfMbDfzBJWcOnKdKs8jMUV06ft41/n2iMQElH8jC4l8ODrAeEBkanX9G5CHkD2/
 a6/2Qzl29eK1CtGWf+5g/qQiLPqut8VsjGCoHeeB91m74kP/UBzRYfq9To2jiGK4ReVS
 qAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756810466; x=1757415266;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6vbU/noPQ4DpytGCBJSdN3o1FeaehS8Wgf3dvsfk3iI=;
 b=dxe6wW2+vP85BvX9Du9bGw0KaTOrjchfLdv6QidSvRKzUkl4tV4qbggG7AT3TRp6Nc
 OCuixcLNVQ3dJuIw/zJbIcD8l14s1Cp7hyWwq8iQlFaiwojFpIfjPKwBUCk+mrahVm8I
 9da2VeOPSnmwTYngvq3UURFQ/JqJHsWTES+pjedNgcRsZBQ3MQdptyLINcpem+bFanuh
 GbimdDDlURfNF8YNM8B3Hl8NGTz5Vvx7HoFjUZ0VTCV3fgTGZ8SURgzlCUM/Aq7txxsQ
 /VY+TrSKdWSsYTaK0Uh0orCTjwcsUwwyjFI+hwc4uaUyG0J1Dlt/XwZdqvYoH1J9J0Dg
 EQ5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwqYJL/V3GsZA4BcFRRNL4SuRN0bUG75Rs0HePqMgmew+s70h9p49JTnlLdhLUoZB80YMs/kfCOXJs@nongnu.org
X-Gm-Message-State: AOJu0YxivxM1rhlLi0ul3o3zJc6v1c4QY/JbiDCCOk2ZZ0/w9tmiKPL7
 aDanaPD3S3OaItSh4RaTYDoaT2lHhJ4Kq4RI0BJFd3ScO5aDCdAjPpihTWpAMQ8IhK8=
X-Gm-Gg: ASbGncvByXjdnKidBnXtFEruhuZkE6n8y0NdPms6xwfKVOOdcSeCDGIvGTFgAEzbFaz
 LbJ/QRR4ibqbvktoTIzvoNDs09fFPEBVaxhVbxOaySFlqDDd3J73YUKYMZQ+Cq5CmlEc2eIaEoL
 ayGJmNwSTQX+Dku5+u9NVzqDbHGN3aIhZO1uE4Aefr4NiU58OtRLbaJLQw70mWH5FiD1eXeg4QQ
 WtltTJF0epbx5aTdQWZlw1HHzTHTdWppWsvOdXgfexSrdNTU3nynVOZFTfyG12FyL7J5htVX2BP
 YzzkXqRFQhKZtBhOCFokGsFPldDs8eVWRkC/nTlcLDJzMTD3Qgs6cCGZM3wwq6ShxFfQ0nldFZz
 M5QZtquivz9Nsjv+kPJqkyiEQKNSswgM8ifJ+15Erc1EhNSBNVHkAG/rbUjm0Y6JCTXcZMb20P7
 7o
X-Google-Smtp-Source: AGHT+IEQms/ew/mK09dghy4zC5tbBT0hg8W7f2iT8m3PEZuDe/+d/xvoWFjtO4Bcb4J9V6wCQw1zFw==
X-Received: by 2002:a05:600c:484a:b0:45b:85d0:9a0c with SMTP id
 5b1f17b1804b1-45b85d09ccdmr68693415e9.15.1756810466344; 
 Tue, 02 Sep 2025 03:54:26 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b66b6985bsm182407205e9.2.2025.09.02.03.54.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 03:54:25 -0700 (PDT)
Message-ID: <8e759fdd-5ed4-4e2b-9769-c6b072f52ed1@linaro.org>
Date: Tue, 2 Sep 2025 12:54:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system: drop the -old-param option
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250828162700.3308812-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250828162700.3308812-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 28/8/25 18:27, Peter Maydell wrote:
> We deprecated the command line option -old-param for the 10.0
> release, which allows us to drop it in 10.2.  This option was used to
> boot Arm targets with a very old boot protocol using the
> 'param_struct' ABI.  We only ever needed this on a handful of board
> types which have all now been removed from QEMU.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   docs/about/deprecated.rst       | 13 ------
>   docs/about/removed-features.rst | 12 +++++
>   include/system/system.h         |  1 -
>   hw/arm/boot.c                   | 81 +--------------------------------
>   system/globals.c                |  1 -
>   system/vl.c                     |  4 --
>   qemu-options.hx                 |  7 ---
>   7 files changed, 13 insertions(+), 106 deletions(-)

FYI this patch doesn't apply anymore.


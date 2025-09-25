Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB8DDCAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 11:44:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1kM4-0002mq-SE; Thu, 25 Sep 2025 07:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1kLZ-0002Nn-9q
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 07:41:15 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1kLP-0001L0-LX
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 07:41:12 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46e1bc8ffa1so8992735e9.0
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 04:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758800453; x=1759405253; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7g6ZYIv2HmwEDBfdK6gE48JDjOb62MEWHjhZZKWDhjs=;
 b=jn5csKuSVq0g6dNxdIuXJtu5OsvE1QU1oK59HGkuaxR312illHN/X5NU9nCc1ypC5M
 ZJNmpCznFqJv3suOgL7I99r/019bkOkyvQiyMzgHIUZLnbrL9I4hGfCm509KY5MIiY+T
 yROsxiWIXzMgznlxgR/he4A6taeL4BueWRrWmJojdx9uh1VNOOHF2RlK3zWV9pffUz8E
 Ve/tprBljpK6/hllHvLqRFi3WBB0QmbcKxLlfk5stftnBvzgANL8urNXtErQCayr/gLF
 UnijBnhkW1Od1ui9mFAY91o1Lv+u/Xq98Y740wLyw+G1r41RjNM8qNcelQgElMWg02Mm
 Jd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758800453; x=1759405253;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7g6ZYIv2HmwEDBfdK6gE48JDjOb62MEWHjhZZKWDhjs=;
 b=riaK3nZMhVajyX4YF6ZJkGWjZNFr16gbo8c4yMKvY6giD3XtvDAIRbmysfglZ1XlvE
 wU2GDSjOQ07XrT0DVqzS4g0JXwWtWjM4dH5V1v5XE2jKmzkKmOnB2ssjvplvLYvfl4yb
 6J6mwxlAqBbnhxapQHJT7Q7ih1mRFbotEJs6ph6P7PPwX8AQl73qq/juBh+0jHVgW6Sg
 BGaPsJVX9xzSD+YgZWB4QXT5nJvrDnaD2Mx8MlKfNl9PMlIcK+nFAUvVzBawh37pFusq
 H9AWzuVZjPfoRrotukfpLvQpOnIOSitDacX4VoBFBKqGXcPFTT0awiUBNOrjJhvrAmKv
 39uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRFn9p4GHAhoIYePmibs4pbrKdk7Ef9QpLmMNTbZRvirrzGXC48mFtsFMQnEYHx6Avx35cFDIYb61L@nongnu.org
X-Gm-Message-State: AOJu0YzlIwXHiVyZoJgloaVJTHQnx4r3sATx3NvmkaRS69ETMdReoQJ3
 Tj1ipEzsCYj7l616M4auiEiYxUf3VwZ6maaq0CZg24K+j+3Ivisx2/aWSL6+Cvm5pnI=
X-Gm-Gg: ASbGncuna1XYhvq3JaifzTxZbePMr0ty6kxM3sNIoSODkS1H8RsIGkH4D11JiUP0aiB
 T3qTUg/9OaMLbhzDT1Jnq7UTtlGFn9xIqrPIbd/V/RQIdsvvS3f4S1PTfTw99JlJ8fiMkSQOAHp
 KxvmPSXqwbzmCexEV1BWfaeaz8uEk2ZSvwwDEUK9laWBBke+8kTJ342Y65H+el53muVUIUPei3B
 exQ6AArT9QUlSjbyVJON0exhilacxBX/iUgrPhzBLcrroGGn1SHwbGmdEwagRNMO5CINDLq7c0S
 EPQNTi0l2CjUuMLPoaZsgKDsyM4PzAl+4k2c75HPuZLJ2fTnWMdsLI2GLkdl/aTjpNQCCgGQ8/x
 kw+YIuAs1pHXy2HgwTWpXSJkQOxcPesB4CNIbMe3z4vfGXpD+LDaUkNB51mxUSz4VWg==
X-Google-Smtp-Source: AGHT+IHfvtcjgeeipRSeJ1nr89p9rtgNrnaoCXwnya28JVsr4b1MkjEZpzHB5xjIYYOVzVL1n442pA==
X-Received: by 2002:a05:600c:4e88:b0:46e:2801:84aa with SMTP id
 5b1f17b1804b1-46e329396ebmr32652105e9.0.1758800453290; 
 Thu, 25 Sep 2025 04:40:53 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e32bd6360sm17417105e9.1.2025.09.25.04.40.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 04:40:52 -0700 (PDT)
Message-ID: <4753a8c4-0709-4c13-af1f-baaa925f6478@linaro.org>
Date: Thu, 25 Sep 2025 13:40:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 28/36] target/arm: Move alias setting for wildcards
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20250916142238.664316-1-richard.henderson@linaro.org>
 <20250916142238.664316-29-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250916142238.664316-29-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 16/9/25 16:22, Richard Henderson wrote:
> Move this test from add_cpreg_to_hashtable to
> define_one_arm_cp_reg_with_opaque, where we can also
> simplify it based on the loop variables.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/helper.c | 22 ++++++++++++----------
>   1 file changed, 12 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


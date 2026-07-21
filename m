Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D59DFC44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 14:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmBc5-00059R-UY; Tue, 21 Jul 2026 10:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmBc3-00058X-Gr
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 10:38:27 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmBc1-00006Y-RR
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 10:38:27 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-4513435cdd2so4622132fac.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 07:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784644703; x=1785249503; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hLpwhR0BRSCSpnp9kLooKTfd08zdAXaSiV1Ool7x5ts=;
 b=lt5FWoDMOMvJJYDFcxgOzF3/W+v+hDiEyOGFXiVCmqCZg6ks1zy2t2334OmD0iQd4N
 F7Uzfb6C8D5mus2rZQmkJl4jLKNNA6JDtkxTqT+ffXJA7feDL3wv8S4Il//4mX9mK7NY
 P5j1n+LkCmgGyU9dcnccxJK0w19f/tbAdYdr+Ao4zin2OovV3V62oZgxrmOLB8Oxnwl4
 hBYvaRWEL+ScnOGmNEZoKljzID3EoNElzCxpI8mG1rifGX9bXuAu9NnPAom16Fc762P/
 pdVR5R17mfXJgIqwYCR7DvBqz+FZbTOWn5LtLvcyd4rOyjBzb8v4/+zLKmksjDthhPcy
 xxxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784644703; x=1785249503;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hLpwhR0BRSCSpnp9kLooKTfd08zdAXaSiV1Ool7x5ts=;
 b=Y1s0fEi3QQyy1z7c3UpYKrwljr1F4PzJD17Ii0EHToQlqKqwOxe5qfwKXNa1EBodYe
 WHC1VNVCDTnvXc/GZA6IvIcV7T/uCTzfoPa/g6R+KDr9+Hc5AfBUOZ3+s4OAt3fDld3m
 sGG/o3TdZ90nYai83poAcI8E6grtYujfK+B9SAJpPb09VBw7479o5GS3VP7NCqPsOdN6
 dEglV1pXR6RpwsnCO19TvlieiRAVKAG//tGUSiyn3wdkjAaMHPPLG0MEGAX8VrBGZn9c
 UpLoeclHoe0hmwYkWuH7ogj/AQF1hFS3grd+zT4vEBc0vZdXeG4SarECnihDBvbgRnHD
 UJGQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpRGbLP7np/P60I0MC68ZS+ZCYuUn+tlgig+xnnFbKTh9NoTyrEEZd02abckMMGVFZ63BjB7AV3lHXH@nongnu.org
X-Gm-Message-State: AOJu0YwQXhKmlLEVNF/oNwxmV1st/CdEyYnyM0Q5/aevkmkBFktPCIlo
 LEjOFoKBAxD0jKp9AhWmwU8eRYacwYj3e4RSzHdMQTydq7LxO7JIgE8daaPqr4JFGDg=
X-Gm-Gg: AR+sD12I2dsGC5iuXnJuSP3gI8h2JLtIlnOfPEyMwjXGa58pJzPkP1iwVfK4f3LerUF
 rAcVHkOeimEJUeLz3PDxrCRkwFsb74lnyHpeyB/ZPGTdWlTOELmg0SWCdHvIEEEqEqEnvGg1+25
 7jonCYeLTix3/7Nw6kVlAE8AALNflpKu1NdEKw7jTXl1WvodKM8iL6kp9zoa3uMkuJfYB3qDQCQ
 yWqoVqBaBY9+/Jh/fME6f+MVmigCBLAM8Z3MG3JP7xuXFpM0h3LCONQ9DZH+d5J02m/qUSgkSx8
 BTr3BHCW0OkCKWtUCljKsu9ByUwPkZka1X52S3e+kksNhQ69+lM8HdzKrRiQre9cB1qPUzSXZPX
 PId/myavBaVc90PmO9SW2w5Zt+2hScZEzakJPDFI/wtNz0ZIaIjXzOwZZ6GIljsMAkw5vvztp51
 qZ5mjGYftWPPpRzfM=
X-Received: by 2002:a05:6870:f108:b0:456:4cd1:646b with SMTP id
 586e51a60fabf-456900ae9d6mr8909172fac.11.1784644703434; 
 Tue, 21 Jul 2026 07:38:23 -0700 (PDT)
Received: from [172.20.2.34] ([32.140.233.50])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4568e0bddefsm11451572fac.4.2026.07.21.07.38.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 07:38:22 -0700 (PDT)
Message-ID: <94d532ca-7ff1-44dc-8fda-f405cd8e8e93@linaro.org>
Date: Tue, 21 Jul 2026 07:38:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/17] target/arm: Return struct from
 allocation_tag_mem_internal
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20260717232306.378988-1-richard.henderson@linaro.org>
 <20260717232306.378988-9-richard.henderson@linaro.org>
 <0633cf6a-ac8b-4dd1-818e-e6147fdbdda9@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <0633cf6a-ac8b-4dd1-818e-e6147fdbdda9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x32.google.com
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

On 7/20/26 01:46, Philippe Mathieu-Daudé wrote:
> On 18/7/26 01:22, Richard Henderson wrote:
>> +    AllocationTagMem ret = { };
> 
> I'd feel safer starting with:
> 
>       AllocationTagMem ret = {
>           .flags = TLB_INVALID_MASK,
>           .attrs = MEMTXATTRS_UNSPECIFIED,
>       };
> 
> anyway:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> 

Ok, sure.

r~


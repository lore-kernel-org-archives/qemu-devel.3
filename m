Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CFEECA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 13:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utnEr-00055q-Nu; Wed, 03 Sep 2025 09:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utnEp-00055L-Rl
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 09:09:23 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utnEo-0001hO-12
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 09:09:23 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-afec5651966so595579466b.2
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 06:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756904960; x=1757509760; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WNSzaTqgyVwIoYqGrXgppPc7cMZQEZ3OyNtctVl5xoA=;
 b=oRqEeGGF4o6gIFQej06abOaYYNWajRI7lJnfMCzSv9Ik2XkzRfj2g5qorgRIQyrnZC
 PyTuXjN8A8Hsu70R2W13sYaYOgdAU6GoCw2zyrsskvkbOqMsUAQgPX9rkasanKb5fqiv
 nQhz7RWl+4P+E4xeQMMe4hVGYfwEbM2bBeNBoL/mfNdg1E/tmrO0XhaAhnEqrwVFUMDU
 bZyy+25LCJcP3+7uEjPvVXEqLvUJQv2e/XurloIzOQwUC2kLCR+3K0cwKfV+xfKTH/TC
 3nXyaPSzgoAv+Sa1Oji1GJDCMk3n71VTbK9sUEgAXQb2H2GOjlRDE4O51GNdiNNTpJ8u
 TkQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756904960; x=1757509760;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WNSzaTqgyVwIoYqGrXgppPc7cMZQEZ3OyNtctVl5xoA=;
 b=OLJtfu3mq46VM40BTdzE0LXcAJmuIpXcNer01CeCBB+h8Z/MqOHeQRisHuQp5rnIk3
 ag0UMGg6XSs9UnC7S9eQuAlXD10nBidG5UbUUIsVD7nVQFlxQTpUqO+JnteyiWa4wNL/
 GFS+/C/n4kdd8XTxnJ1E5gxsRIqAWF3+4mtiIhUtKrd9BjZGuBWcV7b/aFO26XHd8XFY
 iGvvEKbhYE+4/uTpxSdleFxR6BQJJJoV7sGflbQGoJgIoCsj7gyY8bUf1D3TXDHL+VzH
 DvjBx+kZ9ETbhqW58aEIXidzUzJ60Dffkf9AIE3azn1Hh9TEYMgDxH7pwzTocCF4rWtJ
 cEZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyLRHDYkx0qT+E8deV/wSL+QpiBSGkqKv5NcJQZPZDeDwHB2PV4nQzHWGZTTuBAzzBcBwntFmgR6V3@nongnu.org
X-Gm-Message-State: AOJu0YyGiZ3ZRWVsyteCEi3igvOKhqKvgYocX2iuMpwlvS1nHpXD5aHb
 Uhz/ZCdmFXomBIokkuBLq7mBLodxBhnYGSxXaN769C5zcDeHm3JDdOgm3fvwOz3rnc4=
X-Gm-Gg: ASbGncusvnOXlbaSE61Us8SZK7e49VkMDPIHsV2K1M3NZGi+bZXNJmj0Sm4IAcYPS/g
 YYn0IthienZYvxZ3jLYkzg0E1TLM4aUExfdVN3rXBpzVhST08qHs6nbYI/bk/nwA5calLYchq81
 Ld6/VorB1lBsYFZPkKhEffIuOkvgYM/YmvR88U/KAw2g0Z3xnHkhCKAyzxSR7Yva28CxflPGtwf
 31zoqc5XznaZ7F+39u+V8uKTacVwALBH/22mJXiyVjb9duQIPRa9lz6/wbfgXMhNE8s3ntcyIO8
 +ML71a6yBA8iRmeRss4ntTQQ0ts95RTeIClQBaDljPnkELMbLjjj1PFo7mGi5k8yvNts+KOkske
 UCfmBYbDE8k+nmv3g78APAyd+ewgzYxnF1ahpjCOzOB/g5ZRn/MkL4l5qMidnJS/aYQCvUjPJNH
 bnBL8Stg==
X-Google-Smtp-Source: AGHT+IF5BX4Rp3Kygd45lwPlgCHBnEgZzxqI0jYCbF7erbTKbivRB5tBFvVLkmWTXG4ax4SgdZJ33g==
X-Received: by 2002:a17:907:9406:b0:b04:6973:1ee9 with SMTP id
 a640c23a62f3a-b0469731fbcmr228824366b.16.1756904960167; 
 Wed, 03 Sep 2025 06:09:20 -0700 (PDT)
Received: from [10.40.6.207] (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b04323984ffsm679797466b.64.2025.09.03.06.09.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 06:09:19 -0700 (PDT)
Message-ID: <1b542ce0-33f9-4967-8402-53ce9c2e0d96@linaro.org>
Date: Wed, 3 Sep 2025 15:09:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/12] target/loongarch: Update TLB index selection
 method
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250903084827.3085911-1-maobibo@loongson.cn>
 <20250903084827.3085911-5-maobibo@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250903084827.3085911-5-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x630.google.com
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

On 9/3/25 10:48, Bibo Mao wrote:
> With function helper_tlbfill(), since there is no suitable TLB entry,
> new TLB will be added and invalidate one old TLB entry. The old TLB
> entry index is selected randomly, instead it can be optimized as
> following:
>    1. invalid TLB entry can be selected at first.
>    2. TLB entry with other ASID can be selected secondly
>    3. random method is used by last.
> 
> Signed-off-by: Bibo Mao<maobibo@loongson.cn>
> ---
>   target/loongarch/tcg/tlb_helper.c | 49 ++++++++++++++++++++++++++-----
>   1 file changed, 42 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


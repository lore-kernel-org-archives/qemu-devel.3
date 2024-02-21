Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B1B0C5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 18:06:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcqya-0001ft-O5; Wed, 21 Feb 2024 13:05:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcqyY-0001dF-VX
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 13:05:46 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcqyX-0000FT-8k
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 13:05:46 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6e45d0c9676so36426b3a.0
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 10:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708538743; x=1709143543; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nKKLptDSdqzkckguYJTH6juMz0piBQqZbgHWd2D7gsc=;
 b=RzU5/pVzMsjqeUpxBRgmUfb2puIyUSB7o6MqtedeCxcA+mpJtaUxH0lfBKzrltGVKU
 UGq43NdMOWNhxllI2FEWPE4U+JIG5FHh70Tqf/I2sCqFyRNX5t/ZtFaDTfHVkg+u1PoH
 x8fydQ4hVB8KMuikE4jN6C0jfNsFw6WZdXRpTz5oqHl+KjN1Dzc3C7f3yO9Ibc/r1E1d
 FJTWiVCBcKQRQuv+Ube12uxqiGCv7CmR6YmSSt+y9V/C5Ko55/hxgc3k7pKIOqeyUcBV
 LKPhLdqjJQZfPVSDnGJCCAeqpvlk/uIefzllLZlYRMStmuzSrEjF8bntEochMQoR7IXn
 zj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708538743; x=1709143543;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nKKLptDSdqzkckguYJTH6juMz0piBQqZbgHWd2D7gsc=;
 b=NUrje3s7SnnUQyxQsEd11AmIZF197w+SUrDPrzSmGV0d9uwtClDshqWiElCAWBD12m
 rWKQw1IMWbzxYSMeO6YnLrLH73a1jRsQbi57GhfTTwkHOImdx8L20UjkdaQlGBTJ7Hlf
 KfzQSFJGwuhuKL1RAq3/M8ypI12hFFCmhP0X6vEzr2KDbG8tBx8R+mggYmnabQDZ0o6W
 pFsjDj5R4urBCnrRYAErEqgY+PPGtyRiyCxNMuAa5yQmnZkg6vYsfd3HpH5a7qCBzz02
 1s7VdwwvTmEUp/ejxBptlU1UWQ7O/mOmUYWh3Lc2CzHt1Ob/8mSXUhTgntY/3c8PD4qK
 Dw1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVALCDHZs/CjqRf+y8rZhWMmQiJ6kEUGnt3Iy1Z4RWPr7Plt0gq2dk498yl0K5x8h4BQ+ogEVFv1X1P/UzgrGNyd3CMJH0=
X-Gm-Message-State: AOJu0YzwzLcnlC3IUZ1Jj8zpcRAIHsrjrFczgA2+GzQctUn/26WpkloO
 lL/u/TkGDO+b4rc9KWtmiMrpI6+sE1kC3GiVYxwSYuJYukotNP8SGpFpe0CCZcg=
X-Google-Smtp-Source: AGHT+IFV8Zft/HEd0ZZ0Sqs3GE02GOjtOYWps9GcAdWCAGezCPoGChys0Cq19iS0rzx9cDKs4tYtUA==
X-Received: by 2002:a05:6a00:4585:b0:6e4:bc7f:ba39 with SMTP id
 it5-20020a056a00458500b006e4bc7fba39mr277365pfb.17.1708538743337; 
 Wed, 21 Feb 2024 10:05:43 -0800 (PST)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 s6-20020a62e706000000b006e3f09fd6a5sm7571751pfh.163.2024.02.21.10.05.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 10:05:42 -0800 (PST)
Message-ID: <094d7589-09f6-4515-ae8d-72acbd3ade58@ventanamicro.com>
Date: Wed, 21 Feb 2024 15:05:39 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] target/riscv: Apply modularized matching conditions
 for icount trigger
Content-Language: en-US
To: Alvin Chang <alvinga@andestech.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com
References: <20240219032559.79665-1-alvinga@andestech.com>
 <20240219032559.79665-5-alvinga@andestech.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240219032559.79665-5-alvinga@andestech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x429.google.com
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



On 2/19/24 00:25, Alvin Chang wrote:
> We have implemented trigger_common_match(), which checks if the enabled
> privilege levels of the trigger match CPU's current privilege level. We
> can invoke trigger_common_match() to check the privilege levels of the
> type 3 triggers.
> 
> Signed-off-by: Alvin Chang <alvinga@andestech.com>
> ---
>   target/riscv/debug.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index 67ba19c966..de996a393c 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -624,7 +624,7 @@ void helper_itrigger_match(CPURISCVState *env)
>           if (get_trigger_type(env, i) != TRIGGER_TYPE_INST_CNT) {
>               continue;
>           }
> -        if (check_itrigger_priv(env, i)) {
> +        if (!trigger_common_match(env, TRIGGER_TYPE_INST_CNT, i)) {
>               continue;
>           }


Looks good. Shouldn't we also change riscv_itrigger_enabled() to also use
trigger_common_match()? riscv_itrigger_enabled() is remarkably similar to
helper_itrigger_match() so I believe we can also use the new function
there.


Thanks,

Daniel





>           count = itrigger_get_count(env, i);


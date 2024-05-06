Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B15C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 07:38:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3suz-0007Zf-2k; Mon, 06 May 2024 03:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3sut-0007V3-LF
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:37:43 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3sur-0003dV-Vy
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:37:43 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-41b5dd5af48so13211135e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714981059; x=1715585859; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ihFz0TAiJJkDu1kN8RceEsp2LgCgzM3iMXQYlzTd4LM=;
 b=jbNbCKQp/ZQuqubHpi6+X0Tok46evDkCedEi+Oxp4rk+1YFKo0AIFD3rlQGzBr4icM
 ZQzvxh3hOKawGyvUAFIqLtMi+bE2QtGci1xQWj82J63KmtjTbK9jQfagz3tT+7xCSSsV
 k3vWCk8UFcleeS5GbUtcYYzpnKtlWt1mYfJMXu+5UGwWs8oThy7roE+B21DS40B6K2ef
 7GIMTPnrvxmop7coiLywJIQtquN1XRRve3vHgEPH08a5iIoAJ1vKA03JQ92gwCloXALd
 eGuOd8tGspmSKWJycCrF3nOOw2G34ioxIllQ/3UqfcsLEUNdvzYLrxgkweQHBXgI5id7
 k5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981059; x=1715585859;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ihFz0TAiJJkDu1kN8RceEsp2LgCgzM3iMXQYlzTd4LM=;
 b=mvV/wovVcrcjT3DY54SBcBFD2zoKJ76Gx2bk589+x4Sizq41uNwFkpYwgk78+gN+Tn
 hwZ50bfVSWUGXkidV4gNkAQIXEa0Zzgx/G8a8qubhNashdfOC9HiL0tiAStDslxOvJUe
 zgRNwumdoVF1h16kULp5eoIgJINh8qXXOVqnUV9U6Zn6KZ4SJBKiTpEhDj8fmkl9NmBu
 h1OAOzm+VEmc1IDpt9kkM2HoAtqgGSRezmpsWBEexSZAdgUbcYnUcsG57WpZXewocLBt
 P/Dp3Z5W22/SUM91B9z5hkHdNlTrqbki4ttXqGqhdPOdjtfmdWZsWEiG0fsrXDdD7/cn
 N50w==
X-Gm-Message-State: AOJu0YxRIsNWaoG05grhL19peRxkUtoOqMCmrRhNsdTNyW4AS0LEXLiN
 hzLlbInX9TcxfadHexkAY9lclMI13u1xkGYJRY6lPrQm9YXBPjjy/yCeAJkJaWg=
X-Google-Smtp-Source: AGHT+IFHH1ffhBnTKRAEDzALj9jq2uRL/Gy39LJuoy0si0fbQViIDLueJL6p2frMJU24O06rdUBqSQ==
X-Received: by 2002:a05:600c:3c89:b0:41a:e995:b915 with SMTP id
 bg9-20020a05600c3c8900b0041ae995b915mr6626327wmb.1.1714981059662; 
 Mon, 06 May 2024 00:37:39 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.4])
 by smtp.gmail.com with ESMTPSA id
 q8-20020a05600c46c800b0041ac4aafd3dsm15093098wmo.12.2024.05.06.00.37.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 00:37:39 -0700 (PDT)
Message-ID: <a2686315-cb3e-4b6f-91d2-81ccf023ec60@linaro.org>
Date: Mon, 6 May 2024 09:37:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] hw/usb/dev-network: Remove unused struct
 'rndis_config_parameter'
To: "Dr. David Alan Gilbert" <dave@treblig.org>, peter.maydell@linaro.org,
 laurent@vivier.eu
Cc: qemu-devel@nongnu.org
References: <20240505171444.333302-1-dave@treblig.org>
 <20240505171444.333302-5-dave@treblig.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240505171444.333302-5-dave@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 5/5/24 19:14, Dr. David Alan Gilbert wrote:
> As far as I can tell it was never used.
> 
> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> ---
>   hw/usb/dev-network.c | 8 --------
>   1 file changed, 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>




Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BECCCD1A2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 23:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAzUn-0008G7-9G; Mon, 20 Oct 2025 19:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vAzUX-000887-AN
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:40:43 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vAzUU-0001nx-B6
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:40:40 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-780fc3b181aso2769292b3a.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 16:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761003637; x=1761608437; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9Rvy7rYwhVlUsIjly7OGcRyp4ieLY37bcl2e/d8Auqg=;
 b=iwOw/RZtrvvOBcuj6OZ95RRF5z3vuus0PTChRjZdImby60qCCZkH1f9eLOfaE+aL6T
 bJNpCwFreN0nbOPgErRdOyBMQWj7JtUusa95o32I9EZhE65NB93pcBJ7834YEmuUIsUJ
 C7+LoqY92hebFClmPd3WSq9shibYUJvrfNRtLkq6CE5GV9sa7ereHL/6UK4e4yaInzgf
 D7dRmaag7rhwy+aspspNtOUiAwS62RVmuckhCvsy3v7EgjGRu4rZSJrRIBbzftJ+ukFz
 c5nGqhlW+Yi3NCsmqDw9nvga/iG+vzt1eWphXQszTDzDuu3YDGRsVeQYskpoNj5dosU8
 8brQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761003637; x=1761608437;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9Rvy7rYwhVlUsIjly7OGcRyp4ieLY37bcl2e/d8Auqg=;
 b=Qg0InkNAVTibLPPSuwc/v4klj/PtWpljwlaJiyQm0ZgNOR4h+ekQtlfjvpDNc2GPtt
 zahyrIZ7dTOiR9yclmyn0CYw0zgyqeFJ6E7Sgp7fsdsnatOTfGAqUC0CVmih0NprvfFG
 GLRVB+Na+3bUcx4eeLJAPypCXvpzdih2CFIBo5AVSpbNcRaCk1MC5PRTTpWHiIFV25LL
 WtIo83BVNzc5P6/zCWVYzwPID5g0g+3lSvIMrJWM6ugaCtoi2w+Fufm3vwxXSjY8mD9J
 J1UFm91urMrH7jOzHqrLuWx3K+y1DgJYZdjw9eQklIal/q0Ex79PhOWkYunEviYuop9P
 1S7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXE7eQDFG5mkaoR9c6FXKm4uKAdLB0UBHv9ygkwuvSMni9oFwIfPaGNgfVw8ODWZWLZhKbarS6pExs5@nongnu.org
X-Gm-Message-State: AOJu0YwDMK6+uuCwL7EvheHqaLvekbbDvKy8b8aO2VHUEy60j1h6vI1H
 p27SdY8Ez0hMQRK10RcUoGQg+gXgcY5d5yYuF7uJD1Q16oGrdjLItfqGFLMXxb5qzMM=
X-Gm-Gg: ASbGncudCYQWemecK1V9CYuL7/IAd/8mXkc7YTUlktjvKYwkiBxNdCpYa8wurkWC1Vj
 54kLQqTmqClMl1yKffy6OVXsmFtNVoseX6geBuMG68acoAk2gqn8GOoJJJB+gmw8Ga5dRTieMHt
 L+OZqaxksPGDXrZGZPmeK6cE1XiA1wsGt3v9rk93XnO81aIzcOkpbkJs4KhRnJtM+49y+zxbQTC
 fHGpjYZvCY4VRi2YnEEVMDJT42m/EsM5rG39NOT4I2JRovSi+c07g4iDGyUP9VaUTIrq5IuqWtv
 uiSq/Q35Wl/k1E7iAwwM+gS/ECl/zDE60mrDtB0c4YFbiJweGBi1sbzNLve6ACK0IpHLjbefAMD
 Hjcc3ENjijMXsEt63Cvp4Bu5+HUgVx5Pmza+bpynVWdkHwqZd9qE3ZhfMDGga0rXUbDZDZxEF12
 m9EPwnm16fltqPVA==
X-Google-Smtp-Source: AGHT+IE8JVW8DTYrqgAqA2IBpSNyo6s2yRrLFuxeVwfIAke5qyiFt1Y4GP64kt2+5bs3b9+wmvM+Pw==
X-Received: by 2002:a05:6a20:914b:b0:2b7:e136:1f30 with SMTP id
 adf61e73a8af0-334a864370emr20508406637.55.1761003636778; 
 Mon, 20 Oct 2025 16:40:36 -0700 (PDT)
Received: from [192.168.1.111] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b6a766745dasm8722540a12.14.2025.10.20.16.40.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 16:40:36 -0700 (PDT)
Message-ID: <b1fd7ccb-e41d-4db5-aab4-454530244022@linaro.org>
Date: Mon, 20 Oct 2025 16:40:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 27/30] hw/arm/virt-acpi-build: Build only once
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Luc Michel <luc.michel@amd.com>,
 Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20251020220941.65269-1-philmd@linaro.org>
 <20251020222010.68708-3-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251020222010.68708-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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

On 2025-10-20 15:20, Philippe Mathieu-Daudé wrote:
> Previous commits removed the target-specificities,
> we can now move virt-acpi-build.c to arm_common_ss[].
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



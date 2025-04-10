Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A89C369A2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 16:53:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2v9i-0003AP-Rt; Thu, 10 Apr 2025 12:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u2v9h-0003A7-Eb
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 12:53:33 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u2v9f-0001OJ-Ql
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 12:53:33 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43edb40f357so9439185e9.0
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 09:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744304010; x=1744908810; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C3eUraqFELd4BdV/LtOqGjXSYUf0SlECUuRQ7OTGl58=;
 b=br/Ryt4l2So2WHviiWegDPmGGBlv70FPDz9uw3+XKM6uXrFn7ygI4Vnl3D+GN4/myA
 RRr+UesHyMHSNCKCKQsxjTl6kWhefzy/3ETW1A+jtBUjecvI7FD1tvlLidsHILi6JLmF
 sjhfyiydjbKodZLw3z7gd3gNkrlPevslnbxn7psFQ7lYlQOzjo9bU9TqZKA8iuoRrvY8
 KYhbXmFprJ5wQA9PqAED6Hq353wcPwd9GGJ1XVukP8xRe3Tm1mAmmRB642naYZ3JCziY
 mpoEqhmVQJY8RVm0bA77Lu3YXUXZjmlAHJp4ZTSn6IPs+kRmMpuiExnaqXewwGu5JK32
 6k0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744304010; x=1744908810;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C3eUraqFELd4BdV/LtOqGjXSYUf0SlECUuRQ7OTGl58=;
 b=onsfw2nOcXILn5kHhLJBacqVv1gs12KY36ubsKSlW3NdbRVEcEkLufn2b6Kt71D28Z
 jhD5q1qKVA3YcnCamUlb3ORozIjF/RMvhMYe8EFjvf2bhoQeReCVJChywM8oGk1SX4bI
 XuSy+5zwgMHNGQbzxDwYqPCFA3lM8Fqz40pFfYzLlb/WR47+WBd2tFbG6BuK1umy3/ZE
 8+TJhBekUnLDYv1E7xafubV8+AxH/SIqnp3OgRIcVcXyyMi4EcDG9X8aZZM2hc/uXgCN
 KfyrQx+jijr18yKRUXll7YomAggKkvF8Xl6YG24NhjLrjbEGCh9tC8BctsvDNVRzwo1X
 yiLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhuRWB6G2DNy32v8elUhh3iOrHafvdcKOZFToDYXaHwQYEXSm/8f6O2bcyUJY7DzC5fFiGKaDnbmys@nongnu.org
X-Gm-Message-State: AOJu0Yz93wHKTj7LgeSq22MDe37bleECbUDZh88DJVeRMRSAJkf4br/n
 CFll4YDQIrBrNhcBl6X4BGxsU2diXzKE6Y9Qv+g1NRaH8AMOeU29C+7fY16XgMs=
X-Gm-Gg: ASbGncv+QZDqMQT85RITn2AvXnZGleLlHkcmeX00Zc3DMexlPQ7GCgno2DLmITLB170
 x7/3mfNbTAbEECQFyy9duLPrp3ewabmud5+53jX1DWL5AaJdpegvEOyHmdq+1BVGVA+dGF8CDtp
 P9N4LfCZd74/8NcgXMuW9roVCfzG6pnrgTP5AJAJU/sVccm/iVPkVI6/XRe1J8N9pRNtqU1p7WB
 2AC2Q4IvEyPpBalRxxkCmvAJTJ93+HvW4ASowLJYg9+1bfO876fsCNlreV1sasgN4t5a54uBW3D
 sYdrlr2fuH13X8ID3CtKQ95rsN+3dQ1BaDvNMhsQOlsoZ874llaOgXiU/LKV+T/pDG55MFOt7Zw
 1Xyhs4xxlCdMZPhR+UciqaAyW
X-Google-Smtp-Source: AGHT+IEoBzhR6qco58Cftp/YQMaKqwvyxn2/rQX1pTIcRQbZT/zZVBR6D/avUrXeLBvGVxr2ioveFA==
X-Received: by 2002:a05:600c:c0b:b0:43d:172:50b1 with SMTP id
 5b1f17b1804b1-43f2d97d4c7mr34561515e9.29.1744304010072; 
 Thu, 10 Apr 2025 09:53:30 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f233c49f7sm56508515e9.17.2025.04.10.09.53.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Apr 2025 09:53:29 -0700 (PDT)
Message-ID: <9f950af3-57ed-481e-b753-83ee9691271f@linaro.org>
Date: Thu, 10 Apr 2025 18:53:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv: Fix type conflict of GLib function pointers
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Kohei Tokunaga <ktokunaga.mail@gmail.com>
References: <20250410161722.595634-1-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250410161722.595634-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 10/4/25 18:17, Paolo Bonzini wrote:
> qtest_set_command_cb passed to g_once should match GThreadFunc,
> which it does not.  But using g_once is actually unnecessary,
> because the function is called by riscv_harts_realize() under
> the Big QEMU Lock.
> 
> Reported-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/riscv/riscv_hart.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
> index a55d1566687..bb9104bae0b 100644
> --- a/hw/riscv/riscv_hart.c
> +++ b/hw/riscv/riscv_hart.c
> @@ -104,8 +104,11 @@ static bool csr_qtest_callback(CharBackend *chr, gchar **words)
>   
>   static void riscv_cpu_register_csr_qtest_callback(void)
>   {
> -    static GOnce once;
> -    g_once(&once, (GThreadFunc)qtest_set_command_cb, csr_qtest_callback);
> +    static bool first = true;

Preferably using 'qtest_cb_registered' boolean name,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +    if (first) {
> +        first = false;
> +        qtest_set_command_cb(csr_qtest_callback);
> +    }
>   }
>   #endif
>   



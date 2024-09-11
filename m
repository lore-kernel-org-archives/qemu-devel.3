Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66421EE01FA
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 01:38:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soCJ8-0004ax-U9; Tue, 10 Sep 2024 21:38:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soCJ7-0004Wo-Sj
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 21:38:09 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soCJ6-0004rr-79
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 21:38:09 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2d8f06c2459so4033832a91.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 18:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726018687; x=1726623487; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9JX2g3FxvbURSuBEFyrGMPujo6kN7QNWE7VfPOpiNh0=;
 b=H4okjqG0OYq3GAmqEGk9JfHBfV7JFQ2QPt63NyktzTDlS57yiCznhSGcqTGnStlfgJ
 DYyTXgqpGXJN+Snwl2Bgh4RRSZ6pR3fyhJQLwK6ufQqb9WxyW+kBqmXwmM8o+henC5tK
 F99yo3OlEEFuQm7l3Gkk56ZOCSEXRLqKEZe7WO9K7YO7N7V47/E1WV0LAyCOmNs5rSZ/
 ULKkzfBsz8/Hea3Awx0Kml8qZCbp9Y1MmxeEQPlEViZX+p0ZMsxTi/IuBr8P5sDDn2YM
 QPueUFXZOYhkUcBir65v2/2N/vtcc3oOCKoeueN5kVwZhRGCRd/j/dCnkMsnP26ZYYkH
 mKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726018687; x=1726623487;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9JX2g3FxvbURSuBEFyrGMPujo6kN7QNWE7VfPOpiNh0=;
 b=uN+dU1ExNUxj9QB0rho8RYj4+koXkHRzuwDTyJeZiWThng46F/5oLkON9J0Exx9xuF
 9XAWejCQbTfXnLRoO49nPznOJZMz+9jJpjtUkSdEo/GktnRWfdgvLFEaw9y5rJW4SCIa
 Z8U08zoAYXBvLWfBYSEk1Z0QGtmMRCODaFRXOy3XFuIbTzIkCGBeiTGNoqM55Bdn//Pi
 E/qCDkn2AfOEc3N7SejYyYDs1S+Ewrt09CiBG2Q19Xy8l2sW6wuGNw4hTBI1ZbBTHdrA
 3tISQmvzt7J5p2qoD75+dcAXX2Y7F0hoGnhzOPwHlLKenOpp6ahq7Q4efSmbH0KP63q3
 rUhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZq14Fl7Xc4LRXinvqQ2phLoXLlE7bWB9TKjnYnOcxmTEtj9MsJSlrt8Zuqhk4n7ZrKUqejKrosjzV@nongnu.org
X-Gm-Message-State: AOJu0Yx+kU9AWQeuwhPd32PtMPf7kRVC78jP5CdPmaX9AucIv7sE9JqK
 JasEBNPhIhgX7pwbNTOQo1I8wMO5VWLaYnK3flxWQeCTY2n+fFIT8rgKJzayWd0=
X-Google-Smtp-Source: AGHT+IEKGocNIZLcFXE8ttT9gZJEwU1I5Hc53wfMDMKFxE2ezxFO3e0ItJyK1d5s0Rcdlf1iFvjYXg==
X-Received: by 2002:a17:90a:fe8d:b0:2d8:8175:38c3 with SMTP id
 98e67ed59e1d1-2dad5018d0amr18254235a91.10.1726018686625; 
 Tue, 10 Sep 2024 18:38:06 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dadc03700dsm9227186a91.21.2024.09.10.18.38.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 18:38:06 -0700 (PDT)
Message-ID: <3614c8e1-b87f-4808-91b3-435313e2ea9e@linaro.org>
Date: Tue, 10 Sep 2024 18:38:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/39] hw/arm: replace assert(0) with
 g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-4-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240910221606.1817478-4-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 9/10/24 15:15, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/arm/highbank.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
> index c71b1a8db32..72c4cbff39d 100644
> --- a/hw/arm/highbank.c
> +++ b/hw/arm/highbank.c
> @@ -199,7 +199,7 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
>           machine->cpu_type = ARM_CPU_TYPE_NAME("cortex-a15");
>           break;
>       default:
> -        assert(0);
> +        g_assert_not_reached();
>       }
>   
>       for (n = 0; n < smp_cpus; n++) {

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


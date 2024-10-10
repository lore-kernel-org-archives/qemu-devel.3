Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BAB7CFC5E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 17:41:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syx9c-0002tf-W0; Thu, 10 Oct 2024 13:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1syx9T-0002kz-Sz
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 13:40:43 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1syx9P-000522-RR
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 13:40:38 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2e2ad9825a7so899796a91.0
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 10:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728582033; x=1729186833; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tJoNVS9Dg4LLNpo+2RSSXLDhaguG+t3TsyGfWz8uuR4=;
 b=EekWx6GxcxZcKSLegfY9iNMCcJ91NJ1SSwtthxTmfkn47ZcmlxxmEc8BgTsG/lRtyh
 9nN1owJOmhHJB6Q/LifX3KZUpppws+zrPnTpEY9LEroNJS2jSToUHmFTIfrIOXAJ8B6B
 7UwPp1wNlWeytLitoQqXdfA4C7iRFVWh5GUyYfnDtfLtAfcHw3HK1w/eB+J+4Y54kxWX
 3/5WhvJcAezSCJ1YE+5ESBrXtJuwRyjhI7hIdc2ZWPRfvv5HFLs7lxfd3zeyvtXWsceV
 XE3OXQnM1stcy263qFgfhj6OImsH23Rsm/DUWb/aUhvw7NyMDNulsu7FqGJSoCU+dvmt
 d3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728582033; x=1729186833;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tJoNVS9Dg4LLNpo+2RSSXLDhaguG+t3TsyGfWz8uuR4=;
 b=gGL2/028KtR5zWPtylbG5JEDzwhLDwd+V8ue3OM0bnXnACQOGpLue9C7tI36WGsEaJ
 z2Lrk9XgQH9nbkAfZPL5Om8M+1uUc/v/FjhcXVxJH3QTDAywvieP7uGv0InSAx5cGD2O
 jcXux5+QWOQvvAcTmsEf2djVfHf8kFhlglHSiFUBlP3OUhIR8IXrbj89QKjOeypt+R9G
 2t7pVPv6YOSPfeXcD81nhsJGa/XASrXAtGw7ISZJK28Y6nfVsObht+ppdIRPq9rTbN/T
 RJHgUJ2qqeQHKQCVNfwY9Yk+zaPuW1Xhc2/H0YPEHHCI8fQOiEtt7BWW9I7q6GTn30Y0
 nWLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWstMVfgymXJQbIEqKgACtzBHmkZ0cpyIRH7T88XNCkrG7XgFd64RPug2PjyM0LA9DVvgvwQECwhWQs@nongnu.org
X-Gm-Message-State: AOJu0YygMaRW/fEBnrJfu0SRRmSTRCBGUlwA+P7KV5Eo5iztWwRKjjqd
 pCcZ+H/PCUec6i8so6+kLr4GhlEXMCQHo1ymuFd8m0fpa4aG8VwoYuvuPdpUemiFQj3u2Nc2UHL
 V
X-Google-Smtp-Source: AGHT+IFKeq8s5A8ZiHsmg2ewtAbAQJdJvxD2JMUjw5VWiZPm5GqbGuRFgRkMRGxb1gzcfIS4UYK23Q==
X-Received: by 2002:a17:90b:4d0f:b0:2e2:e09e:b910 with SMTP id
 98e67ed59e1d1-2e2e09eba67mr2020520a91.19.1728582033330; 
 Thu, 10 Oct 2024 10:40:33 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.89.169])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2d5df1133sm1632353a91.15.2024.10.10.10.40.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Oct 2024 10:40:33 -0700 (PDT)
Message-ID: <db943e63-4968-4cb6-885b-3cd479ba8962@linaro.org>
Date: Thu, 10 Oct 2024 14:40:28 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] hw/intc/openpic: Improve errors for out of bounds
 property values
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: xieyongji@bytedance.com, kwolf@redhat.com, hreitz@redhat.com,
 Coiby.Xu@gmail.com, pbonzini@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, mark.cave-ayland@ilande.co.uk, michael.roth@amd.com,
 kkostiuk@redhat.com, qemu-block@nongnu.org
References: <20241010150144.986655-1-armbru@redhat.com>
 <20241010150144.986655-7-armbru@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241010150144.986655-7-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x102a.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/10/24 12:01, Markus Armbruster wrote:
> The error message doesn't matter much, as the "openpic" device isn't
> user-creatable.  But it's the last use of
> QERR_PROPERTY_VALUE_OUT_OF_RANGE, which has to go.  Change the message
> just like the previous commit did for x86 CPUs.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   hw/intc/openpic.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
> index 32bd880dfa..cd3d87768e 100644
> --- a/hw/intc/openpic.c
> +++ b/hw/intc/openpic.c
> @@ -41,7 +41,6 @@
>   #include "hw/pci/msi.h"
>   #include "qapi/error.h"
>   #include "qemu/bitops.h"
> -#include "qapi/qmp/qerror.h"
>   #include "qemu/module.h"
>   #include "qemu/timer.h"
>   #include "qemu/error-report.h"
> @@ -1535,9 +1534,7 @@ static void openpic_realize(DeviceState *dev, Error **errp)
>       };
>   
>       if (opp->nb_cpus > MAX_CPU) {
> -        error_setg(errp, QERR_PROPERTY_VALUE_OUT_OF_RANGE,
> -                   TYPE_OPENPIC, "nb_cpus", (uint64_t)opp->nb_cpus,
> -                   (uint64_t)0, (uint64_t)MAX_CPU);
> +        error_setg(errp, "property 'nb_cpus' can be at most %d", MAX_CPU);
>           return;
>       }
>   

As another cleanup we could convert MAX_CPU to unsigned.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



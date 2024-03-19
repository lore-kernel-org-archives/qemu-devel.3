Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50302C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 12:54:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmYzG-0000MU-9j; Tue, 19 Mar 2024 08:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmYzD-0000M1-Ds
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 08:54:36 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmYzB-0002qe-Qa
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 08:54:35 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-41465864644so3196515e9.0
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 05:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710852872; x=1711457672; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EG9fPADsK9KF9HCW1kMDIU7fDHxKBh/+fo0PZPsFexc=;
 b=Jn/5G4gWKPrYUEFJGF6hvdGpvqpGLaig5REFxjXtebs2kbOijaxX3+mfMHnH8nWO+F
 kY9RjlmmuKq+Wknu44M7fhgXN9n7uHJVXWAc/pHbtB13+opkMX/r5nLm6Bts1ucsiGt3
 eWqNpWwfx9+YSzs9YHJCur2Hy44860/tykI/2A4FUrIVx+eMuw+fGyydxmOGeeOs6zvN
 39H7LL5pQdRwA+wLMBZNWeHR9IW0Opua5fuJi5r57CFwMY/jn6fjZ4Llw7eLBLpZyigK
 /2gOyCkjy+2b7W90yVQqrHTRH9t+mklyRomGb6uCMQ/QiOqv/gupo8n9QI3xQJOPG4Lw
 pe2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710852872; x=1711457672;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EG9fPADsK9KF9HCW1kMDIU7fDHxKBh/+fo0PZPsFexc=;
 b=Rw2NtnCd1SNFvMckVYL04S0wTbjOOdNssCFSAkqvJ+UN3kSetQg4VcBD9W+2PnYKhC
 3Z/d0YwcLfR6FkRoBwOUMZFW+JuJ3TGNIC1Ha01Wdy/P3ZtOxC4rQoVXMGgm8bXU3UfT
 n3wPPGN83Oq8Yinm1dxDzJOZv8PtD0LTf6fsk+IHIcT72TL/7hhLUIDKtmyaxJOUoSKg
 R5xXObVTIWvDFQvHnd+3QCqDOpGHylRduIMJa6k81rnm6AP7dSti98uU4hTEMT13Amme
 s87kCQhdJtvKlRrNJEBHX0qgAfZQhh3Y5FoUnZgqVgCXlVQwTrg34Z/bneL4vwS8Vbg1
 wt9A==
X-Gm-Message-State: AOJu0Yygvtb8LgFeupEM7oZ27azNg4hRtmleCXGbyDxleo2rbv/T0JI7
 +io5pSwC1VvRi2OYExxFV9Px6O5MYpPfpYaiua5elL+KdV2ugPUMr3JDOUgwKmkIAg/zI5HPZSH
 Y
X-Google-Smtp-Source: AGHT+IEpXXjV3B1A33uSM0yIkSLKVeugRWuWAyuSfplz+mHpuvVCjFrorIa/D2SktK9ij/CRnfV8jg==
X-Received: by 2002:a05:600c:3d13:b0:413:fae6:4d3b with SMTP id
 bh19-20020a05600c3d1300b00413fae64d3bmr2407305wmb.12.1710852872191; 
 Tue, 19 Mar 2024 05:54:32 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.166.129])
 by smtp.gmail.com with ESMTPSA id
 jg24-20020a05600ca01800b0041468cb6389sm314674wmb.9.2024.03.19.05.54.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 05:54:31 -0700 (PDT)
Message-ID: <c7cd0119-0c8b-45fa-93d5-de25fb8f6a6e@linaro.org>
Date: Tue, 19 Mar 2024 13:54:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0] monitor/hmp-cmds-target.c: append a space in
 error message in gpa2hva()
Content-Language: en-US
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>, dave@treblig.org
Cc: qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>
References: <20240319021610.2423844-1-ruansy.fnst@fujitsu.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240319021610.2423844-1-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 19/3/24 03:16, Shiyang Ruan via wrote:
> From: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> 
> In qemu monitor mode, when we use gpa2hva command to print the host
> virtual address corresponding to a guest physical address, if the gpa is
> not in RAM, the error message is below:
> 
> (qemu) gpa2hva 0x750000000
> Memory at address 0x750000000is not RAM
> 
> a space is missed between '0x750000000' and 'is'.
> 
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> ---
>   monitor/hmp-cmds-target.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
> index 9338ae8440..ff01cf9d8d 100644
> --- a/monitor/hmp-cmds-target.c
> +++ b/monitor/hmp-cmds-target.c
> @@ -261,7 +261,7 @@ void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, uint64_t size, Error **errp)
>       }
>   
>       if (!memory_region_is_ram(mrs.mr) && !memory_region_is_romd(mrs.mr)) {
> -        error_setg(errp, "Memory at address 0x%" HWADDR_PRIx "is not RAM", addr);
> +        error_setg(errp, "Memory at address 0x%" HWADDR_PRIx " is not RAM", addr);
>           memory_region_unref(mrs.mr);
>           return NULL;
>       }

Fixes: e9628441df ("hmp: gpa2hva and gpa2hpa hostaddr command")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



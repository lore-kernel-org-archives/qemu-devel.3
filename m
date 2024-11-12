Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53064D42BA2
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 15:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAtAX-0001Ag-EQ; Tue, 12 Nov 2024 10:51:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tAtAS-0001AP-24
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 10:51:00 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tAtAQ-0000u9-Dt
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 10:50:59 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20cbcd71012so68125415ad.3
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 07:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731426656; x=1732031456; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aUiu92Y0oL0J0dGkA+Ji9vGJiOqJYWXz+jG6orxRY9Y=;
 b=uxmiMr88crPQBrne+m0lv9PqYPKK5ufLagAgGQS3KOmAsNs9Nfldwl6FPKo2H9gQr2
 UlE4Oza5dO7UnSE8tOmnjsju9CeEc8HO6+coAa15jLYtpJULk59PIST4DryUMftr38yx
 y+rO39x8XCpYZvEjzeBai1lOYmnuUIIroCSXg7h2WOVgV3iVTcCnPgsIqjboTaF469kT
 Sp2z9m1p99qgZnZUZ1crif8+fv3lxNuT9Sr5yQeBrKnxyZpSHt7KcCGGDr1rGH8LpFQV
 boR8YGilTLP+M8sNlG+4zu41xmVq7TL9pcN/OXA9KO7QQh9g0r1OtivQ9QUIImYRAPJO
 /9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731426656; x=1732031456;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aUiu92Y0oL0J0dGkA+Ji9vGJiOqJYWXz+jG6orxRY9Y=;
 b=mAisNsiK408jeyJW6YyyDMcckUyTU4j48E7pkdV65Am9try/OifgV+BA8XrjNe9KCZ
 Ht//imi+b43JnbyF7jFhD3RZAZVC+bZgZu7+83DrROeur5sDTJAqDjONxHOqiu87iUmv
 eZYprMVAWvjA6TxL9tBUb+8i/SW1iBBdEvGzF46KY5lwcW9j0Mt7jITR3s7ovAde55Ia
 hQ8CWtPowGEEDKfODofKln+sSYfrv0e/mgo2K2392O8Z93d20tgit/BJo1Sr59gsV7sV
 GYNc9qmmYs6n1PMUy1nYUHNj+jYgrGZpVogXPQgklOTJgjPqMROyeEp3DlGpYFRzW+L0
 1rog==
X-Gm-Message-State: AOJu0Yx7Fl/5gHY3oC3/btXq9rpeIoLoX4+RE/8gqcDUKmmDU8ASY6x/
 RQlpihSUtzgsHsRTroMe+JuXYbWceSi/6o823zFuV6J91mLQb/pY1wX5VjYuuWA=
X-Google-Smtp-Source: AGHT+IGm+TqOXGdwIOwOLzbjlttvbHulz0H91iUbKVMczWIhwKwERRfrwLN33U4K7RQmM8f3UXgw2Q==
X-Received: by 2002:a17:902:ea10:b0:210:fce4:11db with SMTP id
 d9443c01a7336-21183517ca8mr247122595ad.22.1731426656688; 
 Tue, 12 Nov 2024 07:50:56 -0800 (PST)
Received: from [192.168.52.227] (wsip-24-120-228-34.lv.lv.cox.net.
 [24.120.228.34]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc970asm95092085ad.52.2024.11.12.07.50.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 07:50:56 -0800 (PST)
Message-ID: <dab7363f-48b5-4f15-893d-1621ec9481eb@linaro.org>
Date: Tue, 12 Nov 2024 07:50:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Add missing mmap include
To: Patrick Leis <venture@google.com>, laurent@vivier.eu,
 peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, Peter Foley <pefoley@google.com>
References: <20241028181821.1440988-1-venture@google.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241028181821.1440988-1-venture@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 10/28/24 11:18, Patrick Leis wrote:
> From: Peter Foley <pefoley@google.com>
> 
> error: use of undeclared identifier 'MAP_FIXED_NOREPLACE'
> 
> Signed-off-by: Patrick Leis <venture@google.com>
> Signed-off-by: Peter Foley <pefoley@google.com>
> ---
>   linux-user/user-mmap.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/linux-user/user-mmap.h b/linux-user/user-mmap.h
> index b94bcdcf83..de769f9253 100644
> --- a/linux-user/user-mmap.h
> +++ b/linux-user/user-mmap.h
> @@ -18,6 +18,8 @@
>   #ifndef LINUX_USER_USER_MMAP_H
>   #define LINUX_USER_USER_MMAP_H
>   
> +#include "linux/mman.h"
> +
>   /*
>    * Guest parameters for the ADDR_COMPAT_LAYOUT personality
>    * (at present this is the only layout supported by QEMU).

In what context does this appear?
Both glibc and musl define this in <sys/mmap.h>.


r~


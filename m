Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E81E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 16:16:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWHfy-0002jH-2t; Fri, 10 Jan 2025 11:15:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tWHft-0002iW-UY
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:15:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tWHfs-0006L8-3g
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:15:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736525751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=s2ivryGAMaiHRdKGdVxe/oQdelFs70aXh7BQDhHMrIw=;
 b=YPLwLmyJmbN2M9u1F/ph2k0OJR6hpqcnEZt5uiiIU8ZXiSBUT0RpUDsjxiLasFjhyXAjcI
 tbUcnz7RukhavJe7N4hEweq6PJ6HPHZeIgbMIs4WBxYOXo+2j0k4DNZcQjeyXy/DyHO9ZM
 bdWFE9SsN2x1nQj20Vcn+RyJa9t/Z3E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-phMTLs5HPyOFo450LM3OBA-1; Fri, 10 Jan 2025 11:15:48 -0500
X-MC-Unique: phMTLs5HPyOFo450LM3OBA-1
X-Mimecast-MFC-AGG-ID: phMTLs5HPyOFo450LM3OBA
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-436723bf7ffso17928435e9.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 08:15:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736525747; x=1737130547;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s2ivryGAMaiHRdKGdVxe/oQdelFs70aXh7BQDhHMrIw=;
 b=NQy4UH5sHX2sGkdcZ+gT4sSYSITBUNVg9UJyis1NF8Hws7iEjw0lzOKRItjg2rjQ8w
 eXWtnJu2gJq7VSgr5pCvgfXsWcUWkoUF6r9ijwlBtTkapautgb8P9h5u+4q31ekx1G57
 wxmk5qpE87LYKBxuBp3jcziK8whSPkKr/unsJANaFshQx2UUo+wBa4pErvjh0iG21nWD
 K0ZMmQTIJbf3FiIsQY2/lS2+Ik66rwioke3NPtuHNoaipx0hMLruMRwNccydcpFv2xDH
 3ytpdtPhFF9vzk7cZeCugm4dfa8CPxJW72cEA1ItdrR1oRA5qHaYcs2q/UWBwjFz3Z9k
 rcLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWb0NH+KY4WqZ7Pr0MHLqWsJ+e6iy8BtEJUOyCkp2KtZpHRUuwAeTvF43pDSzDF7t4y1adIoc2eNFMa@nongnu.org
X-Gm-Message-State: AOJu0Yz9QOvrDFgLgxWsveC5TuwPcaUFunZtF8dAgRpYxlQ9Ubw/UY0S
 pD9+fvftUY2VKn++KUXRmkbAH+qd/+VxgjRZtHUSc5dVbiD990XJX1lrNejRebdRUc4bdljRijz
 K++GrJhMjlny4FyGptZJumFamwMf4hSzN2++8q3J9YjC/qhYlSfEZ
X-Gm-Gg: ASbGnctAxcGY74Ng2IKrxLB2OBxv/LZmZQQhyh2xaGXQxJYtcqCQ0pxVsdcXSu4hmFV
 dhd6vpCUEH5qB8FpZ+8GYCp4JhdJwEZGPwJko7WPwcHRStXE1fjRVw7zMObvFHXF7LW+5eff0mW
 7DBADtuP5Ur7YQH7akb+cV7et4VjasJDVMm5tJk5T/TG87SVWKNU9xtGFcX8NN3sXnYUIgjqWW7
 tAeIyy2o+5qbyDoLJ3YdR7fASkLBrLZuUMydNX/+Pwjrh4oVBA4Jc1dftMhB2t45N7TEcfEtqqT
 utToz1KmuLDzBplshs0=
X-Received: by 2002:a05:600c:46c3:b0:434:fbe2:4f with SMTP id
 5b1f17b1804b1-436e26e1d21mr46925765e9.23.1736525747590; 
 Fri, 10 Jan 2025 08:15:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0Nq5/HKes7iK9WtES4dIKYEqtQOa5OM3KVmCg086s9pWQXALHU9qJwzHckVzbZZwn6vDgjA==
X-Received: by 2002:a05:600c:46c3:b0:434:fbe2:4f with SMTP id
 5b1f17b1804b1-436e26e1d21mr46925515e9.23.1736525747232; 
 Fri, 10 Jan 2025 08:15:47 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9e62116sm55924885e9.35.2025.01.10.08.15.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 08:15:46 -0800 (PST)
Message-ID: <2802dbe4-8c6e-4637-94b6-fc2c4ef82f10@redhat.com>
Date: Fri, 10 Jan 2025 17:15:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] ppc/ppc405: Remove cache handling instructions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20250110141800.1587589-1-clg@redhat.com>
 <20250110141800.1587589-8-clg@redhat.com>
 <4344c965-ec42-4159-83c3-84ccd290fa2c@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <4344c965-ec42-4159-83c3-84ccd290fa2c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 1/10/25 17:09, Philippe Mathieu-Daudé wrote:
> On 10/1/25 15:17, Cédric Le Goater wrote:
>> Since the 405 CPU family was phased out, these instructions have no
>> users anymore.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   target/ppc/cpu.h       |  6 +-----
>>   target/ppc/translate.c | 11 -----------
>>   2 files changed, 1 insertion(+), 16 deletions(-)
>>
>> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
>> index 504924f10561..f83f01a62a12 100644
>> --- a/target/ppc/cpu.h
>> +++ b/target/ppc/cpu.h
>> @@ -2234,9 +2234,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
>>   #define SPR_L3CR              (0x3FA)
>>   #define SPR_750_TDCH          (0x3FA)
>>   #define SPR_IABR2             (0x3FA)
>> -#define SPR_40x_DCCR          (0x3FA)
>>   #define SPR_ICTC              (0x3FB)
>> -#define SPR_40x_ICCR          (0x3FB)
>>   #define SPR_THRM1             (0x3FC)
>>   #define SPR_403_PBL1          (0x3FC)
>>   #define SPR_SP                (0x3FD)
> 
> Belong to patch #3?
> 

It could. These are the Data and Instruction Cache Cachability
Register, so they could stay in this patch too.


Thanks,

C.




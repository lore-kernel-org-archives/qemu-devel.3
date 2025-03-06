Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6236C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqE0N-0003wA-Ah; Thu, 06 Mar 2025 11:23:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqE0H-0003td-6J
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:23:21 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqE0F-0002a7-6d
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:23:20 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-223959039f4so18254335ad.3
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 08:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741278197; x=1741882997; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C6PlerNKSjJtX4hzeX+y+ge8P8T27t3fwfERe3UKI/Q=;
 b=IyUMwtXvMdYPw7GHmRrGdUpc1j40Tmlorw4B0a1oYtZdz81TnORDVq+ydq1/8ACPkS
 SWlN2UScy3aZuyveO+Ys2H3lhuHq/6DsUzfCdwXHvq4Ib9gSoRSfZQM5GALk8qdjvMoU
 V/V/dQuUC6HeR4uRpGTRYTN0ZcGeVtnFD3g0e3JFbLhfwy8rqVZDthT1yzw3fankzkTX
 xPTV3swIKmQa7K9hHIAwQWp90kDHDg1/ir5asO7ofvm0wkBPPmCcuGD36vIVn0BraU6p
 6J40qd0qYBITmZVQTGypVlxbR2HWdakMYFV0X4KmQEHDv5CIbLDYUMcEkpQtFW6GilAM
 /veQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741278197; x=1741882997;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C6PlerNKSjJtX4hzeX+y+ge8P8T27t3fwfERe3UKI/Q=;
 b=K4Sah6dhiFqqhwePwlBm0liOwp+x0VAbhiE+wgpIWpGwMsX/A4rF7VUyP4IP+3NKW1
 xoDdC1MTUBwwadFyHr50bvlESoDRjHh3LGADHG1+CSKLsDl6Y+Z4gliLI9sjymRj6Ssg
 s8PVXTotsQFsBFG1s8/eayvNvAr2rY+l1ye/gdVdHXlA30SSl4MHRfq+Lafm4hdBpUik
 9KF1aKTdnP9xCqqJvSIa8Q7nTmM9t9skUUrvNpj4LksmzFm9aCvvnRnrZl38WdtLi9dM
 +rgz35yowkCg1Ez/h8RYFmmKaPsuY7g3ZznIt59ycknsCVDKf/MRMaQh/xvL3P3yRGSe
 y9uQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWczImXSUK6SfdY1rtJSDa4lnRMWYglO0Pe0PFQR6gPrYd7f+jwj/wfZj4MZpxfkgSSqxfiai+6asR@nongnu.org
X-Gm-Message-State: AOJu0YwttYwleoIdPFqrSDj9rt6UrmfN+vsA8P1c+SKA0EcMjF150zsW
 4FMiuvUaWBgTAxo/WgNGSTSQloDW739gbjzwqZuJs6ay351dSFse/0LXjcbHZjM=
X-Gm-Gg: ASbGncstrpCUghizRsL50WuuREGymmcENvHNbMAQroP58ZDpmsYmC8rGqBE3RhyJivl
 UR2mMmNF/EG/D6KgK+pCu4WYpZ51j9ipTuuQ0gMCHOwFIIjS6tITkZSngkPloOqDOJvCbaC9kJc
 TrCcn/c07ebH1uk3XUKVrPQzhnIDlUfeDmbWlhMndYKiSvETKnlMq4TPRhbNyZDCeWB9t1gd2fK
 2h4PcXMG6LPFXqW/fvQp9cmZrMHvFBu2S74TBCilRcDWqjq30pbM53OKhcnG7+jLD9RAm8szLV5
 BWMUQHthxIpboJjJohwp5Ly8+cRa5dMHAN6ln6sJbMrVwIyeENEO24JdHA==
X-Google-Smtp-Source: AGHT+IGPukPJ1Cveg09G9PPBBGq/K9XkdCaNM6ATjpnSL1yJJBCPMSzv39EZqWf5lFyewJx8dLFfTg==
X-Received: by 2002:a17:903:1c9:b0:21f:507b:9ad7 with SMTP id
 d9443c01a7336-223f1c973d0mr129475305ad.25.1741278196907; 
 Thu, 06 Mar 2025 08:23:16 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-224109e8587sm14415125ad.62.2025.03.06.08.23.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 08:23:16 -0800 (PST)
Message-ID: <35c2c7a5-5b12-4c21-a40a-375caae60d0c@linaro.org>
Date: Thu, 6 Mar 2025 08:23:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] hw/hyperv/syndbg: common compilation unit
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, philmd@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, manos.pitsidianakis@linaro.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, alex.bennee@linaro.org
References: <20250306064118.3879213-1-pierrick.bouvier@linaro.org>
 <20250306064118.3879213-6-pierrick.bouvier@linaro.org>
 <353b36fd-2265-43c3-8072-3055e5bd7057@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <353b36fd-2265-43c3-8072-3055e5bd7057@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

On 3/6/25 08:19, Richard Henderson wrote:
> On 3/5/25 22:41, Pierrick Bouvier wrote:
>> Replace TARGET_PAGE.* by runtime calls
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    hw/hyperv/syndbg.c    | 7 ++++---
>>    hw/hyperv/meson.build | 2 +-
>>    2 files changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/hyperv/syndbg.c b/hw/hyperv/syndbg.c
>> index d3e39170772..f9382202ed3 100644
>> --- a/hw/hyperv/syndbg.c
>> +++ b/hw/hyperv/syndbg.c
>> @@ -14,7 +14,7 @@
>>    #include "migration/vmstate.h"
>>    #include "hw/qdev-properties.h"
>>    #include "hw/loader.h"
>> -#include "cpu.h"
>> +#include "exec/target_page.h"
>>    #include "hw/hyperv/hyperv.h"
>>    #include "hw/hyperv/vmbus-bridge.h"
>>    #include "hw/hyperv/hyperv-proto.h"
>> @@ -188,7 +188,8 @@ static uint16_t handle_recv_msg(HvSynDbg *syndbg, uint64_t outgpa,
>>                                    uint64_t timeout, uint32_t *retrieved_count)
>>    {
>>        uint16_t ret;
>> -    uint8_t data_buf[TARGET_PAGE_SIZE - UDP_PKT_HEADER_SIZE];
>> +    const size_t buf_size = qemu_target_page_size() - UDP_PKT_HEADER_SIZE;
>> +    uint8_t *data_buf = g_alloca(buf_size);
>>        hwaddr out_len;
>>        void *out_data;
>>        ssize_t recv_byte_count;
> 
> We've purged the code base of VLAs, and those are preferable to alloca.
> Just use g_malloc and g_autofree.
>

I hesitated, due to potential performance considerations for people 
reviewing the patch. I'll switch to heap based storage.

> 
> r~



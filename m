Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E58C87FCE
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Jul 2025 01:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufTm6-0008U4-UK; Fri, 25 Jul 2025 21:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ufTm5-0008Sq-SN
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 21:32:33 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ufTm4-0001vR-0v
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 21:32:33 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-23fb6415a04so8361595ad.1
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 18:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753493550; x=1754098350; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cP/oowYCDx9Dh25/iDMCE2Rq3nYC9SehmMWDlPNE5u0=;
 b=beInMF4JMDL7TWv3eZ5kLAlnOi8Yuv2B+zF1HpVXNXInbWoZgUWOSnN2f+KFLj/w7C
 0w6IqjWamOG+yr9vIb824Wa+/bafV8cBiYYWi11FrOShq9EZRe1W6DItTJJ0TBvTkyLZ
 NxjcnhkIko76f79Nas3TRvv7Maqrm5AYe9wF4f+pCt3l204IpZJDEj7RWAzLDNqOHkXG
 0wLJbrjwNSjf5V1bfd3ltyiG3s3C10TZYXa/j43zpGpOe4foDe6iALxKCBZQpbX5QTl3
 z9Z8rFq//0JSx8IAQJAl5BmxzB05RvsGyQzcKqQzi/wIcrU2U4Fj1DfOnC1Cn3XfsvCo
 RZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753493550; x=1754098350;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cP/oowYCDx9Dh25/iDMCE2Rq3nYC9SehmMWDlPNE5u0=;
 b=luUn79n54NlnL95LTSWYYVDu29FrQKyjjhyCek8WzaXmpoKvHWyHzShlkuJ5ogTaok
 k6HN3KF3VdJ3odM59m/vzpnIUQj3yZOq+qx0ccb9sFx5uS9vQq4NknydVUzgJBAFF48b
 xT1n7D/46Y9hdlwhHjGBbqT7FC82NjBWUDGx1+mPkSBiwNFM/X7vWM8PV6dwN8rtAGNR
 C2sHul/f6r20sGPQMvS53k0eMqQ6aiJ8idDZ7IHwB3zU4x8PGEDyvaHOtnG8fHLar12Y
 /MHEIdRZZaKNU7X5cXWH63aZG2jka50SrpwJL8yGDXTzN9FUJ2IYZbuDtnl60ob6Hy+M
 zc3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPsyHiY1IMeVHhW9coeDIttyUtlKQNCD2rVyeTIvfEkbgUuq0IlRytRoJDI1lR9gBn3e6UXcG/cOwz@nongnu.org
X-Gm-Message-State: AOJu0YxYME3GAA7Rh2gv7i7q47rjdYrZjNA0oQJc8HAAj8CZ+h66Be17
 p3z37neGK/6NqeyPoI80b2iOV+Sq3n9nj3RRJqQfslA9HdRzKnxzTYSWCTAA7k5Tr2A=
X-Gm-Gg: ASbGnctHR56kEitmjFlGISGvdYyHYa9HMi+PnvkOYff26IJkhbmvZ57l0x2D9L4Bs8Z
 di6EZTkRs5kCq4j3mQMOjmJ38A5OUHLfrsRD8V7TdFbny0Fab40PWTI7iOoM+csDqO5NI6RPaXt
 tZTOGLGhUUWtNPA5uWJ/r82cgbxUV0SAyNbCXRoRARRSc/a0UwoJ/3G5veaGzQM5qk4oaHey4yU
 aCeYLLxBnnnUqC8/VHDLRwrz4o8RAp/AWGWMyU5sS4KxaL/Yp29yAAsM10WiQsRzsHVInkhtB+7
 Dhy42HNyzvDfU3Y5KbiMPEsDexbnimNbMivwwPPyppbbEPhruBqHDF3Qn5yXHYZwEvYxvNEAD4l
 gsINVwowWgYdVKpxCPev+abQFkgKz3yr6WFk=
X-Google-Smtp-Source: AGHT+IFTSsXStIg4LQpgCFgr/CRXhE+un4odjydhXCtDnAgb/9DvhvRF/I5/0dDGIMH6TAy9PugGhw==
X-Received: by 2002:a17:903:187:b0:235:779:edfd with SMTP id
 d9443c01a7336-23fb3156110mr59856115ad.39.1753493550303; 
 Fri, 25 Jul 2025 18:32:30 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe5656adsm6297605ad.188.2025.07.25.18.32.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Jul 2025 18:32:29 -0700 (PDT)
Message-ID: <30d55731-56a1-4bc5-8e26-8055c3142790@linaro.org>
Date: Fri, 25 Jul 2025 18:32:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] include/exec/target_page.h: move page-target.c to
 header
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250725202016.21325-1-pierrick.bouvier@linaro.org>
 <20250725202016.21325-3-pierrick.bouvier@linaro.org>
 <43139d06-4844-46a2-934b-ee0c6bdcb991@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <43139d06-4844-46a2-934b-ee0c6bdcb991@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

On 7/25/25 1:38 PM, Richard Henderson wrote:
> On 7/25/25 10:20, Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    meson.build                |  2 +-
>>    include/exec/target_page.h | 11 ++++++++++-
>>    page-target.c              | 10 ----------
>>    3 files changed, 11 insertions(+), 12 deletions(-)
> 
>> diff --git a/page-target.c b/page-target.c
>> index 8fcd5443b52..66f03c61cd4 100644
>> --- a/page-target.c
>> +++ b/page-target.c
>> @@ -9,13 +9,3 @@
>>    #include "qemu/osdep.h"
>>    #include "exec/target_page.h"
>>    
>> -/* Convert target pages to MiB (2**20). */
>> -size_t qemu_target_pages_to_MiB(size_t pages)
>> -{
>> -    int page_bits = TARGET_PAGE_BITS;
>> -
>> -    /* So far, the largest (non-huge) page size is 64k, i.e. 16 bits. */
>> -    g_assert(page_bits < 20);
>> -
>> -    return pages >> (20 - page_bits);
>> -}
> 
> You didn't completely remove the file, though you clearly intended to do so.
>

Right, thanks.

> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~



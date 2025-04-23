Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2183C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 15:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7cUV-0007v8-Te; Wed, 23 Apr 2025 11:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7cUT-0007tn-Ux
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 11:58:26 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7cUR-0007B0-P7
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 11:58:25 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22da3b26532so129205ad.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 08:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745423902; x=1746028702; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2nUE3mex3D/jitPRu1rnZ3zvB4izf7uzkRN4YSnQwAY=;
 b=nJlaIpWw78p8EfVAwN9lxjkA3UgV1OEj96ba17bIIXjTRD9Bihc+Yt49uXEf+09HQE
 i/qsxdaD+ZaZ4RLRxWG/hlREru0LKzZhaetCj4njduS6KqObH7nD5gJW09/VqGVC/R75
 OGku1u4SHmfadG8speRJoZIP26F8MPMrqazYQjMsGGeZ3BDrky45tJdzTnEz2KTlX8in
 z98Euk24d2n2xpMlHOOgtclyZHv+ZIcAjKm2ssU26jZiKOhAv/Gk4yKgKTDL1AeRoirv
 h6vNxlPwNYGSpmL1L8Cz/3HwMwL45eTzc/zsyP9a+jLov+XwBCpBE9LehY9gDJ85BUqW
 5tZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745423902; x=1746028702;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2nUE3mex3D/jitPRu1rnZ3zvB4izf7uzkRN4YSnQwAY=;
 b=mY/4YMYcKECgz4ftwMosRXfvEvMMASyoZunJxyIzeAKkRIC3pcEXR+6KRP7ZpRJ3oy
 u4xA7QTaQCNQCnTCljaCIL3XcfRFz71GHb+S07bqrNGN6Z8Hw9Ud7cOpzKnT01fRnNjL
 MfYk4SJpP4JND7NhcfEtQLsItx7+1HAFKGcw8/m0cG5aqSBMAjknCRZ+lV1yheQ9HQVw
 rBDj3ImnSRktgC0ll/3nNtH0aYyy379qb8b9yvei83rpDwP2x9IC1NyVj9CzuHnCcwGU
 cVT0WMSdAK/x7X7CYIJI4hrboO5SH+fRRmTDift+Sx1to00MCFjEM1pTMwNsOJXF0zAE
 v+AQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWg2uTxHcLlN+Beh4K5cWHb4d85TwXZWmQmjfn3DhNSnKRhVM2XRvUu2PYDVmBxI0X0lrF+p5Lo5tRI@nongnu.org
X-Gm-Message-State: AOJu0Yw0CfSUJPLd17l5M0Id3Uw068Bke8fP9Yx//L611wyxxJDWYSqO
 mvUmW4GDsrEVyDSaxwRIuR+a9GB/D+2Cphfl9iSxIzsSC/wN0RFviKoE5nCs1t1DW1oytizNuXM
 S
X-Gm-Gg: ASbGncu2ZLWN2Ao/AXkRix7krXgecZ17Xov1PC5SDA66t4IRjcp3fXFH+w5CsFGYpN8
 6huW8GO4V0xbEeidm98SaskAwA3rs5bfHBQ1et3GyO4QoJ/79iqzPLRK0SzuxwmSQUm9/HfqlIJ
 7rs4b6cT6l5eQJQuiA+Ywj8+Yh4lmzTcM0iUgIYe63LPd/+/NAHDPKWQn8ZbJZ1PVzFNxa9eOQf
 W9vtGU8VUViG2vny06T98sHND9C5MtG6XpJuUc/asku5K8NG98gorsz13IBc9cMDjbTeJfUYFOh
 4OQj+ZqVW71xv+qukD9l9jk+2CthQcZ+I7l8r884H6wyUt9jclKjlw==
X-Google-Smtp-Source: AGHT+IHt2q+a3PC3LcHrbOB2hCRduXQ0LMLEos3DVCJigDKkk0w2NyjnbJum0S9rfOUr3jVI9hRoqQ==
X-Received: by 2002:a17:902:ef08:b0:216:393b:23d4 with SMTP id
 d9443c01a7336-22c5356713dmr310920185ad.11.1745423901721; 
 Wed, 23 Apr 2025 08:58:21 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fded99sm106646215ad.223.2025.04.23.08.58.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 08:58:21 -0700 (PDT)
Message-ID: <f54bd881-f75f-4a89-a293-7d49f82748bb@linaro.org>
Date: Wed, 23 Apr 2025 08:58:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 013/147] system/xen: remove inline stubs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-14-richard.henderson@linaro.org>
 <dfcf9c43-4585-46e0-8d7c-0855d348c38a@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <dfcf9c43-4585-46e0-8d7c-0855d348c38a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

On 4/23/25 02:22, Philippe Mathieu-Daudé wrote:
> Hi Pierrick,
> 
> On 22/4/25 21:26, Richard Henderson wrote:
>> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> Message-ID: <20250317183417.285700-14-pierrick.bouvier@linaro.org>
>> ---
>>    include/system/xen-mapcache.h | 41 -----------------------------------
>>    include/system/xen.h          | 21 +++---------------
>>    2 files changed, 3 insertions(+), 59 deletions(-)
> 
> 
>> diff --git a/include/system/xen.h b/include/system/xen.h
>> index 990c19a8ef..5f41915732 100644
>> --- a/include/system/xen.h
>> +++ b/include/system/xen.h
>> @@ -25,30 +25,15 @@
>>    #endif /* COMPILING_PER_TARGET */
>>    
>>    #ifdef CONFIG_XEN_IS_POSSIBLE
>> -
>>    extern bool xen_allowed;
>> -
>>    #define xen_enabled()           (xen_allowed)
>> +#else /* !CONFIG_XEN_IS_POSSIBLE */
>> +#define xen_enabled() 0
>> +#endif /* CONFIG_XEN_IS_POSSIBLE */
> 
> Just to be sure, you said we should remove CONFIG_XEN_IS_POSSIBLE?

More "Ideally, it should not have been introduced", and {accel}_enabled 
should be a proper function, and needed stubs should be added for other 
functions.
CONFIG_{ACCEL}_IS_POSSIBLE is just "yet another way" to stub some 
accelerator functions, while we could have proper stubs instead.
As long as it's not blocking our work, I don't think we should do this 
cleanup.

For your case, concerning hvf, I said it would be preferable to simply 
implement hvf_enabled() as normal function, instead of mimicking the 
CONFIG_{ACCEL}_IS_POSSIBLE pattern, since it has not yet been introduced 
for this accelerator.
It it's more simple to simply replicate this, no worries, go ahead, it 
just concerns one header.

When we'll want to link the single binary for the first time, we'll have 
to deal with that anyway, as it won't be possible to have two different 
definition of a single function/symbol (i.e. unify stubs and 
implementations). But we are not yet there, and it's better to focus our 
energy on removing compilation units duplication at the moment.


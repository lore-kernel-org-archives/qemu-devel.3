Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F15C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 16:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trgEK-0005Il-LK; Mon, 10 Mar 2025 12:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trgEF-0005C4-IO
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 12:43:47 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trgEB-0004lN-TC
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 12:43:46 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2255003f4c6so34003935ad.0
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 09:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741625022; x=1742229822; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ApeTF3TeG+eXzCTtnHtEItnBgi/5zu3+a+3JGTzwvmY=;
 b=Ywohy4s1MbNldsVNlCAcB9KLrR65Oh8kNEkznT2+BfXfbDOJVnq96vaWfZMWefaojo
 GUeVJUVhNh7kUFvz2klRcCaeUc+PZb5otHWgnTLkWu6fIVrOCapn5xtGOyfzmFcNgXFr
 boJrHeog5K6DCWkcvPF+Ijp9Jm/DqMSO/AjZjxUrF7QBoeQFP02rgoZkEYbd/znEZBOy
 SXL5p2aFCDemN4OB3Knmwaa23ij1jFWde2UjAyZmFYu0wNsARmpdyuU42xdVzOi8RSU/
 zv6bc99Y0YVOjohailV0II5BpHx9cgL/oGpBCEPLvZOsfUOsiD//yxo5Y1nAplcBDddt
 SvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741625022; x=1742229822;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ApeTF3TeG+eXzCTtnHtEItnBgi/5zu3+a+3JGTzwvmY=;
 b=OCNVCHZNWmsUpLVUe+bKZkbsjroPKlI9wEZu/b5jsfsSIZU7r6SI7VWYAG0Q7Nq5Z2
 2DlwmSW/qZMt4IyJDvyGwC0vFuwmBasyvCWv5dlkkqouMpEBw1DFwY8jxnCXtGuZqaH7
 vSyPZ5rr4NNkCpXQMTTOiPOHb2tsCkx//YsT69PjgiF/rZr8Gz6dmKTFFhwjnu83ajtU
 TS/Pq/D19fcCDXu18DynKSPdnR6s/c02vJwW37n1EtboBDfKXfu+kJZDVNhon8cOupO8
 3U+fru2GZMgq31uSRcRE5ZJ/BSgPcYogyoBqd0cUKpGd/q0dIfpm5M7+OkjneOOuzQRJ
 dymQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVizn6N2RXraC7p+w/mB9MBhXhIeOZYZ0Eh41c0lDIex/yAXjKpUHLI6RTeLt4ErkmHKrWAnP0kMCCC@nongnu.org
X-Gm-Message-State: AOJu0YwnoAtbar76G30myvW33YYPE4Mq826MT/qxNqrCOLvHafvOfp/b
 MRzAh6o6ZnIcesepSxuG7N9wLCMXgZOzVwwi+yXleAvL3nyZfYJ1ibvmU7GSp5Q=
X-Gm-Gg: ASbGnctsAFGTR0VFk8ttffs7UMf/b9b+hePjzdyvlA3D6IClD5m1wcw0CtrDMaVHaan
 Lm+/epFPb3b7Ot/aOMBDvnx1FchX0MRuSloJsina1wu+ArUD+xRWujLkKJAYVtTbb0A+mdAzKX4
 nW4msUAvp3hc5dgsvoN4ZVMZOD44KwpjXs/TZaYfIAzxkLE1V6Z8PB2VKIPT59M/7H6Pqu80/wc
 toQ1mH4mrm5RqltZCHem3FRT9CHHy+2w6Wp4BdppLVRTwOkZ/vgGpeTYC9hD+Gr7JHUVhMp9ws3
 3+pVTWsaRK7TJn/ALHTD1QodFYOMPIOsg7V9BvrQ7kZasJyjPmCgWIOHgw==
X-Google-Smtp-Source: AGHT+IFv1TPkdlKu4M0m/vFVJno6p3kYGEL66Zt6sR6IHNLQenuiMP644OFDhQ8hc8jFyNygXCpCNA==
X-Received: by 2002:a17:902:e841:b0:21f:136a:a374 with SMTP id
 d9443c01a7336-225931ad4efmr8164365ad.43.1741625021784; 
 Mon, 10 Mar 2025 09:43:41 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410aa4f43sm80198375ad.224.2025.03.10.09.43.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 09:43:41 -0700 (PDT)
Message-ID: <15816b7b-f120-4235-a1a9-333bc0f69fe1@linaro.org>
Date: Mon, 10 Mar 2025 09:43:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/16] qemu/bswap: implement {ld,st}.*_p as functions
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
 <20250310045842.2650784-6-pierrick.bouvier@linaro.org>
 <4ac28725-33bc-4b29-a941-03784566d330@linaro.org>
 <6a0cd17e-1c76-4b2d-b781-ea7f438cc4b2@linaro.org>
 <6dc11a37-06d7-400a-b45e-a151d660eb6f@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <6dc11a37-06d7-400a-b45e-a151d660eb6f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

On 3/10/25 09:37, Richard Henderson wrote:
> On 3/10/25 09:14, Pierrick Bouvier wrote:
>> On 3/10/25 09:08, Richard Henderson wrote:
>>> On 3/9/25 21:58, Pierrick Bouvier wrote:
>>>> For now, they are duplicate of the same macros in cpu-all.h that we
>>>> eliminate in next commit.
>>>>
>>>> Keep code readable by not defining them with macros, but simply their
>>>> implementation.
>>>>
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>
>>> Why do you want these in bswap.h, rather than tswap.h?
>>> They're target swaps, after all.
>>>
>>>
>>> r~
>>
>> No preference on that, I simply added them to the same file than their explicit endianness
>> variant. Would you prefer the endianness agnostic variant to be in tswap.h instead?
> 
> I think I would.

Ok, I will move it.

> 
> In addition, I think we want
> 
> #ifdef COMPILING_PER_TARGET
> #define target_words_bigendian()  TARGET_BIG_ENDIAN
> #else
> bool target_words_bigendian(void);
> #endif
> 
> moving the conditional from around target_needs_bswap just below.
> 
> With that, we eliminate the extra branch that you're otherwise
> adding to target-specific code with this patch.
> 

I understand the change requested, but should we really aim in that 
direction? In the end, if we pursue the compilation units deduplication, 
the branch will be present anyway.

I'm ok with your change, just asking if we really want to preserve 
target specific code until the "end".

> 
> r~



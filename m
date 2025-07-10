Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C91C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 16:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZuKH-00027Y-1B; Thu, 10 Jul 2025 12:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZtzi-0002Zc-Jx
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 12:19:34 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZtzg-0001Y2-4t
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 12:19:34 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-6138aedd718so577459eaf.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 09:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752164370; x=1752769170; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n1UvukfACEFi7+Cg77daGyIxEetaxK39b3E4Ak1QmXU=;
 b=E3CRLbrhL3rzXTW4j2pBz3vZ4NICPoqiNteBg42qkZPgVvaoAEf7N858w8TW2AwZNr
 hZPVaZeNNxMm9DUk96HDeHnVRTZK4Eybo0cemak1btGVi+imjXM0M6DWf/ELOsCK0L3R
 JawXwaCdPBpfRPt8N8InS/BAKBawTV7RnbiAtp+Ikw7BpeMtGKWnDhruguo0GV6FKe+r
 PZ9V/VSmhsghGZ9PfAhRztgiMUP/tjc+LX+Ws0k8sgg6w2d3VGTl/I4UKVoyjNZlBSQZ
 9n0S0N+/nljtfhp17pALMrSj3fJXrQgztG6zSo61f6yWnxJBUOlSEQ1KVLJG0cSQDDLJ
 EkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752164370; x=1752769170;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n1UvukfACEFi7+Cg77daGyIxEetaxK39b3E4Ak1QmXU=;
 b=YfcrMDtVb4bQxGv8ggpTkOlt9QDy6uIzJVzPykOx+S0qb71HCFmkB2W9MEtrWZlRTi
 s+VRvwC+KN028alJTZkqk1b2FGfQUCJy5BDNaQGx33+j1TeRBSvgbj9EskZC3u/gQME0
 j7QHF1nxcYBkJqU9/kCM8r7sf0WCOmIhlcl0VIAGEv4SVNyN8KE1ca8jSnzADRzDz8cS
 oAtH/UgrccU2rVCa2zkA788ETpwy3QAgVU4uz0aOjnpzCh+FEYNn+Myu/NbEU2/vXp3+
 sRuCydmshZAovz1QfEKTq/y5cYa4IDFYFO3dh1FuA7o/OsRztO6DGkjB1ElCUQ0wKhE0
 WafQ==
X-Gm-Message-State: AOJu0YyjkseJmhhQrlbCxvfKmXL0E4pgxIPVs5ecagHAIYQ2DXVTMUJ+
 CeqbbVH13V5CJZrVMQ99ywuMZVtYUMS5JrUwm7NuqJl8H2+HeiasteUQZSDV0nrDki8=
X-Gm-Gg: ASbGnctxBKyb3iO+CkTIlJfwnd7FH221afHj/0JGT6Teaefon8RDjZyaogQsce4whRE
 BQRZNhYAt5YVCu/mGHcpCSyTmDnWVdE5M8T/XAv2tHEWseIuG5X07mOy7Ms2nhG5ECzpzosX69p
 aRuYsGbsXidEELcgBqZaYLUKdqmLweYIzHwCIYO2tq8WEi3gMeLhlmZqkBAOU9ppCRMIBAqVpGp
 pTiEOPKIkO6CVixN+xkSygCrGFLrlutCNWXeNPF+ILjhpa4j3TBwH6g91ZJcaOVTbZjUckOLA6K
 aa/4CWILpdFiTKprgH2Z5YncLaBrA1cPmH7Cmlz7PeYh2/ew6rvfwQ2+alFoOIUPqVpgbwhAc1v
 OGRk=
X-Google-Smtp-Source: AGHT+IGcCrktwC65eJ35MlY0bO7p1MhHjK5Furx8apWg4lM6ZS0HAxQzroapf+nRCL0UXaJbXHXIzA==
X-Received: by 2002:a05:6820:28ca:b0:611:758f:1fa4 with SMTP id
 006d021491bc7-613d7a4a1b0mr2624706eaf.0.1752164369871; 
 Thu, 10 Jul 2025 09:19:29 -0700 (PDT)
Received: from [172.20.0.130] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf1064e90sm257809a34.9.2025.07.10.09.19.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 09:19:29 -0700 (PDT)
Message-ID: <9fa3f726-ecef-4b0a-ba52-61329c0ad5d8@linaro.org>
Date: Thu, 10 Jul 2025 10:19:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/20] target/arm: Convert v8m_is_sau_exempt to access_perm
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20250707202111.293787-1-richard.henderson@linaro.org>
 <20250707202111.293787-8-richard.henderson@linaro.org>
 <CAFEAcA9aH_31Z=C++baEMm+9TUCuVbKnYz7LMjoF0-Q_S_RvGw@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA9aH_31Z=C++baEMm+9TUCuVbKnYz7LMjoF0-Q_S_RvGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2d.google.com
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

On 7/10/25 06:01, Peter Maydell wrote:
> On Mon, 7 Jul 2025 at 21:58, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/ptw.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
>> index a11df31b18..78a9c21fab 100644
>> --- a/target/arm/ptw.c
>> +++ b/target/arm/ptw.c
>> @@ -2754,14 +2754,14 @@ bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
>>   }
>>
>>   static bool v8m_is_sau_exempt(CPUARMState *env,
>> -                              uint32_t address, MMUAccessType access_type)
>> +                              uint32_t address, unsigned access_perm)
>>   {
>>       /*
>>        * The architecture specifies that certain address ranges are
>>        * exempt from v8M SAU/IDAU checks.
>>        */
>>       return
>> -        (access_type == MMU_INST_FETCH && m_is_system_region(env, address)) ||
>> +        ((access_perm & PAGE_EXEC) && m_is_system_region(env, address)) ||
>>           (address >= 0xe0000000 && address <= 0xe0002fff) ||
>>           (address >= 0xe000e000 && address <= 0xe000efff) ||
> 
> This also is conflating "don't check access permissions" with
> "access is data, not insn".

Yes.  We don't (yet) have a need for "don't check access permissions" for m-profile.

Talking a-profile for a moment, in order to match the pseudocode we would have the 
AccessType_* enumerators.  The two relevant enumerators are AccessType_IFETCH and 
AccessType_AT, which means that all of the probing that we want to do is !IFETCH.


r~


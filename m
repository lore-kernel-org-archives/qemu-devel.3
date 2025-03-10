Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A42C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 16:04:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trfb2-0001KW-3B; Mon, 10 Mar 2025 12:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trfaw-00017X-VJ
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 12:03:12 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trfau-0006lT-LD
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 12:03:10 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2ff6ae7667dso8456999a91.0
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 09:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741622584; x=1742227384; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ht/MoUDKO56ahPSvxc42Z8jfInmbefH2eRo9d7rT5KM=;
 b=vhHB5005oKwF7NFblMBPtznEXYoToKpQVTdYjXM2exbYAg4LcwteOb1I0VFXpg5toe
 Z885m9ZjWYBypS5TDdt4iYagObhT59kmeLddHJ34OSFus8PNpr6DvUmEuu09Mu2JvhJe
 lPB8t2/IQutG1HvyG0v1mmnc/iqRwJoc0Obs26t/Z2E1mDXkpH3QvMsdix9mtIhQc/Py
 /QVWj0TKuNssfo2Ws/gVj2aemAqmyd2HKsvomF3T8KnXZYmr9KWGSU82p7bnox4GumJt
 BfCsIYAm6NV6R3UdglhhUqlmU8tzmTjn1BQVNZlt/UGbu8VfD637QGSH3EZRHgrKFR7n
 0W/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741622584; x=1742227384;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ht/MoUDKO56ahPSvxc42Z8jfInmbefH2eRo9d7rT5KM=;
 b=jODuVZ8j6s/M91uK/ntF8vqE86AFPtkKirWC9dgOnqgP4gfkyBZTTK90fhSwOcz1wC
 G2kKNZ17VlEgM8F5sks2/96D0IXKj+x8CrUlQ2cKAuCf4XadR8FXrWRzubQAUCaDCoUk
 s3n5Ll7++eL6dyUbovVoY2214ORfsen5j1xBdh2RKM48VCDLuUXzWDVYo+5yYB71OSEF
 4/SEhek8axOyQ4TgSMUnmcMjocbmICKwR7JIveBLSs7QQSTJT8U25N4QCxsp+/9tRjNO
 q+izsHoJjIqvVZv0ubIE9ElVuVmDHf1Sgt6XT5Y+j0PmF57K3AHVRWlfsE3zntIf1/MV
 ZSiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKa4gCPPrAmld9b7+e9YHve4CcQUdBjugEx3AU4R0RIcyP0i5eDkd2G9qqOz6TQWVL8ODZ4d2zeBYJ@nongnu.org
X-Gm-Message-State: AOJu0YzwXZZsCRNO+9kzImVScusj16jmI6f+Tggvn/+9qj+R0NXzNU63
 oQ5r8M6xtCShNSb3B5BpFGvXQZErwXmJYCy50fgNhR2ibnijlpF5F7NRgE8YamI=
X-Gm-Gg: ASbGncs45i8YoIvRuNuM4FOINrIwyj2HK9NbSmwC4bEr3yOHsOZ39ewYhs+FaYdijn5
 9edSnvJC2q9aT2/X7hP/Bx6mOhoMtP80NB0GQaAHsznLIB5wgZtyPDTjh7KNFrvU2a82QDsCDbU
 62DUEt8Zs3Dke6uEQlsJ7AX3jJaB9/hJvmfukQVw3Mjp1xJeGVZDsSaFbVOAuUQj3E2Q2rScEWp
 Q40K4X/AxbqZ8SGkblJcFlrqjKf5dN7NUAnQwEdL/ojFXisTHYOYo0REAqL9OFbWYDYE5yj0tUN
 3+DUyC9n1wT/yfXZAF5ZeZucTl39Y7tg33zdVQtR2YR7LYpPNooQP5G/0nz5kWxvEeK4
X-Google-Smtp-Source: AGHT+IGxM/Em+R0Hl2wb682CCRh3FUj8sHYmky7580qYek7/oVkcclGio5UopDNe0hpBl/G7AgjYIA==
X-Received: by 2002:a17:90b:1343:b0:2ff:6fc3:79c3 with SMTP id
 98e67ed59e1d1-2ff7ce7aa7dmr24350888a91.9.1741622583660; 
 Mon, 10 Mar 2025 09:03:03 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff693f8804sm9137803a91.47.2025.03.10.09.03.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 09:03:03 -0700 (PDT)
Message-ID: <ea332af4-e5e4-4c35-8f03-25aa7c121137@linaro.org>
Date: Mon, 10 Mar 2025 09:03:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/16] exec/memory_ldst: extract memory_ldst declarations
 from cpu-all.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
 <20250310045842.2650784-2-pierrick.bouvier@linaro.org>
 <57612d65-aec0-4785-86c3-0c8d647af38a@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <57612d65-aec0-4785-86c3-0c8d647af38a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1031.google.com
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

On 3/10/25 08:17, Richard Henderson wrote:
> On 3/9/25 21:58, Pierrick Bouvier wrote:
>> They are now accessible through exec/memory.h instead, and we make sure
>> all variants are available for common or target dependent code.
> ...
>> diff --git a/include/exec/memory_ldst.h.inc b/include/exec/memory_ldst.h.inc
>> index 92ad74e9560..74519a88de0 100644
>> --- a/include/exec/memory_ldst.h.inc
>> +++ b/include/exec/memory_ldst.h.inc
>> @@ -19,7 +19,8 @@
>>     * License along with this library; if not, see <http://www.gnu.org/licenses/>.
>>     */
>>    
>> -#ifdef TARGET_ENDIANNESS
>> +uint8_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
>> +    hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
>>    uint16_t glue(address_space_lduw, SUFFIX)(ARG1_DECL,
>>        hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
> 
> You shouldn't be exposing
> 
>     address_space_lduw
> 
> to common code, only
> 
>     address_space_lduw_be
>     address_space_lduw_le
> 
> etc.  I'm not sure what you're trying to do here.
> 
> 
> r~

As mentioned in the cover letter, the goal is to extract memory 
functions from cpu headers. The result is that we need to expose all 
functions for both common and target dependent code.

In case you don't see the point, you can try to remove memory_ldst 
include from cpu-all.h (without touching memory_ldst.h) and see the 
compilation errors. This patch is the minimal change to get something 
working.

If your point is that non be/le variants should be eliminated 
completely, yes, it can be done after this series.


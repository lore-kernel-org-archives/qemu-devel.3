Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF02C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 16:38:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trg8J-0003jn-Sn; Mon, 10 Mar 2025 12:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1trg8A-0003au-9t
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 12:37:31 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1trg84-0003ql-B1
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 12:37:30 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-223a7065ff8so7799635ad.0
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 09:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741624642; x=1742229442; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l4M+hR/te1e6dZBsoKedyXrJC1sJ2EhI30/YZ6Rp6CM=;
 b=d+FaLYOGn4zxYLwtCbXiI7v5EF91jskWgh22ortOGWETmze3a6lb2l9Hs6IDjXkj3p
 wBm1OW8b7UsKDRTVP4dwKBB8uIWRJj2VY6YrISVzhc1UITifIg8QyKyr4gcTCj+33qZD
 kBSu4xl9F0Zd4cHp//xtnYQl4axi/RnGiWTF11Wc3Qi6jbgsPL+ZSSec0dkQndt3+MDr
 pP05P0FCu8PL7YbVbKmBzqL8g1olcUWOfyxwroshK2yAak5ecTv1iT1lILE/zW/eFGH4
 t6x8vN3PU0ete8m52BzKFcgmqWm2uL8WbIjPtQH9Suo92b2sS163jkKuG2HEqcOEQs/e
 NP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741624642; x=1742229442;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l4M+hR/te1e6dZBsoKedyXrJC1sJ2EhI30/YZ6Rp6CM=;
 b=rkKSEEBGde1Mohd8R9MsUiCd+2tAdk1QfZPQ194NBRZlb01uA0IxkDFMaNwPjZtqij
 4ULWMjry4SxhQWXoRbW1jQRuXsKPsfrJqMw9hgLJrRXRulWNYqlRqakJmggOHqjE2iIk
 q5H0+v40HKm1MbazklPvY77O0oePKbHQD7quY0wfhXk1ZSRMrH7dktJOplP7Dhcg7ZTt
 cnZ8c6Ax4bU/Oyv2YUaQSz9QvftczJrlobyzXlFSY/5nZTEv/v3zFZkb+z4FRuqGVGKB
 XA1AT5edzh9BTc0YdSrUS+18syD4iawHBs/2pLqt0uhBLYNnRNc3VTKvTjEaAbwXYeKe
 zTMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRErHOiOPEcFXEaNNCoQn6KvOVQ46RR5D+e7cbhRLGjY2IRSAD4gYO/u6HElrCLx1rqOmxyqjE0UJO@nongnu.org
X-Gm-Message-State: AOJu0YwZZwtAL/axoVtHRzX5CfNvQ/0Fxfn+TVJ5A8jbBl7bPgEXzjw5
 jL25VaxSVJq6V0FYH4vraYBVJgS9WDXQ2SCwp6jxWthGDeb/6NI7eK6nG5cwgBw=
X-Gm-Gg: ASbGnct+8o9QOvAgr0Dhs1zAivJA+VTNkSBH3kc7OH9KxW85qzqXwLdixvPvAr/ppMN
 5rVDuJwpegKq6uXNKdSLmdKt/4Vdf36YuclfDo9BYkjV3wvUs8rbNfaS/hLEldhb4/v37Nbh9Fm
 aXOBpeLgF+rxlOjs9Nc0VVvOyWsuSUVhIbdgdY5QjQ0TCPow4X0Oq9NuAExaBPWOj1TCtsyX74a
 2FXGxvnawcCkAfOeVrHskY6EBMxXypnBCqnR5XSCVE2Ixyt4Bu80ey4pkGiUOnV2jaY4pAn96hf
 a9j/fEuxkjtEi0pYgnBbyCwmahUqzaXwbC+CTg/8ODPRidq7XiwxGYkD7nVVptLNCFhw2y/VSKs
 cluqRxSV7
X-Google-Smtp-Source: AGHT+IHCsE5Cj3vgOZLnmfiFnGAnaanBFOnFtdbr4Db1U7n44Z6dy/6ohNEopaK2fysNw00gM8MWZA==
X-Received: by 2002:a05:6a00:cc2:b0:736:3be3:3d76 with SMTP id
 d2e1a72fcca58-736aaaabb86mr20514947b3a.17.1741624641989; 
 Mon, 10 Mar 2025 09:37:21 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736e05ee046sm1742524b3a.179.2025.03.10.09.37.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 09:37:21 -0700 (PDT)
Message-ID: <6dc11a37-06d7-400a-b45e-a151d660eb6f@linaro.org>
Date: Mon, 10 Mar 2025 09:37:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/16] qemu/bswap: implement {ld,st}.*_p as functions
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
 <20250310045842.2650784-6-pierrick.bouvier@linaro.org>
 <4ac28725-33bc-4b29-a941-03784566d330@linaro.org>
 <6a0cd17e-1c76-4b2d-b781-ea7f438cc4b2@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <6a0cd17e-1c76-4b2d-b781-ea7f438cc4b2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 3/10/25 09:14, Pierrick Bouvier wrote:
> On 3/10/25 09:08, Richard Henderson wrote:
>> On 3/9/25 21:58, Pierrick Bouvier wrote:
>>> For now, they are duplicate of the same macros in cpu-all.h that we
>>> eliminate in next commit.
>>>
>>> Keep code readable by not defining them with macros, but simply their
>>> implementation.
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>
>> Why do you want these in bswap.h, rather than tswap.h?
>> They're target swaps, after all.
>>
>>
>> r~
> 
> No preference on that, I simply added them to the same file than their explicit endianness 
> variant. Would you prefer the endianness agnostic variant to be in tswap.h instead?

I think I would.

In addition, I think we want

#ifdef COMPILING_PER_TARGET
#define target_words_bigendian()  TARGET_BIG_ENDIAN
#else
bool target_words_bigendian(void);
#endif

moving the conditional from around target_needs_bswap just below.

With that, we eliminate the extra branch that you're otherwise
adding to target-specific code with this patch.


r~


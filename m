Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F40C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 15:47:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTjNh-0008Lj-0l; Mon, 23 Jun 2025 11:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTjNg-0008LZ-8m
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 11:46:48 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTjNe-0006br-OA
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 11:46:48 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-747fba9f962so3316340b3a.0
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 08:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750693605; x=1751298405; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e7lNyz/un7YDDqQQeFNJWx32N55ye7fGL8e67HppFOM=;
 b=XezTj/1fGL/0k6DihwoSnQifB6+J7OX4XIwb6HnujtdKp5EwC+8fXL8Q5BOT++m+pb
 o+zSZ+E3wdVQ0JL4ZiXHQSL/A4RdzU5DZgvryTJayuqGcvlpzKHTuGuQcbKYEegfARjq
 kJcsXrLg6Drb+h7ptdZLpqM+BxrrhDKw7K7iRJ9hOR5iD9AkN3ldYFEZbQsOtAIb5Hu5
 N1pxJ0B0HzCDDoOI2etk4N/gZju5+Gd8nXujD3dIaMcO7GMoQtCEJ1mNAqTE3zgHId9d
 B0rWMOiWF33MLMCxWxL7NUkiob2hhkT4k5D5Ulc9XUQ2k/7hjY1rbktlq6emPb23QDrd
 UOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750693605; x=1751298405;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e7lNyz/un7YDDqQQeFNJWx32N55ye7fGL8e67HppFOM=;
 b=lPdzZA1qgBOIf6XbSMmjiAcaZqRd/LTPIUatLvziYAbG9ErSEuMSl2hGMmTi4VJNJb
 Y+8ALx+8WKuonf08riXbSdEjk83Ae9VAw6TDT4u0cn2EwGaEc+WUy4gRsOPNJodAVSrn
 Z3wP1hZLD6+oWGqlF+/+rHztPaD6zOMWsKqgorG10gy34jJsh5bQeWt0ZhDHzxYl2z7V
 7jVxG68LnH5KRJKRiCpqkcEigREhiG8n39MFWp+iV55owdPOD3uCCehPytvntTuYq5+R
 YVN1fP6/9PU9IQeCFRFEHddPcRtKFu4m3UrnySDL9NU6ATBhKI+GC+908xdGlZATRsIN
 0ETg==
X-Gm-Message-State: AOJu0Yw2KGfND98CcNl4d6fOVpMgqI7RmVy1s2c7coA7jQusW1rqsHFj
 dsKELTbPzKLaH5PWVQr6X0j9RgF9ISmiKA/TgQfb/ly+COVeAiGvEusbwVLThd79zvqaYyUNwlE
 JCygn/NE=
X-Gm-Gg: ASbGnctlp/Tl+jEjkwx4TOCeYz2f5yr8huGCtdqG4Eh/Ovw0HTTGAuTXPBg6Ft+P2zO
 V9ji/9B4G/rRMcYvamAiJncxtO598m1PY9G6CqfuJ43cZ6HWI1vl9fTn9bwx/jfE+3v8MteD8zh
 PUTEdDQ3+gawRCaxiM1UoqIg26bl+qLYTAVFQR0sav0Cvfh+NRDouTj7QklAvIW6JVB+Osf4efG
 hbLj3tY1nityLUw/CwtBh3B+IL4iutbNWtur7Hph/SmR3IiP6YUBqES1ruUrb3sk+r5ZCyQalOq
 GlSJi/Xu+KvRsV0lazM+79NLxLo6RhfUMXC4xGmHQ7qk1HuOQ01/J5EQlf9zbkdcF5d9jd/7Rxt
 rpnvTu5yaaWNhgVHireDkRa6HtSYY
X-Google-Smtp-Source: AGHT+IH8vWPTVr/IrHTIjayK3/jBJB4r+A613iOjfcvJBFWsFBdh4KprqRUp9qCWWktzG5ZI/4bdLA==
X-Received: by 2002:a05:6a00:2289:b0:73b:ac3d:9d6b with SMTP id
 d2e1a72fcca58-7490f474fb8mr20243604b3a.4.1750693605096; 
 Mon, 23 Jun 2025 08:46:45 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a49ed7fsm8910773b3a.59.2025.06.23.08.46.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 08:46:44 -0700 (PDT)
Message-ID: <ec1fe185-9b61-4c47-b409-cdb42214d9a1@linaro.org>
Date: Mon, 23 Jun 2025 08:46:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 030/101] target/arm: Implement SME2 Multiple Vectors
 SVE Destructive
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-31-richard.henderson@linaro.org>
 <CAFEAcA-1t=MYCnE=Pd=sy+BvwqV0m7YU9uNkkNaATU4AEyqGkg@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA-1t=MYCnE=Pd=sy+BvwqV0m7YU9uNkkNaATU4AEyqGkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 6/23/25 08:25, Peter Maydell wrote:
> On Sun, 22 Jun 2025 at 00:58, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/tcg/translate-sme.c | 65 ++++++++++++++++++++++++++++++++++
>>   target/arm/tcg/sme.decode      | 36 +++++++++++++++++++
>>   2 files changed, 101 insertions(+)
>>
>> diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
>> index 0e05153924..617621d663 100644
>> --- a/target/arm/tcg/translate-sme.c
>> +++ b/target/arm/tcg/translate-sme.c
>> @@ -550,6 +550,37 @@ TRANS_FEAT(SRSHL_n1, aa64_sme2, do_z2z_n1, a, gen_gvec_srshl)
>>   TRANS_FEAT(URSHL_n1, aa64_sme2, do_z2z_n1, a, gen_gvec_urshl)
>>   TRANS_FEAT(SQDMULH_n1, aa64_sme2, do_z2z_n1, a, gen_gvec_sve2_sqdmulh)
>>
>> +static bool do_z2z_nn(DisasContext *s, arg_z2z_en *a, GVecGen3Fn *fn)
>> +{
>> +    int esz, dn, dm, vsz, n;
>> +
>> +    if (!sme_sm_enabled_check(s)) {
>> +        return true;
>> +    }
>> +
>> +    esz = a->esz;
>> +    n = a->n;
>> +    dn = a->zdn;
>> +    dm = a->zm;
>> +    vsz = streaming_vec_reg_size(s);
>> +
>> +    for (int i = 0; i < n; i++) {
>> +        int dofs = vec_full_reg_offset(s, dn + i);
>> +        int mofs = vec_full_reg_offset(s, dm + i);
>> +
>> +        fn(esz, dofs, dofs, mofs, vsz, vsz);
>> +    }
>> +    return true;
>> +}
> 
> Don't we need to handle Dn and Dm overlapping here, the way
> we did in the previous patch ?

No, because Zdn and Zm are both aligned, and both incremented.
Zm+i is fully consumed as Zdn+i is written.


r~
> 
> -- PMM



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E8DFE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 11:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVqmP-0001Or-0A; Thu, 09 Jan 2025 06:32:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVqmN-0001OP-1Y
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 06:32:47 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVqmL-0007B3-4e
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 06:32:46 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-435f8f29f8aso6389145e9.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 03:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736422363; x=1737027163; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l4X4BSj9gt4r7v1ko9bmgBLT0AZoSQ9YSxsqlmSH808=;
 b=jp2xcxj4DIpSwIFQNZevWYEXZ9gQCo4w5WzqUiKDFupxgUJ63G9AFF10rcCwTvQSWa
 u394H+4hgB1GF2XVbix5uN9fxxJJzsrTSQsrdJcUaxTGBSzgyisTgXgHxlP9bqFPpcwj
 C3KvZ3AVDL4MH+caPl9Plv3LG7GEctVerhgf47xiroQIwyEpwwANaAvJjIn8lUYvLVBG
 da0piuFiobC1WmcJnG/jhvtxU1qFHW+426kreKroMWd84aikDcZoVraiZW+2nMEfmZjr
 TRu4VvWkCvJ22BpUefyjr/CGPoR6MUjGelDLRFQPIpxpwi6j64E+PGAn7DtPRaakIEGK
 I3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736422363; x=1737027163;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l4X4BSj9gt4r7v1ko9bmgBLT0AZoSQ9YSxsqlmSH808=;
 b=f4ashbFFkEKlvj7qEwPzo/eAFnhd8xJVZ3RHaGvIhlHFbzUsIW6bRKb5z14UTSB5DY
 rfQcKv0r6pkyQRVVI2mG0rB40CXQncl0aqRmmk9Yu/fwR+EaxH+QhAp7eI0cMQcT+lry
 nTzDej87VU7vQm99EK9Dh2yYoBX9fVWdVpWtM0B5xQQnomHA1KD57Tbhp1qWfVHo+jPy
 CnUrbeqwEMSGE4utUIaeRWA/mii7dNKs+oQ3YaeAhnaWW/gxW8unQ9YGOkzu+qHS3Sot
 K90JroyhQPgv/LKisH6RF1OhLf/i2SERc+Qpf9SYiua05KtR8ubGSVA6lRMr6xlCbz10
 LZ+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbwd9nBZm1FepeOMhecYx2Q0+Z48M3sCBTd2QB+E3MV8KdXlp4YrDSQiLm4Yb1XwPX+Xltxarx3N0u@nongnu.org
X-Gm-Message-State: AOJu0YzXW9JTdNQ8iQbPBOiT+UgU2mlHwg+M8RWM9UkeMRtGzrsB2Diz
 BQkZDAIzs4I4R0Vh57Dn5LNhciw1cRQzrfZya/lXugf1V5/mlSIPvJXVu+uwZcQ=
X-Gm-Gg: ASbGncsq3BQSyeiZoXRvwYf4TScLQ9gRW6he0VrT/5hE/0EqxkwmEWIhnG8Qui1sxA0
 TktOiATFrEneuSSJIQiXUxV+432QCdEKNTfRkqLivj2gsw4Cw6HJvfyObtGzuJX1Zv1/IK0G+rh
 /x5Y3D8+PZu4EO0w00LViTr1ZWXoy6UqNRHBKwXIhosGPQpw+xx4v16ymQttdIRqlc4D6+qd7Of
 XkW+jTViJ2aYEzKKBiAoz3Psh5u72PxiqpO4r7vmBvWSn8god5Vske85Gu8jTaeXGhKencMAKsu
 svasfkgASOVGDKRWSOAHFpvS
X-Google-Smtp-Source: AGHT+IGdpMGUDevlNGBVB+BqjntZ9taAGOG+7UkNDMCGLYjC18IAT4LWiKsuSSffM4Fic+FENT2qhg==
X-Received: by 2002:a05:600c:45c3:b0:434:a4b3:5ebe with SMTP id
 5b1f17b1804b1-436e26e554cmr48846175e9.24.1736422362651; 
 Thu, 09 Jan 2025 03:32:42 -0800 (PST)
Received: from [192.168.69.102] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2da7768sm52980755e9.5.2025.01.09.03.32.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 03:32:42 -0800 (PST)
Message-ID: <388908f5-1138-4b3f-ba9f-313d09f9d291@linaro.org>
Date: Thu, 9 Jan 2025 12:32:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/81] target/arm: Do not test TCG_TARGET_HAS_bitsel_vec
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-8-richard.henderson@linaro.org>
 <eed31d9e-7c0f-4a96-9442-48bb2c56337f@linaro.org>
 <393fb699-a360-416e-b1d1-df9372685c16@linaro.org>
 <2353d8be-843a-4054-86e8-a961aab62769@linaro.org>
 <05806359-d54c-486a-bf40-6efe79253283@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <05806359-d54c-486a-bf40-6efe79253283@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 8/1/25 23:30, Richard Henderson wrote:
> On 1/8/25 14:14, Philippe Mathieu-Daudé wrote:
>>>>>   static void gen_bsl1n_vec(unsigned vece, TCGv_vec d, TCGv_vec n,
>>>>>                             TCGv_vec m, TCGv_vec k)
>>>>>   {
>>>>> -    if (TCG_TARGET_HAS_bitsel_vec) {
>>>>> -        tcg_gen_not_vec(vece, n, n);
>>>>> -        tcg_gen_bitsel_vec(vece, d, k, n, m);
>>>>> -    } else {
>>>>
>>>> Why aren't we doing the NOT n operation here?
>>>>
>>>>> -        tcg_gen_andc_vec(vece, n, k, n);

[*]

>>>>> -        tcg_gen_andc_vec(vece, m, m, k);
>>>>> -        tcg_gen_or_vec(vece, d, n, m);
>>>>> -    }
>>>>> +    tcg_gen_not_vec(vece, n, n);
>>>>> +    tcg_gen_bitsel_vec(vece, d, k, n, m);
>>>
>>> Pardon?  It's right there, unindented.
>>
>> Sorry I'm not clear. Previous to your change, in the
>> TCG_TARGET_HAS_bitsel_vec side we use the NOT opcode,
>> but not in the other side where we expand, why?
> 
> Are you asking about the code being removed?
> 
> Recall that bitsel = (n & k) | (m & ~k).
> 
> Passing n = ~n' we get (~n & k) | (m & ~k),
>                       = (k & ~n) | (m & ~k).
> 
> which is the two andc + or operations above.

Sorry, I misread the first ANDC [*] as AND...

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



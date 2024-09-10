Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84233ECE582
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 07:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snuxi-0004UQ-1J; Tue, 10 Sep 2024 03:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snuxg-0004PH-MO
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 03:06:52 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snuxe-0008Uj-VX
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 03:06:52 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2f761cfa5d8so28358811fa.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 00:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725952009; x=1726556809; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m4e7yrZL8EI2osvdoujnFqGKwjgylpzzlVIrd8thyC4=;
 b=ib76tza9M2avyaQRJUyKUExgOLrKYsBzKmYzePcXGGHc4Tub9eI7VNu/1olsrJYnse
 CzRqZia7lpvkOA5TbuUG5z3NwDv3+dDsMi7XKqVmTy7XKHbid8XM+OUR9KvdPfa3Kb9g
 dBymlUv6Oi9l0WhnKwkwhDo5WW1ftijXEUVx11PpGGkPST7uXBPHiNnAk/twS7N/RuEq
 pifLzntolDz8/U5jd7s1xddixHYA6LDSI953+U2YDL5uu1WiQI/+1fneTYPTVuoGIW1E
 3Lmn5gMPJGtFci+N8960irBajx+iWnvekUwrqV7Pmc8RDYMPlAgb3ft3cN+RWtGb7SxZ
 bq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725952009; x=1726556809;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m4e7yrZL8EI2osvdoujnFqGKwjgylpzzlVIrd8thyC4=;
 b=pdac9ST/Cq5PEmbPn9G6dMeB6YZUzB5c2z+hrEOFzsYUKlVRYxmtw9JCLxYySF2hDZ
 8NYK+xfZawBhTPW7hB5cblxztBOQaO9sN6kakPMwrG8tCOCOpPwLjqazXEMZsgO2QK8T
 WIOpyAkirpZ7TSmUp6e/6Z6EishJFYEML/gMeEUGgamxudrZaxJ5NhsztSNeJrxOleYZ
 HwOi1uXkI+YUIuLBY2m/2hzteFLENz9GvvNj0HBLE0GvUJ69g5OEo9pSwFzP5sdXc6Tc
 G80xIDQkAoBC856DMgI5yHKCv2lsO4uNGJyynMZYUjQxXc1v7UBVGmIj1b2IH1FG+asY
 FJGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNXbsZqfaryye+CouiRlLgYhNT1AP0UrkOig8PguJsaRgGDl+cxdKZA4mAk8bxeIgCNuKx87PcGbXq@nongnu.org
X-Gm-Message-State: AOJu0YzbRQxn58RK+OVXykVchNmIB3ZC+LV4msnoj4eWB0c0V1yNJPGg
 TI5+eFfUVN7g4Zt80/CnZwkEn1R9TM4DSrvbOs/JxOj0d7a9NM975qaAErPCROo=
X-Google-Smtp-Source: AGHT+IF6YiimLNXg7MMG2TarPL7OS2vdllmKJbVpy0m8NBQgkpRqviV0WWULwg+Jqg7IPdhd4SdSpQ==
X-Received: by 2002:a2e:bc21:0:b0:2f3:aed8:aa9b with SMTP id
 38308e7fff4ca-2f751eaef7emr91026861fa.5.1725952008565; 
 Tue, 10 Sep 2024 00:06:48 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.217.32])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd8cd43sm3913147a12.93.2024.09.10.00.06.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 00:06:48 -0700 (PDT)
Message-ID: <ae3a0c8c-99a6-42b1-aeef-2b71b50ea611@linaro.org>
Date: Tue, 10 Sep 2024 09:06:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10 2/4] target/s390x: Use deposit to set psw_mask in
 save_link_info
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
References: <20240605215739.4758-7-richard.henderson@linaro.org>
 <20240909231910.14428-2-philmd@linaro.org>
 <9aac4861-b9b6-444a-b0fd-db03f21b1343@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <9aac4861-b9b6-444a-b0fd-db03f21b1343@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22f.google.com
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

On 10/9/24 01:50, Richard Henderson wrote:
> On 9/9/24 16:19, Philippe Mathieu-Daudé wrote:
>> From: Richard Henderson <richard.henderson@linaro.org>
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> Message-ID: <20240605215739.4758-7-richard.henderson@linaro.org>
>> [PMD: Split patch, part 2/4]
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/s390x/tcg/translate.c | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
>> index faa6d37c8e..53ec817e29 100644
>> --- a/target/s390x/tcg/translate.c
>> +++ b/target/s390x/tcg/translate.c
>> @@ -1417,6 +1417,7 @@ static DisasJumpType op_bas(DisasContext *s, 
>> DisasOps *o)
>>   static void save_link_info(DisasContext *s, DisasOps *o)
>>   {
>> +    TCGv_i64 t1;
>>       TCGv_i64 t2;
>>       if (s->base.tb->flags & (FLAG_MASK_32 | FLAG_MASK_64)) {
>> @@ -1425,14 +1426,17 @@ static void save_link_info(DisasContext *s, 
>> DisasOps *o)
>>       }
>>       gen_op_calc_cc(s);
>> +    t1 = tcg_temp_new_i64();
>>       t2 = tcg_temp_new_i64();
>> +
>>       tcg_gen_andi_i64(o->out, o->out, 0xffffffff00000000ull);
>> +
>> +    /* Shift program mask into place, garbage outside of [27:24]. */
>> +    tcg_gen_shri_i64(t1, psw_mask, 16);
>> +    /* Deposit pc to replace garbage bits below program mask. */
>>       gen_psw_addr_disp(s, t2, s->ilen);
>> -    tcg_gen_or_i64(o->out, o->out, t2);
>> +    tcg_gen_deposit_i64(o->out, t1, t2, 0, 24);
> 
> This is incorrect, as you've lost the high 32-bits of out.

Ah, I felt something was not right but couldn't figure it out,
thanks for pointing at it.

The original patch is not trivial to review...

> 
> r~
> 
> 
>>       tcg_gen_ori_i64(o->out, o->out, (s->ilen / 2) << 30);
>> -    tcg_gen_shri_i64(t2, psw_mask, 16);
>> -    tcg_gen_andi_i64(t2, t2, 0x0f000000);
>> -    tcg_gen_or_i64(o->out, o->out, t2);
>>       tcg_gen_extu_i32_i64(t2, cc_op);
>>       tcg_gen_shli_i64(t2, t2, 28);
>>       tcg_gen_or_i64(o->out, o->out, t2);
> 



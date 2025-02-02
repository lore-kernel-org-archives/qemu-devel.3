Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C42C0218F
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2025 21:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tehye-0004OU-DT; Sun, 02 Feb 2025 16:58:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tehyd-0004OJ-Ax
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 16:58:03 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tehyb-0003w5-O3
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 16:58:03 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2ef714374c0so5407303a91.0
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2025 13:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738533480; x=1739138280; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fTqnZPXyyPZKw82pTySeSG03uMY0dyQ2wh6W2gE0MTA=;
 b=Fv2COWMAlyfhmOSJD/DbaL2THLa+Q5W1pM+jNyZDRCc4Cxu03ZHbC7U9f1/yXR+I3M
 ZS614BSkueooP8cAeOyFWxKB38FJKexfdBirLWvaDb/1aubYl0qD/rUaXmK5to185lvs
 vFLlb2rxRSaqV8WnGRqm8d2i+T+0uymnYoLpEzwuyPmQ53KTZ8zp2lvt/jrBFnpR1Rw3
 FizF5XYvE2sllGDOuwAjNintKkzEIfXDYA+woG8g+edRd44AzTSUE7JohrdOihlnqkQH
 OghP3GBu2Hl1f9SpVhWLl72zZum4TsZuQ8xGTPNfhS3WeMbxFofFMTlfCZDKfcOt2IgJ
 En3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738533480; x=1739138280;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fTqnZPXyyPZKw82pTySeSG03uMY0dyQ2wh6W2gE0MTA=;
 b=Yl8ED9L+FFNuXzaSB0lcsptF0Z0+wsl5VeF/pVSPeh02+i27VmxBWe8crdvkVl2D6a
 7ZtVV2gNrlPUhKfj7Ag0FeQ3SlHb21Fy1/xzbv4Ofcp2QIYodQsylyEkhFSPtk3Gniz8
 WwtpfEMbfKonwpRRlS9ZLvFP814GxzJ9c5aAdRIRRTUd83+UMFrXbrrtNO/5pBpLH46P
 /PmRyVgjxWQjaYEpK6i8JHJmDHEQGGHWzJI22qxtJ6Mb77qjHAmUXQLWfvJZBcA7URWF
 cVpRRCJT/KpSQvlDwwfm6SFAbzzCE4VptGe1dfuEJ6NnHXTKjqFRz2myP9psWJA5lxGp
 o9iQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtx8kZU7XSf9QDNoaEZFTywxYOca9ewVPzHA7gID1vvwtCSuxqFDDFvRvUfC9aWZFXeDkiqVAgQMfX@nongnu.org
X-Gm-Message-State: AOJu0YyyvbLnZvJS6TUyuuq987SNyVvbY2+DrO5b4QauD1HpxorqFBA5
 MWR5LPyh+VqC8OsvmqEnizakP3FQuWQNSNGTF08b4bFXoryYHvmaox/GwFA8U1yHq5xut/xaf6R
 q
X-Gm-Gg: ASbGncsP8fmPfmECtqxN5i+B3ck3f43Sed8tJMJjlKwCF1rlrj7opPfaV99OhKrNtm5
 cm/R5cqmymg5aJXUSgWOx3qMS+8r8wdgxATzyUZIfOGjIualsgs6jHaD7trRMAF8t+62E4TW5ij
 2Kcd3oaBO3f3wvfuADWR3Fw0XZpx3KAZY5lklAFeojdCUlm4d/CFkT41deKzVF0rVQQKFWiv62h
 aRTqZYp3BqcfzQwqkRICPJ7N+OLm2G1D0IOp2MbLyWmJpQqwjDT+dXyd0TQRUAkauMw7mN48WRy
 D+eZZRsMnYDsWUkgxgAeRpzJ9qa3MzMTPnHZhU+dENEqp8O5A6JCkng=
X-Google-Smtp-Source: AGHT+IFGaP2zYBTjedSS28HDKhtvJJqPdZgKwxKzlrHL9I9VIrCb8X6xcdXlMsX0HhwxQGyfyHOO+Q==
X-Received: by 2002:a17:90a:d643:b0:2f2:a90e:74ef with SMTP id
 98e67ed59e1d1-2f994e31e84mr18897350a91.1.1738533479830; 
 Sun, 02 Feb 2025 13:57:59 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21de32eb9f1sm62403605ad.115.2025.02.02.13.57.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Feb 2025 13:57:59 -0800 (PST)
Message-ID: <6208a701-0338-4e1f-b0e2-28bf50d81f86@linaro.org>
Date: Sun, 2 Feb 2025 13:57:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/sparc: fake UltraSPARC T1 PCR and PIC registers
From: Richard Henderson <richard.henderson@linaro.org>
To: Artyom Tarasenko <atar4qemu@gmail.com>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20250131214528.117846-1-atar4qemu@gmail.com>
 <99ea71e8-b978-41c6-8ba5-f056935ea39e@linaro.org>
Content-Language: en-US
In-Reply-To: <99ea71e8-b978-41c6-8ba5-f056935ea39e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 2/2/25 13:46, Richard Henderson wrote:
> On 1/31/25 13:44, Artyom Tarasenko wrote:
>> fake access to
>> PCR Performance Control Register
>> and
>> PIC Performance Instrumentation Counter.
>>
>> Ignore writes in privileged mode, and return 0 on reads.
>>
>> This allows booting Tribblix, MilaX and v9os under Niagara target.
>>
>> Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
>> ---
>>   target/sparc/insns.decode |  7 ++++++-
>>   target/sparc/translate.c  | 20 ++++++++++++++++++++
>>   2 files changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
>> index 989c20b44a..504147563c 100644
>> --- a/target/sparc/insns.decode
>> +++ b/target/sparc/insns.decode
>> @@ -96,7 +96,10 @@ CALL    01 i:s30
>>       RDTICK          10 rd:5  101000 00100 0 0000000000000
>>       RDPC            10 rd:5  101000 00101 0 0000000000000
>>       RDFPRS          10 rd:5  101000 00110 0 0000000000000
>> -    RDASR17         10 rd:5  101000 10001 0 0000000000000
>> +    {
>> +      RDASR17       10 rd:5  101000 10001 0 0000000000000
>> +      RDPIC         10 rd:5  101000 10001 0 0000000000000
>> +    }
>>       RDGSR           10 rd:5  101000 10011 0 0000000000000
>>       RDSOFTINT       10 rd:5  101000 10110 0 0000000000000
>>       RDTICK_CMPR     10 rd:5  101000 10111 0 0000000000000
>> @@ -114,6 +117,8 @@ CALL    01 i:s30
>>       WRCCR           10 00010 110000 ..... . .............  @n_r_ri
>>       WRASI           10 00011 110000 ..... . .............  @n_r_ri
>>       WRFPRS          10 00110 110000 ..... . .............  @n_r_ri
>> +    WRPCR           10 10000 110000 01000 0 0000000000000
>> +    WRPIC           10 10001 110000 01000 0 0000000000000
>>       {
>>         WRGSR         10 10011 110000 ..... . .............  @n_r_ri
>>         WRPOWERDOWN   10 10011 110000 ..... . .............  @n_r_ri
>> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
>> index 7e5c7351cb..285c9b0a59 100644
>> --- a/target/sparc/translate.c
>> +++ b/target/sparc/translate.c
>> @@ -2882,6 +2882,15 @@ static TCGv do_rd_leon3_config(DisasContext *dc, TCGv dst)
>>   TRANS(RDASR17, ASR17, do_rd_special, true, a->rd, do_rd_leon3_config)
>> +static TCGv do_rdpic(DisasContext *dc, TCGv dst)
>> +{
>> +    tcg_gen_movi_tl(dst, 0UL);
>> +    return dst;
>> +}
> 
> return tcg_constant_tl(0);
> 
>> +
>> +TRANS(RDPIC, HYPV, do_rd_special, true, a->rd, do_rdpic)
> 
> Surely reads are not allowed in user mode.

You might as well implement RDPCR as well, which *is* privileged.
Since PCR=0, then RDPCR is allowed.

It might be worthwhile to implement PCR, or at least PCR.PRIV.


r~

r~


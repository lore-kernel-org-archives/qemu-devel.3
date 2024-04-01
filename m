Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 699B6CD1288
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 21:18:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrP1w-0001fa-Hz; Mon, 01 Apr 2024 17:17:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rrP1u-0001fN-F0
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 17:17:22 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rrP1r-0008Tg-Os
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 17:17:22 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5d8b70b39efso3060537a12.0
 for <qemu-devel@nongnu.org>; Mon, 01 Apr 2024 14:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712006238; x=1712611038; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MHhXEnd0MbjMJ/Qb1+pGLb+PF3UomWpHlTfOh2cQ6Pw=;
 b=VwvkBbU4XJw9Apmvhgy1tbJbIGO7VUMdiKpZ+Q6Fcpwok9Br2YSAc2X5lPV+NuJVfA
 /2NuQn7HMJyirEFPmnhZf/6wY1FnquKlwxU61VGtrRvaww0LAqNqkfts7P3WOfbzCIBh
 ZnTufECsTMdqmTVx+H84QDDD0EsUQgpxJUoN7M5xUuUXKIG90iBB/EWQhjVsni/EzkPz
 k6MaROFXRs67LeWzX2J0cv9+401hyIqfb/roxhNx5ac0JrG1GIppKpVTaPVdW8/dUeNv
 kg/Ctc80QwkEx6id2tFaOEI5Y6WxQ2uXVLbztIPVhYCQS85BWTMmFH/mctCoLxyrCb5m
 wFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712006238; x=1712611038;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MHhXEnd0MbjMJ/Qb1+pGLb+PF3UomWpHlTfOh2cQ6Pw=;
 b=GPF75uFxVnwpXnLX3QiqZA1yR1HtFflEXWjctxOuqlSQoIgTIwel5VdF3j7EzTkfE8
 hBESym3R17Gy4p4BbSfIndLT5ryN5OGAWxTK1hToP1CyWi+OPlbZcEShyw+9W+zC408w
 sfj9eYr0RU9lpTm4b/mgKI2vFUBC4Y6NGStE9Jz5HZGnCdo1lvHWvYFYd2rU15e44XKa
 wXvpWoIate1itr0YyF7lY/lvQij5ls4i+4cfYFyHCCUMCrceNOEDJgAZ4ftig5X3UdK8
 23GIu0inIXc6rMSiKe2E/nFOsYeuzsPBR6quOkzu7ZkuLINrx8IR32UZn6JbVN0/Qeph
 zHzw==
X-Gm-Message-State: AOJu0YyQ3ckudT6U/7l4pVze0ba71QVhp3MQyULzFlgthbHJTjWODQw9
 BGkSQO1XySrWL9eh9dOx87FYr2cLoJJj9tLOxbZBoO09NbJKGwYcZKY5I7X0/pY=
X-Google-Smtp-Source: AGHT+IH36ZdesYZ4mjg2CM2QJD+Fs/EiDyuZKdey2vddknjaiac5IOdaemCgQsUSqjYCsoxDNA/iqQ==
X-Received: by 2002:a17:902:d491:b0:1e2:15ac:1c09 with SMTP id
 c17-20020a170902d49100b001e215ac1c09mr10183354plg.29.1712006237999; 
 Mon, 01 Apr 2024 14:17:17 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a170902c18500b001dddce2291esm9447832pld.31.2024.04.01.14.17.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Apr 2024 14:17:17 -0700 (PDT)
Message-ID: <069d1894-0c91-43f2-a33b-904cb89ac16e@linaro.org>
Date: Mon, 1 Apr 2024 11:17:13 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hppa: mask upper iaoq bits when returning to
 narrow mode
To: Sven Schnelle <svens@stackframe.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>
References: <20240401145201.2175873-1-svens@stackframe.org>
 <0f5697e6-da79-424b-866d-40d11b4db0bb@linaro.org>
 <87msqczujz.fsf@t14.stackframe.org> <87il10zu46.fsf@t14.stackframe.org>
 <87edboztrt.fsf@t14.stackframe.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87edboztrt.fsf@t14.stackframe.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

On 4/1/24 10:56, Sven Schnelle wrote:
>> This seems to be caused by IIAOQ's containing the upper bits. With the
>> patch below i'm able to boot. Not sure whether it's correct though.
>>
>> diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
>> index 58c13d3e61..f7c4cca8f1 100644
>> --- a/target/hppa/int_helper.c
>> +++ b/target/hppa/int_helper.c
>> @@ -123,8 +123,14 @@ void hppa_cpu_do_interrupt(CPUState *cs)
>>           env->cr[CR_IIASQ] = 0;
>>           env->cr_back[0] = 0;
>>       }
>> -    env->cr[CR_IIAOQ] = env->iaoq_f;
>> -    env->cr_back[1] = env->iaoq_b;
>> +    if (old_psw & PSW_W) {
>> +        env->cr[CR_IIAOQ] = env->iaoq_f;
>> +        env->cr_back[1] = env->iaoq_b;
>> +    } else {
>> +        env->cr[CR_IIAOQ] = (env->iaoq_f & 0xffffffff);
>> +        env->cr_back[1] = env->iaoq_b & 0xffffffff;
>> +    }
>> +
> 
> I guess the interesting question where should these bits get masked out
> - i would assume that this place is to late, and it should happen
> earlier in trans_be/when the iaoq value is copied. On the other hand
> you had one commit that removed the masking in copy_iaoq_entry()...

I would have said this masking should not happen at all.


r~


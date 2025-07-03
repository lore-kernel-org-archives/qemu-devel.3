Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9048DC83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 16:56:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNDt-0007sM-1x; Thu, 03 Jul 2025 12:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNDr-0007s7-Nk
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:55:44 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNDo-0008B3-O7
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:55:43 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a4ef2c2ef3so9000f8f.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 09:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751561738; x=1752166538; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hYYsoPhUt2rwghSez0OC1r1SNN/QZSz1/N0OAe81ego=;
 b=TKtMR+VTN1I8JJd06pQG9p3sYbzM1Ru1Ler4cGobywgXoXgh9XwqwroTWoPVpIDqY4
 uDYSHOjnkfqJqEbAplmLZXZm8S7CUaEb9d0nuh3YzNMT731RBPOcUX8OtpTvKqE1VYha
 26PNRlrfsQKQuR0fPJYGrJAvYJqi8Rpl/wo7+xEwR+v/VS/bk8A/p2vf//AO+o1Cq2ZK
 BLDtfKSNE2n/MIlhev1vQxvbUy9x0L60AaeIo5/E3ZHUSV/TGgQp7gdCSW3/vDjPOtqD
 d3cTR5XeDRaB7Oj55asoELeQPQneOOBlVaTNmbC+UsPFIqH1JNZRSw3jBsBojbfrioAG
 9UHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751561738; x=1752166538;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hYYsoPhUt2rwghSez0OC1r1SNN/QZSz1/N0OAe81ego=;
 b=jK01uXpRU4XG2dehNmZeRjn0hweOk5tUdMdNzy/S26Hy93e09wqt4/edjS7CDR0vro
 AU1Mpaa2ic8dN1i9MAji+hBiU5S6ZbWmhG75OLfNGtoqrYvn91OePcwXuG5ys5WrXCYk
 xT6EGTWpsmbLDIS2umK2+Rd8KaacwaTrFlDgfeY11PbcblPxj0igJ4EelVZ5CQAvEPE2
 4Cj29ozMJbzvK2GAN0oqsr/BLg+3olNqUEokpmWfCxFbWg+L4xrSx8sAiifuzjNI+aO0
 sFVmYogS8YmqNp0+HEWEZFw4JyHFTEAggRHvfUukTyXkVCAEIcgUFqT2HOAsMszBnA10
 3HgA==
X-Gm-Message-State: AOJu0YyIsER4oaw8vaGywxh25h6E2hJwsqMpp4LhLL0hAfMqD+dmBVFA
 bkDVeyZb0ENb7JhBhFV5kQDBEbnvyP/jOtz1kkNHq6ppE+gDzwTttLx83oxkhgBjcxY=
X-Gm-Gg: ASbGncv9iPohljtE9ImslXNIP6lZIahtBo5PgAT/sxuV5886AIaA6SoY+yjX9OgK4c3
 YA2gOMlRPt3QnJp5Z5zD8/XovbypNXKrjeZ3uRpbZfBskh6xrf1WwTHmEohZUFLsy9PDL4xIwJT
 7i78mqQws1X8cHJ/ICA78sDiw+LLGlcTnJO6xHd3Ka2UWOtyzJk05JEEqA14jxhvn6cTgu5BlM0
 NGVwZ3OX7PFmubQ6+2hycYhIufQqjOHCYZJtgYj2cPINR5TfbKwqQlDWmx3YpQxsdj0CeThnnwp
 yql1XRpY8Rn3mA/gl9L2SUERcAiIK6M9jpKhW5GTmQ5iDUAbhXzhwh7qHkahbhlROKd5lqQ2rQ6
 D+trxrg4tuujlmTXZjF6m3dIOz2Ky3g==
X-Google-Smtp-Source: AGHT+IHLUEZ5vDy4UpJ8pCKMBdiahdN4DFcUr6FxKXFZdwgF+JfkAVchTkNT9I4nLqN07mkCrXiLxA==
X-Received: by 2002:a05:6000:481c:b0:3a4:fea6:d49f with SMTP id
 ffacd0b85a97d-3b2012f94f8mr6499301f8f.49.1751561738527; 
 Thu, 03 Jul 2025 09:55:38 -0700 (PDT)
Received: from [192.168.69.218] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454b1698e91sm2651495e9.30.2025.07.03.09.55.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jul 2025 09:55:37 -0700 (PDT)
Message-ID: <4cde90c2-abc9-4221-9571-d66f981bff8a@linaro.org>
Date: Thu, 3 Jul 2025 18:55:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/65] system/cpus: Defer memory layout changes until
 vCPUs are realized
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Peter Xu
 <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
References: <20250702185332.43650-1-philmd@linaro.org>
 <20250702185332.43650-3-philmd@linaro.org> <87cyahcjt5.fsf@draig.linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87cyahcjt5.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 3/7/25 18:37, Alex Bennée wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> vCPUs are not really usable until fully realized. Do not attempt
>> to commit memory changes in the middle of vCPU realization. Defer
>> until realization is completed and vCPU fully operational.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   system/physmem.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/system/physmem.c b/system/physmem.c
>> index ff0ca40222d..8b2be31fa7e 100644
>> --- a/system/physmem.c
>> +++ b/system/physmem.c
>> @@ -2792,6 +2792,14 @@ static void tcg_commit(MemoryListener *listener)
>>       cpuas = container_of(listener, CPUAddressSpace, tcg_as_listener);
>>       cpu = cpuas->cpu;
>>   
>> +    if (!qdev_is_realized(DEVICE(cpu))) {
>> +        /*
>> +         * The listener is also called during realize, before
>> +         * all of the tcg machinery for run-on is initialized.
>> +         */
>> +        return;
>> +    }
>> +
> 
> This is a c&p of the wording bellow:
> 
>       * That said, the listener is also called during realize, before
>       * all of the tcg machinery for run-on is initialized: thus halt_cond.
> 
> which is now redundant because of the early exit?

Commit 0d58c660689 ("softmmu: Use async_run_on_cpu in tcg_commit") hmmm.

I don't understand enough this area, so I'll drop this patch for now and
keep carrying it for split accel.

Regards,

Phil.



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891F3C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 18:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwR5n-0006lC-Ky; Mon, 15 Apr 2024 14:30:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwR5l-0006kw-OZ
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 14:30:09 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwR5k-0007uD-0j
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 14:30:09 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-516d2b9cd69so4256954e87.2
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 11:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713205806; x=1713810606; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ErqVx4xQAmKM1pbFeZnxTYHT3KuUv0DO97EtB5dIXHA=;
 b=jIZkMFMQV3yEnLEbSZeOJudkl95HhAPglU2SkBN3xuFpoD48mBJZHd675Uis13UiLu
 Sljdd5dvpymM6hEtlxpM02Qs9/ptD2dlvpbYUqUxn4ZE6wSydmTgDTUfw0zX9efhw9KB
 NeF9/wwP7+vPPrmaX1og0NRb0s+Yjf/55Bmhqn1hwNoLSUivcsk1OsxjWjVPTSXQCLm5
 lQKd2ips+gTaT+JzJEL5uvJh87vii+4WfebGodJxhXE4lDuoNajaW7AJW7zLdqbHZWRd
 NHqXkHhi1O4NaJE+DkXsOhMrn/fsJ3CMcm+Y4cpt1D8AHZ0RSJfuw93XZEVW6/Bbd7Q2
 r9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713205806; x=1713810606;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ErqVx4xQAmKM1pbFeZnxTYHT3KuUv0DO97EtB5dIXHA=;
 b=lhY1803otIFQGsSihOeKfq+Cay4LqA7mIvW6sfkNe1nTZuV4w7fvK7Ef6ZZo+Ef9Pz
 HUuQ1I1RFB91Sr9nXgWM3gHKcjM8TvbruijFPUC2gVXxC7ebKZ/g76IHxtd7m+86wFd3
 RgdzXZuHlI+g3zV+y9730wJwmmfTj941K/vCAXbjePyYUapriscctMVPFUz/df8O/guN
 x4ctEk0bkTiycgEZw9HN4eOMIq7VxQPARqwUXmFgWbALwjiEwO7Laiu1Vf2a7s0DkQc7
 9bn3jSecAxx55Xe5j+TVb2Hhi2OaSQ6X5LbMBWw5YqBf15POyS18W09VsX8ME/FR7fUr
 T7+Q==
X-Gm-Message-State: AOJu0Yyf/fGtbiUVHoGyBzPav93TTxI5MOxeDLpuHZt8iZ/rxNPWQnyM
 PMEIJB8OXj5tAzLHIQB97SKNPoPlgWvay8BeTW4RDbX77R2BxpOSVGmz5RqbVOM=
X-Google-Smtp-Source: AGHT+IEnI7HsAbnUgKwlwMvMAMayFD7KhTFd8uFT8rpoRJsrDL2sAnxDhWxbSigBCJc/48B+qwXyPw==
X-Received: by 2002:a05:6512:3107:b0:518:6d2:2a8f with SMTP id
 n7-20020a056512310700b0051806d22a8fmr6651256lfb.24.1713205805594; 
 Mon, 15 Apr 2024 11:30:05 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.132.126])
 by smtp.gmail.com with ESMTPSA id
 t4-20020a05640203c400b005704011143asm70371edw.93.2024.04.15.11.30.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Apr 2024 11:30:04 -0700 (PDT)
Message-ID: <78b7d022-1bb8-4b1d-ad52-db241582350c@linaro.org>
Date: Mon, 15 Apr 2024 20:30:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/i386: Give IRQs a chance when resetting
 HF_INHIBIT_IRQ_MASK
To: Paolo Bonzini <pbonzini@redhat.com>, Ruihan Li <lrh2000@pku.edu.cn>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240415064518.4951-4-lrh2000@pku.edu.cn>
 <CABgObfZmQoSBMQx=t0UYCa6t5d9RRZKy23zeW3orrBYnVQtKYQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CABgObfZmQoSBMQx=t0UYCa6t5d9RRZKy23zeW3orrBYnVQtKYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
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

On 15/4/24 11:32, Paolo Bonzini wrote:
> On Mon, Apr 15, 2024 at 8:50 AM Ruihan Li <lrh2000@pku.edu.cn> wrote:
>>
>> When emulated with QEMU, interrupts will never come in the following
>> loop. However, if the NOP instruction is uncommented, interrupts will
>> fire as normal.
>>
>>          loop:
>>                  cli
>>                  call do_sti
>>                  jmp loop
>>
>>          do_sti:
>>                  sti
>>                  # nop
>>                  ret
>>
>> This behavior is different from that of a real processor. For example,
>> if KVM is enabled, interrupts will always fire regardless of whether the
>> NOP instruction is commented or not. Also, the Intel Software Developer
>> Manual states that after the STI instruction is executed, the interrupt
>> inhibit should end as soon as the next instruction (e.g., the RET
>> instruction if the NOP instruction is commented) is executed.
> 
> Thanks, interesting bug!
> 
> What do you think about writing this:
> 
>>       /* If several instructions disable interrupts, only the first does it.  */
>>       if (inhibit && !(s->flags & HF_INHIBIT_IRQ_MASK)) {
>>           gen_set_hflag(s, HF_INHIBIT_IRQ_MASK);
>> -    } else {
>> +        inhibit_reset = false;
>> +    } else if (!inhibit && (s->flags & HF_INHIBIT_IRQ_MASK)) {
>>           gen_reset_hflag(s, HF_INHIBIT_IRQ_MASK);
>> +        inhibit_reset = true;
>> +    } else {
>> +        inhibit_reset = false;
>>       }
> 
> in a slightly simpler manner:
> 
>      inhibit_reset = false;
>      if (s->flags & HF_INHIBIT_IRQ_MASK) {
>          gen_reset_hflag(s, HF_INHIBIT_IRQ_MASK);
>          inhibit_reset = true;
>      } else if (inhibit) {
>          gen_set_hflag(s, HF_INHIBIT_IRQ_MASK);
>      }
> 
> No need to submit v3, I can do the change myself when applying.

Cc: qemu-stable@nongnu.org




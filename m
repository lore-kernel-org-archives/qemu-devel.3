Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B985C87FD2
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 08:35:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulNya-00086E-Ml; Mon, 11 Aug 2025 04:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulNyX-00085x-7o
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 04:33:49 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulNyN-0008T3-3B
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 04:33:48 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3b7892609a5so2271775f8f.1
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 01:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754901214; x=1755506014; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YFcjllRVptL2Zs+wrc+7lz4hy832fvh6aPDM03wksP0=;
 b=y683+4oFqHC85xtEET9gR5wHgHPDYG+hqpjfULfstqdsCF4okQN4XxtUZPV2+zXLLu
 G4vPoNp+W0F9aopTD94fPmMJMOEG1miErelvnsg0z2zoV3uwK+9sWhVhF2r9gaBx7o7T
 MIKJm53H5+3KROeoV6aF0teA3Hgc1A9SWEtrBcXLhYK2a14ze6tS/91eDoc+JPScIGjn
 WRWvWCGMRYyyBzWsoxLeZYJT/Qbe8fhCM77OttkgDlH8hWEais2XqRRSAASNbHbXayTp
 T9S2aYPV3oxo8C2ttRafbVYEzLoVwt1GuhwqcCZW6AtGUK4lavcbwpRtAVvGGjnel4CQ
 q8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754901214; x=1755506014;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YFcjllRVptL2Zs+wrc+7lz4hy832fvh6aPDM03wksP0=;
 b=Tsh7pVrMmR/Qa2BinqSeant9yYd4q7JTXWAEmh6+syt91pUQxIeG6dowaVrmd4/Ox4
 lymGM1bCkcOq/8Q+7M1jZnXHvJRIYkyF6E2O/qyKeu60Aggl3T9NYoZazslUHGss7rg0
 h7L7O70mmVVYU+yu97xaCzbNfm9UXTBFWK/JNbKzbVJHeGzGfHE7mggT9usJ1eZGsRgL
 8O4rF2fTTFBZEOpJP82Jsoy63zHRnItIH9ABkOYEyUH+PlrBaIlpPozWDtWe+yFc736b
 WvF/Ilq98PBcfAIn2+IcHhuN+gU2wa0fhDATzKp8vzFKKqGtmCHhmIjoU0Pzjr71FQ6m
 3qEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUToar/xhLylA3CcV7nOIgh4C/iLmbxEBugmwmPNinmE45ejkNNIR3TP7TuDre9gb/N4Zn9sMbr42XD@nongnu.org
X-Gm-Message-State: AOJu0Yw4yAFXJdq/ZBFoWanLlh9ce/GLzLX8odCa/zFXZMt/2Ay6Dm+T
 wmTOpBUiHQelp6vCPVm4rVUO/8GknudR1xPJ7XwpLUgdfB8GP6qe65/g8LQ+57OvrECYH6U03+6
 P9Up7
X-Gm-Gg: ASbGncsXFyMFbB3TtnmMfMAM2pMIErfCw3CFz24VLIWcZFIB51KZ2R+SG6Pcjv7UzW8
 lmQnKcKoa2cAcDSqFaCb/0EiCWBuSO+Ek5SID7EG3WCIarcEgFnVSk+aXPBy+BF/oQG7BZrlL7k
 /emjy1cXafwW1wywa570+nhLS2cFCJTJCA4OJDTTk1yJQAaKfDctJHwi1+GraF7swUU9peOjz6C
 lg4ySrEd9tAXi4Aiyr1eX8s5fqDnjiZIXs8lF7gjKu+Tp2B7Qz0262abNivKFjdQTwrRfIEJkKz
 hxVKP7ky6WqJhOwKc5rvFa9IoUwgCORlGwq1PdiDwAyHshDIhsD8K8f17y5tFQ0f7uHpeGa3dxf
 SVqCKn1Nfo1FAebriZcm5jixGR6BlkhkZ1H2yfcYOct+FjRvdCwKQZziak6IHtzqybS75HtgiDF
 zv
X-Google-Smtp-Source: AGHT+IHEl8clm8vum4gRt35MgXvus9J45ShAFcbEmMyvoD4jOQbA0hLQjVm6DkGzb5TtSCpbGB9EAg==
X-Received: by 2002:a5d:5848:0:b0:3b8:893f:a17d with SMTP id
 ffacd0b85a97d-3b900b511b8mr10169525f8f.49.1754901214543; 
 Mon, 11 Aug 2025 01:33:34 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c4533e6sm40641341f8f.35.2025.08.11.01.33.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 01:33:33 -0700 (PDT)
Message-ID: <0b1f2388-a1a8-457e-a60c-3f34f6f1bf80@linaro.org>
Date: Mon, 11 Aug 2025 10:33:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] accel/tcg: introduce tcg_kick_vcpu_thread
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com, peterx@redhat.com
References: <20250808185905.62776-1-pbonzini@redhat.com>
 <20250808185905.62776-5-pbonzini@redhat.com>
 <d7923560-58b8-4967-ae2b-2cabf5dfea7d@linaro.org>
 <78ceb108-670b-4be6-9d74-4521c0b6d872@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <78ceb108-670b-4be6-9d74-4521c0b6d872@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 11/8/25 08:10, Paolo Bonzini wrote:
> On 8/10/25 01:26, Richard Henderson wrote:
>> On 8/9/25 04:59, Paolo Bonzini wrote:
>>> +void tcg_kick_vcpu_thread(CPUState *cpu)
>>> +{
>>> +    /*
>>> +     * Ensure cpu_exec will see the reason why the exit request was 
>>> set.
>>> +     * FIXME: this is not always needed.  Other accelerators instead
>>> +     * read interrupt_request and set exit_request on demand from the
>>> +     * CPU thread; see kvm_arch_pre_run() for example.
>>> +     */
>>> +    qatomic_store_release(&cpu->exit_request, 1);
>>> +
>>> +    /* Ensure cpu_exec will see the exit request after TCG has 
>>> exited.  */
>>> +    qatomic_store_release(&cpu->neg.icount_decr.u16.high, -1);
>>> +}
>>
>> So, now both cpu_exit and cpu_kick set exit_request.
>>
>> You ifdef this out again for user-only in patch 7, but this does 
>> suggest that kick and exit are essentially interchangeable.  You 
>> rearrange things a bit in patch 6, but it's still not clear to me what 
>> the difference between the two should be.  There's certainly nothing 
>> at all in include/hw/core/cpu.h to differentiate them.
>>
>> Should we instead eliminate one of kick or exit, unifying the paths?
> In cpu-exec.c terms, qemu_cpu_kick() *should* go out to 
> cpu_handle_interrupt() whereas cpu_exit() *should* go out to 
> cpu_handle_exception().  The difference matters for some accelerators 
> where qemu_cpu_kick() tries not to take the BQL in the vCPU thread.

While I'm still learning this area, this answer makes sense to me.
If this is correct (reviewed by others), can we document it in the
corresponding prototype declarations?

> 
> Until now TCG's implementation of kick_vcpu_thread set both exit_request 
> and interrupt_request, and I'm not changing that yet for system 
> emulation.

For long I tried to figure out why both are set there.

> Patch 7 does that for user-mode emulation, because it's 
> trivial: neither linux-user not bsd-user use qemu_cpu_kick() directly.
> 
> Paolo
> 
> 



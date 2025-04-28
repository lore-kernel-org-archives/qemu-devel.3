Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F4EC369DC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 22:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9WwB-0003Vw-HE; Mon, 28 Apr 2025 18:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9Ww9-0003V5-6C
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 18:26:53 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9Ww0-0000Xl-TJ
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 18:26:51 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7376dd56f8fso7279661b3a.2
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 15:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745879199; x=1746483999; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VXnU4y2uum/hyVLkGiTbKCYOdx7OrE9UbzpXvgNrBVY=;
 b=tJfCZsiRnkk5uAO1qz6/FcXpC35CGsX7c9IH4N5IPvtXzcXhsCG2Vb5ugyQMculFYz
 iEUlBoKaF9G6+/reGVPR+AidvnlNxPbapG8j4T8I7CvF2sJakuA01gt0BJa3W5fhvK1E
 DBOk92igtzkgLIr7E506mquGsjsQElasqeo3YrMNZpWzmBe9dz59DSAKPLlUXrU6Qzvc
 DLVRf0gu9k5U/MEILB5NaSDkhPywor1c28kWmhrR2wcQuJZnveU6dP3Y6Xv3CLXKeYrQ
 3kfU8+aGe24TyX7lpKtyWaVSW9hlfZpOU0kBYU7HsnSB3vT2+swxkfCmBzdM5f6X0OUa
 +6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745879199; x=1746483999;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VXnU4y2uum/hyVLkGiTbKCYOdx7OrE9UbzpXvgNrBVY=;
 b=R4wKNLGIbQ3AOaDbEpPlngL9uHfSOvpwpnk7NLjcoQvwxmwigXnEE0DaQucFTBIIf9
 NMO2mU3xCRVpGUnQBXNmRmFzHZOPoVr8MQ1GeiHUrAhtdRBOvJ3hV/p397EjzhSwaIvz
 6D9LtklsBI+n1Wg32xzHl4oiiXR9BV/Wgq4ZBoqPE1CTgyW2QJQ7ZJFFTe1wJ5QgCXb8
 MLOR+4JpUpTRK8s/aEF8a9KBIUl0uR7BFDltcUbEf+2x6QnUSohoPct7bc+lLh09S8sC
 NO93EOXjJgz9WxFXx6ULPQKS92+dpcI67bGRyNiBagv+TUtiQPyjf4mKLYUz6gpLiclX
 yXbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWz3o1rncSFwjh8uNd5B1+SoIqaVVQq12S1KuhsrLnya7Ya4xftbZ4r8rcvA3CQb3LkijRT27qhx5oc@nongnu.org
X-Gm-Message-State: AOJu0YxN2QEzMjtyhJs8romMWqtcHz3GNZei6oW4bNMzdcxgWSgOPzzo
 +a446eOW24ZuYkVYVcvkomBbgUL4ioK7DY/AwjpXZHSmEegIrlBQKin7aMDYeLs=
X-Gm-Gg: ASbGncuopHYeb0HZfJA+5bMK80mWnJtwOmWqjBl0yVt9kUknlYZfHBa2oo6ZiEzuWMs
 2VkSB6nRHY1UsFUPS1CZ0MtZPwTW8mROpF2bMEKqWZrLG9vXmxBB8MJTLiF46AMZkB35Vcwxc+E
 JP9F5IjZJHosDlH/Zh1gfJFTGY5quIMYDYWkiJsshRsE1Umo4fPCsTgF8LUI41AAjQ9AjKk44Ej
 lfp4CX8EADivhPMAY5NE1dIIWUoTiXBdNlwZjOxvFF1wBe/71T/PouNJVhzalwNcQA5bkXn+QX8
 MYsp7AGFtY/2ybupB3wwRTL32kkajd21ZR87QaUrUYBXRc1ys1e0tw==
X-Google-Smtp-Source: AGHT+IE6vS+hH2j6TQQ7WtROxneZAtlsQ8aNezJ3pWHU/YvKLUsBfHXRq3U4FTc20DkOpBmsc35kyA==
X-Received: by 2002:a05:6a00:2303:b0:72d:9cbc:730d with SMTP id
 d2e1a72fcca58-7402929fdc3mr1016440b3a.11.1745879199249; 
 Mon, 28 Apr 2025 15:26:39 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25912efbsm8565531b3a.23.2025.04.28.15.26.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 15:26:38 -0700 (PDT)
Message-ID: <db0b8cff-b79f-4f4f-8322-c9f41462cdd5@linaro.org>
Date: Mon, 28 Apr 2025 15:26:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] accel/tcg: Return TCGTBCPUState from
 cpu_get_tb_cpu_state
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250428201028.1699157-1-richard.henderson@linaro.org>
 <20250428201028.1699157-8-richard.henderson@linaro.org>
 <e56a1170-9e0f-4aed-83f5-99ac5c1261a3@linaro.org>
 <31ec7f6c-e5fe-401e-96f4-74bc7b0dee36@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <31ec7f6c-e5fe-401e-96f4-74bc7b0dee36@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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

On 4/28/25 3:07 PM, Richard Henderson wrote:
> On 4/28/25 15:00, Pierrick Bouvier wrote:
>> On 4/28/25 1:10 PM, Richard Henderson wrote:
>>> diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
>>> index f5e5746976..8dbe79ea7c 100644
>>> --- a/include/accel/tcg/cpu-ops.h
>>> +++ b/include/accel/tcg/cpu-ops.h
>>> @@ -18,8 +18,13 @@
>>>    #include "exec/vaddr.h"
>>>    #include "tcg/tcg-mo.h"
>>> -void cpu_get_tb_cpu_state(CPUArchState *env, vaddr *pc,
>>> -                          uint64_t *cs_base, uint32_t *flags);
>>> +struct TCGTBCPUState {
>>> +    vaddr pc;
>>> +    uint32_t flags;
>>> +    uint64_t flags2;
>>
>> Could it be named cs_base instead?
>> flags2 is a little bit generic.
> 
> Of course flags2 is generic -- it's only cs_base for x86.
> 

It seems to be named the same for other architectures as well,
so it's wrong for all other arch too?

My point is that:
tb_gen_code(cpu, s.pc, s.flags2, s.flags, cflags);

is error prone, and it's easy to swap flags and flags2 by mistake.
I don't mind the name, but something more distinct would help.

> 
> r~



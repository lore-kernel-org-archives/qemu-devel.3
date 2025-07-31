Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A92C87FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 22:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhbhJ-0000lO-Eb; Thu, 31 Jul 2025 18:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhbhH-0000jx-Fs
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 18:24:23 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhbh7-0007sl-UQ
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 18:24:22 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-76bd202ef81so1286459b3a.3
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 15:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754000651; x=1754605451; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h1XTAZmQ9Z9hWX/51etGJMmVHUV3OyDs+oeAAYHV6CY=;
 b=rPJ42wvnp0HALdi4DrNoTBnIqnnqQZCZ7XfzlIdxihA1TpKYU0UkowlSZ5jCAdnHZ0
 Kd4QWYZ2IYEwJHOxN0Ge1G6lcYXSjvc6aM4dtG750H0sPx0HpAj4OFMTCIf12yHrhdNy
 OvAAfTl45T/NfUIr3l5VuMX9XKCn3XEBOEhK88FLfVOZdarLfXU2n2K75ahUM2ELJo9H
 0lMnLuBj/gGpK8EDaxHwZUjrZTB/+mEtN12YFOrkcqjhL6TR2IBPO9j7XXKNCFjQq3To
 TyzyO7EdCs+zzqDUDtPzbxQRF0HJc+smSLHSc87RsNSpsS1nbaSckY3/+Qrf4Mz7jwfv
 VWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754000651; x=1754605451;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h1XTAZmQ9Z9hWX/51etGJMmVHUV3OyDs+oeAAYHV6CY=;
 b=sEHeAat7yCInUT0cQtmjbAokOhcSFi7pkbyuGncYjRpwXcUa+gbWkDdCiQNRVA48xT
 uD9LpZS4LesRjZsl+ptS/BK69pM/YBuCEEvgDNbewEjaDY5L3NNg06Sb81qexZOm3Ce6
 owkm9KKkAXx9JNCbmSdJpuYfGEHSTslOMtkNz63cLiBlBZCZeufvndjHxSHcvATVIcu3
 U78v4Xh3SpWmJvQ0EdQBOcdl1cZv5iKuElad1GhjUG/p2bhAPq0A9fdhP16/pkHqHNWe
 MA/x7rL9OrI5US+l0OS1WRKsRE4JJ9q5vd6Y4iZHgumo7R4vev05ad9GwKkoTXTpbq7u
 hrog==
X-Gm-Message-State: AOJu0Yyp3cy84cAvMLW5dVlenUdE6EKkDk63419m5Nr0oPBfM9f1nsSh
 3RJ0cyTSzGu7rp0UQKau02xlIIl9edk4hWcGUV8QnV/PQqdIHQbOU1kH2Dha4cMs06c=
X-Gm-Gg: ASbGncu2CcCaKo3l4J4gFMqIeZXHMuIT1bAI1iwo/rm922laDsuJxt2tMzbqQe1MSvg
 nYJ3h4D7DlpvJo0l+q3yR/inCahg6izCNpTEaJLNS+Hj0CsfPfDgheIve+Yq1XN0WCvP+HiSz6I
 PgAEAjcMKp4NPol+QRbgPlT9r+Bx6nZh/jtOCcmWt5Zqfr+rO5tAhr5k880JcW+Te8x91v1RNc+
 jLQpBSRrbIwEcpIUfnZL2GCwGvOsWSfRJS+GRuYIYrueom4qWgMzwGnR9YdOwCoZaJ7Ig8rvaOb
 6wzR+SumGKKx6H2Rb7KwlATZgsV01fROteuXwiBm63C0MBQ04qOOkTUktrlyNAdaNxrRHIpyYVC
 0wRuCYm0wp0t9btK0CSAH1Av9sIU31Qjxx9E=
X-Google-Smtp-Source: AGHT+IHcOvx4GGDL5U1HJR9YfOssv4B27HQuzOzHPs7a29XQxQBdfVwWMbD2S/tYUm061H2jTHCM1A==
X-Received: by 2002:a05:6a00:1954:b0:76b:d791:42e5 with SMTP id
 d2e1a72fcca58-76bd79148e2mr2692816b3a.17.1754000651217; 
 Thu, 31 Jul 2025 15:24:11 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bccfd4c1dsm2466492b3a.100.2025.07.31.15.24.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 15:24:10 -0700 (PDT)
Message-ID: <16a2b79e-63fa-41d8-81f2-b3cbae094343@linaro.org>
Date: Thu, 31 Jul 2025 15:24:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] single-binary: compile hw/intc/arm* files once
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20250725201906.19533-1-pierrick.bouvier@linaro.org>
 <bfdd8821-a7f7-4648-a389-124426da6d15@linaro.org>
 <144f0930-af30-42b0-849c-99242d3f09ee@linaro.org>
 <CAFEAcA-ycO=AO8UO+X3f6pw34J=iFwW3dpPyMXKm5BzJ11dt5Q@mail.gmail.com>
 <25fe9c70-be00-4884-8d91-53dfff745cb6@linaro.org>
 <7cc71966-5165-430d-80ec-6de6d5e6dc1b@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <7cc71966-5165-430d-80ec-6de6d5e6dc1b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

On 7/31/25 2:27 PM, Philippe Mathieu-Daudé wrote:
> On 31/7/25 20:30, Pierrick Bouvier wrote:
>> On 7/31/25 9:23 AM, Peter Maydell wrote:
>>> On Mon, 28 Jul 2025 at 20:34, Pierrick Bouvier
>>> <pierrick.bouvier@linaro.org> wrote:
>>>> This old commit (7702e47c2) was the origin of having interrupt related
>>>> code in a generic folder, but I don't really understand the rationale
>>>> behind it to be honest. It seems to be an exception regarding all the
>>>> rest of the codebase, thus the idea to bring back things where they
>>>> belong.
>>>
>>> Most devices are both (a) architecture specific and (b) a particular
>>> kind of device (UART, ethernet controller, interrupt controller, etc).
>>> The nature of a filesystem hierarchy is that we can't file them
>>> in both ways at once. We picked "sort them by kind", which is why
>>> all the interrupt controllers live in hw/intc, all the UARTS in
>>> hw/char, ethernet controllers in hw/net, and so on. In this
>>> breakdown of the world, hw/$ARCH is supposed to be for board models
>>> and SoC models only.
>>>
>>> The GICv3 and the NVIC are odd, because they are very closely
>>> coupled to the CPU. (A few other interrupt controllers are also
>>> like this, but many are not: for instance the GICv2 is a distinct
>>> bit of hardware that communicates with the CPU over the IRQ and
>>> FIQ lines only.)
>>>
>>> One of my post-implementation regrets about GICv3 is that we
>>> didn't really get the split between the GICv3 proper and its
>>> CPU interface right. In hardware the GICv3 is an external device
>>> and the CPU interface is part of the CPU, with a defined
>>> protocol for talking between them. In QEMU we put all the
>>> implementation of this in hw/intc/, and the code in arm_gicv3_cpuif.c
>>> does some ad-hoc installing of hooks into the CPU.
>>>
>>> For the GICv5 I'm trying to structure this in a cleaner way that
>>> is closer to the hardware structure, so the CPU interface
>>> will be code in target/arm/, with a clearly defined set of
>>> functions that it calls to talk to the rest of the GIC that
>>> lives in hw/intc/. (This would be too much upheaval to
>>> retrofit to GICv3 though, I think.)
>>>
>>> In a green-field design of M-profile we might have made
>>> the NVIC be code in target/arm, and instead of a separate
>>> device have the CPU object itself do this code. But at the
>>> time it was written we didn't have the same QOM device
>>> class setup we did at the time, and IIRC CPU objects
>>> weren't a subclass of device.
> 
> 
>> Coming back to our issue, I can see two ways to solve it in a short term:
>> - On build system: define target hw before generic ones, so we can reuse
>> all the source sets defined there. This has the advantage to be usable
>> by all others architectures.
> 
> That seems the cheaper / quicker way, isn't it?
>

Yes, and beyond cpu->* usage, there is a lot of cpregs involved too.
I'll try this option then (build system one).

>> - Move gic related fields to a substructure in arm cpu, and provide a
>> simple accessor to it, like "cpu_gicv3(cpu)", breaking the dependency to
>> cpu.h. Concerned fields would be: gic_num_lrs, gic_vpribits,
>> gic_vprebits, gic_pribits.
> 
> FYI a previous attempt to disentangle GIC vs CPU with QOM:
> https://lore.kernel.org/qemu-devel/20231212162935.42910-1-philmd@linaro.org/
> 



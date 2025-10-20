Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33AE2CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 15:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vArsI-0002T8-Rq; Mon, 20 Oct 2025 11:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vArsH-0002Sl-8h
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 11:32:41 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vArsC-0002uI-Kx
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 11:32:40 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-471b80b994bso25204765e9.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 08:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760974341; x=1761579141; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uelOh0xA8dHuH7WqUL25+FbMyaGY/y9suR6slIY0y3w=;
 b=KK62JKfVjDRfWaPWAOjFEyBipZoDr61KjjkFVfRY08TZ/0+r5KCdg/KNSTOV9ytizX
 QkyrnZtrLe4dIMEbfcHFBxTvZd3Ea+wtMgfvo10j5hHEmJ1LMum2dZ5Ygrw406LuMn6p
 ourMJegDsYdG93i3whsvGRbelqkEgQ1U3kwjFxGSNeBxMkXJKoxbzCTZeN8QvAtzAFvQ
 oq3QiIw1afkcYIQODVUYR75vwUWpdZFRaVuf1NeB/1ecs0D7xEwcorXIfAy9IG0NoYTf
 VdnPGyzwOILY/U7Put9WBEHgj1slQfSgjFCrPwSj6A50HFOkRcZFeUKiRoRXozCCTAOg
 ArWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760974341; x=1761579141;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uelOh0xA8dHuH7WqUL25+FbMyaGY/y9suR6slIY0y3w=;
 b=fltp/0+e8Fhs/A3CzLVVA+0DweuHEdyBlBIggm3AshwkQ8IZokHmT5ilNBt4ZJaBaS
 lYDrrrqq3II2GEoHucYHjDOfs9ADNrFC1naYTFRCdu1kT73ro6laGCWpx+YLurnX6wsp
 uUs/VLugjlcFfAKgup72Pg2RN4VDc0fGLIT/O0NAgqeyrVjpKixfxTFTQk8tugW5fKtf
 JqO6WHPZxTyfRVmIY/7Y/+0kRWWA5s1ZP6DgIdXD/gNICYJBkFwbH4zbTjE4Svoxq6gJ
 Ja+ixMDwuLFvKkis7qfQG8ubeYOfi3Xcd2Yalv10D45gjjSA6hxDmqUQe94yjxemWxNk
 u5UQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLe70alS7ySXDy8hxBmy1TKpQ+AXZQG+bHbtwjQdU2KzJ32ju3FU1YygYdnNyUH4kAev3vbF1NdAWR@nongnu.org
X-Gm-Message-State: AOJu0YzXMTzjrXYLpL/QHZYX+tfqbBp+urMsZZebzvsj5Q6J2nXXOrq8
 Vv5t5rdviNMbSbh19FU3Yzv4P2NJyWVInEamM4HLzP/+K/8lITIcVefUAaQ8026TwR0=
X-Gm-Gg: ASbGncuZTSGpRdvCBUZYABvfewUJmkP9yYV6GhgGHBlcncdMwvqW7UuJcwnJRG4IsiO
 BVxo1Ely3OT2AB3+pP3m4nME7Ph79prq0rAdffyuAdk7qth3e1Wp2H6ovS6bu7yoxsf0sXwk8wo
 W4mm1Gd29yzM8efcI6MPFdARU2nrhOY5u6NXIrFbLvS1lOutFxA/v5kAeJwx//uP35/2eU0MTYq
 bSF68nfXIlZAZ+dfPN35tVVqTlL33i0NKBoJmkexUbruCbyOaLBRJY1myzblNVj4nR2x16cvaHn
 5Flvr47GdpeDZXPkJT3nqscP+DSZD1KaZ8YvNQp6VOUu3I8/TXXUgXyVlZ91wG3By4+qNntubyG
 FdVfDqcqkqyndWLUc9A6fQpNkuft5QT/aa1rrqQt6wSUwSjSVOkD3cotaOSvlrFASJU5O0sTO0n
 uuFvOhJfEf/qtjKdDREmUm1zdSUZK7moDosFTkqSaM0LM=
X-Google-Smtp-Source: AGHT+IHGcu4iKu47B05h4HIW5I3I80eBt0LYfqyXdfy6e7OEnVKNZiU6qwL/9DCPe7eRR6KSEpsvPA==
X-Received: by 2002:a05:600d:6289:b0:471:14a7:981 with SMTP id
 5b1f17b1804b1-474920ab04cmr11341555e9.32.1760974340603; 
 Mon, 20 Oct 2025 08:32:20 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144b5c29sm237811285e9.12.2025.10.20.08.32.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 08:32:20 -0700 (PDT)
Message-ID: <72cef0eb-085f-4d91-a1ff-69a0fdd872c0@linaro.org>
Date: Mon, 20 Oct 2025 17:32:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/13] hw/boards: Extend DEFINE_MACHINE macro to cover
 more use cases
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster
 <armbru@redhat.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <cover.1760798392.git.balaton@eik.bme.hu>
 <d75c8bbed97650f1a4d2d675444582a240a335b4.1760798392.git.balaton@eik.bme.hu>
 <9a1fe708-66a1-489c-ad2f-23705497c470@linaro.org>
 <00108467-9f4f-4078-a430-0f18297da94c@linaro.org>
In-Reply-To: <00108467-9f4f-4078-a430-0f18297da94c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 20/10/25 17:11, Philippe Mathieu-Daudé wrote:
> +Pierrick
> 
> On 20/10/25 17:05, Philippe Mathieu-Daudé wrote:
>> On 18/10/25 17:11, BALATON Zoltan wrote:
>>> Add a more general DEFINE_MACHINE_EXTENDED macro and define simpler
>>> versions with less parameters based on that. This is inspired by how
>>> the OBJECT_DEFINE macros do this in a similar way to allow using the
>>> shortened definition in more complex cases too.
>>>
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>>   include/hw/boards.h | 16 ++++++++++++++--
>>>   1 file changed, 14 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/hw/boards.h b/include/hw/boards.h
>>> index 665b620121..fd3d549ff5 100644
>>> --- a/include/hw/boards.h
>>> +++ b/include/hw/boards.h
>>> @@ -762,7 +762,8 @@ struct MachineState {
>>>           } \
>>>       } while (0)
>>> -#define DEFINE_MACHINE(namestr, machine_initfn) \
>>> +#define DEFINE_MACHINE_EXTENDED(namestr, PARENT_NAME, InstanceName, \
>>> +                                machine_initfn, ABSTRACT, ...) \
>>>       static void machine_initfn##_class_init(ObjectClass *oc, const 
>>> void *data) \
>>>       { \
>>>           MachineClass *mc = MACHINE_CLASS(oc); \
>>> @@ -770,8 +771,11 @@ struct MachineState {
>>>       } \
>>>       static const TypeInfo machine_initfn##_typeinfo = { \
>>>           .name       = MACHINE_TYPE_NAME(namestr), \
>>> -        .parent     = TYPE_MACHINE, \
>>> +        .parent     = TYPE_##PARENT_NAME, \
>>>           .class_init = machine_initfn##_class_init, \
>>> +        .instance_size = sizeof(InstanceName), \
>>> +        .abstract = ABSTRACT, \
> 
> IIUC we don't want to have abstract type with interfaces, but
> only QOM leaves. So maybe better always use .abstract = false in
> DEFINE_MACHINE_EXTENDED()?
> 
>>> +        .interfaces = (const InterfaceInfo[]) { __VA_ARGS__ } , \
>>
>> IIUC Richard asked for array argument in order to save .rodata?
>>
>>>       }; \
>>>       static void machine_initfn##_register_types(void) \
>>>       { \
>>> @@ -779,6 +783,14 @@ struct MachineState {
>>>       } \
>>>       type_init(machine_initfn##_register_types)
>>> +#define DEFINE_MACHINE(namestr, machine_initfn) \
>>> +    DEFINE_MACHINE_EXTENDED(namestr, MACHINE, MachineState, 
>>> machine_initfn, \
>>> +                            false, { })
>>> +
>>> +#define DEFINE_MACHINE_WITH_INTERFACES(namestr, machine_initfn, ...) \
>>> +    DEFINE_MACHINE_EXTENDED(namestr, MACHINE, MachineState, 
>>> machine_initfn, \
>>> +                            false, __VA_ARGS__)

Hmm how can be sure the __VA_ARGS__ argument is { NULL } terminated?

>>> +
>>>   extern GlobalProperty hw_compat_10_1[];
>>>   extern const size_t hw_compat_10_1_len;
> 



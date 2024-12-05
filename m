Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A79FE77179
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 17:57:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJG65-0005iB-LE; Thu, 05 Dec 2024 12:57:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJG63-0005hi-9Y
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 12:57:03 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJG5w-0004jP-Fb
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 12:57:01 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7e9e38dd5f1so968233a12.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 09:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733421415; x=1734026215; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jphDf0g3chUYOfjqFiuXsfoLINV6Dp4Yrzsia3tvOPk=;
 b=QcQ9SHgCiSb+A7Dqf5MyMQtutfgRigTvCr1K8ZIRCRTzsrzm7GWEu3VNHLGivnStru
 6p4Wd4ZOVT4A9PzDhZYYJ/j9jXGA5iKIJAgttye0lIBWBxVwajx7hkVY385X7+2n3zeK
 SnybTrRAYLWb3lXHhTmb+86XIU2aiOvl9yw2XVhj03cOPHdmVFOHGkJWqEVI8/Ej7s0Q
 /XVMxzpPX4EGIdYI8Fg7mv72AoTxAzDeSFUGRi0hbjW3MMjOcH3o37GAL/vYD2G3uuHD
 SQD/eXJtlCJL1MhzXxHSZpLkuCbL0Tg5hREMDiSC7qumFppVyjoQzoEMT8d7bobwF3KS
 Txyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733421415; x=1734026215;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jphDf0g3chUYOfjqFiuXsfoLINV6Dp4Yrzsia3tvOPk=;
 b=pwl2H4BLx1yQEWinnMkTTqaXcp2jCMla8/O/VJtNLDwjHn1bRr647lq8D5BEydsdf8
 4Wkyw8n9KkpyFhM2qs0UlxbMKQVkE8LGBRT4PqQ5oi/XDuGf2/8gcrTgGMO75iSNnWRA
 +lWF6cWT7Hs4JE1aljXtS7m6N18GIoFo0egnh3iR+r44anT3Rh/dALeEC+G5gx82WpjB
 qXBjbxtWId7idbU8v5OyJpUbvqLj2jLZZUKi8A3L4h2bwD0gV1utNdj7pa9sPoEoIN2z
 DOLMsZbXfeJJhisxLDazce/Ui3A9SD4H2dgw9Goc/HANf9NbPzkiIgHFxRDFja13wuGt
 S1NA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZmjmoxdab6sTMf0LqwYO2zpy93V1k53v3HkH3TS60V3n9/L76ryaWKHW325Tnn3a/0CghLDe/iTRL@nongnu.org
X-Gm-Message-State: AOJu0Yw3so/ow0pd1JAsBYIMmXNjMUX47Kobv261xh5Sb5BDT6+lOMDg
 9wD1bISIA87s5Wlsc+6Vr8O+643qkKfcxQJOeJouj2xqEOlh85F011ppGRUeI/k=
X-Gm-Gg: ASbGncsrlaRR03Rf2EVPuRD+T+1AotGh//DU0cYeQk8X/Q2WgPKZw8CGOj4NdUPzc6p
 gYxB3ubuaSBS7eFWXuOi4Pd8CqMPda8ZMlaFx7uqF0/bxkFVb6gGzOhCkwvcI4tUUMssOlIcD9x
 q/OiXv4ms2rWv772lc3ZEzDCIKkUT1zhgQzXeQzawvZF40w28GR0d5vSlzdhtK9zN67QO4jzGND
 9KlgaBsVsMv7E2M5RkAOzdMNfoGJOqK1i/v58rVGTwKWUF0/fzYqKgKR/I9mswVbJOCgwLGwOIQ
 rKx9MR95tpLVSfm4yelwtw==
X-Google-Smtp-Source: AGHT+IEXWHZWkb3TfPTtZmOBOlT13nXIJmVBt0KC8By1W8AMZ6zEe1mn0eM1JJR8se3BTGkWUEioIg==
X-Received: by 2002:a05:6a20:7491:b0:1e0:c50c:9842 with SMTP id
 adf61e73a8af0-1e1653f2a9dmr15498251637.31.1733421415080; 
 Thu, 05 Dec 2024 09:56:55 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fd1568f26asm1578400a12.9.2024.12.05.09.56.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 09:56:54 -0800 (PST)
Message-ID: <64e40e6f-bc90-4760-bb70-fb67d80ff4d7@linaro.org>
Date: Thu, 5 Dec 2024 09:56:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 01/11] plugins: add types for callbacks related to
 certain discontinuities
Content-Language: en-US
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
References: <cover.1733063076.git.neither@nut.email>
 <5e624b7244f1b0b294b28cd513aab04b6b294b1d.1733063076.git.neither@nut.email>
 <181b9b53a258257df1b24e7bfb8b0e6fc590c25f@nut.email>
 <35529516-cc96-41de-8e0d-a7807ccc09cb@linaro.org>
 <ca20c295f464ae7e3365e012ad9a550f70b34b51@nut.email>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <ca20c295f464ae7e3365e012ad9a550f70b34b51@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x530.google.com
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

On 12/5/24 04:40, Julian Ganz wrote:
> Hi Pierrick,
> 
> December 4, 2024 at 11:41 PM, "Pierrick Bouvier" wrote:
>> On 12/3/24 00:45, Julian Ganz wrote:
>>
>>>
>>> Hi,
>>>   December 2, 2024 at 8:26 PM, "Julian Ganz" wrote:
>>>
>>>>
>>>> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
>>>>   index 0fba36ae02..9c67374b7e 100644
>>>>   --- a/include/qemu/qemu-plugin.h
>>>>   +++ b/include/qemu/qemu-plugin.h
>>>>   @@ -154,6 +154,49 @@ typedef void (*qemu_plugin_vcpu_simple_cb_t)(qemu_plugin_id_t id,
>>>>
>>>   <snip>
>>>
>>>>
>>>> +/**
>>>>   + * typedef qemu_plugin_vcpu_discon_cb_t - vcpu discontinuity callback
>>>>   + * @vcpu_index: the current vcpu context
>>>>   + * @type: the type of discontinuity
>>>>   + * @from_pc: the source of the discontinuity, e.g. the PC before the
>>>>   + * transition
>>>>   + * @to_pc: the PC pointing to the next instruction to be executed
>>>>   + *
>>>>   + * The excact semantics of @from_pc depends on @the type of discontinuity. For
>>>>   + * interrupts, @from_pc will point to the next instruction which would have
>>>>   + * been executed. For exceptions and host calls, @from_pc will point to the
>>>>   + * instruction that caused the exception or issued the host call. Note that
>>>>   + * in the case of exceptions, the instruction is not retired and thus not
>>>>   + * observable via general instruction exec callbacks. The same may be the case
>>>>   + * for some host calls such as hypervisor call "exceptions".
>>>>
>>>   Some more notes about this bit: I originally tried to make the from_pc
>>>   semantics independent from the type of event, i.e. either of the two
>>>   cases. I obviously did not succeed in doing so. As, in most cases, the
>>>   instruction pointed to by from_pc is not observable via exec callbacks
>>>   I could also not test this behaviour in the testing plugin (see patch
>>>   11). I am therefore in favor for dropping the from_pc for the next
>>>   iteration of this patch series.
>>>
>> Does it mean that information returned should be dependent of type of event, as we previously discussed on v1?
> 
> Yes, and I don't like it.
> 

I respect your personal preference, but our conversation should be based 
on arguments, and not only tastes.

The important thing, from my point of view, is that the API stays easy 
to use and clear for the user. Having multiple callbacks is a headache, 
because you can't clearly group them somewhere, and force the user to 
implement all of them at once.

By having a single callback, we can force the user to handle all cases, 
thanks to the type system. The user may decide to use "default: break;" 
and that's ok, because they chose it deliberately.

I was, and I am still ok with the current approach, of having from/to 
parameters and a "simple" callback type. But remove "from" because we 
can't get it right in some cases does not seem the best decision.

Let's try to move forward, and solve the problems we have with from_pc. 
The testing part can be solved already (as explained in a previous 
message). In which cases can't you identify from_pc?

> Regards,
> Julian Ganz

By the way, and if you are open to talk about naming.

I understand why you picked up discontinuity, which is coming from a 
mathematical background. However, I rarely see this term used in the 
literature for computer science, and people use "exceptional control 
flow" to qualify interrupts and traps. In more, when we'll integrate 
classic control flow (including fallback between tb), the term 
discontinuity will lose its meaning. For this reason, I think that 
{cflow,CFLOW} makes more sense.

But, as there is some personal preference into this, I will leave the 
choice up to you.

Thanks,
Pierrick


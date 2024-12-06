Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2EADE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 19:00:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJdXv-0003Nk-7n; Fri, 06 Dec 2024 13:59:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJdXr-0003NU-RY
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 13:59:20 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJdXq-0007HI-4K
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 13:59:19 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-724d57a9f7cso2245992b3a.3
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 10:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733511553; x=1734116353; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r61igy6zEP7v6Ea0LV0w9+LlMUtORk9GdlN8rAbyfH4=;
 b=XDthR7GBYUKE+ju2hM5tKrTc17O/l6CAlhvNnp5MVyD7qUIecQAQNuwkYoLJ10kDGK
 Jl98OYiHqvOsnUmL7/H+miR0+hUFUCSgpI6dXSLWljzOMgysCfZFpI2NP1gIW8pADS/M
 r9p6KT7JnSnALV48V/vx3vIrNwnv44nXWCXklEnzEHkWRh3GeECmvSHU1L1MezHegcVX
 KgCCnWpBDWxWp7LMChFML5zM3n7wLJit3CcnCiULahtv+Nqz15nH7aTCPpZObnTOrB0d
 n8xN4gtqBgcakg2YyZSyJE8gRNqAWmbVxfaEouvQK9dAw3DayWKLr8FynavDYlG9XgoX
 yTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733511553; x=1734116353;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r61igy6zEP7v6Ea0LV0w9+LlMUtORk9GdlN8rAbyfH4=;
 b=mbd4CDOV5ptsyUj1RRQW32UCjqK/Cmj/97Y5NVmeyUr+YD2+o0UuXzJImJbXyVhBtj
 ZvPUrvxNLNK47ECHRc4Dhz/OsIFhUedmdG/fITtzYLQUuMWgulvdl8d8BvvCy8vYizwX
 6Vsy7AZR7EhmQ+aXjmEcJhT4I1pCUH56TshSaMebx0AOQGyfBBTYm4DdVz3XG7XCwXGs
 IlolkiIMKrhGK2hrNNMvYSlYfKhxacjaAyi9vZ+juMeUTP6sqxN7l0shSgjI0OTSd2bB
 QjPPxEvg3JtufmJG7jFV7FzWbN+hUFENmZiZ6KClyfGaWvJtlbumQWdjTLc7VOO1gaWb
 5KKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/MMN4TdCRaCJuc+m/MoMAxHGDWlwvoI7IRkWewcpug9SDa5YnozmrGK/+nN8GLgnRCVL4w1AO53uV@nongnu.org
X-Gm-Message-State: AOJu0YxTmlahr0shUzmOd7HyqElw4ufU7peM72eaaz4hoLcifznJJoZ3
 TbVfdq7oCpbfxlaTc7vrZ2L9TbOupIXIEW/pLu9Xb5t3rAUaG5kOwikIyxObu+k=
X-Gm-Gg: ASbGncuB6G0ijbbcesHJgO/Ne+vdg8WO8UXY3FNWNADeT4Imt1oE2MGmElUbSLxZitD
 hNnAJyvZ2Oa5AoHDbPv+eGV3N6r3SM34Gfqvj7e4aUxTKInqxdJbegwIsfwgxh0bk1QTQajTMsa
 cXuVRI+0zQuqWlGMmRL67K848AKmVDfrMn+yqYtJIbcslyYOaQ6qKnleZvZYpCyGl/A++nbRhEF
 VHolU7RjdLPoKiSI9x/MPQh72V1hyD11XGHfmhfaR+dQABSSHp3GIR5nTyrpqHYRiT6rPeryVAs
 KTlHbjy0kDSnIkSPU/rzeg==
X-Google-Smtp-Source: AGHT+IESiB8AXxwLZAsIhJ7YBWy0cMLV6nwpQKnyqPtkj2hctir3pg6HnSqc+gWI2dKl5Foefwtkng==
X-Received: by 2002:a05:6a00:2e09:b0:71e:4786:98ee with SMTP id
 d2e1a72fcca58-725b81f81b9mr6796240b3a.21.1733511552806; 
 Fri, 06 Dec 2024 10:59:12 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725a2ca64b1sm3278559b3a.156.2024.12.06.10.59.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2024 10:59:12 -0800 (PST)
Message-ID: <85423c12-3d2f-4d17-a7fa-ba3de32e7d44@linaro.org>
Date: Fri, 6 Dec 2024 10:59:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 01/11] plugins: add types for callbacks related to
 certain discontinuities
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
References: <cover.1733063076.git.neither@nut.email>
 <5e624b7244f1b0b294b28cd513aab04b6b294b1d.1733063076.git.neither@nut.email>
 <181b9b53a258257df1b24e7bfb8b0e6fc590c25f@nut.email>
 <35529516-cc96-41de-8e0d-a7807ccc09cb@linaro.org>
 <ca20c295f464ae7e3365e012ad9a550f70b34b51@nut.email>
 <64e40e6f-bc90-4760-bb70-fb67d80ff4d7@linaro.org>
 <51ac04eea17a6c5b59a240d3c57ce54a851e4989@nut.email>
 <e45c0eed-fb2d-465d-b21e-ab3d395bcf71@linaro.org>
 <0b8c1c08b7780b62dd2af81e437f2e690a07d70a@nut.email>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <0b8c1c08b7780b62dd2af81e437f2e690a07d70a@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 12/6/24 00:58, Julian Ganz wrote:
> Hi Pierrick,
> 
> December 6, 2024 at 12:03 AM, "Pierrick Bouvier" wrote:
>> On 12/5/24 13:50, Julian Ganz wrote:
>>>   If you cannot rely on an input being a sensible value, doesn't that
>>>   render the input useless?
>>>
>> I agree. If for a specific event it's impossible to provide a value (i.e. the value has no meaning for a real cpu), it will just point that we need several types of data per event, and the compromise of having a single callback won't be possible.
>>
>> We should differentiate "it's hard to find this value in QEMU" vs "this value does not exist in real life". The first can be solved if we put effort into it. And every time a cpu changes it's flow of execution, it makes sense to find where it was just before.
>>
>> One of the end goals is to be able to build a full control flow graph, with edges labeled on transition type (exceptions, traps, interrupts, jump, fallback), which we can do with the triple {event,from,to}.
> 
> I agree that that triple is sensible for any event type and likely
> useful to plugin authors. At least if the semantics are sufficiently
> uniform among event types. However, I also feel that given the actual
> implementation (hooks sprinkled over target specific code) this is not
> easily achievable reliably. At least testability should be a hard
> requirement. Otherwise the API's reliability will inevitably deteriorate
> over time without any way to tell how bad the situation got.
> 
>>>> Let's try to move forward, and solve the problems we have with from_pc. The testing part can be solved already (as explained in a previous message). In which cases can't you identify from_pc?
>>>>
>>>   I'll have to check, but problems that I discussed with a colleague
>>>   included jumps to an unmapped page resulting in the appropriate
>>>   exception. We ultimately agreed that in such a situation from_pc should
>>>   point to the jump target inside the unmapped page, instead of, say, the
>>>   jump. We assume that most targets should already behave this way without
>>>   further changes. However, in order to compute the correct from_pc, we
>>>   need to know the jump target before the exception is raised (i.e. right
>>>   after the jump instruction is executed), and that's not necessarily
>>>   straight-forward to do in a plugin.
>>>
>> It's an interesting conversation. For the scope of this series, I agree you should use the jump target, which triggered the trap.
>>
>> In fine, transitions should simply follow what the cpu does.
>>
>> - orig_insn: jump to A
>> - jump_target: execute A traps
>> - page_fault: load page
>> - jump_target: come back to A
>>
>> event(JUMP, orig_insn, jump_target) // not covered by this series
>> event(EXCEPTION, jump_target, page_fault)
>> ... execute page_fault (with potential other transitions)
>> event(JUMP, end_page_fault, jump_target)
>>
>> In the case of a double trap, we could follow the same logic, and represent the original transition that lead to the trap, and the two consecutive traps.
>>
>> Does it make sense?
> 
> Yes, those transitions are correct imo. And if a jump event should be
> introduced at some point, the call sequence would look like that. My
> issue is that testing this (in a plugin) will not be straight forward
> or even impossible. And overly complex tests don't exactly provoke
> confidence.
> 

Instruction instrumentation is done before executing the instruction 
itself, as you can see by running:
./build/qemu-x86_64 -plugin build/tests/tcg/plugins/libinsn.so -d 
in_asm,op /usr/bin/true

I'm not entirely sure about the sequence when there is an exception 
while fetching the instruction though. You can give it a try, track the 
PC using insn instrumentation, and we can identify which cases are not 
working.

The test plugin itself is not complicated.
You'll need:
- one callback per instruction to set the expected pc (possibly 
optimized with inline operation), used to compare to from_pc, and we 
check if (optional) to_pc matches the current instruction.
- when the callback for discontinuity is called, we check if from_pc is 
matching, and register the next expected with to_pc.

We can then add tests targeting supported architectures using the 
plugin, and ensuring it never fails.
It's hard to know we don't miss events though. Except if we write manual 
assembly system mode tests, that trigger the expected behaviour. But it 
would be tedious, and I'm really not sure there is a real value with 
reduced examples like this.

> Regards,
> Julian Ganz



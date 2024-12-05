Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95375E77171
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 23:03:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJKsZ-0002Io-Gw; Thu, 05 Dec 2024 18:03:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJKsX-0002IY-9G
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 18:03:25 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJKsU-0004SW-VC
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 18:03:24 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2153e642114so14542265ad.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 15:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733439801; x=1734044601; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AkOXTxZfjvtBFz6LTaiCk2YtRC+nvaGBg0C2mHib3QU=;
 b=rupHj1eN7KPzASnETp6VS9pJkgQbtu4WTjJ+3rBQwPRLyEPIgALL9WWJyWiGBXgBna
 XneZTDhhNDhfF+eIV7yGI7wzhYMWc0Khq4YEq5wsTbkiJQYKxX6kmAhjbpQoCDJ2RkaE
 GS45Kz81jo2rxXrULWciT5NU8ld87uNQ713nHeQCBSSIqVHT2N4LU6QWKB0c0MHJBnee
 1iiminpXaAWkfvfzWfot8GGegVj2EuJ497p2HZKOrw+vWAZ1jV9Eqq/npelSfADZhqeE
 2b6gxT4VGtJi8loI7skr6qgtALPZ0GZnriOdF9jsY1kB4LiN6mXRWEHkDFmAstxwEHYH
 du/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733439801; x=1734044601;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AkOXTxZfjvtBFz6LTaiCk2YtRC+nvaGBg0C2mHib3QU=;
 b=RNaUtdnJf9e220mO3hgY9x11X0CL/t0WZqqQ13WKSeTuUDPXJO8ZGhpyZ6wOjx5wm4
 2d7YfPslJ3ATYW/oLQAXSHDBz0x9cynEoYM2VzCVMxSTgjpzVHhx82/KeLowCFlHj62V
 fuek0AWY0XFcuC+MPkANpoLztVkhQANRSxd1IN+ybEmYFNKod+w78wOOACTMq4/yr6nQ
 OrIKrYvI5jXUHoBWc4fsxsbKejJKekCjgPR9fgroyw++nO74HCiRnBWGt0ni0WWzSttI
 XsnOkXUbkJIJm4PzJASMu1N1QkQrXCnHY043fTK9JWcP4Mpzg5h288aK0gbACavOGrK/
 wu9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7/IQwvtCQtZoon0XbMxXoUe4Jl5OOI8DSc2AUN3WTPwJ3m3u5fw5zYB+71ypkK6Cy7lQQVerCVcl2@nongnu.org
X-Gm-Message-State: AOJu0Yw2bRmBlmxWb2+gXJ1hfU7r7Y6lKg/y58qwGuwM6TIdDjRJNlQh
 6Le4+kScPNAdJ2WyG1vrXdBJJ0MII7KjDevt/O6o29DRMmHxeqK10/LQtAF45Uo=
X-Gm-Gg: ASbGncsdEPOfFZHIJs9n0Vq1i8H5Tja2RMYoqd0RSlBLzOdKsyxrHPyQRzBQYzzv793
 Tf96xkHZk57QMdurvKZQ3o1LbGpDkpTFAZgo7KicRqjxymkLmBX2cq3dBDA1mtFgaqHgwR996tF
 kZW+dgWfbtEQoFt3OEyUB8NMXdAEtCuV5R3+9cFQDY+RGprF/Mt845+SutR9qODtv7iUAGn5167
 Ca5KP3ys57qam/lumri1p/1TWvrqX15Gjj570WZQ11OEXCA9f0Pclx35n7E6ik9BMrNMbS/oJvn
 HQPt4NotCMDlxOZ2bHC8Lw==
X-Google-Smtp-Source: AGHT+IHj4czUScx3VdPU/0RuoxECPkQsvnmNFL7kZsHTPwFBkVNGFbJQS6mGD1oA3B+7H+eogek6rw==
X-Received: by 2002:a17:902:e5cd:b0:215:9a73:6c45 with SMTP id
 d9443c01a7336-21614d45334mr10536915ad.22.1733439801001; 
 Thu, 05 Dec 2024 15:03:21 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215f8f0a886sm17115095ad.208.2024.12.05.15.03.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 15:03:20 -0800 (PST)
Message-ID: <e45c0eed-fb2d-465d-b21e-ab3d395bcf71@linaro.org>
Date: Thu, 5 Dec 2024 15:03:19 -0800
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
 <64e40e6f-bc90-4760-bb70-fb67d80ff4d7@linaro.org>
 <51ac04eea17a6c5b59a240d3c57ce54a851e4989@nut.email>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <51ac04eea17a6c5b59a240d3c57ce54a851e4989@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

On 12/5/24 13:50, Julian Ganz wrote:
> Hi Pierrick,
> 
> December 5, 2024 at 6:56 PM, "Pierrick Bouvier" wrote:
>> On 12/5/24 04:40, Julian Ganz wrote:
>>
>>>
>>> Hi Pierrick,
>>>   December 4, 2024 at 11:41 PM, "Pierrick Bouvier" wrote:
>>>> Does it mean that information returned should be dependent of type of event, as we previously discussed on v1?
>>>>
>>>   Yes, and I don't like it.
>>>
>> I respect your personal preference, but our conversation should be based on arguments, and not only tastes.
>>
>> The important thing, from my point of view, is that the API stays easy to use and clear for the user. Having multiple callbacks is a headache, because you can't clearly group them somewhere, and force the user to implement all of them at once.
> 
> Having only one callback is not something I'm against.
> 
>> I was, and I am still ok with the current approach, of having from/to parameters and a "simple" callback type. But remove "from" because we can't get it right in some cases does not seem the best decision.
> 
> If you cannot rely on an input being a sensible value, doesn't that
> render the input useless?
> 

I agree. If for a specific event it's impossible to provide a value 
(i.e. the value has no meaning for a real cpu), it will just point that 
we need several types of data per event, and the compromise of having a 
single callback won't be possible.

We should differentiate "it's hard to find this value in QEMU" vs "this 
value does not exist in real life". The first can be solved if we put 
effort into it. And every time a cpu changes it's flow of execution, it 
makes sense to find where it was just before.

One of the end goals is to be able to build a full control flow graph, 
with edges labeled on transition type (exceptions, traps, interrupts, 
jump, fallback), which we can do with the triple {event,from,to}.

>> Let's try to move forward, and solve the problems we have with from_pc. The testing part can be solved already (as explained in a previous message). In which cases can't you identify from_pc?
> 
> I'll have to check, but problems that I discussed with a colleague
> included jumps to an unmapped page resulting in the appropriate
> exception. We ultimately agreed that in such a situation from_pc should
> point to the jump target inside the unmapped page, instead of, say, the
> jump. We assume that most targets should already behave this way without
> further changes. However, in order to compute the correct from_pc, we
> need to know the jump target before the exception is raised (i.e. right
> after the jump instruction is executed), and that's not necessarily
> straight-forward to do in a plugin.

It's an interesting conversation. For the scope of this series, I agree 
you should use the jump target, which triggered the trap.

In fine, transitions should simply follow what the cpu does.

- orig_insn: jump to A
- jump_target: execute A traps
- page_fault: load page
- jump_target: come back to A

event(JUMP, orig_insn, jump_target) // not covered by this series
event(EXCEPTION, jump_target, page_fault)
... execute page_fault (with potential other transitions)
event(JUMP, end_page_fault, jump_target)

In the case of a double trap, we could follow the same logic, and 
represent the original transition that lead to the trap, and the two 
consecutive traps.

Does it make sense?

> 
> But as I wrote before in another message, I need to take another look at
> the cflow plugin.
> 
>> By the way, and if you are open to talk about naming.
> 
> I'm open to suggestions.
> 
>> I understand why you picked up discontinuity, which is coming from a mathematical background. However, I rarely see this term used in the literature for computer science, and people use "exceptional control flow" to qualify interrupts and traps. In more, when we'll integrate classic control flow (including fallback between tb), the term discontinuity will lose its meaning. For this reason, I think that {cflow,CFLOW} makes more sense.
> 
> Using the term "discontinuity" was, in fact, inspired by "uninferable PC
> discontinuities" defined in the RISC-V ETrace spec [1], arguably a
> technical document. We chose discontinuity over the notion of control
> flow because the PC is not the (only) thing affected by the event. In
> the case of host calls, we ideally don't even observe an effect on the
> PC. Thus control flow doesn't really fit the bill for those.
> 

I'm happy to read this spec reinvents a term clearly defined elsewhere 
(sigh...). Beyond the intellectual vocabulary creation pleasure, it's 
good to use term people can find on Google.

We can use this term though, PC discontinuity makes sense, and a 
fallback is a special case of discontinuity if we adopt this 
perspective. Thanks for explaining!

> Regards,
> Julian Ganz
> 
> [1] https://github.com/riscv-non-isa/riscv-trace-spec



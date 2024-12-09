Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C7DE7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 18:53:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKirv-0004Kv-L5; Mon, 09 Dec 2024 13:52:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tKirt-0004KT-5p
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 13:52:29 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tKirr-0000Py-CQ
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 13:52:28 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-215ac560292so46951885ad.2
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 10:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733770345; x=1734375145; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9XO5VDOMSOplC2h45Pu78Zxy8H6Ep5ZjzoXkVLstBXk=;
 b=iBwXo78o60qGY5EDi/Oyzq3J8GQF5e7wNI4TKojpOGNVtw1bLjCDahDzTHgFALkwnf
 P4/BBxsEr3IlBZPLHZpMQyVDMlV5vI9XvYn/j1wURNp/DLmfZvt/CDNoZTYPUcSCuFZr
 9vSK5hOs2wA5RMUe1MFliZ1g2VnVd0++mL+s0hcJ+HI/EfDWr1mihbjikVFfGFKhDQMM
 2kQSj4WeeRPkpncqkgoIxGvcAYDkCPT8alvfqmxnc1dOkTYcJZw1s+ELWb7WVSgoEPn3
 ZgUhJj6/Yadeq19e4sv+st+U0B8qN4oEhI4/FkZxaX5Z7RPgxb458YaNvS3af8sa//zw
 lQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733770345; x=1734375145;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9XO5VDOMSOplC2h45Pu78Zxy8H6Ep5ZjzoXkVLstBXk=;
 b=nJ043zFwfKMmf6DlJugczLA7YPisP2QK41I3mUJeF0qKgyHV2SZdny/6Ag2c27E9UP
 DPFR9404H/KjeiXYwoEN+KY3thslGXoOWEayGCCxTeDl9sEVEm4Cf0PLTXEtYYtGPID+
 KKL1m59Wcl7Z42w7ex5AJ+jBqro7Sa02042RLxH9r8ViMiR+XYMcNXftH80RA1jOBWTY
 PCv40//c5ptDaQo5dYf51rtTlBtJ4nGKL3H/SoWeBZqILkdBYs/AGlpUopL/YvPO5jLO
 LFUfCP4rmDDmxYp102ycbj+TdTiRs2Na1UulwJyz5DqIJRrs4eTiJhHsoHCzgdTbFjTM
 pSDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJt8up9bIUPIYCYD14BK2Iu71RjhbzIPSE6PM4VVSyzVVrFngEPs7DMPh4OON7X1Nef9j1Oe7+WRFN@nongnu.org
X-Gm-Message-State: AOJu0YwEvAmLyEcGi7c0YP/c7HivuifAx7Onju4kpWyPWDKAbDwvdmuZ
 hLCr+n75OwQ4pyMg1lr9iiORdvNYQXgivM8hNYrwwtQqaZlCI1prbm9j60uR/zs=
X-Gm-Gg: ASbGncvrZ1pc6IO/MAo4Txct5iZ05Ih+qsGXJQdY1IBTmR+ksfK9XFosKIGa0AP8BSL
 3h8gzrzXKgAkuU9gAZ9zDEo7CWBlUVuIaCE+OsWcNks4CG0dfeQ/beYJScl+aoEOXHrtFNwoc6p
 JAKqV3JRYmY+3NCg0Y1aOIaxQE5GdilhwSJaxmBbiEAlTwk2xlAAf6oYp3ibohz5nZcNtUCv554
 5dEyy6HL5rvDyiMSvmvp8oin1KDJn0jZUCVfAKNyG9hS0pHH1xWC1oCZ1NwZN7vUo7iSZANeNZL
 PCskLJVvIvHwynsh1OeAiA==
X-Google-Smtp-Source: AGHT+IG1wTA+0cEtmO36k380SdTcXIGF0lKorENm6B+Ec0kU1mJvY7cD1qoSoFxAerelscXT7SHWNw==
X-Received: by 2002:a17:902:d48b:b0:212:fa3:f627 with SMTP id
 d9443c01a7336-21669fb605emr26772235ad.16.1733770345623; 
 Mon, 09 Dec 2024 10:52:25 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fd4e9d822fsm2052076a12.14.2024.12.09.10.52.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2024 10:52:25 -0800 (PST)
Message-ID: <af010d29-f66b-45d3-97dc-613b5d241c09@linaro.org>
Date: Mon, 9 Dec 2024 10:52:24 -0800
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
 <e45c0eed-fb2d-465d-b21e-ab3d395bcf71@linaro.org>
 <0b8c1c08b7780b62dd2af81e437f2e690a07d70a@nut.email>
 <85423c12-3d2f-4d17-a7fa-ba3de32e7d44@linaro.org>
 <2f8052fd509a1e7eba334c1881a6b46030f3d4dd@nut.email>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <2f8052fd509a1e7eba334c1881a6b46030f3d4dd@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

On 12/7/24 05:38, Julian Ganz wrote:
> Hi Pierrick,
> 
> December 6, 2024 at 7:59 PM, "Pierrick Bouvier" wrote:
>> On 12/6/24 00:58, Julian Ganz wrote:
>>>   December 6, 2024 at 12:03 AM, "Pierrick Bouvier" wrote:
>>>> It's an interesting conversation. For the scope of this series, I agree you should use the jump target, which triggered the trap.
>>>>
>>>>   In fine, transitions should simply follow what the cpu does.
>>>>
>>>>   - orig_insn: jump to A
>>>>   - jump_target: execute A traps
>>>>   - page_fault: load page
>>>>   - jump_target: come back to A
>>>>
>>>>   event(JUMP, orig_insn, jump_target) // not covered by this series
>>>>   event(EXCEPTION, jump_target, page_fault)
>>>>   ... execute page_fault (with potential other transitions)
>>>>   event(JUMP, end_page_fault, jump_target)
>>>>
>>>>   In the case of a double trap, we could follow the same logic, and represent the original transition that lead to the trap, and the two consecutive traps.
>>>>
>>>>   Does it make sense?
>>>>
>>>   Yes, those transitions are correct imo. And if a jump event should be
>>>   introduced at some point, the call sequence would look like that. My
>>>   issue is that testing this (in a plugin) will not be straight forward
>>>   or even impossible. And overly complex tests don't exactly provoke
>>>   confidence.
>>>
>> Instruction instrumentation is done before executing the instruction itself, as you can see by running:
>> ./build/qemu-x86_64 -plugin build/tests/tcg/plugins/libinsn.so -d in_asm,op /usr/bin/true
>>
>> I'm not entirely sure about the sequence when there is an exception while fetching the instruction though. You can give it a try, track the PC using insn instrumentation, and we can identify which cases are not working.
>>
>> The test plugin itself is not complicated.
>> You'll need:
>> - one callback per instruction to set the expected pc (possibly optimized with inline operation), used to compare to from_pc, and we check if (optional) to_pc matches the current instruction.
> 
> What I'm saying ist that this exactly is not feasible for quite a few
> relevant instructions. As someone who isn't all too intimate with TCG
> itself, it's not even clear if we can rely on jump and branch
> instructions only occuring at the end of a tb. At least a superficial
> glance at the documentation tells me we can, but if this should in fact
> not be the case, or if someone introduces something like zero overhead
> loops inside a tb, all bets are off.
> 

TCG already has the possibility to generate jumps inside a TB 
(conditional branches - brcond, is an example).

However, for the scope of this series, it does not matter.
We only have to check the from_pc when a discontinuity is detected (and 
not all the time), so there is no need to anticipate the "next" instruction.

>> - when the callback for discontinuity is called, we check if from_pc is matching, and register the next expected with to_pc.
>>
>> We can then add tests targeting supported architectures using the plugin, and ensuring it never fails.
>> It's hard to know we don't miss events though. Except if we write manual assembly system mode tests, that trigger the expected behaviour. But it would be tedious, and I'm really not sure there is a real value with reduced examples like this.
> 
> So currently my thinking goes in the direction of having the plugin
> print a warning every time we don't have an expected from_pc to check
> against. Probably also have this be a feature you can deactivate.
> 

As it's a test plugin, I think it would be a better default to abort on 
error, and not be able to deactivate it. Any difference we find would be 
a bug anyway, so require fixing.

> Regards,
> Julian Ganz



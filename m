Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A8EF513E9
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 01:56:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyKPv-00073h-Sg; Thu, 05 Mar 2026 20:55:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vyKPu-00073T-DE
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 20:55:50 -0500
Received: from v512.v5f06b487.use4.send.mailgun.net ([143.55.232.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vyKPq-0008A3-89
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 20:55:49 -0500
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 a6fe344c5d94d448cf523ff75100021ccf85ab1e3627f80753cd74fae668093e with SMTP id
 69aa341d1ff86a8a1879c5bd; Fri, 06 Mar 2026 01:55:41 GMT
X-Mailgun-Sending-Ip: 143.55.232.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1772762139;
 bh=LnC2fHLioAWeOaAUSQ6wRi/Lr8hBeEJbeQawGkfsPIA=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 X-Mailgun-Dkim:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:From:Reply-to:Subject:Date:Message-id:To:
 Cc:Mime-version:Content-type:Content-transfer-encoding:In-reply-to:
 References;
 b=OHAlZ9bCLi+f0POAooOYErsiXcrmGMXADOiG99bCeuDpQ5SxcHPh8a/L70Olee2Zh
 eCB4VH6xej9+zean9Xd+2H1jtoeTGaqvQawWFb8UOTgg3FQm4nJCMbm2Moksh28cuV
 aKn4hksXf3ihsAsWAVipoqqFbf813Jo8WPGuQfs5mz3kFs5cU41tR3Bc58WPovbKhy
 1/Lv+M/9G9XAqoxTBWZ9YPiGZ3npvjWyUyH1a9z/CO+51rscQ5tfB3GHoKZs3nq61N
 /rMn9OW60TiGsp6zptDvVJKOHs/T/ZrJetCP1m45h9+pVNKOYwju91Bd7DVzJPCfep
 UXTuK8vLx8PIw==
Message-ID: <86f1149d-cd44-4169-aa9c-c57e1b2d0cc6@yodel.dev>
Date: Thu, 5 Mar 2026 19:55:38 -0600
MIME-Version: 1.0
Subject: Re: duplicating CPUs with memcpy() in cpu_copy() vs memory-allocated
 things in CPUArchState structs
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: Laurent Vivier <Laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
References: <CAFEAcA9QAyZjjj4kXeC+wM4gg_C+U6Z7McYGrB9u=C1PbiaWZw@mail.gmail.com>
 <ee0b3240-4939-4a6f-a6e7-5f2032bfc2ec@linaro.org>
Content-Language: en-US
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
Autocrypt: addr=yodel.eldar@yodel.dev; keydata=
 xjMEZxqXdhYJKwYBBAHaRw8BAQdAkletQdG3CLyANZyuf2t7Z9PK4b6HiT+DdSPUB2mHzmPN
 I1lvZGVsIEVsZGFyIDx5b2RlbC5lbGRhckB5b2RlbC5kZXY+wpkEExYKAEECGwMFCQOcG00F
 CwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQTTzRjNQG27imap+N+V7k+3NmVNrAUCaNWASwIZ
 AQAKCRCV7k+3NmVNrNnSAPoDjQXa6v7ZzdQSaLdRfAQy/5SsUucv+zp3WAP4pXdgJQEAzMMC
 Ctx4l6b13Fs2hZdRXEnF/4BZ9t1K68nwzZOV3QnOOARnGpd2EgorBgEEAZdVAQUBAQdAKPIy
 3W/DKFsm1e+31zoqmOY0pqz8vjIM846wM6lEY2QDAQgHwn4EGBYIACYCGwwWIQTTzRjNQG27
 imap+N+V7k+3NmVNrAUCaNWG7QUJA5wi9wAKCRCV7k+3NmVNrPusAQCQDQwETy7VT6UhHPho
 TkrQnsNqQfFU3tXqCTiViToktQD7B/U2/to97hQIJCWbK6yd3T+KPZJPMcHMg2XRyedUvgA=
In-Reply-To: <ee0b3240-4939-4a6f-a6e7-5f2032bfc2ec@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=143.55.232.12;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=v512.v5f06b487.use4.send.mailgun.net
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HELO_STATIC_HOST=-0.001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

On 05/03/2026 13:45, Pierrick Bouvier wrote:
> On 3/5/26 9:47 AM, Peter Maydell wrote:
>> In the user-only emulators we need to be able to create a new CPU
>> object for a newly created thread that has the same state as the
>> one in the parent thread. We currently do that in cpu_copy()
>> in linux-user/main.c, which does:
>>
>>      CPUState *cpu = env_cpu(env);
>>      CPUState *new_cpu = cpu_create(cpu_type);
>>      CPUArchState *new_env = cpu_env(new_cpu);
>>
>>      /* Reset non arch specific state */
>>      cpu_reset(new_cpu);
>>
>>      memcpy(new_env, env, sizeof(CPUArchState));
>>
>> plus some special casing for things in the CPUState (cflags,
>> and breakpoints), and an ifdef for x86.
>>
>> This makes several assumptions:
>>
>> (1) nothing in a target's CPU struct is runtime state that needs
>> to be copied across from the old thread's CPU
>> (2) everything in a target's CPU env struct can be handled by
>> a shallow memcpy() from the old to the new
>>
>> Unfortunately (2) isn't true. The example I ran into was
>> MIPS, which allocates a data structure pointed to by env->mvp.
>> Copying the pointer from the old CPU means we leak the structure
>> the new CPU allocated on creation. (We don't actually try to free
>> this at the moment, but if we did try to free it we'd do a double
>> free because both CPUs would be pointing to the same thing.)
>> It seems likely that there are others too.
>>
>> (1) seems on somewhat shaky ground too, especially as we don't
>> document it.
>>
>> There are a couple of ways I can see that we could try to fix this:
>>
>> (A) We could insist that every target's CPUFooState (env struct)
>> must be shallow-copiable, and anything that isn't (pointers, etc)
>> needs to be moved out to its FOOCPU (QOM CPU object struct).
>> Then we could let targets implement any per-target copying specifics
>> in some function in linux-user/$ARCH/ that we call from cpu_copy()
>> after doing the memcpy(). This would be painful if there are any
>> targets that have something non shallow-copiable that they want
>> access to directly from generated code, which has the env pointer
>> but not the CPU object struct.
>>

Did/does CPUArchState's design intend for it to be shallow-copiable,
but it was extended out of necessity/convenience? Relevant if so,
because that's often how bugs get introduced, so the value added from
discovering and resolving anything found as a result of the transition
could make it worth said pain, though I'd want to comprehensively
survey the lay of the land before forming an opinion on this one.

>> (B) We could standardize the "end_reset_fields" convention that
>> some targets have in their env struct, where an empty struct
>> marks the end of the point in the struct where fields can be
>> reset by zeroing them. If they can be reset by zeroing they can
>> also be safely shallow copied with memcpy(). We could then let the
>> target handle anything else via some target hook as above.
>> This would require a lot of targets having this field marker added,
>> which could be a pain if they don't have their structs ordered in
>> a convenient way for this.
>>

I like this one, because it's buy one cpu_copy subroutine, get
a Resettable reset_* hook at a large discount.

>> (C) We could say that trying to write generic code that can
>> copy a target-specific structure is a fool's errand, and require
>> the targets to implement it entirely themselves (only copying the
>> stuff in the common CPU base class in common code). If a plain
>> memcpy() works for them then their implementation can be simple.
>>
> 
> This sounds good, as it's the only approach we can really enforce, by 
> adding a mandatory clone_cpu operation per target. This sounds better 
> than a "partial" clone operation mentioned above.
> 
> To ensure it keeps working, we could add a static_assert on cpu size 
> with a fixed constant directly in clone. This makes sure that when 
> people add fields they have to update this clone_cpu op accordingly 
> also, by changing the size and optionally deep copy the new field.
> 

I especially like the poka-yoke of this one, as in Pierrick's
suggestion of a static_assert constraint. Moreover, this one also
assists with the Resettable Interface transition (albeit not as
directly as (B)) since one can look to the copy code for pitfalls
when implementing reset.

>> Any preferences ?
>>

Too early for me to say, but I'm glad to be thinking about it now.

Thanks,
Yodel

>> thanks
>> -- PMM
> 
> 



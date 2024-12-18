Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E748E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 09:28:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNqLk-0001Xg-Nf; Wed, 18 Dec 2024 04:28:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNqLa-0001Wt-6N
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 04:28:05 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNqLR-0005Eb-Hh
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 04:28:00 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aa67ac42819so1003154666b.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 01:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734514070; x=1735118870; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n1emriCw3ZCUjJXNlY1RRgJtedii2CXWbLG2E++s8lk=;
 b=q8Tp2JgJ9lTxVKdVhRDxUG0PoyJgifUNmlDorMhzJmsXPzXhA72pfRWUyt9Bc2bnkf
 x1SV+t/R1xc/5pMewMnSvKqKDMfhPlvv5vhrNf8VqZo3mYWZMEi3l045YnQZ1X3GBWAw
 92L1pvPouCFSqNt3aig0edpBbhxqVdWZ8+xZ4At2+kHMfdF6dNlhXznju6mBFj8NebZ0
 FlZsASriZu0FWNs1+tpHjFY4/dgbkFqpgXJAwX5No3eFQOHQ6WWHIRkjbEo5PTb44j+c
 GSb+GkDwZplbvoweRnwQmNC1WJxQxi2fSCUUmTh0WN9qoKEJQg9VvX91Gj4xl7dmfnfa
 CY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734514070; x=1735118870;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n1emriCw3ZCUjJXNlY1RRgJtedii2CXWbLG2E++s8lk=;
 b=YBPBOH8Rgu1vcuQ38c5ld9czqKs2yzH08x0xrBMOEgHdZhNj3JxJwtN+4M/832vXUr
 Lhf55HqwFAl5/vmfJzMoriSozXnXcQyDs+fcC1JJap4+QBIDgAHJ2Jev66bxFvYRedee
 oC6QKHZ9ED+W87SHfvB5CY46Bxj9IQ/ofr9sgZn5Cd+oAaxn2nzdhWfoiKOqPAb4fkgR
 lF90A2clcAYtOI4Aukz+ZfbtHc+5iBWmZrhOGbjGsYZXYxPg3DGnTuXQRwqt//Cq8WV8
 l3OkIot1MLVYtVBr2IkLiBvbMhQpdvVG/PKmPz8rEFrI3TGCOuZ5+Q5lKbKVU0K12TWP
 T1Dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUW2HJOHrdwRDvpvy4Qp7TedrrasaBervYqi7MiWK/kqucAxs+919ESg1tTEKwzfRmmkVlCi2dqBpr9@nongnu.org
X-Gm-Message-State: AOJu0YyVNyTrbCR+d/bYbMMjHkFIJBnSKr+7x0t2dH9/lripnGA52Foq
 4ZRYSqp+I9260xrNbBhPjoe6XlWPwIG+j9GRmbXC28wmuPmNYCZNc8askYv5Rto=
X-Gm-Gg: ASbGncuoAAfXBZ3+n+hTHKWgai1MhNxbQRQSKNs+GP1bhM7qMEDgLpwe5l6m3ofdsI7
 s9n4UG8DTldbPKR9Bcs8lEp0CEgNx9WXeMmo8J1tQO/Rw+eujACKit8fKk5dgCS6M8OGrvnYJSK
 1wMxslN2B/KP7m+5gPyiv60mgP+cLeJAQZk41AzY/lVwrln/ILXaE+e4oO8kuGgzXwbCn0DpUwT
 ddWYIzSc8pXyK01BTHXY5w0NgIP0Ol7HPXPschnOkRw9r3Z7ZaV/ik=
X-Google-Smtp-Source: AGHT+IHus8J7UJg+uqLC3iLTVLZoyBr11ft76Xhle1wJfSgRjBcAqtavr7/qE6fplOIt3Q2xD5LK/w==
X-Received: by 2002:a17:907:3f21:b0:aab:cce0:f883 with SMTP id
 a640c23a62f3a-aabf496e15fmr175861366b.51.1734514070506; 
 Wed, 18 Dec 2024 01:27:50 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aab960065d1sm532659066b.6.2024.12.18.01.27.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 01:27:49 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2206E5F846;
 Wed, 18 Dec 2024 09:27:49 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  qemu-devel@nongnu.org,  Laurent Vivier
 <lvivier@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  qemu-arm@nongnu.org
Subject: Re: [PATCH 0/2] Change default pointer authentication algorithm on
 aarch64 to impdef
In-Reply-To: <75ff92e0-7384-4af4-bc9f-64a6b0febc9f@linaro.org> (Pierrick
 Bouvier's message of "Tue, 17 Dec 2024 13:08:48 -0800")
References: <20241204211234.3077434-1-pierrick.bouvier@linaro.org>
 <7cd98960-0c0d-481f-96ea-08e0578d5cad@linaro.org>
 <b0962854-65c3-47d0-8f0a-072fdf51e7b6@linaro.org>
 <6e29d9cb-1c67-4fdc-97f1-32c90bed1048@linaro.org>
 <19df9957-6653-4086-aa1f-07263efcddde@linaro.org>
 <87pllq69l6.fsf@draig.linaro.org>
 <CAFEAcA_xe5QEPsrByM8ems_rxt-KsVRAgkKhGk24X-1J0vcCDA@mail.gmail.com>
 <75ff92e0-7384-4af4-bc9f-64a6b0febc9f@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 18 Dec 2024 09:27:49 +0000
Message-ID: <8734il5oiy.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 12/17/24 02:38, Peter Maydell wrote:
>> On Tue, 17 Dec 2024 at 07:40, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>>>
>>> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>>>
>>>> On 12/16/24 11:50, Richard Henderson wrote:
>>>>> On 12/16/24 13:26, Pierrick Bouvier wrote:
>>>>>> On 12/16/24 11:10, Richard Henderson wrote:
>>>>>>> On 12/4/24 15:12, Pierrick Bouvier wrote:
>>>>>>>> qemu-system-aarch64 default pointer authentication (QARMA5) is exp=
ensive, we
>>>>>>>> spent up to 50% of the emulation time running it (when using TCG).
>>>>>>>>
>>>>>>>> Switching to pauth-impdef=3Don is often given as a solution to spe=
ed up execution.
>>>>>>>> Thus we talked about making it the new default.
>>>>>>>>
>>>>>>>> The first patch introduce a new property (pauth-qarma5) to allow t=
o select
>>>>>>>> current default algorithm.
>>>>>>>> The second one change the default.
>>>>>>>>
>>>>>>>> Pierrick Bouvier (2):
>>>>>>>>       target/arm: add new property to select pauth-qarma5
>>>>>>>>       target/arm: change default pauth algorithm to impdef
>>>>>>>>
>>>>>>>>      docs/system/arm/cpu-features.rst |  7 +++++--
>>>>>>>>      docs/system/introduction.rst     |  2 +-
>>>>>>>>      target/arm/cpu.h                 |  1 +
>>>>>>>>      target/arm/arm-qmp-cmds.c        |  2 +-
>>>>>>>>      target/arm/cpu64.c               | 30 +++++++++++++++++++----=
-------
>>>>>>>>      tests/qtest/arm-cpu-features.c   | 15 +++++++++++----
>>>>>>>>      6 files changed, 38 insertions(+), 19 deletions(-)
>>>>>>>>
>>>>>>>
>>>>>>> I understand the motivation, but as-is this will break migration.
>>>>>>>
>>>>>>> I think this will need to be versioned somehow, but the only thing =
that really gets
>>>>>>> versioned are the boards, and I'm not sure how to link that to the =
instantiated cpu.
>>>>>>>
>>>>>>
>>>>>>    From what I understood, and I may be wrong, the use case to migra=
te (tcg) vm with cpu max
>>>>>> between QEMU versions is *not* supported, as we can't guarantee whic=
h features are present
>>>>>> or not.
>>>>> This doesn't affect only -cpu max, but anything using aarch64_add_pau=
th_properties():
>>>>> neoverse-n1, neoverse-n2, cortex-a710.
>>>>>
>>>>
>>>> I think this is still a change worth to do, because people can get a
>>>> 100% speedup with this simple change, and it's a better default than
>>>> the previous value.
>>>> In more, in case of this migration scenario, QEMU will immediately
>>>> abort upon accessing memory through a pointer.
>>>>
>>>> I'm not sure about what would be the best way to make this change as
>>>> smooth as possible for QEMU users.
>>>
>>> Surely we can only honour and apply the new default to -cpu max?
>>=20
>
> With all my respect, I think the current default is wrong, and it
> would be sad to keep it when people don't precise cpu max, or for
> other cpus enabling pointer authentication.

There is a difference between max and other CPUs. For max as has already
been stated migration is likely to break anyway between QEMU versions -
we should also make that clear in the docs. But for the other CPUs we
need to honour the existing defaults.

> In all our conversations, there seems to be a focus on choosing the
> "fastest" emulation solution that satisfies the guest (behaviour
> wise). And, for a reason I ignore, pointer authentication escaped this
> rule.
>
> I understand the concern regarding retro compatibility, but it would
> be better to ask politely (with an error message) to people to restart
> their virtual machines when they try to migrate, instead of being
> stuck with a slow default forever.

This is why we have compatibility logic so its easy to do the right
thing by specifying the QEMU version in the machine type.=20

> In more, we are talking of a tcg scenario, for which I'm not sure
> people use migration feature (save/restore) heavily, but I may be
> wrong on this.

We can't assume its not. We even have explicit tests that check
migration doesn't break between master and $PREVSTABLE.

> Between the risk of breaking migration (with a polite error message),
> and having a default that is 100% faster, I think it would be better
> to favor the second one. If it would be a 5% speedup, I would not
> argue, but slowing down execution with a factor of 2 is really a lot.
>
>> That was what I thought we were aiming for, yes. We *could* have
>> a property on the CPU to say "use the old back-compatible default,
>> not the new one", which we then list in the appropriate hw_compat
>> array. (Grep for the "backcompat-cntfrq" property for an example of
>> this.) But I'm not sure if that is worth the effort compared to
>> just changing 'max'.
>
> When we'll define hw_compat_10_0, and hw_compat_11_0, do we have to
> carry this on forever? (Same question for "backcompat-cntfrq").
>
>> (It's not that much extra code to add the property, so I could
>> easily be persuaded the other way. Possible arguments include
>> preferring consistency across all CPUs. If we already make the
>> default be not "what the real CPU of this type uses" then that's
>> also an argument that we can set it to whatever is convenient;
>> if we do honour the CPU ID register values for the implementation
>> default then that's an argument that we should continue to do
>> so and not change the default to our impdef one.)
>>
>
> For the TCG use case, is there any visible side effect for the guest
> to use any specific pointer authentication algorithm?
> In other words, is there a scenario where pointer authentication would
> work with impdef, but not with qarma{3,5}?
> If no, I don't see any reason for a cpu to favor an expensive
> emulation.

If the user asks for a specific CPU model (not a special case like max)
we should provide the most accurate model that we can as explicitly set
by the user. We don't trade accuracy for speed (c.f. discussions about
floating point and INEXACT detection).

> In the accelerator case, we read the values from the host cpu, so
> there is no problem.
>
>> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


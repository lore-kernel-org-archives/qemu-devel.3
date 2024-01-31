Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4144EC46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 01:50:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUzk7-0002nK-Gh; Tue, 30 Jan 2024 20:50:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1rUzk6-0002mI-E0
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 20:50:22 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1rUzk2-0005Ca-V3
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 20:50:22 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d71cb97937so27457615ad.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 17:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1706665817; x=1707270617;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:to:from:cc
 :in-reply-to:subject:date:from:to:cc:subject:date:message-id
 :reply-to; bh=/kYJdJ0OmOFrp6DhbGNXAFfCBnvjcg1JoswxMFeCvkM=;
 b=OWhdILzogaYfJUr0MzvDH2NiBD/dyNQjyoMHlsoUFh9WtFbGheVZiRWeb7gL31a4IP
 sngJF4BX2I25NrHZ1csHEHr7W7kErk724/N0DJVMjd29SrwlKARw14aXAduZEf51Y+RC
 dDmBFAlG8FgCo1eqMdrfwPDP/BljUBM65y85zg6ZIb5lJosDtN1yp3jgRAes3OywSZkI
 KJ//sqrK3XHizVKsC+N30pvcQXBj52iP1HtttHnTP01dtfCkazedVV3k5mGe5OVT9wUH
 oD+ixH23YLd0kSdWVxw2DwzjkzhSvCE35zsfwVcqu+388dgi/IgADw4ZskVroVAtLcug
 j1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706665817; x=1707270617;
 h=content-transfer-encoding:mime-version:message-id:to:from:cc
 :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/kYJdJ0OmOFrp6DhbGNXAFfCBnvjcg1JoswxMFeCvkM=;
 b=J9hyiu/gAVqFkMcsZ32AtEISTl61sBzkNUJpgU8+H8NiSmWWtw/5BY80xwpk09c1kD
 y3U98ZxtUha3NVxJYLDGwJ29JcNrnT10Idh2Mhf0rSwAjvNsSjEVPXL7SCa+X53P1Sox
 N8fDw9EyUSoVe/8yTseHwP5lrp1+KiEGDlmVpEcHBsnCobvjOQcI56FuQxitXZkwM3N6
 YpCPYonhEy8SFWk8Mwb9RXi0/DCtOMd6q4w0dnaV1bN0MdF1Y7V0R/9LC8EvtgL7KeSI
 0gomc5+wf3vDSv8MBi4H+SCyzB1XiJBcMeBjeGmQBkEcbczABiYsp2aQEnHW6DPbTiEy
 GyiQ==
X-Gm-Message-State: AOJu0YwmveLz6hA8LF8gMhpYZL+GLNEtMOVmG4akA5RMCuzRsl9KRRHA
 b7QxVlBRqeBYAR3mhpwWlCyVMgPZ7qbPmS9cMGENESwN29oGZ/3aTjpQw4uWZUs=
X-Google-Smtp-Source: AGHT+IH3j7ZZ8x+T/tjjx7aQcyGVM7Y3bc2tjampzOiiepQmi4ieofDEK2upvYP8R0gF54kHVhYuVQ==
X-Received: by 2002:a17:902:da8c:b0:1d3:4860:591b with SMTP id
 j12-20020a170902da8c00b001d34860591bmr364269plx.0.1706665816803; 
 Tue, 30 Jan 2024 17:50:16 -0800 (PST)
Received: from localhost ([12.44.203.122]) by smtp.gmail.com with ESMTPSA id
 y19-20020a170902ed5300b001d8b0750940sm6664266plb.175.2024.01.30.17.50.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 17:50:16 -0800 (PST)
Date: Tue, 30 Jan 2024 17:50:16 -0800 (PST)
X-Google-Original-Date: Tue, 30 Jan 2024 17:49:31 PST (-0800)
Subject: Re: Call for GSoC/Outreachy internship project ideas
In-Reply-To: <CAKmqyKMAQ1vrf9QnCx17DbKgGTqgDd58y46RLwZvzW4Sk4zyjA@mail.gmail.com>
CC: stefanha@gmail.com, Alistair Francis <Alistair.Francis@wdc.com>,
 dbarboza@ventanamicro.com, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 afaria@redhat.com, 
 alex.bennee@linaro.org, eperezma@redhat.com, gmaglione@redhat.com,
 marcandre.lureau@redhat.com, 
 rjones@redhat.com, sgarzare@redhat.com, imp@bsdimp.com, philmd@linaro.org,
 pbonzini@redhat.com, 
 thuth@redhat.com, danielhb413@gmail.com, gaosong@loongson.cn,
 akihiko.odaki@daynix.com, 
 shentey@gmail.com, npiggin@gmail.com, seanjc@google.com,
 Marc Zyngier <maz@kernel.org>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: alistair23@gmail.com
Message-ID: <mhng-3f05ad6b-53ef-4207-9592-625d794686e8@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=palmer@dabbelt.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 30 Jan 2024 17:26:11 PST (-0800), alistair23@gmail.com wrote:
> On Wed, Jan 31, 2024 at 10:30 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>
>> On Tue, 30 Jan 2024 12:28:27 PST (-0800), stefanha@gmail.com wrote:
>> > On Tue, 30 Jan 2024 at 14:40, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>> >>
>> >> On Mon, 15 Jan 2024 08:32:59 PST (-0800), stefanha@gmail.com wrote:
>> >> > Dear QEMU and KVM communities,
>> >> > QEMU will apply for the Google Summer of Code and Outreachy internship
>> >> > programs again this year. Regular contributors can submit project
>> >> > ideas that they'd like to mentor by replying to this email before
>> >> > January 30th.
>> >>
>> >> It's the 30th, sorry if this is late but I just saw it today.  +Alistair
>> >> and Daniel, as I didn't sync up with anyone about this so not sure if
>> >> someone else is looking already (we're not internally).
>> >>
>> >> > Internship programs
>> >> > ---------------------------
>> >> > GSoC (https://summerofcode.withgoogle.com/) and Outreachy
>> >> > (https://www.outreachy.org/) offer paid open source remote work
>> >> > internships to eligible people wishing to participate in open source
>> >> > development. QEMU has been part of these internship programs for many
>> >> > years. Our mentors have enjoyed helping talented interns make their
>> >> > first open source contributions and some former interns continue to
>> >> > participate today.
>> >> >
>> >> > Who can mentor
>> >> > ----------------------
>> >> > Regular contributors to QEMU and KVM can participate as mentors.
>> >> > Mentorship involves about 5 hours of time commitment per week to
>> >> > communicate with the intern, review their patches, etc. Time is also
>> >> > required during the intern selection phase to communicate with
>> >> > applicants. Being a mentor is an opportunity to help someone get
>> >> > started in open source development, will give you experience with
>> >> > managing a project in a low-stakes environment, and a chance to
>> >> > explore interesting technical ideas that you may not have time to
>> >> > develop yourself.
>> >> >
>> >> > How to propose your idea
>> >> > ----------------------------------
>> >> > Reply to this email with the following project idea template filled in:
>> >> >
>> >> > === TITLE ===
>> >> >
>> >> > '''Summary:''' Short description of the project
>> >> >
>> >> > Detailed description of the project that explains the general idea,
>> >> > including a list of high-level tasks that will be completed by the
>> >> > project, and provides enough background for someone unfamiliar with
>> >> > the codebase to do research. Typically 2 or 3 paragraphs.
>> >> >
>> >> > '''Links:'''
>> >> > * Wiki links to relevant material
>> >> > * External links to mailing lists or web sites
>> >> >
>> >> > '''Details:'''
>> >> > * Skill level: beginner or intermediate or advanced
>> >> > * Language: C/Python/Rust/etc
>> >>
>> >> I'm not 100% sure this is a sane GSoC idea, as it's a bit open ended and
>> >> might have some tricky parts.  That said it's tripping some people up
>> >> and as far as I know nobody's started looking at it, so I figrued I'd
>> >> write something up.
>> >>
>> >> I can try and dig up some more links if folks thing it's interesting,
>> >> IIRC there's been a handful of bug reports related to very small loops
>> >> that run ~10x slower when vectorized.  Large benchmarks like SPEC have
>> >> also shown slowdowns.
>> >
>> > Hi Palmer,
>> > Performance optimization can be challenging for newcomers. I wouldn't
>> > recommend it for a GSoC project unless you have time to seed the
>> > project idea with specific optimizations to implement based on your
>> > experience and profiling. That way the intern has a solid starting
>> > point where they can have a few successes before venturing out to do
>> > their own performance analysis.
>>
>> Ya, I agree.  That's part of the reason why I wasn't sure if it's a
>> good idea.  At least for this one I think there should be some easy to
>> understand performance issue, as the loops that go very slowly consist
>> of a small number of instructions and go a lot slower.
>>
>> I'm actually more worried about this running into a rabbit hole of
>> adding new TCG operations or even just having no well defined mappings
>> between RVV and AVX, those might make the project really hard.
>>
>> > Do you have the time to profile and add specifics to the project idea
>> > by Feb 21st? If that sounds good to you, I'll add it to the project
>> > ideas list and you can add more detailed tasks in the coming weeks.
>>
>> I can at least dig up some of the examples I ran into, there's been a
>> handful filtering in over the last year or so.
>>
>> This one
>> <https://gist.github.com/compnerd/daa7e68f7b4910cb6b27f856e6c2beba>
>> still has a much more than 10x slowdown (73ms -> 13s) with
>> vectorization, for example.
>
> It's probably worth creating a Gitlab issue for this and adding all of
> the examples there. That way we have a single place to store them all

Makes sense.  I think I'd been telling people to make bug reports for 
them, so there might be some in there already -- I just dug this one out 
of some history.

Here's a start: https://gitlab.com/qemu-project/qemu/-/issues/2137

>
> Alistair
>
>>
>> > Thanks,
>> > Stefan
>>


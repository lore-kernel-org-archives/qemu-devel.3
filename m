Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E7CEC47DDB
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 00:30:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUyU6-0001xF-EI; Tue, 30 Jan 2024 19:29:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1rUyTy-0001pu-Pp
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 19:29:40 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1rUyTw-0004WX-Af
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 19:29:38 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d751bc0c15so39168135ad.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 16:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1706660975; x=1707265775;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:to:from:cc
 :in-reply-to:subject:date:from:to:cc:subject:date:message-id
 :reply-to; bh=oRLEFUdWpThQfnH7eYE9k9scQwtpW7zudC4XUtfylHg=;
 b=zdZb8mFooYv2EfEeMVEQ7pgT1v4G/L/p//DnKfnupMHG7NUEGNbwtQGBheSo07F5Uh
 JXwvD44zhSrzKraK1Kwej+CX+twpLKRJRubkb+NowErIa+4f645bR/MM0ilJTsLRjE3q
 HeNpDHqjnEncCh81LgRYIeUf7hRb4g7X2MPLiZQflWMXt9y8HUgNP/6cuoSCXkOqMXOv
 piwSEDpHSTM3Vr5uDpC4f0iJJiAbBo8rK2M2oy1FYPR8O34DH/3y9npzFltkIP7fvzeV
 oJi0x7RTWqHYyHg/z4SKWOT65njLcztxXegXpyMtaXfDmOq9+VlpPYnLEfN+k+W6/wOE
 n0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706660975; x=1707265775;
 h=content-transfer-encoding:mime-version:message-id:to:from:cc
 :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oRLEFUdWpThQfnH7eYE9k9scQwtpW7zudC4XUtfylHg=;
 b=Z0FhcUJN3Ce+JI+S1L/HsaUTyOpvEAb2etLz5+uBLqD/NIePOwxv537RCVkFsg+BY4
 LRvedV5sSWkA4vDEkTZVeKcZH557F8pnW9aGmasLMIhIeKssZ5X6mgmCen4zmWeClXbm
 PVZzp32j/vOf5rduaRuzWGXBW9KBv+DfnAvTiPf2o7AiEyN3VV7oLi2VMqoPekPHNl0W
 F67SLcFqEKEENnGgQ0kgEM3cWUs594rA8knYTIvnGtOAnnqYZiT9Tnu4k+fZ5KghNBGp
 rVTKNA9i0jMKX7eyHsBBNsYbc4+cjn5AurZcGVue7HMqtGTwK5OMLCD7x9QUUvWqvAJq
 P/Gg==
X-Gm-Message-State: AOJu0YxwQ9+YKpAxU6IyHvnZQBPYOzFyEx55qdNvubZmZaax/v0SU3OF
 erFqiQXnYU/i9/5AqnGI3axP4agMIUjbIRHq4K9gHZngXOOJp4gfQsKgrWuS+C4=
X-Google-Smtp-Source: AGHT+IEffwLOD3IeGUvaEZuDZg/fNUq8KeMu5UCv1OS3W7G/LqKI6ZtHB8RVKmtvaa6YyYi9ygBI9w==
X-Received: by 2002:a17:903:1344:b0:1d6:f34c:35d9 with SMTP id
 jl4-20020a170903134400b001d6f34c35d9mr176144plb.58.1706660974561; 
 Tue, 30 Jan 2024 16:29:34 -0800 (PST)
Received: from localhost ([12.44.203.122]) by smtp.gmail.com with ESMTPSA id
 c3-20020a170902d90300b001d901e176afsm2267470plz.232.2024.01.30.16.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 16:29:34 -0800 (PST)
Date: Tue, 30 Jan 2024 16:29:34 -0800 (PST)
X-Google-Original-Date: Tue, 30 Jan 2024 16:29:29 PST (-0800)
Subject: Re: Call for GSoC/Outreachy internship project ideas
In-Reply-To: <CAJSP0QU2M0e56M0S9ztMDO7eyqFB-p1KgwxJhzwkxt=CuS_PqA@mail.gmail.com>
CC: Alistair Francis <Alistair.Francis@wdc.com>, dbarboza@ventanamicro.com,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, afaria@redhat.com,
 alex.bennee@linaro.org, 
 eperezma@redhat.com, gmaglione@redhat.com, marcandre.lureau@redhat.com,
 rjones@redhat.com, 
 sgarzare@redhat.com, imp@bsdimp.com, philmd@linaro.org, pbonzini@redhat.com,
 thuth@redhat.com, 
 danielhb413@gmail.com, gaosong@loongson.cn, akihiko.odaki@daynix.com,
 shentey@gmail.com, 
 npiggin@gmail.com, seanjc@google.com, Marc Zyngier <maz@kernel.org>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: stefanha@gmail.com
Message-ID: <mhng-e7014372-2334-430e-b22e-17227af21bd9@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=palmer@dabbelt.com; helo=mail-pl1-x630.google.com
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

On Tue, 30 Jan 2024 12:28:27 PST (-0800), stefanha@gmail.com wrote:
> On Tue, 30 Jan 2024 at 14:40, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>
>> On Mon, 15 Jan 2024 08:32:59 PST (-0800), stefanha@gmail.com wrote:
>> > Dear QEMU and KVM communities,
>> > QEMU will apply for the Google Summer of Code and Outreachy internship
>> > programs again this year. Regular contributors can submit project
>> > ideas that they'd like to mentor by replying to this email before
>> > January 30th.
>>
>> It's the 30th, sorry if this is late but I just saw it today.  +Alistair
>> and Daniel, as I didn't sync up with anyone about this so not sure if
>> someone else is looking already (we're not internally).
>>
>> > Internship programs
>> > ---------------------------
>> > GSoC (https://summerofcode.withgoogle.com/) and Outreachy
>> > (https://www.outreachy.org/) offer paid open source remote work
>> > internships to eligible people wishing to participate in open source
>> > development. QEMU has been part of these internship programs for many
>> > years. Our mentors have enjoyed helping talented interns make their
>> > first open source contributions and some former interns continue to
>> > participate today.
>> >
>> > Who can mentor
>> > ----------------------
>> > Regular contributors to QEMU and KVM can participate as mentors.
>> > Mentorship involves about 5 hours of time commitment per week to
>> > communicate with the intern, review their patches, etc. Time is also
>> > required during the intern selection phase to communicate with
>> > applicants. Being a mentor is an opportunity to help someone get
>> > started in open source development, will give you experience with
>> > managing a project in a low-stakes environment, and a chance to
>> > explore interesting technical ideas that you may not have time to
>> > develop yourself.
>> >
>> > How to propose your idea
>> > ----------------------------------
>> > Reply to this email with the following project idea template filled in:
>> >
>> > === TITLE ===
>> >
>> > '''Summary:''' Short description of the project
>> >
>> > Detailed description of the project that explains the general idea,
>> > including a list of high-level tasks that will be completed by the
>> > project, and provides enough background for someone unfamiliar with
>> > the codebase to do research. Typically 2 or 3 paragraphs.
>> >
>> > '''Links:'''
>> > * Wiki links to relevant material
>> > * External links to mailing lists or web sites
>> >
>> > '''Details:'''
>> > * Skill level: beginner or intermediate or advanced
>> > * Language: C/Python/Rust/etc
>>
>> I'm not 100% sure this is a sane GSoC idea, as it's a bit open ended and
>> might have some tricky parts.  That said it's tripping some people up
>> and as far as I know nobody's started looking at it, so I figrued I'd
>> write something up.
>>
>> I can try and dig up some more links if folks thing it's interesting,
>> IIRC there's been a handful of bug reports related to very small loops
>> that run ~10x slower when vectorized.  Large benchmarks like SPEC have
>> also shown slowdowns.
>
> Hi Palmer,
> Performance optimization can be challenging for newcomers. I wouldn't
> recommend it for a GSoC project unless you have time to seed the
> project idea with specific optimizations to implement based on your
> experience and profiling. That way the intern has a solid starting
> point where they can have a few successes before venturing out to do
> their own performance analysis.

Ya, I agree.  That's part of the reason why I wasn't sure if it's a 
good idea.  At least for this one I think there should be some easy to 
understand performance issue, as the loops that go very slowly consist 
of a small number of instructions and go a lot slower.

I'm actually more worried about this running into a rabbit hole of 
adding new TCG operations or even just having no well defined mappings 
between RVV and AVX, those might make the project really hard.

> Do you have the time to profile and add specifics to the project idea
> by Feb 21st? If that sounds good to you, I'll add it to the project
> ideas list and you can add more detailed tasks in the coming weeks.

I can at least dig up some of the examples I ran into, there's been a 
handful filtering in over the last year or so.

This one 
<https://gist.github.com/compnerd/daa7e68f7b4910cb6b27f856e6c2beba> 
still has a much more than 10x slowdown (73ms -> 13s) with 
vectorization, for example.

> Thanks,
> Stefan


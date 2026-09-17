Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68EAFC982D2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 10:08:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x792M-0004RK-N0; Thu, 17 Sep 2026 06:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x792G-0004Qc-1H
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 06:08:08 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x792C-0005gs-UL
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 06:08:07 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-485933b24c3so359070f8f.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 03:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789639683; x=1790244483; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hwNz+nSJy6H7wG+qtS9xsWQRrvGy/8z3htN31fYkID4=;
 b=ygn0lXjWji1wDMdi0IUOtYfp6SthXBOR2sp1OjkUq11Bk1vaf7HUnz6jt2uQRmFxyn
 6pc2KV63sH+aFAA9MKcU8diKorsAlvoP/WtWolnz9dF/WYRTOP9LqQ8JgI2Iivp4YJyy
 dMpED4SbiqpIa5A/e5Ewuo3GHF+CQFJxU5Noik8DOxfNUtQ6hBN+g7Jlju7uiAGWiYZj
 9kVY/50aMvQGL7ZRb6CEoOz2QNU90eW1gfIJv/egNjbSxnXbQlsQ3GJwYkJI/WB3iq95
 sB5MXMZm74+LZ14z+fKkUvXIVE4lxiXbijKhPQlDxC4q/anPNLTlHCGQ/WnrZxJKv0Nv
 SAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789639683; x=1790244483;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hwNz+nSJy6H7wG+qtS9xsWQRrvGy/8z3htN31fYkID4=;
 b=MLp0wow8N9diGvjd1V1a+Jw2SysK7C4TCeCelpXgtdNmIF4bmW27lrc6O9pBtaszBw
 v4Ws91WU4ELOkizRZTKNxaImjJ/uTMJbT3ayVjSnyTRQuP1BTLPWDq80ZMF1FWKrpfYG
 TG+/iUr9Qe/vuulyB/rZjRvFOy0I+f+smuFHxYVx0GhFwOvpQRVet0Nl6cX7jwsLL1hi
 qqkV5+ieq2BKRsuKIVG/xhy6q5bb441+XXT4t8AHhECYHxEPZAXfotzoHAwGz5p4ZmhY
 xS6S1pzP2dl/1CP+LOUB565Yr+4varenDCbXBhBGr/cbg3RTy4g80cdX9ysayz4nQs6H
 P0aw==
X-Gm-Message-State: AFuF++kQ23NjboTMSKSRJujM30n1S8VBKflLmUUs3dWtUd2y/MpXhYo/
 lXR1a4eXOopLXfGKa+V5GdXTmijbX4Iyki0T5+UCKlCfCnbsGSpU3PoHBeEg2LgvkBpGk7n0ER+
 G/eE6wRc=
X-Gm-Gg: AYBFou1yUBJX7gw0u2BjLY2qeYVqzW4crFHmw4HN2XEcBNlEAZtLuG/cXq4iH7+bhtK
 xC+Np33qL0wyni2SzHSsATaDOWuvIA5SLGy2J3jk92UzmLaBkjh1ksELxEDQ9ji3LbAWc3xun83
 Dk2m+8Fw4uzt4KkYfKgKGk1zAa3/0jQHiNrJEBQu2yv8tiBLZyMSYMymu7NTJR2KtrlfZKadUkE
 gZsk5oIVI53/sjdlMIxnFJo8iG/rgj/0OUjIHwXny51FULvllOtbDInEJNQg2dCv317xlZn9WbS
 0/MFYloks+fVxdXJNiHU5/mLdJTW7v7PAmdr4qpQN5ooZEUOCpGrfWW8KFThfvNypo/QMjrZ0b4
 EFvmn9I/d86TN9pD9nqZ/u9y+9Lju66zDDYKDQCgsdXmL07lHzp9F8v+J1weeR/kVvqW5+ppxkh
 jOm2owqjLA0rnmBkcW8Vd7DC3VEuxDYy8Xu1NmoQgyQioXN4xyEX5egCvcSJ6ANobkZBbujo8=
X-Received: by 2002:a05:600c:1909:b0:49e:8418:389d with SMTP id
 5b1f17b1804b1-49eb72f35bfmr69758645e9.9.1789639682380; 
 Thu, 17 Sep 2026 03:08:02 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e847e994dsm98389135e9.2.2026.09.17.03.08.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 03:08:01 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 861285F834;
 Thu, 17 Sep 2026 11:08:00 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  pbonzini@redhat.com
Subject: Re: [qemu-web RFC PATCH] blog post: some notes on the bugpocolypse
In-Reply-To: <10111cde-7d2e-4e81-8233-4ae940a95dac@redhat.com> (Thomas Huth's
 message of "Thu, 17 Sep 2026 11:10:07 +0200")
References: <20260911173420.1581755-1-alex.bennee@linaro.org>
 <10111cde-7d2e-4e81-8233-4ae940a95dac@redhat.com>
User-Agent: mu4e 1.14.4-pre3; emacs 30.1
Date: Thu, 17 Sep 2026 11:08:00 +0100
Message-ID: <8733v88a2n.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr2-x10.google.com
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

Thomas Huth <thuth@redhat.com> writes:

> On 11/09/2026 19.34, Alex Benn=C3=A9e wrote:
>> As we've been going throw the growing pains of AI bug bots I thought
>> it might be worth addressing in a blog post. I'm mainly just trying to
>> outline the challenges and maybe dissuade people from spam bombing the
>> bug tracker with lots of low value bugs in the more dusty corners of
>> the code base.
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>
>  Hi Alex,
>
> I was hoping that some native speaker would chime in first, but since
> nobody replied yet so far, let me try to provide some feedback: While
> I think the basic idea of having an article about the AIcapolypse is a
> good idea, I think the article is, all in all, somewhat too verbose
> and missing a proper line of thoughts / target audience throughout the
> whole text ... For example, for me it's quite unclear who you really
> want to address here. Is it an article about the history of the code
> base of QEMU? If so, people who just want to report a bug ticket that
> they found with their LLM tool don't care about most paragraphs here
> and will likely ignore this article.  The final paragraphs sound
> different, though, so I assume your intention was to write this for
> bug reporters? Somewhere in between, it also sounds like an education
> about what QEMU devices should be used for running QEMU in security
> relevant scenaries, so the target audience would rather be the users
> of QEMU? ... thus I'd recommend to double check each paragraph again
> whether they contain real information for the target audience or
> not...
>> diff --git a/_posts/2026-09-16-bugs.md b/_posts/2026-09-16-bugs.md
>> new file mode 100644
>> index 0000000..c3a466b
>> --- /dev/null
>> +++ b/_posts/2026-09-16-bugs.md
>> @@ -0,0 +1,203 @@
>> +---
>> +layout: post
>> +title: "Bugpocalypse, or reporting bugs in an AI age"
>> +date: 2026-09-11 14:00:00 +0000
>
> The date does not match with the file name of the article.

Yeah - I'll fix that up once we are close to publishing. Jekyll seems to
have issues rendering articles in the future so I had to keep renaming
the article and changing the metadata from when I originally wrote it.

If anyone has any tips on the right way to draft a blog post in Jekyll
let me know.

>
>> +categories: [bugs, ai, policy]
>> +---
>> +
>> +It is a truth universally acknowledged by programmers that software
>> +has bugs. In a program as large and complex as QEMU, you can expect it
>> +to have a fair few, especially thanks to our legacy of being written
>> +in C.
>
> I don't see much given value in the above paragraph. Maybe just drop
> it?

Fair enough, it was a little nod to Pride and Prejudice but I'll trim it.=20

>
>> +As a project, we have generally relied on our users to [report
>> +bugs](https://www.qemu.org/contribute/report-a-bug/) when they find
>> +them. Until recently, we had a slightly different process for
>> +"security" bugs, where we attempted to keep the details somewhat more
>> +secure until a fix could be made. Nowadays, we track all of the bugs
>> +in one place while taking advantage of GitLab's confidential flag to
>> +limit viewing the bugs to project members.
>
> So how's that information helpful for the reader? I think you should
> add information that we had to switch to the bug tracker for security
> bugs to scale the process due to the AIcapolypse. And that we try to
> make bugs public ASAP to avoid duplicates. =3D=3D> That would help people
> to understand our process, otherwise there is no additional
> information here to what people can already read on
> https://www.qemu.org/contribute/security-process/

That is what I was going for but I can make that tighter.

>
>> +While user bugs are found in the field, the project also tries to be
>> +proactive in catching bugs before that.
>> +
>> +Over the years, we have converted a lot of code to take advantage of
>> +modern language features to harden against common C faults. We have
>> +also greatly expanded our testing matrix to cover more of the
>> +codebase, both on developers' machines and in the CI system. The build
>> +system has native support for sanitiser builds as well as our own
>> +enhanced assertions for things like TCG. We even have experimental
>> +support for [Rust](https://rust-lang.org/), which opens a pathway for
>> +guest-facing device emulation to be implemented in a language that
>> +avoids most of [C's most popular bear traps](https://xkcd.com/1354/).
>
> Again, a big paragraph for very little information about. At least for
> bug reporters. Or did you want to write an article about the history
> of QEMU? If so, you should maybe rephrase the other paragraphs at the
> end of the article...

It was to give context that there are chunks of QEMU that we have been
proactively retrofitting to avoid bugs but leading into talk about the
dustier unmaintained sections.

>
>> +However, there are some caveats, and we have to acknowledge...
>> +
>> +Not All Code is Created Equal
>> +-----------------------------
>> +
>> +QEMU's git history goes back to 2003 and has grown a lot over the
>> +years as it has gained additional capabilities. Originally intended to
>> +help run Windows applications on other architectures via
>> +[Wine](https://www.winehq.org/), it has grown system emulation
>> +facilities for numerous architectures as well as support for a number
>> +of different hypervisors.
>> +
>> +In that time, it has also gained support for numerous architectures,
>> +boards, and features=E2=80=94totalling between 5 million to 11.5 millio=
n lines
>> +of code (depending on how you count). To keep track of that large
>> +codebase, we rely on our hardworking maintainers. This is all
>> +documented in the top-level
>> +[MAINTAINERS](https://gitlab.com/qemu-project/qemu/-/raw/master/MAINTAI=
NERS?ref_type=3Dheads)
>> +file.
>> +
>> +![Maintainer Coverage](/screenshots/qemu-maint-chart-26.svg)
>> +
>> +Compared to a lot of Free, Libre, and Open Source (FLOSS) projects,
>> +QEMU is quite lucky in that quite a high proportion of maintainers
>> +have jobs that allow them to actively look after the code. Around
>> +two-thirds of the code has maintainers who are able to review and
>> +queue patches for the upstream tree as well as triage bugs and
>> +undertake the architectural clean-up all projects need to go through
>> +as codebases mature.
>> +
>> +In general, those paid to look after QEMU worry about the
>> +[virtualisation use
>> +case](https://www.qemu.org/docs/master/system/security.html), as this
>> +is where the risk of untrusted guests trying to exploit the hypervisor
>> +and VMM is the greatest. The whole TCG accelerator is excluded from
>> +this security boundary specifically because it was never written with
>> +security requirements in mind.
>
> Again two very verbose paragraphs (you didn't use a LLM to write this,
> did you?) to say something that likely could be done in two short
> sentences.

I did not - the verbosity is purely my own story telling style unfortunatel=
y.

>
>> +Generally, we expect people running images on the
>> +[numerous](https://www.qemu.org/docs/master/system/arm/digic.html)
>> +[boutique](https://www.qemu.org/docs/master/system/or1k/or1k-sim.html)
>> +[platforms](https://www.qemu.org/docs/master/system/ppc/amigang.html)
>> +QEMU can emulate to have a fairly good idea of the provenance of the
>> +code they are running. Those using QEMU for security research are
>> +expected to take extra steps to contain potential exploits of QEMU
>> +itself.
>> +
>> +The designation of the virtualisation "use case" is also somewhat
>> +complicated by some legacy operating systems that don't support
>> +[VirtIO](https://www.qemu.org/docs/master/system/devices/virtio/index.h=
tml)
>> +out of the box. One very common class of devices often used for input
>> +on these machines is USB keyboards and touchscreens. At the time of
>> +writing, the USB subsystem is officially orphaned, which means no one
>> +is actively collecting patches or tending to the bugs in the tracker.
>> +
>> +While QEMU models a number of popular networking chips, they too have
>> +been a source of C bugs in the past. You should only be using them if
>> +for some reason you can't use virtio-net, because aside from security
>> +concerns, they will have lower performance than the VirtIO
>> +equivalent.
>
> This is very repetitive again. It does not matter very much whether
> you are using NICs, USB or whatever devices - if they are not being
> actively looked at (e.g. as virtualization use case), they are likely
> full of bugs due to the old code base.

I wanted to call out NICs and USB as they are the main attractors for
these LLM bug reports.

>
>> +The state of the bug tracker
>> +----------------------------
>> +
>> +If you look at the project's bug stats over the last year, you can see
>> +an inflection point around about March. This seems to coincide with
>> +the point where LLMs reached a new level of capability in their
>> +ability to diagnose security issues in code.
>> +
>> +![Issue Tracker over Last Year](/screenshots/2026-09-culm-issues.svg)
>> +
>> +Dramatic as this graph is, it doesn't even count a recent incident
>> +when one otherwise inactive user raised 120 seemingly valid issues in
>> +the space of a few minutes. I'm sure they would have posted more, but
>> +we think reporting the account for abuse to GitLab stopped the flood.
>
> It did not happen only one time. There were a bunch of other users,
> too, who reported dozens of tickets, some being real AI slop (though
> that guy with those 120 tickets certainly had one of the highest
> ticket counts)

I can reword to be more generic. I wanted to point out the 120 ticket
spam isn't reflected in the graph.

>
>> +We debated how much effort we should spend analysing those reports in
>> +case there were some real bugs in there. In the end, the conclusion
>> +was that we shouldn't waste valuable developer time on something the
>> +reporter didn't seem to really care about. We are almost certain that
>> +an LLM was involved in generating a lot of seemingly plausible bug
>> +reports.
>
> I think you should provide some links to bug tickets as an example
> here, so that people can better understand what you are talking about.

Unfortunately the 120 where removed from the system and some of the
biggest ones are still confidential. I'll see if I can find some
examples from the public bugs to point at.=20

>
>> +Verbosity has a cost
>> +--------------------
>> +
>> +As a project, we've tweaked our [issue
>> +templates](https://gitlab.com/qemu-project/qemu/-/tree/master/.gitlab/i=
ssue_templates?ref_type=3Dheads)
>> +a number of times to encourage users to include all relevant
>> +information when reporting bugs. We did this so developers can attempt
>> +to replicate bugs.
>> +
>> +It turns out LLM agents are pretty good at filling in the relevant
>> +details, often going much further than the template by including a
>> +long-form root-cause analysis of why we are seeing the failure. The
>> +quality of this text can vary a lot, but we usually get at least a
>> +test case and a command line to run it, which is more than we often
>> +get from our human contributors.
>> +
>> +However, that long text does come at a cost, and it will eventually
>> +need to have a human sit down and read it to understand what's going
>> +on. And humans, unlike machines, get tired after spending many hours
>> +going through the flood of incoming reports. It's with some sense of
>> +irony that we've been experimenting with using LLMs to do the initial
>> +triage of bugs so we can better distribute the load by routing bugs to
>> +the appropriate developer. However, all this generated text has to
>> +eventually be read and understood by a developer who is going to try
>> +and fix the issue.
>> +
>> +We still want help
>> +------------------
>> +
>> +Ultimately, the QEMU project is still a community of humans
>> +collaborating on a key component of the FLOSS virtualisation stack.
>> +People participate for many reasons, but no developer has signed up to
>> +spend their days wading through reams of generated slop.
>> +
>> +The ability to submit drive-by patches to fix that annoying behaviour
>> +in something you use has long been an advantage of FLOSS, and we want
>> +to take advantage of that. Some of those passing by end up hanging
>> +around the project and taking on bigger jobs and more responsibilities,
>> +and that is the way we try and sustain QEMU's developer community.
>> +
>> +With that in mind, I thought I would mention some things to keep in
>> +mind if you want to raise a bug in our bug tracker.
>> +
>> +*Focus on areas you use*
>> +
>> +Anyone can aim an LLM at some of the dustier corners of the QEMU code
>> +base and find issues. That's fine if you're looking for candidates for
>> +your first patch submission to the project. However, if you're just
>> +looking to raise bugs for the sake of it, please reconsider what your
>> +motivation is. If you truly want to help the project, maybe consider
>> +looking at some of the existing bugs and helping out there. We have
>> +plenty.
>> +
>> +*Review the output of AI tools*
>> +
>> +We don't ban the use of LLMs in the bug tracker because they obviously
>> +have their uses in identifying problems with the code. However, they
>> +are not infallible, so please be upfront about their use so people
>> +reading the report are fully informed of the origin of the report.
>> +Also, please review the text and see if you can edit down some of the
>> +more verbose passages that don't add useful information or are
>> +engaging in speculation as to the underlying failure reason. If your
>> +agent has written an elaborate harness to exercise the bug, then tell
>> +it to rewrite the test using QEMU's existing [testing
>> +framework](https://www.qemu.org/docs/master/devel/testing/index.html).
>> +
>> +*Propose a patch*
>> +
>> +If you've automated the process of finding bugs, you might as well go
>> +a step further and propose a patch to fix the issue. Often, reading a
>> +patch will give a clearer idea of the issue than wading through all
>> +the descriptive text. And if the patch turns into a massive
>> +rearchitecting of the codebase, then maybe consider that the LLM's
>> +model of how things might work could be flawed.
>> +
>> +We have been here before
>> +------------------------
>> +
>> +Modern LLMs are certainly proving to be disruptive, but this is not
>> +the first time a new technology has caused ripple effects throughout
>> +the FLOSS world. The introduction of static analysers, improved
>> +compiler diagnostics, sanitisers, and fuzzers have all been
>> +accompanied by code churn as the issues they find have been addressed.
>
> Well, yes, but those waves have never been as huge as the current one,
> I think.

I'll reword.

>> +I expect the same will eventually be true of this wave, and at the end
>> +of this disruptive phase, we will have better, cleaner, and more
>> +reliable software. And to achieve that, we will still need motivated
>> +engineers who understand the history and architecture of the codebase
>> +to shepherd it to the next release.
>
> I don't quite understand what you want to say with the last sentence.
> Do you want to ask people to join the development team? Or do you want
> to ask the reporters to report less / more meaningful things to avoid
> burning out the current team?


Both really - we need developers to step up for the uncovered areas and
we want reporters to be more mindful of where the most value is in
reporting issues.

>
>  Thomas

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA54C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 09:10:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x788J-0000fm-JB; Thu, 17 Sep 2026 05:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x788I-0000fe-1Q
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 05:10:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x788E-0007OP-Jd
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 05:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789636212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mdMr1E3qsgsZD/ZsMCir0Ma/e3yiXh4TEws/wX6KUec=;
 b=JC7FZAubaEeU607vcqhPhvUpHFRjfmUrXewXqW+y+wNuCk0W3YL9Y/teCQL50HScPKasbK
 N5j9pKMReenZToh60pgc/XPhnZX9TEnI7pciTah2+KX8KUbHsoOqzlTba1gc97kzfYKZf8
 n4bBRTSQhm0eglyCGespSMWuE7l45gk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-xF7W0tzgNiO8gli06KC0MA-1; Thu, 17 Sep 2026 05:10:10 -0400
X-MC-Unique: xF7W0tzgNiO8gli06KC0MA-1
X-Mimecast-MFC-AGG-ID: xF7W0tzgNiO8gli06KC0MA_1789636210
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49e82768ac2so2728645e9.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 02:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789636209; x=1790241009; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mdMr1E3qsgsZD/ZsMCir0Ma/e3yiXh4TEws/wX6KUec=;
 b=D3SY6njtbre1wHmG5p0gzCqO73QDDOszAGF34MmdBZOZKOC+V6J0NI7wClNBs5r0Ms
 0tu9fSqZpyW0Ku2v8vniuwkGZIVS9UVCuwPq4mhQJSCSYpqjQIWXetSyVC32GWU0O7iD
 JHsl8DLL0CTIcFe1iIeBoV5X3yhqwWl0SbpiAmZKCgTAktCgDqSLTD7r35tVC3DFE6gm
 v+8UDiQ+/RptTXFZibffikJFhdAnyzi6rvoA33cYW/43DC/yvZn3lTj39SdqavqO7ue7
 V3/QaqhjSArJq1B3LMUcMCfO+MHEeaSYb4Yte0CaujMbfZagPBY8ccUb/13nIGeg11s6
 E4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789636209; x=1790241009;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mdMr1E3qsgsZD/ZsMCir0Ma/e3yiXh4TEws/wX6KUec=;
 b=Dv46iTapp6JcH5OKuVZ/nZV6/9mWH9vtBMRQcrbNLIMcmvRN5E8Qcfxv1xUeAZQrhP
 wteoRbJdNuVPfUO2ljQf/t3NS11NMMpyLrUnFcGhTQ3C/Q4IDt8YrHb8ULGLAK3/U+5a
 DdVhWTaQFuowRjLCqubROb92RLvx7+Jcgdx8pF/SRbPI1zm8i+EF7GyCPRC0xAejmNex
 b9P+Dur2br+ioTPgF7iDpxvTWT7Y6HgfCC71GqlVvBL+dAD9PcqAKeM8B/85kMUSeLB1
 Dv4BXjAZKAe4/+4BZtUPR+yAXXO7pPVyU/3611FFpzWBpp6CavMZ31pr7qpksuJTduCG
 u4bA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzA64qol2eoCWzgACZcwD4Y9Y0GPmWiniQ+oqZlHxoFXpvVSx/38HAawd6EnujZggzAUnAq5KtL+6Tc@nongnu.org
X-Gm-Message-State: AFuF++k56IsM2cZFvax+Qh6Lew9wsDMCnRXQS4V7bF5e7dRMNbey7pba
 g1ZrthCRSglih86RZkYL28bab47FlJfXB7wmZfuC3l/OUsMIhQSi2YsY3cIugnuSVLXYEn7URKe
 4iC+xg4/AY81z1U1krfv9E4NyrXZPJpxwxsUd3khqYjTteFuzWngkx48O
X-Gm-Gg: AYBFou2ufA8TR1DdfO0wAATTeAjrAT7ggHTdCArK+oBslrk27qMVlmhVfgOLkVnxsFE
 EFafOyfadIR1SoFGOHUipyGjPth9PYZRCZqhvrZyG/PUizaaoJE3uVJIJsGi6ONWm45Hm/ihtSa
 QGYzlm8O3AyhCVaNyI98vR4ZE2kYC6he3B0CYQCjV2HaCaI0dN5w/Pn8bgCLq7m9wxavE6iaDT8
 TaEmpn8fTj3lsaxifbrMzbDh0uXkGTFeoS7NSG5M0etCQTui+yp7WaK/bwlcU0IefB6JGCgWs6s
 iQA71I4t2vvutQ+qc+wtYaqtiuBl8LVdmskehuWGzKmSBs/DZsW5Be/ln3OLASwTEHBVI/U+Ag=
 =
X-Received: by 2002:a05:600c:5020:b0:49c:e0e8:bd94 with SMTP id
 5b1f17b1804b1-49fbd1b170dmr39710215e9.1.1789636209431; 
 Thu, 17 Sep 2026 02:10:09 -0700 (PDT)
X-Received: by 2002:a05:600c:5020:b0:49c:e0e8:bd94 with SMTP id
 5b1f17b1804b1-49fbd1b170dmr39709595e9.1.1789636208863; 
 Thu, 17 Sep 2026 02:10:08 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.112.181])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bcc7d1esm13814483f8f.0.2026.09.17.02.10.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2026 02:10:08 -0700 (PDT)
Message-ID: <10111cde-7d2e-4e81-8233-4ae940a95dac@redhat.com>
Date: Thu, 17 Sep 2026 11:10:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [qemu-web RFC PATCH] blog post: some notes on the bugpocolypse
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20260911173420.1581755-1-alex.bennee@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260911173420.1581755-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/09/2026 19.34, Alex Bennée wrote:
> As we've been going throw the growing pains of AI bug bots I thought
> it might be worth addressing in a blog post. I'm mainly just trying to
> outline the challenges and maybe dissuade people from spam bombing the
> bug tracker with lots of low value bugs in the more dusty corners of
> the code base.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---

  Hi Alex,

I was hoping that some native speaker would chime in first, but since nobody 
replied yet so far, let me try to provide some feedback: While I think the 
basic idea of having an article about the AIcapolypse is a good idea, I 
think the article is, all in all, somewhat too verbose and missing a proper 
line of thoughts / target audience throughout the whole text ... For 
example, for me it's quite unclear who you really want to address here. Is 
it an article about the history of the code base of QEMU? If so, people who 
just want to report a bug ticket that they found with their LLM tool don't 
care about most paragraphs here and will likely ignore this article.  The 
final paragraphs sound different, though, so I assume your intention was to 
write this for bug reporters? Somewhere in between, it also sounds like an 
education about what QEMU devices should be used for running QEMU in 
security relevant scenaries, so the target audience would rather be the 
users of QEMU? ... thus I'd recommend to double check each paragraph again 
whether they contain real information for the target audience or not...
> diff --git a/_posts/2026-09-16-bugs.md b/_posts/2026-09-16-bugs.md
> new file mode 100644
> index 0000000..c3a466b
> --- /dev/null
> +++ b/_posts/2026-09-16-bugs.md
> @@ -0,0 +1,203 @@
> +---
> +layout: post
> +title: "Bugpocalypse, or reporting bugs in an AI age"
> +date: 2026-09-11 14:00:00 +0000

The date does not match with the file name of the article.

> +categories: [bugs, ai, policy]
> +---
> +
> +It is a truth universally acknowledged by programmers that software
> +has bugs. In a program as large and complex as QEMU, you can expect it
> +to have a fair few, especially thanks to our legacy of being written
> +in C.

I don't see much given value in the above paragraph. Maybe just drop it?

> +As a project, we have generally relied on our users to [report
> +bugs](https://www.qemu.org/contribute/report-a-bug/) when they find
> +them. Until recently, we had a slightly different process for
> +"security" bugs, where we attempted to keep the details somewhat more
> +secure until a fix could be made. Nowadays, we track all of the bugs
> +in one place while taking advantage of GitLab's confidential flag to
> +limit viewing the bugs to project members.

So how's that information helpful for the reader? I think you should add 
information that we had to switch to the bug tracker for security bugs to 
scale the process due to the AIcapolypse. And that we try to make bugs 
public ASAP to avoid duplicates. ==> That would help people to understand 
our process, otherwise there is no additional information here to what 
people can already read on https://www.qemu.org/contribute/security-process/

> +While user bugs are found in the field, the project also tries to be
> +proactive in catching bugs before that.
> +
> +Over the years, we have converted a lot of code to take advantage of
> +modern language features to harden against common C faults. We have
> +also greatly expanded our testing matrix to cover more of the
> +codebase, both on developers' machines and in the CI system. The build
> +system has native support for sanitiser builds as well as our own
> +enhanced assertions for things like TCG. We even have experimental
> +support for [Rust](https://rust-lang.org/), which opens a pathway for
> +guest-facing device emulation to be implemented in a language that
> +avoids most of [C's most popular bear traps](https://xkcd.com/1354/).

Again, a big paragraph for very little information about. At least for bug 
reporters. Or did you want to write an article about the history of QEMU? If 
so, you should maybe rephrase the other paragraphs at the end of the article...

> +However, there are some caveats, and we have to acknowledge...
> +
> +Not All Code is Created Equal
> +-----------------------------
> +
> +QEMU's git history goes back to 2003 and has grown a lot over the
> +years as it has gained additional capabilities. Originally intended to
> +help run Windows applications on other architectures via
> +[Wine](https://www.winehq.org/), it has grown system emulation
> +facilities for numerous architectures as well as support for a number
> +of different hypervisors.
> +
> +In that time, it has also gained support for numerous architectures,
> +boards, and features—totalling between 5 million to 11.5 million lines
> +of code (depending on how you count). To keep track of that large
> +codebase, we rely on our hardworking maintainers. This is all
> +documented in the top-level
> +[MAINTAINERS](https://gitlab.com/qemu-project/qemu/-/raw/master/MAINTAINERS?ref_type=heads)
> +file.
> +
> +![Maintainer Coverage](/screenshots/qemu-maint-chart-26.svg)
> +
> +Compared to a lot of Free, Libre, and Open Source (FLOSS) projects,
> +QEMU is quite lucky in that quite a high proportion of maintainers
> +have jobs that allow them to actively look after the code. Around
> +two-thirds of the code has maintainers who are able to review and
> +queue patches for the upstream tree as well as triage bugs and
> +undertake the architectural clean-up all projects need to go through
> +as codebases mature.
> +
> +In general, those paid to look after QEMU worry about the
> +[virtualisation use
> +case](https://www.qemu.org/docs/master/system/security.html), as this
> +is where the risk of untrusted guests trying to exploit the hypervisor
> +and VMM is the greatest. The whole TCG accelerator is excluded from
> +this security boundary specifically because it was never written with
> +security requirements in mind.

Again two very verbose paragraphs (you didn't use a LLM to write this, did 
you?) to say something that likely could be done in two short sentences.

> +Generally, we expect people running images on the
> +[numerous](https://www.qemu.org/docs/master/system/arm/digic.html)
> +[boutique](https://www.qemu.org/docs/master/system/or1k/or1k-sim.html)
> +[platforms](https://www.qemu.org/docs/master/system/ppc/amigang.html)
> +QEMU can emulate to have a fairly good idea of the provenance of the
> +code they are running. Those using QEMU for security research are
> +expected to take extra steps to contain potential exploits of QEMU
> +itself.
> +
> +The designation of the virtualisation "use case" is also somewhat
> +complicated by some legacy operating systems that don't support
> +[VirtIO](https://www.qemu.org/docs/master/system/devices/virtio/index.html)
> +out of the box. One very common class of devices often used for input
> +on these machines is USB keyboards and touchscreens. At the time of
> +writing, the USB subsystem is officially orphaned, which means no one
> +is actively collecting patches or tending to the bugs in the tracker.
> +
> +While QEMU models a number of popular networking chips, they too have
> +been a source of C bugs in the past. You should only be using them if
> +for some reason you can't use virtio-net, because aside from security
> +concerns, they will have lower performance than the VirtIO
> +equivalent.

This is very repetitive again. It does not matter very much whether you are 
using NICs, USB or whatever devices - if they are not being actively looked 
at (e.g. as virtualization use case), they are likely full of bugs due to 
the old code base.

> +The state of the bug tracker
> +----------------------------
> +
> +If you look at the project's bug stats over the last year, you can see
> +an inflection point around about March. This seems to coincide with
> +the point where LLMs reached a new level of capability in their
> +ability to diagnose security issues in code.
> +
> +![Issue Tracker over Last Year](/screenshots/2026-09-culm-issues.svg)
> +
> +Dramatic as this graph is, it doesn't even count a recent incident
> +when one otherwise inactive user raised 120 seemingly valid issues in
> +the space of a few minutes. I'm sure they would have posted more, but
> +we think reporting the account for abuse to GitLab stopped the flood.

It did not happen only one time. There were a bunch of other users, too, who 
reported dozens of tickets, some being real AI slop (though that guy with 
those 120 tickets certainly had one of the highest ticket counts)

> +We debated how much effort we should spend analysing those reports in
> +case there were some real bugs in there. In the end, the conclusion
> +was that we shouldn't waste valuable developer time on something the
> +reporter didn't seem to really care about. We are almost certain that
> +an LLM was involved in generating a lot of seemingly plausible bug
> +reports.

I think you should provide some links to bug tickets as an example here, so 
that people can better understand what you are talking about.

> +Verbosity has a cost
> +--------------------
> +
> +As a project, we've tweaked our [issue
> +templates](https://gitlab.com/qemu-project/qemu/-/tree/master/.gitlab/issue_templates?ref_type=heads)
> +a number of times to encourage users to include all relevant
> +information when reporting bugs. We did this so developers can attempt
> +to replicate bugs.
> +
> +It turns out LLM agents are pretty good at filling in the relevant
> +details, often going much further than the template by including a
> +long-form root-cause analysis of why we are seeing the failure. The
> +quality of this text can vary a lot, but we usually get at least a
> +test case and a command line to run it, which is more than we often
> +get from our human contributors.
> +
> +However, that long text does come at a cost, and it will eventually
> +need to have a human sit down and read it to understand what's going
> +on. And humans, unlike machines, get tired after spending many hours
> +going through the flood of incoming reports. It's with some sense of
> +irony that we've been experimenting with using LLMs to do the initial
> +triage of bugs so we can better distribute the load by routing bugs to
> +the appropriate developer. However, all this generated text has to
> +eventually be read and understood by a developer who is going to try
> +and fix the issue.
> +
> +We still want help
> +------------------
> +
> +Ultimately, the QEMU project is still a community of humans
> +collaborating on a key component of the FLOSS virtualisation stack.
> +People participate for many reasons, but no developer has signed up to
> +spend their days wading through reams of generated slop.
> +
> +The ability to submit drive-by patches to fix that annoying behaviour
> +in something you use has long been an advantage of FLOSS, and we want
> +to take advantage of that. Some of those passing by end up hanging
> +around the project and taking on bigger jobs and more responsibilities,
> +and that is the way we try and sustain QEMU's developer community.
> +
> +With that in mind, I thought I would mention some things to keep in
> +mind if you want to raise a bug in our bug tracker.
> +
> +*Focus on areas you use*
> +
> +Anyone can aim an LLM at some of the dustier corners of the QEMU code
> +base and find issues. That's fine if you're looking for candidates for
> +your first patch submission to the project. However, if you're just
> +looking to raise bugs for the sake of it, please reconsider what your
> +motivation is. If you truly want to help the project, maybe consider
> +looking at some of the existing bugs and helping out there. We have
> +plenty.
> +
> +*Review the output of AI tools*
> +
> +We don't ban the use of LLMs in the bug tracker because they obviously
> +have their uses in identifying problems with the code. However, they
> +are not infallible, so please be upfront about their use so people
> +reading the report are fully informed of the origin of the report.
> +Also, please review the text and see if you can edit down some of the
> +more verbose passages that don't add useful information or are
> +engaging in speculation as to the underlying failure reason. If your
> +agent has written an elaborate harness to exercise the bug, then tell
> +it to rewrite the test using QEMU's existing [testing
> +framework](https://www.qemu.org/docs/master/devel/testing/index.html).
> +
> +*Propose a patch*
> +
> +If you've automated the process of finding bugs, you might as well go
> +a step further and propose a patch to fix the issue. Often, reading a
> +patch will give a clearer idea of the issue than wading through all
> +the descriptive text. And if the patch turns into a massive
> +rearchitecting of the codebase, then maybe consider that the LLM's
> +model of how things might work could be flawed.
> +
> +We have been here before
> +------------------------
> +
> +Modern LLMs are certainly proving to be disruptive, but this is not
> +the first time a new technology has caused ripple effects throughout
> +the FLOSS world. The introduction of static analysers, improved
> +compiler diagnostics, sanitisers, and fuzzers have all been
> +accompanied by code churn as the issues they find have been addressed.

Well, yes, but those waves have never been as huge as the current one, I think.

> +I expect the same will eventually be true of this wave, and at the end
> +of this disruptive phase, we will have better, cleaner, and more
> +reliable software. And to achieve that, we will still need motivated
> +engineers who understand the history and architecture of the codebase
> +to shepherd it to the next release.

I don't quite understand what you want to say with the last sentence. Do you 
want to ask people to join the development team? Or do you want to ask the 
reporters to report less / more meaningful things to avoid burning out the 
current team?

  Thomas



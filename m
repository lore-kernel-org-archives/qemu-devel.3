Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F3FC982FA
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 07:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Ha3-0005IU-6f; Wed, 23 Sep 2026 03:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x9Ha1-0005I2-GF
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 03:39:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x9HZy-0008VO-RU
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 03:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790149185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MQpcJ+iRve9ltReyYJt47+8sj/eFVJiuQsyrFxdHeuI=;
 b=Tly/J0iUZsA2lfaqWXc5klGhtcpiQqmXqMYG+dZr2gxumE+B9NBP/IdTC483QTkrx0YsVd
 y3ebPpqs+rA7AXFSUckR6ZVAIx//ghYuiZ/+KWJNNYKnUk4fMS8hd8dpE1BhXbZmBYVh37
 A9e8wN9gMdL57RmsM4rvdyu4FsYoBPc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-s7iSnPbQOcmJQ49Nv3QkfA-1; Wed, 23 Sep 2026 03:39:43 -0400
X-MC-Unique: s7iSnPbQOcmJQ49Nv3QkfA-1
X-Mimecast-MFC-AGG-ID: s7iSnPbQOcmJQ49Nv3QkfA_1790149182
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4870eda3782so513816f8f.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 00:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790149182; x=1790753982; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MQpcJ+iRve9ltReyYJt47+8sj/eFVJiuQsyrFxdHeuI=;
 b=i4lVPsBUkKClhni5keVqAnWChoc8nmMJF8Q6gXPUj/jsIZG12AE0Lobv3sSCSfmCR7
 OE27wQ7dO3g+uNo8AsQ8oEuAjtDA8sAKgjPyFZHE+Ot7E0LfEmNDjmUSm3to+Jgc0Q62
 iwcXxawmgZzo6CxercmxLW3v43vMavu1DXS93Xchh0Ksd/4HdsIZ/+cVvLdu/ABmETqa
 kuI0v/4M3s2WEdWPbOSUtHhpxdoDeKB0uE9yUdHXml3xVdbLN1iln1uuoadx3GsRO1pD
 JhD+hCHncfLDO7aERyh7jThCGOGjfUs7GvS28niGky1jrkZbHivgvenodBZp9A6BmBH7
 n4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790149182; x=1790753982;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MQpcJ+iRve9ltReyYJt47+8sj/eFVJiuQsyrFxdHeuI=;
 b=CCqa+VFZ8L7AL/jA6Ac9KNAd3M0S6E8vbUjYQpqoZyOdtlxtLCK8A58sEekoe5oZqx
 AhNl0ZIBYdj3GjARx+dql43gyUhkicvAxvf4DPF8hsq8tmgxkXAWkTLADUpHxiHIJXOD
 ZQ0jsd5H+B740f0w3c0OGZfmhI9lvQIpNQ33q84I57tv+03DPqcsfv065rY+Nx3FPCe+
 MDgBWRgXsaE/a6XipWqYs0j2vRwqZvg9EKx/mJ9RsaGV5xFKg5+tFqkB15eEadIeV9CG
 AJxfAay7cr3pdTbPOSlMpSzQ5o0u96ltekZKrx7vgiqw0cqWEA0/pk6BCuJUIjPkX2B9
 fw/w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxu7221+8Q17gtGgN67HiQKnGtzfzIlTRG7GYvq4xnm22tok3OIOsI3/ZTiceb/ywchCdqn78tLeJeV@nongnu.org
X-Gm-Message-State: AFuF++k3dMSBN33OFyiKMjIsdETepCzAVBiTF8EUrlksqvwVwSHtfaMX
 BAM4EXqRyBn6H+/iasyKTP92IFR1uBqaizat+7LqvPN+pxRXm7WWM6tIt6j1YZTmhk4A4VYmHSl
 3NgkDOpdVO6ozVxN+OLEl+eHN0FMyS7+ZXPGE1jgXRLyOganrF4PiBoKv
X-Gm-Gg: AYBFou3S/jdnucC2tohJPe9zMhmG4FH4HmNVrdWV2a/+WAFxSsrs0aaSDMGfG1BNfpG
 o01XLtUwg9UDg04VpT4P+l7pft5Qzf/f3OGpQ6X54+4QWumztuTfRL/RykZ1M5pd56pmTJh790b
 KOxZhJ5aiLII5/VzCFuMBGol11xK0stemPBA6L9AEcCc4fzrCALaH61ottVbBz3GNWVSildzf7i
 u7FBju7yklB3TlqNx3pC3dQXN0Ytw8lyNyOXeu5nF64ewXV4WLPtrL3+AzX33Of99zkJbMiWqXN
 midzZY4sewejmuRDHZyw8d9PV2kTrNaVO/1Fh1UGo3D4hpyD+nkuaEAJqYgBfolcsdjYmwJCfQ=
 =
X-Received: by 2002:a05:6000:4914:b0:487:1256:ab80 with SMTP id
 ffacd0b85a97d-488670a4452mr2517109f8f.57.1790149181935; 
 Wed, 23 Sep 2026 00:39:41 -0700 (PDT)
X-Received: by 2002:a05:6000:4914:b0:487:1256:ab80 with SMTP id
 ffacd0b85a97d-488670a4452mr2517073f8f.57.1790149181467; 
 Wed, 23 Sep 2026 00:39:41 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-488688893a0sm5052153f8f.32.2026.09.23.00.39.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 00:39:40 -0700 (PDT)
Message-ID: <77608a72-d61e-4a6c-95a1-85e940260bb2@redhat.com>
Date: Wed, 23 Sep 2026 09:39:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [qemu-web PATCH v3] blog post: some notes on the bugpocolypse
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: yodel.eldar@yodel.dev, pbonzini@redhat.com
References: <20260921075850.1322075-1-alex.bennee@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260921075850.1322075-1-alex.bennee@linaro.org>
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

  Hi Alex!

Thanks for the update, the text now sounds much better and clearer to me, I 
think this is close to be ready for being published now. Some minor nits 
below...

On 21/09/2026 09.58, Alex Bennée wrote:
> As we've been going through the growing pains of AI bug bots I thought
> it might be worth addressing in a blog post. I'm mainly just trying to
> outline the challenges and maybe dissuade people from spam bombing the
> bug tracker with lots of low value bugs in the more dusty corners of
> the codebase.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v3
>    - went through Yodel's review comments
>    - /throw/through/
>    - consistent use of codebase
>    - bunch of commas and tweaks to long run-on sentences
>    - reword drive-by sentence to avoid double-feature
> 
> v2
>    - shorter lead in, use quote instead of literary allusion
>    - move history of code to after discussion of bug tracker state
>    - rewrite section on slop attacks
>    - include example bug analysis
>    - trim last few paragraphs from code history discussion
>    - actively mention how many confidential issues are unmaintained
>    - nod to the largeness of the wave while summing up
> ---
>   _posts/2026-09-17-bugs.md           |  206 ++
>   screenshots/2026-09-culm-issues.svg | 3210 +++++++++++++++++++++++++++
>   screenshots/qemu-maint-chart-26.svg |    1 +
>   3 files changed, 3417 insertions(+)
>   create mode 100644 _posts/2026-09-17-bugs.md
>   create mode 100644 screenshots/2026-09-culm-issues.svg
>   create mode 100644 screenshots/qemu-maint-chart-26.svg
> 
> diff --git a/_posts/2026-09-17-bugs.md b/_posts/2026-09-17-bugs.md
> new file mode 100644
> index 0000000..ed4bf3b
> --- /dev/null
> +++ b/_posts/2026-09-17-bugs.md
> @@ -0,0 +1,206 @@
> +---
> +layout: post
> +title: "Bugpocalypse, or reporting bugs in an AI age"
> +author: Alex Bennée
> +date: 2026-09-16 12:00:00 +0000
> +status: draft

Please remember to match the date with the file name and remove "draft" for 
the final version.

> +categories: [bugs, ai, policy]
> +---
> +
> +> "...perfect software doesn't exist. No one in the brief history of
> +> computing has ever written a piece of perfect software."
> +>
> +> <cite>- Andrew Hunt, The Pragmatic Programmer, Chapter 4</cite>
...
> +
> +Verbosity has a cost
> +--------------------
> +
> +As a project, we've tweaked our [issue
> +templates](https://gitlab.com/qemu-project/qemu/-/tree/master/.gitlab/issue_templates?ref_type=heads)
> +a number of times to encourage users to include as much relevant
> +information as possible when reporting bugs. From a developer point of
> +view we want to know the precise versions and command lines used to
> +help us replicate the issues. An excellent bug report is one that
> +comes with a simple reproducer test case that is easily run.
> +
> +It turns out as LLM agents abilities have improved so has their
> +ability and willingness to fill out the relevant details. Often they
> +go much further than the template by including a long-form root-cause
> +analysis of why we are seeing the failure. The quality of this text
> +can vary a lot, but we usually get at least a test case and an example
> +command line to run it.
> +
> +However, that long text does come at a cost, and it will eventually
> +need to have a human sit down and read it to understand what's going
> +on.
> +
> +For example consider this [iommu migration
> +bug](https://gitlab.com/qemu-project/qemu/-/work_items/4174) which is
> +nearly 4000 words long and includes a from scratch test harness to
> +modify a migration stream and trigger the issue. Once you spend awhile
> +reading it you can work out that what is at issue is if you mess with a
> +migration stream you can trigger the receiving end to abort() when it
> +gets junk. Is this really a critical issue? It's hard to tell, but the
> +text does seem persuasive - it will probably need a migration expert
> +to look at it and give their opinion.
> +
> +Humans, unlike machines, get tired after spending many hours reading
> +through walls of plausible text from a seemingly never-ending stream
> +of incoming reports.

"git am" complained about a "trailing whitespace" here.

> +It is with some sense of irony that we've been experimenting with
> +using LLMs to do the initial triage of bugs so we can better
> +distribute the load by routing bugs to the appropriate developer. But
> +still eventually a human has to assess and decide what to do about it.
> +
> +We should also consider another fact which is....
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
> +boards, and features totalling between 5 million to 11.5 million lines
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
> +
> +Generally, we expect people running images on the
> +[numerous](https://www.qemu.org/docs/master/system/arm/digic.html)
> +[boutique](https://www.qemu.org/docs/master/system/or1k/or1k-sim.html)
> +[platforms](https://www.qemu.org/docs/master/system/ppc/amigang.html)
> +QEMU can emulate to have a fairly good idea of the provenance of the
> +code they are running. Those using QEMU for security research are
> +expected to take extra steps to contain potential exploits of QEMU
> +itself.

maybe add a "(for example by using the security features of libvirt, see 
https://libvirt.org/drvqemu.html#driver-security-architecture)" at the end 
of the last sentence?

  Thomas



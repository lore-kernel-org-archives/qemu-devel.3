Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60563CD98C5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 13:56:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ7nN-0004iM-8s; Mon, 15 Jun 2026 09:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wZ7nI-0004gu-DX; Mon, 15 Jun 2026 09:56:04 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wZ7nF-0002Jw-Po; Mon, 15 Jun 2026 09:56:04 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65FDtfJM066597
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 15 Jun 2026 22:55:41 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=hL6WN6cKKG0UobNTFCxhqkQpG6gwNjkA3147OsKl7l4=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1781531741; v=1;
 b=hDPcqFYAlb3DjIPSr4Zlqh8Q4goHjA/5DuLjjb/6iDm63W48sHAFnFoWoW0jTHPH
 X6ZmKzzCmCjzjRhfIHVv1ms8gVm2sdxkB/FXJM0fzZRNHwSXMBaG+idJzuEbBk1F
 ZYPEx988baDFFki8XyfdXYibF7bcrsyjhjmYXxoYcnKGPfnSWMKwcZ+N9jXUhJq8
 tTrhTmq8LhvELYfG5yPS+pxdcNCSzp3BlwYHvi4uDFpcl9nJ+dvRCD/bMg8je8Jg
 g0mA1udJ1WqjbCDS0WonHC4C4tZKLm9NqN3GqLJk4AznpB/DTOc+oilKcl7WFGbc
 RKzEE40uOadHFMy/2VSQqQ==
Message-ID: <5ade0eb4-db5c-45c9-9472-888096fd35fd@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 15 Jun 2026 22:55:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] qom: Manage references to embedded child objects
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-rust@nongnu.org, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
References: <20260615-embedded-v1-0-bb0c65bf126c@rsg.ci.i.u-tokyo.ac.jp>
 <20260615-embedded-v1-2-bb0c65bf126c@rsg.ci.i.u-tokyo.ac.jp>
 <ai-z14dMCK33_pis@redhat.com>
 <CAFEAcA_nFiQyXyCuvwUrJ+-0fhmGoMfswK-+KsZbxahAGatTXw@mail.gmail.com>
 <ai-5M6FF7CoJc_re@redhat.com>
 <CAFEAcA_52oFGv7cC11jbpj9pwBq-x2O-R_aOGkYzaRWW7t-K2g@mail.gmail.com>
 <acb64b89-2a5f-4f7c-b5c8-8c31667908c2@nutanix.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <acb64b89-2a5f-4f7c-b5c8-8c31667908c2@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/06/15 22:42, Mark Cave-Ayland wrote:
> On 15/06/2026 10:28, Peter Maydell wrote:
> 
>> On Mon, 15 Jun 2026 at 09:35, Daniel P. Berrangé <berrange@redhat.com> 
>> wrote:
>>>
>>> On Mon, Jun 15, 2026 at 09:31:36AM +0100, Peter Maydell wrote:
>>>> On Mon, 15 Jun 2026 at 09:13, Daniel P. Berrangé 
>>>> <berrange@redhat.com> wrote:
>>>>> Do we know how many examples we have of embedding objects inside
>>>>> another ?
>>>>
>>>> It is an extremely common pattern for device and SoC model
>>>> implementations; we've been recommending it for years.
>>>>
>>>>> I would much prefer if we forbid the embedding of objects. It is
>>>>> horrible design practice to have some QOM objects which can be
>>>>> freed via reference count and some which cannot.
>>>>
>>>> That would be a very large amount of code to rewrite to the
>>>> new paradigm. I don't object inherently ("you have pointers to
>>>> your child objects" works better when they might be implemented
>>>> in Rust and might play better with being able to create
>>>> machines and wire them up on the command line); I'm just
>>>> noting how much work it would be if you wanted to make
>>>> embedding forbidden.
>>>
>>> Would it be a more tractable problem to "fix" object structure only
>>> incrementally as they gain a need to be managed/reference from
>>> Rust code, or does the Rust usage already implicitly extend too
>>> broadly
>>
>> At the moment we have exactly 2 Rust devices. You can see the
>> workaround we ended up with for the PL011 in commits 5b87a07e768
>> and cc3d262aa93a4, where we pad out the C device struct and
>> assert on the Rust side that its version isn't any bigger.
>>
>> For that particular problem we could say "you need to refactor
>> all users of device X to not embed it before creating the Rust
>> version". There is I think only one embedded use of the PL011
>> (I was actually expecting more). This does have the awkward
>> effect that anybody wanting to do a "rewrite device in rust"
>> is now forced into "do a big refactor of some old C code they
>> don't care about". We would also need to actually document and
>> provide some good examples of "this is how we think we should
>> be writing device models that have child objects now".
> 
> I think given the legacy of the QEMU codebase then this will always be 
> an issue, but we've solved this in the past with the introduction of 
> MemoryRegions so there's no reason we couldn't do it again.
> 
> This is a similar problem to the use of non-class object properties I 
> was discussing in the thread with Daniel: it seems the general consensus 
> is that they shouldn't exist, but this hasn't been formalised anywhere. 
> If we can formalise the decision not to use embedded QOM objects, then 
> we can start by ensuring that new submissions don't use them and go from 
> there.
> 
> Question: who currently should make these decisions? Is it restricted to 
> the QOM maintainers?
> 
>> But embedded MemoryRegions are enormously common, and devices
>> that embed other devices that embed MemoryRegions are also
>> pretty common. So I don't know how much of a gradual approach
>> you could take for the issue descibed in this patch.
> 
> Zoltan did post a patch that allowed for adding externally referenced 
> MemoryRegions a while back: my reason for not supporting the approach 
> was because it added yet another way of adding MemoryRegions to work 
> around a particular legacy use case. However if there is agreement that 
> this is the way we should do things, I suspect that the series will have 
> solved most of the problems in this area.

Personally, I do not have a strong preference between supporting 
references to embedded objects and deprecating object embedding 
entirely, so this patch takes the smaller step needed to address the 
immediate issue. I would not object to deprecating embedding if that is 
the direction we want to take.

Regards,
Akihiko Odaki


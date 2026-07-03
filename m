Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5CCC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 22:46:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfmdx-0008Ec-As; Fri, 03 Jul 2026 18:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.2trqg2f9qk65se4=0mx28d1n08ij=l07orq7cnrwkkn@em1175899.techtravels.org>)
 id 1wfmdt-0008EN-Pe
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 18:45:55 -0400
Received: from a3i384.smtp2go.com ([203.31.37.128])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.2trqg2f9qk65se4=0mx28d1n08ij=l07orq7cnrwkkn@em1175899.techtravels.org>)
 id 1wfmds-0004U5-2L
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 18:45:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=techtravels.org;
 i=@techtravels.org; q=dns/txt; s=s1175899; t=1783118740; h=from :
 subject : to : message-id : date;
 bh=N5Qz6dllLKNJDBYao5BMJMG9ZXP9eOMJ/geX2rz3ut0=;
 b=Aq4F1DHlG1OSxa/iEc5QolgCxiTNe2Ryh4f/vaZL26I+0HhdA0/mI8mNg0x0MlP5BFhBp
 3U0ifhG/hhjLfB+EHcdkxQY0hQSbJxxY5198Ra4xarYJVoLAVySELFIJIhKd3lRsfzwTWhf
 b5I8fFhVqXZQDgkOm8SDDhIGyC4BBJlr6b19mtGe/86XFyFLdqI/bWIPr65EF13KcYotX4V
 Ng8sbX4VijgfrY0nwmzIq1EBsTJYdsJjqXBBZJxjghuwEoZLhBWTtdbevKH4GKqiVw/2XEB
 esrn/DTHOZYSHIst0cpORH9RhRpXISwrJD1cy6dpHxgEmBaBK3vuubMjIgoA==
Received: from [10.91.249.253] (helo=boxtwo.techtravels.org)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.99.4) (envelope-from <keith@techtravels.org>)
 id 1wfmdb-FnQW0hPnR4y-BVwP; Fri, 03 Jul 2026 22:45:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=techtravels.org;
 s=mail; t=1783118728;
 bh=cHtFOx6bUc6ou1tMY0XAVNCbHcOZ1aRFCJXzBPi/JmU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Oh+TjdiFl0X5VAQJyNk1H9ZogLVJDThjHO3IXaC88lYN3e/QuLHtfRVJ6490UsOXt
 pPF0GXgzNbQ5TQfP99p0UH1E9G4d+4j/aBmzZoTdJdk8i6OIA/GGc8hN8nofMwpZSH
 TuO/CgSqLQmV9hZfiFH/WDcIK4uJ8QTfzOuz0SMH41H3U/avu/zrRQoKeSax+vi9kU
 nm1xGw6BOjt5zbwBdRKvAQRuQ0+rK9dqED1mNw8j4UoxMfFXpThx4T3+C+omEOKH4Y
 KkUpxDSrYYY8lnQ/IKIxYTrT8r31dlpvVTWfBXv9Aesuc3FR79riBkvUQ9BJJtJRP2
 uW20gRXI7dgUg==
Received: from authenticated-user (boxtwo.techtravels.org [54.196.37.146])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by boxtwo.techtravels.org (Postfix) with ESMTPSA id 66ABD3F195;
 Fri,  3 Jul 2026 18:45:28 -0400 (EDT)
Message-ID: <74e5958d-58d8-4519-82dc-52e598eb6d68@techtravels.org>
Date: Fri, 3 Jul 2026 18:45:28 -0400
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/4] hw/scsi/ncr53c710: rewrite the SCRIPTS engine
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, BALATON Zoltan <balaton@eik.bme.hu>
References: <20260701213359.1855870-1-keith@techtravels.org>
 <20260701213359.1855870-4-keith@techtravels.org>
 <CAFEAcA_3vf5vrwoO0cGcdTsykU8uTf8386oyWki3iQ3Bje9Trw@mail.gmail.com>
 <8d3f679a-3039-404e-879d-b97e1b58e090@techtravels.org>
 <CAFEAcA-s2xYKG5PiUqFufdgJgMxD1OccbHO9zcCH2+aXwkK70Q@mail.gmail.com>
Content-Language: en-US
From: Keith Monahan <keith@techtravels.org>
In-Reply-To: <CAFEAcA-s2xYKG5PiUqFufdgJgMxD1OccbHO9zcCH2+aXwkK70Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 1175899m:1175899aieqF3d:1175899s5U9-VI9CJ
X-smtpcorp-track: UfqSfaQjhvK_.qc_8_V0K7Dlq.u-OcDwGbXBw
Received-SPF: pass client-ip=203.31.37.128;
 envelope-from=bounce.2trqg2f9qk65se4=0mx28d1n08ij=l07orq7cnrwkkn@em1175899.techtravels.org;
 helo=a3i384.smtp2go.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Peter,

As you know, I did not start with a rewrite. I started exactly where you 
are asking me to end up. I spent a large amount of effort trying to 
morph the existing model into something correct one reviewable change at 
a time: identifying, debugging, remediating, and reapplying fixes for 
something on the order of a dozen distinct bugs, testing after each 
round. That path still did not converge. Only after that did I pivot to 
rebuilding from scratch, and that was its own effort: tracing, 
debugging, and running hundreds of test cases before it actually worked.

So reconstructing an incremental series now means manufacturing the 
exact path I already tried and abandoned, except the intermediate 
commits are throwaway by construction. They exist only to satisfy 
review, not to reach a solution, since the working solution already 
exists as the final commit.

I am investigating the feasibility of creating a series of incremental 
patches to morph the original 710 model into the new one, but I do not 
yet know how cleanly that will map onto the current result, since the 
structure is now quite different and some parts may not have a useful 
intermediate form.

The original 710 model likely borrowed from the 895 model, as did I when 
I rebuilt it. So you are right: some of what I claim to be new code in 
the diff could very well be the same 895 pattern the original author 
already used as well. This may indeed reduce how much is genuinely new, 
and I can look for other places where the same thing is true.

There is also a real tradeoff in how the series can be sliced, and I 
think it comes down to a choice I need you to make. I can aim for 
smaller steps that each build but do not necessarily boot the guest, or 
I can aim for steps that keep the model bootable at each stage, which 
forces large chunks of the central core to land together as one atomic 
commit. I do not think I can give you both at once.

Which do you want? If every commit has to boot, some changes simply 
cannot be separated, because the model likely only becomes functional 
once the central control flow change lands.

To be clear, choosing option 2 means the central patch is going to be large!

Thanks,
Keith

On 7/3/2026 5:03 AM, Peter Maydell wrote:
> On Thu, 2 Jul 2026 at 22:49, Keith Monahan <keith@techtravels.org> wrote:
>>
>> Peter,
>>
>> Thanks for going through it. I raised this originally in the v1 thread
>> and I am not sure it reached you, so let me lay it out here.
>>
>> The size is real, but the more useful thing to flag is that reading this
>> as a diff against the old model will not give you an accurate view of
>> the change, because these are not two versions of one model. They are
>> two different implementations, and git is aligning text between them
>> that never shared any code.
> 
> And yet, when I look at the diff I see clear things that are
> just individual fixes or changes to the existing code.
> Yes, there's a big change to the core, but it would be much
> easier to see what that core change is if it was not all
> thrown in with all the other parts too. (Just to check I
> had another scroll through and there really is a ton of stuff
> in there which is changes like "variable name changed from
> 'operator' to 'xoperator' or "the constant names in all the
> case statements lost their _REG suffix".)
> 
> Incidentally, even for "here is a completely new device model"
> I would recommend structuring it as multiple patches, not a
> single "here is the device" patch, when the device is this
> complex.
> 
> -- PMM



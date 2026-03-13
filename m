Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62AE7106FD9A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 07:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0x0X-0003G8-Kw; Fri, 13 Mar 2026 03:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0x0S-0003FW-F0; Fri, 13 Mar 2026 03:32:26 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0x0P-00024G-Jw; Fri, 13 Mar 2026 03:32:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773387095; bh=M1QTbYtC1DBjME5AQ00HKc9tFhfjhVjAz1Q47jGsb7U=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=dWdTqPUGYwe9JRTdeulvlOb6Vw99+2VDHO4F1kkR9w+PbzqNMic2avtxhZ+lXjdSB
 ulnScDH0HWywGiZh2doqeuLdBSht6otTgJkPDVy+GHBmOpadDpQkUaX7anEyyZD1GP
 kJuzkiqikVVSXP9VQEgStv1p0gdFpRm3Ugok+6s94LtiiAjI0mw31a/hjJV7G6KXI1
 yiHNNS1Dh1CilyAgpaJGtM8pb4ONr0ifw3GICHEwZY5sEqT1b3W8Ab5ijeC9rxShJE
 mecYaFMPOOkvDFY3ZeUzZftuCUUucphmTLZ0qhxpcgzJjpr4964xp/QlOAxpd1wV3S
 nvgjALOqfnO1w==
Received: from [192.168.177.146] (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by isrv.corpit.ru (Postfix) with ESMTP id 6860C192B3F;
 Fri, 13 Mar 2026 10:31:35 +0300 (MSK)
Message-ID: <f9ae42d4-e532-45f2-afe8-e425e32ccae0@tls.msk.ru>
Date: Fri, 13 Mar 2026 10:32:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 1/2] target/loongarch: Preserve PTE permission bits in LDPTE
To: andrew@rail5.org, Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bibo Mao <maobibo@loongson.cn>
References: <20260310114442.1025328-1-gaosong@loongson.cn>
 <20260310114442.1025328-2-gaosong@loongson.cn>
 <55df9b3d-702b-445b-972a-6671a1b9270e@tls.msk.ru>
 <e7fbf3677b84a53d44769b1711a69a1c52332c19.camel@rail5.org>
 <3db74cf4-3676-4e18-96e8-61b91b17c316@tls.msk.ru>
 <36380340ce49dda41ef9d933f0d471bc520de797.camel@rail5.org>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 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
In-Reply-To: <36380340ce49dda41ef9d933f0d471bc520de797.camel@rail5.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

On 13.03.2026 05:04, Andrew S. Rightenburg wrote:
> On Wed, 2026-03-11 at 13:30 +0300, Michael Tokarev wrote:
>> Please take a look at https://gitlab.com/mjt0k/qemu/-/commits/staging-10.2
>> -- hopefully my back-port makes sense.
>>
>> The same's for staging-10.1 and staging-10.0 (10.0 needed additional
>> small tweak).
>>
> 
> It makes sense to me, but 10.1 and 10.0 still have the recursive PNX bug. I've
> included backported patches for those two down below

Aha.  I wondered about that one for a moment too, but didn't look close
enough, being distracte dby the PTE permission bits change :)

>> Yeah the Fixes tag is obviously misleading.  What's the actual commit
>> which introduced the issue, if it's easy to find? :)
> 
> It looks like the "mask the whole PTE" bug was introduced in d2cba6f7ce
> ("target/loongarch: Add other core instructions support") when LDPTE was added
> initially
> 
> Likewise I screwed up the 'Fixes:' tag for the other part of the patch as well.
> The recursive PNX exception bug was actually introduced in f757a2cd69
> ("target/loongarch: Add LoongArch interrupt and exception handle")

Aha.  This makes perfect sense!

> Sorry about that. In any future patches I'll make sure to be more careful about
> identifying the origin.

> Thanks for having been so patient with me

That's entirely okay, Andrew!  Thank *you* very much for taking care of
finding and fixing the bugs, and for thinking about qemu-stable in the
first place - the most important things here.  The rest isn't really
that relevant.  Yes, it'd be nice to have all the proper tags, good
wording in comments etc yadda, - but that all is just cosmetics.
Another very good thing is that we managed to sort it out - you managed,
I'm just a follower here.

As for the backports you did - it isn't necessary for simple changes
like this one.  This is just moving single line from one group of
"case" statements to another, in a particular function.  I've had
plenty of such cases already which I had to apply across various
renames, splits, merges etc, - sure I found 410dfbf620 "Move TCG
specified functions to tcg_cpu.c" (I guess it should've been
"specific" not "specified", but ok), -- especially since you already
mentioned it in the Fixes: tag - and found where this function were
located previously.  Also, when I apply patches to stable branches,
I should keep track of what's applied; and I prefer the commit
messages to be exactly the same as in master - unless the patch
differs significantly..  All that to say - I cherry-picked this
patch (db2325f79 "Avoid recursive PNX exception..") to 10.0 & 10.1
directly, - without using backports you provided, it was easier
this way to keep all the info in place.  So your work providing
the backports wasn't used - which is unfortunate..

Anyway, thank you very much for cooperation, this is excellent!
Such attention from the maintainer is a good driver to continue
maintaining the stable branches!

I re-arranged the patches to include proper Fixes tags in stable
branches, and added the second one.  You can see how it looks like
in the end at https://gitlab.com/mjt0k/qemu - in respective branches.

/mjt


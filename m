Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD7CE77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 23:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVIsi-0005pZ-Sk; Tue, 07 Jan 2025 18:21:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1tVIsg-0005ou-Hv
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 18:21:02 -0500
Received: from dormouse.elm.relay.mailchannels.net ([23.83.212.50])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1tVIse-0004Jp-IQ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 18:21:02 -0500
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 340623237F6;
 Tue,  7 Jan 2025 23:20:58 +0000 (UTC)
Received: from pdx1-sub0-mail-a234.dreamhost.com
 (trex-2.trex.outbound.svc.cluster.local [100.109.23.135])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id A31233223F9;
 Tue,  7 Jan 2025 23:20:57 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1736292057; a=rsa-sha256;
 cv=none;
 b=ERBS0oiVBk2Xb6JwdkcXLRqG1qX7KuXhDocNEsYsb7berQkUcbPhQEH/6D/IXXrC2iiojg
 n13YhgIRcXyjqRNJgF+vRLSOGlB2GLDh9DHwCzZgJAEDZT9Mu+iT0q+2ceo24hdxwL/lWa
 IoyiZ57aUt686Ss1yzBArk/v8lkWv2+XjAraOEZ7+lZX3EHiUdpvpEDvctPUpMTQwXFZ0C
 BWnzfZjAyilMfRzEKyrNEE8KP903zVTMzOLu0efBdgwwutfxgBQWICruWcqQUapamekaJx
 S1BFYVFnQbZG/lIkiX1y8TnZJDzY0I0rZT0e7wAKQsguuA0M0HD2AAOeC3scnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1736292057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=uTPIbz7LB+ULVOPIft/sMzfCsyOKg2ovifBBeDjlNiw=;
 b=avWeJe1ZAgNUlXujgh4KlD7R2WZ+5aACVdB7FOn5J9K4drrXClnT/m0Feo7B03T3COlTsN
 OccRu9HDc7N2tx/JHWy2g5ZZUB5Nw+rsWolwWxrA9Okesoe9rperpKIKuJ+GhanN2PnREV
 SHibX+dxZivQ8LYuDJ82wOODTCJdXxSrihTMkzJhZbHnUjQuAzV1zaIiJHH2S/YfN2VKCD
 gNK5+z0SKtPRldMuWJclrJp0ygIv8w9gMOrkygXSep/7LLktfEHLPM0yABD7E35/deovAG
 8jPU64/bHsomN4RPr5zIkmkRVrXI/f7gl0b41DwYu1gpV7J+BuT04r1XpOPm+A==
ARC-Authentication-Results: i=1; rspamd-7df4dcbd86-4qk5j;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Harbor-Cold: 2435848978ac12b9_1736292057917_4051586479
X-MC-Loop-Signature: 1736292057917:226697232
X-MC-Ingress-Time: 1736292057917
Received: from pdx1-sub0-mail-a234.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.109.23.135 (trex/7.0.2); Tue, 07 Jan 2025 23:20:57 +0000
Received: from [172.16.32.88] (unknown [198.232.126.202])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 (Authenticated sender: rob@landley.net)
 by pdx1-sub0-mail-a234.dreamhost.com (Postfix) with ESMTPSA id 4YSRqr6rBBz8S; 
 Tue,  7 Jan 2025 15:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
 s=dreamhost; t=1736292057;
 bh=wWKlZUyNNVVj1YsXWkNsJDVvt0wHxvoYrtx+2KFO3gk=;
 h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
 b=YR+GRBwk00tVJR+vSRWtil5ZHEyS92qt2LXmA8h5CoIA81O8dhLBi0OFXqI/k11/f
 N9f3ZqRIa/QNMD4OhzxVxoIIXcZFMoJuHtsozN984BO0UzWTz36yw+3i/n5S1BI4Ov
 hRxG8lqeHStDTmF9koToXZCcg2hQlaSs34lHsg/RsgqAA3eSLC4rxL3tjpd1kAvMR/
 lUXv1+mWteYFXvL+0K4b4SIN4ppo8z9PToxWIPn7/vn+s0Ljy5puVD/Aasq9DCKaqc
 wFcRAvIM5suj/M4ZrTS5sy9FSilqS3MdgZpqFnC9lwRyzKC9GWS9GiEQudrKkJ89lj
 jp63iW5vmFgsw==
Message-ID: <e2f1c14c-f5d2-48f3-bb6e-d1db0ce6d1fa@landley.net>
Date: Tue, 7 Jan 2025 17:20:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: or1k -M virt -hda and net.
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stafford Horne <shorne@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Linux OpenRISC <linux-openrisc@vger.kernel.org>
References: <9b2761aa-8ee0-4399-b237-31e70e3ed165@landley.net>
 <Z0Cyx3i3z7Zl7XPm@antec> <31fa6255-8e0c-4d05-bad9-dd843c676244@landley.net>
 <Z0GSETLeT5w8B2DX@antec> <87a6b910-5af6-47ad-ad8d-b79f11a7cbf2@landley.net>
 <Z0LMqEqcdjkAxnN-@antec> <57c5207c-3aca-47cd-bfd3-3d7eb7be3c0f@landley.net>
 <Z2lgL31ZeSkO59MZ@antec> <8807078a-0673-4b27-8d58-4a2a3ce4987d@landley.net>
 <39511711-b86a-4ac6-8bd6-8dab824b693e@landley.net> <Z31k3zNN3pOdGWWK@antec>
 <87y0zmbita.fsf@draig.linaro.org>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <87y0zmbita.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.212.50; envelope-from=rob@landley.net;
 helo=dormouse.elm.relay.mailchannels.net
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

On 1/7/25 12:05, Alex Bennée wrote:
> Stafford Horne <shorne@gmail.com> writes:
>> I have not used -hda before, do you have it working with other targets?
>>
>> According to the qemu docs in qemu-options.hx. I see:
>>
>>      Use file as hard disk 0, 1, 2 or 3 image on the default bus of the
>>      emulated machine (this is for example the IDE bus on most x86 machines,
>>      but it can also be SCSI, virtio or something else on other target
>>      architectures). See also the :ref:`disk images` chapter in the System
>>      Emulation Users Guide.
>>
>> I think, since we don't have a "default" bus in openrisc this doesn't work so we
>> need to specify the -drive explictly.
>>
>> I checked the x86 machine code and confirm it seems to work like this.  There is
>> code in the system setup to look for hd* drives and wire them into IDE.  There
>> is no such code in openrisc.
> 
> Yeah don't use -hdX as they are legacy options with a lot of default
> assumptions. As the docs say: https://qemu.readthedocs.io/en/master/system/invocation.html#hxtool-1
> 
>    The QEMU block device handling options have a long history and have
>    gone through several iterations as the feature set and complexity of
>    the block layer have grown. Many online guides to QEMU often reference
>    older and deprecated options, which can lead to confusion.

I want "a block device from this file" in a generic way that works the 
same across multiple architectures regardless of the board being 
emulated, where I only have to specify the file not explicitly 
micromanage bus plumbing details, and which is easy for a human to type 
from when explained over a voice call.

What's the alternative to -hda you suggest for that?

Can I do "./run-qemu.sh -drive file=blah.img" without the rest? Perhaps 
specify all the details in the script and then optionally add an extra 
argument at the end? I couldn't get that to work:

$ root/or1k/run-qemu.sh -netdev user,id=net0 -device 
virtio-net-device,netdev=net0 -drive format=raw,id=hd0 -device 
virtio-blk-device,drive=hd0 -drive file=README
qemu-system-or1k: -drive format=raw,id=hd0: A block device must be 
specified for "file"

Also, if you say -device and -drive but do NOT specify a file, qemu 
refuses to start. So I can't set the defaults but only optionally use 
them, the way -hda has defaults built into the image that don't cause a 
problem if I DON'T add a -hda argument to the command line.

>    Older options like -hda are essentially macros which expand into -drive
>    options for various drive interfaces.

Where the knowledge of "what this board needs in order to do that" is 
built into qemu rather than provided by the caller, yes.

> The original forms bake in a lot
>    of assumptions from the days when QEMU was emulating a legacy PC, they
>    are not recommended for modern configurations.

I'm building a kernel. It finds /dev/?da so I can mount it. That is my 
desired outcome.

I am attempting to get generic behavior out of multiple architectures, 
among other reasons so I can cross-test and package up "it fails on X, 
here's a build and test" to point package maintainers at.

"It natively builds under the emulator" is the easiest way to make that 
work, which is why https://landley.net/bin/toolchains/latest/ has a 
native.sqf for each cross.tar.xz.

wget system-image-arch.txz
wget toolchain.sqf
wget test.img

./run-emulator.sh -hda test.img -hdb toolchain.sqf

If I have to explain "-drive virtio-potato-walrus,inkpot=striated 
-device collect=striated,burbank-potato,ireland" at somebody whose 
domain expertise is xfce or something, the barrier to getting them to 
reproduce the issue I'm seeing is noticeably higher. If I have to MAKE a 
bespoke wrapper shell script for them with every bug report, the 
likelihood that it works differently for them than when I tried it is 
noticeably nonzero, and the likelihood of the issue going on my todo 
heap and never getting pursued upstream is also noticeably higher. Which 
is why I try to make generic tools...

(Making a _test_ script to demonstrate the issue is normal. If it's 
their project, usually they can tell if I typoed it and fix it up 
themselves because they know what I MEANT. But if I typo the setup for 
the virtual environment, or are missing a prerequisite package install, 
or they hit qemu version skew, or I said /bin/sh and theirs points to 
dash... Brick wall. It either works or it doesn't.)

(And when I have to set up the long version for a nightly cron job, and 
then when the test fails 6 months later and I look at it and go "huh? 
salad?" that's a bad 3am digression as well. And which is more likely to 
break from version skew during qemu version upgrades: two lines of 
micromanaging --longopts or -hda that gets adjusted by the maintainers?)

Rob

P.S. For some reason -hda grew an "I'm going to make the first block 
read-only just like loopback devices do because you can't be trusted" 
nag a few years back, but it's mostly yet more boot spam. I can tell the 
kernel to be quiet during boot, but never figured out the equivalent for 
qemu-system...


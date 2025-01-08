Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DAEE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 14:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVXWe-0008O9-Ee; Wed, 08 Jan 2025 09:59:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVXWd-0008Nr-I1
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 09:59:15 -0500
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVXWY-00051w-S9
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 09:59:13 -0500
Received: by mail-ej1-x641.google.com with SMTP id
 a640c23a62f3a-aab6fa3e20eso2808651066b.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 06:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736348349; x=1736953149; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o4yl5M7j04HVGwyU3KVHNQ62ypgg9hQ+++6O70p3+fs=;
 b=NjhO3JXJZUclew7wHn7SqHsIm2WNRhIC0fsW4XXVLIf9D6Hrv8fbYBWx3uF4NYXhGD
 Mpbmf/r4Fx25vwZUu5h8UkOBtOzJ1NQlMMoFDVDYb3293Q6+xqrtzTzYVNjszzNWzN63
 it84uoJk/VDNycf42N5YYboHye1YuJGdxyJktonGJqHH3Yu1kaOm7KpI03QxvBDeNuwu
 dlVSRvHb73j6bYp957bsv2vtkpDULdN7GJ6eTO2yt81XHASNSqRFLOuA62eFVmBXS/Ju
 7tAi6id76nFA9dJMwRqiMIYz2kFVklYDXjr5MmkRRsULUJBDf8SG9I14lpqgUNCbIyHb
 oACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736348349; x=1736953149;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o4yl5M7j04HVGwyU3KVHNQ62ypgg9hQ+++6O70p3+fs=;
 b=KPeMhbLpKA+8mv2Zdwq6FWAyVYjt0q5uUw/F44x2pGam2zw55tOFruGwJ3I4IEvzD7
 LItzrxtRKYZ1edoRWdr66oycEL62A1yhROZfBLa8s4QpgWF4BFT3wJDwyx9hkvvNZYgS
 ZLc4VlTnznlw20HlgywqRtKswrQgmCGYS/Pce8t15O3ng2LCj2JZWzNS/pEdXbrjE1vn
 ZJ8jYiYCOEFfvsazeG4FDqGwpWg8GSxR75rckNL1VgkQjOjqw/BLGUisdmlgj+JWcMQk
 J2lr8O+//+QU/aoicjOSi+3qC4SeAbcHs9S9u+u6SZNfZqcRraOF5goFMFt7CMZO1YWT
 G3Ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPkDc2M1LhJH6wFGXCXTPR+wMPb9t7paw0ekRI/ZbAxZxt2P5EVAcCNJYXUIIkBPkARUmO8mJIZcKA@nongnu.org
X-Gm-Message-State: AOJu0YzVo/0yOrTfLi0YRiZHJHnIFUQbg7T2qeUHOXb5dkenKO6t+UEP
 5+eP6nQrO9dJVzqprM9e9QKJR+atchaQ9i3Cz+SfbyVXyFaptmkHaeGBAGaS6RM=
X-Gm-Gg: ASbGncuOrY3zoT4KTCflWmCP+wsp5n01kTUwwggb6LIPvm9tcMhjIU3OVtw8mnAOsZc
 m7SNbjlFPmzl0el2F+iscGsdxcGGVD8HgwQ2a5vE4sIowWKDFDzADLzcitQ7j5VIuIBtDj5HQfQ
 YQqxW0ti3qgNmXmWAnmkCCW+eEmv9/29OM/eo+OYsu56gOPPhvKpl1YadeQQCgnF4ql6G6cJbQJ
 1TC39OSYGCinJCR51Rq82NLzEX/BiI8pcUvAo0jGJSqOc2pOjaErik=
X-Google-Smtp-Source: AGHT+IHMX80FhNjkGXpVv7j7y3oqFGJIvGQDPL4Q9BMCi3FKYlAIX4AIY6K85lPBkXJKZNNByPmyig==
X-Received: by 2002:a17:907:9690:b0:aa6:738c:2ddc with SMTP id
 a640c23a62f3a-ab2ab67714amr229325066b.4.1736348348745; 
 Wed, 08 Jan 2025 06:59:08 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0efe467esm2513775966b.104.2025.01.08.06.59.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 06:59:08 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 585645F8AC;
 Wed,  8 Jan 2025 14:59:07 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Rob Landley <rob@landley.net>
Cc: Stafford Horne <shorne@gmail.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  "Jason A. Donenfeld" <Jason@zx2c4.com>,  QEMU
 Developers <qemu-devel@nongnu.org>,  Linux OpenRISC
 <linux-openrisc@vger.kernel.org>
Subject: Re: or1k -M virt -hda and net.
In-Reply-To: <e2f1c14c-f5d2-48f3-bb6e-d1db0ce6d1fa@landley.net> (Rob Landley's
 message of "Tue, 7 Jan 2025 17:20:56 -0600")
References: <9b2761aa-8ee0-4399-b237-31e70e3ed165@landley.net>
 <Z0Cyx3i3z7Zl7XPm@antec>
 <31fa6255-8e0c-4d05-bad9-dd843c676244@landley.net>
 <Z0GSETLeT5w8B2DX@antec>
 <87a6b910-5af6-47ad-ad8d-b79f11a7cbf2@landley.net>
 <Z0LMqEqcdjkAxnN-@antec>
 <57c5207c-3aca-47cd-bfd3-3d7eb7be3c0f@landley.net>
 <Z2lgL31ZeSkO59MZ@antec>
 <8807078a-0673-4b27-8d58-4a2a3ce4987d@landley.net>
 <39511711-b86a-4ac6-8bd6-8dab824b693e@landley.net>
 <Z31k3zNN3pOdGWWK@antec> <87y0zmbita.fsf@draig.linaro.org>
 <e2f1c14c-f5d2-48f3-bb6e-d1db0ce6d1fa@landley.net>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Wed, 08 Jan 2025 14:59:07 +0000
Message-ID: <87msg1bbd0.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x641.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Rob Landley <rob@landley.net> writes:

> On 1/7/25 12:05, Alex Benn=C3=A9e wrote:
>> Stafford Horne <shorne@gmail.com> writes:
>>> I have not used -hda before, do you have it working with other targets?
>>>
>>> According to the qemu docs in qemu-options.hx. I see:
>>>
>>>      Use file as hard disk 0, 1, 2 or 3 image on the default bus of the
>>>      emulated machine (this is for example the IDE bus on most x86 mach=
ines,
>>>      but it can also be SCSI, virtio or something else on other target
>>>      architectures). See also the :ref:`disk images` chapter in the Sys=
tem
>>>      Emulation Users Guide.
>>>
>>> I think, since we don't have a "default" bus in openrisc this doesn't w=
ork so we
>>> need to specify the -drive explictly.

Well if you want a simple drive command you need something. For example
on -M virt for aarch64:

  -drive  driver=3Draw,file.driver=3Dhost_device,file.filename=3D/dev/zen-s=
sd2/trixie-arm64,discard=3Dunmap

only really contains backend options. By default this will attach the
block device to the virtio-pci bus, see virt.c:

  mc->block_default_type =3D IF_VIRTIO;

The backend options might look a bit much, a simpler case with qcow2
would be:

  -drive driver=3Dqcow2,file=3Dtrixie-x86_64.qcow2=20

However if you don't have any default bus for your block devices you
must use -device/-blockdev pairs. It doesn't add much:

 -device virtio-scsi-pci \
 -device scsi-hd,drive=3Dhd \
 -blockdev driver=3Draw,node-name=3Dhd,file.driver=3Dhost_device,file.filen=
ame=3D/dev/zen-ssd2/trixie-arm64,discard=3Dunmap \

So all I've added is the bus, a device and then linked them with the
drive/node-name ids.

>>>
>>> I checked the x86 machine code and confirm it seems to work like this. =
 There is
>>> code in the system setup to look for hd* drives and wire them into IDE.=
  There
>>> is no such code in openrisc.
>> Yeah don't use -hdX as they are legacy options with a lot of default
>> assumptions. As the docs say: https://qemu.readthedocs.io/en/master/syst=
em/invocation.html#hxtool-1
>>    The QEMU block device handling options have a long history and
>> have
>>    gone through several iterations as the feature set and complexity of
>>    the block layer have grown. Many online guides to QEMU often reference
>>    older and deprecated options, which can lead to confusion.
>
> I want "a block device from this file" in a generic way that works the
> same across multiple architectures regardless of the board being
> emulated, where I only have to specify the file not explicitly
> micromanage bus plumbing details, and which is easy for a human to
> type from when explained over a voice call.

You shouldn't need to micro manage bus details, you just need to link
the device to the backend via an id.

> What's the alternative to -hda you suggest for that?
>
> Can I do "./run-qemu.sh -drive file=3Dblah.img" without the rest?
> Perhaps specify all the details in the script and then optionally add
> an extra argument at the end? I couldn't get that to work:
>
> $ root/or1k/run-qemu.sh -netdev user,id=3Dnet0 -device
> virtio-net-device,netdev=3Dnet0 -drive format=3Draw,id=3Dhd0 -device
> virtio-blk-device,drive=3Dhd0 -drive file=3DREADME
> qemu-system-or1k: -drive format=3Draw,id=3Dhd0: A block device must be
> specified for "file"
>
> Also, if you say -device and -drive but do NOT specify a file, qemu
> refuses to start. So I can't set the defaults but only optionally use
> them, the way -hda has defaults built into the image that don't cause
> a problem if I DON'T add a -hda argument to the command line.

device and blockdev pairs are required. -drive attempts to do both in
one command line option.

>>    Older options like -hda are essentially macros which expand into -dri=
ve
>>    options for various drive interfaces.
>
> Where the knowledge of "what this board needs in order to do that" is
> built into qemu rather than provided by the caller, yes.
>
>> The original forms bake in a lot
>>    of assumptions from the days when QEMU was emulating a legacy PC, they
>>    are not recommended for modern configurations.
>
> I'm building a kernel. It finds /dev/?da so I can mount it. That is my
> desired outcome.
>
> I am attempting to get generic behavior out of multiple architectures,
> among other reasons so I can cross-test and package up "it fails on X,
> here's a build and test" to point package maintainers at.

We support a wide variety of boards some with fixed block device buses
and some with the ability to add stuff dynamically. While we certainly
could do better documenting the edge cases (patches welcome ;-) I'm not
sure its possible to come up with a generic command line that works
across all boards. That said any of the VirtIO enabled platforms (often
called virt) will have fairly similar command lines for adding devices
(modulo PCI/MMIO support).

> "It natively builds under the emulator" is the easiest way to make
> that work, which is why https://landley.net/bin/toolchains/latest/ has
> a native.sqf for each cross.tar.xz.
>
> wget system-image-arch.txz
> wget toolchain.sqf
> wget test.img
>
> ./run-emulator.sh -hda test.img -hdb toolchain.sqf
>
> If I have to explain "-drive virtio-potato-walrus,inkpot=3Dstriated
> -device collect=3Dstriated,burbank-potato,ireland" at somebody whose
> domain expertise is xfce or something, the barrier to getting them to
> reproduce the issue I'm seeing is noticeably higher. If I have to MAKE
> a bespoke wrapper shell script for them with every bug report, the
> likelihood that it works differently for them than when I tried it is
> noticeably nonzero, and the likelihood of the issue going on my todo
> heap and never getting pursued upstream is also noticeably higher.
> Which is why I try to make generic tools...

Just put it in a script then.=20

> (Making a _test_ script to demonstrate the issue is normal. If it's
> their project, usually they can tell if I typoed it and fix it up
> themselves because they know what I MEANT. But if I typo the setup for
> the virtual environment, or are missing a prerequisite package
> install, or they hit qemu version skew, or I said /bin/sh and theirs
> points to dash... Brick wall. It either works or it doesn't.)
>
> (And when I have to set up the long version for a nightly cron job,
> and then when the test fails 6 months later and I look at it and go
> "huh? salad?" that's a bad 3am digression as well. And which is more
> likely to break from version skew during qemu version upgrades: two
> lines of micromanaging --longopts or -hda that gets adjusted by the
> maintainers?)

QEMU's command line reputation is not undeserved but it is at least
consistent with the modern composable options. If we can improve the
documentation then let us know:

  https://qemu.readthedocs.io/en/master/system/device-emulation.html

But expanding the use of automagical options is not really a long term
solution.

> Rob
>
> P.S. For some reason -hda grew an "I'm going to make the first block
> read-only just like loopback devices do because you can't be trusted"
> nag a few years back, but it's mostly yet more boot spam. I can tell
> the kernel to be quiet during boot, but never figured out the
> equivalent for qemu-system...

-append passes options to the kernel command line if you are doing a
direct kernel boot or your firmware supports direct kernel booting.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


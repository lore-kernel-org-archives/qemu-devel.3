Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 725E5E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 22:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVedc-0007tP-DR; Wed, 08 Jan 2025 17:34:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1tVedZ-0007sP-6l
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 17:34:53 -0500
Received: from dormouse.elm.relay.mailchannels.net ([23.83.212.50])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1tVedV-0007Ew-0q
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 17:34:51 -0500
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 9885B90237C;
 Wed,  8 Jan 2025 22:34:46 +0000 (UTC)
Received: from pdx1-sub0-mail-a296.dreamhost.com
 (100-109-114-128.trex-nlb.outbound.svc.cluster.local [100.109.114.128])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 2AA5D902DA0;
 Wed,  8 Jan 2025 22:34:46 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1736375686; a=rsa-sha256;
 cv=none;
 b=foD6S157c4hAQ4Ppjm9CxDAtFUUJSy3CInXotH7Yc7TpEAlpGYMB0N9GzKmlIUOetHrEs1
 h6D6uG8vNYEmT04FEvRiLHXvpENZ303xpR3bpcPfIZMrYQS9A9tt3II148mrta0NlY6qmy
 P2lDKRNCYsoZQwEQ46LamGuCDvs9HibeKPTGEsN9uKiKRzQa7P722Twk1B8B+lns+iklnF
 ieAe734sANwIQR5PyRH0tnRnaRyfBDkcYT8Zjbx/u6ERtMiXTdAuEphmHpCT4xcaoENSrp
 Acf7j6QtZ3ZfkXB0ft7BMXfEURx3/NefD+JRMiqZCuzNclMbmzl79Uf+pO7awA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1736375686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=rvV/1rvyLGVvqXQnTDQS9shdK/OSwbl8HeNERXS5uOQ=;
 b=cON3GhBW9n8DyGfhVWPZ0zr1uALu2ohzvtSe3P7VOLpkuvWrCICCv3sclJljxOmSIJ49jU
 3Id6UEzIlN/1+ee6GOe3qbjPrpTw7W4kWjUBhKrTQs5QKzGFP0bYQJmT2qKXxbORZU/TDL
 QGXsKb3eTOEUJzZXQIa775te6qXOzeUNo8bjhnM4OeT59k8XpPHN3+mDAlLA9rJNcyqr8A
 zPtNx3Kpf77IWYVbqvO6DuP1Uz9BhUY5kQ7OeDYS5LfmJOAk3mUrHrZoG1xKEMR7fOyGg1
 fg7AQrUNQM0rDUAtAoIpwn1GRzQ8c2mEklEF00CufWWXMBNwn5vcPD2XWhB/GA==
ARC-Authentication-Results: i=1; rspamd-7df4dcbd86-xxr65;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Glossy-Descriptive: 38035b2c6364d85e_1736375686456_2890440580
X-MC-Loop-Signature: 1736375686456:3270057027
X-MC-Ingress-Time: 1736375686456
Received: from pdx1-sub0-mail-a296.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.109.114.128 (trex/7.0.2); Wed, 08 Jan 2025 22:34:46 +0000
Received: from [172.16.32.88] (unknown [198.232.126.202])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: rob@landley.net)
 by pdx1-sub0-mail-a296.dreamhost.com (Postfix) with ESMTPSA id 4YT2m52VHzz7h; 
 Wed,  8 Jan 2025 14:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
 s=dreamhost; t=1736375686;
 bh=9QCrObfvxOHDC8i+Xhzfgy58KzsBt/ZKup7QFfv4shI=;
 h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
 b=SrkuKBddJJmPb6Fb/qleuSo7l8frTDv4SF7foTUgqWYvYiEuUMrzWdFvkoX6JpaJH
 PtmgHaw0fyNDeStmU5bGGZ91RNrG5SQvsoz/woRL+xkjeAmX49O0wPGAj1wBiOKWVt
 9hw2Uejb63b4UBW2lXL1bw1TOvSgmPf1zfSdTjbZjE96Zw/nn5HwyI6x7rHWpLTUEa
 DF+tKRsez65nwTlikpdhJCrPv3JQdsmcR9TxTXSextQkzHYpc9WcRnK98WjF/JO3T6
 QUfxM1LpFktF4DreJ5Jz6MmsVJ43j6Sll5Tk8cMQJSe+rdS0FF5sib5m0wS0D7/kLa
 96EhqNVCzC4ig==
Message-ID: <fe70397e-671b-4c7e-b73b-bc45cd376b15@landley.net>
Date: Wed, 8 Jan 2025 16:34:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: or1k -M virt -hda and net.
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Stafford Horne <shorne@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
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
 <e2f1c14c-f5d2-48f3-bb6e-d1db0ce6d1fa@landley.net>
 <87msg1bbd0.fsf@draig.linaro.org>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <87msg1bbd0.fsf@draig.linaro.org>
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

On 1/8/25 08:59, Alex Bennée wrote:
> Rob Landley <rob@landley.net> writes:
> 
>> On 1/7/25 12:05, Alex Bennée wrote:
>>> Stafford Horne <shorne@gmail.com> writes:
>>>> I have not used -hda before, do you have it working with other targets?
>>>>
>>>> According to the qemu docs in qemu-options.hx. I see:
>>>>
>>>>       Use file as hard disk 0, 1, 2 or 3 image on the default bus of the
>>>>       emulated machine (this is for example the IDE bus on most x86 machines,
>>>>       but it can also be SCSI, virtio or something else on other target
>>>>       architectures). See also the :ref:`disk images` chapter in the System
>>>>       Emulation Users Guide.
>>>>
>>>> I think, since we don't have a "default" bus in openrisc this doesn't work so we
>>>> need to specify the -drive explictly.
> 
> Well if you want a simple drive command you need something. For example
> on -M virt for aarch64:
> 
>    -drive  driver=raw,file.driver=host_device,file.filename=/dev/zen-ssd2/trixie-arm64,discard=unmap

echo "We've replaced the dilithium they normally use with Folger's 
Crystals." > file.img
qemu-system-aarch64 -M virt -cpu cortex-a57 -m 256 -nographic \
   -no-reboot -kernel linux-kernel -initrd initramfs.cpio.gz \
   -append "HOST=aarch64 console=ttyAMA0" -hda README
...
Type exit when done.
$ cat /dev/vda
We've replaced the dilithium they normally use with Folger's Crystals.
$ exit
reboot: Restarting system

Seems like a sane default is already there. (And on most other boards.)

I also note that 90% of the above qemu invocation is the same for all 
targets. My build system's entire configuration for the m68k 
architecture is just:

>   elif [ "$CROSS" == m68k ]; then
>     QEMU_M=q800 KARCH=m68k
>     KCONF="$(be2csv MMU M68040 M68KFPU_EMU MAC BLK_DEV_SD MACINTOSH_DRIVERS \
>       NET_VENDOR_NATSEMI MACSONIC SCSI{,_LOWLEVEL,_MAC_ESP} \
>       SERIAL_PMACZILOG{,_TTYS,_CONSOLE})"

And here's the or1k target under discussion:

>   elif [ "$CROSS" == or1k ]; then
>     KARCH=openrisc QEMU_M=virt KARGS=ttyS0
>     KCONF="$(be2csv ETHOC SERIO SERIAL_OF_PLATFORM SERIAL_8250{,_CONSOLE} \
>       VIRTIO_{MENU,NET,BLK,PCI,MMIO} POWER_RESET{,_SYSCON{,_POWEROFF}} SYSCON_REBOOT_MODE)"

There are some targets I have to poke harder, armv5l and armv4tl have
"qemu-system-arm -M versatilepb -net nic,model=rtl8139 -net user" for 
some reason... Huh, apparently I've been doing that since 2007?

https://github.com/landley/aboriginal/commit/5a51e551568a

Why did I do that... https://landley.net/notes-2007.html#04-07-2007 says 
"switch to using the rtl8139 driver because PIO doesn't work on
the qemu-system-arm PCI controller yet so I need something with mmio." 
Maybe that's fixed by now and I can go back to the default network card 
there? Hmmm, hw/arm/versatilepb.c says the default is smc91c111, the 
kernel driver for that is CONFIG_SMC91X... which needs GPIOLIB for some 
reason (why is that a depends not a selects?) And yes, the board's 
default network card works if I flip on the right driver and remove the 
--micromanagement.

Ok, fixed: https://github.com/landley/toybox/commit/65887c2f3cd8

But the point was it _can_ do that. Just seldom needs to. I was asking 
for a "that" prefix which let me use -hda on or1k (and still worked when 
I didn't supply one). I don't mind supplementing or overriding an 
unworkable default in the wrapper script, I've done it before. But what 
I was asking for was something to make -hda work when $@ expanded to it.

> only really contains backend options. By default this will attach the
> block device to the virtio-pci bus, see virt.c:
> 
>    mc->block_default_type = IF_VIRTIO;
> 
> The backend options might look a bit much, a simpler case with qcow2
> would be:
> 
>    -drive driver=qcow2,file=trixie-x86_64.qcow2

A raw block device can be loopback mounted on the host and mounted 
within qemu in the same way. (Qemu doesn't even mind if they're sparse, 
although loopback still did last I checked.)

The block device isn't even always a filesystem, sometimes it's a 
tarball. And when it is a filesystem, half the time it's squashfs. Why 
wrap it in a ubifs-style block remapping layer? Extra step, more tools, 
can't look at the data in hexedit (which comes up)... It may be nice to 
have a more complicated option, but "raw image" is the generic version.

> However if you don't have any default bus for your block devices you
> must use -device/-blockdev pairs. It doesn't add much:
> 
>   -device virtio-scsi-pci \
>   -device scsi-hd,drive=hd \
>   -blockdev driver=raw,node-name=hd,file.driver=host_device,file.filename=/dev/zen-ssd2/trixie-arm64,discard=unmap \

Where "you don't" means "the board doesn't"? So the user of the board 
has to manually tell the board emulation what bus type it has available? 
(And guess right, because I can't add arbitrary types, the board will 
only ACCEPT certain ones...)

> So all I've added is the bus, a device and then linked them with the
> drive/node-name ids.

With hda I'm saying "here's the filename for your block device", and I'm 
usually externally supplying it to an existing board setup. When 
comparing the m68k behavior with the arm behavior of the same piece of 
software, I don't need to tell each system how to be itself. (It already 
knows.)

With your suggested API, specifying the filename as its own argument 
separate from the rest doesn't seem to have occurred to the designers.

If I don't provide an -hda then there isn't one. Cleanly drops out. If I 
specify -device without a filename, qemu tends to get upset and refuse 
to start.

You jumped into the thread to encouraging a move from -hda to -drive. In 
what way is -drive the superior option from a user perspective?

>>>> I checked the x86 machine code and confirm it seems to work like this.  There is
>>>> code in the system setup to look for hd* drives and wire them into IDE.  There
>>>> is no such code in openrisc.
>>> Yeah don't use -hdX as they are legacy options with a lot of default
>>> assumptions. As the docs say: https://qemu.readthedocs.io/en/master/system/invocation.html#hxtool-1
>>>     The QEMU block device handling options have a long history and
>>> have
>>>     gone through several iterations as the feature set and complexity of
>>>     the block layer have grown. Many online guides to QEMU often reference
>>>     older and deprecated options, which can lead to confusion.
>>
>> I want "a block device from this file" in a generic way that works the
>> same across multiple architectures regardless of the board being
>> emulated, where I only have to specify the file not explicitly
>> micromanage bus plumbing details, and which is easy for a human to
>> type from when explained over a voice call.
> 
> You shouldn't need to micro manage bus details, you just need to link
> the device to the backend via an id.

By "shouldn't need to micro manage the bus details", are you saying I 
can link the device to the backend without ever having manually 
specified the bus type on the command line?

Inside the VM, my init script does something like:

   [ -e /dev/?da ] && mount /dev/?da /mnt
   [ -x /mnt/init ] && exec /mnt/init

So it doesn't care if it's sda or vda and "just works" as long as the 
device shows up in /dev. And it just works if it's _not_ there either. 
(And used to work with /dev/hda before they made everything pretend to 
be scsi.)

To trigger it, I go "./run-qemu.sh -hda filename.img" because my run 
script has "$@" in the qemu command line, so I don't need to know how it 
will be used. (This isn't the ONLY thing they can add, another common 
thing is to set up port forwarding so a server in the emulator can 
appear on a host loopback port.) It's a generic tool like a hammer. It 
works the same whether ./run-qemu.sh is in the m68k directory, sh4eb, 
powerpc, etc.

>> What's the alternative to -hda you suggest for that?
>>
>> Can I do "./run-qemu.sh -drive file=blah.img" without the rest?
>> Perhaps specify all the details in the script and then optionally add
>> an extra argument at the end? I couldn't get that to work:
>>
>> $ root/or1k/run-qemu.sh -netdev user,id=net0 -device
>> virtio-net-device,netdev=net0 -drive format=raw,id=hd0 -device
>> virtio-blk-device,drive=hd0 -drive file=README
>> qemu-system-or1k: -drive format=raw,id=hd0: A block device must be
>> specified for "file"
>>
>> Also, if you say -device and -drive but do NOT specify a file, qemu
>> refuses to start. So I can't set the defaults but only optionally use
>> them, the way -hda has defaults built into the image that don't cause
>> a problem if I DON'T add a -hda argument to the command line.
> 
> device and blockdev pairs are required.

Required when -hda doesn't work.

> -drive attempts to do both in one command line option

If I can -drive setup,setup,setup and then -hda filename.img (or not) 
later, then the details can get hidden in run-qemu.sh, which is what I 
was asking how to do earlier in this thread.

Or does -drive still require I know what filename to attach, and whether 
or not to do it? So if I wanted to support -hda command.sqf -hdb 
workspace.ext3 -hdc toolchain.iso that got intercepted and turned into
-drive by a shell script I would need... I dunno, some sort of loop?

Do you want my wrapper script to include a regex to notice one of its 
arguments was "-hda", find the argument after that and convert it into a 
-drive line, with error handling for "there wasn't another argument" or 
, and = in the filename? Plus it needs to know -hdb and -hdc and -hdd as 
well to keep parity with what was previously there...

Or do you want the users to have to externally specify the -drive line 
to the script, with target-specific bus type they didn't need to know 
before in order to attach a disk to a VM?

Which of these is the improvement that makes a move from -hda to -drive 
better for the user?

>> I am attempting to get generic behavior out of multiple architectures,
>> among other reasons so I can cross-test and package up "it fails on X,
>> here's a build and test" to point package maintainers at.
> 
> We support a wide variety of boards some with fixed block device buses
> and some with the ability to add stuff dynamically. While we certainly
> could do better documenting the edge cases (patches welcome ;-) I'm not
> sure its possible to come up with a generic command line that works
> across all boards.

I have one already. The qemu devs deprecated it for some reason, and 
made it spit warnings and break fdisk when using "raw" images. (If you 
can wipe everything _except_ the first few blocks, what exactly have you 
improved? Never understood that part...)

> That said any of the VirtIO enabled platforms (often
> called virt) will have fairly similar command lines for adding devices
> (modulo PCI/MMIO support).

The test I ran upthread said that aarch64, armv7l, riscv32, riscv64, and 
s390x were all using /dev/vda for -hda.

And armv4l, armv5l, i486, i686, m68k, mips, mips64, mipsel, powerpc, 
powerpc64, powerpc64le, sh4, sh4eb, and x86_64 weren't.

And the caller didn't need to know the difference.

>> If I have to explain "-drive virtio-potato-walrus,inkpot=striated
>> -device collect=striated,burbank-potato,ireland" at somebody whose
>> domain expertise is xfce or something, the barrier to getting them to
>> reproduce the issue I'm seeing is noticeably higher. If I have to MAKE
>> a bespoke wrapper shell script for them with every bug report, the
>> likelihood that it works differently for them than when I tried it is
>> noticeably nonzero, and the likelihood of the issue going on my todo
>> heap and never getting pursued upstream is also noticeably higher.
>> Which is why I try to make generic tools...
> 
> Just put it in a script then.

Which is why my question upthread was if there was a way to use the 
micromanaging --longopts to tell qemu what plumbing -hda (and -hdb, etc) 
should attach to, without actually requiring there to _be_ one.

The answer seems to be "no, it needs a patch and rebuild".

If I have to agglutinate a supplied filename into a -drive 
thing,thing,thing list, how do you suggest I do that without #!/bin/bash 
having to be present because I wrote shell plumbing to make elaborate 
command line option parsing decisions that were never tested on "fish" 
or "zsh" or "dash" or busybox ash or...

Keep in mind the current shell plumbing is literally "$@" from posix.

>> (And when I have to set up the long version for a nightly cron job,
>> and then when the test fails 6 months later and I look at it and go
>> "huh? salad?" that's a bad 3am digression as well. And which is more
>> likely to break from version skew during qemu version upgrades: two
>> lines of micromanaging --longopts or -hda that gets adjusted by the
>> maintainers?)
> 
> QEMU's command line reputation is not undeserved but it is at least
> consistent with the modern composable options. If we can improve the
> documentation then let us know:
> 
>    https://qemu.readthedocs.io/en/master/system/device-emulation.html
> 
> But expanding the use of automagical options is not really a long term
> solution.

Do you plan to replace "-m 256" with a longopt that requires you to 
specify the physical address range of the new memory using multiple 
name=value comma separated arguments?

Or is "-m 256" a useful control knob indicating a thing a user wants to 
have happen without needing to know all the board-specific 
implementation details to invoke it?

>> Rob
>>
>> P.S. For some reason -hda grew an "I'm going to make the first block
>> read-only just like loopback devices do because you can't be trusted"
>> nag a few years back, but it's mostly yet more boot spam. I can tell
>> the kernel to be quiet during boot, but never figured out the
>> equivalent for qemu-system...
> 
> -append passes options to the kernel command line if you are doing a
> direct kernel boot or your firmware supports direct kernel booting.

I asked why append doesn't 8 years ago:

https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg03127.html

I'm not sure how your response relates to "-hda complains about raw 
images". The commit in question that broke it (38f3ef574b48) preserved 
the probe for image types, instead of having -hda just default to "raw" 
always, and requiring the --longopt version to specify the types. That's 
the part I never understood, THAT seemed a really weird decision. "The 
qcow image format is insecure, because qcow can always #include 
arbitrary external files so if you run qemu as root it can read 
/etc/shadow which is apparently a thing people do". There is indeed a 
problem, but it's not raw?

For that matter, why not do what qemu did for:

-m [size=]megs[,slots=n,maxmem=size]

You _can_ have a short option do a sane thing by default but add 
_optional_ compostable csv nonsense to it, where "in order to use an 
image file with an = or , in it you need -hda name=thing,thing and name= 
will always eat the rest of its argument", possibly with an informative 
error message when -hda file,name or -hda file=name doesn't understand 
what it was given.

The UI decisions here struck me as very strange, and deprecating the way 
-hda has worked since 2005 seemed odd to me. (Possibly earlier but 
https://landley.net/notes-2005.html#02-12-2005 is when I first got an 
-hda of a partitioned disk image with LILO installed on it to boot under 
qemu. That was before even aboriginal linux, that was 
https://landley.net/aboriginal/old/ and most of the progress reports 
about _that_ were on livejournal. I switched from User Mode Linux _to_ 
qemu.)

Rob


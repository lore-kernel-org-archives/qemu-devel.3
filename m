Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0ADFE6ADD5
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2024 08:29:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tElV1-00054b-6p; Sat, 23 Nov 2024 03:28:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1tElUx-000549-1h
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 03:28:11 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1tElUu-0004pP-PA
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 03:28:10 -0500
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-431688d5127so24003895e9.0
 for <qemu-devel@nongnu.org>; Sat, 23 Nov 2024 00:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732350487; x=1732955287; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tdYKfDoQ9875GdY/cyfgCfE6f1yYUBQqCM8T5x1EV08=;
 b=AcBMLLTJV/dhiN24C/8h0EbZCa7x3XIOMFHsMlsRxOTy6ffUqperc9tpjcEIfpSpFO
 5WAF0IgIciUzZ5JcJcKN0qT34y3kCIlDtYme7ptH9X7WBGfn7vf7RPciWEuOIPTBtxf4
 0FddouLc64dP2+F/wQR4V5xnjSW+NWE8HsIHmQVqjmlrinIRyNd+y+TRfcpT5TTsCZ49
 npyuyhqOMHC8fRDEOIvADo+cwUqRGWdnaAj0EzQ4OYLxJ9akc/r5EVSIqwcJpc2XyTSb
 LWg6ehHyMNUkUe7lO7stcZQNnq41KisXSETKFV3p55zSgcvoTciI4XM6+vxh6VJtyS0P
 7h0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732350487; x=1732955287;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tdYKfDoQ9875GdY/cyfgCfE6f1yYUBQqCM8T5x1EV08=;
 b=V3q0oqdoanOMTjX66NFr5AFSLOZCmolFNWBcGN8QOhal9OFBQpx6CfWzssdhV9kRlq
 p5jvMUUpOMW0B+WlH1yTeQvdu3eEowQTNRBl0DGBX4zpVg5OZn7HxpHwJKNxjHE0ltqq
 75iEMhRoLZJJZIxA7vhB9uPNfls0Nfxo4pAWSdMKmuuGEGVzrAWvWJfJ2+XDhQIAusYV
 YaVKz2xx85dcjAt9OWH27wH9olI+PDajLJrTA1Rg6hP2bzMUG5ysYFRK1n/pE5pj1V7H
 VADEbkAP1x/0Q6VXgdYtZ8ylMacGOnYkCGdpYXKAhHBXhbUMlrdD51DL9qdFjU/+Ea9f
 fmZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWy+WIlbFh32myacAd8Kon2RPEYtIjAb8D66Q2TeYFjjbdxG3aeE5ABbG3RxDHHlbuJ8mpFEjS1q1pE@nongnu.org
X-Gm-Message-State: AOJu0YzrjPIP9mr30GZH7cw6s3l/vaMTolCWhfgBm6KNdAMej06m0few
 8pDAgUNHUcEf72hGXnaTfJXvQvHw/QK152gBVy2MZ4M4sJb5nnK0
X-Gm-Gg: ASbGncuB3qMYZNIN7oWuNMXO/jmFkyxg1lMlXHjhX/GEGrUZaQBpF1BYrc60qZAXPeB
 ZgGqT+PzPDJivDrHqLqkPqfOFjSuhgcLmfgDZZScsZNp8YSOzYusTAxipkYGxdTHwOjOZVg50ce
 365LDW4bY1RwftRi7TCG2IU8G0COrUBYrBYBq9gQjkPxW0HxmTv4WZo/5fOYOa62/UInTGlKPHD
 tBgVjTmpaoVGCRwY1KZRGBg0uxirM3q3vpdjRkYVydTm6gxU/xMMcQ5a6gTnZhZzwQa/IW/sbgR
 KNQNisOP4fqYGA==
X-Google-Smtp-Source: AGHT+IEuYDMvxshg4lYJoS3kME4mshwql8KbJTa8z82Y+9HmDIm3efEDm+i9y01etczGIzfIvAxPgQ==
X-Received: by 2002:a05:6000:154b:b0:382:5295:b33c with SMTP id
 ffacd0b85a97d-38260be4135mr4538246f8f.58.1732350484979; 
 Sat, 23 Nov 2024 00:28:04 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net.
 [86.9.131.95]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbc4173sm4737449f8f.72.2024.11.23.00.28.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Nov 2024 00:28:03 -0800 (PST)
Date: Sat, 23 Nov 2024 08:28:01 +0000
From: Stafford Horne <shorne@gmail.com>
To: Rob Landley <rob@landley.net>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: QEMU commit 0a923be2f642 broke my or1k image.
Message-ID: <Z0GSETLeT5w8B2DX@antec>
References: <afac091f-08cb-0f6d-4c01-bfa4421e7a47@landley.net>
 <Zufcf4iAqosZ7VBf@antec>
 <9b2761aa-8ee0-4399-b237-31e70e3ed165@landley.net>
 <Z0Cyx3i3z7Zl7XPm@antec>
 <31fa6255-8e0c-4d05-bad9-dd843c676244@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31fa6255-8e0c-4d05-bad9-dd843c676244@landley.net>
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=shorne@gmail.com; helo=mail-wm1-x344.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri, Nov 22, 2024 at 06:54:21PM -0600, Rob Landley wrote:
> On 11/22/24 10:35, Stafford Horne wrote:
> > > I just regression tested linux-6.12 against qemu-9.2.0-rc1 and I'm still
> > > getting no output from or1k, with the current image or the old or1k release
> > > image that worked under old qemu versions.
> > > 
> > > I tried applying your serial patch to current qemu, and it made no
> > > difference: still no output booting the image.
> > 
> > OK, I am trying to get that patch pushed upstream.  I will be sure we fix your
> > issues before we do that.
> 
> Thanks. Let me know how/if I can help.
> 
> > > Alas I can no longer test that reverting the commit I identified (git show
> > > $HASH | patch -p1 -r) makes it work again in current qemu (although it did
> > > at one point, that's a standard sanity check at the end of bisect for me),
> > > and I can't fix it up by hand either because hw/openrisc/openrisc_sim.c no
> > > longer contains the string "load_sim", looks like it got collated with
> > > common code for other architectures.
> > > 
> > > I'm happy to tweak the kernel config if qemu changed in a way that broke
> > > compatibility with old images (I assume _you_ have a kernel that boots), but
> > > I was hoping "this week's kernel release" would have any necessary patches
> > > to work with QEMU's changed ABI.
> > 
> > The patch I have put in 6.12 only helps with earlycon.  Regular output has
> > always been working for me.  I will work on testing your image again to see what
> > is special about it.
> 
> Just a guess, but given the alignment change, I suspect it's barfing on the
> statically linked initramfs? That seems the most likely step to go off the
> rails given the failing patch is a symbol alignment change in the flattened
> device tree plumbing, and I think the initramfs extractor parses device
> trees very early on to find stuff (I forget why). Moving "where the data
> lives" without a corresponding change to the "where to look for the data"
> code seems a bit strange, but it's not my area...

OK, and the broken earlycon may be masking what is going on, as we should at
least see some console output before things fail.  The earlcon fix is in 6.13
not 6.12.

I was able to test your or1k.tgz image and figure out what is wrong.  Your
run-qemu.sh script has 'console=FIXME'.  This command line argument is taken in
and is causing the boot process to not be able to find the console.

Changing it to 'console=ttyS0' allows me to see the output.

I put a branch with the qemu patches I have here:

  - https://github.com/stffrdhrn/qemu/tree/or1k-9.2.0-fixes-1

> Here's the miniconfig I built 6.12 with (90% of which is generic to all the
> architectures I'm testing, the sections are labeled. The console="FIXME" bit
> is because I can't get qemu-system-or1k -append "blah" to go through to
> linux, so I stuck FIXME in that field for the or1k target and it wound up in
> the output):

The kernel command line is injected by qemu into the qemu generated
devicetree.  I notice when I boot your kernel with the reverted FDT alignment
fix the console prints:

    Kernel command line: earlycon

This means that the qemu devicetree is not being used, hence the command line
args are not working.  The qemu device tree not being used is not good, but that
is why reverting the alignment fix 'seems' to fix the issue.  To me the revert
looks to be breaking the qemu devicetree allowing us to fall back to the kernel
supplied devicetree.

This gave me a clue as to what was going on.

> # make ARCH=openrisc allnoconfig KCONFIG_ALLCONFIG=linux-miniconfig
> # make ARCH=openrisc -j $(nproc)
> # boot vmlinux console=FIXME
> 
> # architecture independent
> CONFIG_PANIC_TIMEOUT=1
> CONFIG_NO_HZ=y
> CONFIG_HIGH_RES_TIMERS=y
> CONFIG_RD_GZIP=y
> CONFIG_BINFMT_ELF=y
> CONFIG_BINFMT_SCRIPT=y
> CONFIG_BLK_DEV=y
> CONFIG_BLK_DEV_INITRD=y
> CONFIG_BLK_DEV_LOOP=y
> CONFIG_EXT4_FS=y
> CONFIG_EXT4_USE_FOR_EXT2=y
> CONFIG_VFAT_FS=y
> CONFIG_FAT_DEFAULT_UTF8=y
> CONFIG_MISC_FILESYSTEMS=y
> CONFIG_NLS_CODEPAGE_437=y
> CONFIG_NLS_ISO8859_1=y
> CONFIG_SQUASHFS=y
> CONFIG_SQUASHFS_XATTR=y
> CONFIG_SQUASHFS_ZLIB=y
> CONFIG_TMPFS=y
> CONFIG_TMPFS_POSIX_ACL=y
> CONFIG_DEVTMPFS=y
> CONFIG_DEVTMPFS_MOUNT=y
> CONFIG_NET=y
> CONFIG_NETDEVICES=y
> CONFIG_NET_CORE=y
> CONFIG_NETCONSOLE=y
> CONFIG_PACKET=y
> CONFIG_UNIX=y
> CONFIG_INET=y
> CONFIG_IPV6=y
> CONFIG_ETHERNET=y
> CONFIG_COMPAT_32BIT_TIME=y
> CONFIG_EARLY_PRINTK=y
> CONFIG_IKCONFIG=y
> CONFIG_IKCONFIG_PROC=y
> 
> # architecture specific
> CONFIG_ETHOC=y
> CONFIG_SERIO=y
> CONFIG_SERIAL_OF_PLATFORM=y
> CONFIG_SERIAL_8250=y
> CONFIG_SERIAL_8250_CONSOLE=y
> CONFIG_OPENRISC_BUILTIN_DTB="or1ksim"
> 
> # architecture extra
> CONFIG_INITRAMFS_SOURCE="../../root/or1k/fs"
> 
> And then run-qemu.sh is just:
> 
> DIR="$(dirname $0)"; qemu-system-or1k -M or1k-sim -m 256 "$@" -nographic
> -no-reboot -kernel "$DIR"/linux-kernel -append "HOST=or1k console=FIXME
> $KARGS"
> echo -e '\e[?7h'
> 
> (The echo is because some qemu bioses disable wordwrap in the terminal and
> leave it broken, driving bash cursor-up history nuts. My plumbing just
> sticks a reset in all the architectures' scripts...)
> 
> The or1k support in mkroot is the 4 lines at:
> 
>   https://github.com/landley/toybox/blob/master/mkroot/mkroot.sh#L256
> 
> (I'd cut and paste them here but thunderbird wordwraps everything.)
> 
> Also, looking at that, I'm using a builtin DTB and you might be passing one
> in via -dtb? Another thing the alignment change might break...

Thanks for the steps.  I was just using the or1k.tgz you provided earlier.  The
above will help if I want to try some kernel fixes on my own.

> > Note, I did find some issues with the kernel nor properly handling stdout-path.
> > It seems that if there are multiple uarts the first one will always be used as
> > the default uart.  Only the console= command line argument can be used to
> > override that.
> 
> I've never managed to get console= to go through to linux in
> qemu-system-or1k. The above tries but is ignored.

As I mentioned above this is a good clue and explains why the alignment "fix"
fixes your issue.

> It's also doing a statically linked initramfs because -initrd didn't work on
> this target. Happy to update if it's been fixed, the other targets are
> almost all using -initrd to feed in an external cpio.gz

Using -initrd should work.  But also using the statically linked initramfs
should be fine too.  The setup I use for testing uses virt with a virtio block
driver.

When using qemu with -initrd qemu will back the kernel, initrd and fdt one after
the other into memory as per.

[ kernel ] - Loads from 0x100 (based on elf layout)
[ initrd ] - page aligned
[  fdt   ] - page aligned devicetree (revert moved to 4 bytes aligned)

The fdt address gets placed into r3 which the kernel uses to find the qemu FDT.
Finding the FDT one of the first steps of the boot processes.

> > So as long as the kernel selects the first uart as the stdout path (it should
> > have always been the case)  AND qemu picks the first uart as the uart connected
> > to the console (it should be with my latest patch) we should get serial output.
> 
> The commit in question is not changing UART configuration. It's changing the
> alignment of a symbol. Your patch to the UART plumbing did not fix it. I
> don't see how the UART configuration could have changed between the
> "working" and "not working" states.

As mentioned, it's causing us to switch off access to the QEMU supplied
FDT which is allowing the uart to work.

If you provide command line args console=ttyS0 things will work.

Also console=ttyS0 is not used as all as it should be the default in QEMU.

> > Another thing that may get me delayed is that I need to rebuild my or1k-elf-gdb
> > as it's python version is no longer compatible with the kernel's python.
> 
> Yeah, Python 3's forced upgrade treadmill is deeply silly. I'm not a fan:
> https://landley.net/notes-2024.html#09-04-2024
> 
> (I know they're doing it to make sure they never have another "our userbase
> refuses to move off 2.0 for a full decade" moment by holding tightly to the
> control they wrested away from their users and never giving an inch back now
> they've forced the issue, by making sure their code spoils like milk and the
> installed base is regularly slashed and burned, but for me that just means
> "use lua" or something. Yes your dev team had trauma. So did the perl guys,
> who eventually gave UP forcing their transition down an unwilling userbase's
> throat... But again, not my area.)

It looks like I didnt need this to solve the issue.  But I will need it soon.
sigh.

It looks like the root cause of the issue was the 'console=FIXME'.

I hope it helps.

-Stafford


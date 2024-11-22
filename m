Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 455F6E69182
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 16:36:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEWcv-0001Qr-M2; Fri, 22 Nov 2024 11:35:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1tEWcu-0001Qj-W5
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 11:35:25 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1tEWct-0005oI-4d
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 11:35:24 -0500
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-3825a721ae5so1244182f8f.1
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 08:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732293321; x=1732898121; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dol8uvqp9j6AoZwv3OIjidk1Mz4UVwABRHAlp+oY/D0=;
 b=X66EfNxSd59P/6G0sqze7LX8BcoMcKpUy5i4MMmxQ1J0EJHrXCNYExRqfKN7N0qnhh
 9aqriHTTu2kbgl5MskwCaN5m917A7A+XnpA4LOED/UwGhICdftNdzNOeavl/X7uMKl9X
 7ZesZjKunRYpuqJ+zGcqPV+Bry+4aqTgU1/q6/ybMf3oT5IxenXtVKMBPl+Dro75C5mt
 8HSzZxvsfPbUkv4UjMr5wbGjolv6grIkUNncYeSBZNwRNynR7CxKgHYuRCEUcDZRTzMH
 2XtJZMRgFFXQFNEi+vUV7qMkPhiZ832eIVRbnyGKmJqGvV4inwATW3NFpoDIg/tYbQEV
 DLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732293321; x=1732898121;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dol8uvqp9j6AoZwv3OIjidk1Mz4UVwABRHAlp+oY/D0=;
 b=RCwR3fvRM6lR+DuuWWgSgtUzR5EUJOfsrTyt7KPJBJ4PY0FjrUfzAV8JkyxhZ+H/He
 3naKitE2kCFFL6N1jZF3737BV95XDDVwn/MN/D0BTfGhqEz4tX/mZkxAnPu86hiuJM59
 lFVBd01dPF4aFbu+boEqenJzRN/7dbDNGKERRreY1LptveR4MSf+x0nfxSIcG51GcjnZ
 U4hFnciYLJjVy+FhGXkGgeQhb1OsLPBEDdCmTShKEt6Yge2RO4nazLx3Ke/bFLKmFynd
 G6pwlMwb+QDBjUgIUBPizOF7bRWnvqUzNXCHAxgIVHEcbEVBIkz5TAEfX4CvpIGIWKbH
 yqEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXpZO2KcHN668bu7YtrDsEech9u1ytO82tU9y3qaqHM5o27rRSmxkyn461ABaEdnofHfqYdNFqrtt6@nongnu.org
X-Gm-Message-State: AOJu0Yz6jVa/6hw8y5DANQ6eeFzhVa2lN2bUSq7TLZe4RtiHetp2rsF5
 YNvTwc1Wo8LJq01sQW8r3y6AzCb6b5kGNCzODSxa5+FRIzXciO2TPYJ2MI+K
X-Gm-Gg: ASbGncsaFrGX33kHsUdnWrbl+SlF3eeZfrH5qxIse62xrYyLh6TyrbtzoN7Bu0KmfGS
 hWbM/u0CTovW/33AYNFCUZI7ubEtCgQiLvwvw+cc4DSikpDqF/TboPR66VjnxXwBUJpxiE7MqTG
 2G0OXecXZG+wGgb8hRmzS+Tr5CBWDgMmLDEYMmx6AfSQ7qT6DU6ci/iXDLvsLEPfuK+4Py0GNzk
 0A0+MEFmgtsziwmx6sl6M9woLelrCatyYQ8P3u4Ji5qx/GwOkml0enO/apJT68IRg8NVW/JH6oC
 J4tdoDfyOROF1A==
X-Google-Smtp-Source: AGHT+IG5FVroKsAHosJGeQL/hQVSeRsFz/bTucJL1fbBsdhUHIDeIwovhpyhi+j2HwS7wJpexFGY0Q==
X-Received: by 2002:a5d:6d03:0:b0:382:22d6:988c with SMTP id
 ffacd0b85a97d-3826011336cmr3457579f8f.5.1732293320685; 
 Fri, 22 Nov 2024 08:35:20 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net.
 [86.9.131.95]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fb537d4sm2816189f8f.61.2024.11.22.08.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2024 08:35:19 -0800 (PST)
Date: Fri, 22 Nov 2024 16:35:19 +0000
From: Stafford Horne <shorne@gmail.com>
To: Rob Landley <rob@landley.net>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: QEMU commit 0a923be2f642 broke my or1k image.
Message-ID: <Z0Cyx3i3z7Zl7XPm@antec>
References: <afac091f-08cb-0f6d-4c01-bfa4421e7a47@landley.net>
 <Zufcf4iAqosZ7VBf@antec>
 <9b2761aa-8ee0-4399-b237-31e70e3ed165@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b2761aa-8ee0-4399-b237-31e70e3ed165@landley.net>
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=shorne@gmail.com; helo=mail-wr1-x442.google.com
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

On Thu, Nov 21, 2024 at 04:32:25PM -0600, Rob Landley wrote:
> On 9/16/24 02:21, Stafford Horne wrote:
> > On Wed, Sep 11, 2024 at 12:42:58AM -0500, Rob Landley wrote:
> > > Grab this tarball, extract it, and ./run-qemu.sh. It's a simple
> > > linux+initramfs image that boots to a shell prompt.
> > > 
> > >    https://landley.net/bin/mkroot/latest/or1k.tgz
> > > 
> > > QEMU 7.0.0 ran that linux-or1k image, but newer qemu does not. I besected the
> > > issue to qemu commit 0a923be2f642, and it's still broken in current tip of tree.
> > 
> > Patch is:
> > 
> >   0a923be2f6 ("hw/openrisc: page-align FDT address")
> > 
> > > Rebuilding the image with current linux-git doesn't seem to make a difference?
> > > Either way I get serial output with old qemu and don't with current qemu.
> > 
> > The bisect looks strange as it's only moving a page boundary, it could be
> > correct but it seems harmeless.  There is another commit close by that was
> > causing issues with serial output for the barebox guys and this is a patch I am
> > working on to fix it.
> > 
> > https://lore.kernel.org/qemu-devel/20240908062756.70514-1-shorne@gmail.com/
> > 
> > I will try to get time today to look at your tarball and run it, but if not have
> > a look at this patch.
> 
> I just regression tested linux-6.12 against qemu-9.2.0-rc1 and I'm still
> getting no output from or1k, with the current image or the old or1k release
> image that worked under old qemu versions.
> 
> I tried applying your serial patch to current qemu, and it made no
> difference: still no output booting the image.

OK, I am trying to get that patch pushed upstream.  I will be sure we fix your
issues before we do that.

> Alas I can no longer test that reverting the commit I identified (git show
> $HASH | patch -p1 -r) makes it work again in current qemu (although it did
> at one point, that's a standard sanity check at the end of bisect for me),
> and I can't fix it up by hand either because hw/openrisc/openrisc_sim.c no
> longer contains the string "load_sim", looks like it got collated with
> common code for other architectures.
> 
> I'm happy to tweak the kernel config if qemu changed in a way that broke
> compatibility with old images (I assume _you_ have a kernel that boots), but
> I was hoping "this week's kernel release" would have any necessary patches
> to work with QEMU's changed ABI.

The patch I have put in 6.12 only helps with earlycon.  Regular output has
always been working for me.  I will work on testing your image again to see what
is special about it.

Note, I did find some issues with the kernel nor properly handling stdout-path.
It seems that if there are multiple uarts the first one will always be used as
the default uart.  Only the console= command line argument can be used to
override that.

So as long as the kernel selects the first uart as the stdout path (it should
have always been the case)  AND qemu picks the first uart as the uart connected
to the console (it should be with my latest patch) we should get serial output.

Another thing that may get me delayed is that I need to rebuild my or1k-elf-gdb
as it's python version is no longer compatible with the kernel's python.

-Stafford


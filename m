Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B335DD3A679
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 17:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5qUX-0004ys-3h; Tue, 29 Oct 2024 13:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1t5qUV-0004xy-HM
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 13:58:51 -0400
Received: from gerbil.ash.relay.mailchannels.net ([23.83.222.67])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1t5qUT-0002T7-72
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 13:58:51 -0400
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id CDFA6821CA2;
 Tue, 29 Oct 2024 17:58:39 +0000 (UTC)
Received: from pdx1-sub0-mail-a293.dreamhost.com
 (100-102-251-187.trex-nlb.outbound.svc.cluster.local [100.102.251.187])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 48C53821C2C;
 Tue, 29 Oct 2024 17:58:39 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1730224719; a=rsa-sha256;
 cv=none;
 b=a2si/G4dQ4G7SWYH9cecPmLTAfc88tc+1l+eILghaRVFKCkOdSYGjPbilcYmIxF57hyfkD
 TXLPHd/VBHNMcty8WSVGaId4De/mf4AvOxRHFvBizMFDQxQIHkgbQIQsBn4aCpZ5ZrBWBt
 DOyOwHDGgqkohdncGLTKgaQ6BjAw1GoHzEsfKjZmAtbPj6CFeERv5Xi9EbRm6DRO5Tmf4A
 kXRrX9+F1maBeGUUW7doYYOH3L9PPm/H0ZmeN3oiuQWHvO20VAN4C0jMxRoejcszsfH5rJ
 JQOkx9RxeqDWrH+pTgCwDnQHU8/g7c9TuK7FkRnjbAPsiJ4Et89fDZWPezjWVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1730224719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=iJhEoHmTbBxayFhxlg4I2mRGIG1jQjprOI4TdotZTo0=;
 b=fL2aJ20cnkGvp8fz2nhXKb5EqmiGbUoveVg9Cs8r7dZbAO80JiGqPRhC8+9QOTcWal1dOi
 apyCvbVC+SoXUbo0OZANFwoFZBbXcIjZfk1MxjmYCHrwTxZDE0/NGV240dsHJuuudvPKMM
 SoVPxCd6TuAwfyz850x0eSNkHa+ewX+hycWTam6F9RcLsMDawUtlFKOwxF3+IyW2P3Nq+s
 CelJ0dOYZtgSJeooudpMHzbVd9O+LLxI2xuaY3hiDa5/hlKIpkfa7nVFlCbDqgmLFs+fXf
 awtwqHVyC0aaqvfeAg37sch4jGCuaXU0h3RjBY8UOPc98TikufuCRcfQmCcKPQ==
ARC-Authentication-Results: i=1; rspamd-588c698788-v24fm;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Ruddy-Wide-Eyed: 540f49e018f708a6_1730224719552_166414193
X-MC-Loop-Signature: 1730224719552:655139962
X-MC-Ingress-Time: 1730224719552
Received: from pdx1-sub0-mail-a293.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.102.251.187 (trex/7.0.2); Tue, 29 Oct 2024 17:58:39 +0000
Received: from [172.22.7.54] (unknown [198.232.126.195])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 (Authenticated sender: rob@landley.net)
 by pdx1-sub0-mail-a293.dreamhost.com (Postfix) with ESMTPSA id 4XdJ0G4KzCzDf; 
 Tue, 29 Oct 2024 10:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
 s=dreamhost; t=1730224719;
 bh=iJhEoHmTbBxayFhxlg4I2mRGIG1jQjprOI4TdotZTo0=;
 h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
 b=wMiuqodVEdvYe8c50Jq9cHMoP8ptlhSMHJDjrmFjgV04T3iDxK3o/NAxepbl5kkkp
 IHFq/1XQPhLj1pDSw1dEKAykE/83ZjuznUaRdPS5RjH0fXDpTnItVAVrHr7HjZFGcA
 EKa6jLERT2Hon1FS2V3SUj1JDLVmuViG4ImHA0WWgoIQqHdowVydhUKIn3+L1Le2jp
 ZhWaB+zi5i5Trl4PW9GwmxQMcyVLEZFs6alPRgDilB2m9xLCPsmJ/AR89yXC3PepVb
 4IN3fnD3gfVfN5jfeZoFo0wAndaoDGgpKuCITLOgFKQBo0U/va3kd7JggAI8BymYqj
 0YPRMF4lwxc0g==
Message-ID: <17599c22-6aba-4855-b8a0-43412131823b@landley.net>
Date: Tue, 29 Oct 2024 12:58:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests/functional: Add a test for sh4eb
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>
References: <20241024082735.42324-1-thuth@redhat.com>
 <20241024082735.42324-3-thuth@redhat.com>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <20241024082735.42324-3-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=23.83.222.67; envelope-from=rob@landley.net;
 helo=gerbil.ash.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/24/24 03:27, Thomas Huth wrote:
> Now that we are aware of binaries that are available for sh4eb,
> we should make sure that there are no regressions with this
> target and test it regularly in our CI.

Any progress on restoring this? Didn't see it in "git pull" just now...

> +class R2dEBTest(LinuxKernelTest):
> +
> +    ASSET_TGZ = Asset(
> +        'https://landley.net/bin/mkroot/0.8.11/sh4eb.tgz',
> +        'be8c6cb5aef8406899dc5aa5e22b6aa45840eb886cdd3ced51555c10577ada2c')

Feel free to pull binaries from my site, but from a reliability 
perspective "some random dude got hit by a bus so a site went down that 
broke our test infrastructure" seems a bit dodgy. (Even the Internet 
Archive has been having reliability issues of late, and "as long as 
Brewster Kahle's dot-com money holds out" seems a similar bus number.)

Building it yourself from source seems more reliable. Is there any sort 
of policy here?

I build the toolchains, kernel, and userspace entirely from source and 
can provide the reproduction sequences for those if you like.

It's part of my mkroot project, which is attempting to build small qemu 
systems for every target supported by all of:

1) qemu
2) linux
3) musl-libc
4) gcc

And even do automated smoketests on them showing it can boot, run a 
shell script, and access a virtual block device and network connection:

   https://github.com/landley/toybox/blob/master/mkroot/testroot.sh

Alas a lot of targets I would LIKE to support are missing something in 
one or more of those 4 packages. (No sparc in musl, etc.)

At the moment this lack is most obvious to me for nommu support. If I 
want fdpic then linux/fs/Kconfig.binfmt says my options are:

config BINFMT_ELF_FDPIC
         bool "Kernel support for FDPIC ELF binaries"
         default y if !BINFMT_ELF
         depends on ARM || ((M68K || RISCV || SUPERH || XTENSA) && !MMU)

But gcc's source says my options are:

$ grep -lir fdpic gcc/config | xargs dirname | uniq

   gcc/config/frv
   gcc/config/sh
   gcc/config/bfin
   gcc/config/arm

Which is exactly TWO targets that overlap. (There were two more, but 
Linux commit f5a8eb632b56 removed bfin and frv in 2018, and while I've 
followed arm-fdpic development since 2016 I have yet to get it to work 
for me.)

(NOMMU support is a bit like eukaryote cells in biology: beneath most 
people's notice but EVERYWHERE, to the point that ecosystem physically 
outweighs the "more advanced" one if you add up each instance of both.)

While you can do PIE binaries on nommu (which is what buildroot and
Buildroot and https://github.com/gregungerer/simple-linux do for the 
other nommu architectures), that just doesn't scale. If you run two PIE 
instances of "bash" on nommu it loads two copies of the bash binary into 
memory, AND each one requires one big contiguous block of memory for the 
text, rodata, bss, and data segments all together.

The point of fdpic is those four segments relocate independently, so 
multiple instances of the same program can share text and rodata, and 
also use smaller chunks of memory for bss and data which is much easier 
to come by in system without an mmu to let virtual mappings collate 
fragmented physical memory. On nommu memory fragmentation is basically 
inevitable.

Rob

P.S. In theory I could try linux's nolibc.h instead of musl but building 
toybox under that is quite the lift, and I briefly had an llvm hexagon 
build working instead of gcc (copied from your test stuff, but 
https://compiler-rt.llvm.org/ is just apocalyptically badly designed 
that the easy way to get a portable build out of it honestly seems to be 
to write a new replacement library from scratch).


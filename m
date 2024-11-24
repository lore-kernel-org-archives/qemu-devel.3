Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D07E6688A
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2024 05:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tF51T-0002lP-V2; Sun, 24 Nov 2024 00:19:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1tF51S-0002lA-PY
 for qemu-devel@nongnu.org; Sun, 24 Nov 2024 00:19:02 -0500
Received: from dormouse.elm.relay.mailchannels.net ([23.83.212.50])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1tF51Q-0002iW-J9
 for qemu-devel@nongnu.org; Sun, 24 Nov 2024 00:19:02 -0500
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 10E98901B33;
 Sun, 24 Nov 2024 05:18:55 +0000 (UTC)
Received: from pdx1-sub0-mail-a290.dreamhost.com
 (trex-3.trex.outbound.svc.cluster.local [100.121.85.75])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id A37AB901BB4;
 Sun, 24 Nov 2024 05:18:54 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1732425534; a=rsa-sha256;
 cv=none;
 b=CrFg8mO++muxYg2Pj7iB4BbOOLfyiVKyOKRhOYvcJQ1vz12soZFgfcc04sQ+hLjMgqfwje
 gYOC2v53lOHUdxqoo+R7F+o993r8dJICVG2NnXOwqDBwEUQAym/TPYGjZOrEwo3cdbLd9j
 bHeO+FBjWng7VReQ8YqO78jaTs/swtCEI3wXTs8sXvrMsvO/KYmIO66zBuV1wLSB69Kfj/
 xvSBJiG1b4jvWheKtdqwFcmOrkKBjVd/xVDJIJfO2m04bh/gm2BXpssP+JMMS+gSiec126
 LAPXqrxsWJbnS9yPZVa8opvG8PnkOATnobYQfPfctuESiuLppoRYvYscIh6Z+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1732425534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=AqJbXNOLdgSA7gVFU5bnH87Kf2GqvZYJ5R0hTLzKm+8=;
 b=0BM1I6Fz2M451SKW7x5H5ZP/9NtggdbdHBJzYxgLWyYIvIsoU/MZlYu1fn7iESGe8d26eH
 gK6ugAXYw264NmywUxJn0a3qIrqAcE62I7UtN7R2QSwMpGjYYO4mUwzva54RL+PYytHt9X
 vOTB1wXAwnLG13AyB5IK11wCAzuwB9bP0qvvuOma2J+cyJm/17KdX9V26bsmJOsq9YsSH8
 prd2/4DR6P33wS2wdkfcdRAV+5deavLNGKiOrgbWhjxGXjd1CzsRDL+hV8amee/xQFET5q
 vEpmt457RjQrDRPrD9ZcrwgR6fk3N71L7rqPhTYECkmDfgi37fPZJJJlSSUgTA==
ARC-Authentication-Results: i=1; rspamd-dcc6979f6-hvl4v;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Macabre-Cooperative: 795c01750be9d9d8_1732425534915_2511799689
X-MC-Loop-Signature: 1732425534915:1009308627
X-MC-Ingress-Time: 1732425534915
Received: from pdx1-sub0-mail-a290.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.121.85.75 (trex/7.0.2); Sun, 24 Nov 2024 05:18:54 +0000
Received: from [172.22.7.54] (unknown [198.232.126.195])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: rob@landley.net)
 by pdx1-sub0-mail-a290.dreamhost.com (Postfix) with ESMTPSA id 4Xwxvf0y52zRq; 
 Sat, 23 Nov 2024 21:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
 s=dreamhost; t=1732425534;
 bh=jwW6w90Mj7X6S1xVXGRhxfRhHYbXTegVvejWIqiEcl8=;
 h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
 b=qiT9G2C/Xxi3KxVnb+tlpKbtSiJlhS+8GDFDYF2/fr+59mxweBVuIHycIrbioQ7OB
 KY9ptoZxK429e2Gbm+CwfsvC65qMm9Y4IlAcmSKe9H0FKyoWjqTr9uowlcp/Zjolya
 JGFFFFhdqGBYiD3niiqiUcaHXCWJ86+HnUXP9t+7QLFn7pFnnHmCYHoRg9ar8yF0O0
 94R3LEcAHOoCmZbGdWUIpMHQJYVeHGUR91AD+v23ytFzPatXuHZ936Co96zYluK9cG
 DSrsLsc0N6+EXPyYxkyWevYgeUeLwEKBa1ZDaPPAij82NmnSZqDuww4jItfMJQiIOL
 rrrBtz+3YfIGQ==
Message-ID: <87a6b910-5af6-47ad-ad8d-b79f11a7cbf2@landley.net>
Date: Sat, 23 Nov 2024 23:18:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QEMU commit 0a923be2f642 broke my or1k image.
To: Stafford Horne <shorne@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <afac091f-08cb-0f6d-4c01-bfa4421e7a47@landley.net>
 <Zufcf4iAqosZ7VBf@antec> <9b2761aa-8ee0-4399-b237-31e70e3ed165@landley.net>
 <Z0Cyx3i3z7Zl7XPm@antec> <31fa6255-8e0c-4d05-bad9-dd843c676244@landley.net>
 <Z0GSETLeT5w8B2DX@antec>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <Z0GSETLeT5w8B2DX@antec>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=23.83.212.50; envelope-from=rob@landley.net;
 helo=dormouse.elm.relay.mailchannels.net
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11/23/24 02:28, Stafford Horne wrote:
>> Just a guess, but given the alignment change, I suspect it's barfing on the
>> statically linked initramfs? That seems the most likely step to go off the
>> rails given the failing patch is a symbol alignment change in the flattened
>> device tree plumbing, and I think the initramfs extractor parses device
>> trees very early on to find stuff (I forget why). Moving "where the data
>> lives" without a corresponding change to the "where to look for the data"
>> code seems a bit strange, but it's not my area...
> 
> OK, and the broken earlycon may be masking what is going on, as we should at
> least see some console output before things fail.  The earlcon fix is in 6.13
> not 6.12.
> 
> I was able to test your or1k.tgz image and figure out what is wrong.  Your
> run-qemu.sh script has 'console=FIXME'.  This command line argument is taken in
> and is causing the boot process to not be able to find the console.
> 
> Changing it to 'console=ttyS0' allows me to see the output.

Ha, so it STARTED parsing console= and broke. Oops. (It was there so I'd 
notice...)

> I put a branch with the qemu patches I have here:
> 
>    - https://github.com/stffrdhrn/qemu/tree/or1k-9.2.0-fixes-1
> 
>> Here's the miniconfig I built 6.12 with (90% of which is generic to all the
>> architectures I'm testing, the sections are labeled. The console="FIXME" bit
>> is because I can't get qemu-system-or1k -append "blah" to go through to
>> linux, so I stuck FIXME in that field for the or1k target and it wound up in
>> the output):
> 
> The kernel command line is injected by qemu into the qemu generated
> devicetree.  I notice when I boot your kernel with the reverted FDT alignment
> fix the console prints:
> 
>      Kernel command line: earlycon
> 
> This means that the qemu devicetree is not being used, hence the command line
> args are not working.  The qemu device tree not being used is not good, but that
> is why reverting the alignment fix 'seems' to fix the issue.  To me the revert
> looks to be breaking the qemu devicetree allowing us to fall back to the kernel
> supplied devicetree.

I'm happy to do it the "right" way if I know what that is. I just 
stumbled around and got it to work.

>> Also, looking at that, I'm using a builtin DTB and you might be passing one
>> in via -dtb? Another thing the alignment change might break...
> 
> Thanks for the steps.  I was just using the or1k.tgz you provided earlier.  The
> above will help if I want to try some kernel fixes on my own.

I'm attempting to regression test as many targets as I can to get 
consistent basic behavior out of:

   https://landley.net/bin/mkroot/0.8.11/

I'm trying to get a new release out with the 6.12 kernel which is why 
I'm revisiting this now.

I've even got a test script that runs all the targets under qemu 
(booting them in parallel even) and checks that A) they boot and run 
userspace, B) they can talk to an emulated hard disk, C) they can talk 
to an emulated network, D) the clock gets set reasonably, E) it knows 
how to exit the emulator. You'd be surprised how many regressions there 
are in just that...

Speaking of which, is there a way to get or1k to exit the emulator? I 
told the kernel to reboot but it says "reboot failed, system halted" and 
hangs instead of exiting qemu. (My testroot runs qemu under "timeout -i 
10" to kill it after 10 seconds of inactivity, I.E. nothing written to 
stdout, but it still counts as a failure on one of the criteria.)

>>> Note, I did find some issues with the kernel nor properly handling stdout-path.
>>> It seems that if there are multiple uarts the first one will always be used as
>>> the default uart.  Only the console= command line argument can be used to
>>> override that.
>>
>> I've never managed to get console= to go through to linux in
>> qemu-system-or1k. The above tries but is ignored.
> 
> As I mentioned above this is a good clue and explains why the alignment "fix"
> fixes your issue.

Happy to do it properly. Almost all the other targets can do console=, 
the FIXME was there to highlight the fact it didn't work right. 
(Silently working for the WRONG REASON is still bad when regression 
testing.)

>> It's also doing a statically linked initramfs because -initrd didn't work on
>> this target. Happy to update if it's been fixed, the other targets are
>> almost all using -initrd to feed in an external cpio.gz
> 
> Using -initrd should work.  But also using the statically linked initramfs
> should be fine too.  The setup I use for testing uses virt with a virtio block
> driver.

Most of the other targets _don't_ use builtin initramfs, so you can swap 
them out "aftermarket" as it were. When it's separate you can examine 
and edit the contents without rebuilding the kernel...

> When using qemu with -initrd qemu will back the kernel, initrd and fdt one after
> the other into memory as per.
> 
> [ kernel ] - Loads from 0x100 (based on elf layout)
> [ initrd ] - page aligned
> [  fdt   ] - page aligned devicetree (revert moved to 4 bytes aligned)
> 
> The fdt address gets placed into r3 which the kernel uses to find the qemu FDT.
> Finding the FDT one of the first steps of the boot processes.

I updated my mkroot config:

   https://github.com/landley/toybox/commit/fb3ca98e2faa

I.E. changed the FIXME to ttyS0, removed BUILTIN=1 so it's no longer 
statically linking the initramfs image, and yanked the builtin DTB, and 
the result works with v9.2.0-rc1.

Still doesn't know how to exit qemu, though. (Is there a kernel symbol I 
can add to 6.12, or does qemu still not have an exit mechanism for this 
board yet?)

(FYI: be2csv is a shell function to convert bash's brace expansion 
syntax to a comma separated value list, and then csv2cfg is another 
shell function that turns the CSV into https://lwn.net/Articles/160497/ 
. The CSV is shipped as docs/linux-microconfig in the tarball if you're 
curious. That's how a 400 line bash script can build a Linux system that 
boots to a shell prompt for a dozen architectures. The or1k config is 
now 2 lines, for example. 3 with the "if or1k" check. The variables it 
assigns to are documented around line 190.)

> If you provide command line args console=ttyS0 things will work.
> 
> Also console=ttyS0 is not used as all as it should be the default in QEMU.

I specify it explicitly to be consistent across architectures.

> It looks like the root cause of the issue was the 'console=FIXME'.
> 
> I hope it helps.

Yup, I just had to remove workarounds for old qemu that are no longer 
needed. Thanks for the help. (If you do teach qemu to exit at some 
point, please let me know...)

> -Stafford

Thanks,

Rob


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE9FC4828F
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Feb 2024 20:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWMHu-0005bG-Lj; Sat, 03 Feb 2024 15:06:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rWMHr-0005b1-HW
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 15:06:52 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rWMHp-000295-6z
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 15:06:50 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 03FB24E608B;
 Sat,  3 Feb 2024 21:06:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id rXbMELw-JDFL; Sat,  3 Feb 2024 21:06:42 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0C4764E601F; Sat,  3 Feb 2024 21:06:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 07FD07456B4;
 Sat,  3 Feb 2024 21:06:42 +0100 (CET)
Date: Sat, 3 Feb 2024 21:06:41 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Christian Gudrian <qemu-devel@gudrian.org>
cc: qemu-devel@nongnu.org
Subject: Re: ehci: more than 16 ITDs
In-Reply-To: <441d024e-9d3f-b410-2e3c-3323af841b8e@gudrian.org>
Message-ID: <2cc91c6e-7c1a-f7cd-2b7d-69136c98d832@eik.bme.hu>
References: <441d024e-9d3f-b410-2e3c-3323af841b8e@gudrian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sat, 3 Feb 2024, Christian Gudrian wrote:
> Hello!
>
> I am trying to access a USB audio hardware (a Korg Kronos synthesizer)
> running an ancient 2.6.32.11 kernel (due to the binary only Korg driver
> modules) via USB pass through. Loading the audio driver immediately
> leads to a reset of the EHCI controller due to a "processing error"
> caused by the 17th ITD being fetched.
>
> Entirely ignorant of what I'm doing I've patched hcd-ehci.c to accept
> this 17th ITD. Needless to say that this attempt didn't work: the
> refcount warning in the qh_get function (in ehci-mem.c) triggers and the
> system halts.
>
> Is this a direct consequence of me allowing 17 ITDs or is this caused by
> another part of the Korg driver misbehaving or a bug in the EHCI
> emulation of QEMU? How can I find out, what's going wrong?

It's hard to tell, I don't know EHCI but there's a TODO comment near that 
error so maybe there's some EHCI feature not emulated that you may need to 
implement in QEMU there. I guess you'd need to check the EHCI 
specification or the docs of the actual chip that is emulated for info on 
how this should work.

Also to get more debugging info to see what's happening you can add 
--trace enable="usb*" (or see qemu/hw/usb/trace-events for the list of 
trace points available that could be enabled individually) in case you 
were not aware of that. There are several ways to enable trace points, see 
QEMU docs on that. Apart from the simple enable=pattern these can also be 
controlled from QEMU monitor or put the list in a text file and use that 
with --trace to enable several of these.

Regards,
BALATON Zoltan


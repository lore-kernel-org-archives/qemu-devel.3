Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06675D7237B
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Jan 2026 21:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vk80f-0005dK-Oy; Sun, 25 Jan 2026 16:51:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vk80W-0005a3-Ta
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 16:50:58 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vk80U-0000If-0V
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 16:50:56 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5EE9F5969FF;
 Sun, 25 Jan 2026 22:50:50 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id AWpG5IlqM0j6; Sun, 25 Jan 2026 22:50:48 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 5145D5969F1; Sun, 25 Jan 2026 22:50:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4F6FA5969F0;
 Sun, 25 Jan 2026 22:50:48 +0100 (CET)
Date: Sun, 25 Jan 2026 22:50:48 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: orion cai <orion@orions-MacBook-Air.local>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/net/rtl8139: Fix integer overflow in
 rtl8139_write_buffer
In-Reply-To: <20260125133239.0714449BAC1@orions-MacBook-Air.local>
Message-ID: <8b8995cd-af4b-241f-3f60-269b13b6c0c2@eik.bme.hu>
References: <20260125133239.0714449BAC1@orions-MacBook-Air.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Sun, 25 Jan 2026, orion cai wrote:
> Reply to: qemu-devel@nongnu.org
> Subject: Re: [PATCH] hw/net/rtl8139: Fix integer overflow in rtl8139_write_buffer
> In-Reply-To: <20260124033346.BB51747D39A@orions-MacBook-Air.local>
> References: <20260124033346.BB51747D39A@orions-MacBook-Air.local>
>
> On Sat, 24 Jan 2026 at 06:10, orion cai <orion@orions-macbook-air.local> wrote:
>>
>> From d1781652dc7039b2ac92fa80695091b97dbf1918 Mon Sep 17 00:00:00 2001
>> From: orion cai <orion@orions-MacBook-Air.local>
>> Date: Sat, 24 Jan 2026 11:19:17 +0800
>> Subject: [PATCH] hw/net/rtl8139: Fix integer overflow in rtl8139_write_buffer
>
> Hi; thanks for this bug report and patch.
>
>> Fix integer overflow vulnerability in rtl8139_write_buffer() that could allow
>> a malicious guest to bypass DMA bounds checks and write to arbitrary memory
>> locations.
>
> For clarity, this is an arbitrary write to guest memory,
> not to host (QEMU) memory, since we're doing a pci_dma_write(),
> correct ?
>
> That renders it a bit less critical, because if you can
> program the RTL8139 then you almost certainly already
> have kernel level privilege in the guest and can write
> to arbitrary guest memory directly if you want...
>
> Yes, you're absolutely correct. The pci_dma_write() writes to guest memory,
> not host memory. An attacker would need guest kernel privileges. However,
> the bug can still cause guest memory corruption and crashes, so fixing it
> improves QEMU's correctness and robustness.

What does a real card do with these parameters? Does it wrap and overwrite 
unexpected memory address and crash the real machine or it handles this 
case differently? If the real machine wraps then doing the same in 
emulation is correct otherwise this should be changed to do what real card 
does which may not be ignroing wrong writes. I haven't checked this but 
the point is that we emulate a real card so this may be something that is 
a problem there too in which case it might not need to be fixed.

Regards,
BALATON Zoltan


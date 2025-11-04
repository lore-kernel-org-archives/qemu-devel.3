Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F99CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 11:27:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGFBj-0004ex-Dm; Tue, 04 Nov 2025 06:26:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vGFBh-0004en-Rn
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 06:26:57 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vGFBf-00030p-Rk
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 06:26:57 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B9F755972F3;
 Tue, 04 Nov 2025 12:26:47 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id dj77pexzPveG; Tue,  4 Nov 2025 12:26:45 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9CD905972E4; Tue, 04 Nov 2025 12:26:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9B4285972E2;
 Tue, 04 Nov 2025 12:26:45 +0100 (CET)
Date: Tue, 4 Nov 2025 12:26:45 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 5/7] ati-vga: Implement HOST_DATA register writes
In-Reply-To: <441b1bbc-3432-680f-80d7-09a256a62436@eik.bme.hu>
Message-ID: <b92ef3bf-affd-6a74-6b05-581c6d510e61@eik.bme.hu>
References: <20251103033608.120908-1-chad@jablonski.xyz>
 <20251103033608.120908-6-chad@jablonski.xyz>
 <441b1bbc-3432-680f-80d7-09a256a62436@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

On Mon, 3 Nov 2025, BALATON Zoltan wrote:
> On Sun, 2 Nov 2025, Chad Jablonski wrote:
>> Writing to any of the HOST_DATA0-7 registers pushes the written data
>> into a buffer. A final write to HOST_DATA_LAST writes data to the
>> buffer and triggers the pending blit operation.
>> 
>> The buffer for now is a static 4MiB and overflows are checked. This
>> seems like a large enough value given what I've seen in testing. Future
>> work could dynamically size the buffer based on the destination dimensions 
>> if
>> needed.
>
> I wonder where the real chip stores this information?

I don't think there's a separate buffer for this on real card and the 
command FIFO is not long enough to store it so it should probably use 
vram. But how does it know which part of that can be used? Maybe you could 
write some pattern into HOST_DATAx registers (like 0xaaaaaaaa, 0x55555555 
but longer than the FIFO to make sure it's not staying there) and then 
before writing HOST_DATA_LAST look for that pattern in vram to see if it 
appears anywhere. Maybe some register points there or the card has some 
memory management I don't know about? (I don't know much about GPUs so 
it's quite possible I have no idea how it should work.) If the pattern is 
not found I don't have any better idea to find out how this should work. 
(We could keep the separate buffer in emulation for now but I'm curious 
how the real chip does it and if we can emulate that.)

Regards,
BALATON Zoltan


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBD5CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 15:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKeYC-0007yE-RP; Wed, 06 May 2026 11:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wKeY3-0007xY-Br
 for qemu-devel@nongnu.org; Wed, 06 May 2026 11:52:32 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wKeY1-0004MU-QD
 for qemu-devel@nongnu.org; Wed, 06 May 2026 11:52:31 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EF225596978;
 Wed, 06 May 2026 17:45:53 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id FZuX4kGjOYI6; Wed,  6 May 2026 17:45:51 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E5B9D596975; Wed, 06 May 2026 17:45:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E0637596967;
 Wed, 06 May 2026 17:45:51 +0200 (CEST)
Date: Wed, 6 May 2026 17:45:51 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] ati-vga: fix ati_set_dirty address calculation
In-Reply-To: <DI5TLZB5BUHN.3EVV3B79DTS8A@jablonski.xyz>
Message-ID: <0ba59a44-1dd8-6f9c-fc04-16b93ba9e13f@eik.bme.hu>
References: <20260417205752.3932801-1-chad@jablonski.xyz>
 <58180aa1-4e39-4aa8-6d3b-586d4461deba@eik.bme.hu>
 <DHWB25SYYESE.QMQK5VPNXSVK@jablonski.xyz>
 <6d7f3031-225b-31d9-dcca-45e34ba61783@eik.bme.hu>
 <DI5TLZB5BUHN.3EVV3B79DTS8A@jablonski.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

On Wed, 29 Apr 2026, Chad Jablonski wrote:
>> I've found a case which this patch seems to fix and does not involve
>> panning (unfortunately I can't give a reproducer as it is with AmigaOS
>> that isn't free) but I don't understand why and what exactly happens.
>> Maybe updates are missed when guest updates display by directly writing to
>> VRAM? But such writes should cause region to become dirty due to
>> vga_dirty_log_start() called at the end of vga_common_init() which we call
>> from ati_vga_realize(). Without this patch after a mode change display is
>> only updated around the mouse where it's explicitely marked dirty (with
>> guest_hwcursor=on as guest_hwcursor=off is bugged) but with this patch
>> updates correctly but I don't know if it's just a side effect or actual
>> fix for something. Maybe it's just the calculation fix and not the off
>> screen dirty marking part, I haven't try to test it with restricting to
>> visible screen (maybe I wait for v2 of the patch).
>>
>
> Interesting! I haven't run into a case without panning yet so I'd
> definitely be interested to hear if v2 still fixes this or if it behaves
> any differently at all.

v2 also fixed this case. I made the changes I suggested to simplify it and 
have sent a v3 that still works for me so I hope I did not break it. From 
this it now seems to me the difference we missed was the dst_x offset that 
I'm not sure how it ever worked without or where we lost that but it does 
not matter any more with this patch fixing it so I did not investigate 
further.

Regards,
BALATON Zoltan


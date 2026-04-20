Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC01F588E4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 14:57:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEq3c-0002QC-As; Mon, 20 Apr 2026 10:57:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wEq3b-0002Q2-1Q
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 10:57:03 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wEq3Y-0007BP-Cd
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 10:57:02 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B2C2559695E;
 Mon, 20 Apr 2026 16:56:56 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id fCh5aPBl7rE6; Mon, 20 Apr 2026 16:56:54 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 5CEF959695D; Mon, 20 Apr 2026 16:56:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5B3B159695B;
 Mon, 20 Apr 2026 16:56:54 +0200 (CEST)
Date: Mon, 20 Apr 2026 16:56:54 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] ati-vga: fix ati_set_dirty address calculation
In-Reply-To: <DHWB25SYYESE.QMQK5VPNXSVK@jablonski.xyz>
Message-ID: <6d7f3031-225b-31d9-dcca-45e34ba61783@eik.bme.hu>
References: <20260417205752.3932801-1-chad@jablonski.xyz>
 <58180aa1-4e39-4aa8-6d3b-586d4461deba@eik.bme.hu>
 <DHWB25SYYESE.QMQK5VPNXSVK@jablonski.xyz>
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

On Sat, 18 Apr 2026, Chad Jablonski wrote:
>> I guess this is to fix chars not appearing in xterm when a virtual desktop
>> is panned that you noticed here?
>> https://lists.nongnu.org/archive/html/qemu-devel/2026-04/msg00785.html
>>
>
> Yep! I should have mentioned this.
>
>>> The second is that a bounds check was also being performed to ensure
>>> that the dirty memory was within the visible screen. With the virtual
>>> desktop this isn't actually what we want. Updates can and will happen
>>> outside of the visible screen area. Those should be marked dirty.
>>
>> But I still think only the visible area should need marking dirty because it
>> is used to update display so marking non visible parts should have no
>> effect. I'm not sure if it has any performance impact but just seems
>> unnecessary so that's why this tried to limit it to visible area. I've
>> added to cc some people who could maybe enlighten us on this.
>>
>
> After digging into this deeper I think you're right that the
> non-visible dirty marking isn't necessary. Looking at vga_draw_graphic

I've found a case which this patch seems to fix and does not involve 
panning (unfortunately I can't give a reproducer as it is with AmigaOS 
that isn't free) but I don't understand why and what exactly happens. 
Maybe updates are missed when guest updates display by directly writing to 
VRAM? But such writes should cause region to become dirty due to 
vga_dirty_log_start() called at the end of vga_common_init() which we call 
from ati_vga_realize(). Without this patch after a mode change display is 
only updated around the mouse where it's explicitely marked dirty (with 
guest_hwcursor=on as guest_hwcursor=off is bugged) but with this patch 
updates correctly but I don't know if it's just a side effect or actual 
fix for something. Maybe it's just the calculation fix and not the off 
screen dirty marking part, I haven't try to test it with restricting to 
visible screen (maybe I wait for v2 of the patch).

Regards,
BALATON Zoltan


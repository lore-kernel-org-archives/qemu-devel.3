Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF61FF60EF
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 10:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7VxB-0006Zv-JS; Tue, 31 Mar 2026 06:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w7VxA-0006Zh-0V
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 06:04:08 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w7Vx7-0001W8-Gf
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 06:04:07 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 19BDE5969F3;
 Tue, 31 Mar 2026 12:04:03 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 2MfStPy87OU4; Tue, 31 Mar 2026 12:04:01 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 140325969F2; Tue, 31 Mar 2026 12:04:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1274B5968DD;
 Tue, 31 Mar 2026 12:04:01 +0200 (CEST)
Date: Tue, 31 Mar 2026 12:04:01 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Gerd Hoffmann <kraxel@redhat.com>
cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, 
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [RFC PATCH] cirrus-vga: Add property to set frame buffer
 endianness and make it default to little endian
In-Reply-To: <acqO5rPZtu9rcWTi@sirius.home.kraxel.org>
Message-ID: <06bfb850-a802-5a5e-3d6b-47f2499afb3c@eik.bme.hu>
References: <20260330140655.31EC55968DE@zero.eik.bme.hu>
 <acqO5rPZtu9rcWTi@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, 30 Mar 2026, Gerd Hoffmann wrote:
>  Hi,
>
>> +    { "isa-cirrus-vga", "x-big-endian-fb", "off" },
>> +    { "cirrus-vga", "x-big-endian-fb", "off" },
>
> I don't think cirrus needs any of this.  As far I know only standard vga
> is used in big endian targets.

You can add a cirrus-vga-pci with -device to big endian machine too and 
I've tried an AmigaOS driver which assumes the card is little endian and 
does not work so this fix would be useful. We could just change the 
default as cirrus-vga is relatively unused on big endian machines but 
having the property is safer and may allow users to continue using what 
they use now. Please merge this fix for 11.0 if there are no objections.

> IIRC cirrus (as-in: the physical hardware) has 4M vram and a a 8M pci
> bar, where the lower 4M offer little-endian access to the vram and the
> upper 4M offer big-endian access to the vram.
>
> qemu never emulated the big-endian aperture with the automagic
> byteswapping.

The GD5449 has 16 MB BAR but also may have byte swapping aperture but I 
don't know anything that uses that.

Regards,
BALATON Zoltan


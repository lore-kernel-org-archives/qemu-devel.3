Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681A2FED9F8
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 17:25:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2YAb-0000Ml-00; Tue, 17 Mar 2026 13:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w2YAY-0000MI-Pq
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:25:26 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w2YAW-0007r1-Lb
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:25:26 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D4526596A4F;
 Tue, 17 Mar 2026 18:25:20 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id r4kJtxB-L3Ds; Tue, 17 Mar 2026 18:25:18 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id CFE89596A47; Tue, 17 Mar 2026 18:25:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CE2C15969E4;
 Tue, 17 Mar 2026 18:25:18 +0100 (CET)
Date: Tue, 17 Mar 2026 18:25:18 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 marcandre.lureau@redhat.com, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 1/4] ati-vga: Fix colors when frame buffer endianness
 does not match host
In-Reply-To: <DH578OG8RPS8.PFREUK5BRSF5@jablonski.xyz>
Message-ID: <4e847dfc-11de-bcbe-1b6a-98d4f4748fc3@eik.bme.hu>
References: <cover.1773618848.git.balaton@eik.bme.hu>
 <5837ddb9d354004465216a39b6b6189c2ee5c8f4.1773618848.git.balaton@eik.bme.hu>
 <DH578OG8RPS8.PFREUK5BRSF5@jablonski.xyz>
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

On Tue, 17 Mar 2026, Chad Jablonski wrote:
> This works in the 24/32bpp case. Before this I see a yellow background in
> fluxbox, after I see gray.
>
> I did notice that the existing big_endian_fb boolean in ati_vga_switch_mode
> doesn't distinguish between big endian 32-bit and 16-bit swapping. In the 16bpp
> case I see a black background in fluxbox. I did a quick and dirty test and
> replaced the bswap32s with a 16-bit byte swap and then 16bpp displays the gray
> background correctly.
>
> This is a pre-existing issue but I thought it was worth pointing out. That said
> this fixes things for 24/32bpp and is an improvement.
>
> Tested-by: Chad Jablonski <chad@jablonski.xyz>
> Reviewed-by: Chad Jablonski <chad@jablonski.xyz>

Thanks for testing and review. Yes you're right I should have take into 
account bpp too. I'll have a look to see if I can fix this and send a new 
version.

Regards,
BALATON Zoltan


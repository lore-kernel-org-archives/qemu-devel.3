Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49D7E8784A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 16:44:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnJUL-000231-73; Tue, 03 Feb 2026 11:42:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vnJUG-0001rd-4N; Tue, 03 Feb 2026 11:42:48 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vnJUD-0007e8-TE; Tue, 03 Feb 2026 11:42:47 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 247615969F3;
 Tue, 03 Feb 2026 17:42:43 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id BKcdOnU-_B-w; Tue,  3 Feb 2026 17:42:41 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 272615969FF; Tue, 03 Feb 2026 17:42:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 24F7F5969FA;
 Tue, 03 Feb 2026 17:42:41 +0100 (CET)
Date: Tue, 3 Feb 2026 17:42:41 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org, qemu-devel-bounces+chad=jablonski.xyz@nongnu.org
Subject: Re: [PATCH v7 08/19] ati-vga: Consolidate dirty region tracking in
 ati_2d_blt
In-Reply-To: <DG5FIN3H49YO.RK3FTIRHL4G9@jablonski.xyz>
Message-ID: <b7cca74d-c8c9-8cbf-fa33-8cd51d3fe7e2@eik.bme.hu>
References: <20260202204738.3080092-1-chad@jablonski.xyz>
 <20260202204738.3080092-9-chad@jablonski.xyz>
 <7e2672e6-5e7b-47d2-1070-ccc71060513e@eik.bme.hu>
 <DG5FIN3H49YO.RK3FTIRHL4G9@jablonski.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 3 Feb 2026, Chad Jablonski wrote:
>> Are you sure dst_offset calculation this way is correct? Also if
>> s->regs.crtc_offset is not 0 as that seems to be added to dst_bits for
>> Rage128Pro. This may be replaced with correct value from ctx later but
>> then you could just keep the original here to make sure it's not broken.
>>
>
> Good catch on this. I totally overlooked the R128-specific update to it.
> I'll keep the original here. It does eventually bite us again in patch
> 11. This was an attempt to avoid adding it to the ctx while also allowing us
> to pass only VGACommonState into ati_set_dirty instead of the full
> ATIVGAState. But it may have been a bit ambitious.
>
> The alternative here is to either continue to pass ATIVGAState to
> ati_set_dirty or add dst_offset to the ATI2DCtx. It feels a little out of
> place to me (like vram_end) on ATI2DCtx but I think that's a better tradeoff
> than continuing to pass the full ATIVGAState struct. I'll add it to the ctx
> in v8 unless you have objections or a cleaner approach.

I can't tell without looking at the new patch version but I think 
ati_vga_set_dirty needs to determine if the update is visible so it would 
need two values for that: start of visible screen (offset from vram start) 
and length of it so maybe these two values are needed in Ctx (or maybe 
multiple of these as there could be more screens but we only emulate one 
now) but I don't mind either if we keep passing ATIVGAState to all these 
functions.

Originally I thought Ctx would only include values that override what are 
in regs such as expanded bits and current src and dest coords that aren't 
updated in regs so host data can set and update these and not include a 
copy of every reg which could still be get from ATIVGAState. That way we 
don't need a separate ATIHostDataState struct either just include an 
ATI2DCtx in ATIVGAState and the blt function can use that instead of some 
regs while can keep using regs for other values. But if this would be too 
much reverting then I'm also OK with current approach and we can refine 
it later.

Regards,
BALATON Zoltan


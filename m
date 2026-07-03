Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A93C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 13:38:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfe5b-0005Gj-Vk; Fri, 03 Jul 2026 09:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wfe5Z-0005GM-SD
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 09:37:53 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wfe5X-0002Jj-TO
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 09:37:53 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 62BC2596707;
 Fri, 03 Jul 2026 15:37:48 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id Y6KuKBC_oJyv; Fri,  3 Jul 2026 15:37:46 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1C86359672E; Fri, 03 Jul 2026 15:37:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1AD8F59672D;
 Fri, 03 Jul 2026 15:37:46 +0200 (CEST)
Date: Fri, 3 Jul 2026 15:37:46 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Subject: Re: [PULL 40/41] ati-vga: fix ati_set_dirty address calculation
In-Reply-To: <CAFEAcA88TQhP6HFOhrAMjRMXU3UPYcw_EGp-Fj5GfA6L_WdjFA@mail.gmail.com>
Message-ID: <3f5fc513-1dab-078b-7f05-70f6fe2dedcd@eik.bme.hu>
References: <20260512062142.67998-1-philmd@linaro.org>
 <20260512062142.67998-41-philmd@linaro.org>
 <CAFEAcA88TQhP6HFOhrAMjRMXU3UPYcw_EGp-Fj5GfA6L_WdjFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1789271932-1783085866=:40069"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1789271932-1783085866=:40069
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 3 Jul 2026, Peter Maydell wrote:
> On Tue, 12 May 2026 at 07:30, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> From: Chad Jablonski <chad@jablonski.xyz>
>>
>> This fixes three bugs with the ati_set_dirty address calculation.
>>
>> First, vbe_start_addr is a word offset. All other values in the
>> calculation are byte offsets. It must be converted to bytes.
>>
>> Second, when setting the dirty region with memory_region_set_dirty
>> the vbe_start_addr is used to calculate the start of the dirty region.
>> This is a problem because the vbe_start_addr is the offset at which scan out
>> begins. This puts it in the visible screen coordinate system. The dirty
>> region however is in the virtual screen coordinate system. This can cause both
>> overmarking and missed updates. This is removed from the calculation.
>>
>> Third, when the start address of a blit is outside of the bounds check
>> the entire blit is missed and not set to dirty. This happens even if the
>> blit does partially overlap with the visible screen. The fix here is to
>> find the intersection of the visible screen and the blit and mark only
>> that region as dirty.
>>
>> This does not attempt to apply clipping to the blit. So there will be
>> overmarking in some cases.
>>
>> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
>> [balaton: drop excess parenthesis, use offsets instead of pointers]
>> Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
>> Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> Message-ID: <20260506153920.C6B27596978@zero.eik.bme.hu>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>
> Hi; Coverity warns here about some "we did a 32 x 32 multiply
> and put the result into a 64 bit calculation" issue here (CID 1660048):

I've got the warnings but didn't have time to look at it yet.

>> ---
>>  hw/display/ati_2d.c | 24 +++++++++++++++++-------
>>  1 file changed, 17 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
>> index 504d1c57085..48498677c7e 100644
>> --- a/hw/display/ati_2d.c
>> +++ b/hw/display/ati_2d.c
>> @@ -69,18 +69,28 @@ typedef struct {
>>  static void ati_set_dirty(VGACommonState *vga, const ATI2DCtx *ctx)
>>  {
>>      DisplaySurface *ds = qemu_console_surface(vga->con);
>> +    unsigned int bypp = ctx->bpp / 8;
>> +    hwaddr dirty_start = ctx->dst_offset + ctx->dst.x * bypp +
>> +                         ctx->dst.y * ctx->dst_stride;
>
> dst.y is uint16_t and dst_stride is int, so we do the multiply
> at 32-bits, and then the whole set of additions at 32-bits before
> putting it into a 64-bit hwaddr.
>
> Should we cast one of them to 64-bits to avoid the overflow,
> or do we know here that these values can't actually be large
> enough to overflow ?

I think since the x,y values are limited (at about 16384 or so, we usually 
apply mask when writing the regs) these should never overflow but we could 
try to cast something to silence the warnings. I can try to make a patch 
eventually unless someone else does it faster.

Regards,
BALATON Zoltan
--3866299591-1789271932-1783085866=:40069--


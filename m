Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B94DFCA19D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 23:00:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzja8-0005vw-KP; Mon, 09 Mar 2026 19:00:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vzja1-0005vi-I9
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 19:00:06 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vzjZz-0004L5-1P
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 19:00:05 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 123815969E7;
 Tue, 10 Mar 2026 00:00:00 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 5qjtksLH5NIk; Mon,  9 Mar 2026 23:59:58 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 121295969E6; Mon, 09 Mar 2026 23:59:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0EC755966F4;
 Mon, 09 Mar 2026 23:59:58 +0100 (CET)
Date: Mon, 9 Mar 2026 23:59:58 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: Chad Jablonski <chad@jablonski.xyz>, qemu-devel@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] ati-vga: Fix sign extension in DEFAULT_SC_BOTTOM_RIGHT
 read
In-Reply-To: <e2824e5c-4d1d-4d08-ba24-a8c3056c2edc@linaro.org>
Message-ID: <de83d589-99c0-9d40-b29e-61f8deb3d249@eik.bme.hu>
References: <20260309212206.2457691-1-chad@jablonski.xyz>
 <1931a6d0-d351-cc43-1b3d-fa3b3b0809a9@eik.bme.hu>
 <e2824e5c-4d1d-4d08-ba24-a8c3056c2edc@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1991432198-1773097198=:98453"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1991432198-1773097198=:98453
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 9 Mar 2026, Philippe Mathieu-Daudé wrote:
> On 9/3/26 22:41, BALATON Zoltan wrote:
>> On Mon, 9 Mar 2026, Chad Jablonski wrote:
>>> Cast default_sc_bottom to uint32_t before shifting left to prevent
>>> sign extension when assigning to uint64_t.
>>> 
>>> Fixes: CID 1645615
>>> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
>>> ---
>>> hw/display/ati.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>> 
>>> diff --git a/hw/display/ati.c b/hw/display/ati.c
>>> index 6cf243bcf9..f9773e1154 100644
>>> --- a/hw/display/ati.c
>>> +++ b/hw/display/ati.c
>>> @@ -514,7 +514,7 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, 
>>> unsigned int size)
>>>         val |= s->regs.default_tile << 16;
>>>         break;
>>>     case DEFAULT_SC_BOTTOM_RIGHT:
>>> -        val = (s->regs.default_sc_bottom << 16) |
>>> +        val = ((uint32_t)s->regs.default_sc_bottom << 16) |
>>>               s->regs.default_sc_right;
>
> What about using deposit64() which is uncontroversial?
>
>            val = deposit64(s->regs.default_sc_right, 16,
>                            13, s->regs.default_sc_bottom);

I can't make sense of that without going and looking what the arguments of 
this function are so I'd rather keep it simple. As I said, the values here 
can't be large enough to sign extend and there may be other similar cases 
that are already marked in Coverity. But if we still want to fix all of 
them then maybe we could try to make val uint32_t then do something about 
it once at the return for all cases. That seems better than trying to 
handle in each case inconsistently. The simplest would still be to tell 
Converity it's wrong here.

Regards,
BALATON Zoltan
--3866299591-1991432198-1773097198=:98453--


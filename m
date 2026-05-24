Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38988CD5BB1
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 21:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRGK1-0000VC-GO; Sun, 24 May 2026 17:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wRGJz-0000Ut-0L; Sun, 24 May 2026 17:25:19 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wRGJw-0004sJ-Ik; Sun, 24 May 2026 17:25:18 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D366F596942;
 Sun, 24 May 2026 23:25:10 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id R3STALKwON3X; Sun, 24 May 2026 23:25:08 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 92475596944; Sun, 24 May 2026 23:25:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 906835966F5;
 Sun, 24 May 2026 23:25:08 +0200 (CEST)
Date: Sun, 24 May 2026 23:25:08 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org, qemu-devel-bounces+chad=jablonski.xyz@nongnu.org
Subject: Re: [PATCH v2 2/7] ati-vga: Implement CCE/PM4 microcode register
 handling
In-Reply-To: <DIR5TO4BY98U.2E7PHJ6MND0QE@jablonski.xyz>
Message-ID: <f21aa188-4bf9-e087-a8a1-aad2fe9bc67d@eik.bme.hu>
References: <20260101035555.1300511-1-chad@jablonski.xyz>
 <20260101035555.1300511-3-chad@jablonski.xyz>
 <20a6233c-7214-01de-196d-117bf55d9563@eik.bme.hu>
 <DIR5TO4BY98U.2E7PHJ6MND0QE@jablonski.xyz>
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

On Sun, 24 May 2026, Chad Jablonski wrote:
>>> diff --git a/hw/display/ati.c b/hw/display/ati.c
>>> index 33f8e211dc..e291926470 100644
>>> --- a/hw/display/ati.c
>>> +++ b/hw/display/ati.c
>>> @@ -510,6 +510,31 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
>>>     case DEFAULT_SC_BOTTOM_RIGHT:
>>>         val = s->regs.default_sc_bottom_right;
>>>         break;
>>> +    case PM4_MICROCODE_ADDR:
>>> +        val = s->cce.microcode.addr;
>>> +        break;
>>> +    case PM4_MICROCODE_RADDR:
>>> +        val = 0;
>>
>> Should this return s->cce.microcode.raddr? (More comments below.)
>>
>
> Hardware testing shows that this register always returns 0 when read.
> https://codeberg.org/cjab/ati-tests/src/commit/55ddfe401f1fe5702a5f333b72b22e70a815fa02/tests/common/cce.c#L158-L165

Maybe it's worth a comment.

Regards,
BALATON Zoltan


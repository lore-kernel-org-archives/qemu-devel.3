Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6E6CD1288
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 22:36:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rs9D4-0001g3-KY; Wed, 03 Apr 2024 18:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rs9D2-0001fr-Go
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 18:35:56 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rs9Cz-0004k5-Rt
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 18:35:56 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C346E4E6026;
 Thu,  4 Apr 2024 00:35:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id hLCZZ9gHedpk; Thu,  4 Apr 2024 00:35:48 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 962A84E601C; Thu,  4 Apr 2024 00:35:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 951F57456FE;
 Thu,  4 Apr 2024 00:35:48 +0200 (CEST)
Date: Thu, 4 Apr 2024 00:35:48 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Gautam Bhat <mindentropy@gmail.com>
cc: Richard Henderson <richard.henderson@linaro.org>, 
 QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: Point where target instructions are read
In-Reply-To: <CAM2a4uxuY5PGrHLo72+i2p6Cj-1R37kiXOehrhRMKUn3Xaia=g@mail.gmail.com>
Message-ID: <b396634a-7406-7974-189b-a2b4fd37972b@eik.bme.hu>
References: <CAM2a4uwktAA=Uk9_GRnxusvHhfrZg+EUWjfxy95YgxGsQQntjA@mail.gmail.com>
 <dd957513-1272-40cf-bda5-4d3f717f3c71@linaro.org>
 <CAM2a4uxuY5PGrHLo72+i2p6Cj-1R37kiXOehrhRMKUn3Xaia=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-504818395-1712183748=:78889"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-504818395-1712183748=:78889
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 3 Apr 2024, Gautam Bhat wrote:
> On Tue, Apr 2, 2024 at 2:01 AM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>
>> The boot process must cooperate somehow.
>>
>> When using loader, you must link the image such that it loads at the pc reset address
>> defined by the architecture manual.
>>
>>
>> r~
>
> I changed my loading options to the following now to have better control:
>
> ./qemu-system-msp430 -machine msp430-launchpad -device
> loader,file=simple_test.bin,addr=0xFFFE,cpu-num=0,force
> -raw=on -d in_asm,out_asm

Check the docs on the generic loader: 
https://www.qemu.org/docs/master/system/generic-loader.html
I think when using cpu-num it will also set the PC but I don't know much 
about it. Maybe you could start qemu with -S option then do info registers 
in QEMU monitor to check the status to find out what's happening. If real 
board has firmware maybe you need to use that or emulate it in the board 
code if the boot loader exepects it to be present.

Regards,
BALATON Zoltan

> Here simple_test.bin is the raw binary file converted using objcopy.
> addr=0xFFFE is the vector location where the PC will load with the
> starting address.
>
> Now how do I load the address in that reset vector location and set my
> PC? Is there some example code that I can look at?
>
> -Gautam.
>
>
--3866299591-504818395-1712183748=:78889--


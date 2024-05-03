Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F390BC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 05:45:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2lim-0002xo-D7; Fri, 03 May 2024 01:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=qmem=MG=kaod.org=clg@ozlabs.org>)
 id 1s2lif-0002vN-Pq; Fri, 03 May 2024 01:44:31 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=qmem=MG=kaod.org=clg@ozlabs.org>)
 id 1s2lib-0000To-6q; Fri, 03 May 2024 01:44:29 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4VW09M1Wywz4wcR;
 Fri,  3 May 2024 15:44:07 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4VW09J6N8Sz4wyq;
 Fri,  3 May 2024 15:44:04 +1000 (AEST)
Message-ID: <e1875754-1b85-4f85-a9e0-d5cbe41b1711@kaod.org>
Date: Fri, 3 May 2024 07:44:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ppc/pnv: Begin a more complete ADU LPC model for
 POWER9/10
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Saif Abrar <saif.abrar@linux.vnet.ibm.com>
References: <20240417110215.808926-1-npiggin@gmail.com>
 <20240417110215.808926-2-npiggin@gmail.com>
 <577fd77f-a6b9-41f5-8193-f2cc80503a7d@kaod.org>
 <D0YBCHP9K12V.3JU88W5WITYRM@gmail.com>
 <272a9f32-8d32-4681-b25b-9d45c6c787b5@kaod.org>
 <D0ZQN2YAQ28S.3FGETJPE6XVC8@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <D0ZQN2YAQ28S.3FGETJPE6XVC8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=qmem=MG=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_FAIL=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 5/3/24 06:51, Nicholas Piggin wrote:
> On Thu May 2, 2024 at 6:47 PM AEST, Cédric Le Goater wrote:
>> On 5/1/24 14:39, Nicholas Piggin wrote:
>>> On Wed Apr 17, 2024 at 9:25 PM AEST, Cédric Le Goater wrote:
>>>> Hello Nick,
>>>>
>>>> On 4/17/24 13:02, Nicholas Piggin wrote:
>>>>> This implements a framework for an ADU unit model.
>>>>>
>>>>> The ADU unit actually implements XSCOM, which is the bridge between MMIO
>>>>> and PIB. However it also includes control and status registers and other
>>>>> functions that are exposed as PIB (xscom) registers.
>>>>>
>>>>> To keep things simple, pnv_xscom.c remains the XSCOM bridge
>>>>> implementation, and pnv_adu.c implements the ADU registers and other
>>>>> functions.
>>>>>
>>>>> So far, just the ADU no-op registers in the pnv_xscom.c default handler
>>>>> are moved over to the adu model.
>>>>>
>>>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>>>> ---
>>>>>     include/hw/ppc/pnv_adu.h   |  34 ++++++++++++
>>>>>     include/hw/ppc/pnv_chip.h  |   3 +
>>>>>     include/hw/ppc/pnv_xscom.h |   6 ++
>>>>>     hw/ppc/pnv.c               |  16 ++++++
>>>>>     hw/ppc/pnv_adu.c           | 111 +++++++++++++++++++++++++++++++++++++
>>>>>     hw/ppc/pnv_xscom.c         |   9 ---
>>>>>     hw/ppc/meson.build         |   1 +
>>>>>     hw/ppc/trace-events        |   4 ++
>>>>>     8 files changed, 175 insertions(+), 9 deletions(-)
>>>>>     create mode 100644 include/hw/ppc/pnv_adu.h
>>>>>     create mode 100644 hw/ppc/pnv_adu.c
>>>>>
>>>>> diff --git a/include/hw/ppc/pnv_adu.h b/include/hw/ppc/pnv_adu.h
>>>>> new file mode 100644
>>>>> index 0000000000..9dc91857a9
>>>>> --- /dev/null
>>>>> +++ b/include/hw/ppc/pnv_adu.h
>>>>> @@ -0,0 +1,34 @@
>>>>> +/*
>>>>> + * QEMU PowerPC PowerNV Emulation of some ADU behaviour
>>>>> + *
>>>>> + * Copyright (c) 2024, IBM Corporation.
>>>>> + *
>>>>> + * SPDX-License-Identifier: LGPL-2.1-or-later
>>>>
>>>>
>>>> Did you mean GPL-2.0-or-later ?
>>>
>>> Hey Cedric,
>>>
>>> Thanks for reviewing, I've been away so sorry for the late reply.
>>>
>>> It just came from one of the headers I copied which was LGPL. But
>>> there's really nothing much in it and could find a GPL header to
>>> copy. Is GPL-2.0-or-later preferred?
>>
>> I would since all pnv models are GPL.
> 
> Some of pnv is actually LGPL. 

I was grepping for 'LGPL' and not 'Lesser' ... Indeed you are right.
Most files miss an SPDX-License-Identifier tag also.

> That's okay I'll change to GPL.

LGPL is more relaxed if the code needs to be used in libraries, but
I am not sure it applies to the PNV models. What would you prefer ?

C.

  
>> I think some parts of QEMU were initially LGPL (there used to be
>> a library, may be that's the reason ?) and other parts are relaxed
>> to LGPL because they are reused in libraries.
> 
> Thanks,
> Nick



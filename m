Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 879EEC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 08:33:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2RsL-0004ve-Q7; Thu, 02 May 2024 04:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=l4T0=MF=kaod.org=clg@ozlabs.org>)
 id 1s2RsH-0004vF-TP; Thu, 02 May 2024 04:33:05 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=l4T0=MF=kaod.org=clg@ozlabs.org>)
 id 1s2RsG-0002sa-7Z; Thu, 02 May 2024 04:33:05 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4VVRyf1dmYz4wck;
 Thu,  2 May 2024 18:32:58 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4VVRyb5YBTz4xFg;
 Thu,  2 May 2024 18:32:55 +1000 (AEST)
Message-ID: <1911763b-53ba-4816-96b8-f8720b8c5634@kaod.org>
Date: Thu, 2 May 2024 10:32:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ppc/pnv: Implement ADU access to LPC space
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Saif Abrar <saif.abrar@linux.vnet.ibm.com>
References: <20240417110215.808926-1-npiggin@gmail.com>
 <20240417110215.808926-3-npiggin@gmail.com>
 <f8b689f4-50b0-4f96-bd64-21b9eda6862e@kaod.org>
 <D0YBEWF2CP6Q.121MBJ0QG4HS1@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <D0YBEWF2CP6Q.121MBJ0QG4HS1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=l4T0=MF=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Nick,


>>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>>> index 5869aac89a..eb9dbc62dd 100644
>>> --- a/hw/ppc/pnv.c
>>> +++ b/hw/ppc/pnv.c
>>> @@ -1642,6 +1642,8 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
>>>        }
>>>    
>>>        /* ADU */
>>> +    object_property_set_link(OBJECT(&chip9->adu), "lpc", OBJECT(&chip9->lpc),
>>> +                             &error_abort);
>>
>> I would add an assert on the lpc pointer in the ADU realize routine.
> 
> A assert != NULL, in case this failed to link correctly? (Maybe if it
> was called before lpc object was realized). I will do.

It is to make sure that an ADU object is not "realized" without
the pointer '->lpc' being set before, since it is a must-have for
the implementation to operate (and do LPC transactions).

There are several :

    assert(s->chip);

in the pnv models for the same kind of purpose.

Thanks,

C.





Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1518ECAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 16:08:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyuhE-0001o5-EN; Wed, 17 Sep 2025 12:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uyuh8-0001mf-HE; Wed, 17 Sep 2025 12:07:48 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uyuh0-0008Gx-Ee; Wed, 17 Sep 2025 12:07:46 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 27AB056F2D1;
 Wed, 17 Sep 2025 18:07:36 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 4d_VPj-O1y-0; Wed, 17 Sep 2025 18:07:33 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id CBC3656F2AE; Wed, 17 Sep 2025 18:07:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C943C56F295;
 Wed, 17 Sep 2025 18:07:33 +0200 (CEST)
Date: Wed, 17 Sep 2025 18:07:33 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Miles Glenn <milesg@linux.ibm.com>
cc: Thomas Huth <thuth@redhat.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@redhat.com, 
 npiggin@gmail.com, rathc@linux.ibm.com, richard.henderson@linaro.org
Subject: Re: [PATCH v4 6/9] target/ppc: Add IBM PPE42 special instructions
In-Reply-To: <14ea64c1c7c2f9e154b0d607d88b737adb067127.camel@linux.ibm.com>
Message-ID: <2e4a6d39-650e-74a4-ad60-56d5422c83a1@eik.bme.hu>
References: <20250912164808.371944-1-milesg@linux.ibm.com>
 <20250912164808.371944-7-milesg@linux.ibm.com>
 <a419ef55-d0d5-4d88-8302-ebcc9a8c4bab@linux.ibm.com>
 <db99b84a-4d7c-49af-8185-97db09843006@redhat.com>
 <14ea64c1c7c2f9e154b0d607d88b737adb067127.camel@linux.ibm.com>
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

On Wed, 17 Sep 2025, Miles Glenn wrote:
> On Wed, 2025-09-17 at 08:20 +0200, Thomas Huth wrote:
>> On 17/09/2025 06.57, Harsh Prateek Bora wrote:
>>>
>>> On 9/12/25 22:17, Glenn Miles wrote:
>>>> Adds the following instructions exclusively for
>>>> IBM PPE42 processors:
>>>>
>>>>    LSKU
>>>>    LCXU
>>>>    STSKU
>>>>    STCXU
>>>>    LVD
>>>>    LVDU
>>>>    LVDX
>>>>    STVD
>>>>    STVDU
>>>>    STVDX
>>>>    SLVD
>>>>    SRVD
>>>>    CMPWBC
>>>>    CMPLWBC
>>>>    CMPWIBC
>>>>    BNBWI
>>>>    BNBW
>>>>    CLRBWIBC
>>>>    CLRWBC
>>>>    DCBQ
>>>>    RLDICL
>>>>    RLDICR
>>>>    RLDIMI
>>>>
>>>> A PPE42 GCC compiler is available here:
>>>> https://github.com/open-power/ppe42-gcc
>>>>
>>>> For more information on the PPE42 processors please visit:
>>>> https://wiki.raptorcs.com/w/images/a/a3/PPE_42X_Core_Users_Manual.pdf
>>>>
>>>> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
>>>> ---
>>>> Changes from v3:
>>>>    - Removed copy of CHECK_VDR
>>>>    - Refactored ld/st instructions
>>>>
>>>>   target/ppc/insn32.decode            |  66 ++-
>>>>   target/ppc/translate.c              |  29 +-
>>>>   target/ppc/translate/ppe-impl.c.inc | 665 ++++++++++++++++++++++++++++
>>>>   3 files changed, 750 insertions(+), 10 deletions(-)
>>>>   create mode 100644 target/ppc/translate/ppe-impl.c.inc
>>>>
>>>
>>> <snip>
>>>
>>>> diff --git a/target/ppc/translate/ppe-impl.c.inc b/target/ppc/translate/
>>>> ppe-impl.c.inc
>>>> new file mode 100644
>>>> index 0000000000..792103d7c2
>>>> --- /dev/null
>>>> +++ b/target/ppc/translate/ppe-impl.c.inc
>>>> @@ -0,0 +1,665 @@
>>>> +/*
>>>> + * IBM PPE Instructions
>>>> + *
>>>> + * Copyright (c) 2025, IBM Corporation.
>>>> + *
>>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>>> + */
>>>> +
>>>> +
>>>> +#if !defined(TARGET_PPC64)
>>>> +static bool vdr_is_valid(uint32_t vdr)
>>>> +{
>>>> +    const uint32_t valid_bitmap = 0xf00003ff;
>>>> +    return !!((1ul << (vdr & 0x1f)) & valid_bitmap);
>>>> +}
>>>> +
>>>> +static bool ppe_gpr_is_valid(uint32_t reg)
>>>> +{
>>>> +    const uint32_t valid_bitmap = 0xf00027ff;
>>>> +    return !!((1ul << (reg & 0x1f)) & valid_bitmap);
>>>> +}
>>>> +#endif
>>>> +
>>>> +#define CHECK_VDR(CTX, VDR)                             \
>>>> +    do {                                                \
>>>> +        if (unlikely(!vdr_is_valid(VDR))) {             \
>>>> +            gen_invalid(CTX);                           \
>>>> +            return true;                                \
>>>> +        }                                               \
>>>> +    } while (0)
>>>> +
>>>> +#define CHECK_PPE_GPR(CTX, REG)                         \
>>>> +    do {                                                \
>>>> +        if (unlikely(!ppe_gpr_is_valid(REG))) {         \
>>>> +            gen_invalid(CTX);                           \
>>>> +            return true;                                \
>>>> +        }                                               \
>>>> +    } while (0)
>>>> +
>>>> +#define VDR_PAIR_REG(VDR) (((VDR) + 1) & 0x1f)
>>>> +
>>>> +#define CHECK_PPE_LEVEL(CTX, LVL)                       \
>>>> +    do {                                                \
>>>> +        if (unlikely(!((CTX)->insns_flags2 & (LVL)))) { \
>>>> +            gen_invalid(CTX);                           \
>>>> +            return true;                                \
>>>> +        }                                               \
>>>> +    } while (0)
>>>> +
>>>> +static bool trans_LCXU(DisasContext *ctx, arg_LCXU *a)
>>>> +{
>>>> +#if defined(TARGET_PPC64)
>>>> +    return false;
>>>> +#else
>>>
>>> If we are building the PPE42 instructions only for !TARGET_PPC64, does
>>> it still make it usable with qemu-system-ppc64?
>>
>> As explained in an earlier thread already, qemu-system-ppc64 is a superset
>> of qemu-system-ppc. Thus the ppe42 stuff should work in qemu-system-ppc64, too.
>>
>>   Thomas
>>
>
> Ah, yes, I don't think I fully understood the ramifications of Thomas's
> statements earlier.  Looks like I'll need to scrub the code to ensure
> that PPE42 can run even if TARGET_PPC64 is defined.
>
> Cedric, this requires me to change my response to your request to add
> the check for TARGET_PPC64 inside the is_ppe() function.  I will need
> to leave that function as-is if we want PPE42 to be supported in both
> targets.  Will you be ok with that?

Does it make sense to support it with !TARGET_PPC64 if its only use is in 
qemu-system-ppc64? Even if the CPU is 32-bit it has some 64-bit 
instructions IIUC so does that make it TARGET_PPC64 only?

Regards,
BALATON Zoltan


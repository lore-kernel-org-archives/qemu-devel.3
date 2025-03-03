Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3115C19F32
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 00:35:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1totky-0006da-KQ; Sun, 02 Mar 2025 19:34:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1totkw-0006dD-C1; Sun, 02 Mar 2025 19:34:02 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1totkr-0005Iu-Hk; Sun, 02 Mar 2025 19:33:59 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5FDC14E6162;
 Mon, 03 Mar 2025 01:33:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id wrONbx0xW5Ne; Mon,  3 Mar 2025 01:33:49 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 165DE4E6010; Mon, 03 Mar 2025 01:33:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1451274577C;
 Mon, 03 Mar 2025 01:33:49 +0100 (CET)
Date: Mon, 3 Mar 2025 01:33:49 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] hw/ppc/e500: Partial implementation of local access
 window registers
In-Reply-To: <24E72FE6-E2AE-4BF4-9273-1B915908EE2E@gmail.com>
Message-ID: <7a21d5d7-01f7-daab-a94f-28b32344df6b@eik.bme.hu>
References: <20250115211544.307124E602F@zero.eik.bme.hu>
 <aabb2da4-3eaa-2a5f-b461-01727c380372@eik.bme.hu>
 <24E72FE6-E2AE-4BF4-9273-1B915908EE2E@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1929920270-1740962029=:7747"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1929920270-1740962029=:7747
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sun, 2 Mar 2025, Bernhard Beschow wrote:
> Am 1. März 2025 16:10:35 UTC schrieb BALATON Zoltan <balaton@eik.bme.hu>:
>> On Wed, 15 Jan 2025, BALATON Zoltan wrote:
>>> This allows guests to set the CCSR base address. Also store and return
>>> values of the local access window registers but their functionality
>>> isn't implemented.
>>
>> Bernhard,
>
> Hi Zoltan,
>
>>
>> If you have no alternative patch you plan to submit for next release 
>> should we merge this for now? This helps running u-boot binaries even 
>> if it's not enough alone but would be one patch less in my local tree. 
>> Or do you know about a problem with this patch why this should not be 
>> merged?
>
> QEMU sets a machine-specific CCSR base address (pmc->ccsrbar_base) which 
> differs from the real chip's default. The default is checked by U-Boot 
> which enters an infinite loop on mismatch: 
> <https://source.denx.de/u-boot/u-boot/-/blob/v2024.07/arch/powerpc/cpu/mpc85xx/start.S#L614>. 
> How does this work for you?

The U-Boot version I've tested (or something else, I don't remember) 
wanted to set the CCSRBAR to the value it expects which is different from 
where it looks for it at reset and that works with this patch. I don't 
know which code path that corresponds to in start.S.

> In addition, when moving the CCSR region, `env->mpic_iack` should be 
> updated as well: 
> <https://gitlab.com/qemu-project/qemu/-/blob/v9.2.2/hw/ppc/e500.c?ref_type=tags#L969>

I did not notice that. Maybe it's only relevant with KVM and I've only 
tested with TCG or could be I did not get to the part yet when this would 
cause problems. I don't see an easy way to update this as these are in 
separate places and also don't know how this mpic_iack is handled with 
multiple cores. So in case this patch breaks this then it's OK to drop it 
for now. I can carry it locally until fixed upstream.

> I'm happy to submit an implementation on top of my e500 cleanup series 
> <https://patchew.org/QEMU/20241103133412.73536-1-shentey@gmail.com/> 
> which needs agreement on some open discussions.

Some of that series was already merged. What are the outstanding patches 
and discussions? I don't remember seeing an updated version of that series 
with only the outstanding patches.

Regards,
BALATON Zoltan
--3866299591-1929920270-1740962029=:7747--


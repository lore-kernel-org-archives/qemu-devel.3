Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E659CC36000
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 13:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tutFO-0006hS-90; Wed, 19 Mar 2025 09:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tutFL-0006gx-GW; Wed, 19 Mar 2025 09:14:11 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tutFJ-0005ti-8j; Wed, 19 Mar 2025 09:14:11 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D9C7B4E601B;
 Wed, 19 Mar 2025 14:14:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id R55wcFVAAHgO; Wed, 19 Mar 2025 14:14:05 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 034424E6005; Wed, 19 Mar 2025 14:14:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 01AFE74577C;
 Wed, 19 Mar 2025 14:14:05 +0100 (CET)
Date: Wed, 19 Mar 2025 14:14:04 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Michael Tokarev <mjt@tls.msk.ru>
cc: qemu-devel <qemu-devel@nongnu.org>, qemu-PowerPC <qemu-ppc@nongnu.org>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: vof-nvram.bin: what it is and how it is used?
In-Reply-To: <2176cec3-8957-425f-8b50-e48b1f6ff4dc@tls.msk.ru>
Message-ID: <6f29bd39-5855-c2c4-80b3-0873c7387897@eik.bme.hu>
References: <2176cec3-8957-425f-8b50-e48b1f6ff4dc@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Wed, 19 Mar 2025, Michael Tokarev wrote:
> Hi!
>
> Commit fc8c745d50150a63f6c "spapr: Implement Open Firmware client interface"
> in Jun-2021 added a new file, pc-bios/vof-nvram.bin, to qemu sources.
>
> But there's nothing in the sources which refers to this file, and there's
> no mentions about its contents and how it has been generated.
>
> What's the procedure to create this image?  It would be great if such
> procedure can be run during package build time to generate this image anew.
>
> How it is supposed to be used?

See hw/ppc/spapr.c::spapr_create_nvram(). Looks like it would add a drive 
give with -drive if=pflash,index=0 as the nvram backing file. I don't know 
if it generates the default if an empty file is passed or maybe SLOF would 
do that which then could be used for VOF too and that's how it was made? 
So you could try running -machine spapr with an empty nvram with slof then 
compare that to the default for VOF.

> Should it be shipped in a downstream distribution?

If is't not auto-created with the default values and not easy to create 
then maybe more convenient for users to get an example.

Regards,
BALATON Zoltan


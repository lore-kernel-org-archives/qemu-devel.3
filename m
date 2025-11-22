Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F9ECFC52A
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 12:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMmWT-0003nP-2k; Sat, 22 Nov 2025 07:15:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vMmVv-00038M-DW
 for qemu-devel@nongnu.org; Sat, 22 Nov 2025 07:14:51 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vMmVm-00066Q-4J
 for qemu-devel@nongnu.org; Sat, 22 Nov 2025 07:14:49 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7EA4F5969FB;
 Sat, 22 Nov 2025 13:14:26 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id t3A548pqN4gL; Sat, 22 Nov 2025 13:14:24 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 307CE5969FA; Sat, 22 Nov 2025 13:14:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2F0395969F7;
 Sat, 22 Nov 2025 13:14:24 +0100 (CET)
Date: Sat, 22 Nov 2025 13:14:24 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Michael Tokarev <mjt@tls.msk.ru>
cc: QEMU Development <qemu-devel@nongnu.org>
Subject: Re: A few more patches for u-boot-sam460ex (based on 10.2.0-rc1)
In-Reply-To: <9101680c-9b01-4ca8-b54d-15d01451f592@tls.msk.ru>
Message-ID: <2cededf4-2b69-9893-521d-add9a2eb43f8@eik.bme.hu>
References: <9101680c-9b01-4ca8-b54d-15d01451f592@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
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

Hello,

On Wed, 19 Nov 2025, Michael Tokarev wrote:
> Almost an year ago I submitted a few patches for
> u-boot-sam460ex code so it can be built by a
> current gcc:
> https://lists.nongnu.org/archive/html/qemu-devel/2025-01/msg00767.html
>
> Here's another try.  Some of the old issues are
> now gone, some remains, and some new emerged.

Thanks but maybe try upstream at https://acube-systems.biz/ as they are 
still maintaining this U-Boot version and I don't want to diverge too much 
from it so it's easier to update it when a new version comes from 
upstream. (There's already a version newer than the one we have in QEMU 
but that did not work with the emulation for some reason and I did not 
have time to find out why so went with the last version that works as that 
already has the USB fixes we needed and newer version does not have 
anything we need yet but maybe in the future we'll want to update 
further.)

> The below set allows me to build u-boot-sam460ex
> code with gcc-15.
>
> Some bugs are rather harsh and has been there for
> a long time (like multiple definition of fbi symbol -
> the file has been moved to a different dir, but the
> prob remains - it is really a bad code).
>
> Some are harsh but new (the reuse of `failed' variable -
> any compiler, even ancient gcc4, should've catched it).
>
> And some are due to too old code (supporting only gcc4).

The code may be bad and also based on an old U-Boot version that did not 
have support for newer compilers but apparently it works on real boards 
which we try to emulate so I'd like to keep the firmware close to that one 
including bugs so it works the same as the real machine.

For things fixed in newer U-Boot versions it may be better to cherry-pick 
from there and for things that broke because of -Werror settings in Debian 
different from gcc defaults it makes sense to carry patches for that in 
Debian or merge upstream and not just in QEMU.

Regards,
BALATON Zoltan


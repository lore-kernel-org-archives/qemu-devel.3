Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED89C3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 12:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbIx5-0000Vq-Oc; Tue, 06 Aug 2024 08:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sbIwx-0000Tv-UM; Tue, 06 Aug 2024 08:06:00 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sbIwu-00016M-7x; Tue, 06 Aug 2024 08:05:59 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 621894E6001;
 Tue, 06 Aug 2024 14:05:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id XUKk3km_KKnR; Tue,  6 Aug 2024 14:05:43 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2CF024E6000; Tue, 06 Aug 2024 14:05:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2B76374577C;
 Tue, 06 Aug 2024 14:05:43 +0200 (CEST)
Date: Tue, 6 Aug 2024 14:05:43 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Michael Tokarev <mjt@tls.msk.ru>
cc: QEMU Developers <qemu-devel@nongnu.org>, 
 QEMU PowerPC <qemu-ppc@nongnu.org>
Subject: Re: u-boot-sam460ex fixes
In-Reply-To: <142f2839-578c-4dc5-a837-ffacdc18d8c4@tls.msk.ru>
Message-ID: <e7f76eae-22d1-636a-c764-c1320a5339a2@eik.bme.hu>
References: <142f2839-578c-4dc5-a837-ffacdc18d8c4@tls.msk.ru>
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

Hello,

On Sat, 3 Aug 2024, Michael Tokarev wrote:
> It's been a long time since everyone's fighting with u-boot-sam460ex 
> code which is very bad, suffers from countless issues.
>
> For one, it does not compile for quite a long time with current compilers.

QEMU comes with a binary so normally there's no reason to compile it for 
most people so I don't think everyone has to fight with it. You're the 
first who complained.

> For example, here are changes which I apply to this code when building 
> things on Debian: 
> https://salsa.debian.org/qemu-team/qemu/-/tree/master/debian/patches/ 
> (see u-boot-sam460ex-* files in there).  I just created another patch, 
> u-boot-sam460ex-build.patch, to address numerous new issues revealed by 
> gcc-14 and its new defaults in Debian.
>
> Please note that most of the last patch are actually just workarounds, 
> not real fixes, - real fixes needs much more than that.
>
> For example, there are a LOT of *conflicting* function declarations in 
> .c files where the functions are being used, instead of writing them in 
> a common .h file and including in both users and where it's defined.

It is based on an old U-Boot version but it needs sam460ex specific 
patches that weren't upstreamed by the vendor of this machine so we have 
to use this old version.

> There are a lot of free conversions between pointer and integer. Some of the
> functions almost always used with a pointer but expects an integer, or vise
> versa.
>
> This code is awful.
>
> But.
>
> Can at least this minimal set of changes be comitted, to let this source to
> be compiled at least somehow?  For the benefit of everyone.
>
> The last patch (-build) also fixes a real bug:
>
> 	char arr[8] = { 0 };
> -	i2c_write(0x68, 0x08, 1, &arr, 8);
> +	i2c_write(0x68, 0x08, 1, arr, 8);

I could push some of the fixes but there's an updated firmware version 
from the vendor since which may be based on a newer U-Boot (still an old 
one from 2015 or before) but has newer version of the sam460ex patches 
that may fix some of the problems. So maybe it's better to look at 
updating to that version. I would not touch it for 9.1 though as the 
current one is at least known to work, so I don't want to break it just 
before the release and also don't have time for it now.

Regards,
BALATON Zoltan


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82670C3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 12:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbJ0f-0000UL-G5; Tue, 06 Aug 2024 08:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sbJ0W-0000D4-N4; Tue, 06 Aug 2024 08:09:41 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sbJ0R-0001gz-ER; Tue, 06 Aug 2024 08:09:40 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 98C184E602E;
 Tue, 06 Aug 2024 14:09:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id Auc9EGOWeYZ5; Tue,  6 Aug 2024 14:09:29 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6F0DB4E601B; Tue, 06 Aug 2024 14:09:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6DEAB74577C;
 Tue, 06 Aug 2024 14:09:29 +0200 (CEST)
Date: Tue, 6 Aug 2024 14:09:29 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>, 
 QEMU PowerPC <qemu-ppc@nongnu.org>
Subject: Re: u-boot-sam460ex fixes
In-Reply-To: <D38CKY8VZYDW.6M3KDSQTX0VZ@gmail.com>
Message-ID: <68a69072-f9c9-15d2-778a-ec4a5f0b80a0@eik.bme.hu>
References: <142f2839-578c-4dc5-a837-ffacdc18d8c4@tls.msk.ru>
 <D38CKY8VZYDW.6M3KDSQTX0VZ@gmail.com>
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

On Tue, 6 Aug 2024, Nicholas Piggin wrote:
> On Sat Aug 3, 2024 at 6:40 PM AEST, Michael Tokarev wrote:
>> Hi!
>>
>> It's been a long time since everyone's fighting with u-boot-sam460ex code which is
>> very bad, suffers from countless issues.
>>
>> For one, it does not compile for quite a long time with current compilers.
>>
>> For example, here are changes which I apply to this code when building things on
>> Debian: https://salsa.debian.org/qemu-team/qemu/-/tree/master/debian/patches/
>> (see u-boot-sam460ex-* files in there).  I just created another patch,
>> u-boot-sam460ex-build.patch, to address numerous new issues revealed by gcc-14
>> and its new defaults in Debian.
>>
>> Please note that most of the last patch are actually just workarounds, not real
>> fixes, - real fixes needs much more than that.
>>
>> For example, there are a LOT of *conflicting* function declarations in .c files
>> where the functions are being used, instead of writing them in a common .h file
>> and including in both users and where it's defined.
>>
>> There are a lot of free conversions between pointer and integer. Some of the
>> functions almost always used with a pointer but expects an integer, or vise
>> versa.
>>
>> This code is awful.
>>
>> But.
>>
>> Can at least this minimal set of changes be comitted, to let this source to
>> be compiled at least somehow?  For the benefit of everyone.
>>
>> The last patch (-build) also fixes a real bug:
>>
>>   	char arr[8] = { 0 };
>> -	i2c_write(0x68, 0x08, 1, &arr, 8);
>> +	i2c_write(0x68, 0x08, 1, arr, 8);
>
> Not sure about u-boot. Have you tried to get the patches upstreamed?

The sam360ex u-boot is changed from upstream U-Boot by the vendor of the 
machine and they did not upstream it, that's why we can't use the same 
u-boot that's used for e500 and need a separate version. The repo for 
sam460ex is mirrored from my repo so I could change it but maybe better 
postpone it after the release and then look at updating to the latest 
firmware version and then fix bugs in that.

Regards,
BALATON Zoltan


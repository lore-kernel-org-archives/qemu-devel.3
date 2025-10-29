Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6EBFCCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 13:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE6hG-0005G7-78; Wed, 29 Oct 2025 09:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vE6hC-0005FZ-Cc; Wed, 29 Oct 2025 09:58:38 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vE6h7-0004zK-Rs; Wed, 29 Oct 2025 09:58:37 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 11504597300;
 Wed, 29 Oct 2025 14:58:31 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id uV7293Zpf0sI; Wed, 29 Oct 2025 14:58:28 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A82835972FD; Wed, 29 Oct 2025 14:58:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A69105972E8;
 Wed, 29 Oct 2025 14:58:28 +0100 (CET)
Date: Wed, 29 Oct 2025 14:58:28 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Cl=E9ment_Chigot?= <chigot@adacore.com>
cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, hreitz@redhat.com, 
 qemu-block@nongnu.org
Subject: Re: [PATCH 2/5] vvfat: move fat_type check prior to size setup
In-Reply-To: <CAJ307Eg_YngaeBukZjpr81iGJCm+ycwZHj_aPuxU_8tuSC9MPw@mail.gmail.com>
Message-ID: <7f81bcff-9262-b092-42b4-f7e19b302f97@eik.bme.hu>
References: <20250903075721.77623-1-chigot@adacore.com>
 <20250903075721.77623-3-chigot@adacore.com> <aPp2eRW7gQfv4hT7@redhat.com>
 <CAJ307Eg_YngaeBukZjpr81iGJCm+ycwZHj_aPuxU_8tuSC9MPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1772260342-1761746308=:62650"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1772260342-1761746308=:62650
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 29 Oct 2025, Clément Chigot wrote:
> On Thu, Oct 23, 2025 at 8:40 PM Kevin Wolf <kwolf@redhat.com> wrote:
>>
>> Am 03.09.2025 um 09:57 hat Clément Chigot geschrieben:
>>> This allows to handle the default FAT size in a single place and make the
>>> following part taking care only about size parameters. It will be later
>>> moved away in a specific function.
>>>
>>> Setting a floppy disk of 1MB is no longer possible as it was a side
>>> effect of passing "fat-type=12". To be precise there were three cases:
>>>  - fat-type undefined (aka default): a fat12 2MB disk
>>>  - fat-type=16: a fat16 2Mb disk
>>>  - fat-type=12: a fat12 1Mb disk
>>
>> That's quite a strange interface!
>>
>> If we're touching it anyway, I would change it to make the more common
>> format (1.44 MB) the default for FAT12 and make the 2.88 MB FAT12 floppy
>> temporarily unavailable and later require an explicit size. This way
>> both sizes would still be available using the fat-type.
>
> I'm a bit hesitant to change the default behavior as people might be
> using it without clear knowledge of it. True, "floppy" is probably not
> a widely used feature but still.
> Do QEMU have some specific guidelines when changing such default
> behavior ? Adding a warning ? Or just a comment in the changelog would
> be enough ?

https://www.qemu.org/docs/master/about/deprecated.html

Usually you'd add a warning and list it in the docs as deprecated then can 
make the change after it was deperecated for two releases.

Regards,
BALATON Zoltan
--3866299591-1772260342-1761746308=:62650--


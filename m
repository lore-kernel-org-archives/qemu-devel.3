Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398F4C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 12:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taZiN-00080y-Os; Wed, 22 Jan 2025 07:20:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1taZiJ-0007wt-Mm; Wed, 22 Jan 2025 07:20:08 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1taZiE-0004DU-6U; Wed, 22 Jan 2025 07:20:05 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 098ED4E6000;
 Wed, 22 Jan 2025 13:19:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 26jCIu88WR-h; Wed, 22 Jan 2025 13:19:53 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D4F4D4E601D; Wed, 22 Jan 2025 13:19:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D2FDA74577C;
 Wed, 22 Jan 2025 13:19:53 +0100 (CET)
Date: Wed, 22 Jan 2025 13:19:53 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Michael Tokarev <mjt@tls.msk.ru>
cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?ISO-8859-15?Q?Volker_R=FCmelin?= <vr_qemu@t-online.de>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] vvfat: fix out of bounds array write
In-Reply-To: <1e2389b1-07c5-49dd-96c6-8bac84d7c95e@tls.msk.ru>
Message-ID: <05a22f99-65c2-299f-a180-ba02289dff67@eik.bme.hu>
References: <20250105135929.6286-1-vr_qemu@t-online.de>
 <f616a4b4-2161-42c8-9f92-e3a939ba173a@tls.msk.ru>
 <54df1904-0e2c-4c4f-b242-1c8865ad0af1@linaro.org>
 <1e2389b1-07c5-49dd-96c6-8bac84d7c95e@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Wed, 22 Jan 2025, Michael Tokarev wrote:
> 22.01.2025 02:14, Pierrick Bouvier wrote:
> ..
>> I agree the existing code (and this patch) is pretty cryptic for anyone not 
>> familiar with FAT format.
>> However, I think it could be a good thing to first merge this one (which is 
>> correct, and works), and refactor this in a second time, so the current 
>> ubsan issue is fixed upstream as soon as possible.
>
> For an actual *fix*, please take a look at
> https://lore.kernel.org/qemu-devel/20250119093233.9E4C450B6D@localhost.tls.msk.ru/
>
> which is minimal, understandable, verified and works.

Just noticed in that patch you have several &(s->directory) where () is 
not needed, -> is higher priority than & (address_of).

Regards,
BALATON Zoltan


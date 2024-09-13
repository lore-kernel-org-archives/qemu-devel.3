Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5821AFA374B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 13:01:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp5vE-0004d1-LR; Fri, 13 Sep 2024 09:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sp5uz-0004aQ-3f
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 09:01:00 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sp5ux-000873-61
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 09:00:56 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1809E4E602B;
 Fri, 13 Sep 2024 15:00:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id pEkiyLT10Mlr; Fri, 13 Sep 2024 15:00:50 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2454E4E6004; Fri, 13 Sep 2024 15:00:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2210F746F60;
 Fri, 13 Sep 2024 15:00:50 +0200 (CEST)
Date: Fri, 13 Sep 2024 15:00:50 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: "Michael S. Tsirkin" <mst@redhat.com>
cc: qemu-devel@nongnu.org, philmd@linaro.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Bernhard Beschow <shentey@gmail.com>
Subject: Re: [PATCH 0/2] Solve vt82c686 qemu_irq leak.
In-Reply-To: <20240910030754-mutt-send-email-mst@kernel.org>
Message-ID: <7bb40daf-2b1a-e1b6-5977-543cb318c884@eik.bme.hu>
References: <cover.1719690591.git.balaton@eik.bme.hu>
 <20240910030754-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

On Tue, 10 Sep 2024, Michael S. Tsirkin wrote:
> On Sat, Jun 29, 2024 at 10:01:52PM +0200, BALATON Zoltan wrote:
>> This is an alternative appriach to solve the qemu_irq leak in
>> vt82c686. Allowing embedding an irq and init it in place like done
>> with other objects may allow cleaner fix for similar issues and I also
>> plan to use this for adding qemu_itq to pegasos2 machine state for
>> which gpio would not work.
>>
>> BALATON Zoltan (2):
>>   hw: Move declaration of IRQState to header and add init function
>>   hw/isa/vt82c686.c: Embed i8259 irq in device state instead of
>>     allocating
>
> This looked like a simpler approach to shut up analyzer warnings, so I
> picked this one.

Thanks. Looks like you had some mixup with adding your Signed-off-by 
though but I did not notice that in the pull request only now that it 
landed in master. (Just in case this can be corrected somehow in git but 
otherwise it probably does not matter much.)

Regards,
BALATON Zoltan


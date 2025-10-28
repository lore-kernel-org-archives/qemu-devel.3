Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 519D8CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 16:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDmjh-0006rI-6B; Tue, 28 Oct 2025 12:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vDmjc-0006kK-A7; Tue, 28 Oct 2025 12:39:49 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vDmjT-0004bZ-42; Tue, 28 Oct 2025 12:39:47 -0400
Received: from [192.168.10.110] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 59SGdOLI080237
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 29 Oct 2025 01:39:24 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=wLbBfSnrvT6i4Jj0yq+OoqapAMrzdiKbsvRg3kKRVyk=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1761669564; v=1;
 b=B8YXbRR0eBF+clIKTyYhugmR+p1e71Q4yGg0K4n0IGOPRVGlnQ5Ey2fWqUkxFK3N
 mFFRfrhdGsMef/YpZiT4+bLwxSxvBNdwAiAMsqOHZF+BP8WbtRKJR3H1uE/eZI+w
 Rcm/GE845oSMwORFymTkbhgUNFnKO4NgDm1N8VgEtyM3zgRMQOMxSDGpGe6BPp6H
 J4rwdLBjLVU4gCVNQomQtykZ8VwqyE1PPxVGXySCVu48koiqZEY05NrNUAVojb1o
 Qi6rXCHpXJ/AsO5VFbVYUUHLtOGVXPA7D6BL2XBXOqmzHqmX7PVQ5eXO/gyR5C8K
 OdtbrFgSIGlZ2bo+tAJbkg==
Message-ID: <02ba10ef-63fc-4843-b906-1bb127adecbf@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 29 Oct 2025 01:39:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ds1225y: Fix nvram MemoryRegion owner
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <arikalo@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>
References: <20251027-ds1225y-v1-1-406888eb495f@rsg.ci.i.u-tokyo.ac.jp>
 <a4999d10-b8fd-4ba4-84dd-85c5e2b314b6@tls.msk.ru>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <a4999d10-b8fd-4ba4-84dd-85c5e2b314b6@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/10/28 21:28, Michael Tokarev wrote:
> On 10/27/25 04:05, Akihiko Odaki wrote:
>> s points to the MemoryRegion itself. dev points to DS1225Y, the real
>> owner.
>>
>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>> ---
>>   hw/nvram/ds1225y.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/nvram/ds1225y.c b/hw/nvram/ds1225y.c
>> index dbfd0d2e5369..0945e36652e9 100644
>> --- a/hw/nvram/ds1225y.c
>> +++ b/hw/nvram/ds1225y.c
>> @@ -126,7 +126,7 @@ static void nvram_sysbus_realize(DeviceState *dev, 
>> Error **errp)
>>       s->contents = g_malloc0(s->chip_size);
>> -    memory_region_init_io(&s->iomem, OBJECT(s), &nvram_ops, s,
>> +    memory_region_init_io(&s->iomem, OBJECT(dev), &nvram_ops, s,
>>                             "nvram", s->chip_size);
>>       sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
> 
> What's the impact of this issue?
> Should it go to the stable series perhaps?

There should be no perceivable impact. It causes memory leak if the 
device is hotpluggable, but it is apparently not the case.

The same goes for "[PATCH] hw/riscv/riscv-iommu: Fix MemoryRegion owner":
https://lore.kernel.org/qemu-devel/20251027-iommu-v1-1-0fc52a02a273@rsg.ci.i.u-tokyo.ac.jp/

Regards,
Akihiko Odaki


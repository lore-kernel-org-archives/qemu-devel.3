Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 050F9EB7ED3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 11:39:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxkZ2-0004Qb-84; Wed, 04 Mar 2026 06:38:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vxkYs-0004QD-BO
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 06:38:42 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vxkYp-0005qa-4d
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 06:38:41 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 16159596D98;
 Wed, 04 Mar 2026 12:38:35 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id HnawNhK79Cwi; Wed,  4 Mar 2026 12:38:33 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 13DEE596D97; Wed, 04 Mar 2026 12:38:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 124775969E6;
 Wed, 04 Mar 2026 12:38:33 +0100 (CET)
Date: Wed, 4 Mar 2026 12:38:33 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Gerd Hoffmann <kraxel@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v6 5/8] memory: Factor out common ram region initialization
In-Reply-To: <3fd2bad5-5df3-463d-a12b-c3a61ca1c4ab@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <4b9a2efc-905a-335d-940b-a2d89e330689@eik.bme.hu>
References: <cover.1772572714.git.balaton@eik.bme.hu>
 <3122a5855dffd8df81f7552d4a11190c4d0a0403.1772572714.git.balaton@eik.bme.hu>
 <3fd2bad5-5df3-463d-a12b-c3a61ca1c4ab@rsg.ci.i.u-tokyo.ac.jp>
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 4 Mar 2026, Akihiko Odaki wrote:
> On 2026/03/04 6:47, BALATON Zoltan wrote:
>> Introduce internal helper functions to remove duplicated code from
>> different memory_region_init_*ram functions.
>> 
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>   system/memory.c | 132 ++++++++++++++++++------------------------------
>>   1 file changed, 50 insertions(+), 82 deletions(-)
>> 
>> diff --git a/system/memory.c b/system/memory.c
>> index e8c4912a60..1b26c6b5a5 100644
>> --- a/system/memory.c
>> +++ b/system/memory.c
>> @@ -1589,19 +1589,16 @@ bool memory_region_init_ram_nomigrate(MemoryRegion 
>> *mr,
>>                                                     size, 0, errp);
>>   }
>>   -bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
>> -                                            Object *owner,
>> -                                            const char *name,
>> -                                            uint64_t size,
>> -                                            uint32_t ram_flags,
>> -                                            Error **errp)
>> +static void memory_region_setup_ram(MemoryRegion *mr)
>>   {
>> -    Error *err = NULL;
>> -    memory_region_init(mr, owner, name, size);
>>       mr->ram = true;
>>       mr->terminates = true;
>>       mr->destructor = memory_region_destructor_ram;
>> -    mr->ram_block = qemu_ram_alloc(size, ram_flags, mr, &err);
>> +}
>> +
>> +static bool memory_region_error_propagate(MemoryRegion *mr,
>> +                                          Error *err, Error **errp)
>> +{
>>       if (err) {
>>           mr->size = int128_zero();
>>           object_unparent(OBJECT(mr));
>> @@ -1611,6 +1608,18 @@ bool 
>> memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
>>       return true;
>>   }
>
> I think the optimal way to factor out error propagation is to use 
> ERRP_GUARD().

I don't think ERRP_GUARD applies here as we do not dereference errp and 
this does more than just propagate the error so I don't see how ERRP_GUARD 
could help here.

Regards,
BALATON Zoltan


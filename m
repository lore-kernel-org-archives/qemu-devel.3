Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 804C7E63CBF
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Jan 2026 20:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vk6a2-0007Tg-Rm; Sun, 25 Jan 2026 15:19:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vk6a0-0007SI-PL
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 15:19:29 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vk6Zy-0002lh-6S
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 15:19:28 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0F4155969F2;
 Sun, 25 Jan 2026 21:19:24 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id qA6hbRNjgqD9; Sun, 25 Jan 2026 21:19:22 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id ED1DA5969F1; Sun, 25 Jan 2026 21:19:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E7B325969F0;
 Sun, 25 Jan 2026 21:19:21 +0100 (CET)
Date: Sun, 25 Jan 2026 21:19:21 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Xu <peterx@redhat.com>
cc: qemu-devel@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 philmd@linaro.org
Subject: Re: [PATCH 2/6] memory: Factor out common ram region
 initialization
In-Reply-To: <aUwH3O5fgklYuwOh@x1.local>
Message-ID: <a430f242-30f5-8926-5199-c1bc0956b0f0@eik.bme.hu>
References: <cover.1766525089.git.balaton@eik.bme.hu>
 <c648e425d67ec3a7ebf51e40c2d149beb553569c.1766525089.git.balaton@eik.bme.hu>
 <aUwH3O5fgklYuwOh@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 24 Dec 2025, Peter Xu wrote:
> On Tue, Dec 23, 2025 at 10:49:58PM +0100, BALATON Zoltan wrote:
>> -bool memory_region_init_ram_nomigrate(MemoryRegion *mr,
>> -                                      Object *owner,
>> -                                      const char *name,
>> -                                      uint64_t size,
>> -                                      Error **errp)
>> -{
>> -    return memory_region_init_ram_flags_nomigrate(mr, owner, name,
>> -                                                  size, 0, errp);
>> -}
>> -
>> -bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
>> -                                            Object *owner,
>> -                                            const char *name,
>> -                                            uint64_t size,
>> -                                            uint32_t ram_flags,
>> -                                            Error **errp)
>> +static bool memory_region_do_init_ram(MemoryRegion *mr,
>> +                                      Error *err, Error **errp)
>>  {
>> -    Error *err = NULL;
>> -    memory_region_init(mr, owner, name, size);
>>      mr->ram = true;
>>      mr->terminates = true;
>>      mr->destructor = memory_region_destructor_ram;
>> -    mr->ram_block = qemu_ram_alloc(size, ram_flags, mr, &err);
>
> If this is moved out, the err below will never be set.  Maybe this helper
> then doesn't need errp at all.

err is an input parameter to this function as it consolidates common error 
handling so it does not have to be repeated at every caller.

Regards,
BALATON Zoltan

>>      if (err) {
>>          mr->size = int128_zero();
>>          object_unparent(OBJECT(mr));
>> @@ -1611,6 +1594,25 @@ bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
>>      return true;
>>  }
>
>


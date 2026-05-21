Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 901FECD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 15:15:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ56k-0007bD-I9; Thu, 21 May 2026 11:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wQ56i-0007Zt-8t; Thu, 21 May 2026 11:14:44 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wQ56f-0001je-JT; Thu, 21 May 2026 11:14:44 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id D12588360E;
 Thu, 21 May 2026 17:14:36 +0200 (CEST)
Message-ID: <0131584f-2470-471d-b4c1-13881e913eca@proxmox.com>
Date: Thu, 21 May 2026 17:14:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] qcow2: Fix corruption on discard during write with COW
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 hreitz@redhat.com, den@openvz.org, stefanha@redhat.com,
 qemu-stable@nongnu.org, qemu-devel@nongnu.org,
 Thomas Lamprecht <t.lamprecht@proxmox.com>
References: <20260427170520.101242-1-kwolf@redhat.com>
 <20260427170520.101242-4-kwolf@redhat.com>
 <414848c6-3829-4120-b760-6db8d43c1ab5@proxmox.com>
 <ag8MzS2ULm8UTFlb@redhat.com>
 <2fa73e56-f4b5-436e-ab25-5654e0837bce@proxmox.com>
 <ag8YGeNoYB-sanMh@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <ag8YGeNoYB-sanMh@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1779376457993
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
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

Am 21.05.26 um 4:35 PM schrieb Kevin Wolf:
> Am 21.05.2026 um 16:18 hat Fiona Ebner geschrieben:
>> Am 21.05.26 um 3:46 PM schrieb Kevin Wolf:
>>> Am 21.05.2026 um 14:12 hat Fiona Ebner geschrieben:
>>>> Am 27.04.26 um 7:04 PM schrieb Kevin Wolf:
>>>> I'm still trying to figure things out and come up with a better
>>>> reproducer, but wanted to let you know early, also because of the
>>>> upcoming stable releases. Of course, I'd also be happy for hints/hunches
>>>> and am happy to test suggestions!
>>>
>>> Do you have any information about the options used with the image file?
>>> In particular, is it using subclusters? Maybe just the 'qemu-img info'
>>> output would already give a bit more context.
>>
>> No subclusters if I'm not missing anything. When I created the image the
>> output was:
>>
>> Formatting '/mnt/pve/dir/images/300/vm-300-disk-0.qcow2', fmt=qcow2
>> cluster_size=65536 extended_l2=off preallocation=metadata
>> compression_type=zlib size=4510973952 lazy_refcounts=off refcount_bits=16
>>
>> Our management layer doesn't log the command itself, but doing the same
>> operation with logging added (and 301 instead of 300):
>>
>> /usr/bin/qemu-img create -o preallocation=metadata -f qcow2
>> /mnt/pve/dir/images/301/vm-301-disk-0.qcow2 4405248K
>>
>> qemu-img info gives:
>> [...]
> 
> Ok, looks like all default options.
> 
>>> Could you already locate the actual corruption and check what the
>>> pattern looks like? Something like zeros where we would expect data or
>>> the other way around? Or something less clear? (If you don't know,
>>> that's a good answer too. I know well that this kind of things is hard
>>> to debug.)
>>
>> Unfortunately not. I can only see the symptom of memory swapped back in
>> being corrupt (at least that's what happens AFAIU), leading to segfaults
>> in various processes as well as issues with heap allocations, e.g.:
>> corrupted double-linked list
>> free(): invalid pointer
>>
>> I'll write a small program which allocates memory with a fixed pattern
>> and regularly dumps it, maybe that works to get an idea about the
>> corruption.
> 
> AI suggests a scenario that looks like a real bug to me, though I'm not
> sure if it's yours. See the reproducer below.
> 
> Basically it boils down to a non-allocating write being in flight to a
> cluster that is concurrently discarded, turning the write essentially
> into a host-cluster use-after-free. If you then allocate a new cluster
> at the same time, the host cluster will be reused and the write that was
> for a different guest cluster still writes to it.
> 
> I'm not completely sure yet what the right synchronisation mechanism
> would be for this.
> 
> Anyway, as it depends on a specific pattern of discard and cluster
> allocation happening while a write request is in flight, it should be
> possible to use tracing to find out if anything like that is happening
> in your case.

I will try to do tracing. With the following program, I see that the
corrupt memory reads back as zeroes:

> #include <stdbool.h>
> #include <stdint.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <unistd.h>
> 
> #define SIZE 1024
> #define COUNT 100 * 1024
> 
> uint8_t data[COUNT * SIZE];
> 
> int main(void) {
>     while (true) {
>         for (uint32_t i = 0; i < COUNT; i++) {
>             memset(data + i * SIZE, (i % 100) + 1, SIZE);
>         }
>         sleep(10);
>         for (uint32_t i = 0; i < COUNT; i++) {
>             for (uint32_t j = 0; j < SIZE; j++) {
>                 if (data[i * SIZE + j] != (i % 100) + 1) {
>                     uint32_t start = j;
>                     uint32_t corrupt_val = data[i * SIZE + j];
>                     while (j + 1 < SIZE && data[i * SIZE + j + 1] == corrupt_val) {
>                         j++;
>                     }
>                     printf("corrupt block %u byte range %u - %u: val %u expected %u\n",
>                            i, start, j, corrupt_val, (i % 100) + 1);
>                 }
>             }
>         }
>     }
>     return 0;
> }

Example output:

> corrupt block 21495 byte range 928 - 1023: val 0 expected 96
> corrupt block 21496 byte range 0 - 1023: val 0 expected 97
> corrupt block 21497 byte range 0 - 1023: val 0 expected 98
> corrupt block 21498 byte range 0 - 1023: val 0 expected 99
> corrupt block 21499 byte range 0 - 1023: val 0 expected 100
> corrupt block 21500 byte range 0 - 1023: val 0 expected 1
> corrupt block 21501 byte range 0 - 1023: val 0 expected 2
> corrupt block 21502 byte range 0 - 1023: val 0 expected 3
> corrupt block 21503 byte range 0 - 1023: val 0 expected 4
> corrupt block 21504 byte range 0 - 1023: val 0 expected 5
> corrupt block 21505 byte range 0 - 1023: val 0 expected 6
> corrupt block 21506 byte range 0 - 1023: val 0 expected 7
> corrupt block 21507 byte range 0 - 1023: val 0 expected 8
> corrupt block 21508 byte range 0 - 1023: val 0 expected 9
> corrupt block 21509 byte range 0 - 1023: val 0 expected 10
> corrupt block 21510 byte range 0 - 1023: val 0 expected 11
> corrupt block 21511 byte range 0 - 927: val 0 expected 12
> corrupt block 22727 byte range 928 - 1023: val 0 expected 28
> corrupt block 22728 byte range 0 - 1023: val 0 expected 29
> corrupt block 22729 byte range 0 - 1023: val 0 expected 30
> corrupt block 22730 byte range 0 - 1023: val 0 expected 31
> corrupt block 22731 byte range 0 - 1023: val 0 expected 32
> corrupt block 22732 byte range 0 - 1023: val 0 expected 33
> corrupt block 22733 byte range 0 - 1023: val 0 expected 34
> corrupt block 22734 byte range 0 - 1023: val 0 expected 35
> corrupt block 22735 byte range 0 - 1023: val 0 expected 36
> corrupt block 22736 byte range 0 - 1023: val 0 expected 37
> corrupt block 22737 byte range 0 - 1023: val 0 expected 38
> corrupt block 22738 byte range 0 - 1023: val 0 expected 39
> corrupt block 22739 byte range 0 - 1023: val 0 expected 40
> corrupt block 22740 byte range 0 - 1023: val 0 expected 41
> corrupt block 22741 byte range 0 - 1023: val 0 expected 42
> corrupt block 22742 byte range 0 - 1023: val 0 expected 43
> corrupt block 22743 byte range 0 - 1023: val 0 expected 44
> corrupt block 22744 byte range 0 - 1023: val 0 expected 45
> corrupt block 22745 byte range 0 - 1023: val 0 expected 46
> corrupt block 22746 byte range 0 - 1023: val 0 expected 47
> corrupt block 22747 byte range 0 - 1023: val 0 expected 48
> corrupt block 22748 byte range 0 - 1023: val 0 expected 49
> corrupt block 22749 byte range 0 - 1023: val 0 expected 50
> corrupt block 22750 byte range 0 - 1023: val 0 expected 51
> corrupt block 22751 byte range 0 - 927: val 0 expected 52
> corrupt block 23451 byte range 928 - 1023: val 0 expected 52
> corrupt block 23452 byte range 0 - 1023: val 0 expected 53
> corrupt block 23453 byte range 0 - 1023: val 0 expected 54
> corrupt block 23454 byte range 0 - 1023: val 0 expected 55
> corrupt block 23455 byte range 0 - 1023: val 0 expected 56
> corrupt block 23456 byte range 0 - 1023: val 0 expected 57
> corrupt block 23457 byte range 0 - 1023: val 0 expected 58
> corrupt block 23458 byte range 0 - 1023: val 0 expected 59
> corrupt block 23459 byte range 0 - 1023: val 0 expected 60
> corrupt block 23460 byte range 0 - 1023: val 0 expected 61
> corrupt block 23461 byte range 0 - 1023: val 0 expected 62
> corrupt block 23462 byte range 0 - 1023: val 0 expected 63
> corrupt block 23463 byte range 0 - 1023: val 0 expected 64
> corrupt block 23464 byte range 0 - 1023: val 0 expected 65
> corrupt block 23465 byte range 0 - 1023: val 0 expected 66
> corrupt block 23466 byte range 0 - 1023: val 0 expected 67
> corrupt block 23467 byte range 0 - 1023: val 0 expected 68
> corrupt block 23468 byte range 0 - 1023: val 0 expected 69
> corrupt block 23469 byte range 0 - 1023: val 0 expected 70
> corrupt block 23470 byte range 0 - 1023: val 0 expected 71
> corrupt block 23471 byte range 0 - 1023: val 0 expected 72
> corrupt block 23472 byte range 0 - 1023: val 0 expected 73
> corrupt block 23473 byte range 0 - 1023: val 0 expected 74
> corrupt block 23474 byte range 0 - 1023: val 0 expected 75
> corrupt block 23475 byte range 0 - 1023: val 0 expected 76
> corrupt block 23476 byte range 0 - 1023: val 0 expected 77
> corrupt block 23477 byte range 0 - 1023: val 0 expected 78
> corrupt block 23478 byte range 0 - 1023: val 0 expected 79
> corrupt block 23479 byte range 0 - 1023: val 0 expected 80
> corrupt block 23480 byte range 0 - 1023: val 0 expected 81
> corrupt block 23481 byte range 0 - 1023: val 0 expected 82
> corrupt block 23482 byte range 0 - 1023: val 0 expected 83
> corrupt block 23483 byte range 0 - 1023: val 0 expected 84
> corrupt block 23484 byte range 0 - 1023: val 0 expected 85
> corrupt block 23485 byte range 0 - 1023: val 0 expected 86
> corrupt block 23486 byte range 0 - 1023: val 0 expected 87
> corrupt block 23487 byte range 0 - 927: val 0 expected 88




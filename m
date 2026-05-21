Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB1DCD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 14:18:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ4EG-0007Zo-3R; Thu, 21 May 2026 10:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wQ4E6-0007S6-OI; Thu, 21 May 2026 10:18:23 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wQ4E0-0001Gq-Bz; Thu, 21 May 2026 10:18:16 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id C47E0836DE;
 Thu, 21 May 2026 16:18:04 +0200 (CEST)
Message-ID: <2fa73e56-f4b5-436e-ab25-5654e0837bce@proxmox.com>
Date: Thu, 21 May 2026 16:18:03 +0200
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
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <ag8MzS2ULm8UTFlb@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1779373066383
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

Hi Kevin,

Am 21.05.26 um 3:46 PM schrieb Kevin Wolf:
> Am 21.05.2026 um 14:12 hat Fiona Ebner geschrieben:
>> Am 27.04.26 um 7:04 PM schrieb Kevin Wolf:
>>> Most code in qcow2 that accesses (and potentially modifies) L2 tables
>>> does so while holding s->lock.
>>>
>>> There is one exception, which is allocating writes. They hold the lock
>>> initially while allocating clusters, but drop it for writing the guest
>>> payload before taking the lock again for updating the L2 tables. This
>>> allows concurrent requests that touch other parts of the image file to
>>> continue in parallel and is an important performance optimisation.
>>>
>>> However, this means that other requests that run while the lock is
>>> dropped for writing guest data must synchronise with the list of
>>> allocating requests in s->cluster_allocs and wait if they would overlap.
>>> For writes, this is done in handle_dependencies(), but discard and write
>>> zeros operations neglect to synchronise with s->cluster_allocs.
>>>
>>> This means that discard can free a cluster whose L2 entry will already
>>> be modified in qcow2_alloc_cluster_link_l2() by a previously started
>>> write. In the case of a pre-allocated zero cluster that is in the
>>> process of being overwritten, this means that discard can lead to a
>>> situation where the cluster is still mapped (because the write will
>>> restore the L2 entry just without the zero flag), but its refcount has
>>> been decreased, resulting in a corrupted image.
>>>
>>> Add the missing synchronisation to qcow2_cluster_discard() and
>>> qcow2_subcluster_zeroize() to fix the problem.
>>>
>>> Cc: qemu-stable@nongnu.org
>>> Reported-by: Denis V. Lunev <den@openvz.org>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>
>> we had started rolling out a build of QEMU 11 with this patch already
>> included. However, some of our users reported issues with VMs using
>> qcow2 disks soon after [0][1]. I was able to reproduce the in-guest
>> segfaults from [1] in a memory-constrained Debian 12 guest when using a
>> swap partition on the same disk. Thanks to Thomas for the hunch with
>> swap! After reverting this patch, I wasn't able to reproduce the issue
>> anymore. I do not have a better reproducer yet and am not sure about the
>> exact pattern causing the issue. It's related to the
>> wait_for_dependencies() call in qcow2_subcluster_zeroize(), because if I
>> revert just the one in qcow2_cluster_discard(), the issue still reproduces.
>>
>> Commandline for my reproducer VM [2]. The issue does not happen if I
>> drop "detect-zeroes":"unmap". Note that I don't have discard-no-unref
>> for the qcow2 image, so in zero_in_l2_slice(), the branch with
>> qcow2_free_any_cluster() is taken. Could the conflict be related to that?
>>
>> I'm still trying to figure things out and come up with a better
>> reproducer, but wanted to let you know early, also because of the
>> upcoming stable releases. Of course, I'd also be happy for hints/hunches
>> and am happy to test suggestions!
> 
> Do you have any information about the options used with the image file?
> In particular, is it using subclusters? Maybe just the 'qemu-img info'
> output would already give a bit more context.

No subclusters if I'm not missing anything. When I created the image the
output was:

Formatting '/mnt/pve/dir/images/300/vm-300-disk-0.qcow2', fmt=qcow2
cluster_size=65536 extended_l2=off preallocation=metadata
compression_type=zlib size=4510973952 lazy_refcounts=off refcount_bits=16

Our management layer doesn't log the command itself, but doing the same
operation with logging added (and 301 instead of 300):

/usr/bin/qemu-img create -o preallocation=metadata -f qcow2
/mnt/pve/dir/images/301/vm-301-disk-0.qcow2 4405248K

qemu-img info gives:

{
    "children": [
        {
            "name": "file",
            "info": {
                "children": [
                ],
                "virtual-size": 6018105344,
                "filename": "/mnt/pve/dir/images/300/vm-300-disk-0.qcow2",
                "format": "file",
                "actual-size": 3794231296,
                "format-specific": {
                    "type": "file",
                    "data": {
                        "extent-size-hint": 1048576
                    }
                },
                "dirty-flag": false
            }
        }
    ],
    "snapshots": [
        {
            "icount": 0,
            "vm-clock-nsec": 0,
            "name": "s0",
            "date-sec": 1779354489,
            "date-nsec": 415278000,
            "vm-clock-sec": 0,
            "id": "1",
            "vm-state-size": 0
        }
    ],
    "virtual-size": 4510973952,
    "filename": "/mnt/pve/dir/images/300/vm-300-disk-0.qcow2",
    "cluster-size": 65536,
    "format": "qcow2",
    "actual-size": 3794231296,
    "format-specific": {
        "type": "qcow2",
        "data": {
            "compat": "1.1",
            "compression-type": "zlib",
            "lazy-refcounts": false,
            "refcount-bits": 16,
            "corrupt": false,
            "extended-l2": false
        }
    },
    "dirty-flag": false
}

> Could you already locate the actual corruption and check what the
> pattern looks like? Something like zeros where we would expect data or
> the other way around? Or something less clear? (If you don't know,
> that's a good answer too. I know well that this kind of things is hard
> to debug.)

Unfortunately not. I can only see the symptom of memory swapped back in
being corrupt (at least that's what happens AFAIU), leading to segfaults
in various processes as well as issues with heap allocations, e.g.:
corrupted double-linked list
free(): invalid pointer

I'll write a small program which allocates memory with a fixed pattern
and regularly dumps it, maybe that works to get an idea about the
corruption.

Best Regards,
Fiona



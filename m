Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097C6D3C913
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 14:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTL1n-0001ix-PP; Wed, 10 Dec 2025 09:18:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1vTL1j-0001iI-J7
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 09:18:48 -0500
Received: from sg-1-104.ptr.blmpb.com ([118.26.132.104])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1vTL1e-0005Dn-Sr
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 09:18:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1765376305; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=TruzgoQpxx6aE/73p6qnLdRCuY820h9ksChL9p20tFg=;
 b=TQj6MymAdVqGQr8l6A6vVs5SpcEtzX9dmOW/UWjEa6GCgpyaE9r9x2BrJBf9Npwe/5u3Hw
 ozwdsG6N0QNvS0NajyfNwSQkBBFL1d3XzTeCrsjvDLh/Y1EPzCREXfLfvK32pNH+SIZTbM
 V8rGZvQO8kJManF23BMmBPC0Q4clPNzVq8wFaDZs/IXxrj9ZR1EmAlzJicRs+hnfk+aQt1
 7Z0aV64Uu8YmDAoW9GRNIkiBJJpF9rbj+YTAm4POFHucBH/Y7wy4Brk6p4r+plXSPON3eT
 WRBXVE9KOFlXDeAUopDNydGYDhN+2HWNEzbCZ+qxu6W2Um9w3MIQSDLPf1nnHQ==
Date: Wed, 10 Dec 2025 22:18:21 +0800
In-Reply-To: <aTiQK-a-ZcANCFbk@x1.local>
Content-Transfer-Encoding: quoted-printable
User-Agent: Mozilla Thunderbird
Cc: <qemu-devel@nongnu.org>, <mst@redhat.com>, <sgarzare@redhat.com>, 
 <richard.henderson@linaro.org>, <pbonzini@redhat.com>, 
 <david@kernel.org>, <philmd@linaro.org>, <farosas@suse.de>
Message-Id: <58c1e3f7-be13-4a2e-a1e6-0a8295d83345@bytedance.com>
X-Lms-Return-Path: <lba+26939812f+3f855a+nongnu.org+xuchuangxclwt@bytedance.com>
Content-Type: text/plain; charset=UTF-8
References: <20251208120952.37563-1-xuchuangxclwt@bytedance.com>
 <20251208120952.37563-3-xuchuangxclwt@bytedance.com>
 <aTiQK-a-ZcANCFbk@x1.local>
X-Original-From: Chuang Xu <xuchuangxclwt@bytedance.com>
To: "Peter Xu" <peterx@redhat.com>
From: "Chuang Xu" <xuchuangxclwt@bytedance.com>
Subject: Re: [RFC v1 2/2] migration: merge fragmented clear_dirty ioctls
Mime-Version: 1.0
Received-SPF: pass client-ip=118.26.132.104;
 envelope-from=xuchuangxclwt@bytedance.com; helo=sg-1-104.ptr.blmpb.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001,
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

Hi, Peter

On 10/12/2025 05:10, Peter Xu wrote:
> On Mon, Dec 08, 2025 at 08:09:52PM +0800, Chuang Xu wrote:
>> From: xuchuangxclwt <xuchuangxclwt@bytedance.com>
>>
>> When the addresses processed are not aligned, a large number of
>> clear_dirty ioctl occur (e.g. a 16MB misaligned memory can generate
>> 4096 clear_dirty ioctls), which increases the time required for
>> bitmap_sync and makes it more difficult for dirty pages to converge.
>>
>> Attempt to merge those fragmented clear_dirty ioctls.
> (besides separate perf results I requested as in the cover letter reply..=
)
>
> Could you add something into the commit log explaining at least one examp=
le
> that you observe?  E.g. what is the VM setup, how many ramblocks are the
> ones not aligned?
>
> Have you considered setting rb->clear_bmap when it's available?  It'll
> postpone the remote clear even further until page sent.  Logically it
> should be more efficient, but it may depend on the size of unaligned
> ramblocks that you're hitting indeed, as clear_bmap isn't PAGE_SIZE based
> but it can be much bigger.  Some discussion around this would be nice on
> how you chose the current solution.
>

On my Intel(R) Xeon(R) 6986P-C(previous tests were based on Cascade Lake),
I add some logs. Here are some examples of unaligned memory I observed:
size 1966080: system.flash0
size 131072: /rom@etc/acpi/tables, isa-bios, system.flash1, pc.rom
size 65536: cirrus_vga.rom

Taking system.flash0 as an example, judging from its size, this should=20
be the OVMF I'm using.
This memory segment will trigger clear_dirty in both memory_listener=20
"kvm-memory" and
memory_listener "kvm-smram" simultaneously, ultimately resulting in a=20
total of 960 kvm_ioctl calls.
If a larger OVMF is used, this number will obviously worsen.

On the machine I tested, clear=C2=A0system.flash0=C2=A0took a total of 49ms=
,
and clear all unaligned memory took a total of 61ms.

Regarding why the current solution was chosen, because I'm not sure if=20
there were any
special considerations in the initial design of clear_dirty_log for not=20
applying unaligned memory paths.
Therefore, I chose to keep most of the logic the same as the existing one,
only extracting and merging the actual clear_dirty operations.

Thanks.


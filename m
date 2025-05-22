Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB9BFC54756
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 07:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI0Nd-0007H6-5f; Thu, 22 May 2025 03:30:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uI0NZ-0007Et-GG; Thu, 22 May 2025 03:30:13 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uI0NX-0007EQ-AX; Thu, 22 May 2025 03:30:13 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 6641343B1E;
 Thu, 22 May 2025 09:30:07 +0200 (CEST)
Message-ID: <71185c72-10b3-4f3a-acb4-f258aea58288@proxmox.com>
Date: Thu, 22 May 2025 09:30:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 13/14] tests: Add iotest mirror-sparse for recent patches
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
References: <20250515022904.575509-16-eblake@redhat.com>
 <20250515022904.575509-29-eblake@redhat.com>
 <78bc08dc-5da5-4fcf-804b-1a387f2e9ea8@proxmox.com>
 <kd563ogyr5t2sh5nz3i3iydcy4r5o2kuze4byv3d22rjyffktt@gbmqgnuufpnh>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <kd563ogyr5t2sh5nz3i3iydcy4r5o2kuze4byv3d22rjyffktt@gbmqgnuufpnh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
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

Am 21.05.25 um 17:32 schrieb Eric Blake:
> On Wed, May 21, 2025 at 11:54:03AM +0200, Fiona Ebner wrote:
>> I also tried it on my host, where the filesystem is ZFS using
>> compression, and there, 'du' will already report a lower value after
>> creating the image, because of compression. And even without compression
>> it seems that preallocation=full on ZFS is somehow async :/
>>
>>> [I] febner@enia ~/qemu/build/tests/qemu-iotests (master)> qemu-img create my.raw 20M -f raw -o preallocation=full
>>> Formatting 'my.raw', fmt=raw size=20971520 preallocation=full
>>> [I] febner@enia ~/qemu/build/tests/qemu-iotests (master)> du --block-size=1 my.raw
>>> 512	my.raw
>>> [I] febner@enia ~/qemu/build/tests/qemu-iotests (master)> du --block-size=1 my.raw
>>> 20980224	my.raw
> 
> That one may be a bit harder to work around, but I'll give it a shot
> while I'm patching the first one.

FWIW, doing a 'sync' before querying with 'du' will avoid the issue for
the allocation. But even then, after mirroring, the file will be sparse
again.

Best Regards,
Fiona



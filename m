Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB890C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:20:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWbpE-0002qs-8W; Tue, 01 Jul 2025 10:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uWbop-0002m5-Du; Tue, 01 Jul 2025 10:18:44 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uWbol-0000jl-Rs; Tue, 01 Jul 2025 10:18:41 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id B4BEE46ECA;
 Tue,  1 Jul 2025 16:18:28 +0200 (CEST)
Message-ID: <74a66925-12a5-42af-8f93-4031d663a90d@proxmox.com>
Date: Tue, 1 Jul 2025 16:18:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: include 'file' child node name in block device info
To: Hanna Czenczek <hreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, eblake@redhat.com,
 armbru@redhat.com
References: <20250630141421.1558724-1-f.ebner@proxmox.com>
 <81cb7080-cf5e-4049-82f8-e009aac93cdc@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <81cb7080-cf5e-4049-82f8-e009aac93cdc@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
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

Am 01.07.25 um 15:04 schrieb Hanna Czenczek:
> On 30.06.25 16:06, Fiona Ebner wrote:
>> In combination with using a throttle filter to enforce IO limits for
>> a guest device, knowing the 'file' child of a block device can be
>> useful. If the throttle filter is only intended for guest IO, block
>> jobs should not also be limited by the throttle filter, so the
>> block operations need to be done with the 'file' child of the top
>> throttle node as the target. In combination with mirroring, the name
>> of that child is not fixed.
>>
>> Another scenario is when unplugging a guest device after mirroring
>> below a top throttle node, where the mirror target is added explicitly
>> via blockdev-add. After mirroring, the target becomes the new 'file'
>> child of the throttle node. For unplugging, both the top throttle node
>> and the mirror target need to be deleted, because only implicitly
>> added child nodes are deleted automatically, and the current 'file'
>> child of the throttle node was explicitly added (as the mirror
>> target).
> 
> Why not return a map of all children?

No particular reason, I just didn't need to look at the others for my
use-cases. I'll try and go for the map in v2.

Best Regards,
Fiona



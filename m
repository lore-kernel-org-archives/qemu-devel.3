Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88223C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 12:44:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4geT-0006xZ-QZ; Wed, 08 May 2024 08:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1s4geS-0006xC-1v; Wed, 08 May 2024 08:44:04 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1s4geQ-0007KG-Aq; Wed, 08 May 2024 08:44:03 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 27B5945F3E;
 Wed,  8 May 2024 14:43:52 +0200 (CEST)
Message-ID: <eddff0eb-470d-4e1e-bec4-c06f27fb5a9d@proxmox.com>
Date: Wed, 8 May 2024 14:43:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] mirror: allow specifying working bitmap
From: Fiona Ebner <f.ebner@proxmox.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com,
 f.gruenbichler@proxmox.com, t.lamprecht@proxmox.com,
 mahaocong@didichuxing.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com
References: <20240307134711.709816-1-f.ebner@proxmox.com>
 <20240307134711.709816-3-f.ebner@proxmox.com>
 <3e338160-a172-42b8-946c-ae7f7d97a17c@yandex-team.ru>
 <14e568d4-ae82-4eaa-921f-1927a9b81ceb@proxmox.com>
Content-Language: en-US
In-Reply-To: <14e568d4-ae82-4eaa-921f-1927a9b81ceb@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Am 07.05.24 um 14:15 schrieb Fiona Ebner:
> Am 02.04.24 um 22:14 schrieb Vladimir Sementsov-Ogievskiy:
>> On 07.03.24 16:47, Fiona Ebner wrote:
>>> +# @bitmap: The name of a bitmap to use as a working bitmap for
>>> +#     sync=full mode.  This argument must be not be present for other
>>> +#     sync modes and not at the same time as @granularity.  The
>>> +#     bitmap's granularity is used as the job's granularity.  When
>>> +#     the target is a diff image, i.e. one that should only contain
>>> +#     the delta and was not synced to previously, the target's
>>> +#     cluster size must not be larger than the bitmap's granularity.
>>
>> Could we check this? Like in block_copy_calculate_cluster_size(), we can
>> check if target does COW, and if not, we can check that we are safe with
>> granularity.
>>
> 
> The issue here is (in particular) present when the target does COW, i.e.
> in qcow2 diff images, allocated clusters which end up with partial data,
> when we don't have the right cluster size. Patch 4/4 adds the check for
> the target's cluster size.
> 

Sorry, no. What I said is wrong. It's just that the test does something
very pathological and does not even use COW/backing files. All the
mirror targets are separate diff images there. So yes, we can do the
same as block_copy_calculate_cluster_size() and the issue only appears
in the same edge cases as for backup where we can error out early. This
also applies to copy-mode=write-blocking AFAICT.

>>> +#     For a diff image target, using copy-mode=write-blocking should
>>> +#     not be used, because unaligned writes will lead to allocated
>>> +#     clusters with partial data in the target image!
>>
>> Could this be checked?
>>
> 
> I don't think so. How should we know if the target already contains data
> from a previous full sync or not?
> 
> Those caveats when using diff images are unfortunate, and users should
> be warned about them of course, but the main/expected use case for the
> feature is to sync to the same target multiple times, so I'd hope the
> cluster size check in patch 4/4 and mentioning the edge cases in the
> documentation is enough here.
> 



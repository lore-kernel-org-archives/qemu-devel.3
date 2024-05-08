Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A73C19F4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 09:52:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4dxR-00052u-BB; Wed, 08 May 2024 05:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1s4dxM-00052N-4Z
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:51:24 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1s4dxJ-0005dr-TS
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:51:23 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 2A76F461BF;
 Wed,  8 May 2024 11:51:18 +0200 (CEST)
Message-ID: <840f380c-b5f4-4310-8bbd-ed66d1735f87@proxmox.com>
Date: Wed, 8 May 2024 11:51:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Fix "virtio-gpu: fix scanout migration post-load"
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Sebastian Ott <sebott@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eduardo Habkost <eduardo@habkost.net>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>
References: <20240507111920.1594897-1-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20240507111920.1594897-1-marcandre.lureau@redhat.com>
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

Am 07.05.24 um 13:19 schrieb marcandre.lureau@redhat.com:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Hi,
> 
> The aforementioned patch breaks virtio-gpu device migrations for versions
> pre-9.0/9.0, both forwards and backwards. Versioning of `VMS_STRUCT` is more
> complex than it may initially appear, as evidenced in the problematic commit
> dfcf74fa68c ("virtio-gpu: fix scanout migration post-load").
> 
> To resolve this, we need to propagate the `vmstate` `version_id` through the
> nested structures. Additionally, we should tie specific machine version to a
> corresponding `version_id` to maintain migration compatibility.
> 
> `VMS_VSTRUCT` allows specifying the appropriate version of the nested structure
> to use.
> 
> Marc-André Lureau (4):
>   migration: add "exists" info to load-state-field trace
>   include/migration: add VMSTATE_VSTRUCT_TEST_VARRAY_UINT32
>   virtio-gpu: use a VMState variant for the scanout field
>   virtio-gpu: add x-vmstate-version
> 
>  include/hw/virtio/virtio-gpu.h |  1 +
>  include/migration/vmstate.h    | 12 ++++++++++++
>  hw/core/machine.c              |  1 +
>  hw/display/virtio-gpu.c        | 28 +++++++++++++++++++++-------
>  migration/vmstate.c            |  5 +++--
>  migration/trace-events         |  2 +-
>  6 files changed, 39 insertions(+), 10 deletions(-)
> 

Tested-by: Fiona Ebner <f.ebner@proxmox.com>

Thank you for the fix! Tested with an Ubuntu 23.10 VM:

Machine type pc-i440fx-8.2:
1. create snapshot with 8.2, load with patched 9.0
2. create snapshot with patched 9.0, load with patched 9.0 and with 8.2

Machine type pc-i440fx-9.0:
1. create snapshot with patched 9.0, load with patched 9.0

No crashes/failures and didn't notice any other issues :)

Best Regards,
Fiona



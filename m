Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEFCDC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 09:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7XSb-0004nn-Up; Thu, 16 May 2024 05:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1s7XSZ-0004mg-Mn; Thu, 16 May 2024 05:31:35 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1s7XSX-0003jX-Vu; Thu, 16 May 2024 05:31:35 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 31DAA41572;
 Thu, 16 May 2024 11:31:23 +0200 (CEST)
Message-ID: <6ef80da5-6dac-4717-b683-b4428a3a9835@proxmox.com>
Date: Thu, 16 May 2024 11:31:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] Fix "virtio-gpu: fix scanout migration post-load"
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Xu <peterx@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20240516084022.1398919-1-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20240516084022.1398919-1-marcandre.lureau@redhat.com>
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

Am 16.05.24 um 10:40 schrieb marcandre.lureau@redhat.com:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Hi,
> 
> The aforementioned patch breaks virtio-gpu device migrations for versions
> pre-9.0/9.0, both forwards and backwards. Versioning of `VMS_STRUCT` is more
> complex than it may initially appear, as evidenced in the problematic commit
> dfcf74fa68c ("virtio-gpu: fix scanout migration post-load").
> 
> v2:
>  - use a manual version field test (instead of the more complex struct variant)
> 
> v3:
>  - introduce machine_check_version()
>  - drop the VMSD version, and use machine version field test
> 
> v4:
>  - drop machine_check_version() approach
>  - property renamed to x-scanout-vmstate-version
> 
> Marc-André Lureau (3):
>   migration: add "exists" info to load-state-field trace
>   migration: fix a typo
>   virtio-gpu: fix v2 migration
> 
>  include/hw/virtio/virtio-gpu.h |  1 +
>  hw/core/machine.c              |  1 +
>  hw/display/virtio-gpu.c        | 24 ++++++++++++++++--------
>  migration/vmstate.c            |  7 ++++---
>  migration/trace-events         |  2 +-
>  5 files changed, 23 insertions(+), 12 deletions(-)
> 

Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>

Tested the same things as for v1/v2, with an Ubuntu 23.10 VM:

Machine type pc-i440fx-8.2:
1. create snapshot with 8.2, load with patched 9.0
2. create snapshot with patched 9.0, load with patched 9.0 and with 8.2

Machine type pc-i440fx-9.0:
1. create snapshot with patched 9.0, load with patched 9.0

No crashes/failures and didn't notice any other issues 🙂

Best Regards,
Fiona



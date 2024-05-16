Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA56C25B77
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 13:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7bOs-0003Wc-B7; Thu, 16 May 2024 09:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1s7bOq-0003WF-Ez
 for qemu-devel@nongnu.org; Thu, 16 May 2024 09:44:00 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1s7bOo-0001sf-Kp
 for qemu-devel@nongnu.org; Thu, 16 May 2024 09:44:00 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 8376041572;
 Thu, 16 May 2024 15:43:55 +0200 (CEST)
Message-ID: <f8d256a0-8719-4132-9304-afd214ed0ffa@proxmox.com>
Date: Thu, 16 May 2024 15:43:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 04/17] virtio-net: Add support for USO features
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Cc: Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychecnko <andrew@daynix.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20230908064507.14596-1-jasowang@redhat.com>
 <20230908064507.14596-5-jasowang@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20230908064507.14596-5-jasowang@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi,

Am 08.09.23 um 08:44 schrieb Jason Wang:
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index da699cf..230aab8 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -38,6 +38,7 @@
>  #include "exec/confidential-guest-support.h"
>  #include "hw/virtio/virtio.h"
>  #include "hw/virtio/virtio-pci.h"
> +#include "hw/virtio/virtio-net.h"
>  
>  GlobalProperty hw_compat_8_1[] = {};
>  const size_t hw_compat_8_1_len = G_N_ELEMENTS(hw_compat_8_1);
> @@ -45,6 +46,9 @@ const size_t hw_compat_8_1_len = G_N_ELEMENTS(hw_compat_8_1);
>  GlobalProperty hw_compat_8_0[] = {
>      { "migration", "multifd-flush-after-each-section", "on"},
>      { TYPE_PCI_DEVICE, "x-pcie-ari-nextfn-1", "on" },
> +    { TYPE_VIRTIO_NET, "host_uso", "off"},
> +    { TYPE_VIRTIO_NET, "guest_uso4", "off"},
> +    { TYPE_VIRTIO_NET, "guest_uso6", "off"},
>  };
>  const size_t hw_compat_8_0_len = G_N_ELEMENTS(hw_compat_8_0);
>  

unfortunately, this broke backwards migration with machine version 8.1
from 8.2 and 9.0 binaries to a 8.1 binary:

> kvm: Features 0x1c0010130afffa7 unsupported. Allowed features: 0x10179bfffe7
> kvm: Failed to load virtio-net:virtio
> kvm: error while loading state for instance 0x0 of device '0000:00:12.0/virtio-net'
> kvm: load of migration failed: Operation not permitted

Since the series here only landed in 8.2, shouldn't these flags have
been added to hw_compat_8_1[] instead?

Attempting to fix it by moving the flags will break migration with
machine version 8.1 between patched 9.0 and unpatched 9.0 however :(

Is there anything that can be done or will it need to stay broken now?

CC-ing the migration maintainers.

Best Regards,
Fiona



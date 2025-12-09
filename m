Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD84D3B7F3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 12:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSwdb-0004OU-Ic; Tue, 09 Dec 2025 07:16:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1vSwdV-0004HS-Pt
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 07:16:10 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1vSwdN-00032q-ST
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 07:16:07 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 5D46A49390;
 Tue, 09 Dec 2025 13:15:50 +0100 (CET)
Message-ID: <7798584d-e861-47b7-af52-2c2efb67a4de@proxmox.com>
Date: Tue, 9 Dec 2025 13:15:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 03/23] hw/net/virtio-net: make VirtIONet.vlans an array
 instead of a pointer
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Lei Yang <leiyang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <20251028074901.22062-1-philmd@linaro.org>
 <20251028074901.22062-4-philmd@linaro.org>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20251028074901.22062-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1765282541390
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

Hi,

Am 28.10.25 um 11:19 AM schrieb Philippe Mathieu-Daudé:
> From: Michael Tokarev <mjt@tls.msk.ru>
> 
> This field is a fixed-size buffer (number of elements is MAX_VLAN,
> known at build time).  There's no need to allocate it dynamically,
> it can be made an integral part of VirtIONet structure.
> 
> This field is the only user of VMSTATE_BUFFER_POINTER_UNSAFE() macro.
> 
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Tested-by: Lei Yang <leiyang@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> Message-ID: <20251023135316.31128-2-mjt@tls.msk.ru>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

unfortunately, after this commit, loading a VM state taken with v10.1.2
or older doesn't work anymore:

> qemu-system-x86_64: Missing section footer for 0000:00:13.0/virtio-net
> qemu-system-x86_64: Section footer error, section_id: 41

Reproducer below [0].


Reverting

> 58341158d0 migration/vmstate: remove VMSTATE_BUFFER_POINTER_UNSAFE macro
> 3a9cd2a4a1 hw/net/virtio-net: make VirtIONet.vlans an array instead of a pointer

in current master makes it work again.


I'm also seeing the following when a guest is actually running:

> kvm: VQ 1 size 0x100 < last_avail_idx 0x9 - used_idx 0x3e30
> kvm: load of migration failed: Operation not permitted: error while loading state for instance 0x0 of device '0000:00:13.0/virtio-net': Failed to load element of type virtio for virtio: -1

and here too a revert of the two commits seems to help :)


Best Regards,
Fiona


[0]:

> [I] root@pve9a1 ~# cat snapshot-virtio-net.sh
> #!/bin/bash
> rm /tmp/disk.qcow2
> args="
>   -netdev type=tap,id=net1,ifname=tap104i1,script=/usr/libexec/qemu-server/pve-bridge,downscript=/usr/libexec/qemu-server/pve-bridgedown,vhost=on
>   -device virtio-net-pci,mac=BC:24:11:32:3C:69,netdev=net1,bus=pci.0,addr=0x13,id=net1
>   -machine type=pc-i440fx-10.1
> "
> $1/qemu-img create -f qcow2 /tmp/disk.qcow2 1G
> $1/qemu-system-x86_64 --qmp stdio --blockdev qcow2,node-name=node0,file.driver=file,file.filename=/tmp/disk.qcow2 $args <<EOF
> {"execute": "qmp_capabilities"}
> {"execute": "snapshot-save", "arguments": { "job-id": "save0", "tag": "snap", "vmstate": "node0", "devices": ["node0"] } }
> {"execute": "quit"}
> EOF
> $2/qemu-system-x86_64 --qmp stdio --blockdev qcow2,node-name=node0,file.driver=file,file.filename=/tmp/disk.qcow2 $args -loadvm snap




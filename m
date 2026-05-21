Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74AEECD4F5E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 12:13:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ2Gn-0005Zg-7j; Thu, 21 May 2026 08:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wQ2GZ-0005X6-SM; Thu, 21 May 2026 08:12:44 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wQ2GN-0001On-Rn; Thu, 21 May 2026 08:12:34 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 514DB83159;
 Thu, 21 May 2026 14:12:21 +0200 (CEST)
Message-ID: <414848c6-3829-4120-b760-6db8d43c1ab5@proxmox.com>
Date: Thu, 21 May 2026 14:12:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] qcow2: Fix corruption on discard during write with COW
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Cc: hreitz@redhat.com, den@openvz.org, stefanha@redhat.com,
 qemu-stable@nongnu.org, qemu-devel@nongnu.org,
 Thomas Lamprecht <t.lamprecht@proxmox.com>
References: <20260427170520.101242-1-kwolf@redhat.com>
 <20260427170520.101242-4-kwolf@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20260427170520.101242-4-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1779365522979
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

Dear maintainers,

Am 27.04.26 um 7:04 PM schrieb Kevin Wolf:
> Most code in qcow2 that accesses (and potentially modifies) L2 tables
> does so while holding s->lock.
> 
> There is one exception, which is allocating writes. They hold the lock
> initially while allocating clusters, but drop it for writing the guest
> payload before taking the lock again for updating the L2 tables. This
> allows concurrent requests that touch other parts of the image file to
> continue in parallel and is an important performance optimisation.
> 
> However, this means that other requests that run while the lock is
> dropped for writing guest data must synchronise with the list of
> allocating requests in s->cluster_allocs and wait if they would overlap.
> For writes, this is done in handle_dependencies(), but discard and write
> zeros operations neglect to synchronise with s->cluster_allocs.
> 
> This means that discard can free a cluster whose L2 entry will already
> be modified in qcow2_alloc_cluster_link_l2() by a previously started
> write. In the case of a pre-allocated zero cluster that is in the
> process of being overwritten, this means that discard can lead to a
> situation where the cluster is still mapped (because the write will
> restore the L2 entry just without the zero flag), but its refcount has
> been decreased, resulting in a corrupted image.
> 
> Add the missing synchronisation to qcow2_cluster_discard() and
> qcow2_subcluster_zeroize() to fix the problem.
> 
> Cc: qemu-stable@nongnu.org
> Reported-by: Denis V. Lunev <den@openvz.org>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

we had started rolling out a build of QEMU 11 with this patch already
included. However, some of our users reported issues with VMs using
qcow2 disks soon after [0][1]. I was able to reproduce the in-guest
segfaults from [1] in a memory-constrained Debian 12 guest when using a
swap partition on the same disk. Thanks to Thomas for the hunch with
swap! After reverting this patch, I wasn't able to reproduce the issue
anymore. I do not have a better reproducer yet and am not sure about the
exact pattern causing the issue. It's related to the
wait_for_dependencies() call in qcow2_subcluster_zeroize(), because if I
revert just the one in qcow2_cluster_discard(), the issue still reproduces.

Commandline for my reproducer VM [2]. The issue does not happen if I
drop "detect-zeroes":"unmap". Note that I don't have discard-no-unref
for the qcow2 image, so in zero_in_l2_slice(), the branch with
qcow2_free_any_cluster() is taken. Could the conflict be related to that?

I'm still trying to figure things out and come up with a better
reproducer, but wanted to let you know early, also because of the
upcoming stable releases. Of course, I'd also be happy for hints/hunches
and am happy to test suggestions!

Best Regards,
Fiona

[0]: https://forum.proxmox.com/threads/183679/
[1]: https://forum.proxmox.com/threads/183639/

[2]:

> ./qemu-system-x86_64 \
>   -accel kvm \
>   -chardev 'socket,id=qmp,path=/var/run/qemu-server/300.qmp,server=on,wait=off' \
>   -mon 'chardev=qmp,mode=control' \
>   -chardev 'socket,id=qmp-event,path=/var/run/qmeventd.sock,reconnect-ms=5000' \
>   -mon 'chardev=qmp-event,mode=control' \
>   -pidfile /var/run/qemu-server/300.pid \
>   -smp '4,sockets=2,cores=2,maxcpus=4' \
>   -nodefaults \
>   -boot 'menu=on,strict=on,reboot-timeout=1000,splash=/usr/share/qemu-server/bootsplash.jpg' \
>   -vnc 'unix:/var/run/qemu-server/300.vnc,password=on' \
>   -cpu host,+kvm_pv_eoi,+kvm_pv_unhalt \
>   -m 256 \
>   -device 'pci-bridge,id=pci.1,chassis_nr=1,bus=pci.0,addr=0x1e' \
>   -device 'pci-bridge,id=pci.2,chassis_nr=2,bus=pci.0,addr=0x1f' \
>   -device 'pci-bridge,id=pci.3,chassis_nr=3,bus=pci.0,addr=0x5' \
>   -device 'VGA,id=vga,bus=pci.0,addr=0x2' \
>   -device 'virtio-scsi-pci,id=virtioscsi0,bus=pci.3,addr=0x1' \
>   -blockdev '{"detect-zeroes":"unmap","discard":"unmap","driver":"qcow2","file":{"detect-zeroes":"unmap","discard":"unmap","driver":"file","filename":"/mnt/pve/dir/images/300/vm-300-disk-0.qcow2","node-name":"e377549e25f53abd39f9ba01c03653e"},"node-name":"drive-scsi0"}' \
>   -device 'scsi-hd,bus=virtioscsi0.0,channel=0,scsi-id=0,lun=0,drive=drive-scsi0,id=scsi0,device_id=drive-scsi0,bootindex=100' \
>   -netdev 'type=tap,id=net1,ifname=tap300i1,script=/usr/libexec/qemu-server/pve-bridge,downscript=/usr/libexec/qemu-server/pve-bridgedown,vhost=on' \
>   -device 'virtio-net-pci,mac=BC:24:11:CA:B4:EF,netdev=net1,bus=pci.0,addr=0x13,id=net1,rx_queue_size=1024,tx_queue_size=256,host_mtu=1500'





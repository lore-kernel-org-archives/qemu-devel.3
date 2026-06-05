Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60664CD8C81
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 14:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVV8T-0004aE-Tz; Fri, 05 Jun 2026 10:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wVV8Q-0004a4-VZ
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 10:02:55 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wVV8O-0005tm-KS
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 10:02:54 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 7D6FD8094F;
 Fri, 05 Jun 2026 16:02:40 +0200 (CEST)
Message-ID: <077647f6-d569-4918-9aea-c0597a6ddbc8@proxmox.com>
Date: Fri, 5 Jun 2026 16:02:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 12/14] virtio-net: Advertise UDP tunnel GSO support by
 default
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Abeni
 <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Gabriel Goller <g.goller@proxmox.com>,
 Stefan Hanreich <s.hanreich@proxmox.com>,
 Thomas Lamprecht <t.lamprecht@proxmox.com>
References: <cover.1762698873.git.mst@redhat.com>
 <1c79ab6937ae938d3dfd4da1c01afc7eb599857e.1762698873.git.mst@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <1c79ab6937ae938d3dfd4da1c01afc7eb599857e.1762698873.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1780668119825
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

Am 09.11.25 um 4:10 PM schrieb Michael S. Tsirkin:
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 17ed0ef919..3b85560f6f 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -4299,19 +4299,19 @@ static const Property virtio_net_properties[] = {
>      VIRTIO_DEFINE_PROP_FEATURE("host_tunnel", VirtIONet,
>                                 host_features_ex,
>                                 VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO,
> -                               false),
> +                               true),
it seems that the host_tunnel setting can cause issues when VXLAN
traffic originating in a guest goes over a physical NIC which does not
support the feature. We received several reports about the issue
[0][1][2][3] and were able to reproduce it. Turning off the
'host_tunnel' property in the commandline for the VirtIO net device
makes TCP traffic work. The network configuration from our reproducer
setup is as follows:

      guest A (iperf3 -c)                   guest B (iperf3 -s)
  vxlan using vNIC as underlay         vxlan using vNIC as underlay
virtualized NIC exposed to guest     virtualized NIC exposed to guest
    ---guest boundary---                  ---guest boundary---
 tap device connected to bridge       tap device connected to bridge
bridge with physical NIC as port     bridge with physical NIC as port
        physical NIC   <---host boundary--->   physical NIC

Bridge configuration:
iface vmbr0 inet static
	address 10.48.0.109/20
	gateway 10.48.0.1
	bridge-ports nic3
	bridge-stp off
	bridge-fd 0
	bridge-vlan-aware yes
	bridge-vids 2-4094

VXLAN created with:
ip link add vxlan0 type vxlan id 100 remote X dstport 4789 dev eth1
where eth1 is the virtualized NIC exposed to the guest

The physical NIC does not have the feature:
Ethernet controller [0200]: Broadcom Inc. and subsidiaries NetXtreme
BCM5719 Gigabit Ethernet PCIe [14e4:1657] (rev 01)
tx-udp_tnl-segmentation: off [fixed]
tx-udp_tnl-csum-segmentation: off [fixed]

Using a physical NIC which does have the feature works:
Ethernet controller [0200]: Broadcom Inc. and subsidiaries BCM57504
NetXtreme-E 10Gb/25Gb/40Gb/50Gb/100Gb Ethernet [14e4:1751] (rev 11)
tx-udp_tnl-segmentation: on
tx-udp_tnl-csum-segmentation: on

Host kernel:
Proxmox VE with 7.0.2-6-pve

Guest kernel:
Apline with 6.18.34-0-lts

QEMU commandline for the vNIC:
> -netdev 'type=tap,id=net2,ifname=tap103i2,script=/usr/libexec/qemu-server/pve-bridge,downscript=/usr/libexec/qemu-server/pve-bridgedown,vhost=on' \
> -device 'virtio-net-pci,mac=BC:24:11:78:C3:3B,netdev=net2,bus=pci.0,addr=0x14,id=net2,rx_queue_size=1024,tx_queue_size=256,host_mtu=1500' \

We can see that QEMU sets the features for the tap interface via ioctl()
and the host kernel allows it:
tx-udp_tnl-segmentation: on
tx-udp_tnl-csum-segmentation: on

As far as we understand, in the problematic scenario, nothing is ever
filling in the checksums for the inner TCP packets, meaning the outer
UDP checksum ends up being wrong on the target side. Is the host kernel
responsible for doing that before passing the packet to the physical NIC
(without the feature)? Or who would be?

Turning off host_tunnel_csum without turning off host_tunnel does not help.

Interestingly, turning off the features for the working physical NIC
does not make it break:
tx-udp_tnl-segmentation: off
tx-udp_tnl-csum-segmentation: off
Could it be that the NIC just always fills in the inner TCP checksums
regardless of that setting?

On the other hand, running
localhost:~# ethtool -K eth2 tx-checksum-ip-generic off
Actual changes:
tx-checksum-ip-generic: off
tx-tcp-segmentation: off [not requested]
tx-tcp-ecn-segmentation: off [not requested]
tx-tcp6-segmentation: off [not requested]
tx-udp-segmentation: off [not requested]
inside the guests makes it work for the physical NIC without the
tx-udp_tnl* features.

I wanted to ask if this configuration is expected to be unsupported and
if the management is expected to turn off the feature on the commandline
if the traffic might go over a physical NIC without the feature. Or if
this could be a kernel or NIC bug that should be investigated further?
In the former case, should the option really be turned on by default
with new machine versions?

I'll be happy to test and capture/provide additional information. Let me
know what would be interesting.

Thanks to Stefan and Gabriel for looking into the issue with me!

Best Regards,
Fiona

[0]: https://bugzilla.proxmox.com/show_bug.cgi?id=7627
[1]: https://forum.proxmox.com/threads/183494/post-855144
[2]: https://forum.proxmox.com/threads/182328/post-854627
[3]: https://forum.proxmox.com/threads/183963/post-855737



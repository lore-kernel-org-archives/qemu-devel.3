Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D17BECD6E79
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 17:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWdWR-0005tj-TU; Mon, 08 Jun 2026 13:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1wWdWQ-0005tR-Pa
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 13:12:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1wWdWO-0005Rc-N5
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 13:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780938739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qIFUP7iJTynNT1PQk8LqIZ6ikZnR1FSoxms3KW58CbU=;
 b=NiAgXLBrbX9P5xjUY1bMlgQhZQqaeDgQVX7BRBQ44ocsmZREtJQ1JBc9OP9Fp0qxlCMRTe
 QXAOs3Hn10pu6gWW7iqQ4cou7x5lpJISo1HZF3hMhFwGYKHx8I1jJnYutKLoSkLuWm/ttv
 SbnhBbZdGMLf8E1l54HHZtx+4mroyuM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-ibuWQttMNfKhVei2lGVj2Q-1; Mon, 08 Jun 2026 13:12:18 -0400
X-MC-Unique: ibuWQttMNfKhVei2lGVj2Q-1
X-Mimecast-MFC-AGG-ID: ibuWQttMNfKhVei2lGVj2Q_1780938737
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490b93debc8so36387165e9.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 10:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780938737; x=1781543537; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qIFUP7iJTynNT1PQk8LqIZ6ikZnR1FSoxms3KW58CbU=;
 b=eKeAyxDn9r8w3X6x8YoApoxinMRYdvqEQPMEF3x3tMKzBmrl4peppx46+/gQYHgPOR
 dQVB2ndZ/Oez3gEl0ddqRVrNvMSIYF/6AJBhCq2jiGbG2VJiZcMknlnKWg0ZZL5M+nnO
 LDFILZtCzrTKokVt5AzmqIEkpvgaO1juwGqEWcsDI002AOkUdsU+AJRTSHQYRKA3qA2D
 qX7EjyKCsktzZfON/j/wnYK+XArnN2W1Bs3+KX7GZfW63pI6wGRF0F4B96hKNzdUOcbr
 4DGwRym31E8pXToAIXt1K1RSmH14Vyb2M2qgQA4gJ55Su5zKKK3AV09CSBAEagxFihDE
 g/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780938737; x=1781543537;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qIFUP7iJTynNT1PQk8LqIZ6ikZnR1FSoxms3KW58CbU=;
 b=Ivl06Vta5m8xfLTqAF02Qk8Ah1zwknIdDndK75H24yX65iyGeMN7/QT8RDhQFdSZ6f
 Q9zsdhsCmOiP6rEAJBBI1KJ+C28g9YThJZ1PEJ1b/Mv1Lq42/jc+uN34ovQ8SXriULxf
 EhnNSF7IoxB06aKLWdUj4IUiNjZCRXH7RbtNJNe2R53icAwAK7qgrXiNDrEfWOwtKtRM
 wbPPdUoO/FhU/twjhLgyWbNv4ArghvWlvRV4x2NlxjD5DOAutTBnolnxZQPle12EiSZf
 xxG1dcRoFjVCtv/flW2cEWP12FKbLjbjty08Yyh13wGfWyAKJ5c6fVSZPjLQLCWPMAV1
 JZ/g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/4Rn0U0/UvYBF8D5aquPFwJjOdKX10iL6lTowoQMC/zJd4do7vmlBIiqpTxpdmYg2wG++kO2uYnFSH@nongnu.org
X-Gm-Message-State: AOJu0YxVTD0acTyJxtfrB2fgy+RG2BqeC5I3Cy6jozujrUZVo0PkzDhx
 Xo/bwaojOz2jcKufw5nAfhLcHtN+A2zne3/Egdl5EyTjLnjWP4/A2ZAAn1H+/nDh0TTEYW2N3vV
 jt89Ww0wcfJhxLZQr0mOQ89qQ80prZQ13sqAyEvrNJ9MzsMSZUjDCkzvr
X-Gm-Gg: Acq92OF2MY8xpERx6zQQxSLGPjP5ZW3EwWWAhcwAW6Pr+qrVKnmwQwzLaAwrcgCLn8b
 iG/ocpyt4d+Uf6ux53iFoBsjiWSLeP+F3e45uY+j5K3XUWvg4qnhpbFZC7ob7f9f5rUNb0Jz7xP
 lZ8Lq8A1wdQ/Kwi8gwBSKVTGxYtBcsvpLrA/Nk/Y0WuCgxOnbIEjBcKaNqhqSjSuSpZtWpSzdlu
 OedTC9W/FB6aARJDohZEp2i7Xlf4Hc8TbL7BImFwoRpADpOzXzUIqackSQgknTLHUIFU2nA/+HG
 Lstm8hNs+FOKNUpbxt8neUdlX2iaC5hKZhZjnMWkTWQG5KrEw3sOp1jLL9zcVkddb474hZqE8vd
 +CkjI/qXOQZ1ACfQj+3nQ+9kqwe3ZTFhVwx2rkhlvF2yV98M/oL93l0w8IytaHiqgwQ==
X-Received: by 2002:a05:600c:4e14:b0:490:4e3e:b483 with SMTP id
 5b1f17b1804b1-490c2600ebdmr251621215e9.22.1780938736981; 
 Mon, 08 Jun 2026 10:12:16 -0700 (PDT)
X-Received: by 2002:a05:600c:4e14:b0:490:4e3e:b483 with SMTP id
 5b1f17b1804b1-490c2600ebdmr251620505e9.22.1780938736463; 
 Mon, 08 Jun 2026 10:12:16 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.44])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f351ac0sm97423996f8f.27.2026.06.08.10.12.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 10:12:15 -0700 (PDT)
Message-ID: <375064ee-5a6f-44d4-8192-09f39804be69@redhat.com>
Date: Mon, 8 Jun 2026 19:12:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 12/14] virtio-net: Advertise UDP tunnel GSO support by
 default
To: Fiona Ebner <f.ebner@proxmox.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang
 <jasowang@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Gabriel Goller <g.goller@proxmox.com>,
 Stefan Hanreich <s.hanreich@proxmox.com>,
 Thomas Lamprecht <t.lamprecht@proxmox.com>
References: <cover.1762698873.git.mst@redhat.com>
 <1c79ab6937ae938d3dfd4da1c01afc7eb599857e.1762698873.git.mst@redhat.com>
 <077647f6-d569-4918-9aea-c0597a6ddbc8@proxmox.com>
 <39100539-1c43-431b-886d-7d42850bc4c5@redhat.com>
 <127b6887-f93a-4081-a264-1bc63f37921d@proxmox.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <127b6887-f93a-4081-a264-1bc63f37921d@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/8/26 12:41 PM, Fiona Ebner wrote:
> Am 05.06.26 um 4:54 PM schrieb Paolo Abeni:
>> On 6/5/26 4:02 PM, Fiona Ebner wrote:
>>> Am 09.11.25 um 4:10 PM schrieb Michael S. Tsirkin:
>>>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>>>> index 17ed0ef919..3b85560f6f 100644
>>>> --- a/hw/net/virtio-net.c
>>>> +++ b/hw/net/virtio-net.c
>>>> @@ -4299,19 +4299,19 @@ static const Property virtio_net_properties[] = {
>>>>      VIRTIO_DEFINE_PROP_FEATURE("host_tunnel", VirtIONet,
>>>>                                 host_features_ex,
>>>>                                 VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO,
>>>> -                               false),
>>>> +                               true),
>>> it seems that the host_tunnel setting can cause issues when VXLAN
>>> traffic originating in a guest goes over a physical NIC which does not
>>> support the feature. We received several reports about the issue
>>> [0][1][2][3] and were able to reproduce it. Turning off the
>>> 'host_tunnel' property in the commandline for the VirtIO net device
>>> makes TCP traffic work. The network configuration from our reproducer
>>> setup is as follows:
>>>
>>>       guest A (iperf3 -c)                   guest B (iperf3 -s)
>>>   vxlan using vNIC as underlay         vxlan using vNIC as underlay
>>> virtualized NIC exposed to guest     virtualized NIC exposed to guest
>>>     ---guest boundary---                  ---guest boundary---
>>>  tap device connected to bridge       tap device connected to bridge
>>> bridge with physical NIC as port     bridge with physical NIC as port
>>>         physical NIC   <---host boundary--->   physical NIC
>>>
>>> Bridge configuration:
>>> iface vmbr0 inet static
>>> 	address 10.48.0.109/20
>>> 	gateway 10.48.0.1
>>> 	bridge-ports nic3
>>> 	bridge-stp off
>>> 	bridge-fd 0
>>> 	bridge-vlan-aware yes
>>> 	bridge-vids 2-4094
>>>
>>> VXLAN created with:
>>> ip link add vxlan0 type vxlan id 100 remote X dstport 4789 dev eth1
>>> where eth1 is the virtualized NIC exposed to the guest
>>>
>>> The physical NIC does not have the feature:
>>> Ethernet controller [0200]: Broadcom Inc. and subsidiaries NetXtreme
>>> BCM5719 Gigabit Ethernet PCIe [14e4:1657] (rev 01)
>>> tx-udp_tnl-segmentation: off [fixed]
>>> tx-udp_tnl-csum-segmentation: off [fixed]
>>>
>>> Using a physical NIC which does have the feature works:
>>> Ethernet controller [0200]: Broadcom Inc. and subsidiaries BCM57504
>>> NetXtreme-E 10Gb/25Gb/40Gb/50Gb/100Gb Ethernet [14e4:1751] (rev 11)
>>> tx-udp_tnl-segmentation: on
>>> tx-udp_tnl-csum-segmentation: on
>>>
>>> Host kernel:
>>> Proxmox VE with 7.0.2-6-pve
>>>
>>> Guest kernel:
>>> Apline with 6.18.34-0-lts
>>>
>>> QEMU commandline for the vNIC:
>>>> -netdev 'type=tap,id=net2,ifname=tap103i2,script=/usr/libexec/qemu-server/pve-bridge,downscript=/usr/libexec/qemu-server/pve-bridgedown,vhost=on' \
>>>> -device 'virtio-net-pci,mac=BC:24:11:78:C3:3B,netdev=net2,bus=pci.0,addr=0x14,id=net2,rx_queue_size=1024,tx_queue_size=256,host_mtu=1500' \
>>>
>>> We can see that QEMU sets the features for the tap interface via ioctl()
>>> and the host kernel allows it:
>>> tx-udp_tnl-segmentation: on
>>> tx-udp_tnl-csum-segmentation: on
>>>
>>> As far as we understand, in the problematic scenario, nothing is ever
>>> filling in the checksums for the inner TCP packets, meaning the outer
>>> UDP checksum ends up being wrong on the target side. Is the host kernel
>>> responsible for doing that before passing the packet to the physical NIC
>>> (without the feature)? Or who would be?
>>>
>>> Turning off host_tunnel_csum without turning off host_tunnel does not help.
>>>
>>> Interestingly, turning off the features for the working physical NIC
>>> does not make it break:
>>> tx-udp_tnl-segmentation: off
>>> tx-udp_tnl-csum-segmentation: off
>>> Could it be that the NIC just always fills in the inner TCP checksums
>>> regardless of that setting?
>>>
>>> On the other hand, running
>>> localhost:~# ethtool -K eth2 tx-checksum-ip-generic off
>>> Actual changes:
>>> tx-checksum-ip-generic: off
>>> tx-tcp-segmentation: off [not requested]
>>> tx-tcp-ecn-segmentation: off [not requested]
>>> tx-tcp6-segmentation: off [not requested]
>>> tx-udp-segmentation: off [not requested]
>>> inside the guests makes it work for the physical NIC without the
>>> tx-udp_tnl* features.
>>>
>>> I wanted to ask if this configuration is expected to be unsupported and
>>> if the management is expected to turn off the feature on the commandline
>>> if the traffic might go over a physical NIC without the feature. Or if
>>> this could be a kernel or NIC bug that should be investigated further?
>>> In the former case, should the option really be turned on by default
>>> with new machine versions?
>>
>> Thank you for the detailed report. The configuration you describe is
>> supported and expected to work. The fact that different results are
>> obtained on top of a NIC with:
>>
>> [1] tx-udp_tnl-segmentation: off [fixed]
>>
>> WRT to similar setup on top of NIC with:
>>
>> [2] tx-udp_tnl-segmentation: off
>>
>> is indeed strange/unexpected, as the two scenarios are indistinguishable
>> from the stack perspective. I suspect the issue is NIC driver dependent.
>>
>> I understand [1] is using a tg3 driver, and [2] bnxt, both running Linux
>> 7.0.2, am I correct?
> 
> Yes.
> 
>> If you disable csum offloading on the tg3 NIC, does that impact the results?
> 
> Yes, doing
> 
> root@tamy3:~# ethtool -K nic3 tx-checksum-ipv4 off
> Actual changes:
> tx-checksum-ipv4: off
> tx-tcp-segmentation: off [not requested]
> tx-tcp-ecn-segmentation: off [not requested]
> 
> on both hosts makes it work.
> 
>> If you have such data handy, could you please share pcap captures on
>> both ends? links to some accessible URL would be better than sending a
>> lot of data to the ML, I think.
> 
> I captured the following while the problem is present with
> tcpdump -i foo udp port 4789 -w bar.pcap
> on the host interfaces (tap, bridge and physical NIC) just to be sure.
> Looking at it with tcpdump -envvvr, within the same host, only the
> timestamps change. Between the hosts, the UDP checksums do change, but
> the inner TCP checksums do not. So I suppose the NIC fills in the UDP
> checksum based on the still wrong data? Since the UDP checksum would
> already be correct if the TCP checksums would be fixed up?
> 
> For the NIC with the tx-udp_tnl features, the inner TCP checksums do get
> corrected and the UDP checksum stays the same. I did not include
> captures for this.
> 
> IPs for the guest running iperf -s (on host tamy2)
> 10.48.6.81 for the virtualized NIC
> 10.0.123.102 for the VXLAN
> 
> IPs for the guest running iperf -c (on host tamy3):
> 10.48.6.101 for the virtualized NIC
> 10.0.123.103 for the VXLAN
> 
> The captures are short, so I take the liberty to just provide them directly:
> 
> [I] febner@enia ~> tar cf pcap.tar tamy*.pcap
> [I] febner@enia ~> xz pcap.tar
> [I] febner@enia ~> base64 -w 70 pcap.tar.xz
> /Td6WFoAAATm1rRGBMDXBYCgASEBFgAAAAAAAKQwOkPgT/8Cz10AOhhJ/551cIJN23SQMX
> Q2Us4cGiof2bxOS4FK4DxejNh+76NiWIpdIfOxrB5urac3FT0mPKMbUreSY+04/NhofcgS
> Zz41D6t/Xp+VkPxNYx7Xsp3xz4xUCsVuK205jz6G/NAY0bJ0+UrJuCkP0G5VBtn88hJstD
> 7qlaT7qcBLECseOO1OfqsLezxasbm5p614IL18cqAVMCMWucr/Kh2Oqth26v7zI4SVEJC/
> YSEgaOhfjCbQZSi85BEw9/NSZO6IqoyNLrEiPUPgXTWH63NssG+4RMuBswrkgN5Wld70B1
> mROOCwKbo9b9oXI4DumGHqgCV5jdAxzITpEjMQpvDKh6NvM5L/8v1cPiGjLFSL2JesZ0F5
> dTbstymv1q4eN+9f3ng+4AXCvDzaziYMwtGwxYyptK5qDI2oGsCIGwFDpP/ZEw7NYI9EMM
> G2+SDG6D8bKgKWl9Mi6EJcqSMVKFR1P1Z/P3XJ/9sWOMJug1IVYZGIJmtXXM3+roqOEGMF
> tco/LMUJHgdmfkitfuZ5tN1+0EVE0/f4GQiUpdidjqfZ2m9jL0svcGXUd5D3LN0tbh5vmP
> KzXQNtMQiMY6Fj7gbzDbOQGGW/L3/34B5YV+pWEpzhAbeTI9KL0ZF3vJ0OESlL9OMhrqgl
> WX23bxek2h9eG15eO9cderaoCOFb8NEKIjC+UTh2Ir7/ZFfDvlXeGB/3jXM8OTmWmJSr5b
> CrAvBQ4xvow3hwKq2Fbyu7aU6KycVpo03a+59LqxPyRfc3qRXcoUnp8MTi2YUk+kfYR6mI
> S9AE/5xYFzb7I40RUBPUm0OCzguzk9qlIcab3lnTFnrMWa+Cj9AMIkWEEf0tMzw0v9+17u
> VJg/8tWMad3d9Jc5Z6B9kOukzGvgVEWoq4z9snb/k6u2sBVY36q2iI1cmSPrI+UcF2GtSA
> Qs6bt/T/c1Xi2r0Up+tRDrIE9O2aNAAAAKAWpkIVfsvrAAHzBYCgAQAA6om1scRn+wIAAA
> AABFla

Thanks for the data. The bug is in the virtio_net driver; non GSO
packets requiring inner header csum are handled unmodified from the
guest to the host, and the H/W NICs has to compute the inner transport
header csum for the encap packet.

Could you please try the attached kernel patch? You will need to update
the kernel inside the guest.

> Do you have any tips where to start looking in the kernel? What is the
> expected place where the TCP checksums are corrected if the NIC does not
> have the tx-udp_tnl features?

Hopefully no more investigation needed. FTR, for non GSO packets, the
inner transport header csum should be computed inside the guest before
transmitting on the virtio net device.

For GSO packets such csum should be computed inside the host, just
before transmitting on the H/W NIC (if the latter does not support the
relevant offload).

Thanks,

Paolo



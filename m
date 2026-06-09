Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9150CD8CAE
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 07:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWqV4-0002mu-W1; Tue, 09 Jun 2026 03:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1wWqV1-0002mh-Fz
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 03:03:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1wWqUy-0000Ro-Sw
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 03:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780988623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3RioNI4a6NezbnjGgqTnlCDCXrf9CATqFbTeeaTlEPQ=;
 b=dUzJi0KU/kdX5Q3+OjYUVHf6czZ88c0P7pIvTqRRIKsgYhxNdzrgObqno0qLhfYmfuOXoQ
 APIUCU6spLoxkPBF3VCgpVW6uTZcrsI2ltWOEiKXHcKEPpjAMRXjvv153FLnURuupPNDoN
 TOyFnbqQutc4NFKghCh4pzPpzRgnFJU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-5QXE9mgzPySd0oaLjSR_lA-1; Tue, 09 Jun 2026 03:03:41 -0400
X-MC-Unique: 5QXE9mgzPySd0oaLjSR_lA-1
X-Mimecast-MFC-AGG-ID: 5QXE9mgzPySd0oaLjSR_lA_1780988620
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-45eebc943bfso2770114f8f.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 00:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780988620; x=1781593420; darn=nongnu.org;
 h=in-reply-to:content-language:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3RioNI4a6NezbnjGgqTnlCDCXrf9CATqFbTeeaTlEPQ=;
 b=QhE45+IgsftEYpn/9K6XVA703ZDZiZk36rHe52VwD++tVe1rFsG61VCAKkoz1PNnxU
 Z05IV6L8Dje7S/rY8Kh4GqJAEHS4gnWJZQIC0cnjNSLEHPzum7bmfn1QZ2rngIyeJMRc
 xkUIOXs6AySLTyih+34LddNxfoyIPO2tOl3+tEnJ2DNSZfQCBCl/l0oWFfxSc5k4G7nr
 bd0VFEU0bxSwal6wdvicxpklE2o+kLLab3TIxEi1sieMr7nVMSf2OiXu2UP91F5+RP0X
 E8xNBemxBY+yfgZoQvx0dUdvWzn5QTBLJ+9Hzl4jYOXRIWZZJSpZZf0CihX2wO7rq+yJ
 u2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780988620; x=1781593420;
 h=in-reply-to:content-language:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3RioNI4a6NezbnjGgqTnlCDCXrf9CATqFbTeeaTlEPQ=;
 b=XwrAiBAB5ed/H3O9vb63IhFODhe5xNgBFv4Ik79x8SArx9Mv1eyr0D7fJn7deNTJnY
 xiWZsarEM5sA6cz6W4yWkVvrtnGjnL4UvqZ98bd0izpFWR6TuDcpwFKlUE1xJaTmRpI5
 2R0fYUruxxyTP5NBz+4T8+GN0OGiwhY+tQD1lgNhPj40zl6KoiF8+HDEsmIynObHMWNp
 9LQbXoDQazYLoWRXd6wtW6rpZSjyk5mc8VOPPpW9/miTDoVZhb8+MN+1zMbFN+EdeCCO
 LFpioLpepzlWr7X+/CUoDUCo7X9xGwH1NkfAyTKk69ANj93ZX1sVyWO/0Eb/jCHxiBTv
 VvhQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Y11CMPiEjFczSTZ+oaqo1ux8z9Jwr0QThQ9BI5C9u7SNC18zi8TXUxEnE0oblaIGBE4z6tCf67Fjz@nongnu.org
X-Gm-Message-State: AOJu0YwXfBN7BololsMgep0zdLcYY3FxIjX2DaIE7om5BkRfCZGKLI+V
 Q49ISom+YNCfEZEqrn6g92yxC36LpcD2F8tgvtI+/3Ld09XEQr0n0Go0gcngHmIB/QkwT3iOjN+
 vbnw7MO4u74c8iD8ZPf4Mshw3/v643IQ0ghcBmCqSO6WkLu8e9gN5TU+C
X-Gm-Gg: Acq92OEC4rfGPsrbcE/KL2eKrkcVieP71CzMss8RlQxQCimqhA5rwFkolA+WdfX4oZF
 Nw5twP5T38u/Vt6w2jRUQoLanpBS6d2wVxvavqPrUW5JczqGcpPjJOZ8z0/eM9cEGvWVfgNK0DN
 /AgdzgO0n32mK7glx5JpQ7UuTuPeockIKjcnhHBdgoJw5OGndf2JwUsdPel8W20EKrFDBRaMiJN
 XI6GZyolzZCBGqdIgsd6g+MoWa6DxohwUlxu1IuHkiS3ssCdkNky4uEWignFjy97m/0UvHIP8+v
 /SuAGs+HLgj8FOGecBN74wyG8ol4Nbx+fITa6tY+QWlPyM0HI3KYBkGD3EMgVRIk/Zy8HU68Wek
 wA0cuG3kTpLTl/xyqG5RUAx0Z6Dv7w8b5Xuztc82ORQAG0H5+Atl5y7fmxKSZrtdk8A==
X-Received: by 2002:a05:6000:400d:b0:45e:dd32:92fa with SMTP id
 ffacd0b85a97d-46032b81e04mr27949041f8f.12.1780988619449; 
 Tue, 09 Jun 2026 00:03:39 -0700 (PDT)
X-Received: by 2002:a05:6000:400d:b0:45e:dd32:92fa with SMTP id
 ffacd0b85a97d-46032b81e04mr27948943f8f.12.1780988618830; 
 Tue, 09 Jun 2026 00:03:38 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.44])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f35fd33sm65525145f8f.35.2026.06.09.00.03.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2026 00:03:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------Hi5kyrYR8LeT3TwIPqxHwe2C"
Message-ID: <935be681-4920-4361-b54e-3c14da9fc368@redhat.com>
Date: Tue, 9 Jun 2026 09:03:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 12/14] virtio-net: Advertise UDP tunnel GSO support by
 default
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
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
 <375064ee-5a6f-44d4-8192-09f39804be69@redhat.com>
 <20260608160546-mutt-send-email-mst@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260608160546-mutt-send-email-mst@kernel.org>
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

This is a multi-part message in MIME format.
--------------Hi5kyrYR8LeT3TwIPqxHwe2C
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/8/26 10:06 PM, Michael S. Tsirkin wrote:
> On Mon, Jun 08, 2026 at 07:12:14PM +0200, Paolo Abeni wrote:
>> On 6/8/26 12:41 PM, Fiona Ebner wrote:
>>> Am 05.06.26 um 4:54 PM schrieb Paolo Abeni:
>>>> On 6/5/26 4:02 PM, Fiona Ebner wrote:
>>>>> Am 09.11.25 um 4:10 PM schrieb Michael S. Tsirkin:
>>>>>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>>>>>> index 17ed0ef919..3b85560f6f 100644
>>>>>> --- a/hw/net/virtio-net.c
>>>>>> +++ b/hw/net/virtio-net.c
>>>>>> @@ -4299,19 +4299,19 @@ static const Property virtio_net_properties[] = {
>>>>>>      VIRTIO_DEFINE_PROP_FEATURE("host_tunnel", VirtIONet,
>>>>>>                                 host_features_ex,
>>>>>>                                 VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO,
>>>>>> -                               false),
>>>>>> +                               true),
>>>>> it seems that the host_tunnel setting can cause issues when VXLAN
>>>>> traffic originating in a guest goes over a physical NIC which does not
>>>>> support the feature. We received several reports about the issue
>>>>> [0][1][2][3] and were able to reproduce it. Turning off the
>>>>> 'host_tunnel' property in the commandline for the VirtIO net device
>>>>> makes TCP traffic work. The network configuration from our reproducer
>>>>> setup is as follows:
>>>>>
>>>>>       guest A (iperf3 -c)                   guest B (iperf3 -s)
>>>>>   vxlan using vNIC as underlay         vxlan using vNIC as underlay
>>>>> virtualized NIC exposed to guest     virtualized NIC exposed to guest
>>>>>     ---guest boundary---                  ---guest boundary---
>>>>>  tap device connected to bridge       tap device connected to bridge
>>>>> bridge with physical NIC as port     bridge with physical NIC as port
>>>>>         physical NIC   <---host boundary--->   physical NIC
>>>>>
>>>>> Bridge configuration:
>>>>> iface vmbr0 inet static
>>>>> 	address 10.48.0.109/20
>>>>> 	gateway 10.48.0.1
>>>>> 	bridge-ports nic3
>>>>> 	bridge-stp off
>>>>> 	bridge-fd 0
>>>>> 	bridge-vlan-aware yes
>>>>> 	bridge-vids 2-4094
>>>>>
>>>>> VXLAN created with:
>>>>> ip link add vxlan0 type vxlan id 100 remote X dstport 4789 dev eth1
>>>>> where eth1 is the virtualized NIC exposed to the guest
>>>>>
>>>>> The physical NIC does not have the feature:
>>>>> Ethernet controller [0200]: Broadcom Inc. and subsidiaries NetXtreme
>>>>> BCM5719 Gigabit Ethernet PCIe [14e4:1657] (rev 01)
>>>>> tx-udp_tnl-segmentation: off [fixed]
>>>>> tx-udp_tnl-csum-segmentation: off [fixed]
>>>>>
>>>>> Using a physical NIC which does have the feature works:
>>>>> Ethernet controller [0200]: Broadcom Inc. and subsidiaries BCM57504
>>>>> NetXtreme-E 10Gb/25Gb/40Gb/50Gb/100Gb Ethernet [14e4:1751] (rev 11)
>>>>> tx-udp_tnl-segmentation: on
>>>>> tx-udp_tnl-csum-segmentation: on
>>>>>
>>>>> Host kernel:
>>>>> Proxmox VE with 7.0.2-6-pve
>>>>>
>>>>> Guest kernel:
>>>>> Apline with 6.18.34-0-lts
>>>>>
>>>>> QEMU commandline for the vNIC:
>>>>>> -netdev 'type=tap,id=net2,ifname=tap103i2,script=/usr/libexec/qemu-server/pve-bridge,downscript=/usr/libexec/qemu-server/pve-bridgedown,vhost=on' \
>>>>>> -device 'virtio-net-pci,mac=BC:24:11:78:C3:3B,netdev=net2,bus=pci.0,addr=0x14,id=net2,rx_queue_size=1024,tx_queue_size=256,host_mtu=1500' \
>>>>>
>>>>> We can see that QEMU sets the features for the tap interface via ioctl()
>>>>> and the host kernel allows it:
>>>>> tx-udp_tnl-segmentation: on
>>>>> tx-udp_tnl-csum-segmentation: on
>>>>>
>>>>> As far as we understand, in the problematic scenario, nothing is ever
>>>>> filling in the checksums for the inner TCP packets, meaning the outer
>>>>> UDP checksum ends up being wrong on the target side. Is the host kernel
>>>>> responsible for doing that before passing the packet to the physical NIC
>>>>> (without the feature)? Or who would be?
>>>>>
>>>>> Turning off host_tunnel_csum without turning off host_tunnel does not help.
>>>>>
>>>>> Interestingly, turning off the features for the working physical NIC
>>>>> does not make it break:
>>>>> tx-udp_tnl-segmentation: off
>>>>> tx-udp_tnl-csum-segmentation: off
>>>>> Could it be that the NIC just always fills in the inner TCP checksums
>>>>> regardless of that setting?
>>>>>
>>>>> On the other hand, running
>>>>> localhost:~# ethtool -K eth2 tx-checksum-ip-generic off
>>>>> Actual changes:
>>>>> tx-checksum-ip-generic: off
>>>>> tx-tcp-segmentation: off [not requested]
>>>>> tx-tcp-ecn-segmentation: off [not requested]
>>>>> tx-tcp6-segmentation: off [not requested]
>>>>> tx-udp-segmentation: off [not requested]
>>>>> inside the guests makes it work for the physical NIC without the
>>>>> tx-udp_tnl* features.
>>>>>
>>>>> I wanted to ask if this configuration is expected to be unsupported and
>>>>> if the management is expected to turn off the feature on the commandline
>>>>> if the traffic might go over a physical NIC without the feature. Or if
>>>>> this could be a kernel or NIC bug that should be investigated further?
>>>>> In the former case, should the option really be turned on by default
>>>>> with new machine versions?
>>>>
>>>> Thank you for the detailed report. The configuration you describe is
>>>> supported and expected to work. The fact that different results are
>>>> obtained on top of a NIC with:
>>>>
>>>> [1] tx-udp_tnl-segmentation: off [fixed]
>>>>
>>>> WRT to similar setup on top of NIC with:
>>>>
>>>> [2] tx-udp_tnl-segmentation: off
>>>>
>>>> is indeed strange/unexpected, as the two scenarios are indistinguishable
>>>> from the stack perspective. I suspect the issue is NIC driver dependent.
>>>>
>>>> I understand [1] is using a tg3 driver, and [2] bnxt, both running Linux
>>>> 7.0.2, am I correct?
>>>
>>> Yes.
>>>
>>>> If you disable csum offloading on the tg3 NIC, does that impact the results?
>>>
>>> Yes, doing
>>>
>>> root@tamy3:~# ethtool -K nic3 tx-checksum-ipv4 off
>>> Actual changes:
>>> tx-checksum-ipv4: off
>>> tx-tcp-segmentation: off [not requested]
>>> tx-tcp-ecn-segmentation: off [not requested]
>>>
>>> on both hosts makes it work.
>>>
>>>> If you have such data handy, could you please share pcap captures on
>>>> both ends? links to some accessible URL would be better than sending a
>>>> lot of data to the ML, I think.
>>>
>>> I captured the following while the problem is present with
>>> tcpdump -i foo udp port 4789 -w bar.pcap
>>> on the host interfaces (tap, bridge and physical NIC) just to be sure.
>>> Looking at it with tcpdump -envvvr, within the same host, only the
>>> timestamps change. Between the hosts, the UDP checksums do change, but
>>> the inner TCP checksums do not. So I suppose the NIC fills in the UDP
>>> checksum based on the still wrong data? Since the UDP checksum would
>>> already be correct if the TCP checksums would be fixed up?
>>>
>>> For the NIC with the tx-udp_tnl features, the inner TCP checksums do get
>>> corrected and the UDP checksum stays the same. I did not include
>>> captures for this.
>>>
>>> IPs for the guest running iperf -s (on host tamy2)
>>> 10.48.6.81 for the virtualized NIC
>>> 10.0.123.102 for the VXLAN
>>>
>>> IPs for the guest running iperf -c (on host tamy3):
>>> 10.48.6.101 for the virtualized NIC
>>> 10.0.123.103 for the VXLAN
>>>
>>> The captures are short, so I take the liberty to just provide them directly:
>>>
>>> [I] febner@enia ~> tar cf pcap.tar tamy*.pcap
>>> [I] febner@enia ~> xz pcap.tar
>>> [I] febner@enia ~> base64 -w 70 pcap.tar.xz
>>> /Td6WFoAAATm1rRGBMDXBYCgASEBFgAAAAAAAKQwOkPgT/8Cz10AOhhJ/551cIJN23SQMX
>>> Q2Us4cGiof2bxOS4FK4DxejNh+76NiWIpdIfOxrB5urac3FT0mPKMbUreSY+04/NhofcgS
>>> Zz41D6t/Xp+VkPxNYx7Xsp3xz4xUCsVuK205jz6G/NAY0bJ0+UrJuCkP0G5VBtn88hJstD
>>> 7qlaT7qcBLECseOO1OfqsLezxasbm5p614IL18cqAVMCMWucr/Kh2Oqth26v7zI4SVEJC/
>>> YSEgaOhfjCbQZSi85BEw9/NSZO6IqoyNLrEiPUPgXTWH63NssG+4RMuBswrkgN5Wld70B1
>>> mROOCwKbo9b9oXI4DumGHqgCV5jdAxzITpEjMQpvDKh6NvM5L/8v1cPiGjLFSL2JesZ0F5
>>> dTbstymv1q4eN+9f3ng+4AXCvDzaziYMwtGwxYyptK5qDI2oGsCIGwFDpP/ZEw7NYI9EMM
>>> G2+SDG6D8bKgKWl9Mi6EJcqSMVKFR1P1Z/P3XJ/9sWOMJug1IVYZGIJmtXXM3+roqOEGMF
>>> tco/LMUJHgdmfkitfuZ5tN1+0EVE0/f4GQiUpdidjqfZ2m9jL0svcGXUd5D3LN0tbh5vmP
>>> KzXQNtMQiMY6Fj7gbzDbOQGGW/L3/34B5YV+pWEpzhAbeTI9KL0ZF3vJ0OESlL9OMhrqgl
>>> WX23bxek2h9eG15eO9cderaoCOFb8NEKIjC+UTh2Ir7/ZFfDvlXeGB/3jXM8OTmWmJSr5b
>>> CrAvBQ4xvow3hwKq2Fbyu7aU6KycVpo03a+59LqxPyRfc3qRXcoUnp8MTi2YUk+kfYR6mI
>>> S9AE/5xYFzb7I40RUBPUm0OCzguzk9qlIcab3lnTFnrMWa+Cj9AMIkWEEf0tMzw0v9+17u
>>> VJg/8tWMad3d9Jc5Z6B9kOukzGvgVEWoq4z9snb/k6u2sBVY36q2iI1cmSPrI+UcF2GtSA
>>> Qs6bt/T/c1Xi2r0Up+tRDrIE9O2aNAAAAKAWpkIVfsvrAAHzBYCgAQAA6om1scRn+wIAAA
>>> AABFla
>>
>> Thanks for the data. The bug is in the virtio_net driver; non GSO
>> packets requiring inner header csum are handled unmodified from the
>> guest to the host, and the H/W NICs has to compute the inner transport
>> header csum for the encap packet.
>>
>> Could you please try the attached kernel patch? You will need to update
>> the kernel inside the guest.
> 
> Paolo was there supposed to be a patch here?

I'm sorry, ENOCOFFEE here. Thanks Michael for the head-up!

Attaching the patch now.

/P
--------------Hi5kyrYR8LeT3TwIPqxHwe2C
Content-Type: text/x-patch; charset=UTF-8; name="virtio_net_feat.patch"
Content-Disposition: attachment; filename="virtio_net_feat.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3Zp
cnRpb19uZXQuYwppbmRleCBmNGFkY2ZlZTdhODAuLjcyNWU2MzE1MDM2YSAxMDA2NDQKLS0t
IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCisrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19u
ZXQuYwpAQCAtNjIyMiw2ICs2MjIyLDE5IEBAIHN0YXRpYyB2b2lkIHZpcnRuZXRfZnJlZV9p
cnFfbW9kZXIoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkpCiAJcnRubF91bmxvY2soKTsKIH0K
IAorc3RhdGljIG5ldGRldl9mZWF0dXJlc190IHZpcnRuZXRfZmVhdHVyZXNfY2hlY2soc3Ry
dWN0IHNrX2J1ZmYgKnNrYiwKKwkJCQkJICAgICAgICBzdHJ1Y3QgbmV0X2RldmljZSAqZGV2
LAorCQkJCQkgICAgICAgIG5ldGRldl9mZWF0dXJlc190IGZlYXR1cmVzKQoreworCS8qIElu
bmVyIGNzdW0gb2ZmbG9hZCBpcyBvbmx5IGF2YWlsYWJsZSBmb3IgR1NPIHBhY2tldHMuICov
CisJaWYgKHNrYi0+ZW5jYXBzdWxhdGlvbiAmJiAhc2tiX2lzX2dzbyhza2IpKQorCQlyZXR1
cm4gZmVhdHVyZXMgJiB+TkVUSUZfRl9DU1VNX01BU0s7CisKKwkvKiBQYXNzdGhydS4gKi8K
KwlyZXR1cm4gZmVhdHVyZXM7Cit9CisKKwogc3RhdGljIGNvbnN0IHN0cnVjdCBuZXRfZGV2
aWNlX29wcyB2aXJ0bmV0X25ldGRldiA9IHsKIAkubmRvX29wZW4gICAgICAgICAgICA9IHZp
cnRuZXRfb3BlbiwKIAkubmRvX3N0b3AgICAJICAgICA9IHZpcnRuZXRfY2xvc2UsCkBAIC02
MjM1LDcgKzYyNDgsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG5ldF9kZXZpY2Vfb3BzIHZp
cnRuZXRfbmV0ZGV2ID0gewogCS5uZG9fYnBmCQk9IHZpcnRuZXRfeGRwLAogCS5uZG9feGRw
X3htaXQJCT0gdmlydG5ldF94ZHBfeG1pdCwKIAkubmRvX3hza193YWtldXAgICAgICAgICA9
IHZpcnRuZXRfeHNrX3dha2V1cCwKLQkubmRvX2ZlYXR1cmVzX2NoZWNrCT0gcGFzc3RocnVf
ZmVhdHVyZXNfY2hlY2ssCisJLm5kb19mZWF0dXJlc19jaGVjawk9IHZpcnRuZXRfZmVhdHVy
ZXNfY2hlY2ssCiAJLm5kb19nZXRfcGh5c19wb3J0X25hbWUJPSB2aXJ0bmV0X2dldF9waHlz
X3BvcnRfbmFtZSwKIAkubmRvX3NldF9mZWF0dXJlcwk9IHZpcnRuZXRfc2V0X2ZlYXR1cmVz
LAogCS5uZG9fdHhfdGltZW91dAkJPSB2aXJ0bmV0X3R4X3RpbWVvdXQsCg==

--------------Hi5kyrYR8LeT3TwIPqxHwe2C--



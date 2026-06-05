Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08240CD6E79
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 14:56:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVVxk-0001LI-7E; Fri, 05 Jun 2026 10:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1wVVxX-0001Kb-Oj
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 10:55:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1wVVxV-0004ZF-MO
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 10:55:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780671339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8p5mZu74fGrESFXJMy7M6633VpAD+iCO5vCLb9F43eE=;
 b=aI+Laim0dKzMKbTG4Xhg9mVidCNqHyIqaOe5JMulLzf97GY2ya3j2KhUt5Ccj2TOARg6A7
 J1aW8ajErv6NOnzTF+eMmbN+i3mlPZHEX158VtKLBCOaKTRZl7Fy64S7JAUWx25zdXN3Zo
 mjxZmwITucOzZppvCAQ3x9SwAPmZ4SU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-vKzQO8sQNCOvdxa9em6rpQ-1; Fri, 05 Jun 2026 10:54:33 -0400
X-MC-Unique: vKzQO8sQNCOvdxa9em6rpQ-1
X-Mimecast-MFC-AGG-ID: vKzQO8sQNCOvdxa9em6rpQ_1780671272
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490b8adf8b8so19906695e9.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2026 07:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780671272; x=1781276072; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8p5mZu74fGrESFXJMy7M6633VpAD+iCO5vCLb9F43eE=;
 b=KNLeqgzZwc2GzLuFEeprmZ+yAsH7MVKfyEJLiSV/pIb8n+dVBJsB6NoC3Pz0Pilitu
 ZBK82jYJQVu9J0zPxF7er2USBWYe6ctMQscDU/xPDrjgZB76BV/LQFLN7/nV1C6HVuBb
 5GOtRbZcVbqHJdSnh8IUbJ9D4ofxmr0VztJowd0L+fx3TcVpuaZdS3+5s5iirAsHNJy4
 RD73TY80rWpf4KW+HVX9yRG9KgyLFxZOjPRUnyH0iPJ04jHSR2eohMbk/f4bBx1XdCVl
 TSZxzS6OOQwkqNAmvDL22cQwshJYI8EwNacf7MkzMHfFwsHEGug3moeWoFnOFnnz9Hv4
 4IXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780671272; x=1781276072;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8p5mZu74fGrESFXJMy7M6633VpAD+iCO5vCLb9F43eE=;
 b=fCck9uaVGwHPjQOeffsinM4jp+CcKGP9QR73D6/aZMWWtetugDuYVBqK3tTow9CNZg
 Nuu9reKTxr5yaK/DHUQPTGXYhAanIzodQ4Gq7MXylun87Ci1yVSbw3hdCqoFLojAkXtj
 7okDjrWOfVH9HDwmeLhAoRdNRz5PwJOYwbiyXoS41hLP7ShhYDansI/PH4PvFoBJ+NsH
 BnwKYJ5qgPfHPpbegivCw68aP4mScVymRuihGdPptZE2duiqksd3adHHZXIV7etwZqSS
 ugqgECWpQeq+Mn6cOEBCzkUx2fJiZoNH4jRvxq87UvyCfVHnfSjxJX7PM4aNZPh2xsjp
 i1/Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9dCOE3N+0wacEK+gBblTBogET29qhvti/X+Rhgyfkr6Xy7SLbHINSgGkMp/MT3X5/Hm66+FZO2ejxb@nongnu.org
X-Gm-Message-State: AOJu0Yx5Inkil2006sNmzFoqDQauXnZwthcxkS0+6vMhUXticP2znZv4
 Ck4C0pKR0kF5zwuvNZNtFw/QDX0UkBdhV9OXxR50YggGcZwqHsXaBGJFUacaBB9VbwPL82z9SdZ
 Jw2/fR5yU6Yuh1LZFjvOiGi0NGjkGgHTjjwEKE+TIPa4xAyOacKkOxBZF
X-Gm-Gg: Acq92OFwi+/kBjayiNRaVfuLnHDX3oSVhX782A0DK4KZe5BTMbbQaigq4JCq/7nzZii
 +mfxqDU3WAzVFBzrk6y5D+2p8jNgBZflA21D4us+670mUNHbBOrXQ8jpiWv9fM6jc34eG2kOmaS
 FM87ocg5H6neFTFsBhXWj1U92fNDwWxZKLmar1kQxdPa6XRFA/oUCq9lCl9u7rl0yuEXlRW3tnz
 IPoJwJGy20OAh4kDkne9MksJkEg9WsdipPuFH0jwTiNJJ3h2dGp1qhcVqzLmpaj0jymXEsCTzpn
 krNjTkmLf0stCGzVeTnajC/XBIFwRMwGg3+v1+hIEHE5RzO01MpDwBCwrfLGDSuvQCwc18DDQAO
 XRFa7ZwNTJeMHCF/WdMhirP2anmQNwvlpuuMSugiEY2YKr4+KlOK8sTu97gaJ27d/0Vk=
X-Received: by 2002:a05:600c:608e:b0:490:b355:9c8c with SMTP id
 5b1f17b1804b1-490c25f3f00mr61407355e9.23.1780671272024; 
 Fri, 05 Jun 2026 07:54:32 -0700 (PDT)
X-Received: by 2002:a05:600c:608e:b0:490:b355:9c8c with SMTP id
 5b1f17b1804b1-490c25f3f00mr61406895e9.23.1780671271606; 
 Fri, 05 Jun 2026 07:54:31 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.59])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3918d7sm149055915e9.2.2026.06.05.07.54.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2026 07:54:31 -0700 (PDT)
Message-ID: <39100539-1c43-431b-886d-7d42850bc4c5@redhat.com>
Date: Fri, 5 Jun 2026 16:54:29 +0200
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
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <077647f6-d569-4918-9aea-c0597a6ddbc8@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi,

On 6/5/26 4:02 PM, Fiona Ebner wrote:
> Am 09.11.25 um 4:10 PM schrieb Michael S. Tsirkin:
>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>> index 17ed0ef919..3b85560f6f 100644
>> --- a/hw/net/virtio-net.c
>> +++ b/hw/net/virtio-net.c
>> @@ -4299,19 +4299,19 @@ static const Property virtio_net_properties[] = {
>>      VIRTIO_DEFINE_PROP_FEATURE("host_tunnel", VirtIONet,
>>                                 host_features_ex,
>>                                 VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO,
>> -                               false),
>> +                               true),
> it seems that the host_tunnel setting can cause issues when VXLAN
> traffic originating in a guest goes over a physical NIC which does not
> support the feature. We received several reports about the issue
> [0][1][2][3] and were able to reproduce it. Turning off the
> 'host_tunnel' property in the commandline for the VirtIO net device
> makes TCP traffic work. The network configuration from our reproducer
> setup is as follows:
> 
>       guest A (iperf3 -c)                   guest B (iperf3 -s)
>   vxlan using vNIC as underlay         vxlan using vNIC as underlay
> virtualized NIC exposed to guest     virtualized NIC exposed to guest
>     ---guest boundary---                  ---guest boundary---
>  tap device connected to bridge       tap device connected to bridge
> bridge with physical NIC as port     bridge with physical NIC as port
>         physical NIC   <---host boundary--->   physical NIC
> 
> Bridge configuration:
> iface vmbr0 inet static
> 	address 10.48.0.109/20
> 	gateway 10.48.0.1
> 	bridge-ports nic3
> 	bridge-stp off
> 	bridge-fd 0
> 	bridge-vlan-aware yes
> 	bridge-vids 2-4094
> 
> VXLAN created with:
> ip link add vxlan0 type vxlan id 100 remote X dstport 4789 dev eth1
> where eth1 is the virtualized NIC exposed to the guest
> 
> The physical NIC does not have the feature:
> Ethernet controller [0200]: Broadcom Inc. and subsidiaries NetXtreme
> BCM5719 Gigabit Ethernet PCIe [14e4:1657] (rev 01)
> tx-udp_tnl-segmentation: off [fixed]
> tx-udp_tnl-csum-segmentation: off [fixed]
> 
> Using a physical NIC which does have the feature works:
> Ethernet controller [0200]: Broadcom Inc. and subsidiaries BCM57504
> NetXtreme-E 10Gb/25Gb/40Gb/50Gb/100Gb Ethernet [14e4:1751] (rev 11)
> tx-udp_tnl-segmentation: on
> tx-udp_tnl-csum-segmentation: on
> 
> Host kernel:
> Proxmox VE with 7.0.2-6-pve
> 
> Guest kernel:
> Apline with 6.18.34-0-lts
> 
> QEMU commandline for the vNIC:
>> -netdev 'type=tap,id=net2,ifname=tap103i2,script=/usr/libexec/qemu-server/pve-bridge,downscript=/usr/libexec/qemu-server/pve-bridgedown,vhost=on' \
>> -device 'virtio-net-pci,mac=BC:24:11:78:C3:3B,netdev=net2,bus=pci.0,addr=0x14,id=net2,rx_queue_size=1024,tx_queue_size=256,host_mtu=1500' \
> 
> We can see that QEMU sets the features for the tap interface via ioctl()
> and the host kernel allows it:
> tx-udp_tnl-segmentation: on
> tx-udp_tnl-csum-segmentation: on
> 
> As far as we understand, in the problematic scenario, nothing is ever
> filling in the checksums for the inner TCP packets, meaning the outer
> UDP checksum ends up being wrong on the target side. Is the host kernel
> responsible for doing that before passing the packet to the physical NIC
> (without the feature)? Or who would be?
> 
> Turning off host_tunnel_csum without turning off host_tunnel does not help.
> 
> Interestingly, turning off the features for the working physical NIC
> does not make it break:
> tx-udp_tnl-segmentation: off
> tx-udp_tnl-csum-segmentation: off
> Could it be that the NIC just always fills in the inner TCP checksums
> regardless of that setting?
> 
> On the other hand, running
> localhost:~# ethtool -K eth2 tx-checksum-ip-generic off
> Actual changes:
> tx-checksum-ip-generic: off
> tx-tcp-segmentation: off [not requested]
> tx-tcp-ecn-segmentation: off [not requested]
> tx-tcp6-segmentation: off [not requested]
> tx-udp-segmentation: off [not requested]
> inside the guests makes it work for the physical NIC without the
> tx-udp_tnl* features.
> 
> I wanted to ask if this configuration is expected to be unsupported and
> if the management is expected to turn off the feature on the commandline
> if the traffic might go over a physical NIC without the feature. Or if
> this could be a kernel or NIC bug that should be investigated further?
> In the former case, should the option really be turned on by default
> with new machine versions?

Thank you for the detailed report. The configuration you describe is
supported and expected to work. The fact that different results are
obtained on top of a NIC with:

[1] tx-udp_tnl-segmentation: off [fixed]

WRT to similar setup on top of NIC with:

[2] tx-udp_tnl-segmentation: off

is indeed strange/unexpected, as the two scenarios are indistinguishable
from the stack perspective. I suspect the issue is NIC driver dependent.

I understand [1] is using a tg3 driver, and [2] bnxt, both running Linux
7.0.2, am I correct?

If you disable csum offloading on the tg3 NIC, does that impact the results?

If you have such data handy, could you please share pcap captures on
both ends? links to some accessible URL would be better than sending a
lot of data to the ML, I think.

Thanks,

Paolo



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6443AE7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 17:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMsPT-0005xm-1L; Sun, 15 Dec 2024 12:28:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1tMsPI-0005xA-Kd
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 12:27:54 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1tMsPG-0006Hd-9q
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 12:27:52 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-728ea1573c0so2751003b3a.0
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 09:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734283667; x=1734888467; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=9elCsR7GKhbSD9mtaFov2ccb1SavU/pc9+wEnwKJ294=;
 b=f8uqoU9AyKZyPMKl3wRZDGKB/FGkEzuVLJb6BzjsnTDhohc+eHD7I+CMOBpJREHmch
 5W3fWJNMAQUwR00GxnnRZ3xjXUNeENrH8jZWcUJCUUpCtLCW4R+UCDeKF0ftLCj2Fy0a
 RKnFtReY3btBE7SmErqza4th9+fzK0ZpKucQT273nNfElYQXWqDeYVuwe8ZC1axWWn1M
 yRNtfC3PgP1RvbyxFbU1/zFC2weKaMmJXrsJe/c+rXHpAy9EuaHgt739Itd9ehiTgNtA
 bcU8Ua1byXB2uNlYNpqh/j6VWdx/QyZbPpm3ZXKBGZaBtQYbUmYhsdPrc7aJMPKm2FaR
 kgCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734283667; x=1734888467;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9elCsR7GKhbSD9mtaFov2ccb1SavU/pc9+wEnwKJ294=;
 b=rgo73g7T6rxEQgYSs/yk4q2r0d7sTKiikB2SGkIuktk9F8rj46fvWo7mPBEgU6GlmK
 gElJxsgaPFgq4/aVuDknCp/HzDZfvHKkYWzOsWFtrtbis+EqRsRxP9BGfxVflDBTPwp8
 q8sb/f3wFPEboic5h9k7tHVYzMQTa1FDSJ7Udncv0+RVPN0gYK2CSKCFB46cpe2pA2ui
 9cnXfuxJ++QViOjVhvCu1mmdpaaCUZiLDKynHsLPwEm7D/OuPPV8WSoBOgLOG8REjqMx
 XJRsY+VLejpJZlujycaqyyBobVqwZiG30mZ2xNhgfiqm66BfYmpxXh0WPKNrYzFhre7H
 RKWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoHjsK0cHkq6YWl8n7aB96ioeinQreV3QmiePlF9LhYjBJGiNlmw57y+KRzHL3HJYt7+mzSW6BaFW+@nongnu.org
X-Gm-Message-State: AOJu0YxkkeZgzC1Eb6FJkYlp8KQpxcXALfTaoMw8WQ28XUUC5tBepzh3
 lusOpf7NY/D2XGcEx2Xaoki9gpRH9d1WqPJ5E7feN/loou5cZM2q
X-Gm-Gg: ASbGncvUgTqzw8PTHFiWK5BabMAraXGO73OnNVVQ8fEMuMcptznhXyw7m/RoLHqCRdn
 3NP2WNviQ09Y97HS95VLAIYvYrpIjVm/jAp4iUtl6po4dxLvO1ju7limQpNMXxwkMYV+v9TBId7
 z2w8leCrbiTizwhVjMlhIRtqOZoMeldfAd82ySU+RGWqEYd2f2O5Gpr4DPhuRqjrgNB3XxUzdlm
 rviI6FGu1vmLjibH3xqu42Sxw==
X-Google-Smtp-Source: AGHT+IFYkmtUczkrvJw1hSVXlGa7oA+QWX/8SPUGFX3xrvFnZkay3bjppJGKtybvOdzTW3QMRJOYEg==
X-Received: by 2002:a17:902:ce01:b0:216:73a5:ea16 with SMTP id
 d9443c01a7336-218929d6d6bmr125524705ad.21.1734283666760; 
 Sun, 15 Dec 2024 09:27:46 -0800 (PST)
Received: from [192.168.1.18] ([223.233.80.80])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1e5404csm28605705ad.150.2024.12.15.09.27.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Dec 2024 09:27:46 -0800 (PST)
Message-ID: <f95a9e51-6aa1-4aeb-959e-99e9b31109be@gmail.com>
Date: Sun, 15 Dec 2024 22:57:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 0/5] Add packed virtqueue to shadow virtqueue
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 Sahil Siddiq <sahilcdq@proton.me>
References: <20241205203430.76251-1-sahilcdq@proton.me>
 <CAJaqyWerdWk5S0Sxt4oMUCc8FQJTxopyvhtyOV6ocbXmJ_p7Dw@mail.gmail.com>
Content-Language: en-US
From: Sahil Siddiq <icegambit91@gmail.com>
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <CAJaqyWerdWk5S0Sxt4oMUCc8FQJTxopyvhtyOV6ocbXmJ_p7Dw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=icegambit91@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 12/10/24 2:57 PM, Eugenio Perez Martin wrote:
> On Thu, Dec 5, 2024 at 9:34 PM Sahil Siddiq <icegambit91@gmail.com> wrote:
>>
>> Hi,
>>
>> There are two issues that I found while trying to test
>> my changes. I thought I would send the patch series
>> as well in case that helps in troubleshooting. I haven't
>> been able to find an issue in the implementation yet.
>> Maybe I am missing something.
>>
>> I have been following the "Hands on vDPA: what do you do
>> when you ain't got the hardware v2 (Part 2)" [1] blog to
>> test my changes. To boot the L1 VM, I ran:
>>
>> sudo ./qemu/build/qemu-system-x86_64 \
>> -enable-kvm \
>> -drive file=//home/valdaarhun/valdaarhun/qcow2_img/L1.qcow2,media=disk,if=virtio \
>> -net nic,model=virtio \
>> -net user,hostfwd=tcp::2222-:22 \
>> -device intel-iommu,snoop-control=on \
>> -device virtio-net-pci,netdev=net0,disable-legacy=on,disable-modern=off,iommu_platform=on,guest_uso4=off,guest_uso6=off,host_uso=off,guest_announce=off,ctrl_vq=on,ctrl_rx=on,packed=on,event_idx=off,bus=pcie.0,addr=0x4 \
>> -netdev tap,id=net0,script=no,downscript=no \
>> -nographic \
>> -m 8G \
>> -smp 4 \
>> -M q35 \
>> -cpu host 2>&1 | tee vm.log
>>
>> Without "guest_uso4=off,guest_uso6=off,host_uso=off,
>> guest_announce=off" in "-device virtio-net-pci", QEMU
>> throws "vdpa svq does not work with features" [2] when
>> trying to boot L2.
>>
>> The enums added in commit #2 in this series is new and
>> wasn't in the earlier versions of the series. Without
>> this change, x-svq=true throws "SVQ invalid device feature
>> flags" [3] and x-svq is consequently disabled.
>>
>> The first issue is related to running traffic in L2
>> with vhost-vdpa.
>>
>> In L0:
>>
>> $ ip addr add 111.1.1.1/24 dev tap0
>> $ ip link set tap0 up
>> $ ip addr show tap0
>> 4: tap0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UNKNOWN group default qlen 1000
>>      link/ether d2:6d:b9:61:e1:9a brd ff:ff:ff:ff:ff:ff
>>      inet 111.1.1.1/24 scope global tap0
>>         valid_lft forever preferred_lft forever
>>      inet6 fe80::d06d:b9ff:fe61:e19a/64 scope link proto kernel_ll
>>         valid_lft forever preferred_lft forever
>>
>> I am able to run traffic in L2 when booting without
>> x-svq.
>>
>> In L1:
>>
>> $ ./qemu/build/qemu-system-x86_64 \
>> -nographic \
>> -m 4G \
>> -enable-kvm \
>> -M q35 \
>> -drive file=//root/L2.qcow2,media=disk,if=virtio \
>> -netdev type=vhost-vdpa,vhostdev=/dev/vhost-vdpa-0,id=vhost-vdpa0 \
>> -device virtio-net-pci,netdev=vhost-vdpa0,disable-legacy=on,disable-modern=off,ctrl_vq=on,ctrl_rx=on,event_idx=off,bus=pcie.0,addr=0x7 \
>> -smp 4 \
>> -cpu host \
>> 2>&1 | tee vm.log
>>
>> In L2:
>>
>> # ip addr add 111.1.1.2/24 dev eth0
>> # ip addr show eth0
>> 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
>>      link/ether 52:54:00:12:34:57 brd ff:ff:ff:ff:ff:ff
>>      altname enp0s7
>>      inet 111.1.1.2/24 scope global eth0
>>         valid_lft forever preferred_lft forever
>>      inet6 fe80::9877:de30:5f17:35f9/64 scope link noprefixroute
>>         valid_lft forever preferred_lft forever
>>
>> # ip route
>> 111.1.1.0/24 dev eth0 proto kernel scope link src 111.1.1.2
>>
>> # ping 111.1.1.1 -w3
>> PING 111.1.1.1 (111.1.1.1) 56(84) bytes of data.
>> 64 bytes from 111.1.1.1: icmp_seq=1 ttl=64 time=0.407 ms
>> 64 bytes from 111.1.1.1: icmp_seq=2 ttl=64 time=0.671 ms
>> 64 bytes from 111.1.1.1: icmp_seq=3 ttl=64 time=0.291 ms
>>
>> --- 111.1.1.1 ping statistics ---
>> 3 packets transmitted, 3 received, 0% packet loss, time 2034ms
>> rtt min/avg/max/mdev = 0.291/0.456/0.671/0.159 ms
>>
>>
>> But if I boot L2 with x-svq=true as shown below, I am unable
>> to ping the host machine.
>>
>> $ ./qemu/build/qemu-system-x86_64 \
>> -nographic \
>> -m 4G \
>> -enable-kvm \
>> -M q35 \
>> -drive file=//root/L2.qcow2,media=disk,if=virtio \
>> -netdev type=vhost-vdpa,vhostdev=/dev/vhost-vdpa-0,x-svq=true,id=vhost-vdpa0 \
>> -device virtio-net-pci,netdev=vhost-vdpa0,disable-legacy=on,disable-modern=off,ctrl_vq=on,ctrl_rx=on,event_idx=off,bus=pcie.0,addr=0x7 \
>> -smp 4 \
>> -cpu host \
>> 2>&1 | tee vm.log
>>
>> In L2:
>>
>> # ip addr add 111.1.1.2/24 dev eth0
>> # ip addr show eth0
>> 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
>>      link/ether 52:54:00:12:34:57 brd ff:ff:ff:ff:ff:ff
>>      altname enp0s7
>>      inet 111.1.1.2/24 scope global eth0
>>         valid_lft forever preferred_lft forever
>>      inet6 fe80::9877:de30:5f17:35f9/64 scope link noprefixroute
>>         valid_lft forever preferred_lft forever
>>
>> # ip route
>> 111.1.1.0/24 dev eth0 proto kernel scope link src 111.1.1.2
>>
>> # ping 111.1.1.1 -w10
>> PING 111.1.1.1 (111.1.1.1) 56(84) bytes of data.
>>  From 111.1.1.2 icmp_seq=1 Destination Host Unreachable
>> ping: sendmsg: No route to host
>>  From 111.1.1.2 icmp_seq=2 Destination Host Unreachable
>>  From 111.1.1.2 icmp_seq=3 Destination Host Unreachable
>>
>> --- 111.1.1.1 ping statistics ---
>> 3 packets transmitted, 0 received, +3 errors, 100% packet loss, time 2076ms
>> pipe 3
>>
>> The other issue is related to booting L2 with "x-svq=true"
>> and "packed=on".
>>
>> In L1:
>>
>> $ ./qemu/build/qemu-system-x86_64 \
>> -nographic \
>> -m 4G \
>> -enable-kvm \
>> -M q35 \
>> -drive file=//root/L2.qcow2,media=disk,if=virtio \
>> -netdev type=vhost-vdpa,vhostdev=/dev/vhost-vdpa-0,id=vhost-vdpa0,x-svq=true \
>> -device virtio-net-pci,netdev=vhost-vdpa0,disable-legacy=on,disable-modern=off,guest_uso4=off,guest_uso6=off,host_uso=off,guest_announce=off,ctrl_vq=on,ctrl_rx=on,event_idx=off,packed=on,bus=pcie.0,addr=0x7 \
>> -smp 4 \
>> -cpu host \
>> 2>&1 | tee vm.log
>>
>> The kernel throws "virtio_net virtio1: output.0:id 0 is not
>> a head!" [4].
>>
> 
> So this series implements the descriptor forwarding from the guest to
> the device in packed vq. We also need to forward the descriptors from
> the device to the guest. The device writes them in the SVQ ring.
> 
> The functions responsible for that in QEMU are
> hw/virtio/vhost-shadow-virtqueue.c:vhost_svq_flush, which is called by
> the device when used descriptors are written to the SVQ, which calls
> hw/virtio/vhost-shadow-virtqueue.c:vhost_svq_get_buf. We need to do
> modifications similar to vhost_svq_add: Make them conditional if we're
> in split or packed vq, and "copy" the code from Linux's
> drivers/virtio/virtio_ring.c:virtqueue_get_buf.
> 
> After these modifications you should be able to ping and forward
> traffic. As always, It is totally ok if it needs more than one
> iteration, and feel free to ask any question you have :).
> 

I misunderstood this part. While working on extending
hw/virtio/vhost-shadow-virtqueue.c:vhost_svq_get_buf() [1]
for packed vqs, I realized that this function and
vhost_svq_flush() already support split vqs. However, I am
unable to ping L0 when booting L2 with "x-svq=true" and
"packed=off" or when the "packed" option is not specified
in QEMU's command line.

I tried debugging these functions for split vqs after running
the following QEMU commands while following the blog [2].

Booting L1:

$ sudo ./qemu/build/qemu-system-x86_64 \
-enable-kvm \
-drive file=//home/valdaarhun/valdaarhun/qcow2_img/L1.qcow2,media=disk,if=virtio \
-net nic,model=virtio \
-net user,hostfwd=tcp::2222-:22 \
-device intel-iommu,snoop-control=on \
-device virtio-net-pci,netdev=net0,disable-legacy=on,disable-modern=off,iommu_platform=on,guest_uso4=off,guest_uso6=off,host_uso=off,guest_announce=off,ctrl_vq=on,ctrl_rx=on,packed=off,event_idx=off,bus=pcie.0,addr=0x4 \
-netdev tap,id=net0,script=no,downscript=no \
-nographic \
-m 8G \
-smp 4 \
-M q35 \
-cpu host 2>&1 | tee vm.log

Booting L2:

# ./qemu/build/qemu-system-x86_64 \
-nographic \
-m 4G \
-enable-kvm \
-M q35 \
-drive file=//root/L2.qcow2,media=disk,if=virtio \
-netdev type=vhost-vdpa,vhostdev=/dev/vhost-vdpa-0,x-svq=true,id=vhost-vdpa0 \
-device virtio-net-pci,netdev=vhost-vdpa0,disable-legacy=on,disable-modern=off,ctrl_vq=on,ctrl_rx=on,event_idx=off,bus=pcie.0,addr=0x7 \
-smp 4 \
-cpu host \
2>&1 | tee vm.log

I printed out the contents of VirtQueueElement returned
by vhost_svq_get_buf() in vhost_svq_flush() [3].
I noticed that "len" which is set by "vhost_svq_get_buf"
is always set to 0 while VirtQueueElement.len is non-zero.
I haven't understood the difference between these two "len"s.

The "len" that is set to 0 is used in "virtqueue_fill()" in
virtio.c [4]. Could this point to why I am not able to ping
L0 from L2?

Thanks,
Sahil

[1] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/vhost-shadow-virtqueue.c#L418
[2] https://www.redhat.com/en/blog/hands-vdpa-what-do-you-do-when-you-aint-got-hardware-part-2
[3] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/vhost-shadow-virtqueue.c#L488
[4] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/vhost-shadow-virtqueue.c#L501



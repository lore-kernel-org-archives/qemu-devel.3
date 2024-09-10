Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0531ECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 06:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snua2-0004Qk-8q; Tue, 10 Sep 2024 02:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1snuZx-0004GO-Du
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 02:42:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1snuZv-00069W-0V
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 02:42:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725950532;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M4qYcpdlEoqoKVVCpDmHiuas93mcN63TDG0FJ09qrZo=;
 b=Sv+2lrYWyVsSN8SBcE240VC0GphQW0lOa7X0w6IjGnBjTqA7zk3Qq0N5vl2AHcEGKvrTjJ
 7NNx6eV1L4ulWdPBDxLoPuTb0ekBWR/rTfMiSt8AUmP8lcTqPNqnJcrxDpOE3SJyHVWY7P
 MvPJzLINat5hZq9x35qSxa4AnrBlAsc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-aM7SVAiJMwqKZOaMcAYtVA-1; Tue, 10 Sep 2024 02:42:11 -0400
X-MC-Unique: aM7SVAiJMwqKZOaMcAYtVA-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7a9a74d39b5so703933385a.2
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 23:42:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725950530; x=1726555330;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M4qYcpdlEoqoKVVCpDmHiuas93mcN63TDG0FJ09qrZo=;
 b=eHTKsnki9WGta08T8jUWwOaAAM3saz6hi2my6ciUreb+eD/3AY+oRzMpCX3MV/4Y9g
 169i9Qt3IxjF+R7ZBESrMj88Ea/TrHVZIsZUs6j6HTvb3XF8SDCaP8PAig1XIxpIiscr
 oI04mIoStAsxfD1RtL7fGuVk0i9H4OLKnl/p+SbQYoa5ych+qpJYdHHijKyAEyhu6CRB
 8ZxLlRPcUjSxfkR1H4s0o3GnbQ4PcC39FHdZvHNNLzH5V8XY8uZ4nI3pqcR3ZM4Y/phO
 MU80MJBuL8zxGHyipiRzP4wqhgx6q4hr7qrUffYKkG4nzpnZZdaLE4Uthyk7qwfD+QvL
 ay7A==
X-Gm-Message-State: AOJu0YxZMZmCkN6iVIFpjY+Cl+d9KzJEO4opyB5HPAFoRDTLP6rqbZEU
 3VRzaOyWIe00p4i4uFBIe0e5EGnNyW7PFfvLnsd5uyvzPzEdQ9SRLaBauCzXSJX+3IWabdbNWRf
 rxA/yvPj905hQKTqUWRS9QAPeK+ZJuRlSpfF2ToreBsI6LsZQhd/l
X-Received: by 2002:a05:620a:488:b0:7a9:be53:fe3b with SMTP id
 af79cd13be357-7a9be53fe7fmr404916785a.14.1725950530471; 
 Mon, 09 Sep 2024 23:42:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeNet8sTgFgJNH3CmMwI7Ck7zdT0PAQo96AXky9bwpAg060M5ygddhNJNHUfHuf4Cyq++f8Q==
X-Received: by 2002:a05:620a:488:b0:7a9:be53:fe3b with SMTP id
 af79cd13be357-7a9be53fe7fmr404914985a.14.1725950530053; 
 Mon, 09 Sep 2024 23:42:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a9a7946b0csm283674485a.23.2024.09.09.23.42.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 23:42:09 -0700 (PDT)
Message-ID: <146a6f6f-a1bd-44aa-a86e-985484eae65c@redhat.com>
Date: Tue, 10 Sep 2024 08:42:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug Report] smmuv3 event 0x10 report when running virtio-blk-pci
Content-Language: en-US
To: Zhou Wang <wangzhou1@hisilicon.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Mostafa Saleh <smostafa@google.com>
References: <447984db-8c52-c911-d7bd-6616edaaefa5@hisilicon.com>
 <CAFEAcA-qBKn=42SYwU1X_7QrwWZYA1G1Hbf-iUP4GOFu0LwLzw@mail.gmail.com>
 <cbd29bc4-c5ab-22d7-8a3e-fd7646f16fd5@hisilicon.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <cbd29bc4-c5ab-22d7-8a3e-fd7646f16fd5@hisilicon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Zhou,
On 9/10/24 03:24, Zhou Wang via wrote:
> On 2024/9/9 22:31, Peter Maydell wrote:
>> On Mon, 9 Sept 2024 at 15:22, Zhou Wang via <qemu-devel@nongnu.org> wrote:
>>> Hi All,
>>>
>>> When I tested mainline qemu(commit 7b87a25f49), it reports smmuv3 event 0x10
>>> during kernel booting up.
>> Does it still do this if you either:
>>  (1) use the v9.1.0 release (commit fd1952d814da)
>>  (2) use "-machine virt-9.1" instead of "-machine virt"
> I tested above two cases, the problem is still there.
Thank you for reporting. I am able to reproduce and effectively the
maxcpus kernel option is triggering the issue. It works without. I will
come back to you asap.

Eric
>
>> ?
>>
>> My suspicion is that this will have started happening now that
>> we expose an SMMU with two-stage translation support to the guest
>> in the "virt" machine type (which we do not if you either
>> use virt-9.1 or in the v9.1.0 release).
>>
>> I've cc'd Eric (smmuv3 maintainer) and Mostafa (author of
>> the two-stage support).
>>
>>> qemu command which I use is as below:
>>>
>>> qemu-system-aarch64 -machine virt,kernel_irqchip=on,gic-version=3,iommu=smmuv3 \
>>> -kernel Image -initrd minifs.cpio.gz \
>>> -enable-kvm -net none -nographic -m 3G -smp 6 -cpu host \
>>> -append 'rdinit=init console=ttyAMA0 ealycon=pl0ll,0x90000000 maxcpus=3' \
>>> -device pcie-root-port,port=0x8,chassis=0,id=pci.0,bus=pcie.0,multifunction=on,addr=0x2 \
>>> -device pcie-root-port,port=0x9,chassis=1,id=pci.1,bus=pcie.0,addr=0x2.0x1 \
>>> -device virtio-blk-pci,drive=drive0,id=virtblk0,num-queues=8,packed=on,bus=pci.1 \
>>> -drive file=/home/boot.img,if=none,id=drive0,format=raw
>>>
>>> smmuv3 event 0x10 log:
>>> [...]
>>> [    1.962656] virtio-pci 0000:02:00.0: Adding to iommu group 0
>>> [    1.963150] virtio-pci 0000:02:00.0: enabling device (0000 -> 0002)
>>> [    1.964707] virtio_blk virtio0: 6/0/0 default/read/poll queues
>>> [    1.965759] virtio_blk virtio0: [vda] 2097152 512-byte logical blocks (1.07 GB/1.00 GiB)
>>> [    1.966934] arm-smmu-v3 9050000.smmuv3: event 0x10 received:
>>> [    1.967442] input: gpio-keys as /devices/platform/gpio-keys/input/input0
>>> [    1.967478] arm-smmu-v3 9050000.smmuv3:      0x0000020000000010
>>> [    1.968381] clk: Disabling unused clocks
>>> [    1.968677] arm-smmu-v3 9050000.smmuv3:      0x0000020000000000
>>> [    1.968990] PM: genpd: Disabling unused power domains
>>> [    1.969424] arm-smmu-v3 9050000.smmuv3:      0x0000000000000000
>>> [    1.969814] ALSA device list:
>>> [    1.970240] arm-smmu-v3 9050000.smmuv3:      0x0000000000000000
>>> [    1.970471]   No soundcards found.
>>> [    1.970902] arm-smmu-v3 9050000.smmuv3: event 0x10 received:
>>> [    1.971600] arm-smmu-v3 9050000.smmuv3:      0x0000020000000010
>>> [    1.971601] arm-smmu-v3 9050000.smmuv3:      0x0000020000000000
>>> [    1.971601] arm-smmu-v3 9050000.smmuv3:      0x0000000000000000
>>> [    1.971602] arm-smmu-v3 9050000.smmuv3:      0x0000000000000000
>>> [    1.971606] arm-smmu-v3 9050000.smmuv3: event 0x10 received:
>>> [    1.971607] arm-smmu-v3 9050000.smmuv3:      0x0000020000000010
>>> [    1.974202] arm-smmu-v3 9050000.smmuv3:      0x0000020000000000
>>> [    1.974634] arm-smmu-v3 9050000.smmuv3:      0x0000000000000000
>>> [    1.975005] Freeing unused kernel memory: 10112K
>>> [    1.975062] arm-smmu-v3 9050000.smmuv3:      0x0000000000000000
>>> [    1.975442] Run init as init process
>>>
>>> Another information is that if "maxcpus=3" is removed from the kernel command line,
>>> it will be OK.
>>>
>>> I am not sure if there is a bug about vsmmu. It will be very appreciated if anyone
>>> know this issue or can take a look at it.
>> thanks
>> -- PMM
>> .



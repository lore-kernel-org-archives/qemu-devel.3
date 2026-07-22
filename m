Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3346FC44512
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 07:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmR9d-0002oa-C6; Wed, 22 Jul 2026 03:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wmR9b-0002o4-Az
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 03:14:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wmR9U-0005Zo-FE
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 03:14:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784704439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7rw6w9ogoPhqjNbcM3z322xDGoJiejIRBqWFWI2tGvQ=;
 b=GMD8gTgPTca4gly1FG9IbBLy9CTZHAiLnnC1Z4aWFMOGSJWI/LelGTEeg/EwAwo+/A25lV
 mS3DP/Zckko7r5189ayIQjSH4efeaeOtKzR4dJqmHrrP6dH1QeU+vc+YENAn+kCG1uGeSe
 nPUppMSAF/aaQZKQohPVPubkDUBmRDY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-Dseg2FkEN_eqvi-JQVxrrQ-1; Wed, 22 Jul 2026 03:13:57 -0400
X-MC-Unique: Dseg2FkEN_eqvi-JQVxrrQ-1
X-Mimecast-MFC-AGG-ID: Dseg2FkEN_eqvi-JQVxrrQ_1784704437
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cec4226c70so198287955ad.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 00:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784704437; x=1785309237; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7rw6w9ogoPhqjNbcM3z322xDGoJiejIRBqWFWI2tGvQ=;
 b=Ez4jtB8DgzFLPsmCQtN9TUwNFvEQ0JuVifJxPjD3zGUo7+jnm0Z7TdrTpTCTCe3sWD
 HGEdg7d0Gjyy89WYCzhkcdynZSdSzx6hGGebrSR0d1SoXtgHPsmOEygo7HDcGD9VPh/l
 HhEtoXntcD7zAMtEZCXZrk/uqKTBoH+gmuNA9HM3tBkDT3orZBYQJrDCGGgfe0Q8HQAY
 /gl8S0f82PD1C1um/AE2iqZoO8hSnhllht+emO8AgHO31hd4mKhqsrbPpAfgO0dgsZrA
 RC8Goj23vbMT0YPdzKC6hmYGZnC3exGqjsblMlJNRxSJlUB4Ib9BBOHOER93HVB4X0sl
 t7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784704437; x=1785309237;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7rw6w9ogoPhqjNbcM3z322xDGoJiejIRBqWFWI2tGvQ=;
 b=PbRl3pv0kGEKT0Pdg1ZIvFix9J5G37I9LdmVhFxyaCfXkkVyirUzdMSAvlieGCWnpo
 702QfWTXC9dNpMNhdhxPt/RXhhDDu/gzjOVqC03sIbaPbuytu/SQ1cI8IJZkw9ebOxmz
 iq8jmsqHmBVLKzS2AyWa9M/sZmTd+toG52TTBc9jWQJNmPdaSGV2gvIZYMVy0Del6Gw4
 ShMapKNNM57hK8O73iLTMJsPGTqJlhlXGQKt7zJFMj0gq9dno7PvxNpNRegp8yRas8j6
 ZjA4wnjqfAIlS3k6mavgVYGdzomM2owKKUDKN37djz6sEc+mjxedF+oHEYyUAGiqJGrf
 kqTA==
X-Gm-Message-State: AOJu0YxOFhJEt83/Tt2tNX8v+5cq+VyIt85S/NZTF8tGg9j6EwG8naHo
 8SUxXzmqKD4EyfVnd9OZvnn7s0NVUFMJVu0ghRdk0rzxieBOSbjDDqK3pOZN5wfrzT0SE3gzI6O
 P8Bb4TLnD1zjy3hmR5WIE3hcKzIycEK2Kl0Xnv0/vWbeWr5lTDmyn/+t5
X-Gm-Gg: AR+sD13kijka8S0XvicEpUYtkog4Qd+0enQyoxumk8GZAyF4Y75tAHr2QNl3soAw2B9
 SqluqgLKiKX4DzV7/vuDFT0Tt9fenuQ15pkQj0BowL2bxbk9uBeyzxsZQFaw4VTUI0hWy6zsk/K
 wwCtVKGgmoSDSn9oideBO6mHeMpOmLz3Od4CHgR1SSqzOkyp6jjJKq33gSe9DDafhTv9ggLmIpm
 HjTlhjJkqNswzb37TKkXpM1nPN9zURKtsdZMEBuQsJkguYKG14g61kGhVnkjZxPbWkeoX6ARxYx
 K6VgD/539MEc12egxFD4HVQsSAO4cuwLNS8ifxQHUDZTV5ii9Zh2lMksoT+pDsvaU3gu0CQiLCP
 uE1kmZzva2I3GenCW8OSWQarI4+kczzQ9YAE+xPwlr8g=
X-Received: by 2002:a17:903:2986:b0:2ce:b7b7:30e3 with SMTP id
 d9443c01a7336-2cf348575cbmr251670115ad.17.1784704436644; 
 Wed, 22 Jul 2026 00:13:56 -0700 (PDT)
X-Received: by 2002:a17:903:2986:b0:2ce:b7b7:30e3 with SMTP id
 d9443c01a7336-2cf348575cbmr251669305ad.17.1784704435251; 
 Wed, 22 Jul 2026 00:13:55 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf8f3b7c9dsm9207365ad.83.2026.07.22.00.13.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2026 00:13:54 -0700 (PDT)
Message-ID: <97a0e92e-ddc7-4eb3-9fcc-7b05bea8b220@redhat.com>
Date: Wed, 22 Jul 2026 17:13:46 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 00/25] Add Realm support to QEMU-VMM
To: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
 kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com, jpb@kernel.org,
 lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=gshan@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=unavailable autolearn_force=no
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

Hi Mathieu,

On 7/8/26 8:42 AM, Mathieu Poirier wrote:
> This patchset provides minimal functionality to start a Realm VM
> from an Arm RME cabable host using the following command line:
> 
> qemu-system-aarch64 -M confidential-guest-support=rme0 -object rme-guest,id=rme0 \
>          -cpu host -M virt -enable-kvm -M gic-version=3,its=on -nodefaults ..
> 
> This set is a refactoring of Jean-Philippe Brucker's initial work dating from
> a while back.  It is compatible with Steven Price's v14 revision [1] of his work
> adding CCA support to KVM.
> 
> The RME capable host it was tested on is the QEMU SBSA machine.  For convenicence
> a repository is hosted here [2], along with the TF-A [3], RMM [4] and Linux
> kernel [5] for the SBSA machine (all compatible with Steven's v14 patchset).
> 
> Device Assignment is not included.
> 
>  From hereon I will keep this set up to date with new releases from Steven.
> 
> Thanks,
> Mathieu
> 
> [1]. https://lore.kernel.org/kvm/20260513131757.116630-1-steven.price@arm.com/T/#m06dd14216aaf76acab65b0a76fb84653141ea64f
> [2]. https://gitlab.com/Linaro/cca-public/qemu/-/tree/upstream-v1?ref_type=heads
> [3]. https://gitlab.com/Linaro/cca-public/tf-a/trusted-firmware-a/-/tree/cca/v13?ref_type=heads
> [4]. https://gitlab.com/Linaro/cca-public/rmm/-/tree/cca/v14?ref_type=heads
> [5]. https://gitlab.com/Linaro/cca-public/linux/-/tree/cca/v14?ref_type=heads
> 
[...]

Gave this series + (v14) series a try and found the following issues so far. Note
some of the HMP commands like those relevant to migration have been skipped since
we know the migration isn't supported. I list the issues for record and we eventually
need to figure them out one by one.

(1) qemu is terminiated on exeute qmp command 'dump-guest-memory'

(qemu) dump-guest-memory -p "/tmp/mem" 0x40000000 0x10000000
**
ERROR:../system/memory_mapping.c:215:guest_phys_block_add_section: assertion failed: (predecessor->target_end <= target_start)
Bail out! ERROR:../system/memory_mapping.c:215:guest_phys_block_add_section: assertion failed: (predecessor->target_end <= target_start)
Aborted

(2) qemu emulation can't be stopped and resumed

(qemu) stop
(qemu) cont
Failed to set KVM_REG_ARM_TIMER_CNT

(3) qemu is terminiated on qmp command 'system_reset'

(qemu) system_reset
cpus are not resettable, terminating

(4) Incompatible to virtio-iommu-pci. The realm guest doesn't boot up with
     a virtio-iommu-pci device

host$ qemu-system-aarch64 -enable-kvm -object rme-guest,id=rme0                \
-machine virt,gic-version=3,confidential-guest-support=rme0                    \
-m 2G -cpu host -smp maxcpus=4,cpus=4,sockets=1,clusters=1,cores=2,threads=2   \
-object memory-backend-ram,id=mem0,size=2G,share=yes                           \
-numa node,nodeid=0,cpus=0-3,memdev=mem0                                       \
-serial mon:stdio -monitor none -nographic -nodefaults                         \
-bios /mnt/edk2/Build/ArmVirtQemu-AARCH64/RELEASE_GCC5/FV/QEMU_EFI.fd          \
-kernel /mnt/linux/arch/arm64/boot/Image                                       \
-initrd /mnt/buildroot/output/images/rootfs.cpio.xz                            \
-append earlycon=pl011,mmio,0x10009000000                                      \
-device pcie-root-port,bus=pcie.0,chassis=1,id=pcie.1                          \
-device pcie-root-port,bus=pcie.0,chassis=2,id=pcie.2                          \
-device virtio-iommu-pci,bus=pcie.0                                            \
-netdev tap,id=tap1,vhost=on,script=/etc/qemu-ifup,downscript=/etc/qemu-ifdown \
-device virtio-net-pci,bus=pcie.2,netdev=tap1,mac=b8:3f:d2:1d:3e:c0
         :
UEFI firmware (version  built at 00:09:11 on Jun 30 2026)
         :
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x000f0510]
[    0.000000] Linux version 7.2.0-rc4-gavin-g1590cf032971 (gshan@nvidia-grace-hopper-01.khw.eng.bos2.dc.redhat.com) (gcc (GCC) 14.3.1 20251022 (Red Hat 14.3.1-4), GNU ld version 2.41-65.el10) #46 SMP PREEMPT Mon Jul 20 06:56:20 EDT 2026
[    0.000000] KASLR enabled
[    0.000000] earlycon: pl11 at MMIO 0x0000010009000000 (options '')
[    0.000000] printk: legacy bootconsole [pl11] enabled
[    0.000000] efi: EFI v2.7 by EDK II
[    0.000000] efi: SMBIOS 3.0=0xbff60000 ACPI 2.0=0xbdee2018 INITRD=0xbdd94f18 RNG=0xbdee2a18 MEMRESERVE=0xbdd94f98
         :
[   18.374507] virtio-pci 0000:00:03.0: enabling device (0000 -> 0002)
[   18.594890] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[   18.651840] Serial: AMBA driver
[   19.669576] software IO TLB: Memory encryption is active and system is using DMA bounce buffers
[   35.021315] Freeing initrd memory: 5772K
[   40.984997] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[   41.076752] rcu: 	3-...0: (77 ticks this GP) idle=aed4/1/0x4000000000000000 softirq=83/97 fqs=2365
[   41.210687] rcu: 	(detected by 2, t=5307 jiffies, g=-1079, q=352 ncpus=4)
[   41.311646] Sending NMI from CPU 2 to CPUs 3:
[   51.631564] After 10 seconds, these CPUS still haven't responded to the NMI: 3
[   51.739789] rcu: rcu_preempt kthread timer wakeup didn't happen for 2685 jiffies! g-1079 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
[   51.910690] rcu: 	Possible timer handling issue on cpu=2 timer-softirq=2168
[   52.014654] rcu: rcu_preempt kthread starved for 2756 jiffies! g-1079 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=2
[   52.169468] rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
[   52.304725] rcu: RCU grace-period kthread stack dump:
[   52.379337] task:rcu_preempt     state:I stack:0     pid:15    tgid:15    ppid:2      task_flags:0x208040 flags:0x00000010
[   52.542813] Call trace:
[   52.578516]  __switch_to+0xfc/0x248 (T)
[   52.636293]  __schedule+0x3a4/0xe68
[   52.686511]  schedule+0x3c/0xe8
[   52.731765]  schedule_timeout+0x80/0x120
[   52.788489]  rcu_gp_fqs_loop+0x110/0x440
[   52.846921]  rcu_gp_kthread+0x10c/0x120
[   52.906472]  kthread+0x138/0x150
[   52.955082]  ret_from_fork+0x10/0x20

(5) As reported previously, 'reboot' on the realm guest causes the termination of qemu process.

root@guest:~# reboot
     :
The system is going down NOW!
Sent SIGTERM to all processes
Sent SIGKILL to all processes
Requesting system reboot
[   61.874435] reboot: Restarting system
qemu-system-aarch64: cpus are not resettable, terminating
qemu-system-aarch64: cpus are not resettable, terminating
qemu-system-aarch64: cpus are not resettable, terminating
qemu-system-aarch64: cpus are not resettable, terminating

Thanks,
Gavin



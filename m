Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A090C982DE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 04:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8VIH-0002JR-F6; Mon, 21 Sep 2026 00:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1x8VHa-0002Hc-1L
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 00:05:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1x8VHX-0002RG-PD
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 00:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789963529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nSnN8VOGhRRV+y42MQat+4tLa8LqeXPrcAdJgHeq7Ts=;
 b=OcWv0T28hEE6WJtkII1g/ZTL5/twiw6XrMfzAfoMccqrDy5Z8ZeuDNzqDS+6HlqoZpnd0z
 tWR9m864TLiuMftqo9uULUpajTJ3QKEA/rRS+w434FhlUfsjltxbZhoR6nx9H5uZNDIGi8
 VvyW/z/f/qDxO4TId6BcCJ6djrpwOxE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-XJlc0SVEOFyBBRE2u48gbA-1; Mon, 21 Sep 2026 00:05:28 -0400
X-MC-Unique: XJlc0SVEOFyBBRE2u48gbA-1
X-Mimecast-MFC-AGG-ID: XJlc0SVEOFyBBRE2u48gbA_1789963527
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38ea32e57e2so5154246a91.1
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2026 21:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789963527; x=1790568327; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nSnN8VOGhRRV+y42MQat+4tLa8LqeXPrcAdJgHeq7Ts=;
 b=JJNwdGhDCLtcPOkWxB+saQ8/fnDOPbd8nmSReXXrXEcaqWuwLolgOy6KIhWSiPLE3Q
 JEekNGTAn7oeABXQQOX36kigVr+scUWieCkVNjFK5Nua/r7Wf/+5S/y3n1gdbBzFjeOU
 rpdUOr7Atu07IU8O1buDz0OE+MWkBTWU11iv4WMCvqCL+4WFiB2yzXiUKmIDYWJQATsE
 ztmPdFLZT9XatyluGOBH0NKZAIZC/hBMGR4tWGPFaEYW4GJaXAWk+Bh5NtINzV0Hmirf
 2oHMfL5kLfBvGJREAlPICsbMrY1Mr0V9zEnmVkGOOFsEaeiWTMrSk/CYmXElkGmXaXv7
 KL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789963527; x=1790568327;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nSnN8VOGhRRV+y42MQat+4tLa8LqeXPrcAdJgHeq7Ts=;
 b=DGI5g685pV/QOO/oNFJspD62Z3UBPcxh/Dw8gdq3ViAfJqeDD/tlu0uX8gpE3kPHiD
 eWX7ApY/XZgvA4Ahzd98q4vtfyYPAjdQhODXGNLiI4JiTZFAJ7ijg+Bo9NUA6Q7AcOf7
 0zwCPS4juXQsdNjLn7FVf2IOH7HYviLGjUTq9pElj2EUSBYTjH1cOdRvtkVNLCQtn250
 KwJCquRcL4Ddz8+9cpi/fbzd5cFi9yXoY9cCXxKc0ZMpr6HPpCHtV7tcJPlKRL6RgFZR
 obdIBHL822omPmXCI+lKRcXTNfJCfF0w9iR8MPOxMPaNftnLkxbj3UO4R+2hnajrej9y
 syQw==
X-Gm-Message-State: AFuF++mDwAuQn6XaqB21PTOg2/K2StAH3HmPT0MxlRK3tA2TAWeVQMIx
 IcNEXSnEHAop+VqdjZQL2rFslYDXtxfVz8lWuwmwg/+a4WXdK5VFzXXSAZLBBv+jh7nGTX47q1G
 cQROwpNQ72f7JOryBfXha7gCZRgwSFqPGe2Oe+C3mE2Mk8u0tj5RUbmyt
X-Gm-Gg: AYBFou1K+5ckRy8uUvlKRJiGsvbRC+gH83ObZdqvnx/5qy2LkR6/mJQHe8RQXSX8+Sc
 sbz+d91wVljG3cYvP7xcN8b1vk1kA8/fN7DCKGV0yaE+TfXj0D+dj7L2TBL0AR+NYARaJM2ekZO
 h+xT6k5QCLGuEqkWJgyc//NiXkt5uTWxYo3GflLCKOkvCIQ6eD1xnDcOmDyn9JUoSEoyi0LtSB/
 7ESsmBc3xSS8mKB97Dvy1+cwLxO5pzxFC85Uk1HIgVT0RBhHv3TbvWGzhqEpA4zrSi1Xf95wLGr
 BExun8PXd6PXhQJ3FrI0K0RTj8n9o8bExwp2Te0ykzOGLMQVRIy4v4Rw9yKP/MCRLNBoiTqO1vP
 Wp6iiBfz+R5OnVXUbjwtB0NsPKr9wexcQj4gRCVyyiw==
X-Received: by 2002:a17:90a:e7c6:b0:39e:6a81:5a90 with SMTP id
 98e67ed59e1d1-39e6a815e0amr8901155a91.36.1789963526816; 
 Sun, 20 Sep 2026 21:05:26 -0700 (PDT)
X-Received: by 2002:a17:90a:e7c6:b0:39e:6a81:5a90 with SMTP id
 98e67ed59e1d1-39e6a815e0amr8901122a91.36.1789963526274; 
 Sun, 20 Sep 2026 21:05:26 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e6ca50118sm12051508a91.4.2026.09.20.21.05.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Sep 2026 21:05:24 -0700 (PDT)
Message-ID: <7dea93a6-b119-4882-9c56-557a372b646a@redhat.com>
Date: Mon, 21 Sep 2026 14:05:19 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 00/24] Add Realm support to QEMU-VMM
To: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
 kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com,
 lorenzo.pieralisi@linaro.org, enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Hi Mathieu,

On 9/4/26 5:35 AM, Mathieu Poirier wrote:
> This patchset provides minimal functionality to start a Realm VM
> from an Arm RME capable host using the following command line:
> 
> qemu-system-aarch64 \
>   -M confidential-guest-support=rme0,memory-backend=ram0 \
>   -object rme-guest,id=rme0,convert-in-place=on \
>   -object memory-backend-guest-memfd,id=ram0,size=1G,share=on \
>   -cpu host -M virt -enable-kvm -M gic-version=3,its=on -nodefaults ..
> 
> It is a refactoring of Jean-Philippe Brucker's initial work dating from a while
> back.  It is compatible with Steven Price's v16 revision [1] of his work adding
> CCA support to KVM.
> 
> This revision is based on Michael Roth's work on guest memfd in-place memory
> conversion [2], rebased to QEMU master.  I left out the AMD specific changes
> from Michael's work because I can't test the result.  Other than the
> modications to the linux headers, this series is identical to V3.
> 
> It was tested on the QEMU SBSA machine.  For convenience, a repository is hosted
> here [3], along with the TF-A [4] and RMM [5] for the SBSA machine (compatible
> with Steven's v16 patchset).  The Repository for the kernel [6] is also
> available.  Note that for the latter, defines for
> KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES and KVM_CAP_ARM_RMI have been modified to
> follow QEMU master.
> 
> Instructions to compile and run the entire stack can be found here [7].
> 
> Device Assignment is not included.
> 
> Thanks,
> Mathieu
> 
> [1]. https://lore.kernel.org/kvm/20260803134403.80630-1-steven.price@arm.com/
> [2]. https://lore.kernel.org/kvm/20260528000416.8161-1-michael.roth@amd.com/
> [3]. https://gitlab.com/Linaro/cca-public/qemu/-/tree/upstream-v4?ref_type=heads
> [4]. https://gitlab.com/Linaro/cca-public/tf-a/trusted-firmware-a/-/tree/cca/v13?ref_type=heads
> [5]. https://gitlab.com/Linaro/cca-public/rmm/-/tree/cca/v16?ref_type=heads
> [6]. https://gitlab.com/Linaro/cca-public/linux/-/tree/upstream-v4?ref_type=heads
> [7]. https://gitlab.com/Linaro/cca-public/build-instructions
> 

Give this series and (v19) arm/cca host series [1] a try, and found the following
issues. I'm sharing the found issues that I need take chance to look at them
closely in future.

[1] https://git.gitlab.arm.com/linux-arm/linux-cca.git  (branch: cca/cca-host/kvm-v19/integration)

Note that the host is emulated using qemu (TCG mode) via 'virt' platform, using
the following command lines

laptop$ /home/gshan/sandbox/cca/host/qemu/build/qemu-system-aarch64                 \
         -M virt,virtualization=on,secure=on,gic-version=3,acpi=off                  \
         -cpu max,x-rme=on -m 4G -smp 8                                              \
         -serial mon:stdio -monitor none -nographic -nodefaults                      \
         -bios /home/gshan/sandbox/cca/host/tf-a/flash.bin                           \
         -kernel /home/gshan/sandbox/cca/host/linux/arch/arm64/boot/Image            \
         -initrd /home/gshan/sandbox/cca/host/buildroot/output/images/rootfs.cpio.xz \
         -append kvm-arm.mode=rmm                                                    \
         -device pcie-root-port,bus=pcie.0,chassis=1,id=pcie.1                       \
         -device pcie-root-port,bus=pcie.0,chassis=2,id=pcie.2                       \
         -device pcie-root-port,bus=pcie.0,chassis=3,id=pcie.3                       \
         -device pcie-root-port,bus=pcie.0,chassis=4,id=pcie.4                       \
         -device virtio-9p-device,fsdev=shr0,mount_tag=shr0                          \
         -fsdev local,security_model=none,path=/home/gshan/sandbox/cca/guest,id=shr0 \
         -netdev tap,id=tap1,script=/etc/qemu-ifup,downscript=/etc/qemu-ifdown       \
         -device virtio-net-pci,bus=pcie.2,netdev=tap1,mac=b8:3f:d2:1d:3e:80

The realm VM is started using the following command lines.

host$ qemu-system-aarch64 -enable-kvm -object rme-guest,id=rme0,convert-in-place=on \
       -machine virt,gic-version=3,confidential-guest-support=rme0 -m 2G -cpu host   \
       -smp maxcpus=4,cpus=4,sockets=1,clusters=1,cores=2,threads=2                  \
       -object memory-backend-guest-memfd,id=mem0,size=2G,share=on                   \
       -numa node,nodeid=0,cpus=0-3,memdev=mem0                                      \
       -serial mon:stdio -monitor none -nographic -nodefaults                        \
       -kernel /mnt/linux/arch/arm64/boot/Image                                      \
       -initrd /mnt/buildroot/output/images/rootfs.cpio.xz                           \
       -append earlycon=pl011,mmio,0x10009000000

Found issues
============

(1) qemu is terminiated on qmp command 'dump-guest-memory'

(qemu) dump-guest-memory -p "/tmp/mem" 0x40000000 0x10000000
**
ERROR:../system/memory_mapping.c:215:guest_phys_block_add_section: assertion failed: (predecessor->target_end <= target_start)
Bail out! ERROR:../system/memory_mapping.c:215:guest_phys_block_add_section: assertion failed: (predecessor->target_end <= target_start)

(2) qemu emulation can't be stopped and resumed

(qemu) stop
(qemu) cont
Failed to set KVM_REG_ARM_TIMER_CNT

(3) qemu is terminiated on qmp command 'system_reset'

(qemu) system_reset
cpus are not resettable, terminating

(4) 'reboot' from the guest doesn't work

root@guest:~# reboot
    :
Requesting system reboot
[  123.264893] reboot: Restarting system
qemu-system-aarch64: cpus are not resettable, terminating

(5) Incompatible to virtio-iommu-pci. The realm guest doesn't boot up if a virtio-iommu-pci
     device is specified in the command lines

host$ qemu-system-aarch64 -enable-kvm                                          \
-object rme-guest,id=rme0,convert-in-place=on                                  \
-machine virt,gic-version=3,confidential-guest-support=rme0                    \
-m 2G -cpu host -smp maxcpus=4,cpus=4,sockets=1,clusters=1,cores=2,threads=2   \
-object memory-backend-guest-memfd,id=mem0,size=2G,share=on                    \
-numa node,nodeid=0,cpus=0-3,memdev=mem0                                       \
-serial mon:stdio -monitor none -nographic -nodefaults                         \
-kernel /mnt/linux/arch/arm64/boot/Image                                       \
-initrd /mnt/buildroot/output/images/rootfs.cpio.xz                            \
-append earlycon=pl011,mmio,0x10009000000                                      \
-device pcie-root-port,bus=pcie.0,chassis=1,id=pcie.1                          \
-device pcie-root-port,bus=pcie.0,chassis=2,id=pcie.2                          \
-device virtio-iommu-pci,bus=pcie.0                                            \
-drive file=/mnt/disk.qcow2,if=none,id=drive0                                  \
-device virtio-blk-pci,id=virtblk0,bus=pcie.1,drive=drive0,num-queues=4        \
-netdev tap,id=tap1,vhost=on,script=/etc/qemu-ifup,downscript=/etc/qemu-ifdown \
-device virtio-net-pci,bus=pcie.2,netdev=tap1,mac=b8:3f:d2:1d:3e:c0
      :
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x000f0510]
[    0.000000] Linux version 7.2.0-rc5-gavin-gf5098b6bae76 (gshan@nvidia-grace-hopper-01.khw.eng.bos2.dc.redhat.com) (gcc (GCC) 14.3.1 20251022 (Red Hat 14.3.1-4), GNU ld version 2.41-65.el10) #47 SMP PREEMPT Mon Jul 27 02:29:03 EDT 2026
[    0.000000] KASLR enabled
[    0.000000] Machine model: linux,dummy-virt
[    0.000000] earlycon: pl11 at MMIO 0x0000010009000000 (options '')
[    0.000000] printk: legacy bootconsole [pl11] enabled
[    0.000000] efi: UEFI not found.
[    0.000000] OF: reserved mem: Reserved memory: No reserved-memory node in the DT
[    0.000000] NODE_DATA(0) allocated [mem 0xbfbecb00-0xbfbf09bf]
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.1 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] psci: SMC Calling Convention v1.2
[    0.000000] RME: Using RSI version 1.0
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000040000000-0x00000000bfffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
      :
[    6.664423] Serial: AMBA PL011 UART driver
[    7.151312] 9000000.pl011: ttyAMA0 at MMIO 0x9000000 (irq = 13, base_baud = 0) is a PL011 rev1
[    7.213181] printk: console [ttyAMA0] enabled
[    8.536454] HugeTLB: registered 1.00 Gi
<...The realm guest stops here, no output since then...>

Thanks,
Gavin



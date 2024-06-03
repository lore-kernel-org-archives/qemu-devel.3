Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA3CAC27C4F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 08:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE2yv-0003Ax-7R; Mon, 03 Jun 2024 04:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sE2yu-0003Ap-0U
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 04:23:52 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sE2yr-0007EY-OS
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 04:23:51 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-35dc7d0387cso4188513f8f.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 01:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717403027; x=1718007827; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3HX8JrmOtAhh8WIgP6il8d9RXEl7zoJXJAvY2kVhcmw=;
 b=rlsnGUNNJbMXgsO5SCqfksxgW1T4yRcbA65DN638kU4ADpb+xZ/4/MW4Fd7cm5qhKu
 jIMR+R/RKzDhV3JUjdmeGJKnBxITS50YuivehHR/5aqBojov0arpAPDPtnMsfZVQzXxq
 hR6EbIueazbt3LaKijIy3SuNiGexsNP0fvrp7FsPFN12xjdfitSWlQf+FqSMVoss8m0m
 VLlRAgpqFNLmeymRJSBNfUvzUdFjYWbuCsdrN8lM8eHqktE9KIcXInY5JWQjsuq9EXVS
 aziooEpwLaQGMlh7IQq3/YwGdojjeco3LAD4QiNjWJMDs0RXvG1ZqYA003RKtzyNGWQ6
 HyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717403027; x=1718007827;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3HX8JrmOtAhh8WIgP6il8d9RXEl7zoJXJAvY2kVhcmw=;
 b=gLMsdHD5fQ2tGHZZ0myctFcdosOqSYZVXM2NndqlkypHrDnST9l8+8sYpGqzeJs8P7
 XUOkZLfbyU1upbexkQpZPsqEcuAgoYu9lWhoK2hpThltHYMYqbIh3VA1HhstB2KCBDa6
 5mUqZeq/Z4/QVPh4/M9K4VFdzpuoDqe5FBCuZFzO8R9nn+pRUDCRI4XtTKuwaDSYV28D
 DfFhtzvMeRq0PzdCEFcu2WXn8Y1Fi4qtEj3QOzC3m3BGV4Qb+J476Ynd14Uugo7ziQf6
 1BFsNSuKPy5I5xYKgRmZTNBH30RWEjp3DoXL7mqRIBtBkL417EzBNazlRAeljaaziwKG
 kNDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBnTnuXkzA5+Ej7n5og7DC14CBG/QEJO5ly02ej3lKNVhy02CCyI+bVncahE9379qQkq+MX8+s2gIFTm/caKYvAE2jEHg=
X-Gm-Message-State: AOJu0Yw0NNpDsK4KKsvr49sk9/NixyCoNzNoWJ0LtEsgiRSmczrav7/W
 6s+8WPkj4J3FIy6ET40HfMTBfz1Dwm40oR6MyQQEAAss5RVmSZoiFhdHkdgH+qg=
X-Google-Smtp-Source: AGHT+IELYfmrHxsr32ZZ0m1rTGrwg3YIWfM/5g6rXJzLSE/DBoRXC1XrhucPIInjLjfdRVKAW9atYQ==
X-Received: by 2002:a5d:64ad:0:b0:35d:c988:6bd7 with SMTP id
 ffacd0b85a97d-35e0f281d6fmr9772583f8f.32.1717403027352; 
 Mon, 03 Jun 2024 01:23:47 -0700 (PDT)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04c0e84sm8063840f8f.13.2024.06.03.01.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 01:23:46 -0700 (PDT)
Date: Mon, 3 Jun 2024 09:24:02 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Gavin Shan <gshan@redhat.com>
Cc: Itaru Kitayama <itaru.kitayama@linux.dev>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ard Biesheuvel <ardb@kernel.org>
Subject: Re: Unexpected error in rme_configure_one() at
 ../target/arm/kvm-rme.c:159
Message-ID: <20240603082402.GA25688@myrica>
References: <0C6F517A-5686-4BCE-8D08-1CED02CB470E@linux.dev>
 <4e7aa598-1a5d-47e1-aaa3-78af05947eeb@linaro.org>
 <CB05CAA2-9301-45F6-8AE3-A2E27A160CDF@linux.dev>
 <cbd630d7-01e8-49ba-9c8b-a6514d898ed2@redhat.com>
 <20240531150922.GA83195@myrica>
 <bd1f84bd-e23c-4f4b-bc0b-a2a1b70081f4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd1f84bd-e23c-4f4b-bc0b-a2a1b70081f4@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Gavin,

On Sat, Jun 01, 2024 at 08:14:46PM +1000, Gavin Shan wrote:
> ---> guest edk2
> 
> # git clone https://git.codelinaro.org/linaro/dcap/edk2.git edk2-guest
> # cd edk2-guest; git checkout origin/cca/v2 -b cca/v2
> # git submodule update --init --recursive;  \
>   source edksetup.sh; make -j -C BaseTools; \
>   export GCC5_AARCH64_PREFIX=;              \

Doesn't this needs a cross-compiler, something like "aarch64-linux-gnu-" ?

>   build -b DEBUG -a AARCH64 -t GCC5 -p ArmVirtPkg/ArmVirtQemu.dsc
>    :
>   WriteSections64(): /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore/DEBUG/ArmPlatformPrePeiCore.dll AARCH64 small code model requires identical ELF and PE/COFF section offsets modulo 4 KB.
> cp -p -f /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/OvmfPkg/VirtioFsDxe/VirtioFsDxe/DEBUG/VirtioFsDxe.dll /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/OvmfPkg/VirtioFsDxe/VirtioFsDxe/DEBUG/VirtioFsDxe.debug
> cp -p -f /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/MdeModulePkg/Universal/Disk/PartitionDxe/PartitionDxe/DEBUG/PartitionDxe.debug /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/PartitionDxe.debug
> "gcc" -MMD -MF /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/CryptoPkg/Library/OpensslLib/OpensslLibCrypto/OUTPUT/openssl/crypto/asn1/x_sig.obj.deps @/home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/CryptoPkg/Library/OpensslLib/OpensslLibCrypto/OUTPUT/cc_resp.txt  -c -o /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/CryptoPkg/Library/OpensslLib/OpensslLibCrypto/OUTPUT/openssl/crypto/asn1/x_sig.obj  /home/gavin/sandbox/CCA/edk2-guest/CryptoPkg/Library/OpensslLib/openssl/crypto/asn1/x_sig.c
> "GenFw" -e DXE_CORE -o /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/MdeModulePkg/Core/Dxe/DxeMain/OUTPUT/DxeCore.efi /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/MdeModulePkg/Core/Dxe/DxeMain/DEBUG/DxeCore.dll
> GenSec -s EFI_SECTION_USER_INTERFACE -n ArmCpuDxe -o /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/FV/Ffs/B8D9777E-D72A-451F-9BDB-BAFB52A68415ArmCpuDxe/B8D9777E-D72A-451F-9BDB-BAFB52A68415SEC3.ui
> cp -p -f /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/MdeModulePkg/Universal/DisplayEngineDxe/DisplayEngineDxe/DEBUG/*.map /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/MdeModulePkg/Universal/DisplayEngineDxe/DisplayEngineDxe/OUTPUT
> cp -p -f /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/MdeModulePkg/Universal/Disk/UdfDxe/UdfDxe/OUTPUT/UdfDxe.efi /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/MdeModulePkg/Universal/Disk/UdfDxe/UdfDxe/DEBUG
> GenFw: ERROR 3000: Invalid
>   :
> build.py...
>  : error 7000: Failed to execute command
> 	make tbuild [/home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore]
> 
> 
> build.py...
>  : error F002: Failed to build module
> 	/home/gavin/sandbox/CCA/edk2-guest/ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore.inf [AARCH64, GCC5, DEBUG]
> 
> - Failed -
> Build end time: 05:42:19, Jun.01 2024
> Build total time: 00:00:31
> 
> ---> Use the edk2 image from the latest QEMU source

Unfortunately this can't work at the moment because edk2 needs several
changes in order to run in a Realm

> 
> # cd /home/gavin/sandbox/CCA
> # cp /home/gavin/sandbox/qemu.main/build/pc-bios/edk2-aarch64-code.fd ./
> 
> ---> Start the guest and no output from the console
> 
> host# mount | grep 9p
> shr0 on /mnt/shr0 type 9p (rw,relatime,access=client,trans=virtio)
> host# export SHR_DIR="/mnt/shr0"
> host# qemu-system-aarch64 -accel kvm                              \
>       -machine virt,gic-version=3,confidential-guest-support=rme0 \
>       -cpu host -smp 2 -m 512M                                    \
>       -object 'rme-guest,id=rme0,measurement-algo=sha512'         \
>       -monitor none -serial mon:stdio -nographic                  \
>       -bios /mnt/edk2-aarch64-code.fd                             \
>       -kernel ${SHR_DIR}/linux/arch/arm64/boot/Image              \
>       -initrd ${SHR_DIR}/buildroot/output/images/rootfs.cpio      \
>       -append 'console=ttyAMA0'
>         :
>       <no output from the console>
>         :
>       (QEMU) q
> 
> There are some messages from host's console indicating RMI/RMM servicing
> states when the guest is running at background. After the guest is terminated,
> the host crashes.
> 
> SMC_RMM_RTT_CREATE            102dff000 122c2e000 1e00000 3 > RMI_SUCCESS
> SMC_RMM_RTT_CREATE            102dff000 1234a7000 2000000 3 > RMI_SUCCESS
> SMC_RMM_RTT_CREATE            102dff000 1235bd000 2200000 3 > RMI_SUCCESS
> SMC_RMM_RTT_CREATE            102dff000 12387c000 2400000 3 > RMI_SUCCESS
> SMC_RMM_RTT_CREATE            102dff000 123a5a000 2600000 3 > RMI_SUCCESS
> SMC_RMM_RTT_CREATE            102dff000 12407d000 2800000 3 > RMI_SUCCESS
> SMC_RMM_RTT_CREATE            102dff000 124109000 2a00000 3 > RMI_SUCCESS
> SMC_RMM_RTT_CREATE            102dff000 123e49000 2c00000 3 > RMI_SUCCESS
> SMC_RMM_RTT_CREATE            102dff000 124275000 2e00000 3 > RMI_SUCCESS
> SMC_RMM_RTT_CREATE            102dff000 123138000 3000000 3 > RMI_SUCCESS
> SMC_RMM_RTT_CREATE            102dff000 124d07000 3200000 3 > RMI_SUCCESS
>  :
>  :
> [22768.994481] rcu: INFO: rcu_preempt self-detected stall on CPU

This is a warning rather than a crash. The current KVM patches spend too
much time tearing down guest page tables (SMC calls to RMM) while holding
the mmu lock. Not very nice but harmless.

Thanks,
Jean

> [22769.006861] rcu: 	3-....: (2751 ticks this GP) idle=93ec/1/0x4000000000000000 softirq=114451/115721 fqs=1160
> [22769.020475] rcu: 	(t=5257 jiffies g=531913 q=7 ncpus=8)
> [22769.030547] CPU: 3 PID: 198 Comm: qemu-system-aar Not tainted 6.9.0-rc1-gavin-gfcfc92d6ff07 #1
> [22769.041847] Hardware name: QEMU QEMU Virtual Machine, BIOS unknown 2/2/2022
> [22769.050548] pstate: 60402009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [22769.059382] pc : kvm_realm_unmap_range+0x308/0x32c
> [22769.070275] lr : kvm_realm_unmap_range+0x304/0x32c
> [22769.075893] sp : ffff800080a3b930
> [22769.079929] x29: ffff800080a3b930 x28: 00000000003d7000 x27: 00000000003d6000
> [22769.092990] x26: 00000000c4000152 x25: ffffffffffffffff x24: 0000000000000000
> [22769.101150] x23: 0000010000000000 x22: 00000000c4000155 x21: 0000000102dff000
> [22769.109056] x20: ffff8000801a5e00 x19: 0000000000000000 x18: 0000000000000001
> [22769.117042] x17: 0000000000000000 x16: 000000000000000e x15: 0000000000000000
> [22769.124991] x14: 0000ffff7fa14000 x13: 0000000000000002 x12: 000000000010d594
> [22769.134213] x11: 0000000000000002 x10: 00000000ffffffff x9 : ffffffffffffffff
> [22769.142951] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 00000000c2dff000
> [22769.151413] x5 : 0000000102f56000 x4 : 0000000000000015 x3 : 0000000000000000
> [22769.159932] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
> [22769.169674] Call trace:
> [22769.174026]  kvm_realm_unmap_range+0x308/0x32c
> [22769.181046]  __unmap_stage2_range+0x60/0x7c
> [22769.186396]  kvm_free_stage2_pgd+0xa0/0xd4
> [22769.191766]  kvm_arch_flush_shadow_all+0x1c/0x34
> [22769.197879]  kvm_mmu_notifier_release+0x30/0x84
> [22769.203304]  __mmu_notifier_release+0x7c/0x1f8
> [22769.209340]  exit_mmap+0x264/0x274
> [22769.213992]  __mmput+0x40/0x150
> [22769.218635]  mmput+0x50/0x5c
> [22769.222606]  do_exit+0x288/0x92c
> [22769.226935]  do_group_exit+0x34/0x90
> [22769.231359]  get_signal+0x814/0x820
> [22769.236537]  do_signal+0x90/0x1320
> [22769.241145]  do_notify_resume+0xc8/0x140
> [22769.246458]  el0_svc+0xc8/0xdc
> [22769.250913]  el0t_64_sync_handler+0x13c/0x158
> [22769.256045]  el0t_64_sync+0x190/0x194
> 
> Thanks,
> Gavin
> 
> 
> 
> 


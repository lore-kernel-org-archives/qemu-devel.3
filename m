Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA006E7717F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 03:04:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLD0I-00077D-PN; Tue, 10 Dec 2024 22:03:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1tLD0G-00076Q-AB
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 22:03:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1tLD0D-0007Ig-So
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 22:03:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733886183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R3WwKwVyzFyRQqvvPJsr5YJYe3ifPZ+pd4mOmMmqqdQ=;
 b=WdWKGM83x3UQLzvVYYRrmXR6tb4CX11/Khlz1a4zROVlhippf/1k519Fpj6S6fAqEL+loi
 l2v0LXakGv4j7wMqyPDa7zkoBty7lJaLifDFVCRr3eRaXuA3gzi7S/7YKZwSkx6aojUMUE
 5uHaRzYJBFhVl7+soJhQOcQeN2zdRe8=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-MRSU-K4PMHyr30gU2_gDfw-1; Tue, 10 Dec 2024 22:01:27 -0500
X-MC-Unique: MRSU-K4PMHyr30gU2_gDfw-1
X-Mimecast-MFC-AGG-ID: MRSU-K4PMHyr30gU2_gDfw
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-216717543b7so23456415ad.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 19:01:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733886086; x=1734490886;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R3WwKwVyzFyRQqvvPJsr5YJYe3ifPZ+pd4mOmMmqqdQ=;
 b=TiX+yo7/rViykP5/FLz8G+M1iNIPTAzZ5UBMPnpnm+ysEDVoRTYt9IwDc5Noz4nB9S
 eiXl819k6T5qtKfJKK6KeKQ+cGqnBD5LGvZFZlILrwHfbw5t1Nayz5DXXQejsGh4D2Mj
 Qq8RaCfFf6Y0/CNRR7M/VPGYtqW+dAa6LGdLn6TgOiplhi4WO+T6RsLGWMdAIjVfdAvu
 oCy5Ltlzq/A0/GN7jfsmOwGiwiuORB+pr8JPZZlsOUumufv3plE2bd1ZdEdsjaM1ZT2U
 8CZK7frofzOsALilfWPzQUMDQDTSwfHIMEs9Cnh5x/CQfuV890PNoZZCprQ9NmE77Ojp
 rEkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJjUvT28jYeIq77vkW8EV7PmMvLiZb1f38mM918IHvQR9qoFc9dsdcCEQWmLGYA3KyR2MKc3DOW/20@nongnu.org
X-Gm-Message-State: AOJu0Yzjw8VY6fSUJ4lVm0NmIjItFjDcoPwI+0kDoGb+yti+Q3J/v8oO
 YstjNgPKTCot7uZ9SGrsoTwSmtICwa8vHUslfvbWLKy0QFZwVG7lCySikMD0dCoqxNUFz4+VoIC
 o2Y0gNz+34PJgnsc0uav6cgmHChwx3LTtkcvZZwko0mtBPzeMMNFQ
X-Gm-Gg: ASbGncvchY0bnN0LNWrg6HRUxQe+Axi+DWinWFkK5eiTV0t2DImV5aXN5mkiH68coI/
 I+x+cDzjRHOTHObROH/WFIbMYUjI1elZw792xvJr4vDTdiMgwE38Xr8fCfrRW+Fv65UkkFwYVd8
 FXCdxIlSP2HUrNucMQsvBftTIomuNLHBEyc0VSpogwrn2PKxOxU1s4znZ/zaqCbK3LtXhewVhbI
 QlPcCJ5pFNjuklWsertFChyOGtj3mejUnnZ8n24kG5shz3tS3hZ2A==
X-Received: by 2002:a17:902:e80d:b0:216:5e6e:68cb with SMTP id
 d9443c01a7336-217785357femr19451625ad.16.1733886086381; 
 Tue, 10 Dec 2024 19:01:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHddK/R4O90YaYT5037yaSxQNKQLBr7CgoMw8EBJRIzIBhPCjXgwKQxKYoChGul6nGVtpleeA==
X-Received: by 2002:a17:902:e80d:b0:216:5e6e:68cb with SMTP id
 d9443c01a7336-217785357femr19451265ad.16.1733886085953; 
 Tue, 10 Dec 2024 19:01:25 -0800 (PST)
Received: from [10.72.112.56] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2164619fdb1sm47616865ad.28.2024.12.10.19.01.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2024 19:01:24 -0800 (PST)
Message-ID: <8504f92d-03fe-4a0c-a647-0003d9c8772c@redhat.com>
Date: Wed, 11 Dec 2024 13:01:19 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/26] arm: Run Arm CCA VMs with KVM
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org,
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Gonda <pgonda@google.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20241125195626.856992-2-jean-philippe@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Jean,

On 11/26/24 5:55 AM, Jean-Philippe Brucker wrote:
> This series enables running confidential VMs on Arm CCA. The host KVM
> support is progressing but still under discussion [1], so there is no
> urgency to upstream this series. I'm sending this new version to give a
> status update, and also to discuss remote attestation below.
> 
> Since v2 [2] I addressed comments on the QAPI patches. The support for
> running Linux in a Realm will be in Linux v6.13 [3], so the guest-facing
> interface is now stable. One important change since v2 is the requirement
> to initialize the whole GPA space in RMM before boot, which we do in patch
> 9. The 'earlycon' kernel parameter now requires an unprotected address
> parameter (see Documentation/arch/arm64/arm-cca.rst in Linux v6.13).
> 
> Documentation to try this series out:
> https://linaro.atlassian.net/wiki/spaces/QEMU/pages/29051027459/Building+an+RME+stack+for+QEMU
> 

I followed the instructions, but encountering some issues. First of all, the
recommended TF-RMM (branch: cca/v4) fails to be built. After switching to the
latest upstream TF-RMM, it fails to be initialized.

Note: the combination of the upstream TF-A + upstream TF-RMM + upstream EDK2
worked fine for the 'fvp' emulator.

TF-RMM fails to be built
========================
$ git clone https://git.codelinaro.org/linaro/dcap/rmm.git tf-rmm
$ cd tf-rmm
$ git checkout origin/cca/v4 -b cca/v4
$ git submodule update --init --recursive
$ cmake -DCMAKE_BUILD_TYPE=Debug -DRMM_CONFIG=qemu_virt_defcfg -B build-qemu
-- The C compiler identification is GNU 11.5.0
-- The CXX compiler identification is GNU 11.5.0
-- The ASM compiler identification is GNU
-- Found assembler: /usr/bin/gcc
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - failed
-- Check for working C compiler: /usr/bin/gcc
-- Check for working C compiler: /usr/bin/gcc - broken
CMake Error at /usr/share/cmake/Modules/CMakeTestCCompiler.cmake:67 (message):
   The C compiler

     "/usr/bin/gcc"

   is not able to compile a simple test program.

   It fails with the following output:

     Change Dir: /home/gshan/sandbox/qemu/host/tf-rmm/build-qemu/CMakeFiles/CMakeScratch/TryCompile-Aab6zP
     
     Run Build Command(s):/usr/bin/cmake -E env VERBOSE=1 /usr/bin/gmake -f Makefile cmTC_87ded/fast && /usr/bin/gmake  -f CMakeFiles/cmTC_87ded.dir/build.make CMakeFiles/cmTC_87ded.dir/build
     gmake[1]: Entering directory '/home/gshan/sandbox/qemu/host/tf-rmm/build-qemu/CMakeFiles/CMakeScratch/TryCompile-Aab6zP'
     Building C object CMakeFiles/cmTC_87ded.dir/testCCompiler.c.obj
     /usr/bin/gcc   -fno-common -ffunction-sections -fdata-sections -Wall -Werror -gdwarf-4 -ffreestanding -mbranch-protection=standard -mgeneral-regs-only -mstrict-align -fpie  -o CMakeFiles/cmTC_87ded.dir/testCCompiler.c.obj -c /home/gshan/sandbox/qemu/host/tf-rmm/build-qemu/CMakeFiles/CMakeScratch/TryCompile-Aab6zP/testCCompiler.c
     gcc: error: unrecognized command-line option ‘-mbranch-protection=standard’
     gcc: error: unrecognized command-line option ‘-mstrict-align’; did you mean ‘-Wstrict-aliasing’?
     gmake[1]: *** [CMakeFiles/cmTC_87ded.dir/build.make:78: CMakeFiles/cmTC_87ded.dir/testCCompiler.c.obj] Error 1
     gmake[1]: Leaving directory '/home/gshan/sandbox/qemu/host/tf-rmm/build-qemu/CMakeFiles/CMakeScratch/TryCompile-Aab6zP'
     gmake: *** [Makefile:127: cmTC_87ded/fast] Error 2

   CMake will not be able to correctly generate this project.
Call Stack (most recent call first):
   CMakeLists.txt:51 (project)


-- Configuring incomplete, errors occurred!

Upstream TF-RMM fails to be initialized
========================================
$ git clone git@github.com:TF-RMM/tf-rmm.git tf-rmm
$ cd tf-rmm
$ git submodule update --init --recursive
$ export CROSS_COMPILE=aarch64-none-elf-
$ cmake -DCMAKE_BUILD_TYPE=Debug -DRMM_CONFIG=qemu_virt_defcfg -B build-qemu
$ cmake --build build-qemu

$ cd ..
$ git clone git@github.com:tianocore/edk2.git edk2
$ cd edk2
$ git submodule update --init --recursive
$ source edksetup.sh
$ make -j -C BaseTools
$ export GCC5_AARCH64_PREFIX=aarch64-linux-gnu-
$ build -b RELEASE -a AARCH64 -t GCC5 -p ArmVirtPkg/ArmVirtQemuKernel.dsc

$ cd ..
$ git@github.com:ARM-software/arm-trusted-firmware.git tf-a
$ make -j CROSS_COMPILE=aarch64-linux-gnu-     \
   PLAT=qemu ENABLE_RME=1 DEBUG=1 LOG_LEVEL=40  \
   QEMU_USE_GIC_DRIVER=QEMU_GICV3               \
   RMM=../rmm/build-qemu/Debug/rmm.img          \
   BL33=../edk2/Build/ArmVirtQemuKernel-AARCH64/RELEASE_GCC5/FV/QEMU_EFI.fd all fip
$ dd if=build/qemu/debug/bl1.bin of=flash.bin
$ dd if=build/qemu/debug/fip.bin of=flash.bin seek=64 bs=4096

$ ${HOST_PATH}/qemu/build/qemu-system-aarch64                         \
-M virt,virtualization=on,secure=on,gic-version=3,acpi=off            \
-cpu max,x-rme=on -m 64G -smp 8                                       \
-serial mon:stdio -monitor none -nographic -nodefaults                \
-bios ${HOST_PATH}/tf-a/flash.bin                                     \
-kernel ${HOST_PATH}/linux/arch/arm64/boot/Image                      \
-initrd ${HOST_PATH}/buildroot/output/images/rootfs.cpio.xz           \
-device pcie-root-port,bus=pcie.0,chassis=1,id=pcie.1                 \
-device pcie-root-port,bus=pcie.0,chassis=2,id=pcie.2                 \
-device pcie-root-port,bus=pcie.0,chassis=3,id=pcie.3                 \
-device pcie-root-port,bus=pcie.0,chassis=4,id=pcie.4                 \
-device virtio-9p-device,fsdev=shr0,mount_tag=shr0                    \
-fsdev local,security_model=none,path=${GUEST_PATH},id=shr0           \
-netdev tap,id=tap1,script=/etc/qemu-ifup,downscript=/etc/qemu-ifdown \
-device virtio-net-pci,bus=pcie.2,netdev=tap1,mac=78:ac:44:2b:43:f0
   :
   :
NOTICE:  Booting Trusted Firmware
NOTICE:  BL1: v2.12.0(debug):ad6310a66
NOTICE:  BL1: Built : 22:09:22, Dec  7 2024
INFO:    BL1: RAM 0xe0ee000 - 0xe0f6000
INFO:    BL1: Loading BL2
INFO:    Loading image id=1 at address 0xe05b000
INFO:    Image id=1 loaded: 0xe05b000 - 0xe0652b9
NOTICE:  BL1: Booting BL2
INFO:    Entry point address = 0xe05b000
INFO:    SPSR = 0x3cd
INFO:    GPT: Boot Configuration
INFO:      PPS/T:     0x2/40
INFO:      PGS/P:     0x0/12
INFO:      L0GPTSZ/S: 0x0/30
INFO:      PAS count: 6
INFO:      L0 base:   0xeefc000
INFO:    Enabling Granule Protection Checks
NOTICE:  BL2: v2.12.0(debug):ad6310a66
NOTICE:  BL2: Built : 22:09:23, Dec  7 2024
INFO:    BL2: Doing platform setup
INFO:    Reserved RMM memory [0x40100000, 0x418fffff] in Device tree
INFO:    BL2: Loading image id 3
INFO:    Loading image id=3 at address 0xe090000
INFO:    Image id=3 loaded: 0xe090000 - 0xe0a20c4
INFO:    BL2: Loading image id 35
INFO:    Loading image id=35 at address 0x40100000
INFO:    Image id=35 loaded: 0x40100000 - 0x40303a00
INFO:    BL2: Loading image id 5
INFO:    Loading image id=5 at address 0x60000000
INFO:    Image id=5 loaded: 0x60000000 - 0x60200000
NOTICE:  BL2: Booting BL31
INFO:    Entry point address = 0xe090000
INFO:    SPSR = 0x3cd
NOTICE:  BL31: v2.12.0(debug):ad6310a66
NOTICE:  BL31: Built : 22:09:23, Dec  7 2024
INFO:    GICv3 without legacy support detected.
INFO:    ARM GICv3 driver initialized in EL3
INFO:    Maximum SPI INTID supported: 287
INFO:    BL31: Initializing runtime services
INFO:    RMM setup done.
INFO:    BL31: Initializing RMM
INFO:    RMM init start.
ERROR:   RMM init failed: -7               <<<<< RMM initialization failed
WARNING: BL31: RMM initialization failed
INFO:    BL31: Preparing for EL3 exit to normal world
INFO:    Entry point address = 0x60000000
INFO:    SPSR = 0x3c9
UEFI firmware (version  built at 22:03:35 on Dec  7 2024)
  :
EFI stub: Booting Linux Kernel...
EFI stub: Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path
EFI stub: Using DTB from configuration table
EFI stub: Exiting boot services...
ERROR:   RMM Failed to initialize. Ignoring for CPU1
ERROR:   RMM Failed to initialize. Ignoring for CPU2
ERROR:   RMM Failed to initialize. Ignoring for CPU3
ERROR:   RMM Failed to initialize. Ignoring for CPU4
ERROR:   RMM Failed to initialize. Ignoring for CPU5
ERROR:   RMM Failed to initialize. Ignoring for CPU6
ERROR:   RMM Failed to initialize. Ignoring for CPU7
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x000f0510]

Thanks,
Gavin



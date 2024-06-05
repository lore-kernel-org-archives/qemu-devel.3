Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4329FC25B78
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 01:30:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEfSY-0000TU-Cb; Tue, 04 Jun 2024 21:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sEfSW-0000Sr-O2
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 21:29:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sEfSU-0004VN-IZ
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 21:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717550937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jMtNE9Eow0elFpRE+T+eUuXHnyjNYdQ9KKqLT6dH5gA=;
 b=QUfzQMER7Q5H4qdWCQX4UycTkiA2Nq8qAcUVE/HDhYcmFzGo9OvHXHQYwKs2yJl7f3hz8T
 R//IV7Vx6YvJdEjWKtioe29S1hM28909GAPgVrCCg9YQa3bpABZz1HxSl3yAzlDRu+pwbt
 kk4BbAhm9o/9d03/8EUisJiyIyAg/3U=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195--wzj32r9PlWSxEDe7GZhhg-1; Tue, 04 Jun 2024 21:28:55 -0400
X-MC-Unique: -wzj32r9PlWSxEDe7GZhhg-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1f6792bf633so15085385ad.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 18:28:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717550933; x=1718155733;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jMtNE9Eow0elFpRE+T+eUuXHnyjNYdQ9KKqLT6dH5gA=;
 b=jZQ05pCtS040V1z1TJZ3exenPlGHbsv2qKdCOB+cBkFuCFdmG8AVT25jjnFe2a2ao4
 Z4mR0+/3VIt/WzOorwkQvQhd2gyYVEuCDs90Z5RlFPc5XpgAkXpyRS0OtlpqVi1+yCKu
 ZUWLrXGCc5Toji59S6gylyvqPIQZacT/0EOebsEf2NI9KrxxDvZdSyP8UlrVWYfLtVkP
 KCsr66JsJKddf3gMAyyTOxcUDtOxxPCMtFzbBKOK6LZeiAnTPaOpPRdvtk3qF0qj7OTN
 jb2nRIKn1vxWlSB+cbh4ODe/6wBLZAXPjDSOsKGX+K95MQaBJ83W4BTWq+veIPXWhHnT
 Bzdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlYp4jc1sX2iJNwc5o67Yw42k4TP2RTt9J4ZOnaWYgr11bLEUN6e2QogqMdZAKPnHeC6+bbRiXZovHuUqNMSJjRbm8ESA=
X-Gm-Message-State: AOJu0YyLWLcHu8B+x82EslEHALmJ3sWO64L62uLczaIpkKyqoaWX8M6G
 4RFGSfVJXhKh28cCTIrQJAYkkAZpMvOOdgitkzmd8k/ciYj4mG3WtGANkCYrahOf2jWNHCCjfz1
 IlSKBT0wEYJTwdGaew0U2NoUQcRw5H9KSYmNxtwJhcOywqNlcyDntxmsfKR2O
X-Received: by 2002:a17:902:d482:b0:1f3:4d8f:e5f3 with SMTP id
 d9443c01a7336-1f6a5a10405mr16992325ad.15.1717550933123; 
 Tue, 04 Jun 2024 18:28:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcgrrYDUt2pCJR8uE12repLrE76MxHDiOsp4jCC420V+o4b13wURBv7DbdTqJbBFK6TTyDlQ==
X-Received: by 2002:a17:902:d482:b0:1f3:4d8f:e5f3 with SMTP id
 d9443c01a7336-1f6a5a10405mr16992015ad.15.1717550932660; 
 Tue, 04 Jun 2024 18:28:52 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.224])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f683286848sm38107865ad.235.2024.06.04.18.28.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 18:28:52 -0700 (PDT)
Message-ID: <e7748b25-a01b-49e9-bbeb-cd03abb91cf6@redhat.com>
Date: Wed, 5 Jun 2024 11:28:47 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Unexpected error in rme_configure_one() at
 ../target/arm/kvm-rme.c:159
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Itaru Kitayama <itaru.kitayama@linux.dev>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ard Biesheuvel <ardb@kernel.org>
References: <0C6F517A-5686-4BCE-8D08-1CED02CB470E@linux.dev>
 <4e7aa598-1a5d-47e1-aaa3-78af05947eeb@linaro.org>
 <CB05CAA2-9301-45F6-8AE3-A2E27A160CDF@linux.dev>
 <cbd630d7-01e8-49ba-9c8b-a6514d898ed2@redhat.com>
 <20240531150922.GA83195@myrica>
 <bd1f84bd-e23c-4f4b-bc0b-a2a1b70081f4@redhat.com>
 <20240603082402.GA25688@myrica>
 <2c81cb47-b9bc-4875-a7fb-49c3a8ab6713@redhat.com>
 <20240604111517.GB875061@myrica>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240604111517.GB875061@myrica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 6/4/24 21:15, Jean-Philippe Brucker wrote:
> On Tue, Jun 04, 2024 at 01:02:08PM +1000, Gavin Shan wrote:
>> On 6/3/24 18:24, Jean-Philippe Brucker wrote:
>>> On Sat, Jun 01, 2024 at 08:14:46PM +1000, Gavin Shan wrote:
>>>> ---> guest edk2
>>>>
>>>> # git clone https://git.codelinaro.org/linaro/dcap/edk2.git edk2-guest
>>>> # cd edk2-guest; git checkout origin/cca/v2 -b cca/v2
>>>> # git submodule update --init --recursive;  \
>>>>     source edksetup.sh; make -j -C BaseTools; \
>>>>     export GCC5_AARCH64_PREFIX=;              \
>>>
>>> Doesn't this needs a cross-compiler, something like "aarch64-linux-gnu-" ?
>>>
>>
>> No, I was building everything using a native compiler instead of a cross compiler.
>> All packages were compiled on a NVidia's grace-hopper machine.
>>
>> [root@nvidia-grace-hopper-05 ~]# cat /etc/system-release
>> Red Hat Enterprise Linux release 9.5 Beta (Plow)
>> [root@nvidia-grace-hopper-05 ~]# uname -r
>> 6.7.0-rc2-gavin+
>> [root@nvidia-grace-hopper-05 ~]# gcc --version
>> gcc (GCC) 11.4.1 20231218 (Red Hat 11.4.1-3)
>> Copyright (C) 2021 Free Software Foundation, Inc.
>> This is free software; see the source for copying conditions.  There is NO
>> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>>
>> I tried the cross compiler and encountered the same build error.
>>
>> [root@nvidia-grace-hopper-05 edk2-guest]# export | grep GCC5_AARCH64_PREFIX
>> declare -x GCC5_AARCH64_PREFIX="aarch64-linux-gnu-"
>> [root@nvidia-grace-hopper-05 edk2-guest]# build -b DEBUG -a AARCH64 -t GCC5 -p ArmVirtPkg/ArmVirtQemu.dsc
>>    :
>> --add-gnu-debuglink=/home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore/DEBUG/ArmPlatformPrePeiCore.debug /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore/DEBUG/ArmPlatformPrePeiCore.dll
>> cp -p -f /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore/DEBUG/ArmPlatformPrePeiCore.debug /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/ArmPlatformPrePeiCore.debug
>> "GenFw" -e SEC -o /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore/OUTPUT/ArmPlatformPrePeiCore.efi /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore/DEBUG/ArmPlatformPrePeiCore.dll
>> GenFw: ERROR 3000: Invalid
>>    WriteSections64(): /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore/DEBUG/ArmPlatformPrePeiCore.dll AARCH64 small code model requires identical ELF and PE/COFF section offsets modulo 4 KB.
> 
> Ah I've seen this once but it disappeared as I tried to investigate and
> I've since changed the implementation, so I don't have many notes about
> it.
> 
> Maybe you could try to bisect from "ArmVirtPkg: ArmCcaIoMmu: Provide an
> implementation for SetAttribute", but it may give false positives if the
> error depends on some random linker placement. Could be
> "ArmVirtPkg/ArmPlatformLibQemu: Setup early UART mapping in a Realm" which
> adds a 4k page to the data section for the ealy RSI config call, though
> that has explicit 4kB alignment.
> 
> In my notes I also wrote that changing "-z common-page-size=0x20" to 4k in
> the link flags may have made the error disappear, but I doubt it's the
> right fix.
> 
> I'll try GCC 11 to see if I can reproduce.
> 

Ok. I run a git-bisect and the first problematic commit is 1153ae939c
("ArmVirtPkg/ArmPlatformLibQemu: Add a third-level page table for the UART idmap")

I'm not familiar with edk2. The error is raised by BaseTools/Source/C/GenFw/Elf64Convert.c::WriteSections64()
where the relocatable address isn't properly aligned to 4KB. So I modified the code
as below, but I have to run two consecutive builds. In the first attempt build, I
still hit the same error.

---> VirtPkg/Library/ArmPlatformLibQemu/IdMap.S

   .align    12
   .globl    idmap
   .globl    uart_pte
   .section  ".data.idmap", "aw", %progbits
   .align    12

# source edksetup.sh; export GCC5_AARCH64_PREFIX=
# make -j -C BaseTools; \                                               <<< Failed on the first attempt
   build -b DEBUG -a AARCH64 -t GCC5 -p ArmVirtPkg/ArmVirtQemu.dsc
    :
WriteSections64(): /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore/DEBUG/ArmPlatformPrePeiCore.dll AARCH64 small code model requires identical ELF and PE/COFF section offsets modulo 4 KB.
make: *** [GNUmakefile:405: /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore/OUTPUT/ArmPlatformPrePeiCore.efi] Error 2

# make -j -C BaseTools; \                                              <<< Succeed on the second attempt
   build -b DEBUG -a AARCH64 -t GCC5 -p ArmVirtPkg/ArmVirtQemu.dsc
    :
Generating FVMAIN FV
######
Fd File Name:QEMU_VARS (/home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/FV/QEMU_VARS.fd)
    :
- Done -
Build end time: 21:04:05, Jun.04 2024
Build total time: 00:00:06

After that, I'm unable to start the guest with the edk2 image successfully.

host# # mount | grep 9p
shr0 on /mnt/shr0 type 9p (rw,relatime,access=client,trans=virtio)
host# cat ./realm.sh
#!/bin/sh

SHR_DIR="/mnt/shr0"

qemu-system-aarch64 -accel kvm                              \
-machine virt,gic-version=3,confidential-guest-support=rme0 \
-cpu host -smp 2 -m 512M                                    \
-object 'rme-guest,id=rme0,measurement-algo=sha512'         \
-monitor none -serial mon:stdio -nographic                  \
-bios ${SHR_DIR}/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/FV/QEMU_EFI.fd \
-kernel ${SHR_DIR}/linux/arch/arm64/boot/Image              \
-initrd ${SHR_DIR}/buildroot/output/images/rootfs.cpio      \
-append 'console=ttyAMA0'

host# ./realm.sh
UEFI firmware (version  built at 19:56:47 on Jun  4 2024)
add-symbol-file /home/gavin/sandbox/C                              <<< I don't see more output after it

>> GenFw: ERROR 3000: Invalid
>>    :
>>
>>>>     build -b DEBUG -a AARCH64 -t GCC5 -p ArmVirtPkg/ArmVirtQemu.dsc
>>>>      :
>>>>     WriteSections64(): /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore/DEBUG/ArmPlatformPrePeiCore.dll AARCH64 small code model requires identical ELF and PE/COFF section offsets modulo 4 KB.
>>>> cp -p -f /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/OvmfPkg/VirtioFsDxe/VirtioFsDxe/DEBUG/VirtioFsDxe.dll /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/OvmfPkg/VirtioFsDxe/VirtioFsDxe/DEBUG/VirtioFsDxe.debug
>>>> cp -p -f /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/MdeModulePkg/Universal/Disk/PartitionDxe/PartitionDxe/DEBUG/PartitionDxe.debug /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/PartitionDxe.debug
>>>> "gcc" -MMD -MF /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/CryptoPkg/Library/OpensslLib/OpensslLibCrypto/OUTPUT/openssl/crypto/asn1/x_sig.obj.deps @/home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/CryptoPkg/Library/OpensslLib/OpensslLibCrypto/OUTPUT/cc_resp.txt  -c -o /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/CryptoPkg/Library/OpensslLib/OpensslLibCrypto/OUTPUT/openssl/crypto/asn1/x_sig.obj  /home/gavin/sandbox/CCA/edk2-guest/CryptoPkg/Library/OpensslLib/openssl/crypto/asn1/x_sig.c
>>>> "GenFw" -e DXE_CORE -o /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/MdeModulePkg/Core/Dxe/DxeMain/OUTPUT/DxeCore.efi /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/MdeModulePkg/Core/Dxe/DxeMain/DEBUG/DxeCore.dll
>>>> GenSec -s EFI_SECTION_USER_INTERFACE -n ArmCpuDxe -o /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/FV/Ffs/B8D9777E-D72A-451F-9BDB-BAFB52A68415ArmCpuDxe/B8D9777E-D72A-451F-9BDB-BAFB52A68415SEC3.ui
>>>> cp -p -f /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/MdeModulePkg/Universal/DisplayEngineDxe/DisplayEngineDxe/DEBUG/*.map /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/MdeModulePkg/Universal/DisplayEngineDxe/DisplayEngineDxe/OUTPUT
>>>> cp -p -f /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/MdeModulePkg/Universal/Disk/UdfDxe/UdfDxe/OUTPUT/UdfDxe.efi /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/MdeModulePkg/Universal/Disk/UdfDxe/UdfDxe/DEBUG
>>>> GenFw: ERROR 3000: Invalid
>>>>     :
>>>> build.py...
>>>>    : error 7000: Failed to execute command
>>>> 	make tbuild [/home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore]
>>>>
>>>>
>>>> build.py...
>>>>    : error F002: Failed to build module
>>>> 	/home/gavin/sandbox/CCA/edk2-guest/ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore.inf [AARCH64, GCC5, DEBUG]
>>>>
>>>> - Failed -
>>>> Build end time: 05:42:19, Jun.01 2024
>>>> Build total time: 00:00:31
>>>>
> 
> 
>> Ok, I can look into this deeply after I can bring up the guest successfully.
> 
> Note that the guest edk2 is optional and experimental, you can use direct
> kernel boot to get a working demo quicker.
> 

I never did this before. Could you please provide the detailed steps on this?

Thanks,
Gavin



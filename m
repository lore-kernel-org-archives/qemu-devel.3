Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF1BCC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 15:57:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEszX-0002lZ-Ex; Wed, 05 Jun 2024 11:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sEszV-0002kr-RQ
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 11:55:57 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sEszT-0006KD-UT
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 11:55:57 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-354f14bd80cso1869447f8f.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 08:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717602953; x=1718207753; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=g7yFTYJAQNbfV366A2NWikpPsZaDac6yP9Q77k6ZhiM=;
 b=Ve9MtDfr2G5EimyZjqt22VqXJN8sx7s/XpITpMSlL2TEbNX9jtE3tkxKkwt/mgIPH5
 ZecfN9uOdj5y0Chw40Kr8mM49FsBuFHfrJsrKDjSnBhnHDjcy3AEFdMejcaIQkdKsFfH
 2hVLiEKsUHGQAhinIWl5NRbsZBPYIq5gYPF5IPN7K/jhSTK+fKvbBQX1CsCbF09Jguei
 Wtf0VVKP1lGbfWzUMpK3BIeltZLfq/kn8i2UdcUMnOpQL6/Emp0x3sdPl3aMpandWnju
 5atTsQdw4GeBJHz4LrkZXqDPqLt8ti1nVNNCeSjwERE//PeAXC2gsKcfV2S8CvfZenAj
 nxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717602953; x=1718207753;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g7yFTYJAQNbfV366A2NWikpPsZaDac6yP9Q77k6ZhiM=;
 b=iGm9QkkxESc3kBmN+D2Fe7ZllSXCIGmSNkFFHOLaXA8YwWSonX6CQwRtOApLIzCnNL
 F3BxmAQnx2DVvGgeDrq5uGbnrAhY+cDNRqeIh3/aSPyuNY1sHBHBYHkqL5ubbeGHcTGw
 TWJ6N836uVZG3JXC/ZeaIYX6Y/aqWx2BiJk8ytmvziXsvKs/iuLhncb+seDekYKIDDP/
 h4n2S+S0JJ1ltAzKj2MXhX7iaZzzYWOZhqTeaQDFHCHJnzIdwhJR3Zne+eQT6z2bqvOH
 nTojmLlo6PUT0od8TitWuDcOaYvM5fB2Lg2N0VdGFi8GcZTcv0/YWSdvHTO9YGDJIPea
 d5XA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFH+1GWGrb5JbkBNYUPz7MKnr/GbKWhlcTMm8/65vXFMy5SkYOapTP62AiS6sMeMqWOOclsNKIPGL5U7+AUK+r/EFkKsw=
X-Gm-Message-State: AOJu0Yw/szCnyyHzlPwkK3aIC2b86EmuhjJsoi1KYkSimx6sXMcgDR90
 qGXpjV1E8rJqt/Vw8ozwP0OkBmroP8ofJAOow035DPnQkk2o54PCpXOfH28Wsps=
X-Google-Smtp-Source: AGHT+IESzALHIFLNPt1IC9P61RLOyTagTvnP9h/oPUw+WtnQeGMc48S5+SC7Oipnr/z8Og13sz5lOw==
X-Received: by 2002:a5d:5888:0:b0:354:f9f0:a7ed with SMTP id
 ffacd0b85a97d-35e8ef86d29mr2464245f8f.47.1717602953537; 
 Wed, 05 Jun 2024 08:55:53 -0700 (PDT)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd066eb35sm14912744f8f.115.2024.06.05.08.55.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 08:55:53 -0700 (PDT)
Date: Wed, 5 Jun 2024 16:56:08 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Gavin Shan <gshan@redhat.com>
Cc: Itaru Kitayama <itaru.kitayama@linux.dev>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ard Biesheuvel <ardb@kernel.org>
Subject: Re: Unexpected error in rme_configure_one() at
 ../target/arm/kvm-rme.c:159
Message-ID: <20240605155608.GA3251699@myrica>
References: <0C6F517A-5686-4BCE-8D08-1CED02CB470E@linux.dev>
 <4e7aa598-1a5d-47e1-aaa3-78af05947eeb@linaro.org>
 <CB05CAA2-9301-45F6-8AE3-A2E27A160CDF@linux.dev>
 <cbd630d7-01e8-49ba-9c8b-a6514d898ed2@redhat.com>
 <20240531150922.GA83195@myrica>
 <bd1f84bd-e23c-4f4b-bc0b-a2a1b70081f4@redhat.com>
 <20240603082402.GA25688@myrica>
 <2c81cb47-b9bc-4875-a7fb-49c3a8ab6713@redhat.com>
 <20240604111517.GB875061@myrica>
 <e7748b25-a01b-49e9-bbeb-cd03abb91cf6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7748b25-a01b-49e9-bbeb-cd03abb91cf6@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x436.google.com
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

On Wed, Jun 05, 2024 at 11:28:47AM +1000, Gavin Shan wrote:
> > >    WriteSections64(): /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore/DEBUG/ArmPlatformPrePeiCore.dll AARCH64 small code model requires identical ELF and PE/COFF section offsets modulo 4 KB.
> > 
> > Ah I've seen this once but it disappeared as I tried to investigate and
> > I've since changed the implementation, so I don't have many notes about
> > it.
> > 
> > Maybe you could try to bisect from "ArmVirtPkg: ArmCcaIoMmu: Provide an
> > implementation for SetAttribute", but it may give false positives if the
> > error depends on some random linker placement. Could be
> > "ArmVirtPkg/ArmPlatformLibQemu: Setup early UART mapping in a Realm" which
> > adds a 4k page to the data section for the ealy RSI config call, though
> > that has explicit 4kB alignment.
> > 
> > In my notes I also wrote that changing "-z common-page-size=0x20" to 4k in
> > the link flags may have made the error disappear, but I doubt it's the
> > right fix.
> > 
> > I'll try GCC 11 to see if I can reproduce.
> > 
> 
> Ok. I run a git-bisect and the first problematic commit is 1153ae939c
> ("ArmVirtPkg/ArmPlatformLibQemu: Add a third-level page table for the UART idmap")

Ah thanks, I'm able to reproduce the problem now, it was my local config
that masked it.

> 
> I'm not familiar with edk2. The error is raised by BaseTools/Source/C/GenFw/Elf64Convert.c::WriteSections64()
> where the relocatable address isn't properly aligned to 4KB. So I modified the code
> as below, but I have to run two consecutive builds. In the first attempt build, I
> still hit the same error.

This seems to be because GenFw generates a file even on error, so it
doesn't retry the second time.

This commit moves the page tables from .rodata to .data. When linking
IdMap.obj into ArmPlatformPrePeiCore.dll, the alignment of the .text
section changes from 0x1000 to 0x800. This change comes from the linker
script putting .rodata into .text. I don't know why the included .rodata
alignment affects the .text alignment, but I don't think it matters here.

In GenFw, ScanSections64() calculates a mCoffAlignment as the max
.text/.data/.hii section alignement. Since with this commit, .data
alignement (0x1000) becomes larger than .text (0x800), it picks 0x1000 as
the output text offset, and then WriteSections64() complains that this
offset isn't equal to the input .text alignment modulo 0x1000.

The linker script says:

  /*
   * The alignment of the .data section should be less than or equal to the
   * alignment of the .text section. This ensures that the relative offset
   * between these sections is the same in the ELF and the PE/COFF versions of
   * this binary.
   */

but that's not what we're getting. I don't have a fix yet, other than
forcing the .text and .data alignment to 4k.

> ---> VirtPkg/Library/ArmPlatformLibQemu/IdMap.S
> 
>   .align    12
>   .globl    idmap
>   .globl    uart_pte
>   .section  ".data.idmap", "aw", %progbits
>   .align    12
> 
> # source edksetup.sh; export GCC5_AARCH64_PREFIX=
> # make -j -C BaseTools; \                                               <<< Failed on the first attempt
>   build -b DEBUG -a AARCH64 -t GCC5 -p ArmVirtPkg/ArmVirtQemu.dsc
>    :
> WriteSections64(): /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore/DEBUG/ArmPlatformPrePeiCore.dll AARCH64 small code model requires identical ELF and PE/COFF section offsets modulo 4 KB.
> make: *** [GNUmakefile:405: /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore/OUTPUT/ArmPlatformPrePeiCore.efi] Error 2
> 
> # make -j -C BaseTools; \                                              <<< Succeed on the second attempt
>   build -b DEBUG -a AARCH64 -t GCC5 -p ArmVirtPkg/ArmVirtQemu.dsc
>    :
> Generating FVMAIN FV
> ######
> Fd File Name:QEMU_VARS (/home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/FV/QEMU_VARS.fd)
>    :
> - Done -
> Build end time: 21:04:05, Jun.04 2024
> Build total time: 00:00:06
> 
> After that, I'm unable to start the guest with the edk2 image successfully.
> 
> host# # mount | grep 9p
> shr0 on /mnt/shr0 type 9p (rw,relatime,access=client,trans=virtio)
> host# cat ./realm.sh
> #!/bin/sh
> 
> SHR_DIR="/mnt/shr0"
> 
> qemu-system-aarch64 -accel kvm                              \
> -machine virt,gic-version=3,confidential-guest-support=rme0 \
> -cpu host -smp 2 -m 512M                                    \
> -object 'rme-guest,id=rme0,measurement-algo=sha512'         \
> -monitor none -serial mon:stdio -nographic                  \
> -bios ${SHR_DIR}/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/FV/QEMU_EFI.fd \
> -kernel ${SHR_DIR}/linux/arch/arm64/boot/Image              \
> -initrd ${SHR_DIR}/buildroot/output/images/rootfs.cpio      \
> -append 'console=ttyAMA0'
> 
> host# ./realm.sh
> UEFI firmware (version  built at 19:56:47 on Jun  4 2024)
> add-symbol-file /home/gavin/sandbox/C                              <<< I don't see more output after it

I'm guessing in this case the firmware was corrupted because GenFw fails the
first time and never generated a complete binary

> > 
> > Note that the guest edk2 is optional and experimental, you can use direct
> > kernel boot to get a working demo quicker.
> > 
> 
> I never did this before. Could you please provide the detailed steps on this?

Removing the -bios parameter to QEMU should be enough. You can also add
'earlycon' to -append to show early boot errors.

Thanks,
Jean



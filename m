Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D85D3C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 15:10:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD3sY-0007fM-ET; Fri, 31 May 2024 11:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sD3sW-0007f7-FQ
 for qemu-devel@nongnu.org; Fri, 31 May 2024 11:09:12 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sD3sU-00059E-D4
 for qemu-devel@nongnu.org; Fri, 31 May 2024 11:09:12 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-52a54d664e3so1507100e87.0
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 08:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717168148; x=1717772948; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vujZepglms1bK1s11/iMyFJ7QfJ32dqmj6z2Azg2PoE=;
 b=OEXwxN5MSRWU0ClaHh2JfJKnJaQsA1xocSZDpE6lBAdiIbL/Tq8ymjagg20ZhhOfcT
 t0WcnVStAqdO+Q3SWtbtumpk30K5ICbhOsoG8ddVpiNNGaIkW8wllrQo7L5o72LnFp8A
 LjAz9fMW4t8x7n0cpgvCNp0sX+7jGa9Jco5VeK10SfRgiA3XZevvrrTtyC4Jq2EkmXps
 k9T32AbnDDk5Txulxj45rHzUW0i+I2UMu8NzHqet85mcpCbsbrCcwnULNv5hbWAYX082
 a1wusy3Ax2BhWU/XOBKQvvYbylwYy9JIOEeA2wc/Jx05lgb7fp/sE+DYMacxBMMRujHx
 ZnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717168148; x=1717772948;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vujZepglms1bK1s11/iMyFJ7QfJ32dqmj6z2Azg2PoE=;
 b=GN09UvSUnUTAhcXAOT2zyCaaJ5wTF3vLaluuTGmF3AR1hEc2GYEeERcsCllAoxWwKL
 7Vaciuv5604UssHFyLfix1ryoeF7gWueNkaMLv89qRVY0Od6jOglYN3+2LQZHB0bF+hR
 uJH1zBZJBcY9/dXoMB6zODKz+b92i6gw/efLD4y6JSFwJcU5o8Ntq8es+xILqsC8wTOo
 VY+nTYhfs191O/tZ/9DfIC4rftmw/YEBrvJFkI1f2apazrh9qA8DfsIhnXpzJQ5x+tb5
 oYIfXGj/ICI5PbB0v2GEmc3vpkFLvA+RzVBaKxAUvNBA4/Eucfdwonp4Tzh6C2cWSJ/P
 ZH3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNl9kEKzBX7bH5sTImjkuhWW3FI1i0T2C+SfBm8n4hssH1l8LBq2cSaIB84HPgjFioXbPp1KXxFhn71hG0ctIRNgO/9yc=
X-Gm-Message-State: AOJu0YzxnpUa4RRDF+I1Dp3+NedK5Vs0Z/o2o0YVDidp49ljsFLgio8C
 YgLQ0y7YJ2ilK4SR/lwfyyHy/bKkZUC5Qz/9r+qNCeKoq5zscsVV/LtaEDUFFWY=
X-Google-Smtp-Source: AGHT+IHKF0dU7IZo8MPKMKqEuTS0Tr+1oHrUs4qu6A67zBXVT74JxClr+A+E01lYnhzV8O+rRvzIDw==
X-Received: by 2002:a05:6512:2eb:b0:52b:79c2:1aa7 with SMTP id
 2adb3069b0e04-52b896d48f6mr1463581e87.62.1717168148117; 
 Fri, 31 May 2024 08:09:08 -0700 (PDT)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-421330d2a27sm12412585e9.42.2024.05.31.08.09.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 08:09:07 -0700 (PDT)
Date: Fri, 31 May 2024 16:09:22 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Gavin Shan <gshan@redhat.com>
Cc: Itaru Kitayama <itaru.kitayama@linux.dev>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ard Biesheuvel <ardb@kernel.org>
Subject: Re: Unexpected error in rme_configure_one() at
 ../target/arm/kvm-rme.c:159
Message-ID: <20240531150922.GA83195@myrica>
References: <0C6F517A-5686-4BCE-8D08-1CED02CB470E@linux.dev>
 <4e7aa598-1a5d-47e1-aaa3-78af05947eeb@linaro.org>
 <CB05CAA2-9301-45F6-8AE3-A2E27A160CDF@linux.dev>
 <cbd630d7-01e8-49ba-9c8b-a6514d898ed2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbd630d7-01e8-49ba-9c8b-a6514d898ed2@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=jean-philippe@linaro.org; helo=mail-lf1-x12e.google.com
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

On Fri, May 31, 2024 at 04:23:13PM +1000, Gavin Shan wrote:
> I got a chance to try CCA software components, suggested by [1]. However, the edk2
> is stuck somewhere. I didn't reach to stage of loading guest kernel yet. I'm replying
> to see if anyone has a idea.
...
> INFO:    BL31: Preparing for EL3 exit to normal world
> INFO:    Entry point address = 0x60000000
> INFO:    SPSR = 0x3c9
> UEFI firmware (version  built at 01:31:23 on May 31 2024)
> 
> The boot is stuck and no more output after that. I tried adding more verbose output
> from edk2 and found it's stuck at the following point.
> 
> 
> ArmVirtPkg/PrePi/PrePi.c::PrePiMain
> rmVirtPkg/Library/PlatformPeiLib/PlatformPeiLib.c::PlatformPeim
> 
>  #ifdef MDE_CPU_AARCH64
>   //
>   // Set the SMCCC conduit to SMC if executing at EL2, which is typically the
>   // exception level that services HVCs rather than the one that invokes them.
>   //
>   if (ArmReadCurrentEL () == AARCH64_EL2) {
>     Status = PcdSetBoolS (PcdMonitorConduitHvc, FALSE);       // The function is never returned in my case
>     ASSERT_EFI_ERROR (Status);
>   }
>  #endif

I'm able to reproduce this even without RME. This code was introduced
recently by c98f7f755089 ("ArmVirtPkg: Use dynamic PCD to set the SMCCC
conduit"). Maybe Ard (Cc'd) knows what could be going wrong here.

A slightly reduced reproducer:

$ cd edk2/
$ build -b DEBUG -a AARCH64 -t GCC5 -p ArmVirtPkg/ArmVirtQemuKernel.dsc
$ cd ..

$ git clone https://github.com/ARM-software/arm-trusted-firmware.git tf-a
$ cd tf-a/
$ make -j CROSS_COMPILE=aarch64-linux-gnu- PLAT=qemu DEBUG=1 LOG_LEVEL=40 QEMU_USE_GIC_DRIVER=QEMU_GICV3 BL33=../edk2/Build/ArmVirtQemuKernel-AARCH64/DEBUG_GCC5/FV/QEMU_EFI.fd all fip && \
  dd if=build/qemu/debug/bl1.bin of=flash.bin && \
  dd if=build/qemu/debug/fip.bin of=flash.bin seek=64 bs=4096
$ qemu-system-aarch64 -M virt,virtualization=on,secure=on,gic-version=3 -cpu max -m 2G -smp 8 -monitor none -serial mon:stdio -nographic -bios flash.bin

Thanks,
Jean


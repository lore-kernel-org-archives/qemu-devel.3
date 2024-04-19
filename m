Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE15BC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 16:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxqoH-0004Lt-RQ; Fri, 19 Apr 2024 12:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rxqo8-0004FR-C8; Fri, 19 Apr 2024 12:09:48 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rxqo5-0002ge-8K; Fri, 19 Apr 2024 12:09:48 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VLfgB67pKz6JBJF;
 Sat, 20 Apr 2024 00:07:34 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id BFEF4140A35;
 Sat, 20 Apr 2024 00:09:40 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 19 Apr
 2024 17:09:40 +0100
Date: Fri, 19 Apr 2024 17:09:38 +0100
To: Gerd Hoffmann <kraxel@redhat.com>
CC: <devel@edk2.groups.io>, Jonathan Cameron via <qemu-devel@nongnu.org>,
 <linuxarm@huawei.com>, Richard Henderson <richard.henderson@linaro.org>,
 <qemu-arm@nongnu.org>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, Idan Horowitz <idan.horowitz@gmail.com>, "Ard
 Biesheuvel" <ardb@kernel.org>
Subject: Re: [edk2-devel] [PATCH v3 5/6] target/arm: Do memory type
 alignment check when translation disabled
Message-ID: <20240419170938.00000551@huawei.com>
In-Reply-To: <kjpkyoux2xcegrqshde5ddhicf33jnlelobuzuo4uj4svvlzdn@rilun7dz6776>
References: <20240301204110.656742-1-richard.henderson@linaro.org>
 <20240301204110.656742-6-richard.henderson@linaro.org>
 <20240416161111.0000607c@huawei.com>
 <0c878d25-3fbb-4f0b-bc9e-ca638f8c4f1e@linaro.org>
 <20240418091555.00006666@Huawei.com>
 <20240418183600.00000345@huawei.com>
 <kjpkyoux2xcegrqshde5ddhicf33jnlelobuzuo4uj4svvlzdn@rilun7dz6776>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 19 Apr 2024 13:52:07 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

>   Hi,
> 
> > Gerd, any ideas?  Maybe I needs something subtly different in my
> > edk2 build?  I've not looked at this bit of the qemu infrastructure
> > before - is there a document on how that image is built?  
> 
> There is roms/Makefile for that.
> 
> make -C roms help
> make -C roms efi
> 
> So easiest would be to just update the edk2 submodule to what you
> need, then rebuild.
> 
> The build is handled by the roms/edk2-build.py script,
> with the build configuration being in roms/edk2-build.config.
> That is usable outside the qemu source tree too, i.e. like this:
> 
>   python3 /path/to/qemu.git/roms/edk2-build.py \
>     --config /path/to/qemu.git/roms/edk2-build.config \
>     --core /path/to/edk2.git \
>     --match armvirt \
>     --silent --no-logs
> 
> That'll try to place the images build in "../pc-bios", so maybe better
> work with a copy of the config file where you adjust this.
> 
> HTH,
>   Gerd
> 

Thanks Gerd!

So the builds are very similar via the two method...
However - the QEMU build sets -D CAVIUM_ERRATUM_27456=TRUE

And that's the difference - with that set for my other builds the alignment
problems go away...

Any idea why we have that set in roms/edk2-build.config?
Superficially it seems rather unlikely anyone cares about thunderx1
(if they do we need to get them some new hardware with fresh bugs)
bugs now and this config file was only added last year.


However, the last comment in Ard's commit message below seems
highly likely to be relevant!

Chasing through Ard's patch it has the side effect of dropping
an override of a requirement for strict alignment. 
So with out the errata 
DEFINE GCC_AARCH64_CC_XIPFLAGS     = -mstrict-align -mgeneral-regs-only
is replaced with
 [BuildOptions]
+!if $(CAVIUM_ERRATUM_27456) == TRUE^M
+  GCC:*_*_AARCH64_PP_FLAGS = -DCAVIUM_ERRATUM_27456^M
+!else^M
   GCC:*_*_AARCH64_CC_XIPFLAGS ==
+!endif^M

The edk2 commit that added this was the following +CC Ard.

Given I wasn't sure of the syntax of that file I set it
manually to the original value and indeed it works.


commit ec54ce1f1ab41b92782b37ae59e752fff0ef9c41
Author: Ard Biesheuvel <ardb@kernel.org>
Date:   Wed Jan 4 16:51:35 2023 +0100

    ArmVirtPkg/ArmVirtQemu: Avoid early ID map on ThunderX

    The early ID map used by ArmVirtQemu uses ASID scoped non-global
    mappings, as this allows us to switch to the permanent ID map seamlessly
    without the need for explicit TLB maintenance.

    However, this triggers a known erratum on ThunderX, which does not
    tolerate non-global mappings that are executable at EL1, as this appears
    to result in I-cache corruption. (Linux disables the KPTI based Meltdown
    mitigation on ThunderX for the same reason)

    So work around this, by detecting the CPU implementor and part number,
    and proceeding without the early ID map if a ThunderX CPU is detected.

    Note that this requires the C code to be built with strict alignment
    again, as we may end up executing it with the MMU and caches off.

    Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
    Acked-by: Laszlo Ersek <lersek@redhat.com>
    Tested-by: dann frazier <dann.frazier@canonical.com>

Test case is
qemu-system-aarch64 -M virt,virtualization=true, -m 4g -cpu cortex-a76 \
-bios QEMU_EFI.fd -d int

Which gets alignment faults since:
https://lore.kernel.org/all/20240301204110.656742-6-richard.henderson@linaro.org/

So my feeling here is EDK2 should either have yet another config for QEMU as a host
or should always set the alignment without needing to pick the CAVIUM 27456 errata
which I suspect will get dropped soonish anyway if anyone ever cleans up
old errata.

Jonathan





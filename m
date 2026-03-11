Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF3E1125847
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:19:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0LIM-0007OQ-Jz; Wed, 11 Mar 2026 11:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w0LIG-00078h-Lo
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 11:16:18 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w0LIE-0000PM-38
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 11:16:16 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 64901596D8B;
 Wed, 11 Mar 2026 16:16:10 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id mNszGf5dFwyd; Wed, 11 Mar 2026 16:16:08 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6797E596A13; Wed, 11 Mar 2026 16:16:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 65BF1596A41;
 Wed, 11 Mar 2026 16:16:08 +0100 (CET)
Date: Wed, 11 Mar 2026 16:16:08 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Markus Armbruster <armbru@redhat.com>
cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 Peter Xu <peterx@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: -device T,help crashes
In-Reply-To: <87pl5abgpl.fsf@pond.sub.org>
Message-ID: <353746d7-0744-4621-8732-2f4da7771f40@eik.bme.hu>
References: <87pl5abgpl.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, 11 Mar 2026, Markus Armbruster wrote:
> Watch this:
>
>    $ qemu-system-aarch64 -S -display none -M virt -device acpi-ged,help
>    qemu-system-aarch64: ../hw/core/qdev.c:858: qdev_get_machine: Assertion `dev' failed.
>
> A number of devices crash this way:
>
> * acpi-ged (aarch64 arm i386 loongarch64 x86_64)
> * fsl-imx6 (aarch64 arm)
> * fsl-imx7 (aarch64 arm)
> * fsl-imx8mp (aarch64)
> * microchip.pfsoc (riscv64)
> * riscv.sifive.e.soc (riscv32 riscv64)
> * xlnx-zynqmp (aarch64)
>
> Here's another one:
>
>    $ qemu-system-sparc64 -S -display none -M virt -device sun4u-iommu,help
>    qemu-system-sparc64: ../system/physmem.c:1401: register_multipage: Assertion `num_pages' failed.
>
> Devices crashing this way:
>
> * Loongson-3A4000-mips64-cpu (mips64 mips64el)
> * dc232b-xtensa-cpu (xtensa)
> * dc233c-xtensa-cpu (xtensa)
> * de212-xtensa-cpu (xtensa)
> * de233_fpu-xtensa-cpu (xtensa)
> * dsp3400-xtensa-cpu (xtensa)
> * fsf-xtensa-cpu (xtensaeb)
> * lx106-xtensa-cpu (xtensa)
> * sample_controller-xtensa-cpu (xtensa)
> * sun4m-iommu (sparc)
> * sun4u-iommu (sparc64)
> * test_kc705_be-xtensa-cpu (xtensaeb)
> * test_mmuhifi_c3-xtensa-cpu (xtensa)
>
> These crashes escape tests/qtest/device-introspect-test, because it
> covers only HMP "device_add T,help", not CLI "-device T,help".

Maybe these should be user_creatable=false in the first place as they 
look like some internal devices used to model a SoC or machine specific 
stuff.

Regards,
BALATON Zoltan


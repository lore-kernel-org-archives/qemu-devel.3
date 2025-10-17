Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C915ECCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 19:26:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9q5L-00054n-8T; Fri, 17 Oct 2025 15:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1v9q5I-00053e-Gk; Fri, 17 Oct 2025 15:25:52 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1v9q5F-00008g-PE; Fri, 17 Oct 2025 15:25:52 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9B2775972F0;
 Fri, 17 Oct 2025 21:25:43 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id GZFqDvT-Gct3; Fri, 17 Oct 2025 21:25:41 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8E9A25972EF; Fri, 17 Oct 2025 21:25:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8BC745972E9;
 Fri, 17 Oct 2025 21:25:41 +0200 (CEST)
Date: Fri, 17 Oct 2025 21:25:41 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Vishal Chourasia <vishalc@linux.ibm.com>
cc: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com, 
 npiggin@gmail.com, peter.maydell@linaro.org, alistair23@gmail.com, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, berrange@redhat.com, 
 richard.henderson@linaro.org, alistair@alistair23.me, 
 alex.bennee@linaro.org, deller@gmx.de, pbonzini@redhat.com, 
 eduardo@habkost.net, minyard@acm.org, gaosong@loongson.cn, 
 maobibo@loongson.cn, laurent@vivier.eu, edgar.iglesias@gmail.com, 
 hpoussin@reactos.org, david@redhat.com, chigot@adacore.com, 
 konrad.frederic@yahoo.fr, atar4qemu@gmail.com, jcmvbkbc@gmail.com
Subject: Re: [Patch v4 1/5] hw/core/loader: capture Error from
 load_image_targphys
In-Reply-To: <20251017181250.1421446-4-vishalc@linux.ibm.com>
Message-ID: <0026ec98-fa2b-7bf2-e40e-b8938b4f8c6f@eik.bme.hu>
References: <20251017181250.1421446-2-vishalc@linux.ibm.com>
 <20251017181250.1421446-4-vishalc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 17 Oct 2025, Vishal Chourasia wrote:
> Add Error **errp parameter to load_image_targphys(),
> load_image_targphys_as(), and get_image_size() to enable better
> error reporting when image loading fails.
>
> Pass NULL for errp in all existing call sites to maintain current
> behavior. No functional change intended in this patch.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> ---
> hw/alpha/dp264.c         |  4 ++--
> hw/arm/armv7m.c          |  2 +-
> hw/arm/boot.c            |  5 +++--
> hw/arm/digic_boards.c    |  2 +-
> hw/arm/highbank.c        |  3 ++-
> hw/arm/raspi.c           |  2 +-
> hw/arm/vexpress.c        |  2 +-
> hw/core/generic-loader.c |  3 ++-
> hw/core/guest-loader.c   |  2 +-
> hw/core/loader.c         | 40 ++++++++++++++++++++++++++++++++--------
> hw/hppa/machine.c        |  5 +++--
> hw/i386/multiboot.c      |  2 +-
> hw/i386/x86-common.c     |  4 ++--
> hw/ipmi/ipmi_bmc_sim.c   |  2 +-
> hw/loongarch/boot.c      |  5 ++---
> hw/m68k/an5206.c         |  2 +-
> hw/m68k/mcf5208.c        |  4 ++--
> hw/m68k/next-cube.c      |  2 +-
> hw/m68k/q800.c           |  7 ++++---
> hw/m68k/virt.c           |  4 ++--
> hw/microblaze/boot.c     |  5 +++--
> hw/mips/boston.c         |  2 +-
> hw/mips/fuloong2e.c      |  9 +++++----
> hw/mips/jazz.c           |  2 +-
> hw/mips/loongson3_virt.c | 10 ++++++----
> hw/mips/malta.c          |  9 +++++----
> hw/nubus/nubus-device.c  |  2 +-
> hw/openrisc/boot.c       |  5 +++--
> hw/pci/pci.c             |  2 +-
> hw/ppc/amigaone.c        |  4 ++--
> hw/ppc/e500.c            |  5 +++--
> hw/ppc/mac_newworld.c    |  9 ++++++---
> hw/ppc/mac_oldworld.c    |  9 ++++++---
> hw/ppc/pegasos2.c        |  5 +++--
> hw/ppc/pnv.c             |  9 ++++++---
> hw/ppc/ppc440_bamboo.c   |  3 ++-
> hw/ppc/prep.c            |  8 +++++---
> hw/ppc/sam460ex.c        |  3 ++-
> hw/ppc/spapr.c           |  8 ++++----
> hw/ppc/virtex_ml507.c    |  5 +++--
> hw/riscv/boot.c          |  7 ++++---
> hw/rx/rx-gdbsim.c        |  2 +-
> hw/s390x/ipl.c           |  8 +++++---
> hw/sh4/r2d.c             |  8 +++++---
> hw/smbios/smbios.c       |  2 +-
> hw/sparc/leon3.c         |  4 ++--
> hw/sparc/sun4m.c         |  8 +++++---
> hw/sparc64/sun4u.c       |  7 ++++---
> hw/xtensa/xtfpga.c       |  3 ++-
> include/hw/loader.h      |  8 +++++---
> system/device_tree.c     |  2 +-
> 51 files changed, 168 insertions(+), 107 deletions(-)
[...]

> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 477661a025..e40cba1b9f 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -48,6 +48,7 @@
> #include "qapi/error.h"
> #include "qapi/qapi-commands-machine.h"
> #include "qapi/type-helpers.h"
> +#include "qemu/units.h"
> #include "trace.h"
> #include "hw/hw.h"
> #include "disas/disas.h"
> @@ -61,23 +62,31 @@
> #include "hw/nvram/fw_cfg.h"
> #include "system/memory.h"
> #include "hw/boards.h"
> +#include "qapi/error.h"
> #include "qemu/cutils.h"
> #include "system/runstate.h"
> #include "tcg/debuginfo.h"
>
> +#include <errno.h>
> #include <zlib.h>
>
> static int roms_loaded;
>
> /* return the size or -1 if error */
> -int64_t get_image_size(const char *filename)
> +int64_t get_image_size(const char *filename, Error **errp)
> {
>     int fd;
>     int64_t size;
>     fd = open(filename, O_RDONLY | O_BINARY);
> -    if (fd < 0)
> +    if (fd < 0) {
> +        error_setg_file_open(errp, errno, filename);
>         return -1;
> +    }
>     size = lseek(fd, 0, SEEK_END);
> +    if (size < 0) {
> +        error_setg_errno(errp, errno, "lseek failure: %s", filename);
> +        return -1;
> +    }
>     close(fd);
>     return size;
> }
> @@ -118,23 +127,38 @@ ssize_t read_targphys(const char *name,
> }
>
> ssize_t load_image_targphys(const char *filename,
> -                            hwaddr addr, uint64_t max_sz)
> +                            hwaddr addr, uint64_t max_sz, Error **errp)
> {
> -    return load_image_targphys_as(filename, addr, max_sz, NULL);
> +    return load_image_targphys_as(filename, addr, max_sz, NULL, errp);
> }
>
> /* return the size or -1 if error */
> ssize_t load_image_targphys_as(const char *filename,
> -                               hwaddr addr, uint64_t max_sz, AddressSpace *as)
> +                               hwaddr addr, uint64_t max_sz, AddressSpace *as,
> +                               Error **errp)
> {
> +    ERRP_GUARD();
>     ssize_t size;
>
> -    size = get_image_size(filename);
> -    if (size < 0 || size > max_sz) {
> +    size = get_image_size(filename, errp);
> +    if (*errp) {
>         return -1;
>     }
> +
> +    if (size == 0) {
> +        error_setg(errp, "empty file");
> +        return -1;
> +    }
> +
> +    if (size > max_sz) {
> +        error_setg(errp, "%s exceeds maximum image size (%" PRIu64 " MiB)",
> +                   filename, (long unsigned int) max_sz / MiB);
> +        return -1;
> +    }
> +
>     if (size > 0) {
>         if (rom_add_file_fixed_as(filename, addr, -1, as) < 0) {
> +            error_setg(errp, "failed to add file as ROM");
>             return -1;

These in this file are functional changes adding new messages so that 
contradicts the commmit message and maybe should be in its own patch for 
easier review.

Regards,
BALATON Zoltan


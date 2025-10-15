Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE02CCD192
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 14:04:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v925n-0003w4-1w; Wed, 15 Oct 2025 10:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v925k-0003vp-5a
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:03:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v925W-0000TD-GC
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:02:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760536959;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=IA8AKUcn49ztg7Gyot0B/WhQlo+lv9AMOj/jqA3nArU=;
 b=iNxwAkMTYjjuSeo58GtT+9pNqFCqXhq3RMcnLkvDp0isjGnFTuFyg7Z/vmdCnCBhQqqQjm
 s6YnqszPbQvG2BWdbj0nc3VKGTr3hsrugSROKlsDPCxX8v+uG76RX4ddJsXS4l9kMPzMMF
 sC9u8/pTrUS/RNpSb4p7XkXNjCLIiD4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-lBuxfhDsOh2x01mIfM_wgQ-1; Wed,
 15 Oct 2025 10:02:35 -0400
X-MC-Unique: lBuxfhDsOh2x01mIfM_wgQ-1
X-Mimecast-MFC-AGG-ID: lBuxfhDsOh2x01mIfM_wgQ_1760536953
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 295181805C06; Wed, 15 Oct 2025 14:02:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 871D819540DB; Wed, 15 Oct 2025 14:02:30 +0000 (UTC)
Date: Wed, 15 Oct 2025 15:02:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Subject: Re: [PATCH v2] hw/ppc/pnv: Improve kernel/initrd load failure error
 messages
Message-ID: <aO-pc3Qgi9tmr1JZ@redhat.com>
References: <20251015134716.1099351-2-vishalc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251015134716.1099351-2-vishalc@linux.ibm.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Oct 15, 2025 at 07:17:17PM +0530, Vishal Chourasia wrote:
> When QEMU fails to load the kernel or initrd image, it previously emitted
> a generic error message such as:
> 
>   qemu-system-ppc64: Could not load kernel 'vmlinux'
> 
> This provides little context on why the failure occurred, which can make
> debugging difficult, especially for new users or when dealing with large
> images.
> 
> The new messages also include the configured size limits (in MiB) to help
> users verify that their image files are within acceptable bounds.
> 
> [v1] https://lore.kernel.org/all/20251007091214.403430-2-vishalc@linux.ibm.com/
> 
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> ---
>  hw/alpha/dp264.c         |  4 ++--
>  hw/arm/armv7m.c          |  2 +-
>  hw/arm/boot.c            |  5 +++--
>  hw/arm/digic_boards.c    |  2 +-
>  hw/arm/highbank.c        |  3 ++-
>  hw/arm/raspi.c           |  2 +-
>  hw/arm/vexpress.c        |  2 +-
>  hw/core/generic-loader.c |  7 ++++---
>  hw/core/guest-loader.c   |  6 +++---
>  hw/core/loader.c         | 32 ++++++++++++++++++++++++--------
>  hw/hppa/machine.c        |  5 +++--
>  hw/i386/multiboot.c      |  2 +-
>  hw/i386/x86-common.c     |  4 ++--
>  hw/ipmi/ipmi_bmc_sim.c   |  2 +-
>  hw/loongarch/boot.c      |  5 ++---
>  hw/m68k/an5206.c         |  2 +-
>  hw/m68k/mcf5208.c        |  4 ++--
>  hw/m68k/next-cube.c      |  2 +-
>  hw/m68k/q800.c           |  7 ++++---
>  hw/m68k/virt.c           |  4 ++--
>  hw/microblaze/boot.c     |  5 +++--
>  hw/mips/boston.c         |  2 +-
>  hw/mips/fuloong2e.c      |  9 +++++----
>  hw/mips/jazz.c           |  2 +-
>  hw/mips/loongson3_virt.c | 10 ++++++----
>  hw/mips/malta.c          |  9 +++++----
>  hw/nubus/nubus-device.c  |  2 +-
>  hw/openrisc/boot.c       |  5 +++--
>  hw/pci/pci.c             |  2 +-
>  hw/ppc/amigaone.c        |  4 ++--
>  hw/ppc/e500.c            |  5 +++--
>  hw/ppc/mac_newworld.c    |  9 ++++++---
>  hw/ppc/mac_oldworld.c    |  9 ++++++---
>  hw/ppc/pegasos2.c        |  5 +++--
>  hw/ppc/pnv.c             | 22 +++++++++++++---------
>  hw/ppc/ppc440_bamboo.c   |  3 ++-
>  hw/ppc/prep.c            |  8 +++++---
>  hw/ppc/sam460ex.c        |  3 ++-
>  hw/ppc/spapr.c           |  5 +++--
>  hw/ppc/virtex_ml507.c    |  5 +++--
>  hw/riscv/boot.c          |  7 ++++---
>  hw/rx/rx-gdbsim.c        |  2 +-
>  hw/s390x/ipl.c           |  8 +++++---
>  hw/sh4/r2d.c             |  8 +++++---
>  hw/smbios/smbios.c       |  2 +-
>  hw/sparc/leon3.c         |  4 ++--
>  hw/sparc/sun4m.c         |  8 +++++---
>  hw/sparc64/sun4u.c       |  7 ++++---
>  hw/xtensa/xtfpga.c       |  3 ++-
>  include/hw/loader.h      |  8 +++++---
>  system/device_tree.c     |  2 +-
>  51 files changed, 170 insertions(+), 115 deletions(-)
> 

> diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
> index e72bbde2a2..8cf5aadf1f 100644
> --- a/hw/core/generic-loader.c
> +++ b/hw/core/generic-loader.c
> @@ -148,13 +148,14 @@ static void generic_loader_realize(DeviceState *dev, Error **errp)
>  
>          if (size < 0 || s->force_raw) {
>              /* Default to the maximum size being the machine's ram size */
> -            size = load_image_targphys_as(s->file, s->addr, current_machine->ram_size, as);
> +            size = load_image_targphys_as(s->file, s->addr,
> +                    current_machine->ram_size, as, errp);
>          } else {
>              s->addr = entry;
>          }
>  
> -        if (size < 0) {
> -            error_setg(errp, "Cannot load specified image %s", s->file);
> +        if (*errp || size < 0) {

We should not have to check both *errp and 'size < 0'.

We must ensure that every code path in 'load_image_targphys_as' that can
return -1, will *always* fills in 'errp', so that callers can be sure
that *errp is always non-NULL on failure.

> +            error_reportf_err(*errp, "Cannot load specified image %s", s->file);

This method is propagating the error to the caller in its 'errp'
parameter, so it is wrong to call error_reportf_err. The latter
should only be used at the final point in the callstack which
owns the 'Error' parameter.

The only change in this method should be to remove the existing
error_setg call.

>              return;
>          }
>      }

> diff --git a/hw/core/guest-loader.c b/hw/core/guest-loader.c
> index 3db89d7a2e..d4f749fd6e 100644
> --- a/hw/core/guest-loader.c
> +++ b/hw/core/guest-loader.c
> @@ -101,9 +101,9 @@ static void guest_loader_realize(DeviceState *dev, Error **errp)
>  
>      /* Default to the maximum size being the machine's ram size */
>      size = load_image_targphys_as(file, s->addr, current_machine->ram_size,
> -                                  NULL);
> -    if (size < 0) {
> -        error_setg(errp, "Cannot load specified image %s", file);
> +                                  NULL, errp);
> +    if (*errp || size < 0) {
> +        error_reportf_err(*errp, "Cannot load specified image %s", file);
>          return;

Again must not be calling error_reportf_err nor chcking *errp,
just remove error_setg().

>      }
>  
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 477661a025..d8c02786d2 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -48,6 +48,7 @@
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-machine.h"
>  #include "qapi/type-helpers.h"
> +#include "qemu/units.h"
>  #include "trace.h"
>  #include "hw/hw.h"
>  #include "disas/disas.h"
> @@ -61,23 +62,31 @@
>  #include "hw/nvram/fw_cfg.h"
>  #include "system/memory.h"
>  #include "hw/boards.h"
> +#include "qapi/error.h"
>  #include "qemu/cutils.h"
>  #include "system/runstate.h"
>  #include "tcg/debuginfo.h"
>  
> +#include <errno.h>
>  #include <zlib.h>
>  
>  static int roms_loaded;
>  
>  /* return the size or -1 if error */
> -int64_t get_image_size(const char *filename)
> +int64_t get_image_size(const char *filename, Error **errp)
>  {
>      int fd;
>      int64_t size;
>      fd = open(filename, O_RDONLY | O_BINARY);
> -    if (fd < 0)
> +    if (fd < 0) {
> +        error_setg_file_open(errp, errno, filename);
>          return -1;
> +    }

This perhaps ought to be changed to call 'qemu_open' which
already fills in an Error object, and additionally protects
the fd with O_CLOEXEC and handles FD passing with /dev/fdset

>      size = lseek(fd, 0, SEEK_END);
> +    if (size < 0) {
> +        error_setg_errno(errp, errno, "lseek failure");
> +        return -1;
> +    }
>      close(fd);
>      return size;
>  }
> @@ -118,21 +127,28 @@ ssize_t read_targphys(const char *name,
>  }
>  
>  ssize_t load_image_targphys(const char *filename,
> -                            hwaddr addr, uint64_t max_sz)
> +                            hwaddr addr, uint64_t max_sz, Error **errp)
>  {
> -    return load_image_targphys_as(filename, addr, max_sz, NULL);
> +    return load_image_targphys_as(filename, addr, max_sz, NULL, errp);
>  }
>  
>  /* return the size or -1 if error */
>  ssize_t load_image_targphys_as(const char *filename,
> -                               hwaddr addr, uint64_t max_sz, AddressSpace *as)
> +                               hwaddr addr, uint64_t max_sz, AddressSpace *as,
> +                               Error **errp)
>  {
>      ssize_t size;
>  
> -    size = get_image_size(filename);
> -    if (size < 0 || size > max_sz) {
> +    size = get_image_size(filename, errp);
> +    if (*errp || size < 0) {

Must not chck *errp, only 'size < 0'.

>          return -1;
>      }
> +
> +    if (size > max_sz) {
> +        error_setg(errp, "Exceeds maximum image size (%lu MiB)", max_sz / MiB);
> +        return -1;
> +    }
> +
>      if (size > 0) {
>          if (rom_add_file_fixed_as(filename, addr, -1, as) < 0) {
>              return -1;
> @@ -150,7 +166,7 @@ ssize_t load_image_mr(const char *filename, MemoryRegion *mr)
>          return -1;
>      }
>  
> -    size = get_image_size(filename);
> +    size = get_image_size(filename, NULL);
>  
>      if (size < 0 || size > memory_region_size(mr)) {
>          return -1;


I'd suggest that we add the Error parameter in one patch, making every
caller pass NULL. Then a second patch update the callers to pass a
non-NULL errp and use error_report_err to print details, ideally  for
more than just the 1 ppc source file. 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



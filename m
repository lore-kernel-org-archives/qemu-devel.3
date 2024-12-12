Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F30E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 17:40:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLnB4-0008NV-1J; Thu, 12 Dec 2024 12:40:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tLnAt-0008N1-6M
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 12:40:32 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tLnAm-0002oY-FP
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 12:40:27 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Y8KQz3vhrz6K99S;
 Fri, 13 Dec 2024 01:36:59 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 45CB2140A86;
 Fri, 13 Dec 2024 01:40:19 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 12 Dec
 2024 18:40:18 +0100
Date: Thu, 12 Dec 2024 17:40:16 +0000
To: Gregory Price <gourry@gourry.net>
CC: <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>,
 <svetly.todorov@memverge.com>, <nifan.cxl@gmail.com>
Subject: Re: [PATCH RFC v3 3/3] mhsld: implement MHSLD device
Message-ID: <20241212174016.0000002a@huawei.com>
In-Reply-To: <20241018161252.8896-4-gourry@gourry.net>
References: <20241018161252.8896-1-gourry@gourry.net>
 <20241018161252.8896-4-gourry@gourry.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Fri, 18 Oct 2024 12:12:52 -0400
Gregory Price <gourry@gourry.net> wrote:

> From: Svetly Todorov <svetly.todorov@memverge.com>
> 
> Using a shared-memory bytemap, validates that DC adds, releases,
> and reclamations happen on extents belonging to the appropriate
> host.
> 
> The MHSLD device inherits from the CXL_TYPE3 class and adds the following
> configuration options:

As in previous the -- syntax is somewhat confusing as that's
not how the parameters are applied.

> --mhd-head=<u32>
> --mhd-state_file=<str>
> --mhd-init=<bool>
> 
> --mhd-head specifies the head ID of the host on the given device.
> 
> --mhd-state_file is the name of the shared-memory-backed file used
> to store the MHD state.
> 
> --mhd-init indicates whether this QEMU instance should initialize
> the state_file; if so, the instance will create the file if it does
> not exist, ftruncate it to the appropriate size, and initialize its
> header. It is assumed that the --mhd-init instance is run and allowed
> to completely finish configuration before any other guests access the
> shared state.
> 
> The shared state file only needs to be intialized once. Even if a guest
> dies without clearing the ownership bits associated with its head-ID,
> future guests with that ID will clear those bits in cxl_mhsld_realize(),
> regardless of whether mhd_init is true or false.

That sounds like a race condition if not all hosts are brought
up before the first add.

> 
> The following command line options create an MHSLD with 4GB of
> backing memory, whose state is tracked in /dev/shm/mhd_metadata.
> --mhd-init=true tells this instance to initialize the state as
> described above.
> 
> ./qemu-system_x86-64 \
> [... other options ...] \
> -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 \
> -device cxl-rp,id=rp0,bus=cxl.0,chassis=0,port=0,slot=0 \
> -object memory-backend-ram,id=mem0,size=4G \
> -device cxl-mhsld,bus=rp0,num-dc-regions=1,volatile-dc-memdev=mem0,id=cxl-mem0,sn=66667,mhd-head=0,mhd-state_file=mhd_metadata,mhd-init=true \
> -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=4G \
> -qmp unix:/tmp/qmp-sock-1,server,nowait
> 
> Once this guest completes setup, other guests looking to access the
> device can be booted with the same configuration options, but with
> --mhd-head != 0,
> --mhd-init=false,
> and a different QMP socket.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Svetly Todorov <svetly.todorov@memverge.com>

A few trivial things inline.

In general the scheme looks workable but I'm not sure the contraints at setup time
etc are suitable for an upstream solution.  Certainly a useful tool to have
for kernel development though so I'll try and find time in next few days to apply
this on my gitlab tree.

Longer term I think we need a more complex external program or a main / proxy
type arrangement so that ordering requirements can be enforce and we can have
richer info.  Having to chat to each qmp interface independently works fine is
also a bit more complex than I think we would eventually want.

Having a solution in place though will make it much easier to move towards
an eventual upstreamable solution. This is a great place to start from!

Jonathan

> +static bool cxl_mhsld_release_extent(PCIDevice *d, uint64_t dpa, uint64_t len)
> +{
> +    cxl_mhsld_state_clear(CXL_MHSLD(d), dpa / MHSLD_BLOCK_SZ,
> +        len / MHSLD_BLOCK_SZ);

Trivial but align after (

> +    return true;
> +}


> diff --git a/hw/cxl/mhsld/mhsld.h b/hw/cxl/mhsld/mhsld.h
> new file mode 100644
> index 0000000000..e7ead1f0d2
> --- /dev/null
> +++ b/hw/cxl/mhsld/mhsld.h
> @@ -0,0 +1,75 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Copyright (c) 2024 MemVerge Inc.
> + *
> + */
> +
> +#ifndef CXL_MHSLD_H
> +#define CXL_MHSLD_H
> +#include <stdint.h>
> +#include "hw/cxl/cxl.h"
> +#include "hw/cxl/cxl_mailbox.h"
> +#include "hw/cxl/cxl_device.h"
> +#include "qemu/units.h"
> +
> +#define MHSLD_BLOCK_SZ (2 * MiB)
> +
> +/*
> + * We limit the number of heads to prevent the shared state
> + * region from becoming a major memory hog.  We need 512MB of
> + * memory space to track 8-host ownership of 4GB of memory in
> + * blocks of 2MB.  This can change if the block size is increased.

I'm lost what makes up that size?


 
> + */
> +#define MHSLD_HEADS  (8)
> +
> +/*
> + * The shared state cannot have 2 variable sized regions
> + * so we have to max out the ldmap.
> + */
> +typedef struct MHSLDSharedState {
> +    uint8_t nr_heads;
> +    uint8_t nr_lds;
> +    uint8_t ldmap[MHSLD_HEADS];
> +    uint64_t nr_blocks;
> +    uint8_t blocks[];
> +} MHSLDSharedState;
> +
> +struct CXLMHSLDState {
> +    CXLType3Dev ct3d;
> +    bool mhd_init;
> +    char *mhd_state_file;
> +    int mhd_state_fd;
> +    size_t mhd_state_size;
> +    uint32_t mhd_head;
> +    MHSLDSharedState *mhd_state;
> +};
> +
> +struct CXLMHSLDClass {
> +    CXLType3Class parent_class;
> +};
> +
> +enum {
> +    MHSLD_MHD = 0x55,
> +        #define GET_MHD_INFO 0x0
> +};
> +
> +/*
> + * MHD Get Info Command
> + * Returns information the LD's associated with this head
> + */
> +typedef struct MHDGetInfoInput {
> +    uint8_t start_ld;
> +    uint8_t ldmap_len;
> +} QEMU_PACKED MHDGetInfoInput;
> +
> +typedef struct MHDGetInfoOutput {
> +    uint8_t nr_lds;
> +    uint8_t nr_heads;
> +    uint16_t resv1;
> +    uint8_t start_ld;
> +    uint8_t ldmap_len;
> +    uint16_t resv2;
> +    uint8_t ldmap[];
> +} QEMU_PACKED MHDGetInfoOutput;
> +#endif



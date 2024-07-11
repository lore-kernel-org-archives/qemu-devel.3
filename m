Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD63BC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 17:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRxTo-0004S9-Vy; Thu, 11 Jul 2024 13:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=SBUb=OL=kaod.org=clg@ozlabs.org>)
 id 1sRxTm-0004Qw-DA; Thu, 11 Jul 2024 13:21:14 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=SBUb=OL=kaod.org=clg@ozlabs.org>)
 id 1sRxTj-0003Hx-Ni; Thu, 11 Jul 2024 13:21:14 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WKhMg5rk9z4wxk;
 Fri, 12 Jul 2024 03:21:03 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WKhMd3v46z4wnx;
 Fri, 12 Jul 2024 03:21:01 +1000 (AEST)
Message-ID: <bb348910-c1d8-48b7-a06d-c2f7621b0d58@kaod.org>
Date: Thu, 11 Jul 2024 19:20:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/18] ppc/pnv: Better big-core model, lpar-per-core, PC
 unit
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
References: <20240711141851.406677-1-npiggin@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240711141851.406677-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=SBUb=OL=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Nick,

On 7/11/24 16:18, Nicholas Piggin wrote:
> Primary motivation for this series is to improve big-core support.
> 
> This also fixes POWER8 SMT running Linux with the msgsnd fix and
> setting lpar-per-core mode (which is always true on POWER8).

It does. I gave a try to the powernv8 machine with :

  -smp 8,sockets=1,cores=1,threads=8
  -smp 8,sockets=1,cores=2,threads=4
  -smp 8,sockets=1,cores=4,threads=2
  -smp 8,sockets=1,cores=8,threads=1

and

  -smp 16,sockets=1,cores=2,threads=8
  -smp 16,sockets=1,cores=4,threads=4
  -smp 16,sockets=2,cores=8,threads=1

So,

Tested-by: Cédric Le Goater <clg@redhat.com>

However there is an issue with smt on multisocket. CPU hang. I guess
POWER8 is not a priority.

It would be good to improve slightly the models with properties. slightly,
because I don't think adding the "big-core" and "lpar-per-core" properties
to the chip and the core are much work. I am (nearly) sure it will remove
a few lines of code ! Anyhow, this is not a blocker and I hope we can merge
these improvements for 9.1 [*]

One thing we could do also is deprecate the POWER8NVL and POWER8E chips in
the 9.1 cycle.

Thanks,

C.
  
[*] the SPI model and ADU, LPC PSI serirq also. I haven't seen any
     updates for PHB and XIVE,


> 
> I think I accounted for all feedback from Cedric and Harsh from the
> last RFC (except a couple of style suggestions from Harsh).
> 
> Since rfc:
> - Fixed POWER8 SMT so it doesn't have to be disabled.
> - Fixed inadvertent spapr SMT bug.
> - Renamed PnvCPUState.core pointer to pnv_core. (Harsh)
> - Moved where it is initialised (clg)
> - Avoided most qdev_get_machine() calls by adding a PnvMachineState
>    pointer from PnvChip, new patch 3 (clg).
> - Rename TB state to use camel case (Harsh and clg)
> - Add comment to explain SPRC/SPRD is only accessed with powernv.
> - Use mc->desc for error messages and avoid splitting machine init
>    handlers (Harsh).
> - Add max_smt_threads class attribute to avoid duplicating checks (clg)
> - Rename processor_id() class method to get_pir_tir (Harsh and clg)
> - Add a comment for get_pir_tir() (clg)
> - Allow get_pir_tir() to be passed NULL pointers to avoid dummy
>    pir/tir variables (Harsh)
> - Move the PPC_CPU_HAS_CORE_SIBLINGS macros to inline functions (clg)
> - Invert them (test for single-thread rather than for siblings)
>    because the callers read a little better that way (Harsh).
> - Propagate lpar and big-core options down to chip and core
>    levels rather than having to test machine (clg)
> - Significantly split the big-core patch (clg).
> - Rework big-core device-tree handling to simplify it (clg).
> - Make new has_smt_siblings property bool (Harsh)
> - Make the big-core timebase tod quirk a machine class property
>    rather than machine state (Harsh).
> 
> Thanks,
> Nick
> 
> Nicholas Piggin (18):
>    target/ppc: Fix msgsnd for POWER8
>    ppc/pnv: Add pointer from PnvCPUState to PnvCore
>    ppc/pnv: Add a pointer from PnvChip to PnvMachineState
>    ppc/pnv: Move timebase state into PnvCore
>    target/ppc: Move SPR indirect registers into PnvCore
>    ppc/pnv: specialise init for powernv8/9/10 machines
>    ppc/pnv: Extend chip_pir class method to TIR as well
>    ppc: Add a core_index to CPUPPCState for SMT vCPUs
>    target/ppc: Add helpers to check for SMT sibling threads
>    ppc: Add has_smt_siblings property to CPUPPCState
>    ppc/pnv: Add a big-core mode that joins two regular cores
>    ppc/pnv: Add allow for big-core differences in DT generation
>    ppc/pnv: Implement big-core PVR for Power9/10
>    ppc/pnv: Implement Power9 CPU core thread state indirect register
>    ppc/pnv: Add POWER10 ChipTOD quirk for big-core
>    ppc/pnv: Add big-core machine property
>    ppc/pnv: Implement POWER10 PC xscom registers for direct controls
>    ppc/pnv: Add an LPAR per core machine option
> 
>   include/hw/core/cpu.h        |   8 +
>   include/hw/ppc/pnv.h         |   7 +
>   include/hw/ppc/pnv_chip.h    |   6 +-
>   include/hw/ppc/pnv_core.h    |  31 ++++
>   target/ppc/cpu.h             |  41 ++---
>   hw/ppc/pnv.c                 | 298 ++++++++++++++++++++++++++++-------
>   hw/ppc/pnv_chiptod.c         |   7 +-
>   hw/ppc/pnv_core.c            | 130 +++++++++++++--
>   hw/ppc/spapr_cpu_core.c      |  16 +-
>   system/cpus.c                |  10 ++
>   target/ppc/cpu_init.c        |  26 +--
>   target/ppc/excp_helper.c     |  69 ++++----
>   target/ppc/misc_helper.c     | 104 ++++++------
>   target/ppc/timebase_helper.c |  82 +++++-----
>   14 files changed, 601 insertions(+), 234 deletions(-)
> 



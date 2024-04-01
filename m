Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 159C8CD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 08:26:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrCzI-0007Lq-4t; Mon, 01 Apr 2024 04:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=nmE/=LG=kaod.org=clg@ozlabs.org>)
 id 1rrCzF-0007II-94
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 04:25:49 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=nmE/=LG=kaod.org=clg@ozlabs.org>)
 id 1rrCzD-0000dR-77
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 04:25:49 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4V7PGV07jGz4wcs;
 Mon,  1 Apr 2024 19:25:38 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4V7PGS08dCz4wcF;
 Mon,  1 Apr 2024 19:25:35 +1100 (AEDT)
Message-ID: <c671fb5a-18d7-4c3a-beec-ad3f28114986@kaod.org>
Date: Mon, 1 Apr 2024 10:25:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] P11 support for QEMU
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20240401055503.1880587-1-adityag@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240401055503.1880587-1-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=nmE/=LG=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
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

Hello Aditya,

Please run ./scripts/get_maintainer.pl when sending a series. qemu-ppc should be
in Cc:

Briefly looking at this, please separate the changes using one patch per model,
that is : first CPU (target), LPC, OCC, PSI, SBE, PnvCore, SpaprCore. Last the
PnvChip and the machines, powernv11 and pseries. A minimum commit log describing
the HW is required. I don't see PHB6 or XIVE3. Why ?

Also, you will need an OPAL update. The above changes are pointless without it.
The minimum for now is a git commit from the opal repo, then you will need to
update QEMU with a binary.

Thanks,

C.

On 4/1/24 07:55, Aditya Gupta wrote:
> This patch series adds support for Power11 pseries and powernv machine targets
> to emulate VMs running on Power11.
> 
> Most of the P11 support code has been taken from P10 code in QEMU.
> And has been tested in pseries, powernv, with and without compat mode.
> 
> Git Tree for Testing: https://github.com/adi-g15-ibm/qemu/tree/p11
> 
> Aditya Gupta (2):
>    ppc: pseries: add P11 cpu type
>    ppc: powernv11: add base support for P11 PowerNV
> 
>   docs/system/ppc/pseries.rst |   6 +-
>   hw/ppc/pnv.c                | 409 ++++++++++++++++++++++++++++++++++++
>   hw/ppc/pnv_core.c           |  94 +++++++++
>   hw/ppc/pnv_homer.c          |  64 ++++++
>   hw/ppc/pnv_lpc.c            |  14 ++
>   hw/ppc/pnv_occ.c            |  14 ++
>   hw/ppc/pnv_psi.c            |  21 ++
>   hw/ppc/pnv_sbe.c            |  19 ++
>   hw/ppc/spapr_cpu_core.c     |   1 +
>   include/hw/ppc/pnv.h        |  51 +++++
>   include/hw/ppc/pnv_chip.h   |  30 +++
>   include/hw/ppc/pnv_homer.h  |   3 +
>   include/hw/ppc/pnv_lpc.h    |   4 +
>   include/hw/ppc/pnv_occ.h    |   2 +
>   include/hw/ppc/pnv_psi.h    |   2 +
>   include/hw/ppc/pnv_sbe.h    |   2 +
>   include/hw/ppc/pnv_xscom.h  |  55 +++++
>   target/ppc/compat.c         |   7 +
>   target/ppc/cpu-models.c     |   2 +
>   target/ppc/cpu-models.h     |   2 +
>   target/ppc/cpu_init.c       | 162 ++++++++++++++
>   21 files changed, 961 insertions(+), 3 deletions(-)
> 



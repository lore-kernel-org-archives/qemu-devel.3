Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C14CC27C53
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 02:30:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK7ZM-0005me-B1; Wed, 19 Jun 2024 22:30:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1sK7ZK-0005kt-RL; Wed, 19 Jun 2024 22:30:34 -0400
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1sK7ZI-0003wz-PM; Wed, 19 Jun 2024 22:30:34 -0400
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
 by Atcsqr.andestech.com with ESMTP id 45K2UBwp096336;
 Thu, 20 Jun 2024 10:30:11 +0800 (+08)
 (envelope-from ethan84@andestech.com)
Received: from ethan84-VirtualBox (10.0.12.12) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server id 14.3.498.0; Thu, 20 Jun 2024
 10:30:07 +0800
Date: Thu, 20 Jun 2024 10:30:06 +0800
To: Stefan Weil <sw@weilnetz.de>
CC: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>, <palmer@dabbelt.com>,
 <alistair.francis@wdc.com>, <bmeng.cn@gmail.com>,
 <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, <qemu-riscv@nongnu.org>
Subject: Re: [PATCH v7 1/2] hw/misc/riscv_iopmp: Add RISC-V IOPMP device
Message-ID: <ZnOULg2sd7YZHFQi@ethan84-VirtualBox>
References: <20240612031706.2927602-1-ethan84@andestech.com>
 <20240612031706.2927602-2-ethan84@andestech.com>
 <8def1779-6fc8-4e53-9542-20fe83651c0b@weilnetz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8def1779-6fc8-4e53-9542-20fe83651c0b@weilnetz.de>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Originating-IP: [10.0.12.12]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 45K2UBwp096336
Received-SPF: pass client-ip=60.248.80.70; envelope-from=ethan84@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, RDNS_DYNAMIC=0.982,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, TVD_RCVD_IP=0.001,
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
Reply-to:  Ethan Chen <ethan84@andestech.com>
From:  Ethan Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jun 17, 2024 at 02:09:34PM +0200, Stefan Weil wrote:
> [EXTERNAL MAIL]
> 
> Am 12.06.24 um 05:17 schrieb Ethan Chen via:
> > Support basic functions of IOPMP specification v0.9.1 rapid-k model.
> > The specification url:
> > https://github.com/riscv-non-isa/iopmp-spec/releases/tag/v0.9.1
> > 
> > IOPMP check memory access from device is valid or not. This implementation uses
> > IOMMU to change address space that device access. There are three possible
> > results of an access: valid, blocked, and stalled(stall is not supported in this
> >   patch).
> > 
> > If an access is valid, target address space is downstream_as.
> > If an access is blocked, it will go to blocked_io_as. The operation of
> > blocked_io_as could be a bus error, or it can respond a success with fabricated
> > data depending on IOPMP ERR_CFG register value.
> > 
> > Signed-off-by: Ethan Chen <ethan84@andestech.com>
> > ---
> >   hw/misc/Kconfig               |    3 +
> >   hw/misc/meson.build           |    1 +
> >   hw/misc/riscv_iopmp.c         | 1002 +++++++++++++++++++++++++++++++++
> >   hw/misc/trace-events          |    4 +
> >   include/hw/misc/riscv_iopmp.h |  152 +++++
> >   5 files changed, 1162 insertions(+)
> >   create mode 100644 hw/misc/riscv_iopmp.c
> >   create mode 100644 include/hw/misc/riscv_iopmp.h
> 
> Should both new files have SPDX license identifiers?
> 
> Regards,
> Stefan W.

Thank you for the reminder, I will add them.

Thanks,
Ethan


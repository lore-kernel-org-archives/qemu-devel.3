Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5E8C52D71
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 09:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scMNC-0006u8-GB; Fri, 09 Aug 2024 05:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1scMNA-0006qs-0r; Fri, 09 Aug 2024 05:57:24 -0400
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1scMN5-0003dQ-Iw; Fri, 09 Aug 2024 05:57:23 -0400
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
 by Atcsqr.andestech.com with ESMTPS id 4799uwE5025566
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 9 Aug 2024 17:56:58 +0800 (+08)
 (envelope-from ethan84@andestech.com)
Received: from ethan84-VirtualBox (10.0.12.12) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 9 Aug 2024
 17:56:59 +0800
Date: Fri, 9 Aug 2024 17:56:58 +0800
To: Alistair Francis <alistair23@gmail.com>
CC: <qemu-devel@nongnu.org>, <richard.henderson@linaro.org>,
 <pbonzini@redhat.com>, <peterx@redhat.com>, <david@redhat.com>,
 <philmd@linaro.org>, <palmer@dabbelt.com>, <alistair.francis@wdc.com>,
 <bmeng.cn@gmail.com>, <liwei1518@gmail.com>,
 <dbarboza@ventanamicro.com>, <zhiwei_liu@linux.alibaba.com>,
 <qemu-riscv@nongnu.org>
Subject: Re: [PATCH v8 6/8] hw/misc/riscv_iopmp: Add API to configure RISCV
 CPU IOPMP support
Message-ID: <ZrXn6hhuoykwALPv@ethan84-VirtualBox>
References: <20240715095702.1222213-1-ethan84@andestech.com>
 <20240715101409.1249373-1-ethan84@andestech.com>
 <CAKmqyKOJOUvf-=qNQ90BQeFGNayH1mmtcYNd=iYVjNf53V-uMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKOJOUvf-=qNQ90BQeFGNayH1mmtcYNd=iYVjNf53V-uMw@mail.gmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Originating-IP: [10.0.12.12]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 4799uwE5025566
Received-SPF: pass client-ip=60.248.80.70; envelope-from=ethan84@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, RDNS_DYNAMIC=0.982,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_RCVD_IP=0.001 autolearn=no autolearn_force=no
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

On Thu, Aug 08, 2024 at 02:25:04PM +1000, Alistair Francis wrote:
> 
> On Mon, Jul 15, 2024 at 8:15 PM Ethan Chen via <qemu-devel@nongnu.org> wrote:
> >
> > The iopmp_setup_cpu() function configures the RISCV CPU to support IOPMP and
> > specifies the CPU's RRID.
> >
> > Signed-off-by: Ethan Chen <ethan84@andestech.com>
> > ---
> >  hw/misc/riscv_iopmp.c         | 6 ++++++
> >  include/hw/misc/riscv_iopmp.h | 1 +
> >  2 files changed, 7 insertions(+)
> >
> > diff --git a/hw/misc/riscv_iopmp.c b/hw/misc/riscv_iopmp.c
> > index e62ac57437..374bf5c610 100644
> > --- a/hw/misc/riscv_iopmp.c
> > +++ b/hw/misc/riscv_iopmp.c
> > @@ -1211,5 +1211,11 @@ void iopmp_setup_system_memory(DeviceState *dev, const MemMapEntry *memmap,
> >                         "iopmp-downstream-as");
> >  }
> >
> > +void iopmp_setup_cpu(RISCVCPU *cpu, uint32_t rrid)
> > +{
> > +    cpu->cfg.iopmp = true;
> > +    cpu->cfg.iopmp_rrid = rrid;
> > +}
> 
> This should just be a normal CPU property, which the machine can then
> set to true if required

I will add CPU properties for IOPMP config.

Thanks,
Ethan Chen

> 
> Alistair
> 
> > +
> >
> >  type_init(iopmp_register_types);
> > diff --git a/include/hw/misc/riscv_iopmp.h b/include/hw/misc/riscv_iopmp.h
> > index ebe9c4bc4a..7e7da56d10 100644
> > --- a/include/hw/misc/riscv_iopmp.h
> > +++ b/include/hw/misc/riscv_iopmp.h
> > @@ -167,5 +167,6 @@ typedef struct IopmpState {
> >
> >  void iopmp_setup_system_memory(DeviceState *dev, const MemMapEntry *memmap,
> >                                 uint32_t mapentry_num);
> > +void iopmp_setup_cpu(RISCVCPU *cpu, uint32_t rrid);
> >
> >  #endif
> > --
> > 2.34.1
> >
> >


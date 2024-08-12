Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F16C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 02:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdLDm-0007g3-3V; Sun, 11 Aug 2024 22:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1sdLDj-0007eA-Sf; Sun, 11 Aug 2024 22:55:43 -0400
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1sdLDh-0003Ui-4x; Sun, 11 Aug 2024 22:55:43 -0400
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
 by Atcsqr.andestech.com with ESMTPS id 47C2tJq6085654
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Aug 2024 10:55:19 +0800 (+08)
 (envelope-from ethan84@andestech.com)
Received: from ethan84-VirtualBox (10.0.12.12) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server (TLS) id 14.3.498.0; Mon, 12 Aug 2024
 10:55:20 +0800
Date: Mon, 12 Aug 2024 10:55:19 +0800
To: Alistair Francis <alistair23@gmail.com>
CC: <qemu-devel@nongnu.org>, <richard.henderson@linaro.org>,
 <pbonzini@redhat.com>, <peterx@redhat.com>, <david@redhat.com>,
 <philmd@linaro.org>, <palmer@dabbelt.com>, <alistair.francis@wdc.com>,
 <bmeng.cn@gmail.com>, <liwei1518@gmail.com>,
 <dbarboza@ventanamicro.com>, <zhiwei_liu@linux.alibaba.com>,
 <qemu-riscv@nongnu.org>
Subject: Re: [PATCH v8 8/8] hw/riscv/virt: Add IOPMP support
Message-ID: <Zrl5l9r0c45BL4YG@ethan84-VirtualBox>
References: <20240715095702.1222213-1-ethan84@andestech.com>
 <20240715101434.1249621-1-ethan84@andestech.com>
 <CAKmqyKPgqNaT1A0+pk6srrtPQqs6=SUX_etg55hU3rxPbuFVsA@mail.gmail.com>
 <ZrXsFaBndB0zTONi@ethan84-VirtualBox>
 <CAKmqyKMAr9oXz99ndNkPFaXvCSaVcr0pskKW=HbrYoBh2qmezg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKMAr9oXz99ndNkPFaXvCSaVcr0pskKW=HbrYoBh2qmezg@mail.gmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Originating-IP: [10.0.12.12]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 47C2tJq6085654
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

On Mon, Aug 12, 2024 at 10:48:40AM +1000, Alistair Francis wrote:
> [EXTERNAL MAIL]
> 
> On Fri, Aug 9, 2024 at 8:14 PM Ethan Chen <ethan84@andestech.com> wrote:
> >
> > On Thu, Aug 08, 2024 at 02:01:13PM +1000, Alistair Francis wrote:
> > >
> > > On Mon, Jul 15, 2024 at 8:15 PM Ethan Chen via <qemu-devel@nongnu.org> wrote:
> > > >
> > > > - Add 'iopmp=on' option to enable IOPMP. It adds an iopmp device virt machine
> > > >   to protect all regions of system memory, and configures RRID of CPU.
> > > >
> > > > Signed-off-by: Ethan Chen <ethan84@andestech.com>
> > > > ---
> > > >  docs/system/riscv/virt.rst |  5 +++
> > > >  hw/riscv/Kconfig           |  1 +
> > > >  hw/riscv/virt.c            | 63 ++++++++++++++++++++++++++++++++++++++
> > > >  include/hw/riscv/virt.h    |  5 ++-
> > > >  4 files changed, 73 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
> > > > index 9a06f95a34..9fd006ccc2 100644
> > > > --- a/docs/system/riscv/virt.rst
> > > > +++ b/docs/system/riscv/virt.rst
> > > > @@ -116,6 +116,11 @@ The following machine-specific options are supported:
> > > >    having AIA IMSIC (i.e. "aia=aplic-imsic" selected). When not specified,
> > > >    the default number of per-HART VS-level AIA IMSIC pages is 0.
> > > >
> > > > +- iopmp=[on|off]
> > > > +
> > > > +  When this option is "on", an IOPMP device is added to machine. IOPMP checks
> > > > +  memory transcations in system memory. This option is assumed to be "off".
> > >
> > > We probably should have a a little more here. You don't even mention
> > > that this is the rapid-k model.
> >
> > I'll provide more details.
> >
> > >
> > > It might be worth adding a `model` field, to make it easier to add
> > > other models in the future. Thoughts?
> > >
> >
> > I think the IOPMP model should be a device property and not
> > configured here.
> 
> It should be a device property, but then how does a user configure
> that? I guess users can globally set device props, but it's a bit
> clunky
>

Because IOPMP has a lot props, I think it is better to configure them 
through global device props instead of machine option.

Thanks,
Ethan Chen


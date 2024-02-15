Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F542C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 16:05:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raeE6-0002LA-Nf; Thu, 15 Feb 2024 11:04:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1raeE4-0002Kv-UM
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 11:04:40 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1raeE2-00029v-62
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 11:04:40 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbKYD6DRMz6K8j1;
 Fri, 16 Feb 2024 00:01:04 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id B3F51140A86;
 Fri, 16 Feb 2024 00:04:32 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 16:04:32 +0000
Date: Thu, 15 Feb 2024 16:04:31 +0000
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-devel@nongnu.org>, Gregory Price <gregory.price@memverge.com>, Alex
 =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Sajjan Rao
 <sajjanr@gmail.com>, Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>,
 <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Eduardo
 Habkost" <eduardo@habkost.net>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/3] accel/tcg: Set can_do_io at at start of
 lookup_tb_ptr helper
Message-ID: <20240215160431.00005355@huawei.com>
In-Reply-To: <CAFEAcA-_z8FWxXRdGVdk7u5rgOMOEnfSLokdx6_ocyObzPF8bA@mail.gmail.com>
References: <20240215150133.2088-1-Jonathan.Cameron@huawei.com>
 <20240215150133.2088-2-Jonathan.Cameron@huawei.com>
 <CAFEAcA-_z8FWxXRdGVdk7u5rgOMOEnfSLokdx6_ocyObzPF8bA@mail.gmail.com>
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
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 15 Feb 2024 15:11:17 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Thu, 15 Feb 2024 at 15:02, Jonathan Cameron via
> <qemu-devel@nongnu.org> wrote:
> >
> > From: Peter Maydell <peter.maydell@linaro.org>
> >
> > Peter posted this in the thread trying to fix x86 TCG handling
> > of page tables in MMIO space (specifically emulated CXL interleaved memory)
> > https://lore.kernel.org/qemu-devel/CAFEAcA_a_AyQ=Epz3_+CheAT8Crsk9mOu894wbNW_FywamkZiw@mail.gmail.com/#t
> >
> > Peter, are you happy to give your SoB on this one?
> >

Thanks, I'll also add a summary of your description of why there is
a bug based on your email to v2 as the above doesn't really
provide any useful info :( 

If a page table is in IO memory and lookup_tb_ptr probes
the TLB it can result in a page table walk for the instruction
fetch.  If this hits IO memory and io_prepare falsely assumes
it needs to do a TLB recompile.
Avoid that by setting can_do_io at the start of lookup_tb_ptr.


> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  accel/tcg/cpu-exec.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> > index 977576ca14..52239a441f 100644
> > --- a/accel/tcg/cpu-exec.c
> > +++ b/accel/tcg/cpu-exec.c
> > @@ -396,6 +396,14 @@ const void *HELPER(lookup_tb_ptr)(CPUArchState *env)
> >      uint64_t cs_base;
> >      uint32_t flags, cflags;
> >
> > +    /*
> > +     * By definition we've just finished a TB, so I/O is OK.
> > +     * Avoid the possibility of calling cpu_io_recompile() if
> > +     * a page table walk triggered by tb_lookup() calling
> > +     * probe_access_internal() happens to touch an MMIO device.
> > +     * The next TB, if we chain to it, will clear the flag again.
> > +     */
> > +    cpu->neg.can_do_io = true;
> >      cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
> >
> >      cflags = curr_cflags(cpu);
> > --  
> 
> Happy to provide a
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> 
> but I'd appreciate RTH's review to confirm this is the right
> way to deal with the problem.
> 
> thanks
> -- PMM



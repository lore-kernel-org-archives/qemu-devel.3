Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B78CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 10:09:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEm41-0004FU-KO; Fri, 31 Oct 2025 06:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vEm3u-0004E7-VB; Fri, 31 Oct 2025 06:08:52 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vEm3n-0002TL-TI; Fri, 31 Oct 2025 06:08:47 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cyc5r31P6z6M4QQ;
 Fri, 31 Oct 2025 18:04:32 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id 0799F1402E9;
 Fri, 31 Oct 2025 18:08:26 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 31 Oct
 2025 10:08:25 +0000
Date: Fri, 31 Oct 2025 10:08:23 +0000
To: Gavin Shan <gshan@redhat.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <mst@redhat.com>,
 <imammedo@redhat.com>, <anisinha@redhat.com>, <gengdongjiu1@gmail.com>,
 <peter.maydell@linaro.org>, <pbonzini@redhat.com>,
 <mchehab+huawei@kernel.org>, <shan.gavin@gmail.com>
Subject: Re: [PATCH RESEND v2 1/3] acpi/ghes: Extend
 acpi_ghes_memory_errors() to support multiple CPERs
Message-ID: <20251031100823.00001c8d@huawei.com>
In-Reply-To: <20251031095850.00002589@huawei.com>
References: <20251007060810.258536-1-gshan@redhat.com>
 <20251007060810.258536-2-gshan@redhat.com>
 <20251031095850.00002589@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml100005.china.huawei.com (7.214.146.113)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 31 Oct 2025 09:58:50 +0000
Jonathan Cameron <jonathan.cameron@huawei.com> wrote:

> On Tue,  7 Oct 2025 16:08:08 +1000
> Gavin Shan <gshan@redhat.com> wrote:
> 
> > In the situation where host and guest has 64KB and 4KB page sizes, one
> > error on the host's page affects 16 guest's pages. we need to send 16
> > consective errors in this specific case.  
> 
> Hi Gavin,
> 
> Sorry this one has been on my to review list far too long.
> 
> > 
> > Extend acpi_ghes_memory_errors() to support multiple CPERs after the
> > hunk of code to generate the GHES error status is pulled out from
> > ghes_gen_err_data_uncorrectable_recoverable().  
> 
> I think this description needs to be more detailed wrt to how those
> multiple CPERs are handled.  Specifically that they are in a single
> error status block (so should only represent related errors.)
> 
> This is to make it clear this isn't queuing events, but instead just
> presenting them as one block.
> 
> > 
> > No functional changes intended.
> > 
> > Signed-off-by: Gavin Shan <gshan@redhat.com>
> > ---
> >  hw/acpi/ghes-stub.c    |  2 +-
> >  hw/acpi/ghes.c         | 27 ++++++++++++++-------------
> >  include/hw/acpi/ghes.h |  2 +-
> >  target/arm/kvm.c       |  7 ++++++-
> >  4 files changed, 22 insertions(+), 16 deletions(-)  
> 
> > diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> > index 06555905ce..045b77715f 100644
> > --- a/hw/acpi/ghes.c
> > +++ b/hw/acpi/ghes.c
> > @@ -214,18 +214,13 @@ static void acpi_ghes_build_append_mem_cper(GArray *table,
> >  
> >  static void
> >  ghes_gen_err_data_uncorrectable_recoverable(GArray *block,
> > -                                            const uint8_t *section_type,
> > -                                            int data_length)
> > +                                            const uint8_t *section_type)
> >  {
> >      /* invalid fru id: ACPI 4.0: 17.3.2.6.1 Generic Error Data,
> >       * Table 17-13 Generic Error Data Entry
> >       */
> >      QemuUUID fru_id = {};
> >  
> > -    /* Build the new generic error status block header */
> > -    acpi_ghes_generic_error_status(block, ACPI_GEBS_UNCORRECTABLE,
> > -        0, 0, data_length, ACPI_CPER_SEV_RECOVERABLE);
> > -]  
> 
> With this bit gone, is it worth having the helper?  Perhaps just move
> the remains to where it is called.
> 
> >      /* Build this new generic error data entry header */
> >      acpi_ghes_generic_error_data(block, section_type,
> >          ACPI_CPER_SEV_RECOVERABLE, 0, 0,  
> 
> > diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> > index 4f769d69b3..9a47ac9e3a 100644
> > --- a/target/arm/kvm.c
> > +++ b/target/arm/kvm.c
> > @@ -2434,6 +2434,7 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
> >      ram_addr_t ram_addr;
> >      hwaddr paddr;
> >      AcpiGhesState *ags;
> > +    GArray *addresses;
> >  
> >      assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);
> >  
> > @@ -2442,6 +2443,7 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
> >          ram_addr = qemu_ram_addr_from_host(addr);
> >          if (ram_addr != RAM_ADDR_INVALID &&
> >              kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
> > +            addresses = g_array_new(false, false, sizeof(paddr));  
> 
> Given you are going to free in all paths, maybe a g_autofree?

Oddly there is no use of g_auto() with g_array in qemu. Ah well, next suggestion is
my preference anyway.

> 
> Also, we know this only grows to a fixed max size (16 after patch 3), so maybe just
> provide a hwaddr paddrs[16]; and pass forwards the count?
> 
> >              kvm_hwpoison_page_add(ram_addr);
> >              /*
> >               * If this is a BUS_MCEERR_AR, we know we have been called
> > @@ -2454,16 +2456,19 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
> >               * later from the main thread, so doing the injection of
> >               * the error would be more complicated.
> >               */
> > +            g_array_append_vals(addresses, &paddr, 1);
> >              if (code == BUS_MCEERR_AR) {
> >                  kvm_cpu_synchronize_state(c);
> >                  if (!acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC,
> > -                                             paddr)) {
> > +                                             addresses)) {
> >                      kvm_inject_arm_sea(c);
> >                  } else {
> >                      error_report("failed to record the error");
> >                      abort();
> >                  }
> >              }
> > +
> > +            g_array_free(addresses, true);
> >              return;
> >          }
> >          if (code == BUS_MCEERR_AO) {  
> 



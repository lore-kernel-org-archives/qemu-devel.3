Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B74C7C52D71
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 14:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbhc0-0002Br-FN; Wed, 07 Aug 2024 10:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sbhby-00028o-5h; Wed, 07 Aug 2024 10:25:58 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sbhbv-00034t-Lx; Wed, 07 Aug 2024 10:25:57 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WfC8K6R0Vz6K5nm;
 Wed,  7 Aug 2024 22:23:29 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 242E6140B35;
 Wed,  7 Aug 2024 22:25:49 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 7 Aug
 2024 15:25:48 +0100
Date: Wed, 7 Aug 2024 15:25:47 +0100
To: Igor Mammedov <imammedo@redhat.com>
CC: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 <linux-kernel@vger.kernel.org>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 6/7] acpi/ghes: add support for generic error
 injection via QAPI
Message-ID: <20240807152547.000058fd@Huawei.com>
In-Reply-To: <20240806163113.3bdc260a@imammedo.users.ipa.redhat.com>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
 <20c491e357340e0062b6ff09867c1661ed4d2479.1722634602.git.mchehab+huawei@kernel.org>
 <20240806163113.3bdc260a@imammedo.users.ipa.redhat.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 6 Aug 2024 16:31:13 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Fri,  2 Aug 2024 23:44:01 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Provide a generic interface for error injection via GHESv2.
> > 
> > This patch is co-authored:
> >     - original ghes logic to inject a simple ARM record by Shiju Jose;
> >     - generic logic to handle block addresses by Jonathan Cameron;
> >     - generic GHESv2 error inject by Mauro Carvalho Chehab;
> > 
> > Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Co-authored-by: Shiju Jose <shiju.jose@huawei.com>
> > Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Shiju Jose <shiju.jose@huawei.com>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  hw/acpi/ghes.c         | 159 ++++++++++++++++++++++++++++++++++++++---
> >  hw/acpi/ghes_cper.c    |   2 +-
> >  include/hw/acpi/ghes.h |   3 +
> >  3 files changed, 152 insertions(+), 12 deletions(-)
> > 
> > diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> > index a745dcc7be5e..e125c9475773 100644
> > --- a/hw/acpi/ghes.c
> > +++ b/hw/acpi/ghes.c
> > @@ -395,23 +395,22 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
> >      ags->present = true;
> >  }
> >  
> > +static uint64_t ghes_get_state_start_address(void)  
> 
> ghes_get_hardware_errors_address() might better reflect what address it will return
> 
> > +{
> > +    AcpiGedState *acpi_ged_state =
> > +        ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED, NULL));
> > +    AcpiGhesState *ags = &acpi_ged_state->ghes_state;
> > +
> > +    return le64_to_cpu(ags->ghes_addr_le);
> > +}
> > +
> >  int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
> >  {
> >      uint64_t error_block_addr, read_ack_register_addr, read_ack_register = 0;
> > -    uint64_t start_addr;
> > +    uint64_t start_addr = ghes_get_state_start_address();
> >      bool ret = -1;
> > -    AcpiGedState *acpi_ged_state;
> > -    AcpiGhesState *ags;
> > -
> >      assert(source_id < ACPI_HEST_SRC_ID_RESERVED);
> >  
> > -    acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
> > -                                                       NULL));
> > -    g_assert(acpi_ged_state);
> > -    ags = &acpi_ged_state->ghes_state;
> > -
> > -    start_addr = le64_to_cpu(ags->ghes_addr_le);
> > -
> >      if (physical_address) {
> >          start_addr += source_id * sizeof(uint64_t);  
> 
> above should be a separate patch
> 
> >  
> > @@ -448,9 +447,147 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
> >      return ret;
> >  }
> >  
> > +/*
> > + * Error register block data layout
> > + *
> > + * | +---------------------+ ges.ghes_addr_le
> > + * | |error_block_address0 |
> > + * | +---------------------+
> > + * | |error_block_address1 |
> > + * | +---------------------+ --+--
> > + * | |    .............    | GHES_ADDRESS_SIZE
> > + * | +---------------------+ --+--
> > + * | |error_block_addressN |
> > + * | +---------------------+
> > + * | | read_ack0           |
> > + * | +---------------------+ --+--
> > + * | | read_ack1           | GHES_ADDRESS_SIZE
> > + * | +---------------------+ --+--
> > + * | |   .............     |
> > + * | +---------------------+
> > + * | | read_ackN           |
> > + * | +---------------------+ --+--
> > + * | |      CPER           |   |
> > + * | |      ....           | GHES_MAX_RAW_DATA_LENGT
> > + * | |      CPER           |   |
> > + * | +---------------------+ --+--
> > + * | |    ..........       |
> > + * | +---------------------+
> > + * | |      CPER           |
> > + * | |      ....           |
> > + * | |      CPER           |
> > + * | +---------------------+
> > + */  
> 
> no need to duplicate docs/specs/acpi_hest_ghes.rst,
> I'd just reffer to it and maybe add short comment as to why it's mentioned.
> 
> > +/* Map from uint32_t notify to entry offset in GHES */
> > +static const uint8_t error_source_to_index[] = { 0xff, 0xff, 0xff, 0xff,
> > +                                                 0xff, 0xff, 0xff, 1, 0};
> > +
> > +static bool ghes_get_addr(uint32_t notify, uint64_t *error_block_addr,
> > +                          uint64_t *read_ack_addr)
> > +{
> > +    uint64_t base;
> > +
> > +    if (notify >= ACPI_GHES_NOTIFY_RESERVED) {
> > +        return false;
> > +    }
> > +
> > +    /* Find and check the source id for this new CPER */
> > +    if (error_source_to_index[notify] == 0xff) {
> > +        return false;
> > +    }
> > +
> > +    base = ghes_get_state_start_address();
> > +
> > +    *read_ack_addr = base +
> > +        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
> > +        error_source_to_index[notify] * sizeof(uint64_t);
> > +
> > +    /* Could also be read back from the error_block_address register */
> > +    *error_block_addr = base +
> > +        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
> > +        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
> > +        error_source_to_index[notify] * ACPI_GHES_MAX_RAW_DATA_LENGTH;
> > +
> > +    return true;
> > +}  
> 
> I don't like all this pointer math, which is basically a reverse engineered
> QEMU actions on startup + guest provided etc/hardware_errors address.
> 
> For once, it assumes error_source_to_index[] matches order in which HEST
> error sources were described, which is fragile.
> 
> 2nd: migration-wive it's disaster, since old/new HEST/hardware_errors tables
> in RAM migrated from older version might not match above assumptions
> of target QEMU. 
> 
> I see 2 ways to rectify it:
>   1st: preferred/cleanest would be to tell QEMU (via fw_cfg) address of HEST table
>        in guest RAM, like we do with etc/hardware_errors, see
>             build_ghes_error_table()
>                ...
>                tell firmware to write hardware_errors GPA into
>        and then fetch from HEST table in RAM, the guest patched error/ack addresses
>        for given source_id
> 
>        code-wise: relatively simple once one wraps their own head over
>                  how this whole APEI thing works in QEMU
>                  workflow  is described in docs/specs/acpi_hest_ghes.rst
>                  look to me as sufficient to grasp it.
>                  (but my view is very biased given my prior knowledge,
>                   aka: docs/comments/examples wrt acpi patching are good enough)
>                  (if it's not clear how to do it, ask me for pointers)

Hi Igor, I think I follow what you mean but maybe this question will reveal
otherwise.  HEST is currently in ACPI_BUILD_TABLE_FILE.
Would you suggest splitting it to it's own file, or using table_offsets
to get the offset in ACPI_BUILD_TABLE_FILE GPA?


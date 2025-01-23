Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B63FC0218C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 10:30:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tauSt-0005ZM-5W; Thu, 23 Jan 2025 05:29:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tauSq-0005YU-EM; Thu, 23 Jan 2025 05:29:32 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tauSm-0001SB-J8; Thu, 23 Jan 2025 05:29:32 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ydxxq24jgz6K8rx;
 Thu, 23 Jan 2025 18:29:03 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id AFE98140736;
 Thu, 23 Jan 2025 18:29:21 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 23 Jan
 2025 11:29:21 +0100
Date: Thu, 23 Jan 2025 10:29:19 +0000
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Shiju Jose <shiju.jose@huawei.com>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>, Ani Sinha <anisinha@redhat.com>, Dongjiu Geng
 <gengdongjiu1@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/11] acpi/ghes: Use HEST table offsets when preparing
 GHES records
Message-ID: <20250123102919.000044c9@huawei.com>
In-Reply-To: <10a8a913862c9cc894235d32b10bbf2f992340ff.1737560101.git.mchehab+huawei@kernel.org>
References: <cover.1737560101.git.mchehab+huawei@kernel.org>
 <10a8a913862c9cc894235d32b10bbf2f992340ff.1737560101.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.043, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Wed, 22 Jan 2025 16:46:20 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> There are two pointers that are needed during error injection:
> 
> 1. The start address of the CPER block to be stored;
> 2. The address of the ack, which needs a reset before next error.
> 
> It is preferable to calculate them from the HEST table.  This allows
> checking the source ID, the size of the table and the type of the
> HEST error block structures.
> 
> Yet, keep the old code, as this is needed for migration purposes.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Generally looks good.  A few bits that I think could be made
easier to follow for anyone with the spec open in front of them.

Thanks,

Jonathan

> ---
>  hw/acpi/ghes.c | 98 ++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 88 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 34e3364d3fd8..b46b563bcaf8 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -61,6 +61,23 @@
>   */
>  #define ACPI_GHES_GESB_SIZE                 20
>  
> +/*
> + * Offsets with regards to the start of the HEST table stored at
> + * ags->hest_addr_le, according with the memory layout map at
> + * docs/specs/acpi_hest_ghes.rst.
> + */
> +
> +/* ACPI 6.2: 18.3.2.8 Generic Hardware Error Source version 2

Local multiline comment style seems to be always
/*
 * ACPI 6.2:...

So perhaps good to copy that.

> + * Table 18-382 Generic Hardware Error Source version 2 (GHESv2) Structure
> + */
> +#define HEST_GHES_V2_TABLE_SIZE  92
> +#define GHES_ACK_OFFSET          (64 + GAS_ADDR_OFFSET)

Using a GAS offset here to me obscures what is going on.  I'd
explicitly handle the GAS where you are reading this.
We probably should sanity check the type as there are
some crazy options that might turn up one day.

Maybe worth using spec term of
GHES_READ_ACK_...

Obviously it's a question of who you are for whether it is read or
write, but maybe still worth using that term for easy checking
against the specification.

> +
> +/* ACPI 6.2: 18.3.2.7: Generic Hardware Error Source
same on comment format.

> + * Table 18-380: 'Error Status Address' field
> + */
> +#define GHES_ERR_ST_ADDR_OFFSET  (20 + GAS_ADDR_OFFSET)
Maybe STS or spell out status? I found ST a bit confusing below.

> +
>  /*
>   * Values for error_severity field
>   */
> @@ -212,14 +229,6 @@ static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker,
>  {
>      int i, error_status_block_offset;
>  
> -    /*
> -     * TODO: Current version supports only one source.
> -     * A further patch will drop this check, after adding a proper migration
> -     * code, as, for the code to work, we need to store a bios pointer to the
> -     * HEST table.
> -     */
> -    assert(num_sources == 1);
> -
>      /* Build error_block_address */
>      for (i = 0; i < num_sources; i++) {
>          build_append_int_noprefix(hardware_errors, 0, sizeof(uint64_t));
> @@ -419,6 +428,70 @@ static void get_hw_error_offsets(uint64_t ghes_addr,
>      *read_ack_register_addr = ghes_addr + sizeof(uint64_t);
>  }
>  
> +static void get_ghes_source_offsets(uint16_t source_id, uint64_t hest_addr,
> +                                    uint64_t *cper_addr,
> +                                    uint64_t *read_ack_start_addr,
> +                                    Error **errp)
> +{
> +    uint64_t hest_err_block_addr, hest_read_ack_addr;
> +    uint64_t err_source_struct, error_block_addr;
> +    uint32_t num_sources, i;
> +
> +    if (!hest_addr) {
I guess it is a question of matching local code, but I'd be tempted
to name this hest_body_addr as it isn't the start of the table but
rather the bit after the header.

> +        return;
> +    }
> +
> +    cpu_physical_memory_read(hest_addr, &num_sources, sizeof(num_sources));

The hest_addr naming thing confused me a tiny bit here because obviously num_sources
isn't the first thing in the table in the spec!

> +    num_sources = le32_to_cpu(num_sources);
> +
> +    err_source_struct = hest_addr + sizeof(num_sources);
> +
> +    /*
> +     * Currently, HEST Error source navigates only for GHESv2 tables
> +     */
> +
> +    for (i = 0; i < num_sources; i++) {
> +        uint64_t addr = err_source_struct;
> +        uint16_t type, src_id;
> +
> +        cpu_physical_memory_read(addr, &type, sizeof(type));
> +        type = le16_to_cpu(type);
> +
> +        /* For now, we only know the size of GHESv2 table */
> +        if (type != ACPI_GHES_SOURCE_GENERIC_ERROR_V2) {
> +            error_setg(errp, "HEST: type %d not supported.", type);
> +            return;

It's a pity we can't just skip them, but absence of a size field
makes that tricky...  Can add that later I guess along with sizes
for each defined type including figuring out the variable length
ones like IA-32 machine check.  I guess this is why the whole ordering
constraint for new types was added. Can't find the old ones if
we don't know the size of the new ones, hence need new definitions
at the end.

Anyhow, I'm fine with this but maybe a little more description in the comment
would avoid someone going down same rat hole I just did.


> +        }
> +
> +        /* Compare CPER source address at the GHESv2 structure */
> +        addr += sizeof(type);
> +        cpu_physical_memory_read(addr, &src_id, sizeof(src_id));
> +
> +        if (src_id == source_id) {
> +            break;
> +        }
> +
> +        err_source_struct += HEST_GHES_V2_TABLE_SIZE;
> +    }
> +    if (i == num_sources) {
> +        error_setg(errp, "HEST: Source %d not found.", source_id);
> +        return;
> +    }
> +
> +    /* Navigate though table address pointers */
> +    hest_err_block_addr = err_source_struct + GHES_ERR_ST_ADDR_OFFSET;

So this is a bit confusing. I'd pull the GAS offset down here rather
than putting it in the define. That way we can clearly see you
are grabbing the address field.  As above, should we check the type
is 0x00?  There are many fun things it could be but here I think
we just want it to be memory space.

> +    hest_read_ack_addr = err_source_struct + GHES_ACK_OFFSET;

Perhaps move this down to above where it is used?
Same thing about GAS address offset being better found down here
rather than hidden in GHES_ACK_OFFSET.

> +
> +    cpu_physical_memory_read(hest_err_block_addr, &error_block_addr,
> +                             sizeof(error_block_addr));
> +
> +    cpu_physical_memory_read(error_block_addr, cper_addr,
> +                             sizeof(*cper_addr));
> +
> +    cpu_physical_memory_read(hest_read_ack_addr, read_ack_start_addr,
> +                             sizeof(*read_ack_start_addr));
> +}
> +
>  void ghes_record_cper_errors(const void *cper, size_t len,
>                               uint16_t source_id, Error **errp)
>  {
> @@ -439,8 +512,13 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>      }
>      ags = &acpi_ged_state->ghes_state;
>  
> -    get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
> -                         &cper_addr, &read_ack_register_addr);
> +    if (!ags->hest_addr_le) {
> +        get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
> +                             &cper_addr, &read_ack_register_addr);
> +    } else {
> +        get_ghes_source_offsets(source_id, le64_to_cpu(ags->hest_addr_le),
> +                                &cper_addr, &read_ack_register_addr, errp);
> +    }
>  
>      if (!cper_addr) {
>          error_setg(errp, "can not find Generic Error Status Block");



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F98D711A5
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 15:00:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDmBD-00048K-7P; Wed, 20 Nov 2024 09:59:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tDmBB-000487-MJ; Wed, 20 Nov 2024 09:59:41 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tDmB9-0003nV-6T; Wed, 20 Nov 2024 09:59:41 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xtkwq2JTMz6GD2P;
 Wed, 20 Nov 2024 22:57:15 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 92410140114;
 Wed, 20 Nov 2024 22:59:32 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 20 Nov
 2024 15:59:32 +0100
Date: Wed, 20 Nov 2024 14:59:30 +0000
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Igor Mammedov <imammedo@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, <linux-kernel@vger.kernel.org>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 4/6] acpi/ghes: Use HEST table offsets when preparing
 GHES records
Message-ID: <20241120145930.00003895@huawei.com>
In-Reply-To: <cf60aee0059d12755c1b9deb2dddb355d8543297.1731486604.git.mchehab+huawei@kernel.org>
References: <cover.1731486604.git.mchehab+huawei@kernel.org>
 <cf60aee0059d12755c1b9deb2dddb355d8543297.1731486604.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
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

On Wed, 13 Nov 2024 09:37:01 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> There are two pointers that are needed during error injection:
> 
> 1. The start address of the CPER block to be stored;
> 2. The address of the ack, which needs a reset before next error.
> 
> Calculate them preferrable from the HEST table, as this allows
> checking the source ID, the size of the table and the type of
> HEST error block structures.

It is preferable to calculate them from the HEST table.  This allows
checking the source ID, the size of the table and the type of the
HEST error block structures.

A few comments inline.

Jonathan


> 
> Yet, keep the old code, as this is needed for migration purposes.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/ghes.c | 98 ++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 88 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index c93bbaf1994a..9ee25efe8abf 100644
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
/*
 * ACPI 6.2:

to be consistent with local style.

> +/* ACPI 6.2: 18.3.2.8 Generic Hardware Error Source version 2
> + * Table 18-382 Generic Hardware Error Source version 2 (GHESv2) Structure
> + */
> +#define HEST_GHES_V2_TABLE_SIZE  92
> +#define GHES_ACK_OFFSET          (64 + GAS_ADDR_OFFSET)
> +
/*
 * ACPI 6.2: 
> +/* ACPI 6.2: 18.3.2.7: Generic Hardware Error Source
> + * Table 18-380: 'Error Status Address' field
> + */

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

Trivial but I wonder if this should be named to indicate that it sin't the start
of HEST but the first bit of the header.
hest_body_address or something like that maybe?  I don't care that much
though if you prefer to keep as is.


> +        return;
> +    }
> +
> +    cpu_physical_memory_read(hest_addr, &num_sources, sizeof(num_sources));
> +    num_sources = le32_to_cpu(num_sources);
> +
> +    err_source_struct = hest_addr + sizeof(num_sources);
> +
> +    /*
> +     * Currently, HEST Error source navigates only for GHESv2 tables
> +     */

Feels like duplication of the comment below where the type check is.
Maybe drop this one?

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
> +        }
> +
> +        /* It is GHES. Compare CPER source address */

It's GHESv2 (of course this bit is the same, but none the less comment
is misleading). I'd just go with
        /* Compare CPER source address */

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
> +    hest_read_ack_addr = err_source_struct + GHES_ACK_OFFSET;

> +
> +    cpu_physical_memory_read(hest_err_block_addr, &error_block_addr,
> +                             sizeof(error_block_addr));
So this points to a registers
> +
> +    cpu_physical_memory_read(error_block_addr, cper_addr,
> +                             sizeof(*cper_addr));
and this reads the register. I'm not sure the spec defines the
contents of that register to be constant.  Maybe we should avoid
reading the register here and do it instead at read of the record?
I 'think' you could in theory use different storage for the CPER
depending on other unhandled errors or whatever else meant you didn't
want a fixed location.

Or maybe just add a comment to say that the location of CPER storage
is fixed.

> +
> +    cpu_physical_memory_read(hest_read_ack_addr, read_ack_start_addr,
> +                             sizeof(*read_ack_start_addr));
> +}



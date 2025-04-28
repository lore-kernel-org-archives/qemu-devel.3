Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA50C369D1
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 03:30:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9FC5-0001Qu-DJ; Sun, 27 Apr 2025 23:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1u9FC3-0001PO-Ew
 for qemu-devel@nongnu.org; Sun, 27 Apr 2025 23:30:07 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1u9FBx-0007Gq-Fc
 for qemu-devel@nongnu.org; Sun, 27 Apr 2025 23:30:06 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxvnI29g5ox_XHAA--.4140S3;
 Mon, 28 Apr 2025 11:29:58 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMCxrhsz9g5oeWKaAA--.8110S3;
 Mon, 28 Apr 2025 11:29:57 +0800 (CST)
Subject: Re: [PATCH v2 1/2] hw/loongarch/virt: Replace RSDT with XSDT table
To: Bibo Mao <maobibo@loongson.cn>
Cc: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Igor Mammedov <imammedo@redhat.com>
References: <20250304074134.1782295-1-maobibo@loongson.cn>
 <20250304074134.1782295-2-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <cb27f3e0-5a83-3367-e831-5f0b0810525c@loongson.cn>
Date: Mon, 28 Apr 2025 11:32:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250304074134.1782295-2-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMCxrhsz9g5oeWKaAA--.8110S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WrykZw4UCFyUGw1xZF45XFc_yoW8Aw4xpw
 4DZr9YyrsaqwnrXasrGw4qg3WDXrs7C3W2gw12yw4rW3sxKry5GF4jvFZIya42yw1kJFs8
 Zr1ktrW7ua1xAFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jO
 db8UUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-1.279, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

ÔÚ 2025/3/4 ÏÂÎç3:41, Bibo Mao Ð´µÀ:
> XSDT table is introduced in ACPI Specification 5.0, it supports 64-bit
> address in the table. There is LoongArch system support from ACPI
> Specification 6.4 and later, XSDT is supported by LoongArch system.
>
> Here replace RSDT with XSDT table.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/loongarch/virt-acpi-build.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>

thansk.
Song Gao
> diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
> index 9ca88d63ae..43ed8e2825 100644
> --- a/hw/loongarch/virt-acpi-build.c
> +++ b/hw/loongarch/virt-acpi-build.c
> @@ -485,7 +485,7 @@ static void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>       LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(machine);
>       GArray *table_offsets;
>       AcpiFadtData fadt_data;
> -    unsigned facs, rsdt, dsdt;
> +    unsigned facs, xsdt, dsdt;
>       uint8_t *u;
>       GArray *tables_blob = tables->table_data;
>   
> @@ -571,17 +571,17 @@ static void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>       }
>   
>       /* RSDT is pointed to by RSDP */
> -    rsdt = tables_blob->len;
> -    build_rsdt(tables_blob, tables->linker, table_offsets,
> +    xsdt = tables_blob->len;
> +    build_xsdt(tables_blob, tables->linker, table_offsets,
>                  lvms->oem_id, lvms->oem_table_id);
>   
>       /* RSDP is in FSEG memory, so allocate it separately */
>       {
>           AcpiRsdpData rsdp_data = {
> -            .revision = 0,
> +            .revision = 2,
>               .oem_id = lvms->oem_id,
> -            .xsdt_tbl_offset = NULL,
> -            .rsdt_tbl_offset = &rsdt,
> +            .xsdt_tbl_offset = &xsdt,
> +            .rsdt_tbl_offset = NULL,
>           };
>           build_rsdp(tables->rsdp, tables->linker, &rsdp_data);
>       }



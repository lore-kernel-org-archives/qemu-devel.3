Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 342A4C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 05:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trs0N-0007Qg-3A; Tue, 11 Mar 2025 01:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1trs0K-0007Q8-RF; Tue, 11 Mar 2025 01:18:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1trs0I-00013M-PV; Tue, 11 Mar 2025 01:18:12 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AKa0A2004798;
 Tue, 11 Mar 2025 05:18:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=eq6dWQ
 ptE0+1mVUg/1YkP9OrdEFC+z+6IHLK73wqviE=; b=bwj7SZVVITNjBMKzpvn1sT
 pcR62+Xz7cTU3ihixqvPvgSfTUpwDmF4GnTIZDmiIucBmSfvjZv4XlGVfk3iN3xm
 yViyHzNJQYL1qjXq/BkSyvcmU2zvBY0WSExuAbETF3vBrqKpAziIKZbR3a4xr58a
 YjtL9WuGbAeqgbndU4bR7m0Hy5J9V376lRmbQp/ZEJHpZbtC14Dv7SGMuET33gqo
 8JLdk+9rVc1pGhdUQHQBfxSLLY1FrB8pPL3c8BeFpT++2rtOaZTEMjDcCK5ih3I0
 3rM/qfKaq7JoEEkqgRxg8O4rhcwQvTAvDuQPK9Lgu8ZZcEpqd+iL8ohNXodDx3wQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45a78qsnfp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Mar 2025 05:18:08 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52B5EMMg028300;
 Tue, 11 Mar 2025 05:18:07 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45a78qsnfk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Mar 2025 05:18:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52B1t3xX022223;
 Tue, 11 Mar 2025 05:18:07 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45917nabjn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Mar 2025 05:18:07 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52B5I6E810289812
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Mar 2025 05:18:06 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2E4BA58063;
 Tue, 11 Mar 2025 05:18:06 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 70BE658055;
 Tue, 11 Mar 2025 05:18:03 +0000 (GMT)
Received: from [9.109.242.165] (unknown [9.109.242.165])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 11 Mar 2025 05:18:03 +0000 (GMT)
Message-ID: <d14b0a3b-6a74-4c55-8836-32def5504614@linux.ibm.com>
Date: Tue, 11 Mar 2025 10:48:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] hw/ppc: Preserve Memory Regions as per MDST/MDDT
 tables
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
References: <20250217071934.86131-1-adityag@linux.ibm.com>
 <20250217071934.86131-6-adityag@linux.ibm.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20250217071934.86131-6-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AjTy-X2jEC1GcCPbNZQ5pOUpvw45Cmkk
X-Proofpoint-ORIG-GUID: tVSrCx-JAp30kora8rSNkhce2B4Qsr_L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_01,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503110028
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 2/17/25 12:49, Aditya Gupta wrote:
> When MPIPL is used, OPAL/Linux registers memory regions to be preserved
> on a Memory-Preserving boot ('crashkernel boot').
> 
> The regions are added to two tables: MDST and MDDT (source and
> destination tables)
> 
> The MDST contains the start address of the region, and size of region
> 
> The MDDT contains the destination address where the region should be
> copied (and size of region which will be same as in MDST entry)
> 
> Then after a crash, when hostboot (pnv_sbe.c in case of QEMU)
> preserves the memory region, it adds the details of preserved regions to
> MDRT (results table)
> 
> Copy memory regions mentioned in MDST to addresses mentioned in MDDT.
> And accordingly update the copied region details in MDRT table.
> 
> Note: If we did not preserve the regions, and MDRT is empty then OPAL
> simply logs "OPAL dump is not available", while kernel will assume that
> firmware would have preserved the regions, and export /proc/vmcore, but
> the vmcore won't have most basic kernel structures hence crash will be
> unable to analyse the vmcore
> 
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   hw/ppc/pnv_sbe.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 57 insertions(+)
> 
> diff --git a/hw/ppc/pnv_sbe.c b/hw/ppc/pnv_sbe.c
> index 361a3854307d..ee905df4e0a6 100644
> --- a/hw/ppc/pnv_sbe.c
> +++ b/hw/ppc/pnv_sbe.c
> @@ -227,6 +227,60 @@ static uint64_t pnv_sbe_power9_xscom_ctrl_read(void *opaque, hwaddr addr,
>       return val;
>   }
>   
> +static void pnv_mpipl_preserve_mem(void)
> +{
> +    /* Get access to metadata */
> +    struct mpipl_metadata *metadata = malloc(DUMP_METADATA_AREA_SIZE);
> +    struct mdst_table *mdst = malloc(MDST_TABLE_SIZE);
> +    struct mddt_table *mddt = malloc(MDDT_TABLE_SIZE);
> +    struct mdrt_table *mdrt = malloc(MDRT_TABLE_SIZE);

Where are these getting free()ed? Mem leak ?

> +    __be64 source_addr, dest_addr, bytes_to_copy;
> +    uint8_t *copy_buffer;
> +
> +    cpu_physical_memory_read(DUMP_METADATA_AREA_BASE, metadata, DUMP_METADATA_AREA_SIZE);
> +    cpu_physical_memory_read(MDST_TABLE_BASE, mdst, MDST_TABLE_SIZE);
> +    cpu_physical_memory_read(MDDT_TABLE_BASE, mddt, MDDT_TABLE_SIZE);
> +
> +    /* HRMOR_BIT copied from skiboot */
> +    #define HRMOR_BIT (1ul << 63)
Could be moved to pnv_sbe.h file.

> +
> +    for (int i = 0;; ++i) {
> +        /* NOTE: Assuming uninitialised will be all zeroes */
> +        if ((mdst[i].addr == 0) && (mdst[i].size == 0)) {
> +            break;
> +        }

What if there is no uninitialized entry till the end of array?
Out-of-bound access since we do not have a loop exit condition?

> +
> +        if (mdst[i].size != mddt[i].size) {
> +            qemu_log_mask(LOG_TRACE,
> +                    "Warning: Invalid entry, size mismatch in MDST & MDDT\n");
> +            continue;
> +        }
> +
> +        if (mdst[i].data_region != mddt[i].data_region) {
> +            qemu_log_mask(LOG_TRACE,
> +                    "Warning: Invalid entry, region mismatch in MDST & MDDT\n");
> +            continue;
> +        }
> +
> +        mdrt[i].src_addr = mdst[i].addr;
> +        mdrt[i].dest_addr = mddt[i].addr;
> +        mdrt[i].size = mdst[i].size;
> +        mdrt[i].data_region = mdst[i].data_region;
> +
> +        source_addr = cpu_to_be64(mdst[i].addr) & ~HRMOR_BIT;
> +        dest_addr = cpu_to_be64(mddt[i].addr) & ~HRMOR_BIT;
> +        bytes_to_copy = cpu_to_be32(mddt[i].size);
> +
> +        /* XXX: Am i assuming we are in big endian mode ? */
If the patches are assuming to work only with BE, it should gracefully 
handle the LE case.

Thanks
Harsh

> +        copy_buffer = malloc(bytes_to_copy);
> +        cpu_physical_memory_read(source_addr, copy_buffer, bytes_to_copy);
> +        cpu_physical_memory_write(dest_addr,  copy_buffer, bytes_to_copy);
> +        free(copy_buffer);
> +    }
> +
> +    cpu_physical_memory_write(MDRT_TABLE_BASE, mdrt, MDRT_TABLE_SIZE);
> +}
> +
>   static void pnv_sbe_power9_xscom_ctrl_write(void *opaque, hwaddr addr,
>                                          uint64_t val, unsigned size)
>   {
> @@ -250,6 +304,9 @@ static void pnv_sbe_power9_xscom_ctrl_write(void *opaque, hwaddr addr,
>                */
>               pause_all_vcpus();
>   
> +            /* Preserve the memory locations registered for MPIPL */
> +            pnv_mpipl_preserve_mem();
> +
>               /*
>                * TODO: Pass `mpipl` node in device tree to signify next
>                * boot is an MPIPL boot


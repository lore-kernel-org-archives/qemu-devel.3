Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8709CC35FF1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 18:55:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsnho-0000pS-AH; Thu, 13 Mar 2025 14:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tsnhn-0000pC-0L; Thu, 13 Mar 2025 14:54:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tsnhk-0005KN-Dt; Thu, 13 Mar 2025 14:54:54 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DGo5DN024647;
 Thu, 13 Mar 2025 18:54:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=/IpXKa
 JVQcE9gaocX7SDEyZEgOnjwxAsH8//1khS8x4=; b=QL8SCe9jRHXy5EJr+0ShMt
 pFJ42mQkhc3D23IhiXqKqyDcACh4uXVf8hzwMz/LOJW/hv3o6XXsts8qw0lSaxog
 3zs2R+VcvzVPn6f6MbY2pjHC00umZ2q+LHmhlGvy9OjfTUBNMZxYgVHaT/NsIQxo
 uoNi4qwmFq8Ff+jIgRYrb/c9q2yPuaFSYxOqsA6EA4wpQL3Eem7h2jOelepSNh/J
 aCbjc3ce2VJ9C4pyJAoYh+J/SgX9o92Y/bANQIOewWlS2gtRf2N344cxyeWw9BRr
 nrzqr85izHOeyHuDPF3bcbkuZfflIqEzBlpYTUoNesYDrTMC6d/UNNV5Hp2hABmw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c0sr9mry-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Mar 2025 18:54:50 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52DIj92X027231;
 Thu, 13 Mar 2025 18:54:49 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c0sr9mrv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Mar 2025 18:54:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52DFpliB012321;
 Thu, 13 Mar 2025 18:54:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45atsrkbtw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Mar 2025 18:54:48 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52DIsioQ51315068
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Mar 2025 18:54:44 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B778A20043;
 Thu, 13 Mar 2025 18:54:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 34B8520040;
 Thu, 13 Mar 2025 18:54:41 +0000 (GMT)
Received: from [9.124.223.53] (unknown [9.124.223.53])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 13 Mar 2025 18:54:40 +0000 (GMT)
Message-ID: <d411009c-8ee0-4889-97e2-85b27808c9cd@linux.ibm.com>
Date: Fri, 14 Mar 2025 00:24:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] hw/ppc: Preserve Memory Regions as per MDST/MDDT
 tables
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
References: <20250217071934.86131-1-adityag@linux.ibm.com>
 <20250217071934.86131-6-adityag@linux.ibm.com>
 <d14b0a3b-6a74-4c55-8836-32def5504614@linux.ibm.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <d14b0a3b-6a74-4c55-8836-32def5504614@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XJ2AYyMjBqSApB1FfH6ZnujpYPzpIp-t
X-Proofpoint-GUID: GeSpn9vPyQTGwWGXMZJGa49c4rw3cRA4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_08,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503130141
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

On 11/03/25 10:48, Harsh Prateek Bora wrote:

>
> On 2/17/25 12:49, Aditya Gupta wrote:
>> When MPIPL is used, OPAL/Linux registers memory regions to be preserved
>> on a Memory-Preserving boot ('crashkernel boot').
>>
>> The regions are added to two tables: MDST and MDDT (source and
>> destination tables)
>>
>> The MDST contains the start address of the region, and size of region
>>
>> The MDDT contains the destination address where the region should be
>> copied (and size of region which will be same as in MDST entry)
>>
>> Then after a crash, when hostboot (pnv_sbe.c in case of QEMU)
>> preserves the memory region, it adds the details of preserved regions to
>> MDRT (results table)
>>
>> Copy memory regions mentioned in MDST to addresses mentioned in MDDT.
>> And accordingly update the copied region details in MDRT table.
>>
>> Note: If we did not preserve the regions, and MDRT is empty then OPAL
>> simply logs "OPAL dump is not available", while kernel will assume that
>> firmware would have preserved the regions, and export /proc/vmcore, but
>> the vmcore won't have most basic kernel structures hence crash will be
>> unable to analyse the vmcore
>>
>> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
>> ---
>>   hw/ppc/pnv_sbe.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 57 insertions(+)
>>
>> diff --git a/hw/ppc/pnv_sbe.c b/hw/ppc/pnv_sbe.c
>> index 361a3854307d..ee905df4e0a6 100644
>> --- a/hw/ppc/pnv_sbe.c
>> +++ b/hw/ppc/pnv_sbe.c
>> @@ -227,6 +227,60 @@ static uint64_t 
>> pnv_sbe_power9_xscom_ctrl_read(void *opaque, hwaddr addr,
>>       return val;
>>   }
>>   +static void pnv_mpipl_preserve_mem(void)
>> +{
>> +    /* Get access to metadata */
>> +    struct mpipl_metadata *metadata = malloc(DUMP_METADATA_AREA_SIZE);
>> +    struct mdst_table *mdst = malloc(MDST_TABLE_SIZE);
>> +    struct mddt_table *mddt = malloc(MDDT_TABLE_SIZE);
>> +    struct mdrt_table *mdrt = malloc(MDRT_TABLE_SIZE);
>
> Where are these getting free()ed? Mem leak ?

Yes. Thanks for catching this, it's a memory leak, will free it in v2.


>
>> +    __be64 source_addr, dest_addr, bytes_to_copy;
>> +    uint8_t *copy_buffer;
>> +
>> +    cpu_physical_memory_read(DUMP_METADATA_AREA_BASE, metadata, 
>> DUMP_METADATA_AREA_SIZE);
>> +    cpu_physical_memory_read(MDST_TABLE_BASE, mdst, MDST_TABLE_SIZE);
>> +    cpu_physical_memory_read(MDDT_TABLE_BASE, mddt, MDDT_TABLE_SIZE);
>> +
>> +    /* HRMOR_BIT copied from skiboot */
>> +    #define HRMOR_BIT (1ul << 63)
> Could be moved to pnv_sbe.h file.
Okay.
>
>> +
>> +    for (int i = 0;; ++i) {
>> +        /* NOTE: Assuming uninitialised will be all zeroes */
>> +        if ((mdst[i].addr == 0) && (mdst[i].size == 0)) {
>> +            break;
>> +        }
>
> What if there is no uninitialized entry till the end of array?
> Out-of-bound access since we do not have a loop exit condition?

My bad, didn't handle that. Will limit the loop to at max MDST_MAX_SIZE 
/ MDST_ENTRY_SIZE


>
>> +
>> +        if (mdst[i].size != mddt[i].size) {
>> +            qemu_log_mask(LOG_TRACE,
>> +                    "Warning: Invalid entry, size mismatch in MDST & 
>> MDDT\n");
>> +            continue;
>> +        }
>> +
>> +        if (mdst[i].data_region != mddt[i].data_region) {
>> +            qemu_log_mask(LOG_TRACE,
>> +                    "Warning: Invalid entry, region mismatch in MDST 
>> & MDDT\n");
>> +            continue;
>> +        }
>> +
>> +        mdrt[i].src_addr = mdst[i].addr;
>> +        mdrt[i].dest_addr = mddt[i].addr;
>> +        mdrt[i].size = mdst[i].size;
>> +        mdrt[i].data_region = mdst[i].data_region;
>> +
>> +        source_addr = cpu_to_be64(mdst[i].addr) & ~HRMOR_BIT;
>> +        dest_addr = cpu_to_be64(mddt[i].addr) & ~HRMOR_BIT;
>> +        bytes_to_copy = cpu_to_be32(mddt[i].size);
>> +
>> +        /* XXX: Am i assuming we are in big endian mode ? */
> If the patches are assuming to work only with BE, it should gracefully 
> handle the LE case.

Agreed, I have to fix it, so it works in both cases, will handle with 
enough cpu_to_be* for values coming from the firmware/kernel.

Thanks,

- Aditya G

>
> Thanks
> Harsh
>
>> +        copy_buffer = malloc(bytes_to_copy);
>> +        cpu_physical_memory_read(source_addr, copy_buffer, 
>> bytes_to_copy);
>> +        cpu_physical_memory_write(dest_addr,  copy_buffer, 
>> bytes_to_copy);
>> +        free(copy_buffer);
>> +    }
>> +
>> +    cpu_physical_memory_write(MDRT_TABLE_BASE, mdrt, MDRT_TABLE_SIZE);
>> +}
>> +
>>   static void pnv_sbe_power9_xscom_ctrl_write(void *opaque, hwaddr addr,
>>                                          uint64_t val, unsigned size)
>>   {
>> @@ -250,6 +304,9 @@ static void pnv_sbe_power9_xscom_ctrl_write(void 
>> *opaque, hwaddr addr,
>>                */
>>               pause_all_vcpus();
>>   +            /* Preserve the memory locations registered for MPIPL */
>> +            pnv_mpipl_preserve_mem();
>> +
>>               /*
>>                * TODO: Pass `mpipl` node in device tree to signify next
>>                * boot is an MPIPL boot


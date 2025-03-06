Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D75AEC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 04:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq2fO-0007vY-FM; Wed, 05 Mar 2025 23:17:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tq2fF-0007uH-Tv; Wed, 05 Mar 2025 23:16:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tq2fC-0007tk-KG; Wed, 05 Mar 2025 23:16:52 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525KcQAX026998;
 Thu, 6 Mar 2025 04:16:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=W7IDYV
 A2a5hVaVWhcoX9Ks5dWPFbaghJ/s1adXCzV1c=; b=VtDOJjLdMphRZ0h3JKd1Mr
 xmjAg5yZuk7WDhUM4Ud+Su83XBtlbCXTexNuBtJPYqAYf2MOMU2CwOLLXtien82Q
 XGFeeRC7koVFT8g+bOmEh1W60x8u+M3ojXSGeWJv9UChstlUynBu0F/ZHuJf8K0P
 mufLvetDrp3w2VPj8NKKhiudaFPGNsyl5W895aipnBhf7yS8K3E467EjI+9JJ4ra
 d9AAOyoCqu2RqhKMZHM0zjHIf0zxT7d8+tByD+ugdYl9fXmN87Yv+Qx5ZH9lXkWI
 EYx0z5g2O0pSsQuN3tmK/dy6Lcq+j2i3Qt2bBB2iDOCviw/ycvDx3Fw7cO5egBVg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 456wu01jdn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Mar 2025 04:16:47 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5264GlNq010393;
 Thu, 6 Mar 2025 04:16:47 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 456wu01jdk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Mar 2025 04:16:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52620DHU013776;
 Thu, 6 Mar 2025 04:16:46 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454e2kxhtc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Mar 2025 04:16:46 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5264GgGB47907284
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 6 Mar 2025 04:16:42 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AEE0D2004B;
 Thu,  6 Mar 2025 04:16:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 63C2B20040;
 Thu,  6 Mar 2025 04:16:40 +0000 (GMT)
Received: from [9.124.214.147] (unknown [9.124.214.147])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  6 Mar 2025 04:16:40 +0000 (GMT)
Message-ID: <f85227bd-aac1-4316-868e-e9cdd1bfd89f@linux.ibm.com>
Date: Thu, 6 Mar 2025 09:46:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] hw/ppc: Preserve memory regions registered for fadump
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
References: <20250217071711.83735-1-adityag@linux.ibm.com>
 <20250217071711.83735-4-adityag@linux.ibm.com>
 <f5494f6f-599f-427b-8c37-42cc5396c35d@linux.ibm.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <f5494f6f-599f-427b-8c37-42cc5396c35d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: E4_jdiV00W8qFfWL6RD23CDY4KXpaSR-
X-Proofpoint-ORIG-GUID: 1J2aa1UW54wM0oOiTMXaCr6bR8uWj9eh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_02,2025-03-05_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0
 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503060025
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
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

On 05/03/25 12:10, Harsh Prateek Bora wrote:

>
>
> On 2/17/25 12:47, Aditya Gupta wrote:
>> <...snip...>
>>
>> +        /* Reset error_flags & bytes_dumped for now */
>> +        fdm->rgn[i].error_flags = 0;
>> +        fdm->rgn[i].bytes_dumped = 0;
>> +
>> +        if (be32_to_cpu(fdm->rgn[i].request_flag) != 
>> FADUMP_REQUEST_FLAG) {
>> +            qemu_log_mask(LOG_UNIMP,
>> +                "FADUMP: Skipping copying region as not requested\n");
>> +            continue;
>> +        }
>> +
>> +        switch (data_type) {
>> +        case FADUMP_CPU_STATE_DATA:
>> +            /* TODO: Add CPU state data */
>> +            break;
>> +        case FADUMP_HPTE_REGION:
>> +            /* TODO: Add hpte state data */
>> +            break;
>> +        case FADUMP_REAL_MODE_REGION:
>> +        case FADUMP_PARAM_AREA:
>> +            /* Skip copy if source and destination are same (eg. 
>> param area) */
>> +            if (src_addr != dest_addr) {
>> +                copy_buffer = g_malloc(src_len + 1);
>> +                if (copy_buffer == NULL) {
>> +                    qemu_log_mask(LOG_GUEST_ERROR,
>> +                        "FADUMP: Failed allocating memory for 
>> copying reserved memory regions\n");
>> +                    fdm->rgn[i].error_flags =
>> + cpu_to_be16(FADUMP_ERROR_LENGTH_EXCEEDS_SOURCE);
>> +
>> +                    continue;
>> +                }
>> +
>> +                /* Copy the source region to destination */
>> +                cpu_physical_memory_read(src_addr, copy_buffer, 
>> src_len);
>> +                cpu_physical_memory_write(dest_addr, copy_buffer, 
>> src_len);
>> +                g_free(copy_buffer);
>> +            }
>> +
>> +            /*
>> +             * Considering cpu_physical_memory_write would have 
>> copied the
>> +             * complete region
>> +             */
>> +            fdm->rgn[i].bytes_dumped = cpu_to_be64(src_len);
>
> Is this really valid for FADUMP_PARAM_AREA where we intend to skip copy?
>
Yes I think it's good to keep it. Because that's an optimisation i did 
to skip the copy if src and dest are same.

But the actual copy depends on the OS passing us the 
"FADUMP_REQUEST_FLAG" in the region's request flag.

If the flag is set, i am expecting the kernel asked us to copy, and 
hence the .bytes_dumped should be same as the number of bytes asked by 
kernel to copy ideally.

If the flag is not set, we return early, so we let the .bytes_dumped be 0.

>> +
>> +            break;
>> +        default:
>> +            qemu_log_mask(LOG_GUEST_ERROR,
>> +                "FADUMP: Skipping unknown source data type: %d\n", 
>> data_type);
>> +
>> +            fdm->rgn[i].error_flags =
>> +                cpu_to_be16(FADUMP_ERROR_INVALID_DATA_TYPE);
>> +        }
>> +    }
>> +
>> +    return true;
>> +}
>> +
>>   static void trigger_fadump_boot(target_ulong spapr_retcode)
>>   {
>>       /*
>> @@ -353,7 +467,8 @@ static void trigger_fadump_boot(target_ulong 
>> spapr_retcode)
>>        */
>>       pause_all_vcpus();
>>   -    if (true /* TODO: Preserve memory registered for fadump */) {
>> +    /* Preserve the memory locations registered for fadump */
>> +    if (!fadump_preserve_mem()) {
>
> This change can be avoided as suggested in previous patch.
Agreed, will do it in previous patch.
>
>>           /* Failed to preserve the registered memory regions */
>>           rtas_st(spapr_retcode, 0, RTAS_OUT_HW_ERROR);
>>   diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index efa2f891a8a7..a80704187583 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -776,7 +776,32 @@ void push_sregs_to_kvm_pr(SpaprMachineState 
>> *spapr);
>>   #define FADUMP_CMD_UNREGISTER          2
>>   #define FADUMP_CMD_INVALIDATE          3
>>   -#define FADUMP_VERSION    1
>> +#define FADUMP_VERSION                 1
>
> This change can be avoided if taken care initially.

Nice, I missed this diff. Will fix it in the patch which introduced this.


Thanks,

- Aditya Gupta

>
> Thanks
> Harsh
>> +
>> +/*
>> + * The Firmware Assisted Dump Memory structure supports a maximum of 
>> 10 sections
>> + * in the dump memory structure. Presently, three sections are used for
>> + * CPU state data, HPTE & Parameters area, while the remaining seven 
>> sections
>> + * can be used for boot memory regions.
>> + */
>> +#define FADUMP_MAX_SECTIONS            10
>> +#define RTAS_FADUMP_MAX_BOOT_MEM_REGS  7
>> +
>> +/* Firmware provided dump sections */
>> +#define FADUMP_CPU_STATE_DATA   0x0001
>> +#define FADUMP_HPTE_REGION      0x0002
>> +#define FADUMP_REAL_MODE_REGION 0x0011
>> +
>> +/* OS defined sections */
>> +#define FADUMP_PARAM_AREA       0x0100
>> +
>> +/* Dump request flag */
>> +#define FADUMP_REQUEST_FLAG     0x00000001
>> +
>> +/* Dump status flag */
>> +#define FADUMP_ERROR_INVALID_DATA_TYPE          0x8000
>> +#define FADUMP_ERROR_INVALID_SOURCE_ADDR        0x4000
>> +#define FADUMP_ERROR_LENGTH_EXCEEDS_SOURCE      0x2000
>>     /*
>>    * The Firmware Assisted Dump Memory structure supports a maximum 
>> of 10 sections


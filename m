Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD72CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 14:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urHFo-0006CP-22; Wed, 27 Aug 2025 10:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1urHFm-0006BH-AB; Wed, 27 Aug 2025 10:35:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1urHFi-0000JU-OT; Wed, 27 Aug 2025 10:35:57 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57R7QVnh006750;
 Wed, 27 Aug 2025 14:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=LZMNHM
 Ei9Oh6ympMVU081mqe8qx2K7fPG2gm8rPwVHg=; b=i5weTPCSICrK3sjE0jrUmi
 K3rOyQE+H//aG+5fcnvRppqGPVTohm9XABc93yCN9VHAnOn9YJ8wuh4whC3glVke
 hDze26hWXULGpn+n6Az/2gMTT6qcBAXTDm/qpElYkEMQFMq5QUvsMIt6m7E/f8lA
 HNljZm7W9vrhIk3VnqD+DSkOfeQlvTeQd8nXhqKb5L6Xm8m0Kj+Hpsu6U3zlc8Kl
 Rltb9ox/D1dbqk9mJCX0AZW2o54En6Qh+aESHucI+YGD+nlECCl0WS9Crt0z5etn
 CBBOTZ1FS0hm0hmr+bWIg1eI8Ohsg56l3UeK1LOr356opj4Xb8xKVj6YQJKUtEXA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q42j4hee-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Aug 2025 14:35:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57RBwk9P002502;
 Wed, 27 Aug 2025 14:35:51 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48qryprc89-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Aug 2025 14:35:51 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57REZeac20185650
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Aug 2025 14:35:40 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 876AA5805B;
 Wed, 27 Aug 2025 14:35:49 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E8F7C58055;
 Wed, 27 Aug 2025 14:35:47 +0000 (GMT)
Received: from [9.61.169.198] (unknown [9.61.169.198])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 27 Aug 2025 14:35:47 +0000 (GMT)
Message-ID: <4cbc7613-aa51-4a3b-9467-2185426b9c14@linux.ibm.com>
Date: Wed, 27 Aug 2025 10:35:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/29] s390x/diag: Implement DIAG 320 subcode 1
To: Jared Rossi <jrossi@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com
References: <20250818214323.529501-1-zycai@linux.ibm.com>
 <20250818214323.529501-8-zycai@linux.ibm.com>
 <82c91b19-eb26-422b-9f2b-248ccd45b6db@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <82c91b19-eb26-422b-9f2b-248ccd45b6db@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxMCBTYWx0ZWRfX+cZBXr8+1CrE
 mkHNMpQ7rtXRQGYsroeoBTW8QKOnE/XVOdURpCGT3Nh8dnNHvh9+8ZoIl/Fj+vRapLNqHBy5QiE
 guL8Mmc4j6DvOZuRsEq6zHbFE+JmOMLO5bADDCUn6W12XTC8hUEaDCVu/ADB0cpJcZIUyZ3bYGT
 OZwH6pvVogVLEO6ucgF4a/Npkt2pRLHFoh+i84ORMYowPYjRNmDW0h/mijY2PCQSAryL64pCcT9
 YF0O+JbLKPRLZXkV5AtjwULFNuuf2E6/QUS3h9aTIvHhFzt74NVJ/Z78lzXkSbOxb7yWEGCDepn
 FExU9RvwEgJmVyTeVKCZBFyx/IUPFffyc84PFbbqlkLcMf4ABU0iLo548D6FmxpeTe8traob+Jp
 SPTm/XB0
X-Proofpoint-ORIG-GUID: 3xAPYM97Ryo1AH6wmmdTUy8mbMrVFL87
X-Proofpoint-GUID: 3xAPYM97Ryo1AH6wmmdTUy8mbMrVFL87
X-Authority-Analysis: v=2.4 cv=evffzppX c=1 sm=1 tr=0 ts=68af17c7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=UtTk-WhnHdzgtoubRYsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_03,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230010
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/26/25 6:30 PM, Jared Rossi wrote:
> 
> 
> On 8/18/25 5:43 PM, Zhuoying Cai wrote:
>> DIAG 320 subcode 1 provides information needed to determine
>> the amount of storage to store one or more certificates from the
>> certificate store.
>>
>> Upon successful completion, this subcode returns information of the current
>> cert store, such as the number of certificates stored and allowed in the cert
>> store, amount of space may need to be allocate to store a certificate,
>> etc for verification-certificate blocks (VCBs).
>>
>> The subcode value is denoted by setting the left-most bit
>> of an 8-byte field.
>>
>> The verification-certificate-storage-size block (VCSSB) contains
>> the output data when the operation completes successfully. A VCSSB
>> length of 4 indicates that no certificate are available in the cert
>> store.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> ---
>>   docs/specs/s390x-secure-ipl.rst | 10 ++++++
>>   include/hw/s390x/ipl/diag320.h  | 22 +++++++++++++
>>   target/s390x/diag.c             | 56 ++++++++++++++++++++++++++++++++-
>>   3 files changed, 87 insertions(+), 1 deletion(-)
>>
>> diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
>> index 70e9a66fe0..ddc15f0322 100644
>> --- a/docs/specs/s390x-secure-ipl.rst
>> +++ b/docs/specs/s390x-secure-ipl.rst
>> @@ -23,3 +23,13 @@ Subcode 0 - query installed subcodes
>>       Returns a 256-bit installed subcodes mask (ISM) stored in the installed
>>       subcodes block (ISB). This mask indicates which sucodes are currently
>>       installed and available for use.
>> +
>> +Subcode 1 - query verification certificate storage information
>> +    Provides the information required to determine the amount of memory needed to
>> +    store one or more verification-certificates (VCs) from the certificate store (CS).
>> +
>> +    Upon successful completion, this subcode returns various storage size values for
>> +    verification-certificate blocks (VCBs).
>> +
>> +    The output is returned in the verification-certificate-storage-size block (VCSSB).
>> +    A VCSSB length of 4 indicates that no certificates are available in the CS.
>> diff --git a/include/hw/s390x/ipl/diag320.h b/include/hw/s390x/ipl/diag320.h
>> index aa04b699c6..6e4779c699 100644
>> --- a/include/hw/s390x/ipl/diag320.h
>> +++ b/include/hw/s390x/ipl/diag320.h
>> @@ -11,10 +11,32 @@
>>   #define S390X_DIAG320_H
>>   
>>   #define DIAG_320_SUBC_QUERY_ISM     0
>> +#define DIAG_320_SUBC_QUERY_VCSI    1
>>   
>>   #define DIAG_320_RC_OK              0x0001
>>   #define DIAG_320_RC_NOT_SUPPORTED   0x0102
>> +#define DIAG_320_RC_INVAL_VCSSB_LEN 0x0202
>>   
>>   #define DIAG_320_ISM_QUERY_SUBCODES 0x80000000
>> +#define DIAG_320_ISM_QUERY_VCSI     0x40000000
>> +
>> +#define VCSSB_NO_VC     4
>> +#define VCSSB_MIN_LEN   128
>> +#define VCE_HEADER_LEN  128
>> +#define VCB_HEADER_LEN  64
>> +
>> +struct VCStorageSizeBlock {
>> +    uint32_t length;
>> +    uint8_t reserved0[3];
>> +    uint8_t version;
>> +    uint32_t reserved1[6];
>> +    uint16_t total_vc_ct;
>> +    uint16_t max_vc_ct;
>> +    uint32_t reserved3[11];
>> +    uint32_t max_single_vcb_len;
>> +    uint32_t total_vcb_len;
>> +    uint32_t reserved4[10];
>> +};
>> +typedef struct VCStorageSizeBlock VCStorageSizeBlock;
> Previous versions included a build bug message for the size of this 
> structure,
> was it dropped by mistake?
> 

Thanks for pointing it out. The use of the build error message was
misunderstood as unnecessary in the last version.

I'll add it back in the next version.

>>   
>>   #endif
>> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
>> index e67ee57f01..b42cf8fe98 100644
>> --- a/target/s390x/diag.c
>> +++ b/target/s390x/diag.c
>> @@ -191,11 +191,47 @@ out:
>>       }
>>   }
>>   
>> +static int handle_diag320_query_vcsi(S390CPU *cpu, uint64_t addr, uint64_t r1,
>> +                                     uintptr_t ra, S390IPLCertificateStore *qcs)
>> +{
>> +    g_autofree VCStorageSizeBlock *vcssb = NULL;
>> +
>> +    vcssb = g_new0(VCStorageSizeBlock, 1);
>> +    if (s390_cpu_virt_mem_read(cpu, addr, r1, vcssb, sizeof(*vcssb))) {
>> +        s390_cpu_virt_mem_handle_exc(cpu, ra);
>> +        return -1;
>> +    }
>> +
>> +    if (be32_to_cpu(vcssb->length) < VCSSB_MIN_LEN) {
>> +        return DIAG_320_RC_INVAL_VCSSB_LEN;
>> +    }
>> +
>> +    if (!qcs->count) {
>> +        vcssb->length = cpu_to_be32(VCSSB_NO_VC);
>> +    } else {
>> +        vcssb->version = 0;
>> +        vcssb->total_vc_ct = cpu_to_be16(qcs->count);
>> +        vcssb->max_vc_ct = cpu_to_be16(MAX_CERTIFICATES);
>> +        vcssb->max_single_vcb_len = cpu_to_be32(VCB_HEADER_LEN + VCE_HEADER_LEN +
>> +                                                qcs->max_cert_size);
>> +        vcssb->total_vcb_len = cpu_to_be32(VCB_HEADER_LEN + qcs->count * VCE_HEADER_LEN +
>> +                                           qcs->total_bytes);
>> +    }
>> +
>> +    if (s390_cpu_virt_mem_write(cpu, addr, r1, vcssb, be32_to_cpu(vcssb->length))) {
>> +        s390_cpu_virt_mem_handle_exc(cpu, ra);
>> +        return -1;
>> +    }
>> +    return DIAG_320_RC_OK;
>> +}
>> +
>>   void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>>   {
>>       S390CPU *cpu = env_archcpu(env);
>> +    S390IPLCertificateStore *qcs = s390_ipl_get_certificate_store();
>>       uint64_t subcode = env->regs[r3];
>>       uint64_t addr = env->regs[r1];
>> +    int rc;
>>   
>>       if (env->psw.mask & PSW_MASK_PSTATE) {
>>           s390_program_interrupt(env, PGM_PRIVILEGED, ra);
>> @@ -219,7 +255,8 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>>            * but the current set of subcodes can fit within a single word
>>            * for now.
>>            */
>> -        uint32_t ism_word0 = cpu_to_be32(DIAG_320_ISM_QUERY_SUBCODES);
>> +        uint32_t ism_word0 = cpu_to_be32(DIAG_320_ISM_QUERY_SUBCODES |
>> +                                         DIAG_320_ISM_QUERY_VCSI);
>>   
>>           if (s390_cpu_virt_mem_write(cpu, addr, r1, &ism_word0, sizeof(ism_word0))) {
>>               s390_cpu_virt_mem_handle_exc(cpu, ra);
>> @@ -228,6 +265,23 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>>   
>>           env->regs[r1 + 1] = DIAG_320_RC_OK;
>>           break;
>> +    case DIAG_320_SUBC_QUERY_VCSI:
>> +        if (!diag_parm_addr_valid(addr, sizeof(VCStorageSizeBlock), true)) {
>> +            s390_program_interrupt(env, PGM_ADDRESSING, ra);
>> +            return;
>> +        }
>> +
>> +        if (addr & 0x7) {
>> +            s390_program_interrupt(env, PGM_ADDRESSING, ra);
>> +            return;
>> +        }
>> +
>> +        rc = handle_diag320_query_vcsi(cpu, addr, r1, ra, qcs);
>> +        if (rc == -1) {
>> +            return;
>> +        }
>> +        env->regs[r1 + 1] = rc;
>> +        break;
>>       default:
>>           env->regs[r1 + 1] = DIAG_320_RC_NOT_SUPPORTED;
>>           break;
> Regards,
> Jared rossi



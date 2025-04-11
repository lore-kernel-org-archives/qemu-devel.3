Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FFA5C369A2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 17:41:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3INE-0007yV-1t; Fri, 11 Apr 2025 13:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1u3INA-0007wD-Px; Fri, 11 Apr 2025 13:41:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1u3IN8-0000BN-GF; Fri, 11 Apr 2025 13:41:00 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BGjNsC018430;
 Fri, 11 Apr 2025 17:40:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=VPJiex
 vzLUicIKwXNhDDnqVy4i56sgviCaCD0YDN/x4=; b=Nm1EJvx78Vu4HRhHMUobb3
 moKGeDjsUQXJGRALIC/AziuEOPMM5qOBCyFwkJ/uSQZB5HBo8ImZucpzXtjTSylQ
 v+87wbtEq/qCnbiSsTuCvwCpo9jfkcIM+mAJvNqUY3O2oMQiktHIJpAEqqfdjE3+
 964xWREklkuMBhhv0SKCWOEo5XsnNOcizGdulNrjLNQE39TqSLpUpBLrhHJ9iix/
 oi86TpaMybAJRFOzbDcT1ZT1DcxW+FBsDDETkW4UtMpHAqeUIHb93/WvZ8d6Ppy3
 uxU4D5yJv8FMBMB9PBJQ2NAfovwr5TGnZbwH2LaU/su3SboskUZqmes6o6v310rA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45xn5qmxby-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Apr 2025 17:40:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53BDvY6E013915;
 Fri, 11 Apr 2025 17:40:53 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ufup41ap-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Apr 2025 17:40:53 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53BHeqmD20447848
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Apr 2025 17:40:52 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8331958057;
 Fri, 11 Apr 2025 17:40:52 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 683C858059;
 Fri, 11 Apr 2025 17:40:51 +0000 (GMT)
Received: from [9.61.245.55] (unknown [9.61.245.55])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 11 Apr 2025 17:40:51 +0000 (GMT)
Message-ID: <200ea1c6-afa4-4307-a900-9955e6d79349@linux.ibm.com>
Date: Fri, 11 Apr 2025 10:40:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 06/24] s390x/diag: Implement DIAG 320 subcode 1
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250408155527.123341-1-zycai@linux.ibm.com>
 <20250408155527.123341-7-zycai@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20250408155527.123341-7-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7DnaT1NJ8qE2U9Of9ZWwkz44rW0ATgJm
X-Proofpoint-GUID: 7DnaT1NJ8qE2U9Of9ZWwkz44rW0ATgJm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_06,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0
 malwarescore=0 clxscore=1011 priorityscore=1501 mlxscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110110
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


On 4/8/2025 8:55 AM, Zhuoying Cai wrote:
> DIAG 320 subcode 1 provides information needed to determine
> the amount of storage to store one or more certificates.
>
> The subcode value is denoted by setting the left-most bit
> of an 8-byte field.
>
> The verification-certificate-storage-size block (VCSSB) contains
> the output data when the operation completes successfully.
>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   include/hw/s390x/ipl/diag320.h | 25 ++++++++++++++++++++++
>   target/s390x/diag.c            | 39 +++++++++++++++++++++++++++++++++-
>   2 files changed, 63 insertions(+), 1 deletion(-)
>
> diff --git a/include/hw/s390x/ipl/diag320.h b/include/hw/s390x/ipl/diag320.h
> index d6f70c65df..ded336df25 100644
> --- a/include/hw/s390x/ipl/diag320.h
> +++ b/include/hw/s390x/ipl/diag320.h
> @@ -13,7 +13,32 @@
>   #define S390X_DIAG320_H
>   
>   #define DIAG_320_SUBC_QUERY_ISM     0
> +#define DIAG_320_SUBC_QUERY_VCSI    1
>   
>   #define DIAG_320_RC_OK              0x0001
> +#define DIAG_320_RC_NOMEM           0x0202
> +
> +#define VCSSB_MAX_LEN   128
> +#define VCE_HEADER_LEN  128
> +#define VCB_HEADER_LEN  64
> +
> +#define DIAG_320_ISM_QUERY_VCSI     0x4000000000000000
> +
> +struct VerificationCertificateStorageSizeBlock {
> +    uint32_t length;
> +    uint8_t reserved0[3];
> +    uint8_t version;
> +    uint32_t reserved1[6];
> +    uint16_t totalvc;
> +    uint16_t maxvc;
> +    uint32_t reserved3[7];
> +    uint32_t maxvcelen;
> +    uint32_t reserved4[3];
> +    uint32_t largestvcblen;
> +    uint32_t totalvcblen;
> +    uint32_t reserved5[10];
> +} QEMU_PACKED;
> +typedef struct VerificationCertificateStorageSizeBlock \
> +VerificationCertificateStorageSizeBlock;
>   
>   #endif
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index c64b935c87..cc639819ec 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -194,6 +194,7 @@ out:
>   void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>   {
>       S390CPU *cpu = env_archcpu(env);
> +    S390IPLCertificateStore *qcs = s390_ipl_get_certificate_store();
>       uint64_t subcode = env->regs[r3];
>       uint64_t addr = env->regs[r1];
>       int rc;
> @@ -210,7 +211,7 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>   
>       switch (subcode) {
>       case DIAG_320_SUBC_QUERY_ISM:
> -        uint64_t ism =  0;
> +        uint64_t ism = DIAG_320_ISM_QUERY_VCSI;
>   
>           if (s390_cpu_virt_mem_write(cpu, addr, (uint8_t)r1, &ism,
>                                       be64_to_cpu(sizeof(ism)))) {
> @@ -218,6 +219,42 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>               return;
>           }
>   
> +        rc = DIAG_320_RC_OK;
> +        break;
> +    case DIAG_320_SUBC_QUERY_VCSI:
> +        VerificationCertificateStorageSizeBlock vcssb;
> +
> +        if (!diag_parm_addr_valid(addr, sizeof(VerificationCertificateStorageSizeBlock),
> +                                  true)) {
> +            s390_program_interrupt(env, PGM_ADDRESSING, ra);
> +            return;
> +        }
> +
> +        if (!qcs || !qcs->count) {
> +            vcssb.length = 4;
> +        } else {
> +            vcssb.length = VCSSB_MAX_LEN;
> +            vcssb.version = 0;
> +            vcssb.totalvc = qcs->count;
> +            vcssb.maxvc = MAX_CERTIFICATES;
> +            vcssb.maxvcelen = VCE_HEADER_LEN + qcs->max_cert_size;
> +            vcssb.largestvcblen = VCB_HEADER_LEN + vcssb.maxvcelen;
> +            vcssb.totalvcblen = VCB_HEADER_LEN + qcs->count * VCE_HEADER_LEN +
> +                                qcs->total_bytes;
> +        }
> +

Do we need this if check below? or can we move it above where we check 
for !qcs || !qcs->count?

> +        if (vcssb.length < 128) {
> +            rc = DIAG_320_RC_NOMEM;
> +            break;
> +        }
> +
> +        if (s390_cpu_virt_mem_write(cpu, addr, (uint8_t)r1, &vcssb,
> +                                    be64_to_cpu(
> +                                        sizeof(VerificationCertificateStorageSizeBlock)
> +                                    ))) {
> +            s390_cpu_virt_mem_handle_exc(cpu, ra);
> +            return;
> +        }
>           rc = DIAG_320_RC_OK;
>           break;
>       default:


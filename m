Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73854C369A2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 17:31:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3IDg-0003mF-E5; Fri, 11 Apr 2025 13:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1u3IDc-0003kE-Cn; Fri, 11 Apr 2025 13:31:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1u3IDY-0006sE-Iq; Fri, 11 Apr 2025 13:31:07 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BGjNBp024798;
 Fri, 11 Apr 2025 17:30:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=YwLKns
 WqxwmA2YHUrI1eO95xAhVIskxgziVoLMyd5Fk=; b=G7UT4EIoBrXGrxVoY6L281
 lfvJIbib5kE/OZJZoGdofnqdF7u8IBHiPBby/Fvhe2/nOTRkpi1w4Rp8PLHzkl8n
 3G6GurYPYc5NOqSGaXYAYo5dVQjOpDS4YJlryOdPQ6RWlu8SLNNE3e6bsqvO+Ere
 MivXg9i1dCWe8V1E9u/9idmfzQmroZprEUFXKhUGtZeVInXld1kGNYryk62qX9SN
 xLgfSUZSO/HEa/QEzOr9gvmAC+6uO+hqABoFNd7LSN/fcWXN3rg66yhSKOrtTzw/
 rfg9JI4nWKTuC16QN0y4vPJU3ufGddL4+Z7sDijUd5hfn+kTFTT5v+pp92/JEs8Q
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45xufabrky-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Apr 2025 17:30:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53BF2S16013858;
 Fri, 11 Apr 2025 17:30:49 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ufup404a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Apr 2025 17:30:49 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53BHUlja31392426
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Apr 2025 17:30:48 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE0255805E;
 Fri, 11 Apr 2025 17:30:47 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D5A3D58043;
 Fri, 11 Apr 2025 17:30:46 +0000 (GMT)
Received: from [9.67.45.136] (unknown [9.67.45.136])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 11 Apr 2025 17:30:46 +0000 (GMT)
Message-ID: <9b8674e7-719f-4309-af0a-44792c1e9d62@linux.ibm.com>
Date: Fri, 11 Apr 2025 13:30:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 09/24] s390x/diag: Implement DIAG 508 subcode 2 for
 signature verification
To: Thomas Huth <thuth@redhat.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 richard.henderson@linaro.org, david@redhat.com, pbonzini@redhat.com
Cc: jjherne@linux.ibm.com, jrossi@linux.ibm.com, fiuczy@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 iii@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20250408155527.123341-1-zycai@linux.ibm.com>
 <20250408155527.123341-10-zycai@linux.ibm.com>
 <6bc09c58-831b-4333-b8d1-17fe162eb359@redhat.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <6bc09c58-831b-4333-b8d1-17fe162eb359@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JSxbAP2GfyK22NkzmL9Pz5ZFLeNX12Gp
X-Proofpoint-ORIG-GUID: JSxbAP2GfyK22NkzmL9Pz5ZFLeNX12Gp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_06,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 priorityscore=1501 adultscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1011 suspectscore=0 malwarescore=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504110110
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
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

On 4/11/25 10:38 AM, Thomas Huth wrote:
> On 08/04/2025 17.55, Zhuoying Cai wrote:
>> From: Collin Walling <walling@linux.ibm.com>
>>
>> DIAG 508 subcode 2 performs signature-verfication on signed components.
>> A signed component may be a Linux kernel image, or any other signed
>> binary. **Verification of initrd is not supported.**
>>
>> The instruction call expects two item-pairs: an address of a device
>> component, an address of the analogous signature file (in PKCS#7 format),
>> and their respective lengths. All of this data should be encapsulated
>> within a Diag508SignatureVerificationBlock, with the CertificateStoreInfo
>> fields ignored. The DIAG handler will read from the provided addresses
>> to retrieve the necessary data, parse the signature file, then
>> perform the signature-verification. Because there is no way to
>> correlate a specific certificate to a component, each certificate
>> in the store is tried until either verification succeeds, or all
>> certs have been exhausted.
>>
>> The subcode value is denoted by setting the second-to-left-most bit of
>> a 2-byte field.
>>
>> A return code of 1 indicates success, and the index and length of the
>> corresponding certificate will be set in the CertificateStoreInfo
>> portion of the SigVerifBlock. The following values indicate failure:
>>
>> 	0x0402: component data is invalid
>> 	0x0502: certificate is not in x509 format
>> 	0x0602: signature is not in PKCS#7 format
>> 	0x0702: signature-verification failed
>>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> ---
>>   include/hw/s390x/ipl/diag508.h |  25 +++++++
>>   target/s390x/diag.c            | 131 ++++++++++++++++++++++++++++++++-
>>   2 files changed, 155 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/hw/s390x/ipl/diag508.h b/include/hw/s390x/ipl/diag508.h
>> index 83c4439cb2..f8f4b6398e 100644
>> --- a/include/hw/s390x/ipl/diag508.h
>> +++ b/include/hw/s390x/ipl/diag508.h
>> @@ -13,5 +13,30 @@
>>   #define S390X_DIAG508_H
>>   
>>   #define DIAG_508_SUBC_QUERY_SUBC    0x0000
>> +#define DIAG_508_SUBC_SIG_VERIF     0x4000
>> +
>> +#define DIAG_508_RC_OK              0x0001
>> +#define DIAG_508_RC_NO_CERTS        0x0102
>> +#define DIAG_508_RC_CERT_NOT_FOUND  0x0202
>> +#define DIAG_508_RC_NO_MEM_FOR_CERT 0x0302
>> +#define DIAG_508_RC_INVAL_COMP_DATA 0x0402
>> +#define DIAG_508_RC_INVAL_X509_CERT 0x0502
>> +#define DIAG_508_RC_INVAL_PKCS7_SIG 0x0602
>> +#define DIAG_508_RC_FAIL_VERIF      0x0702
>> +
>> +struct Diag508CertificateStoreInfo {
>> +    uint8_t  idx;
>> +    uint64_t len;
>> +} QEMU_PACKED;
>> +typedef struct Diag508CertificateStoreInfo Diag508CertificateStoreInfo;
>> +
>> +struct Diag508SignatureVerificationBlock {
>> +    Diag508CertificateStoreInfo csi;
>> +    uint64_t comp_len;
>> +    uint64_t comp_addr;
>> +    uint64_t sig_len;
>> +    uint64_t sig_addr;
>> +} QEMU_PACKED;
>> +typedef struct Diag508SignatureVerificationBlock Diag508SignatureVerificationBlock;
>>   
>>   #endif
>> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
>> index ad7f4b5025..cecb8bf130 100644
>> --- a/target/s390x/diag.c
>> +++ b/target/s390x/diag.c
>> @@ -25,6 +25,11 @@
>>   #include "target/s390x/kvm/pv.h"
>>   #include "qemu/error-report.h"
>>   
>> +#ifdef CONFIG_GNUTLS
>> +#include <gnutls/x509.h>
>> +#include <gnutls/gnutls.h>
>> +#include <gnutls/pkcs7.h>
>> +#endif /* CONFIG_GNUTLS */
>>   
>>   int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3)
>>   {
>> @@ -489,9 +494,67 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>>       env->regs[r1 + 1] = rc;
>>   }
>>   
>> +#ifdef CONFIG_GNUTLS
>> +#define datum_init(datum, data, size) \
>> +    datum = (gnutls_datum_t){data, size}
>> +
>> +static int diag_508_init_comp(gnutls_datum_t *comp,
>> +                              Diag508SignatureVerificationBlock *svb)
>> +{
>> +    uint8_t *svb_comp = NULL;
>> +
>> +    if (!svb->comp_len || !svb->comp_addr) {
>> +        error_report("No component data.");
>> +        return -1;
>> +    }
>> +
>> +    /*
>> +     * corrupted size vs. prev_size in fastbins, occurs during 2nd iteration,
>> +     * allocating 1mil bytes.
> 
> I don't understand that comment - could you elaborate?
> 

Elaboration: developer (me) forgot to remove this comment from an early
implementation.  It is irrelevant to the code presented here, sorry.

If you're curious:

<irrelevant>

I may be incorrect here, but from what I was able to gather, this issue
was encountered during a memory allocation, specifically without
properly freeing the previous component.

When allocating memory for the 2nd component (also the 2nd
invocation/iteration of this function), I would see the "corrupted size
vs prev_size in fastbins" error.  I think this is because the previous
component wasn't properly freed and there was a conflict between the
amount of space needed for the new component and however much was
available in the fastbins... debugging showed it was requesting 1mil bytes.

This has been corrected.

</irrelevant>

>> +     */
>> +    svb_comp = g_malloc0(svb->comp_len);
>> +    cpu_physical_memory_read(svb->comp_addr, svb_comp, svb->comp_len);
>> +
>> +    /*
>> +     * Component data is not written back to the caller,
>> +     * so no need to do a deep copy. Comp is freed when
>> +     * svb is freed.
>> +     */
>> +    datum_init(*comp, svb_comp, svb->comp_len);
>> +    return 0;
>> +}
>> +
>> +static int diag_508_init_signature(gnutls_pkcs7_t *sig,
>> +                                   Diag508SignatureVerificationBlock *svb)
>> +{
>> +    gnutls_datum_t datum_sig;
>> +    uint8_t *svb_sig = NULL;
>> +
>> +    if (!svb->sig_len || !svb->sig_addr) {
>> +        error_report("No signature data");
>> +        return -1;
>> +    }
>> +
>> +    svb_sig = g_malloc0(svb->sig_len);
>> +    cpu_physical_memory_read(svb->sig_addr, svb_sig, svb->sig_len);
>> +
>> +    if (gnutls_pkcs7_init(sig) < 0) {
>> +        error_report("Failed to initalize pkcs7 data.");
>> +        return -1;
>> +    }
>> +
>> +    datum_init(datum_sig, svb_sig, svb->sig_len);
>> +    return gnutls_pkcs7_import(*sig, &datum_sig, GNUTLS_X509_FMT_DER);
>> +
>> +}
>> +#endif /* CONFIG_GNUTLS */
>> +
>>   void handle_diag_508(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>>   {
>> +    S390IPLCertificateStore *qcs = s390_ipl_get_certificate_store();
>> +    size_t csi_size = sizeof(Diag508CertificateStoreInfo);
>>       uint64_t subcode = env->regs[r3];
>> +    uint64_t addr = env->regs[r1];
>>       int rc;
>>   
>>       if (env->psw.mask & PSW_MASK_PSTATE) {
>> @@ -506,7 +569,73 @@ void handle_diag_508(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>>   
>>       switch (subcode) {
>>       case DIAG_508_SUBC_QUERY_SUBC:
>> -        rc = 0;
>> +        rc = DIAG_508_SUBC_SIG_VERIF;
>> +        break;
>> +    case DIAG_508_SUBC_SIG_VERIF:
>> +        size_t svb_size = sizeof(Diag508SignatureVerificationBlock);
>> +        Diag508SignatureVerificationBlock *svb;
>> +
>> +        if (!qcs || !qcs->count) {
>> +            error_report("No certificates in cert store.");
> 
> Not sure whether we should print an error by default here ... it's likely 
> better to use a trace_...() function here, I think.
> 

The return value is likely sufficient enough, and the caller can decide
if it's necessary to print a message or handle it some other way.

>> +            rc = DIAG_508_RC_NO_CERTS;
>> +            break;
>> +        }
>> +
>> +        if (!diag_parm_addr_valid(addr, svb_size, false) ||
>> +            !diag_parm_addr_valid(addr, csi_size, true)) {
>> +            s390_program_interrupt(env, PGM_ADDRESSING, ra);
>> +            return;
>> +        }
>> +
>> +        svb = g_new0(Diag508SignatureVerificationBlock, 1);
>> +        cpu_physical_memory_read(addr, svb, svb_size);
> 
> Do you need to byteswap the read values with be_to_cpuXX() here?
> 

For cross-arch compliance, yeah... I'll fix that for next time.

>> +#ifdef CONFIG_GNUTLS
>> +        gnutls_pkcs7_t sig = NULL;
>> +        gnutls_datum_t comp;
>> +        int i;
>> +
>> +        if (diag_508_init_comp(&comp, svb) < 0) {
>> +            rc = DIAG_508_RC_INVAL_COMP_DATA;
>> +            g_free(svb);
>> +            break;
>> +        }
>> +
>> +        if (diag_508_init_signature(&sig, svb) < 0) {
>> +            rc = DIAG_508_RC_INVAL_PKCS7_SIG;
>> +            gnutls_pkcs7_deinit(sig);
>> +            g_free(svb);
>> +            break;
>> +        }
>> +
>> +        rc = DIAG_508_RC_FAIL_VERIF;
>> +        /*
>> +         * It is uncertain which certificate contains
>> +         * the analogous key to verify the signed data
>> +         */
>> +        for (i = 0; i < qcs->count; i++) {
>> +            gnutls_x509_crt_t g_cert = NULL;
>> +            if (g_init_cert((uint8_t *)qcs->certs[i].raw, qcs->certs[i].size, &g_cert)) {
>> +                continue;
>> +            }
>> +
>> +            if (gnutls_pkcs7_verify_direct(sig, g_cert, 0, &comp, 0) == 0) {
>> +                svb->csi.idx = i;
>> +                svb->csi.len = qcs->certs[i].size;
>> +                cpu_physical_memory_write(addr, &svb->csi,
>> +                                          be32_to_cpu(csi_size));
>> +                rc = DIAG_508_RC_OK;
>> +                break;
>> +            }
>> +
>> +            gnutls_x509_crt_deinit(g_cert);
>> +        }
>> +
>> +        gnutls_pkcs7_deinit(sig);
>> +#else
>> +        rc = DIAG_508_RC_FAIL_VERIF;
>> +#endif /* CONFIG_GNUTLS */
>> +        g_free(svb);
>>           break;
>>       default:
>>           s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> 
>   Thomas
> 
> 


-- 
Regards,
  Collin


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC29CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 21:33:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1tYU-0007cN-Gl; Thu, 25 Sep 2025 17:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1v1tYO-0007YJ-FO; Thu, 25 Sep 2025 17:31:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1v1tYE-0008A8-U2; Thu, 25 Sep 2025 17:31:02 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PImlcP029919;
 Thu, 25 Sep 2025 21:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=YwBC3h
 +Bhiak7XF9NXqw3YyWleXhPN9U7ra2GAkSIvM=; b=peVWiXczpOCImREzol2ulb
 7FwyyTDbt/HrAMGjtMeDClhRzhL7lSGXZqyOE/htXuDZoKbqaBGnF4AxKTcNMdas
 mT4tSjOfrYhnlXqnlSIpkD2HDmy8EQte9z7ZRoPfMFrGnIdrhj8M6y/zEXbpiHIJ
 kp/7lzINHRcvuddgtpluC6/POfja9s+ktVBEadDv9MmmdG77EzcnRdDQT2CHxWO6
 E9W8nzURaorJbd9wyFJjQLtoGtAzaKoH4xt3djthBkilgiVCv0mLchCz9+EzP73c
 NaHPfoYyQDBSRsfCrjbG4UzRgjXaEXCIWGNJaLVSgI6sVT8prV7+iXEcfH3iULng
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49dbbbgrg5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 21:30:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58PL50wd023732;
 Thu, 25 Sep 2025 21:30:46 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49ddbd038r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 21:30:46 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58PLUjaR19530336
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Sep 2025 21:30:45 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0110858045;
 Thu, 25 Sep 2025 21:30:45 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F94658052;
 Thu, 25 Sep 2025 21:30:43 +0000 (GMT)
Received: from [9.61.254.10] (unknown [9.61.254.10])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 25 Sep 2025 21:30:43 +0000 (GMT)
Message-ID: <4175d457-4a54-4df0-925a-bcc28b486194@linux.ibm.com>
Date: Thu, 25 Sep 2025 14:30:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/28] s390x/diag: Implement DIAG 508 subcode 1 for
 signature verification
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-13-zycai@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20250917232131.495848-13-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pJHF_JiC_4AuHxhaxujKb_MPdLs8-4v7
X-Authority-Analysis: v=2.4 cv=LakxKzfi c=1 sm=1 tr=0 ts=68d5b487 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=thS5O-zgTb_kNLbebe8A:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: pJHF_JiC_4AuHxhaxujKb_MPdLs8-4v7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3NCBTYWx0ZWRfX+kNQoqRI1cjB
 NiwVJhAq0o1ACSawJkiMzZsuIDa4bYea7HE4TVzpCoeWGG/GgixU9N9eA0XUEfN3xzpksVP6pWb
 xbfihAK8q9Y7+Ow7xd2umw4N8LDfkJe7hNdno75vzowX+l5JMzdzWPug0NkdPWEXvr/hev3mOKr
 UDq5T9wvJY/tAfG9C8zYU/QipUe8Ohk5TiqKcyL6T1EbyELbX6BZ72QD/TV/Sb+ZDO++U/sN0J6
 l4GBp4RNRAUN7TtmJewtCu31LYzy0Vc6bNHqxZ4ljoNiJ2jpEAcPuY+XaN/JVZPqmThfwuVjItX
 Q/NO2T+OwKXGgzh2ReOoiOBL2q3uwTTqvWNR144SY9Hy0o7jcCIaLc/yM4u3vqQVK5yoRH5JbNS
 deWxgU6+Shs507vf1kqAgNtPSP2z2Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_02,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250174
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
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


On 9/17/2025 4:21 PM, Zhuoying Cai wrote:
> From: Collin Walling <walling@linux.ibm.com>
>
> DIAG 508 subcode 1 performs signature-verification on signed components.
> A signed component may be a Linux kernel image, or any other signed
> binary. **Verification of initrd is not supported.**
>
> The instruction call expects two item-pairs: an address of a device
> component, an address of the analogous signature file (in PKCS#7 DER format),
> and their respective lengths. All of this data should be encapsulated
> within a Diag508SigVerifBlock.
>
> The DIAG handler will read from the provided addresses
> to retrieve the necessary data, parse the signature file, then
> perform the signature-verification. Because there is no way to
> correlate a specific certificate to a component, each certificate
> in the store is tried until either verification succeeds, or all
> certs have been exhausted.
>
> The subcode value is denoted by setting the second-to-left-most bit of
> a 2-byte field.
>
> A return code of 1 indicates success, and the index and length of the
> corresponding certificate will be set in the Diag508SigVerifBlock.
> The following values indicate failure:
>
> 	0x0102: certificate not available
> 	0x0202: component data is invalid
> 	0x0302: signature is not in PKCS#7 format
> 	0x0402: signature-verification failed
> 	0x0502: length of Diag508SigVerifBlock is invalid
>
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   docs/specs/s390x-secure-ipl.rst |   5 ++
>   include/hw/s390x/ipl/diag508.h  |  23 +++++++
>   target/s390x/diag.c             | 115 +++++++++++++++++++++++++++++++-
>   3 files changed, 142 insertions(+), 1 deletion(-)
>
> diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
> index 0919425e9a..eec368d17b 100644
> --- a/docs/specs/s390x-secure-ipl.rst
> +++ b/docs/specs/s390x-secure-ipl.rst
> @@ -66,3 +66,8 @@ that requires assistance from QEMU.
>   
>   Subcode 0 - query installed subcodes
>       Returns a 64-bit mask indicating which subcodes are supported.
> +
> +Subcode 1 - perform signature verification
> +    Perform signature-verification on a signed component, using certificates
> +    from the certificate store and leveraging qcrypto libraries to perform
> +    this operation.
> diff --git a/include/hw/s390x/ipl/diag508.h b/include/hw/s390x/ipl/diag508.h
> index 6281ad8299..ad401cc867 100644
> --- a/include/hw/s390x/ipl/diag508.h
> +++ b/include/hw/s390x/ipl/diag508.h
> @@ -11,5 +11,28 @@
>   #define S390X_DIAG508_H
>   
>   #define DIAG_508_SUBC_QUERY_SUBC    0x0000
> +#define DIAG_508_SUBC_SIG_VERIF     0x8000
> +
> +#define DIAG_508_RC_OK              0x0001
> +#define DIAG_508_RC_NO_CERTS        0x0102
> +#define DIAG_508_RC_INVAL_COMP_DATA 0x0202
> +#define DIAG_508_RC_INVAL_PKCS7_SIG 0x0302
> +#define DIAG_508_RC_FAIL_VERIF      0x0402
> +#define DIAG_508_RC_INVAL_LEN       0x0502
> +
> +struct Diag508SigVerifBlock {
> +    uint32_t length;
> +    uint8_t reserved0[3];
> +    uint8_t version;
> +    uint32_t reserved[2];
> +    uint8_t cert_store_index;
> +    uint8_t reserved1[7];
> +    uint64_t cert_len;
> +    uint64_t comp_len;
> +    uint64_t comp_addr;
> +    uint64_t sig_len;
> +    uint64_t sig_addr;
> +};
> +typedef struct Diag508SigVerifBlock Diag508SigVerifBlock;
>   
>   #endif
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index ee64257dbc..379fb8f2b4 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -602,9 +602,112 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>       }
>   }
>   
> +static int diag_508_verify_sig(uint8_t *cert, size_t cert_size,
> +                              uint8_t *comp, size_t comp_size,
> +                              uint8_t *sig, size_t sig_size)

Nit we could change the function definition from an int to bool, this 
would make reading easier.


> +{
> +    g_autofree uint8_t *sig_pem = NULL;
> +    size_t sig_size_pem;
> +    int rc;
> +
> +    /*
> +     * PKCS#7 signature with DER format
> +     * Convert to PEM format for signature verification
> +     */
> +    rc = qcrypto_pkcs7_convert_sig_pem(sig, sig_size, &sig_pem, &sig_size_pem, NULL);
> +    if (rc < 0) {
> +        return -1;
> +    }
> +
> +    rc = qcrypto_x509_verify_sig(cert, cert_size,
> +                                 comp, comp_size,
> +                                 sig_pem, sig_size_pem, NULL);
> +    if (rc < 0) {
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +static int handle_diag508_sig_verif(uint64_t addr, size_t svb_size,
> +                                    S390IPLCertificateStore *qcs)
> +{
> +    int rc;
> +    int verified;
> +    uint32_t svb_len;
> +    uint64_t comp_len, comp_addr;
> +    uint64_t sig_len, sig_addr;
> +    g_autofree uint8_t *svb_comp = NULL;
> +    g_autofree uint8_t *svb_sig = NULL;
> +    g_autofree Diag508SigVerifBlock *svb = NULL;
> +
> +    if (!qcs || !qcs->count) {
> +        return DIAG_508_RC_NO_CERTS;
> +    }
> +
> +    svb = g_new0(Diag508SigVerifBlock, 1);
> +    cpu_physical_memory_read(addr, svb, svb_size);
> +
> +    svb_len = be32_to_cpu(svb->length);
> +    if (svb_len != svb_size) {
> +        return DIAG_508_RC_INVAL_LEN;
> +    }
> +
> +    comp_len = be64_to_cpu(svb->comp_len);
> +    comp_addr = be64_to_cpu(svb->comp_addr);
> +    sig_len = be64_to_cpu(svb->sig_len);
> +    sig_addr = be64_to_cpu(svb->sig_addr);
> +
> +    if (!comp_len || !comp_addr) {
> +        return DIAG_508_RC_INVAL_COMP_DATA;
> +    }
> +
> +    if (!sig_len || !sig_addr) {
> +        return DIAG_508_RC_INVAL_PKCS7_SIG;
> +    }
> +
> +    svb_comp = g_malloc0(comp_len);
> +    cpu_physical_memory_read(comp_addr, svb_comp, comp_len);
> +
> +    svb_sig = g_malloc0(sig_len);
> +    cpu_physical_memory_read(sig_addr, svb_sig, sig_len);
> +
> +    rc = DIAG_508_RC_FAIL_VERIF;
> +    /*
> +     * It is uncertain which certificate contains
> +     * the analogous key to verify the signed data
> +     *
> +     * Ignore errors from signature format convertion and verification,
> +     * because currently in the certificate lookup process.
> +     *
> +     * Any error is treated as a verification failure,
> +     * and the final result (verified or not) will be reported later.
> +     */
> +    for (int i = 0; i < qcs->count; i++) {
> +        verified = diag_508_verify_sig(qcs->certs[i].raw,
> +                                       qcs->certs[i].size,
> +                                       svb_comp, comp_len,
> +                                       svb_sig, sig_len);
> +        if (verified == 0) {
> +            svb->cert_store_index = i;
> +            svb->cert_len = cpu_to_be64(qcs->certs[i].der_size);
> +            cpu_physical_memory_write(addr, svb, be32_to_cpu(svb_size));

Converting svb_size looks incorrect, shouldn't we just write svb_size 
bytes?

Thanks
Farhan



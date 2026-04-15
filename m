Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80AACF428C0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 18:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD54D-0003CH-Cy; Wed, 15 Apr 2026 14:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wD54B-0003BV-J7; Wed, 15 Apr 2026 14:34:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wD54A-0005Rd-1t; Wed, 15 Apr 2026 14:34:23 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63FGhlfo1860571; Wed, 15 Apr 2026 18:34:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=1wjMj9
 3p7t3olnWWKJ5pIfT+6p90JUDLmz6QV1xnGcM=; b=X22bgj3SQpt511DYmYKEEz
 fSJRpR8FvM2tXP73Nwi6PmO/BQWTtdR6TLVfsLZCi50rIGJtT+YmdVZoymoPivfo
 Ij4ZZ4sVHxOB8alzPvD4h2lnkR67JRC/e/MKKoTOySQlTchJuBshwnGBcXzv72Zs
 ImmqmzL7Tb1e2nXuKeXFcsIKjcFeKyB+pmajSt2uAMscT+IjqFtbF81lPikLTgn0
 S/xOLBjNE5GtonvQ2vE9CW1XgWtS8UCKiNQlV9udxjSbocScFNFzF0PDoEQ1CKHE
 Jym5RKIGAiQnPK/d5TSeZ5nwCsAmkaNpR7RYYD8NkQGaacA4CyKfhSMaieKBolVg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89ph2p9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Apr 2026 18:34:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63FGh1qF003514;
 Wed, 15 Apr 2026 18:34:16 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg1mnffjw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Apr 2026 18:34:16 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63FIYF3w6226822
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Apr 2026 18:34:15 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 37DFF58054;
 Wed, 15 Apr 2026 18:34:15 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 826F85805C;
 Wed, 15 Apr 2026 18:34:13 +0000 (GMT)
Received: from [9.61.11.27] (unknown [9.61.11.27])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 15 Apr 2026 18:34:13 +0000 (GMT)
Message-ID: <467038ec-7ef1-41e0-998c-e46faf15843a@linux.ibm.com>
Date: Wed, 15 Apr 2026 14:34:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 03/30] crypto/x509-utils: Add helper functions for
 certificate store
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, jrossi@linux.ibm.com,
 cohuck@redhat.com, richard.henderson@linaro.org,
 pierrick.bouvier@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com,
 brueckner@linux.ibm.com, jdaley@linux.ibm.com
References: <20260402221453.1602899-1-zycai@linux.ibm.com>
 <20260402221453.1602899-4-zycai@linux.ibm.com> <adUpGiQHAi2yoLmt@redhat.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <adUpGiQHAi2yoLmt@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DGO5K1ASEQ33S2rvUAQikSdIIIC0BuUY
X-Proofpoint-ORIG-GUID: DGO5K1ASEQ33S2rvUAQikSdIIIC0BuUY
X-Authority-Analysis: v=2.4 cv=WbE8rUhX c=1 sm=1 tr=0 ts=69dfda29 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=47wMCozZT2dH2ogIpjAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDE3MSBTYWx0ZWRfX6e3VWpgLVzWA
 2pjsRQFyuEVzNxH7yWh5jiWg+6HNrX4bNxfD6MWPp9FP9aata5PxD7Kn+lAFAku2SLZ11wgaMMP
 EaeWFyvL8T8H8W6cdKJb7ZXbuTdzQDxohQeVwlsZyvYCnn6XA+1cA0G0ttqr+u0Ay0sTZn4E0Q/
 baoGoLVMYX3j/g2qTQyMcJblCuaF6hIeU+fvED5DLA2ERAFZf/yuhmRoFUpbxmunj6n1o1iMpVA
 9l47FccCqfPiRHqInPejUBr5aJxupxfdZsztUY2fkfuoC7tskNzI5hNl8ZjnbB28uG47Bnbw9tl
 xWNil9K1oPthDdCBn5kQmsH2H6CWHE7eG73nfIsXHTtlImKKmvj1PTbNOrosDFCn6LZjH/t5OCC
 Qs+Duk0OA6rJx9XX4QgzhF2pmMAo9XdwhFP4yv4j38TWcN98jNMBLLdr3fR29b9kzOqueqlpjWM
 +pcD3P+9QtsQxa7gruw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 phishscore=0 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150171
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/7/26 11:56 AM, Daniel P. Berrangé wrote:
> On Thu, Apr 02, 2026 at 06:14:25PM -0400, Zhuoying Cai wrote:
>> Introduce new helper functions for x509 certificate, which will be used
>> by the certificate store:
>>
>> qcrypto_x509_convert_cert_der() - converts a certificate from PEM to DER format
>>
>> These functions provide support for certificate format conversion.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> Acked-by: Daniel P. Berrangé <berrange@redhat.com>
>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  crypto/x509-utils.c         | 49 +++++++++++++++++++++++++++++++++++++
>>  include/crypto/x509-utils.h | 21 ++++++++++++++++
>>  2 files changed, 70 insertions(+)
>>
>> diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
>> index 6176a88653..2696d48155 100644
>> --- a/crypto/x509-utils.c
>> +++ b/crypto/x509-utils.c
>> @@ -81,6 +81,46 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
>>      return ret;
>>  }
>>  
>> +int qcrypto_x509_convert_cert_der(uint8_t *cert, size_t size,
>> +                                  uint8_t **result, size_t *resultlen,
>> +                                  Error **errp)
>> +{
>> +    int ret = -1;
>> +    int rc;
>> +    gnutls_x509_crt_t crt;
>> +    gnutls_datum_t datum = {.data = cert, .size = size};
>> +    gnutls_datum_t datum_der = {.data = NULL, .size = 0};
>> +
>> +    rc = gnutls_x509_crt_init(&crt);
>> +    if (rc < 0) {
>> +        error_setg(errp, "Failed to initialize certificate: %s", gnutls_strerror(rc));
>> +        return ret;
>> +    }
>> +
>> +    rc = gnutls_x509_crt_import(crt, &datum, GNUTLS_X509_FMT_PEM);
>> +    if (rc != 0) {
>> +        error_setg(errp, "Failed to import certificate: %s", gnutls_strerror(rc));
>> +        goto cleanup;
>> +    }
>> +
>> +    rc = gnutls_x509_crt_export2(crt, GNUTLS_X509_FMT_DER, &datum_der);
>> +    if (rc != 0) {
>> +        error_setg(errp, "Failed to convert certificate to DER format: %s",
>> +                   gnutls_strerror(rc));
>> +        goto cleanup;
>> +    }
>> +
>> +    *resultlen = datum_der.size;
>> +    *result = g_memdup2(datum_der.data, datum_der.size);
>> +
>> +    ret = 0;
>> +
>> +cleanup:
>> +    gnutls_x509_crt_deinit(crt);
>> +    gnutls_free(datum_der.data);
> 
> Please use "g_free" here.
> 
> gnutls_free does nothing since gnutls deprecated gnutls_global_set_mem_functions
> and turned its impl into a no-op, but the use of gnutls_free will break builds
> with CFI enabled.
> 
> Same comment for the later patches to x509-utils.c that use gnutls_free.
> 
> With regards,
> Daniel

Thank you for the review! I’ll address this in the next version.



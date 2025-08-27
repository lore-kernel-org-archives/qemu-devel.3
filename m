Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2321ACA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 20:15:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urMX3-0001M6-NO; Wed, 27 Aug 2025 16:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1urMX0-0001Kv-G0; Wed, 27 Aug 2025 16:14:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1urMWs-00072V-Gz; Wed, 27 Aug 2025 16:14:05 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RGQj2N004119;
 Wed, 27 Aug 2025 20:13:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=pfumZT
 +IqB35jSO6QfOlaANoOSDHXWv+P22pd3I2Ghc=; b=iz4Vkys5Rtnr8d+BJLdk8T
 iNklFyU1kucwp1irlLs4YVHXzjfv9jsrUDcqMnFDok3XvgtZZ8Fd1fUWRiDGSj1e
 1i9udL8zqNBUPAHoYbi7lAhdzdhvBd/fQSX7jcFAabip6lMzfjapO8yMt44G1TwP
 hkGxpOUm6ZoleTEyDXe7aVT+YxQtW+epgQyDYw8WnCHokjyRcOfcCnXWM4Tdrjxx
 EFaNVcw6L3xgI5FpboZq2zneT1A0U3fYk2rpAvf0Elh4oMrV1TZBzbX3YfXU4AxW
 jH8eXlN+MP2932UpmNgow2/fJaGPWERpGOH9LB96Owvqk5wfZPgUF8v88NY943rA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q5586798-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Aug 2025 20:13:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57RGj5O9002512;
 Wed, 27 Aug 2025 20:13:50 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48qt6mhg0u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Aug 2025 20:13:50 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57RKDn4b20447832
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Aug 2025 20:13:49 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E46DF58053;
 Wed, 27 Aug 2025 20:13:48 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 695F858043;
 Wed, 27 Aug 2025 20:13:47 +0000 (GMT)
Received: from [9.61.169.198] (unknown [9.61.169.198])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 27 Aug 2025 20:13:47 +0000 (GMT)
Message-ID: <4ca3161b-5b72-4e2e-9688-4aa90ff7a769@linux.ibm.com>
Date: Wed, 27 Aug 2025 16:13:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/29] crypto/x509-utils: Add helper functions for
 certificate store
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com
References: <20250818214323.529501-1-zycai@linux.ibm.com>
 <20250818214323.529501-4-zycai@linux.ibm.com> <aK9ARYO83XACYPYZ@redhat.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <aK9ARYO83XACYPYZ@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ty99xhqrriZEzLXzbnR1ksI7hbKRBL10
X-Proofpoint-ORIG-GUID: Ty99xhqrriZEzLXzbnR1ksI7hbKRBL10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyMSBTYWx0ZWRfX8MpLuiPpa45n
 thiaBwRMR1zbvt2PYecy0JrzSIplo/r1noz7xpUtXRcv4aScsLORSqUP8gdk0UzzNEESv5+E6ri
 3cKywtt7CqovwkWbe13zqoshFRV9labzefVZUu38ZwViMGNnt9KTT+vrmFvs8eHQHWvrl9gyxJi
 o47NXC8ZmcEv91LoA7ROuA9arIyaz90Pd6d3Qt92IfhKl1xdAjQQUtmiSdgihOpRKiInK8jHbxJ
 giKXXcpD147LuM/TKIvX7luol10vMF3BHNZpzhe2QxovQwDxsRVKnrbYiz/FPs3XV5pwRyE+Jm4
 SJrRSCGhsLRvWIEPNFytTZuFtVAgtnH6OOpdZcCSuCXCnhEhv46Nb8p3Z6HqLAOnNRwI9v2dXuQ
 xTnvbTLW
X-Authority-Analysis: v=2.4 cv=A8ZsP7WG c=1 sm=1 tr=0 ts=68af66ff cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=KNvGAO5ahxd8gsMceYMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230021
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On 8/27/25 1:28 PM, Daniel P. Berrangé wrote:
> On Mon, Aug 18, 2025 at 05:42:56PM -0400, Zhuoying Cai wrote:
>> Introduce new helper functions for x509 certificate, which will be used
>> by the certificate store:
>>
>> qcrypto_x509_convert_cert_der() - converts a certificate from PEM to DER format
>>
>> These functions provide support for certificate format conversion.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> ---
>>  crypto/x509-utils.c         | 51 +++++++++++++++++++++++++++++++++++++
>>  include/crypto/x509-utils.h | 20 +++++++++++++++
>>  2 files changed, 71 insertions(+)
>>
>> diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
>> index 6176a88653..29d5146bb2 100644
>> --- a/crypto/x509-utils.c
>> +++ b/crypto/x509-utils.c
>> @@ -81,6 +81,48 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
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
>> +    if (*resultlen == 0) {
>> +        error_setg(errp, "Invalid buffer size");
>> +        goto cleanup;
>> +    }
> 
> Requiring resultlen to be set as an input parameter is strange, when
> this function is allocating the buffer. It would be better if we
> ignore resultlen on input and....
> 
> 
>> +
>> +    *result = g_malloc0(*resultlen);
>> +    rc = gnutls_x509_crt_export(crt, GNUTLS_X509_FMT_DER, *result, resultlen);
> 
> Use 'gnutls_x509_crt_export2' instead
> 
>      datum.data = NULL;
>      datum.size = 0;
>      rc = gnutls_x509_crt_export2(crt, GNUTLS_X509_FMT_DER, &datum);
>      if (rc != 0) {
>      ....
>      }
>      *result = g_new0(uint8_t, datum.size);
>      *resultlen = datum.size;
>      memcpy(result, datum.data, datum.size);
>      gnutls_free(datum.data);
> 

Thanks for the suggestion! I'll make the change in the next version.

>> +    if (rc != 0) {
>> +        error_setg(errp, "Failed to convert certificate to DER format: %s",
>> +                   gnutls_strerror(rc));
>> +        g_clear_pointer(result, g_free);
>> +        goto cleanup;
>> +    }
>> +
>> +    ret = 0;
>> +
>> +cleanup:
>> +    gnutls_x509_crt_deinit(crt);
>> +    return ret;
>> +}
>> +
>>  #else /* ! CONFIG_GNUTLS */
>>  
>>  int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
>> @@ -93,4 +135,13 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
>>      return -1;
>>  }
>>  
>> +int qcrypto_x509_convert_cert_der(uint8_t *cert, size_t size,
>> +                                  uint8_t **result,
>> +                                  size_t *resultlen,
>> +                                  Error **errp)
>> +{
>> +    error_setg(errp, "GNUTLS is required to export X.509 certificate");
>> +    return -1;
>> +}
>> +
>>  #endif /* ! CONFIG_GNUTLS */
>> diff --git a/include/crypto/x509-utils.h b/include/crypto/x509-utils.h
>> index 1e99661a71..4239e3e55a 100644
>> --- a/include/crypto/x509-utils.h
>> +++ b/include/crypto/x509-utils.h
>> @@ -19,4 +19,24 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
>>                                        size_t *resultlen,
>>                                        Error **errp);
>>  
>> +/**
>> + * qcrypto_x509_convert_cert_der
>> + * @cert: pointer to the raw certificate data in PEM format
>> + * @size: size of the certificate
>> + * @result: output location for the allocated buffer for the certificate in DER format
>> +            (the function allocates memory which must be freed by the caller)
>> + * @resultlen: pointer to the size of the buffer
>> +               (will be updated with the actual size of the DER-encoded certificate)
>> + * @errp: error pointer
>> + *
>> + * Convert the given @cert from PEM to DER format.
>> + *
>> + * Returns: 0 on success,
>> + *         -1 on error.
>> + */
>> +int qcrypto_x509_convert_cert_der(uint8_t *cert, size_t size,
>> +                                  uint8_t **result,
>> +                                  size_t *resultlen,
>> +                                  Error **errp);
>> +
>>  #endif
>> -- 
>> 2.50.1
>>
> 
> With regards,
> Daniel



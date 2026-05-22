Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6C7CD5BB1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 20:30:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQWVQ-0005Ux-5J; Fri, 22 May 2026 16:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1wQWVO-0005Tv-1f; Fri, 22 May 2026 16:30:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1wQWVI-00050Q-Q8; Fri, 22 May 2026 16:30:01 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MImoXv3991718; Fri, 22 May 2026 20:29:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=1WgJ0c
 geppuQm/EZ27UG+ipPrU6z2xDNVKFJpbTZGxI=; b=J3ET3+QUmEX6USAPNWRTzC
 REaPTwsr9LTcXwv3oupHEn3QAc1zCQ64q6nx+5bxH9E0sTBG1RHvpg1uIaALq7gu
 eSZ7uaOMb39XdyaZU+yniYWhUAcnDW/X/b9cbFjGwoVBq/Hyedl9L3hS5htUVDeb
 hpLaSZozZaAoganhl8GET29cLBYAWmp6Bk9eAgELQF/dj78Ncjl1XrHZmu71uAlm
 zxWrqLj6+wWrKgRNcrLR25RGiCbyercPzl9Lfhgjw8h1o9hLUBkHwSWokUCdmVOY
 dKLdh3skLHZfU0SZ+oaNcsqPJvHjxNvY5aK2LRALBl1rjh9kBXKiugTzVJqDz+DA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb8v61r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 May 2026 20:29:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64MKO3Fd015976;
 Fri, 22 May 2026 20:29:43 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75kyj8vx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 May 2026 20:29:43 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64MKTga516908854
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 May 2026 20:29:42 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7F87A5805B;
 Fri, 22 May 2026 20:29:42 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7E51358058;
 Fri, 22 May 2026 20:29:40 +0000 (GMT)
Received: from [9.67.42.213] (unknown [9.67.42.213])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 22 May 2026 20:29:40 +0000 (GMT)
Message-ID: <3c8e7119-3c36-40c0-9f41-ca362874ce44@linux.ibm.com>
Date: Fri, 22 May 2026 16:29:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Collin Walling <walling@linux.ibm.com>
Subject: Re: [PATCH v11 08/32] crypto/x509-utils: Add helper functions for
 DIAG 320 subcode 2
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260505201905.997996-1-zycai@linux.ibm.com>
 <20260505201905.997996-9-zycai@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260505201905.997996-9-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIwMCBTYWx0ZWRfX2CXQ+PWou6ME
 GXB90RU5tHCDfa73hCHDeuGijmBOSSCQw7IAsnd4D7n4s8CA0wyV6LaxMJUQd0Jui8G0dbziQij
 YLzseOuzwj5h3NFVLndF/Z5CgnYVyG/UUmlCY1dYElbUZsyyWuVrKf3zJOMTB7mlKhGA/e4BNZx
 svX4ihWITlJ/6n8uZCAcsZnVHPjL8QSJ07fDDNWeTqoePjwiY7x/HAWig9AO4RTPNnfpDUoox5c
 UjvZjVa3u3IuTVgCFChcjy4sX32/fLoptoJnB7jwZ8d8z8ZZcnD1o9sc4vqdwicypA2aI0sUsl8
 f3Omru50asPLW99778Q3xPcztxqjV5IVCF1BB/MJ41RtovDFpX8cl9/9Lel1JE1hz/y4LtIP8Mi
 iopFZnVJWRlhKoKl8VTe32k8vZEowCQDL2bf7eXCXdH/IuVtBRXWdstk5DMvUtIEwNaxRZpcY1u
 Iy/nX4UvUjqOBCKjvSQ==
X-Proofpoint-GUID: POvsLTc_4xLNxgygB8mhp4M8pCB5PejD
X-Proofpoint-ORIG-GUID: POvsLTc_4xLNxgygB8mhp4M8pCB5PejD
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a10bcb8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=hyd8jlXqhlslFZ8SLwYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220200
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/5/26 16:18, Zhuoying Cai wrote:
> Introduce new helper functions to extract certificate metadata:

Just a few typos.

> +int qcrypto_x509_get_cert_key_id(uint8_t *cert, size_t size,
> +                                 QCryptoHashAlgo hash_alg,
> +                                 uint8_t **result,
> +                                 size_t *resultlen,
> +                                 Error **errp)
> +{
> +    int rc;
> +    int ret = -1;
> +    gnutls_x509_crt_t crt;
> +    gnutls_datum_t datum = {.data = cert, .size = size};
> +
> +    if (hash_alg >= G_N_ELEMENTS(qcrypto_to_gnutls_hash_alg_map)) {
> +        error_setg(errp, "Unknown hash algorithm %d", hash_alg);
> +        return ret;
> +    }
> +
> +    if (hash_alg >= G_N_ELEMENTS(qcrypto_to_gnutls_keyid_flags_map) ||
> +        qcrypto_to_gnutls_keyid_flags_map[hash_alg] == -1) {
> +        error_setg(errp, "Unsupported key id flag %d", hash_alg);
> +        return ret;
> +    }
> +
> +    rc = gnutls_x509_crt_init(&crt);
> +    if (rc < 0) {
> +        error_setg(errp, "Failed to initialize certificate: %s", gnutls_strerror(rc));
> +        return ret;
> +    }
> +
> +    rc = gnutls_x509_crt_import(crt, &datum, GNUTLS_X509_FMT_PEM);
> +    if (rc != 0) {
> +        error_setg(errp, "Failed to import certificate: %s", gnutls_strerror(rc));
> +        goto cleanup;
> +    }
> +
> +    *resultlen = gnutls_hash_get_len(qcrypto_to_gnutls_hash_alg_map[hash_alg]);
> +    if (*resultlen == 0) {
> +        error_setg(errp, "Failed to get hash algorithn length: %s", gnutls_strerror(rc));

s/algorithn/algorithm

> +        goto cleanup;
> +    }
> +

[...]

> +/**
> + * qcrypto_x509_check_cert_times
> + * @cert: pointer to the raw certificate data
> + * @size: size of the certificate
> + * @errp: error pointer
> + *
> + * Check whether the activation and expiration times of @cert
> + * are valid at the current time.
> + *
> + * Returns: 0 if the certificate times are valid,
> + *         -1 on error.
> + */
> +int qcrypto_x509_check_cert_times(uint8_t *cert, size_t size, Error **errp);
> +
> +/**
> + * qcrypto_x509_get_cert_key_id
> + * @cert: pointer to the raw certificate data
> + * @size: size of the certificate
> + * @hash_alg: the hash algorithm flag
> + * @result: output location for the allocated buffer for key ID
> + *          (the function allocates memory which must be freed by the caller)
> + * @resultlen: pointer to the size of the buffer
> + *             (will be updated with the actual size of key id)
> + * @errp: error pointer
> + *
> + * Retrieve the key ID from the @cert based on the specified @flag.

s/@flag/@hash_alg ?


-- 
Regards,
  Collin


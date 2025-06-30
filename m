Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E29C83033
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 19:57:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWKcm-0001rU-AY; Mon, 30 Jun 2025 15:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uWKck-0001rA-H0; Mon, 30 Jun 2025 15:57:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uWKch-0007Iz-QH; Mon, 30 Jun 2025 15:57:06 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UIos8a028339;
 Mon, 30 Jun 2025 19:57:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=rC4Wm4
 TDF5YFPzN14ja7NJkakVqIl562E+MlHeMJJbM=; b=p5hGLkOoD7jP68/4RmGacF
 SAzZ7idoMAHVRRXplngrVVoLrlvgo8uZr7fDW/VxvtDJbZmSfB7ZmltY2qDv2BZG
 XSFK13h7RPGoRNYuz0iHz9jG1lW6xE+hxMgyh911rigpO9eidva4EGeOtfhSqsMd
 Rvz0AdwR3zRX7BkIO16vCKPaFu+KDslRJg2nEFVH2e9k+h4nmy7DRwlfNiGZvt8S
 7D5/fPi1e0od9AvLtCGGfkTx44vs5q+nQs6lCd2l1keVWFzCotqUhVya+0l1zzNe
 g/uLBgWXlqywtbFmpB4mg0gwAGTEFebcyKSZcliHn+pRM9o+2ivr09t58iXa6O0Q
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j84d3fqs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Jun 2025 19:57:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55UHUEcN032152;
 Mon, 30 Jun 2025 19:56:58 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47ju40fhax-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Jun 2025 19:56:58 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55UJuvGC16515640
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Jun 2025 19:56:57 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D6C45805C;
 Mon, 30 Jun 2025 19:56:57 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 88F805805A;
 Mon, 30 Jun 2025 19:56:56 +0000 (GMT)
Received: from [9.61.110.65] (unknown [9.61.110.65])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 30 Jun 2025 19:56:56 +0000 (GMT)
Message-ID: <b88c390b-13f0-464f-8aff-006c33a532b0@linux.ibm.com>
Date: Mon, 30 Jun 2025 15:56:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/28] hw/s390x/ipl: Create certificate store
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com, walling@linux.ibm.com, jjherne@linux.ibm.com,
 jrossi@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20250604215657.528142-1-zycai@linux.ibm.com>
 <20250604215657.528142-4-zycai@linux.ibm.com> <aELDf8--oCzcfhFI@redhat.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <aELDf8--oCzcfhFI@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Qt7ARf_zviLT0QLG3SglIVxQKbIDu9IN
X-Proofpoint-GUID: Qt7ARf_zviLT0QLG3SglIVxQKbIDu9IN
X-Authority-Analysis: v=2.4 cv=Ib6HWXqa c=1 sm=1 tr=0 ts=6862ec0c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=mfbu073g6v7wgpRefhYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDE2MiBTYWx0ZWRfX4W3448/vgFRQ
 OVZEBtVsgRHn3dvDOD68slgOr0ZVEE4YBGAPILrkX5ERUE6LMoHezZ2Lf2PTN4pkhWImmbIgDBu
 2nWw87J8+5VTCEMoH5kdXpps+gD02+N8a4WPn+1RXPHfTDeFHJ1Z35RhIx/cOh5Q2xgH0G9SSVj
 T+0K5/NXFS3Fiu31dc5X1UoTP/R1ZgCi34TGCAQpmklaWBb4NTinOCkcSPoYBs1Ij+x2UDh8oq5
 Nz5OqE/JdwKzydqKsB/KgZE3UP6qbUfKM3Y5r8ce10xz8XsM5HQV/LOiFHU7w+LKxzxsssQMpRq
 ogZqfiw4cSqsuLnTrRb11CmE3Mj2HCvfyBw/p5gYQjI2VMmcJ1LdMzH4wpYq8LLCCZ/mKiq7HJb
 +H2vj5i2T7S8r+WZe4CJxREVBpkDfav/bzBmelDk7cMMdhuIz/4V4h07UkjMpaOKy0R2EGck
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_04,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300162
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 6/6/25 6:31 AM, Daniel P. Berrangé wrote:
> On Wed, Jun 04, 2025 at 05:56:31PM -0400, Zhuoying Cai wrote:
>> Create a certificate store for boot certificates used for secure IPL.
>>
>> Load certificates from the boot-certificate parameter of s390-ccw-virtio
>> machine type option into the cert store.
>>
>> Currently, only x509 certificates in DER format and uses SHA-256 hashing
>> algorithm are supported, as these are the types required for secure boot
>> on s390.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> ---
>>  hw/s390x/cert-store.c       | 247 ++++++++++++++++++++++++++++++++++++
>>  hw/s390x/cert-store.h       |  39 ++++++
>>  hw/s390x/ipl.c              |   9 ++
>>  hw/s390x/ipl.h              |   3 +
>>  hw/s390x/meson.build        |   1 +
>>  include/hw/s390x/ipl/qipl.h |   3 +
>>  6 files changed, 302 insertions(+)
>>  create mode 100644 hw/s390x/cert-store.c
>>  create mode 100644 hw/s390x/cert-store.h
>>
>> diff --git a/hw/s390x/cert-store.c b/hw/s390x/cert-store.c
>> new file mode 100644
>> index 0000000000..562fa22241
>> --- /dev/null
>> +++ b/hw/s390x/cert-store.c
>> @@ -0,0 +1,247 @@
>> +/*
>> + * S390 certificate store implementation
>> + *
>> + * Copyright 2025 IBM Corp.
>> + * Author(s): Zhuoying Cai <zycai@linux.ibm.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "cert-store.h"
>> +#include "qemu/error-report.h"
>> +#include "qemu/option.h"
>> +#include "qemu/config-file.h"
>> +#include "hw/s390x/ebcdic.h"
>> +#include "hw/s390x/s390-virtio-ccw.h"
>> +#include "qemu/cutils.h"
>> +#include "crypto/x509-utils.h"
>> +
>> +static const char *s390_get_boot_certificates(void)
>> +{
>> +    return S390_CCW_MACHINE(qdev_get_machine())->boot_certificates;
>> +}
>> +
>> +static size_t cert2buf(char *path, size_t max_size, char **cert_buf)
>> +{
>> +    size_t size;
>> +
>> +    /*
>> +     * maximum allowed size of the certificate file to avoid consuming excessive memory
>> +     * (malformed or maliciously large files)
>> +     */
>> +    if (!g_file_get_contents(path, cert_buf, &size, NULL) ||
>> +        size == 0 || size > max_size) {
> 
> By the time this 'size > max_size' check is performed, the file
> is already loaded into memory, which is fairly pointless. In
> existing code loading certs we don't enforce any max size. This
> data comes from the host admin who QEMU has to assume is trusted,
> so the size check is not required.
> 
>> +        return 0;
>> +    }
>> +
>> +    return size;
>> +}
>> +
>> +static S390IPLCertificate *init_cert_x509_der(size_t size, char *raw)
>> +{
>> +    S390IPLCertificate *q_cert = NULL;
>> +    int key_id_size;
>> +    int hash_size;
>> +    int is_der;
>> +    int hash_type;
>> +    Error *err = NULL;
>> +
>> +    is_der = qcrypto_check_x509_cert_fmt((uint8_t *)raw, size,
>> +                                         QCRYPTO_CERT_FMT_DER, &err);
>> +    /* return early if GNUTLS is not enabled */
>> +    if (is_der == -ENOTSUP) {
>> +        error_report("GNUTLS is not enabled");
>> +        return NULL;
>> +    }
>> +    if (is_der != 0) {
>> +        error_report("The certificate is not in DER format");
>> +        return NULL;
>> +    }
> 
> As mentioned in the other patch, we should exclusively accept PEM
> format as the public interface. If we need DER format internllay,
> gnutls_x509_cert_export can convert it into DER for us.
> 
>> +
>> +    hash_type = qcrypto_get_x509_signature_algorithm((uint8_t *)raw, size, &err);
>> +    if (hash_type != QCRYPTO_SIG_ALGO_RSA_SHA256) {
>> +        error_report("The certificate does not use SHA-256 hashing");
>> +        return NULL;
>> +    }
>> +
>> +    key_id_size = qcrypto_get_x509_keyid_len(QCRYPTO_KEYID_FLAGS_SHA256);
>> +    if (key_id_size == 0) {
>> +        error_report("Failed to get certificate key ID size");
>> +        return NULL;
>> +    }
>> +
>> +    hash_size = qcrypto_get_x509_hash_len(QCRYPTO_HASH_ALGO_SHA256);
>> +    if (hash_size == 0) {
>> +        error_report("Failed to get certificate hash size");
>> +        return NULL;
>> +    }
> 
> Pointless method call when we have a QCRYPTO_HASH_DIGEST_LEN_SHA256
> constant.
> 
>> +
>> +    q_cert = g_new(S390IPLCertificate, 1);
> 
> g_new0 to guarantee zero initialization of all fields.
> 
>> +    q_cert->size = size;
>> +    q_cert->key_id_size = key_id_size;
>> +    q_cert->hash_size = hash_size;
>> +    q_cert->raw = raw;
>> +    q_cert->format = QCRYPTO_CERT_FMT_DER;
>> +    q_cert->hash_type = QCRYPTO_SIG_ALGO_RSA_SHA256;
>> +
>> +    return q_cert;
>> +}
>> +
>> +static int check_path_type(const char *path)
>> +{
>> +    struct stat path_stat;
>> +
>> +    if (stat(path, &path_stat) != 0) {
>> +        perror("stat");
>> +        return -1;
>> +    }
>> +
>> +    if (S_ISDIR(path_stat.st_mode)) {
>> +        return S_IFDIR;
>> +    } else if (S_ISREG(path_stat.st_mode)) {
>> +        return S_IFREG;
>> +    } else {
>> +        return -1;
>> +    }
>> +}
> 
> This helper isn't making the code any simpler - use the
> stat() & S_ISXXX checks inline where needed.
> 
>> +static S390IPLCertificate *init_cert(char *paths)
> 
> s/paths/path/ as this is a single file being used.
> 
>> +{
>> +    char *buf;
>> +    char vc_name[VC_NAME_LEN_BYTES];
>> +    g_autofree gchar *filename;
> 
> All g_autofree variables *must* be initialized at time
> of declaration. 
> 
>> +    size_t size;
>> +    S390IPLCertificate *qcert = NULL;
>> +
>> +    filename = g_path_get_basename(paths);
>> +
>> +    size = cert2buf(paths, CERT_MAX_SIZE, &buf);
>> +    if (size == 0) {
>> +        error_report("Failed to load certificate: %s", paths);
>> +        g_free(buf);
>> +        return NULL;
>> +    }
>> +
>> +    qcert = init_cert_x509_der(size, buf);
>> +    if (qcert == NULL) {
>> +        error_report("Failed to initialize certificate: %s", paths);
>> +        g_free(buf);
>> +        return NULL;
>> +    }
>> +
>> +    /*
>> +     * Left justified certificate name with padding on the right with blanks.
>> +     * Convert certificate name to EBCDIC.
>> +     */
>> +    strpadcpy(vc_name, VC_NAME_LEN_BYTES, filename, ' ');
> 
> What purpose does the 'vc_name' serve ? Are there expectations
> on the user for naming of the cert fiels ?
> 

vc_name refers to the name of the certificate, along with other
certificate metadata, which could be retrieved and displayed via the
DIAG320 invocation. This information is available to the Linux root user
through the cert_store keyring.

The certificate name is expected to consist of ASCII characters.

>> [snip..]



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 898F5CD5BAC
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 20:31:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQWWo-0006Ry-93; Fri, 22 May 2026 16:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1wQWWX-00062Y-CI; Fri, 22 May 2026 16:31:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1wQWWU-0006yN-Mv; Fri, 22 May 2026 16:31:13 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64ME0gEr1950620; Fri, 22 May 2026 20:31:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=1CXIIt
 e1jx2bkWlGzCwAEwGkLRsQ/xBsdAki1I3SNAo=; b=o3VyvUCNhSmbbXMndqUba9
 yKa3fgEORh798qmr+JMoMONEqvs8InnpMoaiTFwxF2Z9hlfu9bFfXQXovvC1IaMp
 kW/0d5OAkFYCNqGcAQCpXz2HZDGqYlfsiuxHmsv1pe+rFJkr6iCdkE6v+eGXvgUB
 eudtCh1cov8cy9fCg4QN3wc//VW27/o/dbzlwsIc+L2pG1Gy+rN62UOreHq246Pm
 0aaa/KbE587/3doRFJBKaJOPeDFP2JBF87NwJvAe7LXGabUFJq1/i9/hq/YljM5k
 rWoMZSk8uJffv8iRsznSPko+dIUf5c8s9cAafOMst+fLVcGI33buxiwqAdg+Drjw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h88v79g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 May 2026 20:31:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64MKO5kx015991;
 Fri, 22 May 2026 20:31:05 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75kyj922-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 May 2026 20:31:05 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64MKV4WD27656734
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 May 2026 20:31:04 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 83B1858059;
 Fri, 22 May 2026 20:31:04 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9DFC05805E;
 Fri, 22 May 2026 20:31:02 +0000 (GMT)
Received: from [9.67.42.213] (unknown [9.67.42.213])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 22 May 2026 20:31:02 +0000 (GMT)
Message-ID: <7e410b08-2a87-450e-87db-2cb218e57d5d@linux.ibm.com>
Date: Fri, 22 May 2026 16:31:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Collin Walling <walling@linux.ibm.com>
Subject: Re: [PATCH v11 04/32] hw/s390x/ipl: Create certificate store
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260505201905.997996-1-zycai@linux.ibm.com>
 <20260505201905.997996-5-zycai@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260505201905.997996-5-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SjeBhZUcVdbJkRSCjVmpIwvxOMPPTMb4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIwMCBTYWx0ZWRfX/iDOj4H+jIhJ
 khq7HLrGA0ET/HFSTRGIKo9VQNviB8vPLS0EaXKvTHUUfhogkOI4P7XrdusDA9TZDWeyu9CEffu
 5pDNzLtCSftmTz/KN1r4gId66ctnjFo+/5hCLcIVfDcCUs53dM1xVSB3DmOy7rluFT9UIhy6uhC
 zW5jMCI64cSrf21BAqseKhNY21Ra2KGh+Q4iNAn6aGDXx5M1LEBQ9uXP2zQqSeNdSYLVBpGYPI+
 hDTScHXXO43B2U9fChZrE8Ld3rECf6qldicELT1giLwaRkQudKfBxNGCp58NXz/GHGdZjrJNWXa
 EEkjb6XDE1Tnrng/r7dp/M8vPaghudvbJXPqTr+cwdK6OZlVbXsCTC/mkIGa7sKbS0UszZyMBS0
 FMRAdGf+M6qYm4HuUeC3wGIOcvVCznUMb9TSMVyO9Hr0NXg7gTGkeoJX34toBPbnRAoIF+A0Igy
 /48fshsF3XNxzyWeGVg==
X-Proofpoint-GUID: SjeBhZUcVdbJkRSCjVmpIwvxOMPPTMb4
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a10bd0a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=68yJAY_iaQW1tmUG3LIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220200
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
> Create a certificate store for boot certificates used for secure IPL.
> 
> Load certificates from the `boot-certs` parameter of s390-ccw-virtio
> machine type option into the cert store.
> 
> Currently, only X.509 certificates in PEM format are supported, as the
> QEMU command line accepts certificates in PEM format only.

Let's add more context here:

"The raw Base64 data is stored, as well as the certificate's size.  The
binary (DER) size is stored as well, which may later be utilized for
secure boot (signature verification)."

> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Farhan Ali<alifm@linux.ibm.com>
> ---
>  docs/specs/index.rst            |   1 +
>  docs/specs/s390x-secure-ipl.rst |  16 +++
>  hw/s390x/cert-store.c           | 221 ++++++++++++++++++++++++++++++++
>  hw/s390x/cert-store.h           |  39 ++++++
>  hw/s390x/ipl.c                  |  10 ++
>  hw/s390x/ipl.h                  |   3 +
>  hw/s390x/meson.build            |   1 +
>  include/hw/s390x/ipl/qipl.h     |   2 +
>  8 files changed, 293 insertions(+)
>  create mode 100644 docs/specs/s390x-secure-ipl.rst
>  create mode 100644 hw/s390x/cert-store.c
>  create mode 100644 hw/s390x/cert-store.h
> 
> diff --git a/docs/specs/index.rst b/docs/specs/index.rst
> index b7909a108a..76d439782c 100644
> --- a/docs/specs/index.rst
> +++ b/docs/specs/index.rst
> @@ -40,3 +40,4 @@ guest hardware that is specific to QEMU.
>     riscv-aia
>     aspeed-intc
>     iommu-testdev
> +   s390x-secure-ipl
> diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
> new file mode 100644
> index 0000000000..1cdf19783f
> --- /dev/null
> +++ b/docs/specs/s390x-secure-ipl.rst
> @@ -0,0 +1,16 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +s390 Certificate Store and Functions
> +------------------------------------
> +
> +s390 Certificate Store
> +^^^^^^^^^^^^^^^^^^^^^^
> +
> +A certificate store is implemented for s390-ccw guests to retain within
> +memory all certificates provided by the user via the command-line, which
> +are expected to be stored somewhere on the host's file system. The store
> +will keep track of the number of certificates, their respective size,
> +and a summation of the sizes.

Add:

"Each certificate is stroed in an S390IPLCertificate struct, which has a
name (converted to EBCDIC), size fields of PEM and DER data, and the raw
PEM Base64 data."

> +
> +Note: A maximum of 64 certificates are allowed to be stored in the certificate
> +store.
> diff --git a/hw/s390x/cert-store.c b/hw/s390x/cert-store.c
> new file mode 100644
> index 0000000000..a4f15627e9
> --- /dev/null
> +++ b/hw/s390x/cert-store.c
> @@ -0,0 +1,221 @@
> +/*
> + * S390 certificate store implementation
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Zhuoying Cai <zycai@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "cert-store.h"
> +#include "qapi/error.h"
> +#include "qemu/error-report.h"
> +#include "qemu/option.h"
> +#include "qemu/config-file.h"
> +#include "hw/s390x/ebcdic.h"
> +#include "hw/s390x/s390-virtio-ccw.h"
> +#include "qemu/cutils.h"
> +#include "crypto/x509-utils.h"
> +#include "qapi/qapi-types-machine-s390x.h"
> +
> +static BootCertificatesList *s390_get_boot_certs(void)
> +{
> +    return S390_CCW_MACHINE(qdev_get_machine())->boot_certs;
> +}
> +
> +static S390IPLCertificate *init_cert(char *path, Error **errp)
> +{
> +    int rc;
> +    char *buf;

What about g_autofree for buf...

> +    size_t size;
> +    size_t der_len;
> +    char name[CERT_NAME_MAX_LEN];
> +    g_autofree gchar *filename = NULL;
> +    S390IPLCertificate *cert = NULL;
> +    g_autofree uint8_t *cert_der = NULL;
> +    Error *local_err = NULL;
> +
> +    filename = g_path_get_basename(path);
> +
> +    if (!g_file_get_contents(path, &buf, &size, NULL)) {
> +        error_setg(errp, "Failed to load certificate: %s", path);
> +        return NULL;
> +    }
> +
> +    rc = qcrypto_x509_convert_cert_der((uint8_t *)buf, size,
> +                                       &cert_der, &der_len, &local_err);
> +    if (rc != 0) {
> +        error_propagate_prepend(errp, local_err,
> +                                "Failed to initialize certificate: %s: ", path);
> +        g_free(buf);

...this could go away...

> +        return NULL;
> +    }
> +
> +    cert = g_new0(S390IPLCertificate, 1);
> +    cert->size = size;
> +    /*
> +     * Store DER length only - reused for size calculation.
> +     * cert_der is discarded because DER certificate data will be used once
> +     * and can be regenerated from cert->raw.
> +     */
> +    cert->der_size = der_len;
> +    /* store raw pointer - ownership transfers to cert */
> +    cert->raw = (uint8_t *)buf;

...then use g_steal_pointer.  It'll read better and the comment wouldn't
be needed to explain what's happening.

> +
> +    /*
> +     * Left justified certificate name with padding on the right with blanks.
> +     * Convert certificate name to EBCDIC.
> +     */
> +    strpadcpy(name, CERT_NAME_MAX_LEN, filename, ' ');
> +    ebcdic_put(cert->name, name, CERT_NAME_MAX_LEN);
> +
> +    return cert;
> +}
> +
> +static void update_cert_store(S390IPLCertificateStore *cert_store,
> +                              S390IPLCertificate *cert)
> +{
> +    size_t data_buf_size;
> +    size_t keyid_buf_size;
> +    size_t hash_buf_size;
> +    size_t cert_buf_size;
> +
> +    /* length field is word aligned for later DIAG use */
> +    keyid_buf_size = ROUND_UP(CERT_KEY_ID_LEN, 4);
> +    hash_buf_size = ROUND_UP(CERT_HASH_LEN, 4);
> +    cert_buf_size = ROUND_UP(cert->der_size, 4);
> +    data_buf_size = keyid_buf_size + hash_buf_size + cert_buf_size;
> +
> +    if (cert_store->largest_cert_size < data_buf_size) {
> +        cert_store->largest_cert_size = data_buf_size;
> +    }
> +
> +    g_assert(cert_store->count < MAX_CERTIFICATES);
> +
> +    cert_store->certs[cert_store->count] = *cert;

Should a g_steal_pointer be used here?

> +    cert_store->total_bytes += data_buf_size;
> +    cert_store->count++;
> +}
> +

Functionally, things look good to me.

-- 
Regards,
  Collin


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2956ED1D48A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 21:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdxWX-0007Wj-5c; Thu, 08 Jan 2026 16:26:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vdxWU-0007Jm-7Y; Thu, 08 Jan 2026 16:26:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vdxWR-0007G3-PX; Thu, 08 Jan 2026 16:26:25 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 608Dmdac004343;
 Thu, 8 Jan 2026 21:26:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=fgMU4y
 RIgG/1kGsQn2Jua1qrh1oKWEgyIgvnGsdOMwk=; b=AdAr05Qxv3Fnn5ZTrUHKft
 ulojfEmrKAiuCkYLBJ/s+bLR5pZf+yWyv2y5SW9xOj0X6OGvvEExNFALsJT56nGs
 z1CCapBxIW7nKtSIeq6Ff8RDsnRNufYCKluX6fSBbpq3cI3IkMsSBzONwxi8+9Uk
 5gPQ1N4NBjsOfaLOoH2TlK3XUTC5GyPN3gyyAoqtB/fi80ldqRCOCUfgjvIvRBIR
 +B2kXGFRfkAfXwLo1lp7faCSEyDY9pWnqJRGwnZmUS1yWsNRxb2xL25a9x3/qrsQ
 jtS0rVGQhmFFlR3zNvp+VGa/4RBGS1M49k8anW90vXOM62GhEFcqEFupxsibE3Fg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betm7gg33-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Jan 2026 21:26:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 608J79kg014528;
 Thu, 8 Jan 2026 21:26:19 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bfeen9cv6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Jan 2026 21:26:19 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 608LPxDo61735176
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 Jan 2026 21:26:00 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 829C358063;
 Thu,  8 Jan 2026 21:26:17 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 77F1F5803F;
 Thu,  8 Jan 2026 21:26:16 +0000 (GMT)
Received: from [9.61.151.176] (unknown [9.61.151.176])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  8 Jan 2026 21:26:16 +0000 (GMT)
Message-ID: <fe035311-cc17-41fe-aad8-cec5c37a5d03@linux.ibm.com>
Date: Thu, 8 Jan 2026 16:26:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Zhuoying Cai <zycai@linux.ibm.com>
Subject: Re: [PATCH v7 04/29] hw/s390x/ipl: Create certificate store
To: Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-5-zycai@linux.ibm.com>
 <f96fdca3-f660-496a-8a81-2d922d0ddfdb@redhat.com>
Content-Language: en-US
In-Reply-To: <f96fdca3-f660-496a-8a81-2d922d0ddfdb@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OdmVzxTY c=1 sm=1 tr=0 ts=696020fc cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=j22drBIyGsQcwlkiSw0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: LDRr6TouLcZkRFXE6i1YYrGKQAdgnn9V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDE2MCBTYWx0ZWRfX9UZxSzjZ7N9d
 wor2NrSoZD2OIjEG2UAktXaW20nrlemkKT8Bya6FdXdJC8fXdkM7Nvp5rLVkNay8IExYEHVZnc0
 INvWovNqGm81JIxJ2CtuyQTpiEj4htnGHGg6maCX87PMEFo0HZldVFA2Fn+Ifoix2okg01E626Q
 6W1Aw4oCVgkRIG4hSGsY4DNIkNaXsY4F/3mg03kXS50hB9rztPhpmxgY40UrJVznkw3cKLPRv6Z
 rREGZRb6WGvwpEyU+GaD+9GUuWyZ2vpWvLbqCfVn54GzrxqWZ840jW4WxJ59R0e1ifOfBl2Gg9U
 10FRGoUA6X82NaDEjJ7REImoI/DFmT5iruztbwQk6Lxxifk3ab5VtXf5HoovjTmkPFEUT9Y29hn
 coJo3/Oz2n7LCqqUC6JrF0Gp2rSZEwJMBSWACsX5d2V9NQZSsxeIYhKpQBmP4yClOlnBuEB9AFu
 QKIpZWKJq4AGz/Nb/hQ==
X-Proofpoint-ORIG-GUID: LDRr6TouLcZkRFXE6i1YYrGKQAdgnn9V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_04,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601080160
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On 1/8/26 7:28 AM, Thomas Huth wrote:
> On 08/12/2025 22.32, Zhuoying Cai wrote:
>> Create a certificate store for boot certificates used for secure IPL.
>>
>> Load certificates from the `boot-certs` parameter of s390-ccw-virtio
>> machine type option into the cert store.
>>
>> Currently, only X.509 certificates in PEM format are supported, as the
>> QEMU command line accepts certificates in PEM format only.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> ---
> ...
>> diff --git a/hw/s390x/cert-store.c b/hw/s390x/cert-store.c
>> new file mode 100644
>> index 0000000000..cf16911d09
>> --- /dev/null
>> +++ b/hw/s390x/cert-store.c
>> @@ -0,0 +1,211 @@
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
>> +#include "qapi/error.h"
>> +#include "qemu/error-report.h"
>> +#include "qemu/option.h"
>> +#include "qemu/config-file.h"
>> +#include "hw/s390x/ebcdic.h"
>> +#include "hw/s390x/s390-virtio-ccw.h"
>> +#include "qemu/cutils.h"
>> +#include "crypto/x509-utils.h"
>> +#include "qapi/qapi-types-machine-s390x.h"
>> +
>> +static BootCertificatesList *s390_get_boot_certs(void)
>> +{
>> +    return S390_CCW_MACHINE(qdev_get_machine())->boot_certs;
>> +}
>> +
>> +static S390IPLCertificate *init_cert_x509(size_t size, uint8_t *raw, Error **errp)
>> +{
>> +    S390IPLCertificate *cert = NULL;
>> +    g_autofree uint8_t *cert_der = NULL;
>> +    size_t der_len = size;
>> +    int rc;
>> +
>> +    rc = qcrypto_x509_convert_cert_der(raw, size, &cert_der, &der_len, errp);
>> +    if (rc != 0) {
>> +        return NULL;
>> +    }
>> +
>> +    cert = g_new0(S390IPLCertificate, 1);
>> +    cert->size = size;
>> +    cert->der_size = der_len;
> 
> Why is only der_len stored here, but cert_der is silently discarded? Could 
> you please add a comment explaining this?
>

Sure, I will add comments to explain this.

To elaborate, cert_der is only used once in handle_cert()
(target/s390x/diag.c) when populating the Verification Certificate Entry
(VCE), and it can be easily regenerated by calling
qcrypto_x509_convert_cert_der(). Most other operations on the
certificate can be performed using the raw certificate in PEM format.

For this reason, storing cert_der in S390IPLCertificate seemed
unnecessary, whereas der_len is required in several places during
certificate store setup, including when calculating the total size of
S390IPLCertificateStore and the VCE length.

>> +    /* store raw pointer - ownership transfers to cert */
>> +    cert->raw = raw;
>> +
>> +    return cert;
>> +}
>> +

[...]

Thanks for the feedback!


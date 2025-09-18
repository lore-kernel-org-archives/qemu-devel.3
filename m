Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D382CA1013
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 19:46:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzKaH-00081V-9t; Thu, 18 Sep 2025 15:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1uzKaF-00081C-Go; Thu, 18 Sep 2025 15:46:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1uzKaD-00067N-6M; Thu, 18 Sep 2025 15:46:23 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IFDat9028021;
 Thu, 18 Sep 2025 19:46:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=a6Xuvl
 RM98ZL+yHq5YwSWqcSfegvhYroqVDfoPPRQ4w=; b=tUZwIx9X37QkzjekaHCJdR
 DkXUYO0u9UxUm5m/Kyn15SpPc0XP4tKHZoEwB7D6IiuMRAoBwsmu7kF1qvDefLZK
 NAh0RZyw/I2lbISS1eQ3sQT8TCGwCH81YqiIJRnpntLkgLFjfzXhBeWB6JgK5TWb
 IGS/xqCjwDUlqTUSJ/0PITna8l7XAFbGpqHZdcjBo9the6wnQvXX1YLvZSeI+uEW
 5XaHwcDt3NqLVnhShcw+hOltGn32EGVbEl5PJGqTCFZ24xJ1zjiQGGU7pVnJhdD/
 VKVSnebmn5xwvZo30PRWuSugmhWNhR2PNi7IVjGixQ7uM4pXfgxf4icFOlyUmqoA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4pcjse-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 19:46:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58IHO45r027358;
 Thu, 18 Sep 2025 19:46:17 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495mengcdu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 19:46:17 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58IJk5Zn26542662
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Sep 2025 19:46:05 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B213758050;
 Thu, 18 Sep 2025 19:46:15 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2F2D558045;
 Thu, 18 Sep 2025 19:46:14 +0000 (GMT)
Received: from [9.61.251.145] (unknown [9.61.251.145])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 18 Sep 2025 19:46:14 +0000 (GMT)
Message-ID: <612c331b-50b7-4593-82ae-791f0c943688@linux.ibm.com>
Date: Thu, 18 Sep 2025 12:46:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/28] hw/s390x/ipl: Create certificate store
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-5-zycai@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20250917232131.495848-5-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX0DfCs42ljBxV
 DEua5UuaLGKCi7gBGCRCc4VF6oUSRElFBJ5WQN53Z1PHMczeXmr6c9ZbKdzsZDMOyz0y4v2VrQx
 Tby4ovvePS9P8Wnwvv9fGQiEUZ6u17Rvwr2uaCOEhVKe3XGzT6TNtPHVuBdeVXUHUtOL2ipBA1e
 rAU8l9ZFje7FGT40h05oOMCdUx9MqdkKXo+jetf64y2u4C7BP/pujB+S0lP2Jb4d+pva9TY24Vt
 L3Xru4MIWBvqnYynV/Og+w9reGpR4XRSaX6nUatfXyUc//wiBNhtj7cV77tDPyqlic0wiDmx6i2
 EQ1hbkUJ1JlydfDxgNzxofsb5kPAJ/lau/lmFcoIPApdvomOlDzCaiNp9gXChbRf6/fcIxaxPFe
 hskkZzi/
X-Proofpoint-ORIG-GUID: _KvgEUcFRL7atMXauR07-x3N6vznio2e
X-Proofpoint-GUID: _KvgEUcFRL7atMXauR07-x3N6vznio2e
X-Authority-Analysis: v=2.4 cv=cNzgskeN c=1 sm=1 tr=0 ts=68cc618a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=NffIB9FPGJXsOB3DuMgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
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


<..snip..>

> diff --git a/hw/s390x/cert-store.h b/hw/s390x/cert-store.h
> new file mode 100644
> index 0000000000..3f76a00277
> --- /dev/null
> +++ b/hw/s390x/cert-store.h
> @@ -0,0 +1,39 @@
> +/*
> + * S390 certificate store
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Zhuoying Cai <zycai@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_S390_CERT_STORE_H
> +#define HW_S390_CERT_STORE_H
> +
> +#include "hw/s390x/ipl/qipl.h"
> +#include "crypto/x509-utils.h"
> +
> +#define VC_NAME_LEN_BYTES  64
> +
> +#define CERT_KEY_ID_LEN    QCRYPTO_HASH_DIGEST_LEN_SHA256
> +#define CERT_HASH_LEN      QCRYPTO_HASH_DIGEST_LEN_SHA256
> +
> +struct S390IPLCertificate {
> +    uint8_t vc_name[VC_NAME_LEN_BYTES];
> +    size_t  size;
> +    size_t  der_size;
> +    uint8_t *raw;
> +};
> +typedef struct S390IPLCertificate S390IPLCertificate;
> +
> +struct S390IPLCertificateStore {
> +    uint16_t count;
> +    size_t   max_cert_size;
> +    size_t   total_bytes;
> +    S390IPLCertificate certs[MAX_CERTIFICATES];
> +} QEMU_PACKED;

I think the guidance is to avoid using QEMU_PACKED (see Thomas's reply 
to me 
https://lore.kernel.org/qemu-devel/ff5a3203-6afb-4202-b59a-1021f0d949db@redhat.com/). 
Also this is an internal QEMU structure and not an architecture specific 
one, so this shouldn't be packed, no?

The rest of the patch LGTM.

<...snip...>



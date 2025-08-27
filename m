Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7849CCA0FF9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 16:30:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urJ2a-0001vf-RL; Wed, 27 Aug 2025 12:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1urJ2U-0001oD-LO; Wed, 27 Aug 2025 12:30:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1urJ2P-0003GQ-Mr; Wed, 27 Aug 2025 12:30:22 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57R6pBb5015852;
 Wed, 27 Aug 2025 16:30:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=B0+kMR
 1VbcbQ5Kx192IQYMYb2goRWYkzeU8EnCIpdbw=; b=adxPQDRI/uXQp9C4REEU/x
 eD/o30HVO8ujMKp9SGG+dMLIKBKeBAl9Wn2xtMXz+ciEedDgQFlGmpYxZndtI59C
 xFgdJ23LCD4dSriy1mCLoqz9Y9fL26f/DO1EbMexD2OZy/wsJe5g2gyKop9w7U7f
 cvrjVubrTFIyNWxxtp/Jacz5vMvyS5NahRL4ConInzor+VrUk0X3GKJC6i7vOm9R
 RcjnPiApH2YI80zMT4mDq2otbYuPOWB1Xe5QpzcTzXxkw7IIoKQA7D5h8pTSAgpA
 BVeYNepe4Nb6s/QORpM5kmtKF+doQFjnRVS2ffPeaCXdwNTwfxac1AXk0Sqj2vgA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q5avn4bp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Aug 2025 16:30:12 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57RFckVA020799;
 Wed, 27 Aug 2025 16:30:10 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48qrc0rwhv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Aug 2025 16:30:10 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57RGU9TB6095684
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Aug 2025 16:30:09 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 652475805A;
 Wed, 27 Aug 2025 16:30:09 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 355DA58051;
 Wed, 27 Aug 2025 16:30:08 +0000 (GMT)
Received: from [9.61.148.204] (unknown [9.61.148.204])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 27 Aug 2025 16:30:08 +0000 (GMT)
Message-ID: <e745b570-e1da-4992-a033-532c55f37339@linux.ibm.com>
Date: Wed, 27 Aug 2025 12:30:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/29] hw/s390x/ipl: Add IPIB flags to IPL Parameter
 Block
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com
References: <20250818214323.529501-1-zycai@linux.ibm.com>
 <20250818214323.529501-16-zycai@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20250818214323.529501-16-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bTFE0jDx31noYk8Ojb-A7B-E8L_I4T7X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyMSBTYWx0ZWRfXxJHRXIQRwnzN
 yQticvFiv3ad+lWhdi6su0Q0efBuFHIUJFwgXIbAuVwjamvMZPblpGBK+v9xmSao54OhZpTqGD3
 HOMWFc4VyY4aDYvbc/zjCcqudLIx5MvXe+jUCbKjlVfH7Gd9ZIQ7oUNS1d7jmT3aVHFbLVK0zJ2
 PxBHl9Ixue7qG2rw9IVa6g9a0fA5Re9oenALjEdAoagyuBR+xSHZ3wbsAoNmHgSUGP6mvvNhFnr
 ZDiZ20yPh0GsPv+PXoWGKYx2hBZdQ0QpEJ7jxk6/O+l+0PEeiUv72OIKapVKl6L2aWvPxgu+UA3
 x0nar9TqM/EsAaAiXFjG0Nuh1Ewm0IKLkk80yYoe+YybaEYBJtRiNkuhztgryfWzQFsfdoCmTCv
 uKqsWBzT
X-Proofpoint-ORIG-GUID: bTFE0jDx31noYk8Ojb-A7B-E8L_I4T7X
X-Authority-Analysis: v=2.4 cv=SNNCVPvH c=1 sm=1 tr=0 ts=68af3294 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=tFOKKjxJ0E9mQNCovc4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230021
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
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


On 8/18/25 5:43 PM, Zhuoying Cai wrote:
> Add IPIB flags to IPL Parameter Block to determine if IPL needs to
> perform securely and if IPL Information Report Block (IIRB) exists.
>
> Move DIAG308 flags to a separated header file and add flags for secure IPL.
>
> Secure boot in audit mode will perform if certificate(s) exist in the
> key store. IIRB will exist and results of verification will be stored in
> IIRB.
>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   hw/s390x/ipl.c                 | 20 ++++++++++++++++++++
>   hw/s390x/ipl.h                 | 17 -----------------
>   include/hw/s390x/ipl/diag308.h | 34 ++++++++++++++++++++++++++++++++++
>   include/hw/s390x/ipl/qipl.h    |  5 ++++-
>   4 files changed, 58 insertions(+), 18 deletions(-)
>   create mode 100644 include/hw/s390x/ipl/diag308.h
>
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 186be923d7..8ac0cee73d 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -430,6 +430,13 @@ S390IPLCertificateStore *s390_ipl_get_certificate_store(void)
>       return &ipl->cert_store;
>   }
>   
> +static bool s390_has_certificate(void)
> +{
> +    S390IPLState *ipl = get_ipl_device();
> +
> +    return ipl->cert_store.count > 0;
> +}
> +
>   static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>   {
>       CcwDevice *ccw_dev = NULL;
> @@ -487,6 +494,19 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>           s390_ipl_convert_loadparm((char *)lp, iplb->loadparm);
>           iplb->flags |= DIAG308_FLAGS_LP_VALID;
>   
> +        /*
> +         * Secure boot in audit mode will perform
> +         * if certificate(s) exist in the key store.
> +         *
> +         * IPL Information Report Block (IIRB) will exist
> +         * for secure boot in audit mode.
> +         *
> +         * Results of secure boot will be stored in IIRB.
> +         */
> +        if (s390_has_certificate()) {
> +            iplb->hdr_flags |= DIAG308_IPIB_FLAGS_IPLIR;
> +        }
> +
We could also override the previously assigned minimum IPLB length here 
if the flag is set.

That would avoid always using the max length and then patch 16 could be 
dropped too.

>           return true;
>       }
>   
> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
> index e26fc1cd6a..3b8cc5474e 100644
> --- a/hw/s390x/ipl.h
> +++ b/hw/s390x/ipl.h
> @@ -23,7 +23,6 @@
>   #include "qom/object.h"
>   #include "target/s390x/kvm/pv.h"
>   
> -#define DIAG308_FLAGS_LP_VALID 0x80
>   #define MAX_BOOT_DEVS 8 /* Max number of devices that may have a bootindex */
>   
>   void s390_ipl_convert_loadparm(char *ascii_lp, uint8_t *ebcdic_lp);
> @@ -91,22 +90,6 @@ struct S390IPLState {
>   };
>   QEMU_BUILD_BUG_MSG(offsetof(S390IPLState, iplb) & 3, "alignment of iplb wrong");
>   
> -#define DIAG_308_RC_OK              0x0001
> -#define DIAG_308_RC_NO_CONF         0x0102
> -#define DIAG_308_RC_INVALID         0x0402
> -#define DIAG_308_RC_NO_PV_CONF      0x0902
> -#define DIAG_308_RC_INVAL_FOR_PV    0x0a02
> -
> -#define DIAG308_RESET_MOD_CLR       0
> -#define DIAG308_RESET_LOAD_NORM     1
> -#define DIAG308_LOAD_CLEAR          3
> -#define DIAG308_LOAD_NORMAL_DUMP    4
> -#define DIAG308_SET                 5
> -#define DIAG308_STORE               6
> -#define DIAG308_PV_SET              8
> -#define DIAG308_PV_STORE            9
> -#define DIAG308_PV_START            10
> -
>   #define S390_IPL_TYPE_FCP 0x00
>   #define S390_IPL_TYPE_CCW 0x02
>   #define S390_IPL_TYPE_PV 0x05
> diff --git a/include/hw/s390x/ipl/diag308.h b/include/hw/s390x/ipl/diag308.h
> new file mode 100644
> index 0000000000..6e62f29215
> --- /dev/null
> +++ b/include/hw/s390x/ipl/diag308.h
> @@ -0,0 +1,34 @@
> +/*
> + * S/390 DIAGNOSE 308 definitions and structures
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Zhuoying Cai <zycai@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef S390X_DIAG308_H
> +#define S390X_DIAG308_H
> +
> +#define DIAG_308_RC_OK              0x0001
> +#define DIAG_308_RC_NO_CONF         0x0102
> +#define DIAG_308_RC_INVALID         0x0402
> +#define DIAG_308_RC_NO_PV_CONF      0x0902
> +#define DIAG_308_RC_INVAL_FOR_PV    0x0a02
> +
> +#define DIAG308_RESET_MOD_CLR       0
> +#define DIAG308_RESET_LOAD_NORM     1
> +#define DIAG308_LOAD_CLEAR          3
> +#define DIAG308_LOAD_NORMAL_DUMP    4
> +#define DIAG308_SET                 5
> +#define DIAG308_STORE               6
> +#define DIAG308_PV_SET              8
> +#define DIAG308_PV_STORE            9
> +#define DIAG308_PV_START            10
> +
> +#define DIAG308_FLAGS_LP_VALID 0x80
> +
> +#define DIAG308_IPIB_FLAGS_SIPL 0x40
> +#define DIAG308_IPIB_FLAGS_IPLIR 0x20
> +
> +#endif
> diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
> index e505f44020..5c2bf3051c 100644
> --- a/include/hw/s390x/ipl/qipl.h
> +++ b/include/hw/s390x/ipl/qipl.h
> @@ -12,6 +12,8 @@
>   #ifndef S390X_QIPL_H
>   #define S390X_QIPL_H
>   
> +#include "diag308.h"
> +
>   /* Boot Menu flags */
>   #define QIPL_FLAG_BM_OPTS_CMD   0x80
>   #define QIPL_FLAG_BM_OPTS_ZIPL  0x40
> @@ -103,7 +105,8 @@ typedef struct IplBlockQemuScsi IplBlockQemuScsi;
>   union IplParameterBlock {
>       struct {
>           uint32_t len;
> -        uint8_t  reserved0[3];
> +        uint8_t  hdr_flags;
> +        uint8_t  reserved0[2];
>           uint8_t  version;
>           uint32_t blk0_len;
>           uint8_t  pbt;
Regards,
Jared Rossi


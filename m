Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A12C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 01:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf6Wz-0004M4-FS; Wed, 01 Jul 2026 21:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wf6Wt-0004LV-Pp; Wed, 01 Jul 2026 21:47:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wf6Wq-0005Be-Rw; Wed, 01 Jul 2026 21:47:50 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6621KOK32347007; Thu, 2 Jul 2026 01:47:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=QZc4Pn
 lbMKHBkg3+iNXrMBSB4o+PBHeHGr0CYn7J2ik=; b=OfYB9pAC1HXTfoI/g4Wa4W
 2GhaiuAjldhT6SrlaVFv3hl4JDiNHJzug3Rl65hmss4vgDy+SyRwYixEVvekkJtD
 KQPweSTZ4VXVHSwLxXAYD0DEHkIJ/DAOSl4DulS4fTWQk+B/3twFI6NPKqqpFPdd
 BeOeC9I4XLcovIEGOyFR+G74WJoTvUFSs3zEqmRfinNH+mBJZvqmdh4sJHpLLjRj
 bTGmqm7fn9C8zDd+OLWU494KmmlJ7UVEVbRhtwqz8wQr9mG1IZwneqx45SpbUtbb
 u/kBOQnEGcOeGY2R/Hy95n+ba21B0lc5AIKETDRPKSW8Uy77LCojd4aVKwrHzGdw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mjy6rv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 01:47:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6621Ycc1001888;
 Thu, 2 Jul 2026 01:47:43 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhyhq3h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 01:47:43 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6621lhZf16319104
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Jul 2026 01:47:43 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E9F6E58061;
 Thu,  2 Jul 2026 01:47:42 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5CC4C58059;
 Thu,  2 Jul 2026 01:47:41 +0000 (GMT)
Received: from [9.61.143.111] (unknown [9.61.143.111])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Thu,  2 Jul 2026 01:47:41 +0000 (GMT)
Message-ID: <3d3a5e97-3cca-491c-8b6b-f3d389b66969@linux.ibm.com>
Date: Wed, 1 Jul 2026 21:47:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 17/35] hw/s390x/ipl: Add IPIB flags to IPL Parameter
 Block
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: cohuck@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260701204922.1320349-1-zycai@linux.ibm.com>
 <20260701204922.1320349-18-zycai@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20260701204922.1320349-18-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAxMCBTYWx0ZWRfX8Nm2y5iRTU0t
 /MggbEYkzimBebXFfsaMgh1sO0EUWk2Zj7NsUrR00SlHT40aeKKQ5jFiefz3Afa1HqKQQvTyS6f
 v7SjxIfvW9JE8DUSAtmouFZYQt96MVbKNMrNBDIWIGO8bnycjCJ+vYbINqSZG1i9eZuLoXSWvfR
 t9dzu3hx5rL6FkANkpObiOJvOGOBckFKX3jbnlaPeApjklqmV0kLgcgxz/9MeQw/Y3JC3uEXpbz
 vrf2KsUB8SweKzkRldXWeXx1vNWk7vMOUmSZuIyBQLM3jiDpurNAt+be3spAlcrzwGZqn4Q8vJA
 lbXhS6OqF3T/fpWZO6AqMizjAjpJVKUJhQT6gS71sD4k4eG5URue4V/YXuXNjId4sBgvysLcenc
 eCF7L459+wjYv2QlqppofCNaZoDLNRzPmOx65Rnlp1sVKuPrPu27GnnWzFth6w5nhywDXiLIfWa
 LT7IZhl12L49OveGNKw==
X-Proofpoint-GUID: EVnPjwSMpnGUI8rriY65SHp8QwCjAo98
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a45c340 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=QC1oVG_qZcyjQOdZZnIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAxMCBTYWx0ZWRfX+udM+67msqTC
 82zRZN3X17IZtJr+yPIoRglmjnhs8c+FDcvvF9oYtiCKmACIbZYlkYnwN7Cqml6DWVTcba+tygu
 gFZ6MBZzUbDC7WYer8CP7PxFdSiP2Tw=
X-Proofpoint-ORIG-GUID: EVnPjwSMpnGUI8rriY65SHp8QwCjAo98
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020010
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 7/1/26 4:49 PM, Zhuoying Cai wrote:
> Add IPIB flags to IPL Parameter Block to determine if IPL needs to
> perform securely and if IPL Information Report Block (IIRB) exists.
>
> Move DIAG308 flags to a separated header file and add flags for secure IPL.
> Move IPLB length related definitions to include/hw/s390x/ipl/qipl.h and
> add a maximum length constant to support secure IPL.
>
> Secure boot in audit mode will perform if certificate(s) exist in the
> key store. IIRB will exist and results of verification will be stored in
> IIRB.
>
> To ensure proper alignment of the IIRB and prevent overlap, set
> iplb->len to the maximum length of the IPLB, allowing alignment
> constraints to be determined based on its size.
>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Collin Walling <walling@linux.ibm.com>
> ---
>   hw/s390x/ipl.c                 | 21 +++++++++++++++++++++
>   hw/s390x/ipl.h                 | 24 ------------------------
>   include/hw/s390x/ipl/diag308.h | 34 ++++++++++++++++++++++++++++++++++
>   include/hw/s390x/ipl/qipl.h    | 13 ++++++++++++-
>   4 files changed, 67 insertions(+), 25 deletions(-)
>   create mode 100644 include/hw/s390x/ipl/diag308.h
>
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 09c24203c7..9cb41511e8 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -461,6 +461,13 @@ S390IPLCertificateStore *s390_ipl_get_certificate_store(void)
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
> @@ -517,6 +524,20 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
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
> +            iplb->len = cpu_to_be32(S390_IPLB_MAX_LEN);
> +        }
> +
>           return true;
>       }
>   
> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
> index f5a49a4431..9807ef18f2 100644
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
> @@ -90,29 +89,6 @@ struct S390IPLState {
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
> -#define S390_IPLB_HEADER_LEN 8
> -#define S390_IPLB_MIN_PV_LEN 148
> -#define S390_IPLB_MIN_CCW_LEN 200
> -#define S390_IPLB_MIN_FCP_LEN 384
> -#define S390_IPLB_MIN_PCI_LEN 376
> -#define S390_IPLB_MIN_QEMU_SCSI_LEN 200
> -
>   static inline bool iplb_valid_len(IplParameterBlock *iplb)
>   {
>       return be32_to_cpu(iplb->len) <= sizeof(IplParameterBlock);
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
> index 9940f1457c..a2180719b1 100644
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
> @@ -31,6 +33,14 @@ typedef enum S390IplType S390IplType;
>   
>   #define QEMU_DEFAULT_IPL S390_IPL_TYPE_CCW
>   
> +#define S390_IPLB_HEADER_LEN 8
> +#define S390_IPLB_MIN_PV_LEN 148
> +#define S390_IPLB_MIN_CCW_LEN 200
> +#define S390_IPLB_MIN_FCP_LEN 384
> +#define S390_IPLB_MIN_PCI_LEN 376
> +#define S390_IPLB_MIN_QEMU_SCSI_LEN 200
> +#define S390_IPLB_MAX_LEN 4096
> +
>   #define MAX_CERTIFICATES  64
>   /* largest supported block size - same as VIRTIO_DASD_DEFAULT_BLOCK_SIZE */
>   #define VIRTIO_MAX_BLOCK_SIZE   4096
> @@ -125,7 +135,8 @@ typedef struct IplBlockPci IplBlockPci;
>   union IplParameterBlock {
>       struct {
>           uint32_t len;
> -        uint8_t  reserved0[3];
> +        uint8_t  hdr_flags;
> +        uint8_t  reserved0[2];
>           uint8_t  version;
>           uint32_t blk0_len;
>           uint8_t  pbt;

Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>


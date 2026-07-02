Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE22C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 01:41:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf6PS-0002Nz-8O; Wed, 01 Jul 2026 21:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wf6PM-0002Me-M5; Wed, 01 Jul 2026 21:40:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wf6PJ-0002Z7-8u; Wed, 01 Jul 2026 21:40:03 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6621KEGx2450288; Thu, 2 Jul 2026 01:39:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=FRcPWl
 zzcfh2zD54LLZiEJL5Q8466WpnioLC5koxrZs=; b=DSt4913d1j3mnlnDJGmLcB
 1CItfUN1ruWGBxlTmKccqo/MdGIaSqdjAnxMOqReb6jWJ/zsFcBnO7iwEoqiE0Qq
 psXii2xIJM2CJWgIPhcgRFtG6PBShFXxHnBMHgNGaeNeBY67fPWqb24uhg6tCKYY
 Ab5dpxP2j+HeqwNtCkVOtWGFzxTy6uYCjig+YUOyMwqic5+l6RLwUU7BDW9L3Ahl
 Sd0EOPeOfaBhvhNIpSSgNmgl0fURR1o7bN6QYgkIuHa/27tXLTZcxu+HbhDDU8hy
 B/Cm9lUjRUM3zSPtMVPZSlie2Catq4TaXXJpuRHwcZfYyszMDlbOngzuky/bwWhw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n5yjck-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 01:39:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6621YhIU005165;
 Thu, 2 Jul 2026 01:39:53 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhhuu6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 01:39:53 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6621dqje33882702
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Jul 2026 01:39:52 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B71958059;
 Thu,  2 Jul 2026 01:39:52 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2527758057;
 Thu,  2 Jul 2026 01:39:51 +0000 (GMT)
Received: from [9.61.143.111] (unknown [9.61.143.111])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Thu,  2 Jul 2026 01:39:51 +0000 (GMT)
Message-ID: <faa6fd6b-3ec1-4c05-a695-8cb8fd3c9e1d@linux.ibm.com>
Date: Wed, 1 Jul 2026 21:39:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 15/35] s390x/ipl: Introduce IPL Information Report
 Block (IIRB)
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: cohuck@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260701204922.1320349-1-zycai@linux.ibm.com>
 <20260701204922.1320349-16-zycai@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20260701204922.1320349-16-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAxMCBTYWx0ZWRfX67rjYsSkUPAC
 vElJzjOuxXG77hzwL/3+oh6BOASyUXuj5BKK1AMxZHlDdQNkwgr1/0H7ZKlCM9HB7yFrxd4U4xA
 Cmw0Pr4xmIhXvGB8fi+9Neadd7xqcFxbZ4QJbRr5eC64WQPkbGNjgIdPAadTQ1TcJvsVSk9X8qa
 SvWLkGvz52qi3xj1xv99kSyMOsCg16+flYkjrz+nYLkxwJGAvrFO4IHq50XGkO4xxMa/l8s0Jcf
 lR+bs22RB40PdYd8ptXYCrEnyz+L1ILRH9lYMPbAGxiW1UmjVgP6Od0e2XUDZyN4qXMw2YesPoo
 PaK2O3D/gGyCrkGsRXuVp8HO2HwjrROr1XH6PYOmbE0UiY+cQBrq9f1kCR7ZGJ+RaaLmaqiOQK9
 xG3CdRc7pa0MCV5hwGdl0d7RNMbjPT9rL6i/Jgq6NWTcOpaE0lOBBTZw6UaRfav76E+bPE+yEFt
 TcbGnKdbiw4hL+bczog==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a45c16b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=QN6mC1T7KMykMM-1KScA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: BsO8fXMXpFz3BK8PqAWz3CcsshNlPWuX
X-Proofpoint-GUID: BsO8fXMXpFz3BK8PqAWz3CcsshNlPWuX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAxMCBTYWx0ZWRfXzxSC6gJSnDnb
 ogAXFPRBCAoCPm7q8UBeHhx8JruSLMO4WHJZkSz02yqORtbh+JJwgihpqtLMkRj2wYEzz0AcKb4
 BJ5OlJaYNfEcKjI8TV0/lJP4HT32/rQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020010
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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



On 7/1/26 4:49 PM, Zhuoying Cai wrote:
> The IPL information report block (IIRB) contains information used
> to locate IPL records and to report the results of signature verification
> of one or more secure components of the load device.
>
> IIRB is stored immediately following the IPL Parameter Block. Results on
> component verification in any case (failure or success) are stored.
>
> The IIRB data is reserved and protected by the guest kernel during early
> boot to prevent it from being overwritten before the certificate data is
> permanently saved.
>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Farhan Ali<alifm@linux.ibm.com>
> Reviewed-by: Collin Walling <walling@linux.ibm.com>
> ---
>   docs/specs/s390x-secure-ipl.rst | 21 +++++++++++
>   include/hw/s390x/ipl/qipl.h     | 62 +++++++++++++++++++++++++++++++++
>   2 files changed, 83 insertions(+)
>
> diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
> index a8be863548..a183d46b61 100644
> --- a/docs/specs/s390x-secure-ipl.rst
> +++ b/docs/specs/s390x-secure-ipl.rst
> @@ -101,3 +101,24 @@ Subcode 1 - perform signature verification
>       * ``0x0302``: PKCS#7 format signature is invalid
>       * ``0x0402``: signature-verification failed
>       * ``0x0502``: length of Diag508SigVerifBlock is invalid
> +
> +IPL Information Report Block
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The IPL Parameter Block (IPLPB), utilized for IPL operation, is extended with an
> +IPL Information Report Block (IIRB), which contains the results from secure IPL
> +operations such as:
> +
> +* component data
> +* verification results
> +* certificate data
> +
> +During early boot, the guest kernel reserves the memory region
> +containing the IIRB. This preserves the data while the guest kernel is
> +operating and during re-IPL.
> +
> +The guest kernel uses the contents in the IIRB for:
> +
> +* Boot logging: reports which components were loaded and verified.
> +* kexec operations: builds the next kernel’s IPL report from the existing one.
> +* Keying: installs IPL certificates into the platform trusted keyring.
> diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
> index ed1a91182a..45d25264f4 100644
> --- a/include/hw/s390x/ipl/qipl.h
> +++ b/include/hw/s390x/ipl/qipl.h
> @@ -32,6 +32,9 @@ typedef enum S390IplType S390IplType;
>   #define QEMU_DEFAULT_IPL S390_IPL_TYPE_CCW
>   
>   #define MAX_CERTIFICATES  64
> +/* largest supported block size - same as VIRTIO_DASD_DEFAULT_BLOCK_SIZE */
> +#define VIRTIO_MAX_BLOCK_SIZE   4096
> +#define MAX_COMP_ENTRIES        ((VIRTIO_MAX_BLOCK_SIZE - 32) / 32)
>   
>   /*
>    * The QEMU IPL Parameters will be stored at absolute address
> @@ -146,4 +149,63 @@ union IplParameterBlock {
>   } QEMU_PACKED;
>   typedef union IplParameterBlock IplParameterBlock;
>   
> +struct IplInfoReportBlockHeader {
> +    uint32_t len;
> +    uint8_t  flags;
> +    uint8_t  reserved1[11];
> +};
> +typedef struct IplInfoReportBlockHeader IplInfoReportBlockHeader;
> +
> +struct IplInfoBlockHeader {
> +    uint32_t len;
> +    uint8_t  type;
> +    uint8_t  reserved1[11];
> +};
> +typedef struct IplInfoBlockHeader IplInfoBlockHeader;
> +
> +enum IplInfoBlockType {
> +    IPL_INFO_BLOCK_TYPE_CERTIFICATES = 1,
> +    IPL_INFO_BLOCK_TYPE_COMPONENTS = 2,
> +};
> +
> +struct IplSignatureCertificateEntry {
> +    uint64_t addr;
> +    uint64_t len;
> +};
> +typedef struct IplSignatureCertificateEntry IplSignatureCertificateEntry;
> +
> +struct IplSignatureCertificateList {
> +    IplInfoBlockHeader            ipl_info_header;
> +    IplSignatureCertificateEntry  cert_entries[MAX_CERTIFICATES];
> +};
> +typedef struct IplSignatureCertificateList IplSignatureCertificateList;
> +
> +#define S390_IPL_DEV_COMP_FLAG_SC  0x80
> +#define S390_IPL_DEV_COMP_FLAG_CSV 0x40
> +
> +struct IplDeviceComponentEntry {
> +    uint64_t addr;
> +    uint64_t len;
> +    uint8_t  flags;
> +    uint8_t  reserved1[5];
> +    uint16_t cert_index;
> +    uint8_t  reserved2[8];
> +};
> +typedef struct IplDeviceComponentEntry IplDeviceComponentEntry;
> +
> +struct IplDeviceComponentList {
> +    IplInfoBlockHeader       ipl_info_header;
> +    IplDeviceComponentEntry  device_entries[MAX_COMP_ENTRIES];
> +};
> +typedef struct IplDeviceComponentList IplDeviceComponentList;
> +
> +#define COMP_LIST_MAX   sizeof(IplDeviceComponentList)
> +#define CERT_LIST_MAX   sizeof(IplSignatureCertificateList)
> +
> +struct IplInfoReportBlock {
> +    IplInfoReportBlockHeader     hdr;
> +    uint8_t                      info_blks[COMP_LIST_MAX + CERT_LIST_MAX];
> +};
> +typedef struct IplInfoReportBlock IplInfoReportBlock;
> +
>   #endif

Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>


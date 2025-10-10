Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC07CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 19:24:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Ihz-0004vS-7a; Fri, 10 Oct 2025 15:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1v7Ihw-0004tk-3Y; Fri, 10 Oct 2025 15:23:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1v7Ihs-0005Gm-F0; Fri, 10 Oct 2025 15:23:15 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59AJ7rDp030370;
 Fri, 10 Oct 2025 19:23:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=NRBq7J
 ootIq6vpayYi7d4ham5tvzRFYMomQU++yEAaE=; b=QSpmpXo6jy0UyDn+GEaJ59
 ZU4W4bQqAlMXs3Z6qiBkLAosoNIidyYe6ab65lp51jf6CAYrLy9bC1zbd3+txovM
 lHdGgOjg7TWksW16WEQ3zV2X/C2cGE6WB0s1HDW3fdhdErzcDUTTiYTSpGVL3LOk
 Ide7N71GpcRjmznjts8veala8T2Sg3y/rtAYKy/EKn8jyCgwIDadkt5iraQPZSIB
 qc2uCkskTTzA0zMMQS7LwtKZbAPurV5R5lzuVw5pDBlk9+g1EC3twN6J1t280+bR
 paHFWpXgmcPCGiSyKW+x8SurDeCId6AwNKmlx8i87iY5FlFiUtKcAHlGqE+0ARzQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv81var2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Oct 2025 19:23:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59AG0HRL022784;
 Fri, 10 Oct 2025 19:23:05 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49nv8vkd49-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Oct 2025 19:23:05 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59AJN4fO31916608
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Oct 2025 19:23:04 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B893D58055;
 Fri, 10 Oct 2025 19:23:04 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2176858043;
 Fri, 10 Oct 2025 19:23:04 +0000 (GMT)
Received: from [9.61.240.77] (unknown [9.61.240.77])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 10 Oct 2025 19:23:04 +0000 (GMT)
Message-ID: <781a3494-453e-47ea-ab10-48d0f5315f4f@linux.ibm.com>
Date: Fri, 10 Oct 2025 12:23:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/16] hw/virtio: Replace HOST_BIG_ENDIAN #ifdef with
 runtime if() check
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20251010134226.72221-1-philmd@linaro.org>
 <20251010134226.72221-9-philmd@linaro.org>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20251010134226.72221-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: s2u-wFbhSy_GG8Jlq6RS0m6EsNyeNEbr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX9pVjrzgqH6vZ
 OVlLI+rUhuG3mBaS4lcmFNhJbzBjYBM/Y+poeTX1Pyd9vxbKZ9OBbAPz56Y0f/yEKEcpDrA0LWt
 psdEwPh3b+C1yXg6KUDrA2PujABBo7FvN3qb7PDzgNjvldvmwp95Hj3P8+AlTmpim3UlHHuAeYM
 9pYvy635oiT7/00oKyt05jKr0Ah3CfCrrrYHUedSzLRR4AtBY0uc6LAwHumm4ggsPYe1m1YE8tU
 BZ/PniR6M76CvYdbjBwsbPrrHbAeL39wu2VhX8q2B3U8z9nacJGFU9iF4pVUo48fDzkvyz4eRZp
 jKII9aVpcDdsY41tTW+6OIbH/xHeyjRhyj2BU/kxoneVTlEu3CwJDDpnhwhVhCMhgK6dTsMpl0W
 z8kBFgoobbvisaJhX0hj6raSdTa24g==
X-Authority-Analysis: v=2.4 cv=cKntc1eN c=1 sm=1 tr=0 ts=68e95d1a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=KKAkSRfTAAAA:8 a=1dBT-wlmzmzewUka4SAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: s2u-wFbhSy_GG8Jlq6RS0m6EsNyeNEbr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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


On 10/10/2025 6:42 AM, Philippe Mathieu-Daudé wrote:
> Replace compile-time #ifdef with a runtime check to ensure all code
> paths are built and tested. This reduces build-time configuration
> complexity and improves maintainability.
>
> No functional change intended.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/virtio/virtio-access.h | 6 +-----
>   hw/virtio/vhost.c                 | 7 +++----
>   2 files changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
> index 07aae69042a..80328912ad3 100644
> --- a/include/hw/virtio/virtio-access.h
> +++ b/include/hw/virtio/virtio-access.h
> @@ -149,11 +149,7 @@ static inline uint64_t virtio_ldq_p(VirtIODevice *vdev, const void *ptr)
>   
>   static inline uint16_t virtio_tswap16(VirtIODevice *vdev, uint16_t s)
>   {
> -#if HOST_BIG_ENDIAN
> -    return virtio_access_is_big_endian(vdev) ? s : bswap16(s);
> -#else
> -    return virtio_access_is_big_endian(vdev) ? bswap16(s) : s;
> -#endif
> +    return HOST_BIG_ENDIAN ^ virtio_access_is_big_endian(vdev) ? s : bswap16(s);

This patch breaks virtio devices(at least input/net devices) on s390x. I 
am not sure if ^ is the right check here? Changing the logic back to how 
it was fixes it for me.

Thanks

Farhan

>   }
>   
>   static inline uint16_t virtio_lduw_phys_cached(VirtIODevice *vdev,
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 266a11514a1..6343477b42f 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1168,11 +1168,10 @@ static inline bool vhost_needs_vring_endian(VirtIODevice *vdev)
>       if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
>           return false;
>       }
> -#if HOST_BIG_ENDIAN
> -    return vdev->device_endian == VIRTIO_DEVICE_ENDIAN_LITTLE;
> -#else
> +    if (HOST_BIG_ENDIAN) {
> +        return vdev->device_endian == VIRTIO_DEVICE_ENDIAN_LITTLE;
> +    }
>       return vdev->device_endian == VIRTIO_DEVICE_ENDIAN_BIG;
> -#endif
>   }
>   
>   static int vhost_virtqueue_set_vring_endian_legacy(struct vhost_dev *dev,


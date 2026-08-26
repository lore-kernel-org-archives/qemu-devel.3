Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD0AC61DBE
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 21:08:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzKpv-0002nM-4v; Wed, 26 Aug 2026 17:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1wzKpt-0002mg-VO; Wed, 26 Aug 2026 17:07:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1wzKps-0003YA-45; Wed, 26 Aug 2026 17:07:05 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QL1nqi3280864; Wed, 26 Aug 2026 21:07:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=7jKLYN
 Tg0Z+cNk0WLKKwzg8OuZLFJv/b0DjrIjqFbmg=; b=EPd4DLZVqIvtPxiTFzCIf5
 uJv006HSOstiPRQDvdbXmfNqCcHMX2OnxO5ZEUZZb5f/0J9FE/8IJGoCJs4tjhPL
 +4YUkkESf3Pxl1HSkoiOkzlZrOjjZOgHEG3/EnfyddEnfb+gAe0nIFTtgA+3vBBU
 TIaqz/6XNqRQF3dBs7yGMKIOXNZR0/MRoaoNC6b1z9QJw+tC6DWOGnA56wutKe/X
 tKo81U07Ywww2LttEAvEHXZXoLJ610kqmp83a2V1RzUUNkbTGn4SI0bDu1BJn/Pp
 bTlyq03Q51aK7sGYHExqBogIrhbRb9fIXiCCqQ+EPJ1iQAqwLLs8fvTjzuOyKn2A
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73er168r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 21:07:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QKuI8r016809;
 Wed, 26 Aug 2026 21:07:00 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7ragm2bq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 21:07:00 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QL6wDZ65077550
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 21:06:58 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7F4A658045;
 Wed, 26 Aug 2026 21:06:58 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E16158050;
 Wed, 26 Aug 2026 21:06:57 +0000 (GMT)
Received: from [9.61.176.10] (unknown [9.61.176.10])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 21:06:57 +0000 (GMT)
Message-ID: <eee4b8dc-6cde-413f-9a58-67d792ab56d8@linux.ibm.com>
Date: Wed, 26 Aug 2026 13:01:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/7] pc-bios/s390-ccw: Add dynamic net header size
 handling
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, borntraeger@linux.ibm.com,
 cohuck@redhat.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 pasic@linux.ibm.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com
References: <20260818205324.580199-1-zycai@linux.ibm.com>
 <20260818205324.580199-3-zycai@linux.ibm.com>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <20260818205324.580199-3-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IJSSTbK_6LollorJfAROdh_R4wKKS8Cr
X-Proofpoint-ORIG-GUID: IJSSTbK_6LollorJfAROdh_R4wKKS8Cr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE3NiBTYWx0ZWRfX5MkkIQkFr3je
 jcmyn47NSbbHytm/0gxmEJOp1+wkpBXvn4jv2qXy+LT6fmhfyicOGeba3Cje45FsCTz6xmUGBtT
 8PMmVFJkH3uUxSoJd/i3OP2oWUxyfFjKB28ZXIz6jwWSO4l5xTEL06yYDKBr6294K0cnN21Jz4f
 5IKEqTrtvtzEBSAiy7HgCpax0pnIGi33mvtS5uKUGlDbIiD/YaBUu1oXoqZFC6SDL/FupfJaJM2
 8KkOHm5Pzkk73W2QVKMNf22SzoAq9mlm8EJex7q5DKxnbow2ZkJC0iX+uCwNAY+jnCheiaJ1oiH
 +w8/NlyFlEAFnDbdiFjWiWAHpTRg0/8/5IOfOfj9rfD/7g6h3N9XkdMCMWFbStCjpXeFHDOzQTm
 6ItlzJOlqhe3WT7l5qQfOSx3/6aHOiLqeuKcl3HKYTtpWcAUMPuIQx333g12F8XTTGsmWeh2UOS
 2e93POhtKmvBLfM2jDQ==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8f5575 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=WlbtgAuzpxvzBHkL9eIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE3NiBTYWx0ZWRfXz+61NZvbg5F/
 GMtqUVqdUn/4Z4XvTq6tWU12yivubWwkepygN2IziMG9vUftaMLYGbnpdhRID0Bq6yCWmOofTUd
 9tCQ/adJXizMOmFlxKaN8hhHLZBfmDs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_06,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260176
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jjherne@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



On 8/18/26 4:53 PM, Zhuoying Cai wrote:
> The virtio-net device used a fixed header size that did not account for
> the num_buffers field used in VirtIO 1.0 or for the mergeable receive
> buffers feature.
> 
> Use dynamic header sizing: 10 bytes for legacy mode and 12 bytes for
> VirtIO 1.0 or when VIRTIO_NET_F_MRG_RXBUF is enabled. This ensures
> correct packet handling across different VirtIO configurations.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/virtio-net.c | 26 +++++++++++++++++++-------
>   1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/virtio-net.c b/pc-bios/s390-ccw/virtio-net.c
> index 0ee51653ab..3a9ae789cf 100644
> --- a/pc-bios/s390-ccw/virtio-net.c
> +++ b/pc-bios/s390-ccw/virtio-net.c
> @@ -20,6 +20,7 @@
>   #include "s390-ccw.h"
>   #include "virtio.h"
>   #include "virtio-ccw.h"
> +#include "virtio-pci.h"
>   #include "s390-time.h"
>   #include "helper.h"
>   
> @@ -28,10 +29,15 @@
>   #endif
>   
>   #define VIRTIO_NET_F_MAC_BIT  (1 << 5)
> +#define VIRTIO_NET_F_MRG_RXBUF_BIT (1 << 15)
>   
>   #define VQ_RX 0         /* Receive queue */
>   #define VQ_TX 1         /* Transmit queue */
>   
> +/* Header sizes for different modes */
> +#define VIRTIO_NET_HDR_SIZE_LEGACY  10  /* Without num_buffers */
> +#define VIRTIO_NET_HDR_SIZE_V1      12  /* With num_buffers */
> +
>   struct VirtioNetHdr {
>       uint8_t flags;
>       uint8_t gso_type;
> @@ -39,11 +45,12 @@ struct VirtioNetHdr {
>       uint16_t gso_size;
>       uint16_t csum_start;
>       uint16_t csum_offset;
> -    /*uint16_t num_buffers;*/ /* Only with VIRTIO_NET_F_MRG_RXBUF or VIRTIO1 */
> +    uint16_t num_buffers; /* Only with VIRTIO_NET_F_MRG_RXBUF or VIRTIO1 */
>   };
>   typedef struct VirtioNetHdr VirtioNetHdr;
>   
>   static uint16_t rx_last_idx;  /* Last index in receive queue "used" ring */
> +static int virtio_net_hdr_size;
>   
>   int virtio_net_init(void *mac_addr)
>   {
> @@ -62,12 +69,17 @@ int virtio_net_init(void *mac_addr)
>           return -1;
>       }
>   
> +    virtio_net_hdr_size = ((vdev->guest_features[1] & VIRTIO_F_VERSION_1) ||
> +                           (vdev->guest_features[0] & VIRTIO_NET_F_MRG_RXBUF_BIT))
> +                          ? VIRTIO_NET_HDR_SIZE_V1
> +                          : VIRTIO_NET_HDR_SIZE_LEGACY;
> +
>       memcpy(mac_addr, vdev->config.net.mac, ETH_ALEN);
>   
>       for (i = 0; i < 64; i++) {
> -        buf = malloc(ETH_MTU_SIZE + sizeof(VirtioNetHdr));
> +        buf = malloc(ETH_MTU_SIZE + virtio_net_hdr_size);
>           IPL_assert(buf != NULL, "Can not allocate memory for receive buffers");
> -        vring_send_buf(rxvq, buf, ETH_MTU_SIZE + sizeof(VirtioNetHdr),
> +        vring_send_buf(rxvq, buf, ETH_MTU_SIZE + virtio_net_hdr_size,
>                          VRING_DESC_F_WRITE);
>       }
>       vring_notify(rxvq);
> @@ -82,9 +94,9 @@ int send(int fd, const void *buf, int len, int flags)
>       VRing *txvq = &vdev->vrings[VQ_TX];
>   
>       /* Set up header - we do not use anything special, so simply clear it */
> -    memset(&tx_hdr, 0, sizeof(tx_hdr));
> +    memset(&tx_hdr, 0, virtio_net_hdr_size);

I think you want to leave this line as-is. There's no harm in cleaning 
the entire struct's memory even if we never end up using the final 
field. But only partially cleaning the struct looks weird and could 
potentially cause problems if subsequent code changes introduce code 
that attempts to read uninitialized data from num_buffers later.

With that change made:
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>


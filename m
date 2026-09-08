Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D6B6C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 18:33:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x40cz-0005o1-0y; Tue, 08 Sep 2026 14:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1x40cx-0005nG-5E; Tue, 08 Sep 2026 14:33:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1x40cv-0002V3-Ad; Tue, 08 Sep 2026 14:33:02 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688F1nT7080816; Tue, 8 Sep 2026 18:32:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=3RHdMF
 wcEIwIG0ZnRutnz8XnJJ8Dl7+dov+V6e3zAX8=; b=riHDw7vAhvpkJOsu3QMCCw
 p727OrqV+HDtrtHApiVLS5Rls8nhl1RM7UHVpfzdYJ0BLoZ+OZuhh/7fJUgcYZ9O
 XlNQ6YMPgSQAW0q0EX5fnue7QUUb8/nMUDc/Z+pH1XZp36oxCjKdby04nRTI3P4j
 8ATsm/of2KAyApUc2hz2cDy7Xp04sJZXNVLKAEvDZhTKbm3CHnimDpfAVZbqLVdY
 GGDdbE/Wiv9AaJS+U4qeG1Sd4eb9wsNNdkw43mmXwvzE6IcsipmNalotUzw2ZW41
 EWwMdW4YIRT8Q68Eih2u/z6DhMQ7yIzIewwa8/cD3+DUhJ2P3VW3pMajqMu5Hh0g
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbjrrub9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 18:32:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 688IQG2d025627;
 Tue, 8 Sep 2026 18:32:58 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ggwdqdung-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 18:32:58 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 688IWuZ227525784
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Sep 2026 18:32:56 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 897F358056;
 Tue,  8 Sep 2026 18:32:56 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7BC265805A;
 Tue,  8 Sep 2026 18:32:55 +0000 (GMT)
Received: from [9.61.69.254] (unknown [9.61.69.254])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Tue,  8 Sep 2026 18:32:55 +0000 (GMT)
Message-ID: <55c42f23-8372-45c5-8d89-3deeee840128@linux.ibm.com>
Date: Tue, 8 Sep 2026 14:32:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] pc-bios/s390-ccw: Add dynamic net header size
 handling
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, borntraeger@linux.ibm.com, jjherne@linux.ibm.com,
 cohuck@redhat.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 pasic@linux.ibm.com, farosas@suse.de, lvivier@redhat.com,
 jdaley@linux.ibm.com, pbonzini@redhat.com
References: <20260903162449.2588271-1-zycai@linux.ibm.com>
 <20260903162449.2588271-3-zycai@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20260903162449.2588271-3-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E7T9Y6dl c=1 sm=1 tr=0 ts=6aa054db cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=9-f3ttb9_-6f4UP9zi4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDIwMSBTYWx0ZWRfXxzD+v9oi/OZD
 zE4RoQCvSX+VDC2bfZEL9p6CHvyylXaf5u9hBoTNA77uO7r3xWSJqUPM9uYbkHcJE7weE234FVe
 1oFUS3ACMXSHMkKDfzGXTKP6ZXyndCM=
X-Proofpoint-ORIG-GUID: OpBkjF7_izyU6bCuwV6RdVUA1Ao5zh6n
X-Proofpoint-GUID: OpBkjF7_izyU6bCuwV6RdVUA1Ao5zh6n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDIwMSBTYWx0ZWRfX0Im1wGS8HUmu
 zvrPgo1g3SSu3ZTDEwrjJTPmmii2hIdFuVEhFl7hl7C+FhiNipy9Ncf61GM3ioFid0eTvzXLgGf
 GVjfiwR/OeEsFtTxh5UOYQFCXRbzGzWEx8Jg61JH74zMdyreBoqvldg26s8ipcqIl5norAS0XUK
 tFdk9MvsuUgz2dRT1OlkRyvOzK9kBynCGR1O/bUE9WmCzxwvtDfUDDkeA623+T/1HPz/p+iEdGi
 d3PRXCsWGLyDoJF0gKQmOHvZMddu90eDH7Y6F97dGDD8ddurkPFpW4Qox8QNjBqRkC3Hj7V2tKa
 R39DOxnQ/h7Xu5aRSqOLcXX1kelcixww0p09oHZ52hizNw58wz+lfmEtaJJzisJGsIZyC0/QtuA
 b/YJsHl2EpbJBLLcqhc18l2DWBtploLggGdnP2bdkgvbUpNs+07FJkKLVzqLLt9VYmZuqrCiAF+
 jUWFYRhvH0yJAM4fXNg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080201
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



On 9/3/26 12:24 PM, Zhuoying Cai wrote:
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
>   pc-bios/s390-ccw/virtio-net.c | 30 ++++++++++++++++++++++++------
>   1 file changed, 24 insertions(+), 6 deletions(-)
>
> diff --git a/pc-bios/s390-ccw/virtio-net.c b/pc-bios/s390-ccw/virtio-net.c
> index f58f7ffc55..afa728bc32 100644
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
> @@ -28,6 +29,7 @@
>   #endif
>   
>   #define VIRTIO_NET_F_MAC_BIT  (1 << 5)
> +#define VIRTIO_NET_F_MRG_RXBUF_BIT (1 << 15)

We define this new feature bit, but it looks like we never set it.

The existing virtio_net_init() code has only:

vdev->guest_features[0] = VIRTIO_NET_F_MAC_BIT;

Should it be updated to VIRTIO_NET_F_MAC_BIT | VIRTIO_NET_F_MRG_RXBUF_BIT?

Is the new feature bit something we want to unconditionally request, only
request for PCI, or do we simply not care about it?
>   
>   #define VQ_RX 0         /* Receive queue */
>   #define VQ_TX 1         /* Transmit queue */
> @@ -43,7 +45,18 @@ struct VirtioNetHdr {
>   };
>   typedef struct VirtioNetHdr VirtioNetHdr;
>   
> +struct VirtioNetHdrMrgRxbuf {
> +    struct VirtioNetHdr hdr;
> +    uint16_t num_buffers; /* Only with VIRTIO_NET_F_MRG_RXBUF or VIRTIO1 */
> +};
> +typedef struct VirtioNetHdrMrgRxbuf VirtioNetHdrMrgRxbuf;
> +
> +/* Header sizes for different modes */
> +#define VIRTIO_NET_HDR_SIZE_LEGACY  sizeof(VirtioNetHdr)
> +#define VIRTIO_NET_HDR_SIZE_V1      sizeof(VirtioNetHdrMrgRxbuf)
> +
>   static uint16_t rx_last_idx;  /* Last index in receive queue "used" ring */
> +static int virtio_net_hdr_size;
>   
>   int virtio_net_init(void *mac_addr)
>   {
> @@ -62,12 +75,17 @@ int virtio_net_init(void *mac_addr)
>           return -1;
>       }
>   
> +    virtio_net_hdr_size = ((vdev->guest_features[1] & VIRTIO_F_VERSION_1) ||
> +                           (vdev->guest_features[0] & VIRTIO_NET_F_MRG_RXBUF_BIT))

Because we do not set VIRTIO_NET_F_MRG_RXBUF in net_init(), only the first
half of this check can ever return true.

Maybe that is correct, but in that case we can simplify this to just
vdev->guest_features[1] & VIRTIO_F_VERSION_1, right?

Regards,
Jared Rossi
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
> @@ -77,14 +95,14 @@ int virtio_net_init(void *mac_addr)
>   
>   int send(int fd, const void *buf, int len, int flags)
>   {
> -    VirtioNetHdr tx_hdr;
> +    VirtioNetHdrMrgRxbuf tx_hdr;
>       VDev *vdev = virtio_get_device();
>       VRing *txvq = &vdev->vrings[VQ_TX];
>   
>       /* Set up header - we do not use anything special, so simply clear it */
>       memset(&tx_hdr, 0, sizeof(tx_hdr));
>   
> -    vring_send_buf(txvq, &tx_hdr, sizeof(tx_hdr), VRING_DESC_F_NEXT);
> +    vring_send_buf(txvq, &tx_hdr, virtio_net_hdr_size, VRING_DESC_F_NEXT);
>       vring_send_buf(txvq, (void *)buf, len, VRING_HIDDEN_IS_CHAIN);
>       while (!vr_poll(txvq)) {
>           yield();
> @@ -108,13 +126,13 @@ int recv(int fd, void *buf, int maxlen, int flags)
>           return 0;
>       }
>   
> -    len = rxvq->used->ring[rx_last_idx % rxvq->num].len - sizeof(VirtioNetHdr);
> +    len = rxvq->used->ring[rx_last_idx % rxvq->num].len - virtio_net_hdr_size;
>       if (len > maxlen) {
>           puts("virtio-net: Receive buffer too small");
>           len = maxlen;
>       }
>       id = rxvq->used->ring[rx_last_idx % rxvq->num].id % rxvq->num;
> -    pkt = (uint8_t *)(rxvq->desc[id].addr + sizeof(VirtioNetHdr));
> +    pkt = (uint8_t *)(rxvq->desc[id].addr + virtio_net_hdr_size);
>   
>   #if DEBUG_VIRTIO_NET   /* Dump packet */
>       int i;



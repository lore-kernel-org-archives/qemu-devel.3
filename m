Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7C3C79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 17:54:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4MUV-0007b2-76; Wed, 09 Sep 2026 13:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1x4MUR-0007ZU-Qq; Wed, 09 Sep 2026 13:53:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1x4MUP-00044B-Rq; Wed, 09 Sep 2026 13:53:43 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 689HVYw1478816; Wed, 9 Sep 2026 17:53:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=3JQ1TH
 UAtSkT5bkWJqvWSqgRxag67HmtlnrQnkfxyT0=; b=H520tMlaVCIe8/TRc9cIpz
 zj3NwQ0mtzCJ7LMcXJ6fvWRBvLz7KJ708vysqMOAEHQE99N39I4TobaPhSYy6jOQ
 v/CL1zAC98ovN7B0GPPHo49XEE0TSY8MqCJVbJIqpSaJ6obvoh2l1P9jkTjek2zD
 6I2gPKGsMzipwTKInSkiYsYdI8Xnulzu3p1zCyUQyCIEce4DRO+JFVNV7+a6iFPa
 DbqueCjzgKm/M42tbnOOgcsUaCNbPnEZieYAhx0kKlvGMl+s9pO0JKYBjf/OKKER
 BeeDGh3Xn+RrR17jZulmPFcz1xGfBbFWZGvrLSioQ9+GP9NFshEfQ8cducFU1F2g
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbhf75re-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Sep 2026 17:53:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 689HfEfA026687;
 Wed, 9 Sep 2026 17:53:38 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggxdk3qy6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Sep 2026 17:53:38 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 689HraLA53019058
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 9 Sep 2026 17:53:37 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D534358065;
 Wed,  9 Sep 2026 17:53:36 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7AA0158066;
 Wed,  9 Sep 2026 17:53:35 +0000 (GMT)
Received: from [9.61.48.189] (unknown [9.61.48.189])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  9 Sep 2026 17:53:35 +0000 (GMT)
Message-ID: <e65f6962-ae40-4731-ab21-34b4626540ef@linux.ibm.com>
Date: Wed, 9 Sep 2026 09:28:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] pc-bios/s390-ccw: Add support for virtio-net-pci
 IPL
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, borntraeger@linux.ibm.com,
 cohuck@redhat.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 pasic@linux.ibm.com, farosas@suse.de, lvivier@redhat.com,
 jdaley@linux.ibm.com, pbonzini@redhat.com
References: <20260903162449.2588271-1-zycai@linux.ibm.com>
 <20260903162449.2588271-5-zycai@linux.ibm.com>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <20260903162449.2588271-5-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KfRHhGasTZ5uPQ5igbfZ-ktbox54dMCv
X-Authority-Analysis: v=2.4 cv=RIaD2Yi+ c=1 sm=1 tr=0 ts=6aa19d22 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=ctsVLiZ_AAAA:8 a=x_p9n0nBIIB2vPYBkI4A:9 a=QEXdDO2ut3YA:10
 a=3VCIHQLkQthbvTRuo98s:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE5NSBTYWx0ZWRfX2gmlcOPSJ3hM
 Fn6x7YxtI2myaeUc/HpNJ+rbfKODeBr315SCIejJP/2rShSYPVFEjGZ+vGND9EyHNq/9BByRL3D
 WEAreaEvez53vVVAAj07QmWHNLd2gt0=
X-Proofpoint-ORIG-GUID: KfRHhGasTZ5uPQ5igbfZ-ktbox54dMCv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE5NSBTYWx0ZWRfXyPTZvxLkomTh
 VJ7fmHOJjgGx2U0qHQYz1ZXhnlwAD88+GhkLEKZJw4iCN0mcz6lZoXiZBXZIXj2Q3TT0cwNRpVB
 JNvMgAql2BokL+5etKr/xxOFvk0yqxj0oKMhmv5XgJd7Bm4crsNhxRpEzgtoE6oeRex5lE9r4N1
 WA67cZEsDhG0i5eyZGXXJEKk2OxuzDBK+moyupP4Gudj8fNvaMH467mAOn5KE/GJh78PEKAks3m
 CvJEZ7K3+t3gqf69nUoy/fA5OXS6g0d9ot+XsAqihWe55SER4B1KgKOXqCQgbAZpMOJab/ayDBz
 h3V/rd2xEd8NrRg/8aXDgVkE78C3oFgs04P4U2YcYOHqyerZwOF5oxlcoC6PGD4ULJgQmz9l8yp
 aBvbBKRSic0EDlj7x7NHl+tOYGj9HZc7/ocuDJlOy2G8i1uTrqWgkRF2sX9/KHRJfCB+zbgXcU1
 6REYcck6wkiwFTrX9AA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090195
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jjherne@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 9/3/26 12:24 PM, Zhuoying Cai wrote:
> Enable network booting via virtio-net-pci by implementing PCI transport
> support for virtio-net.
> 
> This patch also extends endianness handling for virtio PCI ring operations in
> little-endian to ensure correct behavior on s390x.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/main.c       |  1 +
>   pc-bios/s390-ccw/netmain.c    |  9 +++++++-
>   pc-bios/s390-ccw/virtio-net.c | 41 ++++++++++++++++++++++++++++-------
>   pc-bios/s390-ccw/virtio-pci.c | 18 +++++++++++++++
>   4 files changed, 60 insertions(+), 9 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index 8fc1cbf653..28cab3b411 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -332,6 +332,7 @@ static void ipl_pci_device(void)
>       }
>   
>       switch (vdev->dev_type) {
> +    case VIRTIO_ID_NET:
>       case VIRTIO_ID_BLOCK:
>           if (virtio_setup() == 0) {
>               zipl_load(); /* only return on error */
> diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
> index bcb62bf6ca..e42e049063 100644
> --- a/pc-bios/s390-ccw/netmain.c
> +++ b/pc-bios/s390-ccw/netmain.c
> @@ -498,7 +498,14 @@ int netmain(void)
>       sclp_setup();
>       puts("Network boot starting...");
>   
> -    if (!virtio_ccw_net_setup()) {
> +    /*
> +     * CCW devices require subchannel enumeration here.
> +     * PCI devices don't require specific setup: the transport is already
> +     * initialized by ipl_pci_device(), and virtio_is_supported() is checked
> +     * later in virtio_net_init().
> +     */
> +    if (virtio_get_device()->ipl_type == S390_IPL_TYPE_CCW &&
> +        !virtio_ccw_net_setup()) {
>           puts("No valid virtio ccw net device found.");
>           return -1;
>       }
> diff --git a/pc-bios/s390-ccw/virtio-net.c b/pc-bios/s390-ccw/virtio-net.c
> index afa728bc32..418759565d 100644
> --- a/pc-bios/s390-ccw/virtio-net.c
> +++ b/pc-bios/s390-ccw/virtio-net.c
> @@ -68,7 +68,22 @@ int virtio_net_init(void *mac_addr)
>       rx_last_idx = 0;
>   
>       vdev->guest_features[0] = VIRTIO_NET_F_MAC_BIT;
> -    virtio_ccw_setup(vdev);
> +    switch (virtio_get_device()->ipl_type) {
> +    case S390_IPL_TYPE_CCW:
> +        if (virtio_ccw_setup(vdev)) {
> +            puts("Setup failed for virtio-net-ccw");
> +            return -1;
> +        }
> +        break;
> +    case S390_IPL_TYPE_PCI:
> +        if (virtio_pci_setup(vdev)) {
> +            puts("Setup failed for virtio-net-pci");
> +            return -1;
> +        }
> +        break;
> +    default:
> +        return -1;
> +    }
>   
>       if (!(vdev->guest_features[0] & VIRTIO_NET_F_MAC_BIT)) {
>           puts("virtio-net device does not support the MAC address feature");
> @@ -121,22 +136,30 @@ int recv(int fd, void *buf, int maxlen, int flags)
>       VRing *rxvq = &vdev->vrings[VQ_RX];
>       int len, id;
>       uint8_t *pkt;
> +    uint16_t rx_used_idx, rx_avail_idx;
> +    uint32_t rx_used_len, rx_used_id;
> +    uint64_t rx_desc_addr;
>   
> -    if (rx_last_idx == rxvq->used->idx) {
> +    rx_used_idx = virtio_tswap16(rxvq->used->idx);
> +    if (rx_last_idx == rx_used_idx) {
>           return 0;
>       }
>   
> -    len = rxvq->used->ring[rx_last_idx % rxvq->num].len - virtio_net_hdr_size;
> +    rx_used_len = virtio_tswap32(rxvq->used->ring[rx_last_idx % rxvq->num].len);
> +    rx_used_id = virtio_tswap32(rxvq->used->ring[rx_last_idx % rxvq->num].id);
> +
> +    len = rx_used_len - virtio_net_hdr_size;
>       if (len > maxlen) {
>           puts("virtio-net: Receive buffer too small");
>           len = maxlen;
>       }
> -    id = rxvq->used->ring[rx_last_idx % rxvq->num].id % rxvq->num;
> -    pkt = (uint8_t *)(rxvq->desc[id].addr + virtio_net_hdr_size);
> +    id = rx_used_id % rxvq->num;
> +    rx_desc_addr = virtio_tswap64(rxvq->desc[id].addr);
> +    pkt = (uint8_t *)(rx_desc_addr + virtio_net_hdr_size);
>   
>   #if DEBUG_VIRTIO_NET   /* Dump packet */
>       int i;
> -    printf("\nbuf %p: len=%i\n", (void *)rxvq->desc[id].addr, len);
> +    printf("\nbuf %p: len=%i\n", (void *)rx_desc_addr, len);
>       for (i = 0; i < 64; i++) {
>           printf(" %02x", pkt[i]);
>           if ((i % 16) == 15) {
> @@ -150,8 +173,10 @@ int recv(int fd, void *buf, int maxlen, int flags)
>       memcpy(buf, pkt, len);
>   
>       /* Mark buffer as available to the host again */
> -    rxvq->avail->ring[rxvq->avail->idx % rxvq->num] = id;
> -    rxvq->avail->idx = rxvq->avail->idx + 1;
> +    rx_avail_idx = virtio_tswap16(rxvq->avail->idx);
> +    rxvq->avail->ring[rx_avail_idx % rxvq->num] = virtio_tswap16(id);
> +    rx_avail_idx++;
> +    rxvq->avail->idx = virtio_tswap16(rx_avail_idx);
>       vring_notify(rxvq);
>   
>       /* Move index to next entry */
> diff --git a/pc-bios/s390-ccw/virtio-pci.c b/pc-bios/s390-ccw/virtio-pci.c
> index f501252c81..147a82895f 100644
> --- a/pc-bios/s390-ccw/virtio-pci.c
> +++ b/pc-bios/s390-ccw/virtio-pci.c
> @@ -52,6 +52,10 @@ void virtio_pci_id2type(VDev *vdev, uint16_t device_id)
>       case 0x1001:
>           vdev->dev_type = VIRTIO_ID_BLOCK;
>           break;
> +    case 0x1041:
> +    case 0x1000:
> +        vdev->dev_type = VIRTIO_ID_NET;
> +        break;
>       default:
>           vdev->dev_type = 0;
>       }
> @@ -199,6 +203,14 @@ static int virtio_pci_get_blk_config(void)
>       return rc;
>   }
>   
> +static int virtio_pci_get_net_config(void)
> +{
> +    VirtioNetConfig *cfg = &virtio_get_device()->config.net;
> +    int rc = vpci_read_flex(d_cap.off, d_cap.bar, cfg, sizeof(VirtioNetConfig));
> +
> +    return rc;
> +}
> +

Simplify to this:

static int virtio_pci_get_net_config(void)
{
     VirtioNetConfig *cfg = &virtio_get_device()->config.net;

     return vpci_read_flex(d_cap.off, d_cap.bar, cfg, 
sizeof(VirtioNetConfig));
}


>   static int virtio_pci_negotiate(void)
>   {
>       int i, rc;
> @@ -330,6 +342,7 @@ bool virtio_pci_is_supported(VDev *vdev)
>       if (vdev->vendor_id == PCI_VENDOR_VIRTIO) {
>           switch (vdev->dev_type) {
>           case VIRTIO_ID_BLOCK:
> +        case VIRTIO_ID_NET:
>               return true;
>           default:
>               return false;
> @@ -384,6 +397,11 @@ int virtio_pci_setup(VDev *vdev)
>           vdev->cmd_vr_idx = 0;
>           virtio_pci_get_blk_config();
>           break;
> +    case VIRTIO_ID_NET:
> +        vdev->nr_vqs = 2;
> +        vdev->cmd_vr_idx = 0;

cmd_vr_idx is never actually used for net devices. I'm thinking we want 
to skip setting it here. It's actually already set to 0 above, in common 
code, before we know what device type we're dealing with.



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B1FC79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 13:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Ibp-000804-MW; Wed, 09 Sep 2026 09:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x4Ibo-0007zJ-3V; Wed, 09 Sep 2026 09:45:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x4Ibm-0007Vs-7X; Wed, 09 Sep 2026 09:45:03 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 689B2T2R3841412; Wed, 9 Sep 2026 13:44:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=HgovCZ
 OWY2OvNbo3BMMC7f8kLfiwUXOgUA2HiZ2mDX4=; b=pKLeBUfES891BWQoAkNqU0
 iqmwgSnKdUUVScIboZEgPF46Zn2AKbHYaLD7s8U29eCWGYp8g9R0AXmWcNmvox/5
 N+XEoMZMq/IcGdlvRgru6uE5qltwEKHIDQQM5/ubH77x9ZD4ZfAJ7xq8IxZkSTq8
 fupHmVUh/zCr6nXQk9bYwCsVBqxt1az25CxDEpUCIJDon6uhNr8BTspc/Ot3GJ8R
 0LviGB6pM45U4kIdnLXLLzWNSI64uug5xOdjF98u9oc4I+2EBHTQFP6ZgtQTX7FI
 Tynq6HzBn7pkUbPIVTU9Q09Uh9yYT5YQ4aHAEgkFs3Zivmm5PurA1U4MdvlPU4BQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbhf5th2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Sep 2026 13:44:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 689DfFeU032103;
 Wed, 9 Sep 2026 13:44:58 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggxdk2jsm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Sep 2026 13:44:58 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 689Div4q24052436
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 9 Sep 2026 13:44:57 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4EEB158043;
 Wed,  9 Sep 2026 13:44:57 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC1DE58059;
 Wed,  9 Sep 2026 13:44:55 +0000 (GMT)
Received: from [9.61.50.5] (unknown [9.61.50.5])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  9 Sep 2026 13:44:55 +0000 (GMT)
Message-ID: <872239f9-5aad-491f-a6b3-da78ecc569d9@linux.ibm.com>
Date: Wed, 9 Sep 2026 09:44:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] pc-bios/s390-ccw: Add dynamic net header size
 handling
To: Jared Rossi <jrossi@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, borntraeger@linux.ibm.com, jjherne@linux.ibm.com,
 cohuck@redhat.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 pasic@linux.ibm.com, farosas@suse.de, lvivier@redhat.com,
 jdaley@linux.ibm.com, pbonzini@redhat.com
References: <20260903162449.2588271-1-zycai@linux.ibm.com>
 <20260903162449.2588271-3-zycai@linux.ibm.com>
 <55c42f23-8372-45c5-8d89-3deeee840128@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <55c42f23-8372-45c5-8d89-3deeee840128@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5LZsf-WOYikEYdoWHioseVK8KBF7BaGq
X-Authority-Analysis: v=2.4 cv=RIaD2Yi+ c=1 sm=1 tr=0 ts=6aa162db cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=I9RSR5Jx9dm8StX2wbUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE1MSBTYWx0ZWRfX7Pl6xZRVpUZt
 mnl9LPKFfZP+CZGy1fCnItJiV8y3dqzcF63J1tupuXb1qsaVqB9ORv2w3PRLp8DM30bzt7KHuYJ
 EbEfwd0JgOtUNeqGYyyDZHAAKe09d0Y=
X-Proofpoint-ORIG-GUID: 5LZsf-WOYikEYdoWHioseVK8KBF7BaGq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE1MSBTYWx0ZWRfX3hXmgUoDzJA6
 KDKgT5SynRt5ixrFpIbLJz6ecqPx3Q/nnUEXr9+jdEAa5zfySAoUu9YRGMijzWPe9nEAAoActoq
 UYgFvAgw9YJ2DHYN2Phf6T45sLvzSHWSANq3ajUd99Yv5u279kEGDVPOHuJHjxQA25o4JRdkgUt
 DOrZIfTUQSfxlpmF9/2a4A73695xdiaZh3i5b6t7wVudKH5I5vAU0e346X/79q+lYGGcag/+jYK
 popr/hz8ad8ru0ICjuwd2XWX616woeg57spG+l0HDqDeY5adKl3oULTutah34tmjR6ED8RrNzWh
 kqT4YlZTo8FTf/GvYskiLijV3ufmj/Q1gNXT6seyIwjM8BsNJuDzIpjhi4o+TVaZinmGMsEXCAi
 ye5H1jJlyDe/Y3OXaJJ1evzTUmSCVtVBQyTTTMZHIy/iiISiJTjMJPGAzl8N8AEGiCcC0+5JdHF
 +VjHWQmYEFoplREi0VQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090151
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
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

On 9/8/26 2:32 PM, Jared Rossi wrote:
> 
> 
> On 9/3/26 12:24 PM, Zhuoying Cai wrote:
>> The virtio-net device used a fixed header size that did not account for
>> the num_buffers field used in VirtIO 1.0 or for the mergeable receive
>> buffers feature.
>>
>> Use dynamic header sizing: 10 bytes for legacy mode and 12 bytes for
>> VirtIO 1.0 or when VIRTIO_NET_F_MRG_RXBUF is enabled. This ensures
>> correct packet handling across different VirtIO configurations.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> ---
>>   pc-bios/s390-ccw/virtio-net.c | 30 ++++++++++++++++++++++++------
>>   1 file changed, 24 insertions(+), 6 deletions(-)
>>
>> diff --git a/pc-bios/s390-ccw/virtio-net.c b/pc-bios/s390-ccw/virtio-net.c
>> index f58f7ffc55..afa728bc32 100644
>> --- a/pc-bios/s390-ccw/virtio-net.c
>> +++ b/pc-bios/s390-ccw/virtio-net.c
>> @@ -20,6 +20,7 @@
>>   #include "s390-ccw.h"
>>   #include "virtio.h"
>>   #include "virtio-ccw.h"
>> +#include "virtio-pci.h"
>>   #include "s390-time.h"
>>   #include "helper.h"
>>   
>> @@ -28,6 +29,7 @@
>>   #endif
>>   
>>   #define VIRTIO_NET_F_MAC_BIT  (1 << 5)
>> +#define VIRTIO_NET_F_MRG_RXBUF_BIT (1 << 15)
> 
> We define this new feature bit, but it looks like we never set it.
> 
> The existing virtio_net_init() code has only:
> 
> vdev->guest_features[0] = VIRTIO_NET_F_MAC_BIT;
> 
> Should it be updated to VIRTIO_NET_F_MAC_BIT | VIRTIO_NET_F_MRG_RXBUF_BIT?
> 
> Is the new feature bit something we want to unconditionally request, only
> request for PCI, or do we simply not care about it?

As of now, we do not care about VIRTIO_NET_F_MRG_RXBUF_BIT. I added it
because the num_buffers field in VirtioNetHdrMrgRxbuf is present when
either condition is true, and we might want to use it in the future.

>>   
>>   #define VQ_RX 0         /* Receive queue */
>>   #define VQ_TX 1         /* Transmit queue */
>> @@ -43,7 +45,18 @@ struct VirtioNetHdr {
>>   };
>>   typedef struct VirtioNetHdr VirtioNetHdr;
>>   
>> +struct VirtioNetHdrMrgRxbuf {
>> +    struct VirtioNetHdr hdr;
>> +    uint16_t num_buffers; /* Only with VIRTIO_NET_F_MRG_RXBUF or VIRTIO1 */
>> +};
>> +typedef struct VirtioNetHdrMrgRxbuf VirtioNetHdrMrgRxbuf;
>> +
>> +/* Header sizes for different modes */
>> +#define VIRTIO_NET_HDR_SIZE_LEGACY  sizeof(VirtioNetHdr)
>> +#define VIRTIO_NET_HDR_SIZE_V1      sizeof(VirtioNetHdrMrgRxbuf)
>> +
>>   static uint16_t rx_last_idx;  /* Last index in receive queue "used" ring */
>> +static int virtio_net_hdr_size;
>>   
>>   int virtio_net_init(void *mac_addr)
>>   {
>> @@ -62,12 +75,17 @@ int virtio_net_init(void *mac_addr)
>>           return -1;
>>       }
>>   
>> +    virtio_net_hdr_size = ((vdev->guest_features[1] & VIRTIO_F_VERSION_1) ||
>> +                           (vdev->guest_features[0] & VIRTIO_NET_F_MRG_RXBUF_BIT))
> 
> Because we do not set VIRTIO_NET_F_MRG_RXBUF in net_init(), only the first
> half of this check can ever return true.
> 
> Maybe that is correct, but in that case we can simplify this to just
> vdev->guest_features[1] & VIRTIO_F_VERSION_1, right?
> 

Since VIRTIO_NET_F_MRG_RXBUF is neither negotiated nor used today, I can
remove it entirely and simplify the check to vdev->guest_features[1] &
VIRTIO_F_VERSION_1.

> Regards,
> Jared Rossi
>> +                          ? VIRTIO_NET_HDR_SIZE_V1
>> +                          : VIRTIO_NET_HDR_SIZE_LEGACY;
>> +
>>       memcpy(mac_addr, vdev->config.net.mac, ETH_ALEN);
>>   
>>       for (i = 0; i < 64; i++) {
>> -        buf = malloc(ETH_MTU_SIZE + sizeof(VirtioNetHdr));
>> +        buf = malloc(ETH_MTU_SIZE + virtio_net_hdr_size);
>>           IPL_assert(buf != NULL, "Can not allocate memory for receive buffers");
>> -        vring_send_buf(rxvq, buf, ETH_MTU_SIZE + sizeof(VirtioNetHdr),
>> +        vring_send_buf(rxvq, buf, ETH_MTU_SIZE + virtio_net_hdr_size,
>>                          VRING_DESC_F_WRITE);
>>       }
>>       vring_notify(rxvq);
>> @@ -77,14 +95,14 @@ int virtio_net_init(void *mac_addr)
>>   
>>   int send(int fd, const void *buf, int len, int flags)
>>   {
>> -    VirtioNetHdr tx_hdr;
>> +    VirtioNetHdrMrgRxbuf tx_hdr;
>>       VDev *vdev = virtio_get_device();
>>       VRing *txvq = &vdev->vrings[VQ_TX];
>>   
>>       /* Set up header - we do not use anything special, so simply clear it */
>>       memset(&tx_hdr, 0, sizeof(tx_hdr));
>>   
>> -    vring_send_buf(txvq, &tx_hdr, sizeof(tx_hdr), VRING_DESC_F_NEXT);
>> +    vring_send_buf(txvq, &tx_hdr, virtio_net_hdr_size, VRING_DESC_F_NEXT);
>>       vring_send_buf(txvq, (void *)buf, len, VRING_HIDDEN_IS_CHAIN);
>>       while (!vr_poll(txvq)) {
>>           yield();
>> @@ -108,13 +126,13 @@ int recv(int fd, void *buf, int maxlen, int flags)
>>           return 0;
>>       }
>>   
>> -    len = rxvq->used->ring[rx_last_idx % rxvq->num].len - sizeof(VirtioNetHdr);
>> +    len = rxvq->used->ring[rx_last_idx % rxvq->num].len - virtio_net_hdr_size;
>>       if (len > maxlen) {
>>           puts("virtio-net: Receive buffer too small");
>>           len = maxlen;
>>       }
>>       id = rxvq->used->ring[rx_last_idx % rxvq->num].id % rxvq->num;
>> -    pkt = (uint8_t *)(rxvq->desc[id].addr + sizeof(VirtioNetHdr));
>> +    pkt = (uint8_t *)(rxvq->desc[id].addr + virtio_net_hdr_size);
>>   
>>   #if DEBUG_VIRTIO_NET   /* Dump packet */
>>       int i;
> 



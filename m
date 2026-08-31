Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D1A6C61DFD
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 18:36:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x16rl-0003iL-Kn; Mon, 31 Aug 2026 14:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x16rh-0003hQ-04; Mon, 31 Aug 2026 14:36:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x16ra-0002zG-UM; Mon, 31 Aug 2026 14:36:13 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VIVbIG1235188; Mon, 31 Aug 2026 18:36:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=XpASYh
 qHXy7bJtHUKM9K69uQsmwkvvRshP/kZFHb6fU=; b=dAtUUha3ZLAAaO32RK4nXk
 8fZW7x2A/QTF8gkWL2sNbuvJMWYFGpReWGU2Q7Vj51itXuPLOuZNx1pCgQpFB5l8
 3bSV+EiWr3m/hz5hNRn8lxdarOHntCA+/5Qn/uGTjm+VzC2SsAEf11eBXDcGXWFo
 2przvvReCR6cnfMIddNrKufGh/u+tR+Kf7sLgA+qNJpSVFvZnX0pSQli8I0bF0E/
 HD5xydDSXYnSGYmaGviKsqx8aKioPx4j9iFsE+zJQg8iqQGvCbIB/cxvSAhlJ3wr
 2pOtjvA9zkMrEz6KhL/AWQei60xw0TDoe1cA1u3SzE4bK7aWuce1nhBRaQ9oMb4w
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3r34ya-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 18:36:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VIU9IN022170;
 Mon, 31 Aug 2026 18:36:07 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8h7da0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 18:36:07 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67VIa6pR32965150
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Aug 2026 18:36:06 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4481358059;
 Mon, 31 Aug 2026 18:36:06 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0216058058;
 Mon, 31 Aug 2026 18:36:05 +0000 (GMT)
Received: from [9.61.73.66] (unknown [9.61.73.66])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 31 Aug 2026 18:36:04 +0000 (GMT)
Message-ID: <bbbdc3cd-9389-4c32-a9d7-0e1c9336841a@linux.ibm.com>
Date: Mon, 31 Aug 2026 14:36:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/7] pc-bios/s390-ccw: Add support for virtio-net-pci
 IPL
To: Jared Rossi <jrossi@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, borntraeger@linux.ibm.com, jjherne@linux.ibm.com,
 cohuck@redhat.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 pasic@linux.ibm.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com
References: <20260818205324.580199-1-zycai@linux.ibm.com>
 <20260818205324.580199-5-zycai@linux.ibm.com>
 <5a7ed440-ed57-448a-9baa-4626464ee9f8@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <5a7ed440-ed57-448a-9baa-4626464ee9f8@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a95c998 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=ctsVLiZ_AAAA:8 a=kIP0pMTcak2oO-wSoEIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3VCIHQLkQthbvTRuo98s:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE2MCBTYWx0ZWRfX/wD/24MZvNQ5
 F81n0NxlvXAjWhGzC2pRAi2tlMVaRo+DSDmgU3iJT0vrCBAx0rwKF8IUiOhnxx74bfxHsTiV1B+
 AopeIB2FFtrXgMy7282S77mRyklT6+89daoo5KZFDwCbRa4lPUboWBfW5ahIqrWLcAGuNKU5kRT
 gNEHZ2pYKw9blXbRC4Je/Ib5WJDwJ9f/uTFMA+Q/V2IkGC9VvPz2ODVwf0nFVLJ6WRuh+dfE/51
 2U5EqfZDdhXFAgFrrMGMKKSbYJTeeVkfTp0fqow3n9jqXYn+ItY6u7Sq+KZozxJGEqbNtxleQNe
 ofPUR1WJx513FUo7V85Sap7v17N5uHsI0ykdSEv8olu/pWeDvgHoXCk1nYfGlqlDMpnHkTpk7AK
 rps2+g0AGdUxt/fJ4RhDVn3ZPDY1mvX6Qn9kErdnuBotdXHCbzD3i1rPDbDrtin68cTc3iV1lAs
 iq/f1ulOX5fjcwf96Pw==
X-Proofpoint-GUID: tJFC-WnqB4mQkan6klJlynnR6JGq17I5
X-Proofpoint-ORIG-GUID: tJFC-WnqB4mQkan6klJlynnR6JGq17I5
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE2MCBTYWx0ZWRfX8lc0CBbc5LfM
 baZ+Fcv7luYqwKEepgr4EHlfhqxOYoN+GiOeCHwBdi0ByhzvQWnsdzUqfW87iL2TXGHCKYB9EBk
 fk3MV0f9wMYmbI/KKfWo4mF2Rk626HI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_06,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310160
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
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

Thanks for the feedback!

On 8/26/26 12:44 PM, Jared Rossi wrote:
> 
> 
> On 8/18/26 4:53 PM, Zhuoying Cai wrote:
>> Enable network booting via virtio-net-pci by implementing PCI transport
>> support for virtio-net.
>>
>> This patch also adds endianness handling for virtio PCI ring operations in
>> little-endian to ensure correct behavior on s390x.
> 
> Endianness handling was actually added in the previous patch.  Is this a
> misplaced message? Or perhaps it should say extends, rather than adds?
> 

Good catch. It should be "extends" rather than "adds". I'll update the
commit message.

>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> ---
>>   pc-bios/s390-ccw/main.c       |  1 +
>>   pc-bios/s390-ccw/virtio-net.c | 37 +++++++++++++++++++++++-------
>>   pc-bios/s390-ccw/virtio-pci.c | 43 +++++++++++++++++++++++++++++++++++
>>   pc-bios/s390-ccw/virtio-pci.h |  2 ++
>>   4 files changed, 75 insertions(+), 8 deletions(-)
>>
>> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
>> index 8bc6e8eaa3..0eeb53a2bf 100644
>> --- a/pc-bios/s390-ccw/main.c
>> +++ b/pc-bios/s390-ccw/main.c
>> @@ -328,6 +328,7 @@ static void ipl_pci_device(void)
>>       }
>>   
>>       switch (vdev->dev_type) {
>> +    case VIRTIO_ID_NET:
>>       case VIRTIO_ID_BLOCK:
>>           if (virtio_setup() == 0) {
>>               zipl_load(); /* only return on error */
>> diff --git a/pc-bios/s390-ccw/virtio-net.c b/pc-bios/s390-ccw/virtio-net.c
>> index 3a9ae789cf..209f98a0e3 100644
>> --- a/pc-bios/s390-ccw/virtio-net.c
>> +++ b/pc-bios/s390-ccw/virtio-net.c
>> @@ -62,7 +62,16 @@ int virtio_net_init(void *mac_addr)
>>       rx_last_idx = 0;
>>   
>>       vdev->guest_features[0] = VIRTIO_NET_F_MAC_BIT;
>> -    virtio_ccw_setup(vdev);
>> +    switch (virtio_get_device()->ipl_type) {
>> +    case S390_IPL_TYPE_CCW:
>> +        virtio_ccw_setup(vdev);
>> +        break;
>> +    case S390_IPL_TYPE_PCI:
>> +        virtio_pci_setup(vdev);
>> +        break;
>> +    default:
>> +        return -1;
>> +    }
>>   
>>       if (!(vdev->guest_features[0] & VIRTIO_NET_F_MAC_BIT)) {
>>           puts("virtio-net device does not support the MAC address feature");
>> @@ -115,22 +124,30 @@ int recv(int fd, void *buf, int maxlen, int flags)
>>       VRing *rxvq = &vdev->vrings[VQ_RX];
>>       int len, id;
>>       uint8_t *pkt;
>> +    uint16_t rx_used_idx, rx_avail_idx;
>> +    uint32_t rx_used_len, rx_used_id;
>> +    uint64_t rx_desc_addr;
>>   
>> -    if (rx_last_idx == rxvq->used->idx) {
>> +    rx_used_idx = virtio_tswap16(rxvq->used->idx);
>> +    if (rx_last_idx == rx_used_idx) {
>>           return 0;
>>       }
>>   
>> -    len = rxvq->used->ring[rx_last_idx % rxvq->num].len - virtio_net_hdr_size;
>> +    rx_used_len = virtio_tswap32(rxvq->used->ring[rx_last_idx % rxvq->num].len);
>> +    rx_used_id = virtio_tswap32(rxvq->used->ring[rx_last_idx % rxvq->num].id);
>> +
>> +    len = rx_used_len - virtio_net_hdr_size;
>>       if (len > maxlen) {
>>           puts("virtio-net: Receive buffer too small");
>>           len = maxlen;
>>       }
>> -    id = rxvq->used->ring[rx_last_idx % rxvq->num].id % rxvq->num;
>> -    pkt = (uint8_t *)(rxvq->desc[id].addr + virtio_net_hdr_size);
>> +    id = rx_used_id % rxvq->num;
>> +    rx_desc_addr = virtio_tswap64(rxvq->desc[id].addr);
>> +    pkt = (uint8_t *)(rx_desc_addr + virtio_net_hdr_size);
>>   
>>   #if DEBUG_VIRTIO_NET   /* Dump packet */
>>       int i;
>> -    printf("\nbuf %p: len=%i\n", (void *)rxvq->desc[id].addr, len);
>> +    printf("\nbuf %p: len=%i\n", (void *)rx_desc_addr, len);
>>       for (i = 0; i < 64; i++) {
>>           printf(" %02x", pkt[i]);
>>           if ((i % 16) == 15) {
>> @@ -144,8 +161,10 @@ int recv(int fd, void *buf, int maxlen, int flags)
>>       memcpy(buf, pkt, len);
>>   
>>       /* Mark buffer as available to the host again */
>> -    rxvq->avail->ring[rxvq->avail->idx % rxvq->num] = id;
>> -    rxvq->avail->idx = rxvq->avail->idx + 1;
>> +    rx_avail_idx = virtio_tswap16(rxvq->avail->idx);
>> +    rxvq->avail->ring[rx_avail_idx % rxvq->num] = virtio_tswap16(id);
>> +    rx_avail_idx++;
>> +    rxvq->avail->idx = virtio_tswap16(rx_avail_idx);
>>       vring_notify(rxvq);
>>   
>>       /* Move index to next entry */
>> @@ -164,6 +183,8 @@ bool virtio_net_setup(void)
>>       switch (virtio_get_device()->ipl_type) {
>>       case S390_IPL_TYPE_CCW:
>>           return virtio_ccw_net_setup();
>> +    case S390_IPL_TYPE_PCI:
>> +        return virtio_pci_net_setup();
>>       default:
>>           return false;
>>       }
>> diff --git a/pc-bios/s390-ccw/virtio-pci.c b/pc-bios/s390-ccw/virtio-pci.c
>> index f501252c81..c7d62766b8 100644
>> --- a/pc-bios/s390-ccw/virtio-pci.c
>> +++ b/pc-bios/s390-ccw/virtio-pci.c
>> @@ -52,6 +52,10 @@ void virtio_pci_id2type(VDev *vdev, uint16_t device_id)
>>       case 0x1001:
>>           vdev->dev_type = VIRTIO_ID_BLOCK;
>>           break;
>> +    case 0x1041:
>> +    case 0x1000:
>> +        vdev->dev_type = VIRTIO_ID_NET;
>> +        break;
>>       default:
>>           vdev->dev_type = 0;
>>       }
>> @@ -199,6 +203,14 @@ static int virtio_pci_get_blk_config(void)
>>       return rc;
>>   }
>>   
>> +static int virtio_pci_get_net_config(void)
>> +{
>> +    VirtioNetConfig *cfg = &virtio_get_device()->config.net;
>> +    int rc = vpci_read_flex(d_cap.off, d_cap.bar, cfg, sizeof(VirtioNetConfig));
>> +
>> +    return rc;
>> +}
>> +
>>   static int virtio_pci_negotiate(void)
>>   {
>>       int i, rc;
>> @@ -330,6 +342,7 @@ bool virtio_pci_is_supported(VDev *vdev)
>>       if (vdev->vendor_id == PCI_VENDOR_VIRTIO) {
>>           switch (vdev->dev_type) {
>>           case VIRTIO_ID_BLOCK:
>> +        case VIRTIO_ID_NET:
>>               return true;
>>           default:
>>               return false;
>> @@ -384,6 +397,11 @@ int virtio_pci_setup(VDev *vdev)
>>           vdev->cmd_vr_idx = 0;
>>           virtio_pci_get_blk_config();
>>           break;
>> +    case VIRTIO_ID_NET:
>> +        vdev->nr_vqs = 2;
>> +        vdev->cmd_vr_idx = 0;
>> +        virtio_pci_get_net_config();
>> +        break;
>>       default:
>>           puts("Unsupported virtio device");
>>           return -ENODEV;
>> @@ -458,3 +476,28 @@ int virtio_pci_setup_device(void)
>>   
>>       return 0;
>>   }
>> +
>> +static bool find_pci_net_dev(void)
>> +{
>> +    if (!virtio_is_supported(virtio_get_device())) {
>> +        return false;
>> +    }
>> +
>> +    if (virtio_get_device_type() != VIRTIO_ID_NET) {
>> +        return false;
>> +    }
>> +
>> +    return true;
>> +}
>> +
>> +bool virtio_pci_net_setup(void)
>> +{
>> +    bool found = false;
>> +
>> +    if (have_iplb || store_iplb(&iplb)) {
>> +        IPL_assert(iplb.pbt == S390_IPL_TYPE_PCI, "IPL_TYPE_PCI expected");
>> +        found = find_pci_net_dev();
>> +    }
>> +
>> +    return found;
>> +}
> 
> As far as I can tell the net specific setup/find are not needed for PCI
> devices.  By the time we reach the the call to virtio_pci_net_setup() we
> know vdev->ipl_type == S390_IPL_TYPE_PCI because that is the prerequisite
> to call the function in the first place, and vdev->ipl_type was previously
> set based on the PBT.  We also already know that our device type is
> VIRTIO_ID_NET because otherwise the call to virtio_setup() in main.c
> would have fallen through to the default case and failed and/or netmain()
> would not be called from bootmap.c.
> 
> Although we haven't checked virtio_is_supported() yet, we will do that
> verification in virtio_net_init(), which is the very next step.
> 
> For PCI devices, everything checked from virtio_net_setup() appears to be
> guaranteed by the call chain or validated by subsequent net code. Maybe
> virtio_net_setup() only needs to be called for CCW devices?
> 

I was trying to align the CCW setup flow with the PCI devices, but I
agree that it isn't really necessary.

If virtio_net_setup() only needs to be called for CCW devices, is the
generic virtio_net_setup() wrapper still needed? Something like the
following seems sufficient:

if (virtio_get_device()->ipl_type == S390_IPL_TYPE_CCW &&
    !virtio_ccw_net_setup()) {
    puts("No valid virtio ccw net device found.");
}

Alternatively, we could simply add return true for the S390_IPL_TYPE_PCI
case in virtio_net_setup().

One thing worth noting is that virtio_net_init() calls virtio_*_setup(),
which performs virtio_is_supported() as its first step. However, the
return value of virtio_*_setup() is currently ignored in
virtio_net_init(). This is pre-existing behavior and applies to both the
CCW and PCI paths. If setup fails, execution still proceeds to MAC
negotiation and buffer allocation.

Since we are removing the network-specific setup from the PCI path,
would it make sense to also fix virtio_net_init() to check and propagate
the return value of virtio_*_setup()? The error is already reported by
virtio_*_setup(), but execution currently continues into MAC negotiation
and buffer allocation even when device initialization has failed.

> Regards,
> Jared Rossi
>> diff --git a/pc-bios/s390-ccw/virtio-pci.h b/pc-bios/s390-ccw/virtio-pci.h
>> index 33b683bd92..2c3136fd05 100644
>> --- a/pc-bios/s390-ccw/virtio-pci.h
>> +++ b/pc-bios/s390-ccw/virtio-pci.h
>> @@ -70,6 +70,8 @@ long virtio_pci_notify(VRing *vr);
>>   bool virtio_pci_is_supported(VDev *vdev);
>>   int virtio_pci_setup(VDev *vdev);
>>   int virtio_pci_setup_device(void);
>> +bool virtio_pci_is_supported(VDev *vdev);
>> +bool virtio_pci_net_setup(void);
>>   
>>   int vpci_read_flex(uint64_t offset, uint8_t pcias, void *buf, int len);
>>   int vpci_read_bswap64(uint64_t offset, uint8_t pcias, uint64_t *buf);
> 



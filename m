Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 763C6CD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 16:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMprc-0004Mp-4e; Tue, 12 May 2026 12:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wMpra-0004MJ-Ip; Tue, 12 May 2026 12:21:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wMprY-0001CG-Cw; Tue, 12 May 2026 12:21:42 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CCD1fm2611862; Tue, 12 May 2026 16:21:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=nNnrv4
 cKeFdLY5+Kdm3ymwkSp5FCLijaTeIRzw/QcFY=; b=CkifxV2+JwC7gbrYS0MXI4
 1QQ4DhUVM9mHnBNx+UoFW0JQaxy+JnUvjBqMD/PUmqAGkeT0wh2DqqBEhzz/6ALO
 LOUxgnOKreLUHqWGFciKhSFA6VqdU/Qto94jNRDdcz3o0t/0BG7jRaPiSwDL3alF
 hHHh+WjUZ+ktXaRYSyKXu1ae2KB9cCZUH9GO9IUSYTlQfAbuA2rhZV3M4zC6OR8X
 01iYN2vXNSoKOPVrRjKWHTw14/sBn+AXJXqejZ4bqpyIAE7pf8cXv70HI7Kl531d
 2aYdpg34AfRqrVKKrxS/+ChN4ifSZjHW99CRZUFFHOr85jC+hbur9SIDK9egXRMQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nvduyp7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 May 2026 16:21:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64CG9QU2022251;
 Tue, 12 May 2026 16:21:37 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgkvd1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 May 2026 16:21:37 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64CGLZbH29688566
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 May 2026 16:21:35 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C97658065;
 Tue, 12 May 2026 16:21:35 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C8EC85804B;
 Tue, 12 May 2026 16:21:34 +0000 (GMT)
Received: from [9.61.119.68] (unknown [9.61.119.68])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 12 May 2026 16:21:34 +0000 (GMT)
Message-ID: <68913812-4bdd-414d-b255-f24431fbaf12@linux.ibm.com>
Date: Tue, 12 May 2026 12:21:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] pc-bios/s390-ccw: Add per-queue notification offset
 for multi-queue virtio configurations
To: Eric Farman <farman@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, cohuck@redhat.com
Cc: jjherne@linux.ibm.com, mjrosato@linux.ibm.com, zycai@linux.ibm.com
References: <20260504221613.826825-1-jrossi@linux.ibm.com>
 <20260504221613.826825-3-jrossi@linux.ibm.com>
 <0f872fd5ae16db2dac3239f9b1820f4d3f2127db.camel@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <0f872fd5ae16db2dac3239f9b1820f4d3f2127db.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Y/XIdBeN c=1 sm=1 tr=0 ts=6a035392 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=ISLiNHwi8i67TzYMgxoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 8K63vzBinMuzdFtgLIQ7PIvJY9mnPhjW
X-Proofpoint-ORIG-GUID: 8K63vzBinMuzdFtgLIQ7PIvJY9mnPhjW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE2OCBTYWx0ZWRfX8wZhhAlTvWON
 IlMYtOeXq4YeNHzS3WEXzOcaRHDIq44E3Hl2pueALNFPaAzdVy9Z9yMh/Oaf3vWuFkg0sCzwiYu
 mIOhrhiI8vACILSGRGkaSFF7E9zvTYS0FYbaALYkoIkcJrfnTJz8Ov9S3lyx1EUX4foqt+oY4Ah
 QblQrljX0iJO+oSERtvnmoU8HGmAkU3pe3F13XV/ltY0MgNuA0IIRkH/PEE6ALUgz1/0MfhSqT/
 MhQ3ABLSBmN8J4vxVGnUgAPr1zufsLSWZsX1zfHIQzitaQCSkzGUqp3a4rQ0cq3uhb77S3vbc7F
 K7c+4QXAjK/oAMnzQNUwKCm7R69nxN5iLWorr20C7CIY/Ms46iHf8j879ww4xrQ4+q5s362jtpI
 fNkVrXwyWU2poBCD92xsUVJyHK4v9KchvRM/MM529vh5jnzX2xK3v874g0tqOobLdZuF5yJZJkY
 WSbtWQxqXl9rmIwwIWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120168
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



On 5/8/26 1:23 PM, Eric Farman wrote:
> On Mon, 2026-05-04 at 18:16 -0400, jrossi@linux.ibm.com wrote:
>> From: Jared Rossi <jrossi@linux.ibm.com>
>>
>> The initial support for virtio-blk-pci IPL devices used a single virt-queue, but
>> other device types require multiple queues, and for PCI device types this also
>> requires a per-queue notification offset.
>>
>> Add a PCI notify field to the VRing struct so that each queue has a unique
>> notify offset.  Also re-select the target queue before writing buffers to
>> ensure the proper queue is active.
> Why is this patch 2/5, when the series is n/6?
The short answer is I goofed it up.  The contents of the patch are as 
intended.
It should be 2/6.

>
>> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
>> ---
>>   pc-bios/s390-ccw/virtio-pci.c | 36 ++++++++++++++++++++++-------------
>>   pc-bios/s390-ccw/virtio-pci.h |  3 ++-
>>   pc-bios/s390-ccw/virtio.c     |  4 +++-
>>   pc-bios/s390-ccw/virtio.h     |  1 +
>>   4 files changed, 29 insertions(+), 15 deletions(-)
>>
>> diff --git a/pc-bios/s390-ccw/virtio-pci.c b/pc-bios/s390-ccw/virtio-pci.c
>> index 53bdb52e76..736869f4f5 100644
>> --- a/pc-bios/s390-ccw/virtio-pci.c
>> +++ b/pc-bios/s390-ccw/virtio-pci.c
>> @@ -74,10 +74,10 @@ int virtio_pci_reset(VDev *vdev)
>>       return 0;
>>   }
>>   
>> -long virtio_pci_notify(int vq_id)
>> +long virtio_pci_notify(VRing *vr)
>>   {
>> -    uint32_t offset = n_cap.off + notify_mult * q_notify_offset;
>> -    return vpci_bswap16_write(offset, n_cap.bar, (uint16_t) vq_id);
>> +    uint32_t offset = n_cap.off + notify_mult * vr->pci_notify;
>> +    return vpci_bswap16_write(offset, n_cap.bar, (uint16_t) vr->id);
> You no longer need the q_notify_offset variable nor the read into it.
> (Ah, Joy already pointed this out; nice!)
>
>>   }
>>   
>>   /*
>> @@ -166,7 +166,7 @@ int vpci_read_flex(uint64_t offset, uint8_t pcias, void *buf, int len)
>>       return 0;
>>   }
>>   
>> -static int vpci_set_selected_vq(uint16_t queue_num)
>> +int vpci_set_selected_vq(uint16_t queue_num)
>>   {
>>       return vpci_bswap16_write(c_cap.off + VPCI_C_OFFSET_Q_SELECT, c_cap.bar, queue_num);
>>   }
>> @@ -332,7 +332,6 @@ int virtio_pci_setup(VDev *vdev)
>>       VRing *vr;
>>       int rc;
>>       uint8_t status;
>> -    uint16_t vq_size;
>>       int i = 0;
>>   
>>       vdev->guessed_disk_nature = VIRTIO_GDN_NONE;
>> @@ -380,28 +379,39 @@ int virtio_pci_setup(VDev *vdev)
>>           return -EIO;
>>       }
>>   
>> -    if (vpci_read_bswap16(VPCI_C_OFFSET_Q_SIZE, c_cap.bar, &vq_size)) {
>> -        puts("Failed to read virt-queue configuration");
>> -        return -EIO;
>> -    }
>> -
>>       /* Configure virt-queues for pci */
>>       for (i = 0; i < vdev->nr_vqs; i++) {
>> +        uint16_t vq_size;
>> +        uint16_t vq_notify;
>>           VqInfo info = {
>>               .queue = (unsigned long long) virtio_get_ring_area(i),
>>               .align = KVM_S390_VIRTIO_RING_ALIGN,
>>               .index = i,
>> -            .num = vq_size,
>> +            .num = 0,
>>           };
>>   
>>           vr = &vdev->vrings[i];
>> -        vring_init(vr, &info);
>>   
>> -        if (vpci_set_selected_vq(vr->id)) {
>> +        if (vpci_set_selected_vq(i)) {
>>               puts("Failed to set selected virt-queue");
>>               return -EIO;
>>           }
>>   
>> +        if (vpci_read_bswap16(VPCI_C_OFFSET_Q_SIZE, c_cap.bar, &vq_size)) {
>> +            puts("Failed to read virt-queue configuration");
>> +            return -EIO;
>> +        }
>> +
>> +        info.num = vq_size;
>> +
>> +        if (vpci_read_bswap16(c_cap.off + VPCI_C_OFFSET_Q_NOFF, c_cap.bar, &vq_notify)) {
>> +            puts("Failed to read virt-queue configuration");
>> +            return -EIO;
>> +        }
> For either of these error exits, do you need an identifier logged as to -which- virtqueue failed, as
> you're in a loop?
Yes, that would certainly be useful information to have.  I'll add it.

>
>> +
>> +        vr->pci_notify = vq_notify;
>> +        vring_init(vr, &info);
>> +
>>           rc = set_pci_vq_addr(VPCI_C_OFFSET_Q_DESCLO, vr->desc);
>>           rc |= set_pci_vq_addr(VPCI_C_OFFSET_Q_AVAILLO, vr->avail);
>>           rc |= set_pci_vq_addr(VPCI_C_OFFSET_Q_USEDLO, vr->used);
>> diff --git a/pc-bios/s390-ccw/virtio-pci.h b/pc-bios/s390-ccw/virtio-pci.h
>> index 90d07cb9a7..993fc285ac 100644
>> --- a/pc-bios/s390-ccw/virtio-pci.h
>> +++ b/pc-bios/s390-ccw/virtio-pci.h
>> @@ -62,9 +62,10 @@ struct VirtioPciCap {
>>   };
>>   typedef struct VirtioPciCap  VirtioPciCap;
>>   
>> +int vpci_set_selected_vq(uint16_t queue_num);
>>   void virtio_pci_id2type(VDev *vdev, uint16_t device_id);
>>   int virtio_pci_reset(VDev *vdev);
>> -long virtio_pci_notify(int vq_id);
>> +long virtio_pci_notify(VRing *vr);
>>   int virtio_pci_setup(VDev *vdev);
>>   int virtio_pci_setup_device(void);
>>   
>> diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
>> index 30e6b2bc16..00850acc2f 100644
>> --- a/pc-bios/s390-ccw/virtio.c
>> +++ b/pc-bios/s390-ccw/virtio.c
>> @@ -114,7 +114,8 @@ bool vring_notify(VRing *vr)
>>           vr->cookie = virtio_ccw_notify(vdev.schid, vr->id, vr->cookie);
>>           break;
>>       case S390_IPL_TYPE_PCI:
>> -        vr->cookie = virtio_pci_notify(vr->id);
>> +        vr->cookie = virtio_pci_notify(vr);
>> +        break;
>>       default:
>>           return 1;
>>       }
>> @@ -154,6 +155,7 @@ static void vr_bswap_descriptor(VRingDesc *desc)
>>   void vring_send_buf(VRing *vr, void *p, int len, int flags)
>>   {
>>       if (!be_ipl()) {
>> +        vpci_set_selected_vq(vr->id);
>>           vr->avail->idx = bswap16(vr->avail->idx);
>>       }
>>   
>> diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
>> index d32a4830ca..75ae5bdbc2 100644
>> --- a/pc-bios/s390-ccw/virtio.h
>> +++ b/pc-bios/s390-ccw/virtio.h
>> @@ -107,6 +107,7 @@ struct VRing {
>>       VRingUsed *used;
>>       long cookie;
>>       int id;
>> +    uint16_t pci_notify;
>>   };
>>   typedef struct VRing VRing;
>>   
Thank you for the review comments.

Regards,
Jared Rossi


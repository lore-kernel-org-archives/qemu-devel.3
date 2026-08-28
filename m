Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D50BC61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 19:15:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x021w-0002pc-QG; Fri, 28 Aug 2026 15:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1x021t-0002oN-QN; Fri, 28 Aug 2026 15:14:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1x021r-000830-T4; Fri, 28 Aug 2026 15:14:21 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SGVYuL2491404; Fri, 28 Aug 2026 19:14:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=dTPjsW
 y4FWoTlDK5k3kteYBRRrqtdMVymjOcb5+dhSc=; b=p91NqFtbAUoPX8mZcJeriH
 38nVsHSaI/xAdrHtlzWSqodGk/jQaU1uuO4K1GP1UDCHsjmXwOgbIyQRZ4IUOOwb
 D0/fdRUB/kjVTqc4voH3fJZe9br8X9Vw8gCDtFt3WfUErfcJBdmI/At3nztkzy46
 84klWcWyZY6p7y84SfOA231/3AZu0dKEvGRFuoEaVAvPUjql36SAyzd0/zW6xXEn
 XFg4aJLXqcJWtVbEfUzcyanFn51ueSqsMfTL9ESWoDO9n7swjIda7+uywO30bj7X
 ULrOFElewSggJF1F7hk7b+I/mWgSoCr/BIHzskwJrJkQB4wYdu5ifg9/xtkxvqHg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716jeprc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Aug 2026 19:14:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67SJBmaC010472;
 Fri, 28 Aug 2026 19:14:13 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsyr242-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Aug 2026 19:14:13 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67SJDVxW26870518
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Aug 2026 19:13:31 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BB86B58052;
 Fri, 28 Aug 2026 19:14:11 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B71458045;
 Fri, 28 Aug 2026 19:14:10 +0000 (GMT)
Received: from [9.61.147.148] (unknown [9.61.147.148])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 28 Aug 2026 19:14:10 +0000 (GMT)
Message-ID: <ae9d1e9b-930d-4520-bec8-7cc386e6b010@linux.ibm.com>
Date: Fri, 28 Aug 2026 12:51:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/7] pc-bios/s390-ccw: Add support for virtio-net-pci
 IPL
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, borntraeger@linux.ibm.com,
 cohuck@redhat.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 pasic@linux.ibm.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com
References: <20260818205324.580199-1-zycai@linux.ibm.com>
 <20260818205324.580199-5-zycai@linux.ibm.com>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <20260818205324.580199-5-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDE2NiBTYWx0ZWRfX763wEquoFFfv
 dt07d6NDWk3HM4qLjxdkWHUnzp8ZHWxnsgBksuGBQNQGRF3YgiFZlurxYVm7L4unIUJjBEdZ1gB
 J5jYFKnqF9DnZVcGbFcQmOvgpQzvUSE=
X-Proofpoint-GUID: _3yLoQcQlhMxUzMUnRrNMzeSbxvKK6sg
X-Proofpoint-ORIG-GUID: _3yLoQcQlhMxUzMUnRrNMzeSbxvKK6sg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDE2NiBTYWx0ZWRfX5/qk0oZJYVyA
 G+FexxAYRF3Nlr3oV1JBmUUKbvRn2HNjKJz0UD71n+3ItMSTUp533WzwXDYKsNBC1tDR9u35K7I
 rdcPx3jZQX4q8r6gWJpZPqb6qROum+zOjELc4/JqF6/OuTBO8ef7VgJeX54dOqIE0Q93gL3jAmw
 RmyjVaISGr2d/TDSwcM7Fl+XQ5XXOuxHK4vXk3Ftg8KdwhHnMHzzebagREy+hPM7bWjSCHB43+9
 fz1ygUx6VL+5l31tojWkQOc0sIr278IRKox3BbDfxgJLhO90bF0ccRbB9dId+lq9WQeRiUv6O9/
 Xbee0+VwNUsFHJ2nWdXieYBycc1ov7JgRnXNJlHBPpW9y+0iRh9l8lo9XajGsEklRc/9dBnLbhW
 TSUB8QTwSJktN8hNeK92zd6d0HnHVeJ7Tck1r9HbO7EbewzQdjnYBAdnfl5pVeQP0lKqomWxS2m
 ZRlfDhr6rXD6gCvvXJw==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a91de06 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=ZiRjkEM2syFzdTjOdZwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280166
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jjherne@linux.ibm.com;
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


On 8/18/26 4:53 PM, Zhuoying Cai wrote:
> Enable network booting via virtio-net-pci by implementing PCI transport
> support for virtio-net.
> 
> This patch also adds endianness handling for virtio PCI ring operations in
> little-endian to ensure correct behavior on s390x.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/main.c       |  1 +
>   pc-bios/s390-ccw/virtio-net.c | 37 +++++++++++++++++++++++-------
>   pc-bios/s390-ccw/virtio-pci.c | 43 +++++++++++++++++++++++++++++++++++
>   pc-bios/s390-ccw/virtio-pci.h |  2 ++
>   4 files changed, 75 insertions(+), 8 deletions(-)
> ...
> +static bool find_pci_net_dev(void)
> +{
> +    if (!virtio_is_supported(virtio_get_device())) {
> +        return false;
> +    }
> +
> +    if (virtio_get_device_type() != VIRTIO_ID_NET) {
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +bool virtio_pci_net_setup(void)
> +{
> +    bool found = false;
> +
> +    if (have_iplb || store_iplb(&iplb)) {
> +        IPL_assert(iplb.pbt == S390_IPL_TYPE_PCI, "IPL_TYPE_PCI expected");
> +        found = find_pci_net_dev();

Just return find_pci_net_dev() here, and false below.
That eliminates the found variable entirely.

> +    }
> +
> +    return found;
> +}
> diff --git a/pc-bios/s390-ccw/virtio-pci.h b/pc-bios/s390-ccw/virtio-pci.h
> index 33b683bd92..2c3136fd05 100644
> --- a/pc-bios/s390-ccw/virtio-pci.h
> +++ b/pc-bios/s390-ccw/virtio-pci.h
> @@ -70,6 +70,8 @@ long virtio_pci_notify(VRing *vr);
>   bool virtio_pci_is_supported(VDev *vdev);
>   int virtio_pci_setup(VDev *vdev);
>   int virtio_pci_setup_device(void);
> +bool virtio_pci_is_supported(VDev *vdev);

Accidental copy and paste here? You added
virtio_pci_is_supported() but it exists above :)

> +bool virtio_pci_net_setup(void);
>   
>   int vpci_read_flex(uint64_t offset, uint8_t pcias, void *buf, int len);
>   int vpci_read_bswap64(uint64_t offset, uint8_t pcias, uint64_t *buf);

With both of those fixed:
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>




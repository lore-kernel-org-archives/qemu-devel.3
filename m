Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD96C9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 20:13:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9poJ-00025V-07; Thu, 24 Sep 2026 16:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x9poC-00024o-1e; Thu, 24 Sep 2026 16:12:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x9po4-0001ow-2f; Thu, 24 Sep 2026 16:12:37 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OJ5dnj1202049; Thu, 24 Sep 2026 20:12:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=4z383j
 QC/utsnjpsPFFKUKEqjJNnc9eZnFF43gfgSHE=; b=kvPeEFgUK/ADs8IDHHmxXw
 +umuMt9ct9dZqU+GvKoAvmBA7Ji4nkAetzzky3fQpAgzuafwFxC1gKMpi2oqOdR4
 Z1r0yHy/s9088aLcq/0TmZonxp0hfizGOKFC+q26p4CSU8ihrBIg1WAONrng10va
 PeUd56Bo2ZsFukAuHWVrqPX2dym0lFjiBPLoFHMIMnVqBEosEtwmBDI18aEp5mTi
 M0xexaPDWkD4KBrQp8JWd1uYySaKffsFM32t2vEY/MuQENAFLKfbMCGVTaeBhIua
 k/Ly9J8mgeDQSJkoOdlwbcIcUqxbQHjux61LhJlRnK6RyeZushlP53qQRNdzKAsg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske23dey-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 20:12:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OIldZc2516062; Thu, 24 Sep 2026 20:12:32 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbu8yf6a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 20:12:32 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68OKCVgF2950136
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 20:12:31 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 26BFC5804E;
 Thu, 24 Sep 2026 20:12:31 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C3E735803F;
 Thu, 24 Sep 2026 20:12:29 +0000 (GMT)
Received: from [9.61.7.131] (unknown [9.61.7.131])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 20:12:29 +0000 (GMT)
Message-ID: <19fa931f-5672-4595-b7ec-98c60db94260@linux.ibm.com>
Date: Thu, 24 Sep 2026 16:12:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/8] pc-bios/s390-ccw: Add support for virtio-net-pci
 IPL
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, borntraeger@linux.ibm.com,
 jjherne@linux.ibm.com, cohuck@redhat.com, farman@linux.ibm.com,
 pasic@linux.ibm.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com, jdaley@linux.ibm.com
References: <20260924194837.80732-1-zycai@linux.ibm.com>
 <20260924194837.80732-5-zycai@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260924194837.80732-5-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cx1MCwICWT4gG1iX203Q3_Wp9vn9vK4F
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab58431 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=e6rIRjyp0VqVuHTMicQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA4MiBTYWx0ZWRfX4mEXvDK0xCJq
 977AHiSkj7i6a423UHFX6l9r7sz/2O0c+kcgHUmVx02DC1NHCEs9kItbuElMlOr3D98Jtq1Ffwp
 9FGZhk42GfDcsDwJs3H0DCnisnFXLdE=
X-Proofpoint-GUID: cx1MCwICWT4gG1iX203Q3_Wp9vn9vK4F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA4MiBTYWx0ZWRfXxJEFO7VVjYoQ
 ZqnTO9hZm9KT7+X8pC1MIySsXs7OqtDdQe75+7mKUhJ6GbyqDjKYwEChIpco0Npk4eYe/W3PM0r
 +flXZ1sWABQY4xIpb3SqeFtmqER35yHXAVSKuDuHhmaEzQjhyXl1vpP9eNKhc+EvCOYa+5gyVmd
 W5iWmwfeQKAdxFzsJ7TdedCHCJQregutg6ENdPiHs/3UCO+/HGeECJva+LKQJayQjZ3UuPkSh0x
 S1DDskLKiT761HcIfrFyK0xSBv0IyovAXiOU7FJgveCEcwrVSFyG0mikHJcT3891VWxI1IyAmjo
 CQ6xAS5f/6OFMooz6FZ2+5yAtb/9+nCxhGhKduGEWte0N1VfrVtUlaK9EIyIICBg7R+NlPyAh0F
 0p22H71j9ZPNCJ/sgeCrcIqTuyeQlUpElV2sBaI9Ch9l5jqfuSEfkgQuNOcbiJFDd0A79fJlTKE
 zD6dNbBeyixWiuMQWJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240082
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 9/24/26 3:48 PM, Zhuoying Cai wrote:
> Enable network booting via virtio-net-pci by implementing PCI transport
> support for virtio-net.
> 
> This patch also extends endianness handling for virtio PCI ring operations in
> little-endian to ensure correct behavior on s390x.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

Looks like rebase errors with this patch, see below...


>      /* Move index to next entry */
> diff --git a/pc-bios/s390-ccw/virtio-pci.c b/pc-bios/s390-ccw/virtio-pci.c
> index 277c3ea68d..7fb987099d 100644
> --- a/pc-bios/s390-ccw/virtio-pci.c
> +++ b/pc-bios/s390-ccw/virtio-pci.c
> @@ -55,6 +55,9 @@ void virtio_pci_id2type(VDev *vdev, uint16_t device_id)
>      case 0x1048:
>      case 0x1004:
>          vdev->dev_type = VIRTIO_ID_SCSI;

missing break?

> +    case 0x1041:
> +    case 0x1000:
> +        vdev->dev_type = VIRTIO_ID_NET;
>          break;

[...]


> @@ -413,6 +428,9 @@ int virtio_pci_setup(VDev *vdev)
>          vdev->nr_vqs = 3;
>          vdev->cmd_vr_idx = 2;
>          virtio_pci_get_scsi_config();

missing break?

> +    case VIRTIO_ID_NET:
> +        vdev->nr_vqs = 2;
> +        virtio_pci_get_net_config();
>          break;
>      default:
>          puts("Unsupported virtio device");



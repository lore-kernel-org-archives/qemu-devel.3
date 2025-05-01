Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E71C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 11:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uASUS-0004Xu-6a; Thu, 01 May 2025 07:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1uASUE-0004Tt-Hx; Thu, 01 May 2025 07:53:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1uASUC-0002c5-BT; Thu, 01 May 2025 07:53:54 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541BpjBA028655;
 Thu, 1 May 2025 11:53:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=vGyAFf
 Df7Wtd3dqooOnHKEYt/A+i6QjO3aR5QcLl0WM=; b=QR37ck6u/Jc93JgJ5Jiy8a
 hyga9UalvFKB747xTdM+EYzc2YEkdWfmC5DXfgL/I2N4myTYZoCVJDRXXtpGi9CK
 dBP9912/8pShsR1xFJJWT/8iW+bT/elqdsZLQvESTPSuzPGIRHEjTs91X25pcMc4
 nzDtfVPAMgP+fE0CQbH18Y/bDiUNtzQkuCrExvR4EXuufziBgnMKm9XjjqOSwoBV
 5Izi1cklJA3iyA1s5hJDfKwUjaJV/bwP4d/ducISrUiLun1ojgJ8yN/jOkiDtfaW
 oUHEoCDFRQ5Q2gdp5X8ZV8THMmY5GJvDIYLhFMF+EEvDkXFOXH0uEUIcw50uFZYg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46buy92mj3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 May 2025 11:53:47 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 541BpQSe027762;
 Thu, 1 May 2025 11:53:46 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46buy92mj0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 May 2025 11:53:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 541A0u7r000666;
 Thu, 1 May 2025 11:53:45 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469atpmkbr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 May 2025 11:53:45 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 541BrhPP24117932
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 May 2025 11:53:44 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA3AD5805D;
 Thu,  1 May 2025 11:53:43 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7802258059;
 Thu,  1 May 2025 11:53:42 +0000 (GMT)
Received: from [9.61.93.5] (unknown [9.61.93.5])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  1 May 2025 11:53:42 +0000 (GMT)
Message-ID: <7e94c3cf-1295-4b67-b59f-837f36011ff3@linux.ibm.com>
Date: Thu, 1 May 2025 07:53:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/15] vfio: add vfio_device_get_irq_info() helper
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Tomita Moeko <tomitamoeko@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>
References: <20250430194003.2793823-1-john.levon@nutanix.com>
 <20250430194003.2793823-5-john.levon@nutanix.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20250430194003.2793823-5-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDA4OCBTYWx0ZWRfXx5YKYYxJLfBW
 F7OpvXBrTJmFyQOgLp1KXjWMxmTqMDWF+O++NyDP3h8rZD3bHyNGGcBnpL9HyHiqMvw/FhXv/9N
 uMLf08cStMrb9uvA/62iLtQ+pAY1nF8KEfNNrd9PGXn44J3wR4+2ONnrP4qpWMWbBc4Nf8bZbSx
 69eKkxRmGnfGK3SAtLMbTJato1zIvB85vHYeeJbxexZubzVjlCn80cblQumtkaBKG76z4QjjSAk
 DsyXFOKxawP3mTyWMobmWAmJBF/T7sUw+xlebio2iWD7Uvtu/ALlFbz8cWd6efHA4GnjixllG9B
 +pWecsQYSWrc9z07k3ny/mzYaWFMRsQc1omhPNKwpuhpLs6hI6N/mNDRp8x4SPgPxhsOVv0ZgZ1
 aQcJfac9NYdEIHKLzZKb1RMT5QtOTyS1J03J1zQAKU5Qu0kER8n793B1amdVCfHLSqr0LvTg
X-Authority-Analysis: v=2.4 cv=FOYbx/os c=1 sm=1 tr=0 ts=681360cb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=VTyYQ_qCy91EFB7ZLDkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -1jaRhsZ_CvSueWllBtwvDU-41YGNhio
X-Proofpoint-GUID: NJOHfx0IN43Xl358UmBipkRV6uDcmTpC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 clxscore=1011
 bulkscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505010088
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=akrowiak@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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




On 4/30/25 3:39 PM, John Levon wrote:
> Add a helper similar to vfio_device_get_region_info() and use it
> everywhere.
>
> Replace a couple of needless allocations with stack variables.
>
> As a side-effect, this fixes a minor error reporting issue in the call
> from vfio_msix_early_setup().
>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   hw/vfio/ap.c                  | 19 ++++++++++---------
>   hw/vfio/ccw.c                 | 20 +++++++++++---------
>   hw/vfio/device.c              | 15 +++++++++++++++
>   hw/vfio/pci.c                 | 23 +++++++++++------------
>   hw/vfio/platform.c            |  6 +++---
>   include/hw/vfio/vfio-device.h |  3 +++
>   6 files changed, 53 insertions(+), 33 deletions(-)
>
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 4f88f80c54..4f97260dac 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -139,10 +139,10 @@ static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
>                                             unsigned int irq, Error **errp)
>   {
>       int fd;
> -    size_t argsz;
> +    int ret;
>       IOHandler *fd_read;
>       EventNotifier *notifier;
> -    g_autofree struct vfio_irq_info *irq_info = NULL;
> +    struct vfio_irq_info irq_info;
>       VFIODevice *vdev = &vapdev->vdev;
>   
>       switch (irq) {
> @@ -165,14 +165,15 @@ static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
>           return false;
>       }
>   
> -    argsz = sizeof(*irq_info);
> -    irq_info = g_malloc0(argsz);
> -    irq_info->index = irq;
> -    irq_info->argsz = argsz;
> +    ret = vfio_device_get_irq_info(vdev, irq, &irq_info);
> +
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret, "vfio: Error getting irq info");
> +        return false;
> +    }
>   
> -    if (ioctl(vdev->fd, VFIO_DEVICE_GET_IRQ_INFO,
> -              irq_info) < 0 || irq_info->count < 1) {
> -        error_setg_errno(errp, errno, "vfio: Error getting irq info");
> +    if (irq_info.count < 1) {
> +        error_setg(errp, "vfio: Error getting irq info, count=0");
>           return false;
>       }

The changes above look good to me.

>   
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index fde0c3fbef..ab3fabf991 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -376,8 +376,8 @@ static bool vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
>                                              Error **errp)
>   {
>       VFIODevice *vdev = &vcdev->vdev;
> -    g_autofree struct vfio_irq_info *irq_info = NULL;
> -    size_t argsz;
> +    struct vfio_irq_info irq_info;
> +    int ret;
>       int fd;
>       EventNotifier *notifier;
>       IOHandler *fd_read;
> @@ -406,13 +406,15 @@ static bool vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
>           return false;
>       }
>   
> -    argsz = sizeof(*irq_info);
> -    irq_info = g_malloc0(argsz);
> -    irq_info->index = irq;
> -    irq_info->argsz = argsz;
> -    if (ioctl(vdev->fd, VFIO_DEVICE_GET_IRQ_INFO,
> -              irq_info) < 0 || irq_info->count < 1) {
> -        error_setg_errno(errp, errno, "vfio: Error getting irq info");
> +    ret = vfio_device_get_irq_info(vdev, irq, &irq_info);
> +
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret, "vfio: Error getting irq info");
> +        return false;
> +    }
> +
> +    if (irq_info.count < 1) {
> +        error_setg(errp, "vfio: Error getting irq info, count=0");
>           return false;
>       }
>   
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 9673b0717e..5d837092cb 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -185,6 +185,21 @@ bool vfio_device_irq_set_signaling(VFIODevice *vbasedev, int index, int subindex
>       return false;
>   }
>   
> +int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
> +                             struct vfio_irq_info *info)
> +{
> +    int ret;
> +
> +    memset(info, 0, sizeof(*info));
> +
> +    info->argsz = sizeof(*info);
> +    info->index = index;
> +
> +    ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_IRQ_INFO, info);
> +
> +    return ret < 0 ? -errno : ret;
> +}
> +
>   int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
>                                   struct vfio_region_info **info)
>   {
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 6908bcc0d3..407cf43387 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1555,8 +1555,7 @@ static bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
>       uint16_t ctrl;
>       uint32_t table, pba;
>       int ret, fd = vdev->vbasedev.fd;
> -    struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info),
> -                                      .index = VFIO_PCI_MSIX_IRQ_INDEX };
> +    struct vfio_irq_info irq_info;
>       VFIOMSIXInfo *msix;
>   
>       pos = pci_find_capability(&vdev->pdev, PCI_CAP_ID_MSIX);
> @@ -1593,7 +1592,8 @@ static bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
>       msix->pba_offset = pba & ~PCI_MSIX_FLAGS_BIRMASK;
>       msix->entries = (ctrl & PCI_MSIX_FLAGS_QSIZE) + 1;
>   
> -    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_info);
> +    ret = vfio_device_get_irq_info(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX,
> +                                   &irq_info);
>       if (ret < 0) {
>           error_setg_errno(errp, -ret, "failed to get MSI-X irq info");
>           g_free(msix);
> @@ -2736,7 +2736,7 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
>   {
>       VFIODevice *vbasedev = &vdev->vbasedev;
>       g_autofree struct vfio_region_info *reg_info = NULL;
> -    struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info) };
> +    struct vfio_irq_info irq_info;
>       int i, ret = -1;
>   
>       /* Sanity check device */
> @@ -2797,12 +2797,10 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
>           }
>       }
>   
> -    irq_info.index = VFIO_PCI_ERR_IRQ_INDEX;
> -
> -    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_info);
> +    ret = vfio_device_get_irq_info(vbasedev, VFIO_PCI_ERR_IRQ_INDEX, &irq_info);
>       if (ret) {
>           /* This can fail for an old kernel or legacy PCI dev */
> -        trace_vfio_populate_device_get_irq_info_failure(strerror(errno));
> +        trace_vfio_populate_device_get_irq_info_failure(strerror(-ret));
>       } else if (irq_info.count == 1) {
>           vdev->pci_aer = true;
>       } else {
> @@ -2911,17 +2909,18 @@ static void vfio_req_notifier_handler(void *opaque)
>   
>   static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
>   {
> -    struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info),
> -                                      .index = VFIO_PCI_REQ_IRQ_INDEX };
> +    struct vfio_irq_info irq_info;
>       Error *err = NULL;
>       int32_t fd;
> +    int ret;
>   
>       if (!(vdev->features & VFIO_FEATURE_ENABLE_REQ)) {
>           return;
>       }
>   
> -    if (ioctl(vdev->vbasedev.fd,
> -              VFIO_DEVICE_GET_IRQ_INFO, &irq_info) < 0 || irq_info.count < 1) {
> +    ret = vfio_device_get_irq_info(&vdev->vbasedev, VFIO_PCI_REQ_IRQ_INDEX,
> +                                   &irq_info);
> +    if (ret < 0 || irq_info.count < 1) {
>           return;
>       }
>   
> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> index ffb3681607..9a21f2e50a 100644
> --- a/hw/vfio/platform.c
> +++ b/hw/vfio/platform.c
> @@ -474,10 +474,10 @@ static bool vfio_populate_device(VFIODevice *vbasedev, Error **errp)
>       QSIMPLEQ_INIT(&vdev->pending_intp_queue);
>   
>       for (i = 0; i < vbasedev->num_irqs; i++) {
> -        struct vfio_irq_info irq = { .argsz = sizeof(irq) };
> +        struct vfio_irq_info irq;
> +
> +        ret = vfio_device_get_irq_info(vbasedev, i, &irq);
>   
> -        irq.index = i;
> -        ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_IRQ_INFO, &irq);
>           if (ret) {
>               error_setg_errno(errp, -ret, "failed to get device irq info");
>               goto irq_err;
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 666a0b50b4..5b833868c9 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -146,6 +146,9 @@ int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
>   int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
>                                        uint32_t subtype, struct vfio_region_info **info);
>   bool vfio_device_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type);
> +
> +int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
> +                                struct vfio_irq_info *info);
>   #endif
>   
>   /* Returns 0 on success, or a negative errno. */



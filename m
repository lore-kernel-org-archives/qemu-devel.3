Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC270C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 13:16:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAUmj-00034x-Mv; Fri, 24 May 2024 09:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1sAUmi-0002xm-6l; Fri, 24 May 2024 09:16:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1sAUmf-0005Ne-Va; Fri, 24 May 2024 09:16:35 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44OD3NGu024173; Fri, 24 May 2024 13:16:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=1Lz+27ikfRMypDF/R7GstV5InYWxYLUgNCCWS7HnUdo=;
 b=eU51bFVUHruB8DoZZ6QvEASQXueNNcqXSx9GIaP8uw2D5QuLPzXqFZI293ZI/ZvvWPUS
 b6oVg9CZbwtyfzmlEx+RcgH6BbZo4M1u9+PRwlSXs26D5L2DBaZe2ugE+8K3J2FTnq1T
 9kIsbw20VmhyBGI/ajJWpATZnf0ZbR4/TwGAPu1YYcnHmUXQ6Jrrc3B0jb4+5cbP1t36
 mnhKL9XxeoYnaCExD/Rq5Wbc+Mzr/e+vXm+UbLUCTavveP68xIO+rQ9QQ5oEHQZcY+jC
 7wsUO4ijIdpn4eH3WjX+5GcznRi2ixcRGALUcQpurt6nn4cPg6p7jAsiQWfyg5k7VHes cA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yauebg1eh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 May 2024 13:16:30 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44ODGTxM011556;
 Fri, 24 May 2024 13:16:30 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yauebg1ee-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 May 2024 13:16:29 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44OBid2m022119; Fri, 24 May 2024 13:16:29 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y76nu90ss-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 May 2024 13:16:29 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44ODGPvZ26542756
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 May 2024 13:16:27 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 61E8958059;
 Fri, 24 May 2024 13:16:25 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7D17F58058;
 Fri, 24 May 2024 13:16:24 +0000 (GMT)
Received: from [9.61.26.241] (unknown [9.61.26.241])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 May 2024 13:16:24 +0000 (GMT)
Message-ID: <966fb4b0-01b6-4bf1-9273-0c9a3bc2a831@linux.ibm.com>
Date: Fri, 24 May 2024 09:16:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Anthony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH 04/16] vfio/helpers: Make vfio_set_irq_signaling() return
 bool
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Thomas Huth <thuth@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 "open list:S390 general arch..." <qemu-s390x@nongnu.org>
References: <20240515082041.556571-1-zhenzhong.duan@intel.com>
 <20240515082041.556571-5-zhenzhong.duan@intel.com>
Content-Language: en-US
In-Reply-To: <20240515082041.556571-5-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EpitLJonOx0YZOjhatKMo0O0gNiYVW1P
X-Proofpoint-ORIG-GUID: cctCk0e9PxvXiLQcLDBL-ws_AOJ2FloM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-24_04,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405240091
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=akrowiak@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 5/15/24 4:20 AM, Zhenzhong Duan wrote:
> This is to follow the coding standand in qapi/error.h to return bool
> for bool-valued functions.
>
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/hw/vfio/vfio-common.h |  4 ++--
>   hw/vfio/ap.c                  |  8 +++----
>   hw/vfio/ccw.c                 |  8 +++----
>   hw/vfio/helpers.c             | 18 ++++++----------
>   hw/vfio/pci.c                 | 40 ++++++++++++++++++-----------------
>   hw/vfio/platform.c            | 18 +++++++---------
>   6 files changed, 46 insertions(+), 50 deletions(-)
>
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 2d8da32df4..fdce13f0f2 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -207,8 +207,8 @@ void vfio_spapr_container_deinit(VFIOContainer *container);
>   void vfio_disable_irqindex(VFIODevice *vbasedev, int index);
>   void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index);
>   void vfio_mask_single_irqindex(VFIODevice *vbasedev, int index);
> -int vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
> -                           int action, int fd, Error **errp);
> +bool vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
> +                            int action, int fd, Error **errp);
>   void vfio_region_write(void *opaque, hwaddr addr,
>                              uint64_t data, unsigned size);
>   uint64_t vfio_region_read(void *opaque,
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index ba653ef70f..d8a9615fee 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -117,8 +117,8 @@ static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
>       fd = event_notifier_get_fd(notifier);
>       qemu_set_fd_handler(fd, fd_read, NULL, vapdev);
>   
> -    if (vfio_set_irq_signaling(vdev, irq, 0, VFIO_IRQ_SET_ACTION_TRIGGER, fd,
> -                               errp)) {
> +    if (!vfio_set_irq_signaling(vdev, irq, 0, VFIO_IRQ_SET_ACTION_TRIGGER, fd,
> +                                errp)) {
>           qemu_set_fd_handler(fd, NULL, NULL, vapdev);
>           event_notifier_cleanup(notifier);
>       }
> @@ -141,8 +141,8 @@ static void vfio_ap_unregister_irq_notifier(VFIOAPDevice *vapdev,
>           return;
>       }
>   
> -    if (vfio_set_irq_signaling(&vapdev->vdev, irq, 0,
> -                               VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
> +    if (!vfio_set_irq_signaling(&vapdev->vdev, irq, 0,
> +                                VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
>           warn_reportf_err(err, VFIO_MSG_PREFIX, vapdev->vdev.name);
>       }
>   
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 89bb980167..1f578a3c75 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -434,8 +434,8 @@ static bool vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
>       fd = event_notifier_get_fd(notifier);
>       qemu_set_fd_handler(fd, fd_read, NULL, vcdev);
>   
> -    if (vfio_set_irq_signaling(vdev, irq, 0,
> -                               VFIO_IRQ_SET_ACTION_TRIGGER, fd, errp)) {
> +    if (!vfio_set_irq_signaling(vdev, irq, 0,
> +                                VFIO_IRQ_SET_ACTION_TRIGGER, fd, errp)) {
>           qemu_set_fd_handler(fd, NULL, NULL, vcdev);
>           event_notifier_cleanup(notifier);
>       }
> @@ -464,8 +464,8 @@ static void vfio_ccw_unregister_irq_notifier(VFIOCCWDevice *vcdev,
>           return;
>       }
>   
> -    if (vfio_set_irq_signaling(&vcdev->vdev, irq, 0,
> -                               VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
> +    if (!vfio_set_irq_signaling(&vcdev->vdev, irq, 0,
> +                                VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
>           warn_reportf_err(err, VFIO_MSG_PREFIX, vcdev->vdev.name);
>       }
>   
> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
> index 0bb7b40a6a..93e6fef6de 100644
> --- a/hw/vfio/helpers.c
> +++ b/hw/vfio/helpers.c
> @@ -107,12 +107,12 @@ static const char *index_to_str(VFIODevice *vbasedev, int index)
>       }
>   }
>   
> -int vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
> -                           int action, int fd, Error **errp)
> +bool vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
> +                            int action, int fd, Error **errp)
>   {
>       ERRP_GUARD();
>       g_autofree struct vfio_irq_set *irq_set = NULL;
> -    int argsz, ret = 0;
> +    int argsz;
>       const char *name;
>       int32_t *pfd;
>   
> @@ -127,15 +127,11 @@ int vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
>       pfd = (int32_t *)&irq_set->data;
>       *pfd = fd;
>   
> -    if (ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
> -        ret = -errno;
> +    if (!ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
> +        return true;


With this change, I don't see where the allocation of irq_set is is freed.

g_free(irq_set);

What am I missing?


>       }
>   
> -    if (!ret) {
> -        return 0;
> -    }
> -
> -    error_setg_errno(errp, -ret, "VFIO_DEVICE_SET_IRQS failure");
> +    error_setg_errno(errp, errno, "VFIO_DEVICE_SET_IRQS failure");
>   
>       name = index_to_str(vbasedev, index);
>       if (name) {
> @@ -146,7 +142,7 @@ int vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
>       error_prepend(errp,
>                     "Failed to %s %s eventfd signaling for interrupt ",
>                     fd < 0 ? "tear down" : "set up", action_to_str(action));
> -    return ret;
> +    return false;
>   }
>   
>   /*
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index a447013a1d..358da4497b 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -147,10 +147,10 @@ static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
>           goto fail_irqfd;
>       }
>   
> -    if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX, 0,
> -                               VFIO_IRQ_SET_ACTION_UNMASK,
> -                               event_notifier_get_fd(&vdev->intx.unmask),
> -                               errp)) {
> +    if (!vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX, 0,
> +                                VFIO_IRQ_SET_ACTION_UNMASK,
> +                                event_notifier_get_fd(&vdev->intx.unmask),
> +                                errp)) {
>           goto fail_vfio;
>       }
>   
> @@ -295,8 +295,8 @@ static int vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>       fd = event_notifier_get_fd(&vdev->intx.interrupt);
>       qemu_set_fd_handler(fd, vfio_intx_interrupt, NULL, vdev);
>   
> -    if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX, 0,
> -                               VFIO_IRQ_SET_ACTION_TRIGGER, fd, errp)) {
> +    if (!vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX, 0,
> +                                VFIO_IRQ_SET_ACTION_TRIGGER, fd, errp)) {
>           qemu_set_fd_handler(fd, NULL, NULL, vdev);
>           event_notifier_cleanup(&vdev->intx.interrupt);
>           return -errno;
> @@ -590,9 +590,10 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>                   fd = event_notifier_get_fd(&vector->interrupt);
>               }
>   
> -            if (vfio_set_irq_signaling(&vdev->vbasedev,
> -                                       VFIO_PCI_MSIX_IRQ_INDEX, nr,
> -                                       VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
> +            if (!vfio_set_irq_signaling(&vdev->vbasedev,
> +                                        VFIO_PCI_MSIX_IRQ_INDEX, nr,
> +                                        VFIO_IRQ_SET_ACTION_TRIGGER, fd,
> +                                        &err)) {
>                   error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>               }
>           }
> @@ -634,8 +635,9 @@ static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
>           int32_t fd = event_notifier_get_fd(&vector->interrupt);
>           Error *err = NULL;
>   
> -        if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX, nr,
> -                                   VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
> +        if (!vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX,
> +                                    nr, VFIO_IRQ_SET_ACTION_TRIGGER, fd,
> +                                    &err)) {
>               error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>           }
>       }
> @@ -2873,8 +2875,8 @@ static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
>       fd = event_notifier_get_fd(&vdev->err_notifier);
>       qemu_set_fd_handler(fd, vfio_err_notifier_handler, NULL, vdev);
>   
> -    if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_ERR_IRQ_INDEX, 0,
> -                               VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
> +    if (!vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_ERR_IRQ_INDEX, 0,
> +                                VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
>           error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>           qemu_set_fd_handler(fd, NULL, NULL, vdev);
>           event_notifier_cleanup(&vdev->err_notifier);
> @@ -2890,8 +2892,8 @@ static void vfio_unregister_err_notifier(VFIOPCIDevice *vdev)
>           return;
>       }
>   
> -    if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_ERR_IRQ_INDEX, 0,
> -                               VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
> +    if (!vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_ERR_IRQ_INDEX, 0,
> +                                VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
>           error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>       }
>       qemu_set_fd_handler(event_notifier_get_fd(&vdev->err_notifier),
> @@ -2938,8 +2940,8 @@ static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
>       fd = event_notifier_get_fd(&vdev->req_notifier);
>       qemu_set_fd_handler(fd, vfio_req_notifier_handler, NULL, vdev);
>   
> -    if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_REQ_IRQ_INDEX, 0,
> -                           VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
> +    if (!vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_REQ_IRQ_INDEX, 0,
> +                                VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
>           error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>           qemu_set_fd_handler(fd, NULL, NULL, vdev);
>           event_notifier_cleanup(&vdev->req_notifier);
> @@ -2956,8 +2958,8 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
>           return;
>       }
>   
> -    if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_REQ_IRQ_INDEX, 0,
> -                               VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
> +    if (!vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_REQ_IRQ_INDEX, 0,
> +                                VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
>           error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>       }
>       qemu_set_fd_handler(event_notifier_get_fd(&vdev->req_notifier),
> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> index 2bd16096bb..3233ca8691 100644
> --- a/hw/vfio/platform.c
> +++ b/hw/vfio/platform.c
> @@ -115,18 +115,17 @@ static int vfio_set_trigger_eventfd(VFIOINTp *intp,
>       VFIODevice *vbasedev = &intp->vdev->vbasedev;
>       int32_t fd = event_notifier_get_fd(intp->interrupt);
>       Error *err = NULL;
> -    int ret;
>   
>       qemu_set_fd_handler(fd, (IOHandler *)handler, NULL, intp);
>   
> -    ret = vfio_set_irq_signaling(vbasedev, intp->pin, 0,
> -                                 VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err);
> -    if (ret) {
> +    if (!vfio_set_irq_signaling(vbasedev, intp->pin, 0,
> +                                VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
>           error_reportf_err(err, VFIO_MSG_PREFIX, vbasedev->name);
>           qemu_set_fd_handler(fd, NULL, NULL, NULL);
> +        return -EINVAL;
>       }
>   
> -    return ret;
> +    return 0;
>   }
>   
>   /*
> @@ -355,15 +354,14 @@ static int vfio_set_resample_eventfd(VFIOINTp *intp)
>       int32_t fd = event_notifier_get_fd(intp->unmask);
>       VFIODevice *vbasedev = &intp->vdev->vbasedev;
>       Error *err = NULL;
> -    int ret;
>   
>       qemu_set_fd_handler(fd, NULL, NULL, NULL);
> -    ret = vfio_set_irq_signaling(vbasedev, intp->pin, 0,
> -                                 VFIO_IRQ_SET_ACTION_UNMASK, fd, &err);
> -    if (ret) {
> +    if (!vfio_set_irq_signaling(vbasedev, intp->pin, 0,
> +                                VFIO_IRQ_SET_ACTION_UNMASK, fd, &err)) {
>           error_reportf_err(err, VFIO_MSG_PREFIX, vbasedev->name);
> +        return -EINVAL;
>       }
> -    return ret;
> +    return 0;
>   }
>   
>   /**


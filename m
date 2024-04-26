Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 385D7C19F4F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 15:10:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0ND2-0008PX-Nb; Fri, 26 Apr 2024 11:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1s0ND0-0008P1-5C; Fri, 26 Apr 2024 11:09:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1s0NCy-0004UM-4K; Fri, 26 Apr 2024 11:09:53 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43QEXY58002468; Fri, 26 Apr 2024 15:08:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=GRbCeq5VVR2DItLqbUptpgM4Y3GcbQfca8cYMkrRoEU=;
 b=UovpqQqOwjR78bve+1qZhYBfwKbi+7j89ThVZiIpGBdDNruA2Xy0LvBHXn75Idvh2Q1j
 q6wfE4HuFf9eJfzC+S1iLCLbTJK5rCGGm75iappymIe6vW4xzOr4PeLKbGUa0BDvQE4v
 vp+t6Z3T86ulIFgHNHjX/OHKp0HFfcl8eyDYjHyBH4fnlAhMhtz1H/7BJePhwIC4eyYJ
 nJLVAzly0mbN3qNoNUSd6B9E7Nb5qDdUENPHL1zNggdT5wiITD+H19l+5zz5buJ/2b6/
 6NXDZZTLXWCMmroMnSWApxphd4WTmaTFqgyAsEv3pPbCfd7LHrq9bxR7aK+PzEd4S/w/ bQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xre4m82p6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 15:08:48 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43QF8l0J025868;
 Fri, 26 Apr 2024 15:08:47 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xre4m82p2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 15:08:47 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43QDXZs7015302; Fri, 26 Apr 2024 15:08:47 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xmshmr853-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 15:08:47 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43QF8htl30146848
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Apr 2024 15:08:45 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 90CA75805A;
 Fri, 26 Apr 2024 15:08:43 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EBDD05803F;
 Fri, 26 Apr 2024 15:08:42 +0000 (GMT)
Received: from [9.61.150.35] (unknown [9.61.150.35])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 26 Apr 2024 15:08:42 +0000 (GMT)
Message-ID: <6494462b-aab7-495f-9cd8-6c0704b20f93@linux.ibm.com>
Date: Fri, 26 Apr 2024 11:08:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/ap: Use g_autofree variable
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20240424125432.215886-1-clg@redhat.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20240424125432.215886-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WnMsiq1xQxenkCrUaNjlxw9iPUr9undH
X-Proofpoint-GUID: uY-CH4B9WyDNKnRhBkddvPneQ6tc9ji3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_12,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 clxscore=1011
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404260102
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


On 4/24/24 8:54 AM, Cédric Le Goater wrote:
> Also change the return value of vfio_ap_register_irq_notifier() to be
> a bool since it takes and 'Error **' argument. See the qapi/error.h
> Rules section.


LGTM

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>


>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/vfio/ap.c | 19 ++++++++-----------
>   1 file changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 7c4caa5938636937680fec87e999249ac84a4498..8bb024e2fde4a1d72346dee4b662d762374326b9 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -70,14 +70,14 @@ static void vfio_ap_req_notifier_handler(void *opaque)
>       }
>   }
>   
> -static void vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
> +static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
>                                             unsigned int irq, Error **errp)
>   {
>       int fd;
>       size_t argsz;
>       IOHandler *fd_read;
>       EventNotifier *notifier;
> -    struct vfio_irq_info *irq_info;
> +    g_autofree struct vfio_irq_info *irq_info = NULL;
>       VFIODevice *vdev = &vapdev->vdev;
>   
>       switch (irq) {
> @@ -87,13 +87,13 @@ static void vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
>           break;
>       default:
>           error_setg(errp, "vfio: Unsupported device irq(%d)", irq);
> -        return;
> +        return false;
>       }
>   
>       if (vdev->num_irqs < irq + 1) {
>           error_setg(errp, "vfio: IRQ %u not available (number of irqs %u)",
>                      irq, vdev->num_irqs);
> -        return;
> +        return false;
>       }
>   
>       argsz = sizeof(*irq_info);
> @@ -104,14 +104,14 @@ static void vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
>       if (ioctl(vdev->fd, VFIO_DEVICE_GET_IRQ_INFO,
>                 irq_info) < 0 || irq_info->count < 1) {
>           error_setg_errno(errp, errno, "vfio: Error getting irq info");
> -        goto out_free_info;
> +        return false;
>       }
>   
>       if (event_notifier_init(notifier, 0)) {
>           error_setg_errno(errp, errno,
>                            "vfio: Unable to init event notifier for irq (%d)",
>                            irq);
> -        goto out_free_info;
> +        return false;
>       }
>   
>       fd = event_notifier_get_fd(notifier);
> @@ -123,9 +123,7 @@ static void vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
>           event_notifier_cleanup(notifier);
>       }
>   
> -out_free_info:
> -    g_free(irq_info);
> -
> +    return true;
>   }
>   
>   static void vfio_ap_unregister_irq_notifier(VFIOAPDevice *vapdev,
> @@ -171,8 +169,7 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
>           goto error;
>       }
>   
> -    vfio_ap_register_irq_notifier(vapdev, VFIO_AP_REQ_IRQ_INDEX, &err);
> -    if (err) {
> +    if (!vfio_ap_register_irq_notifier(vapdev, VFIO_AP_REQ_IRQ_INDEX, &err)) {
>           /*
>            * Report this error, but do not make it a failing condition.
>            * Lack of this IRQ in the host does not prevent normal operation.


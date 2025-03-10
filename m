Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19EA1C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 15:44:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trfI8-0005di-Su; Mon, 10 Mar 2025 11:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1trfHx-0005MG-E6; Mon, 10 Mar 2025 11:43:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1trfHv-00041H-7H; Mon, 10 Mar 2025 11:43:33 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AE360h027794;
 Mon, 10 Mar 2025 15:43:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=N21xCN
 epGcaqIe2ScJzptCtrt2CYb1r7fTPJiThIbX4=; b=hA4tnlLZOn+z6XXPgnFFHR
 Vi7gAGR2Kzgrk9NqArVORK/F5bHZ/+65mLLnwrOIdldZKqMqokHhVpoiLXCCW98v
 DH4Etv+zLckKX5oBcmJ1GWPfsDCzpfuLkI80VSNUd8p8u3/1mlRXmgGPSUGvA4UW
 DyArOt0zjlrwkZi+eKpgVMjx26a98qb2AZSlR2CT6k4bUreHOwqur5u+WpoVD2+D
 7dL1RnF8t7Gx2vOvDuIpJn3DC/SImO9QvHa5vgVOK/8w2vDWreCWuOyS8VuGO72o
 CYLnIICdmSKcLWY5SCm/bYmmmdTAnYw2svKwq/a5vUKslz/MIa0SDUGKAo5qDJMg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45a1gp0jhp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Mar 2025 15:43:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52AFUAcO014463;
 Mon, 10 Mar 2025 15:43:26 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4592ek7250-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Mar 2025 15:43:26 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52AFhPRk17105594
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Mar 2025 15:43:25 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C2E4C58058;
 Mon, 10 Mar 2025 15:43:25 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EFA0E58057;
 Mon, 10 Mar 2025 15:43:24 +0000 (GMT)
Received: from [9.61.127.211] (unknown [9.61.127.211])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 10 Mar 2025 15:43:24 +0000 (GMT)
Message-ID: <c6ccf121-5dea-4314-9dba-147460db40a4@linux.ibm.com>
Date: Mon, 10 Mar 2025 11:43:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 2/5] hw/vfio/ap: notification handler for AP config
 changed event
To: Rorie Reyes <rreyes@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com
References: <20250310153552.32987-1-rreyes@linux.ibm.com>
 <20250310153552.32987-3-rreyes@linux.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20250310153552.32987-3-rreyes@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4Ky7JQROhvPVAtqf7JsYbWE0991FinFk
X-Proofpoint-ORIG-GUID: 4Ky7JQROhvPVAtqf7JsYbWE0991FinFk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_06,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015
 mlxlogscore=999 suspectscore=0 spamscore=0 impostorscore=0 bulkscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503100121
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=akrowiak@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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




On 3/10/25 11:35 AM, Rorie Reyes wrote:
> Register an event notifier handler to process AP configuration
> change events by queuing the event and generating a CRW to let
> the guest know its AP configuration has changed
>
> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>

LGTM:
Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>

> ---
>   hw/vfio/ap.c | 31 +++++++++++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
>
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index c7ab4ff57a..3614657218 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -18,6 +18,7 @@
>   #include "hw/vfio/vfio-common.h"
>   #include "system/iommufd.h"
>   #include "hw/s390x/ap-device.h"
> +#include "hw/s390x/css.h"
>   #include "qemu/error-report.h"
>   #include "qemu/event_notifier.h"
>   #include "qemu/main-loop.h"
> @@ -37,6 +38,7 @@ struct VFIOAPDevice {
>       APDevice apdev;
>       VFIODevice vdev;
>       EventNotifier req_notifier;
> +    EventNotifier cfg_notifier;
>   };
>   
>   OBJECT_DECLARE_SIMPLE_TYPE(VFIOAPDevice, VFIO_AP_DEVICE)
> @@ -70,6 +72,18 @@ static void vfio_ap_req_notifier_handler(void *opaque)
>       }
>   }
>   
> +static void vfio_ap_cfg_chg_notifier_handler(void *opaque)
> +{
> +    VFIOAPDevice *vapdev = opaque;
> +
> +    if (!event_notifier_test_and_clear(&vapdev->cfg_notifier)) {
> +        return;
> +    }
> +
> +    css_generate_css_crws(0);
> +
> +}
> +
>   static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
>                                             unsigned int irq, Error **errp)
>   {
> @@ -85,6 +99,10 @@ static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
>           notifier = &vapdev->req_notifier;
>           fd_read = vfio_ap_req_notifier_handler;
>           break;
> +    case VFIO_AP_CFG_CHG_IRQ_INDEX:
> +        notifier = &vapdev->cfg_notifier;
> +        fd_read = vfio_ap_cfg_chg_notifier_handler;
> +        break;
>       default:
>           error_setg(errp, "vfio: Unsupported device irq(%d)", irq);
>           return false;
> @@ -136,6 +154,9 @@ static void vfio_ap_unregister_irq_notifier(VFIOAPDevice *vapdev,
>       case VFIO_AP_REQ_IRQ_INDEX:
>           notifier = &vapdev->req_notifier;
>           break;
> +    case VFIO_AP_CFG_CHG_IRQ_INDEX:
> +        notifier = &vapdev->cfg_notifier;
> +        break;
>       default:
>           error_report("vfio: Unsupported device irq(%d)", irq);
>           return;
> @@ -175,6 +196,15 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
>           warn_report_err(err);
>       }
>   
> +    if (!vfio_ap_register_irq_notifier(vapdev, VFIO_AP_CFG_CHG_IRQ_INDEX, &err))
> +    {
> +        /*
> +         * Report this error, but do not make it a failing condition.
> +         * Lack of this IRQ in the host does not prevent normal operation.
> +         */
> +        warn_report_err(err);
> +    }
> +
>       return;
>   
>   error:
> @@ -187,6 +217,7 @@ static void vfio_ap_unrealize(DeviceState *dev)
>       VFIOAPDevice *vapdev = VFIO_AP_DEVICE(dev);
>   
>       vfio_ap_unregister_irq_notifier(vapdev, VFIO_AP_REQ_IRQ_INDEX);
> +    vfio_ap_unregister_irq_notifier(vapdev, VFIO_AP_CFG_CHG_IRQ_INDEX);
>       vfio_detach_device(&vapdev->vdev);
>       g_free(vapdev->vdev.name);
>   }



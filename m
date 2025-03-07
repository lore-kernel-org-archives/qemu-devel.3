Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0BBCC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 11:36:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqVzU-0007Pn-1E; Fri, 07 Mar 2025 06:35:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1tqVyn-0007Hu-FN; Fri, 07 Mar 2025 06:35:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1tqVyl-0003Gd-HE; Fri, 07 Mar 2025 06:35:01 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5277STR3019289;
 Fri, 7 Mar 2025 11:34:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=A6jFxo
 XXoAp9xcDQNKVILzl1SviElNPkkxJ12dxjRRI=; b=eN9gjuslFoy3emGedflyIJ
 0OXSxohMUVmqT43+UOoJ51NCzGeT6H5RQvW/W5VOGSCl+XtvH78iCGHVF8Nui7xt
 5UdqKo6Wit1tUUmHLrAi/0u6fqUMjLpJoBaLuvgZ6CKolzJJlzFNEg4XK4nA7Kce
 qsqW+Xc1dWlRiDIF0gmttgbNU6aZm1Fokzb6Qn5ROFhbZP26t1LXDMf8nq3F7Xb4
 4IzKY4kf7sodSMHxuy3pHZ+QA3eFrO3rFCTJMKef8nagUNEdyTP64LfUsEFnsNW5
 IQ8yaQssRFpuQAE882FxZ2qLySSoFZbFMZnpeWUm1sn3xpkDiUcn2ZYyPdFB08/g
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 457d4p5t7n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Mar 2025 11:34:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5279Hadg013724;
 Fri, 7 Mar 2025 11:34:54 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454e2m6fvj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Mar 2025 11:34:54 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 527BYqMd32178764
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 7 Mar 2025 11:34:53 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DB6BB58065;
 Fri,  7 Mar 2025 11:34:52 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AAD195804B;
 Fri,  7 Mar 2025 11:34:51 +0000 (GMT)
Received: from [9.61.127.211] (unknown [9.61.127.211])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  7 Mar 2025 11:34:51 +0000 (GMT)
Message-ID: <4d1188c1-c48c-4c37-9a67-623875988b9e@linux.ibm.com>
Date: Fri, 7 Mar 2025 06:34:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/5] hw/vfio/ap: notification handler for AP config
 changed event
To: Rorie Reyes <rreyes@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com
References: <20250204170759.36540-1-rreyes@linux.ibm.com>
 <20250204170759.36540-3-rreyes@linux.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20250204170759.36540-3-rreyes@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ufWD1Tx6XvLKojTZoXJUYTl5VCFISAtm
X-Proofpoint-ORIG-GUID: ufWD1Tx6XvLKojTZoXJUYTl5VCFISAtm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_04,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 phishscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503070082
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




On 2/4/25 12:07 PM, Rorie Reyes wrote:
> Register an event notifier handler to process AP configuration
> change events by queuing the event and generating a CRW to let
> the guest know its AP configuration has changed
>
> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
> ---
>   hw/vfio/ap.c | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
>
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 30b08ad375..a2b3735349 100644
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
> @@ -70,6 +72,16 @@ static void vfio_ap_req_notifier_handler(void *opaque)
>       }
>   }
>   
> +static void vfio_ap_cfg_chg_notifier_handler(void *opaque)
> +{
> +    VFIOAPDevice *vapdev = opaque;
> +
> +    if (!event_notifier_test_and_clear(&vapdev->cfg_notifier)) {
> +        css_generate_css_crws(0);

In patch 3/5, you move the css_generate_css_crws() function outside
of this if block and replace it with a return here. That is the right thing
to do, but you should do it here in this patch.

> +    }
> +
> +}
> +
>   static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
>                                             unsigned int irq, Error **errp)
>   {
> @@ -85,6 +97,10 @@ static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
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
> @@ -136,6 +152,9 @@ static void vfio_ap_unregister_irq_notifier(VFIOAPDevice *vapdev,
>       case VFIO_AP_REQ_IRQ_INDEX:
>           notifier = &vapdev->req_notifier;
>           break;
> +    case VFIO_AP_CFG_CHG_IRQ_INDEX:
> +        notifier = &vapdev->cfg_notifier;
> +        break;
>       default:
>           error_report("vfio: Unsupported device irq(%d)", irq);
>           return;
> @@ -175,6 +194,15 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
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
> @@ -187,6 +215,7 @@ static void vfio_ap_unrealize(DeviceState *dev)
>       VFIOAPDevice *vapdev = VFIO_AP_DEVICE(dev);
>   
>       vfio_ap_unregister_irq_notifier(vapdev, VFIO_AP_REQ_IRQ_INDEX);
> +    vfio_ap_unregister_irq_notifier(vapdev, VFIO_AP_CFG_CHG_IRQ_INDEX);
>       vfio_detach_device(&vapdev->vdev);
>       g_free(vapdev->vdev.name);
>   }



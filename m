Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A98C02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 17:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY6ll-0002CF-I8; Wed, 15 Jan 2025 12:01:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1tY6lO-00025U-Tx; Wed, 15 Jan 2025 12:01:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1tY6lK-0004cj-St; Wed, 15 Jan 2025 12:01:06 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FGYWtB002063;
 Wed, 15 Jan 2025 17:00:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=0ZZgPx
 gFquZTcN46EiAokZobN9PdTLMPuJXd327rnt4=; b=gVGBsxTnFwpa+e8fvNQtkP
 AWVv0UPA11E4IgpVrAN/V6M/yLrcxCoRmxVv6m670nveZPxyiKWQIBxQb1hlU9I+
 v1kDIES2Xv+IQWf5Caz/WF9emG2dqE5xYwjkiOS/rjwkNwNyTANT17pg1mo7gjFS
 1KZnVk475a42Wzb4ISo7mPIE38DrCJXjyZMyTHmmF9T1hpKyH6gg+aWRLsNKrVRs
 T7VCsoRy/ONin/XoDL5Rnf1x8Vh/yhzlvsdk28xYYOjgekes2opOjzJlsVGsNNVL
 VQtVpt9F02J+iTS6WVq743oS7ugzUmTK4sWDtt178kTCGxB5L9H6adEgdfH/zcBA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4465gbugks-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jan 2025 17:00:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50FE97p5016976;
 Wed, 15 Jan 2025 17:00:57 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4444fk9bmm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jan 2025 17:00:57 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50FH0ujx31589022
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jan 2025 17:00:56 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4C7925805E;
 Wed, 15 Jan 2025 17:00:56 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2820F58058;
 Wed, 15 Jan 2025 17:00:55 +0000 (GMT)
Received: from [9.61.176.130] (unknown [9.61.176.130])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 15 Jan 2025 17:00:55 +0000 (GMT)
Message-ID: <64671de6-f1c9-47df-997e-2cc15f7ff78c@linux.ibm.com>
Date: Wed, 15 Jan 2025 12:00:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/5] hw/vfio/ap: notification handler for AP config
 changed event
To: Rorie Reyes <rreyes@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com
References: <20250107184354.91079-1-rreyes@linux.ibm.com>
 <20250107184354.91079-3-rreyes@linux.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20250107184354.91079-3-rreyes@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GYzvntiFUuB3P86PSUKCE1V9pVNe__Cj
X-Proofpoint-ORIG-GUID: GYzvntiFUuB3P86PSUKCE1V9pVNe__Cj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_08,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501150125
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=akrowiak@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1.793, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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




On 1/7/25 1:43 PM, Rorie Reyes wrote:
> Register an event notifier handler to process AP configuration
> change events by queuing the event and generating a CRW to let
> the guest know its AP configuration has changed
>
> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
> Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>
> Tested-by: Anthony Krowiak <akrowiak@linux.ibm.com>
> ---
>   hw/vfio/ap.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
>
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 30b08ad375..533cadb2dd 100644
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
> +        warn_report("Event notifier not initialized");
> +        return;
> +    }
> +
> +    css_generate_css_crws(0);
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
> @@ -175,6 +193,15 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
>           warn_report_err(err);
>       }

I missed this in my previous reviews; however, this needs a function to 
unregister the
VFIO_AP_CFG_CHG_IRQ_INDEX notifier.

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



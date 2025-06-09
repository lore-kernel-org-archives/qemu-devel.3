Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB83C61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 10:41:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOZvf-0003PX-4D; Mon, 09 Jun 2025 06:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1uOZvb-0003P1-0e; Mon, 09 Jun 2025 06:40:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1uOZvY-0003Oa-NI; Mon, 09 Jun 2025 06:40:30 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 558LjDEA022766;
 Mon, 9 Jun 2025 10:40:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=gEyupa
 /+JUQHH0dXScCpckR9Z/SWME+PFQcOUv9nbHQ=; b=U3fLiaL+fAZLUaAu4R9iAP
 EBXvPc8ugFDd4fzPTs0HG4GiVVfkXIuy+0XDTRPFFDeHGJZPY3cGFcYYubtjvpWP
 wJKpqCdJ4phOsgpdCmjJxJc01JsXuBQBWpCqZX7EeKFS9eaSgZucgI4/JHPbC7Ze
 vskvYwd3DCR66X3SUzAR6boYthxXyBJ22gkcV4T4P4q30cDbQEjXXBpcI4mDgKgZ
 iuXj8NRw9SWhfpl6pddTSmRqF/CjShyU7AIIPNrjEOqV/hK3IBAfBuG9SWiNCW/h
 7cnWq7qLCCGcuoGI0og5GEtsQpu38kfOe6YJvBl9nDgE1/1rA2t70MZcce1abNgQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474hhdqckr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Jun 2025 10:40:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5596WXad003347;
 Mon, 9 Jun 2025 10:40:24 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4751ykd4bk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Jun 2025 10:40:24 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 559AeNas56688990
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Jun 2025 10:40:23 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 21E2C58055;
 Mon,  9 Jun 2025 10:40:23 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D32C158056;
 Mon,  9 Jun 2025 10:40:21 +0000 (GMT)
Received: from [9.61.64.137] (unknown [9.61.64.137])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Jun 2025 10:40:21 +0000 (GMT)
Message-ID: <d8cbf0f5-3d3b-4d67-9986-d96179d2665b@linux.ibm.com>
Date: Mon, 9 Jun 2025 06:40:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v12 3/4] hw/vfio/ap: Storing event information for an
 AP configuration change event
To: Rorie Reyes <rreyes@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com
References: <20250606183716.26152-1-rreyes@linux.ibm.com>
 <20250606183716.26152-4-rreyes@linux.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20250606183716.26152-4-rreyes@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=DLGP4zNb c=1 sm=1 tr=0 ts=6846ba19 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=sWKEhP36mHoA:10 a=VnNF1IyMAAAA:8
 a=PI68f2b3-64nHHLPdM8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: fEHm0-ID9KWXA2wOulvD5TkuCts4ASXr
X-Proofpoint-ORIG-GUID: fEHm0-ID9KWXA2wOulvD5TkuCts4ASXr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDA3OCBTYWx0ZWRfX2s/q1qYhtxT/
 tS7YAHzei8rro50/GCye/F+7M2Hm4ZshaJ2FUkVeioQyv8LmJPKie+/J5joG18zcMzcYCTbPEzj
 u+3n4Qoy2lLy3cfONk3MOm/wQUs1bbghws5scZLQ5nToUJq2EbiKATt5DvltPurLeXPZTUfFBCG
 llGF7q4FUC4ctTBFWTF+0DT2ic1IC9lNzJBF6yu9sggpTHLe9VTKWRzOv88OLTiX7n7Rm9huC76
 nE1dVCLepeTraxZuN0CXCZH3MollLTpu+AOxa+YT8jPg5rHeUBnyN7Lh8m4kNz8sIhYgDUmYxe1
 g2qtUjH34p+gaDo2QE3DXM1cS8pVcvpoqHsm1qPDaLKIUSis/4gnLqOm2v175RVGHQdWwz0HEfx
 dJqcbJLqKOWmjY/0CCcE8hAjIqq/h+AuIxfZjqGcgRd0IQqb2My7jXDkAwFf9zqhYlmTGj/p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_04,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 clxscore=1015
 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506090078
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




On 6/6/25 2:37 PM, Rorie Reyes wrote:
> These functions can be invoked by the function that handles interception
> of the CHSC SEI instruction for requests indicating the accessibility of
> one or more adjunct processors has changed.
>
> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>

Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>

> ---
>   hw/vfio/ap.c                 | 43 ++++++++++++++++++++++++++++++++++++
>   include/hw/s390x/ap-bridge.h | 39 ++++++++++++++++++++++++++++++++
>   2 files changed, 82 insertions(+)
>
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index fc435f5c5b..7e3c6278b3 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -10,6 +10,7 @@
>    * directory.
>    */
>   
> +#include <stdbool.h>
>   #include "qemu/osdep.h"
>   #include CONFIG_DEVICES /* CONFIG_IOMMUFD */
>   #include <linux/vfio.h>
> @@ -21,6 +22,7 @@
>   #include "hw/s390x/css.h"
>   #include "qemu/error-report.h"
>   #include "qemu/event_notifier.h"
> +#include "qemu/lockable.h"
>   #include "qemu/main-loop.h"
>   #include "qemu/module.h"
>   #include "qemu/option.h"
> @@ -48,6 +50,8 @@ typedef struct APConfigChgEvent {
>   static QTAILQ_HEAD(, APConfigChgEvent) cfg_chg_events =
>       QTAILQ_HEAD_INITIALIZER(cfg_chg_events);
>   
> +static QemuMutex cfg_chg_events_lock;
> +
>   OBJECT_DECLARE_SIMPLE_TYPE(VFIOAPDevice, VFIO_AP_DEVICE)
>   
>   static void vfio_ap_compute_needs_reset(VFIODevice *vdev)
> @@ -96,6 +100,38 @@ static void vfio_ap_cfg_chg_notifier_handler(void *opaque)
>   
>   }
>   
> +int ap_chsc_sei_nt0_get_event(void *res)
> +{
> +    ChscSeiNt0Res *nt0_res  = (ChscSeiNt0Res *)res;
> +    APConfigChgEvent *cfg_chg_event;
> +
> +    WITH_QEMU_LOCK_GUARD(&cfg_chg_events_lock) {
> +        if (QTAILQ_EMPTY(&cfg_chg_events)) {
> +            return EVENT_INFORMATION_NOT_STORED;
> +        }
> +
> +        cfg_chg_event = QTAILQ_FIRST(&cfg_chg_events);
> +        QTAILQ_REMOVE(&cfg_chg_events, cfg_chg_event, next);
> +    }
> +
> +    memset(nt0_res, 0, sizeof(*nt0_res));
> +    g_free(cfg_chg_event);
> +    nt0_res->flags |= PENDING_EVENT_INFO_BITMASK;
> +    nt0_res->length = sizeof(ChscSeiNt0Res);
> +    nt0_res->code = NT0_RES_RESPONSE_CODE;
> +    nt0_res->nt = NT0_RES_NT_DEFAULT;
> +    nt0_res->rs = NT0_RES_RS_AP_CHANGE;
> +    nt0_res->cc = NT0_RES_CC_AP_CHANGE;
> +
> +    return EVENT_INFORMATION_STORED;
> +}
> +
> +bool ap_chsc_sei_nt0_have_event(void)
> +{
> +    QEMU_LOCK_GUARD(&cfg_chg_events_lock);
> +    return !QTAILQ_EMPTY(&cfg_chg_events);
> +}
> +
>   static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
>                                             unsigned int irq, Error **errp)
>   {
> @@ -192,6 +228,13 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
>       VFIOAPDevice *vapdev = VFIO_AP_DEVICE(dev);
>       VFIODevice *vbasedev = &vapdev->vdev;
>   
> +    static bool lock_initialized;
> +
> +    if (!lock_initialized) {
> +        qemu_mutex_init(&cfg_chg_events_lock);
> +        lock_initialized = true;
> +    }
> +
>       if (!vfio_device_get_name(vbasedev, errp)) {
>           return;
>       }
> diff --git a/include/hw/s390x/ap-bridge.h b/include/hw/s390x/ap-bridge.h
> index 470e439a98..7efc52928d 100644
> --- a/include/hw/s390x/ap-bridge.h
> +++ b/include/hw/s390x/ap-bridge.h
> @@ -16,4 +16,43 @@
>   
>   void s390_init_ap(void);
>   
> +typedef struct ChscSeiNt0Res {
> +    uint16_t length;
> +    uint16_t code;
> +    uint8_t reserved1;
> +    uint16_t reserved2;
> +    uint8_t nt;
> +#define PENDING_EVENT_INFO_BITMASK 0x80;
> +    uint8_t flags;
> +    uint8_t reserved3;
> +    uint8_t rs;
> +    uint8_t cc;
> +} QEMU_PACKED ChscSeiNt0Res;
> +
> +#define NT0_RES_RESPONSE_CODE 1
> +#define NT0_RES_NT_DEFAULT    0
> +#define NT0_RES_RS_AP_CHANGE  5
> +#define NT0_RES_CC_AP_CHANGE  3
> +
> +#define EVENT_INFORMATION_NOT_STORED 1
> +#define EVENT_INFORMATION_STORED     0
> +
> +/**
> + * ap_chsc_sei_nt0_get_event - Retrieve the next pending AP config
> + * change event
> + * @res: Pointer to a ChscSeiNt0Res struct to be filled with event
> + * data
> + *
> + * This function checks for any pending AP config change events and,
> + * if present, populates the provided response structure with the
> + * appropriate SEI NT0 fields.
> + *
> + * Return:
> + *   EVENT_INFORMATION_STORED - An event was available and written to @res
> + *   EVENT_INFORMATION_NOT_STORED - No event was available
> + */
> +int ap_chsc_sei_nt0_get_event(void *res);
> +
> +bool ap_chsc_sei_nt0_have_event(void);
> +
>   #endif



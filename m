Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7EE0C28B2F
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 11:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsKCP-0007Mw-TY; Wed, 12 Mar 2025 07:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1tsKCL-0007ML-8q; Wed, 12 Mar 2025 07:24:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1tsKCJ-0001Ex-8E; Wed, 12 Mar 2025 07:24:28 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52C7vGDm027846;
 Wed, 12 Mar 2025 11:24:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=yAL0+c
 v+0sX0rXO34ZApYzghThMQDbUDvZPNGDisF9Y=; b=mBmJljJSNP6P4dvXekWK+9
 8GOmRee15MLoyaLvFHipsLW6y/wa6o4rbug5N8H4CNBln3O24NPQg0AUq7M00Ncx
 oYWMYeqwyL5pRh5kKrpTm2XA3pUYr8ig7VK0XnKd6y78UahQPYehHAXL8IZ5OEXj
 ZqMjN7rg9VNqDfMs2poQ8QjnghBwFAky60Q8pPXfEfSfXVJb2JhTGtEJ0Siph8UO
 Damks0CAVK6DNJCHH+EACGOW7aqSRByUMuVs8mKTzExTumDPxsu320bYh+A7yHEy
 x/wwea/Etyi3V48owkMBwWdr+BaJqSSRN+iBX4bB5QZy/5as68G4ve6Bp4eSBS2g
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45avcyuef7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Mar 2025 11:24:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52CAHoKt007490;
 Wed, 12 Mar 2025 11:24:21 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45atsr3s21-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Mar 2025 11:24:21 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52CBOK6e12124802
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Mar 2025 11:24:20 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 384615805D;
 Wed, 12 Mar 2025 11:24:20 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5AA7B58058;
 Wed, 12 Mar 2025 11:24:19 +0000 (GMT)
Received: from [9.61.127.211] (unknown [9.61.127.211])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 12 Mar 2025 11:24:19 +0000 (GMT)
Message-ID: <b50fe9b3-0dff-4292-843c-7d67f5345213@linux.ibm.com>
Date: Wed, 12 Mar 2025 07:24:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 3/5] hw/vfio/ap: store object indicating AP config
 changed in a queue
To: Rorie Reyes <rreyes@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com
References: <20250311151616.98244-1-rreyes@linux.ibm.com>
 <20250311151616.98244-4-rreyes@linux.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20250311151616.98244-4-rreyes@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ITDPowKjMAQoEK-p7Mi5Ab3y0A9o5Mm4
X-Proofpoint-ORIG-GUID: ITDPowKjMAQoEK-p7Mi5Ab3y0A9o5Mm4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_04,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503120076
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=akrowiak@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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




On 3/11/25 11:16 AM, Rorie Reyes wrote:
> Creates an object indicating that an AP configuration change event
> has been received and stores it in a queue. These objects will later
> be used to store event information for an AP configuration change
> when the CHSC instruction is intercepted.
>
> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>

Reviewed-by: Anthony Krowiak <krowiak@linux.ibm.com>

> ---
>   hw/vfio/ap.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 3614657218..3fa986ca45 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -41,6 +41,13 @@ struct VFIOAPDevice {
>       EventNotifier cfg_notifier;
>   };
>   
> +typedef struct APConfigChgEvent {
> +    QTAILQ_ENTRY(APConfigChgEvent) next;
> +} APConfigChgEvent;
> +
> +QTAILQ_HEAD(, APConfigChgEvent) cfg_chg_events =
> +    QTAILQ_HEAD_INITIALIZER(cfg_chg_events);
> +
>   OBJECT_DECLARE_SIMPLE_TYPE(VFIOAPDevice, VFIO_AP_DEVICE)
>   
>   static void vfio_ap_compute_needs_reset(VFIODevice *vdev)
> @@ -74,12 +81,17 @@ static void vfio_ap_req_notifier_handler(void *opaque)
>   
>   static void vfio_ap_cfg_chg_notifier_handler(void *opaque)
>   {
> +    APConfigChgEvent *cfg_chg_event;
>       VFIOAPDevice *vapdev = opaque;
>   
>       if (!event_notifier_test_and_clear(&vapdev->cfg_notifier)) {
>           return;
>       }
>   
> +    cfg_chg_event = g_new0(APConfigChgEvent, 1);
> +
> +    QTAILQ_INSERT_TAIL(&cfg_chg_events, cfg_chg_event, next);
> +
>       css_generate_css_crws(0);
>   
>   }



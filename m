Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFBF8C28B2E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 15:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trfUT-0004c5-6R; Mon, 10 Mar 2025 11:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1trfUP-0004W4-KD; Mon, 10 Mar 2025 11:56:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1trfUM-0005yc-An; Mon, 10 Mar 2025 11:56:24 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AAliAV003753;
 Mon, 10 Mar 2025 15:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=UzpsBK
 duoNS23Cf16SVYt9gnVQ7ZvtH5kkV7deKlHIs=; b=HS3iiMeZgkJLRKduDEyUED
 R9VGduipd8Hk41NAKY2bcI0f8UybVf4ha7hPCW7lGIu2P2WOMi1gz8Wk6LSgcb0r
 CIq0Ui+4hnUDbKGULKzRb7rWBQ3DVieMR+8P8fMCNUYScxJruyPBmc1zeQ23TDoa
 tI/+vocNpxyXJBhIsXE+peC3hOk6N5nyof6Tw7NVwEBX4pGG5sktIvQzyFKpZuva
 v2PxccE5KJ2gGuEPkypKOsyMgVX4SdL7Xy9cbUhxIIPvnJcksk7Ol+GC4hl1WWL2
 aje66utYXCxTjjLFSq+D8P9SonD6lDBkOMh7F17uwYyRL1cGH+FkWI3x8+ss0vkA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 459jd4v8q1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Mar 2025 15:56:19 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52ADsdX5023914;
 Mon, 10 Mar 2025 15:56:18 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4590kyqgud-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Mar 2025 15:56:18 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52AFuGk325625278
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Mar 2025 15:56:16 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 79AC458068;
 Mon, 10 Mar 2025 15:56:17 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE20058069;
 Mon, 10 Mar 2025 15:56:16 +0000 (GMT)
Received: from [9.61.127.211] (unknown [9.61.127.211])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 10 Mar 2025 15:56:16 +0000 (GMT)
Message-ID: <fef6e0db-f53e-4439-9fe3-83a6085d628b@linux.ibm.com>
Date: Mon, 10 Mar 2025 11:56:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 4/5] hw/vfio/ap: Storing event information for an
 AP configuration change event
To: Rorie Reyes <rreyes@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com
References: <20250310153552.32987-1-rreyes@linux.ibm.com>
 <20250310153552.32987-5-rreyes@linux.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20250310153552.32987-5-rreyes@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ekoFaUeh9WkNk2YYs8C4KihiUgNCmZ_E
X-Proofpoint-GUID: ekoFaUeh9WkNk2YYs8C4KihiUgNCmZ_E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_06,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0
 phishscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503100121
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=akrowiak@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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
> These functions can be invoked by the function that handles interception
> of the CHSC SEI instruction for requests indicating the accessibility of
> one or more adjunct processors has changed.
>
> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
> ---
>   hw/vfio/ap.c                 | 38 ++++++++++++++++++++++++++++++++++++
>   include/hw/s390x/ap-bridge.h | 22 +++++++++++++++++++++
>   2 files changed, 60 insertions(+)
>
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index ddab764ab4..a152a90ca8 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -94,6 +94,44 @@ static void vfio_ap_cfg_chg_notifier_handler(void *opaque)
>   
>   }
>   
> +int ap_chsc_sei_nt0_get_event(void *res)
> +{
> +    APConfigChgEvent *cfg_chg_event = QTAILQ_FIRST(&cfg_chg_events);

You're assuming that the queue has elements in it. Shouldn't you check
first?

> +    ChscSeiNt0Res *nt0_res  = (ChscSeiNt0Res *)res;
> +
> +    memset(nt0_res, 0, sizeof(*nt0_res));
> +
> +    if (!cfg_chg_event) {

Okay, so I see you are checking whether the QTAILQ_FIRST() call above
returned anything. Why not call the ap_chsc_sei_nt0_have_event() 
function here instead, then follow that with the call to QTAILQ_FIRST() 
if there are any elements in the queue. Also, maybe forego the memset() 
call above until you verify that there are elements in the queue; if 
not, then the memset() call is unnecessary.
> +        return 1;
> +    }
> +
> +    QTAILQ_REMOVE(&cfg_chg_events, cfg_chg_event, next);
> +    g_free(cfg_chg_event);
> +
> +    /*
> +     * If there are any AP configuration change events in the queue,
> +     * indicate to the caller that there is pending event info in
> +     * the response block
> +     */
> +    if (ap_chsc_sei_nt0_have_event()) {
> +        nt0_res->flags |= PENDING_EVENT_INFO_BITMASK;
> +    }
> +
> +    nt0_res->length = sizeof(ChscSeiNt0Res);
> +    nt0_res->code = NT0_RES_RESPONSE_CODE;
> +    nt0_res->nt = NT0_RES_NT_DEFAULT;
> +    nt0_res->rs = NT0_RES_RS_AP_CHANGE;
> +    nt0_res->cc = NT0_RES_CC_AP_CHANGE;
> +
> +    return 0;
> +
> +}
> +
> +int ap_chsc_sei_nt0_have_event(void)
> +{
> +    return !QTAILQ_EMPTY(&cfg_chg_events);
> +}
> +
>   static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
>                                             unsigned int irq, Error **errp)
>   {
> diff --git a/include/hw/s390x/ap-bridge.h b/include/hw/s390x/ap-bridge.h
> index 470e439a98..f4d838bf99 100644
> --- a/include/hw/s390x/ap-bridge.h
> +++ b/include/hw/s390x/ap-bridge.h
> @@ -16,4 +16,26 @@
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
> +#define NT0_RES_RESPONSE_CODE 1;
> +#define NT0_RES_NT_DEFAULT    0;
> +#define NT0_RES_RS_AP_CHANGE  5;
> +#define NT0_RES_CC_AP_CHANGE  3;
> +
> +int ap_chsc_sei_nt0_get_event(void *res);
> +
> +int ap_chsc_sei_nt0_have_event(void);
> +
>   #endif



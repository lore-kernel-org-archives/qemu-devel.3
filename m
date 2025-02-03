Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF65CC02196
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 16:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tezew-00030v-LN; Mon, 03 Feb 2025 11:50:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1tezet-00030G-Ml; Mon, 03 Feb 2025 11:50:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1tezer-0000OF-9O; Mon, 03 Feb 2025 11:50:50 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513DRq6D006192;
 Mon, 3 Feb 2025 16:50:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Y/506W
 uebmBpX6P/EfYUwsQKVHw8IMpy/uPg/3aAANA=; b=aj4GRMIrm4M8N0Ub1/pAir
 omlr8yQQAlN9+vfYZYgu9miGkQXd11kMZktKxFJtIynPTe/Vcz5jRaFh6yvnnXx/
 bzSssFkgrXcIg3FNRTNev2FJuF27D3TJv5QE7pkCfu71Jsw3L/uznxuPns8gTkSa
 dwDJCR2LOOXVdJYqm/nqgDCJKNkMVGUh9jLLNZhwafosqr525r3wR+8uiRfKrUJE
 ejBWzhalAtLAEts5+OIX6tD1GpvS7SAXDOCSd7WV4hOPGP36SlHjlu8gkGAxbsbf
 jolrwFG13MmvMulAJjpW9AFykoDJEBcDx1y5kyZBFBZEfodEnoU/eBsVI68BogxQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44jmmybpcx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Feb 2025 16:50:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 513FYAXm024635;
 Mon, 3 Feb 2025 16:50:44 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hxxmyag7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Feb 2025 16:50:44 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 513GohLG15270614
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Feb 2025 16:50:43 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 643C858043;
 Mon,  3 Feb 2025 16:50:43 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9033658055;
 Mon,  3 Feb 2025 16:50:42 +0000 (GMT)
Received: from [9.61.168.239] (unknown [9.61.168.239])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  3 Feb 2025 16:50:42 +0000 (GMT)
Message-ID: <d80b686c-71ee-4a25-82bf-5cf96c43975d@linux.ibm.com>
Date: Mon, 3 Feb 2025 11:50:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/5] hw/vfio/ap: store object indicating AP config
 changed in a queue
To: Rorie Reyes <rreyes@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com
References: <20250107184354.91079-1-rreyes@linux.ibm.com>
 <20250107184354.91079-4-rreyes@linux.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20250107184354.91079-4-rreyes@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dHXqAUHb2_ZSCHZu97NKvyKZDMT_oLv0
X-Proofpoint-ORIG-GUID: dHXqAUHb2_ZSCHZu97NKvyKZDMT_oLv0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_07,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0
 phishscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502030120
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




On 1/7/25 1:43 PM, Rorie Reyes wrote:
> Creates an object indicating that an AP configuration change event
> has been received and stores it in a queue. These objects will later
> be used to store event information for an AP configuration change
> when the CHSC instruction is intercepted.
>
> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
> Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>
> Tested-by: Anthony Krowiak <akrowiak@linux.ibm.com>
> ---
>   hw/vfio/ap.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 533cadb2dd..508c6eed7a 100644
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
> @@ -76,6 +83,9 @@ static void vfio_ap_cfg_chg_notifier_handler(void *opaque)
>   {
>       VFIOAPDevice *vapdev = opaque;
>   
> +    APConfigChgEvent *new_event = g_new0(APConfigChgEvent, 1);
> +
> +    QTAILQ_INSERT_TAIL(&cfg_chg_events, new_event, next);

I didn't notice this before giving my r-b, but I don't think new_event 
should be
inserted into the queue until the 'event_notifier_test_and_clear' below
passes.

>       if (!event_notifier_test_and_clear(&vapdev->cfg_notifier)) {
>           warn_report("Event notifier not initialized");
>           return;



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A25BC3ABCC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 11:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEnxz-0005Ux-5N; Tue, 13 May 2025 07:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1uEnxu-0005UM-LR; Tue, 13 May 2025 07:38:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1uEnxs-0000uO-5B; Tue, 13 May 2025 07:38:30 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D9F71b030046;
 Tue, 13 May 2025 11:38:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=iq0TZf
 FPDU+ruLkHg7c0vAoeMctdus2BwzX2dq5gcRg=; b=URQr3GrrbJdfqnN+vgHz2I
 D9NoVVQh3FTM6KfWq3giJc6mDUIq9CdijbGscMukBY2xNBkQSUi56/WXQECtTVjN
 OmOrj/D3Z2zYdFwafsqtV3t7ijkEyG8PWPsYcJDIpYMWLXWHDvU4v+LwVY9x/F2F
 somIju2dZLf0JiN6aZhlsYltBalL1b2soo6FaARTXMQMN691QTbff1SaiwDwUTMP
 m9of5q0CKtmdPKrxsv2JdR1dIPNhK+dUsTasIW4r5tegZ8WKGHyg+i+1QNSYuUEF
 WBZU8kKV1iMmYjm9ovShLXcNLsxfWkrN96QibcNaHGFvopJ89RQOKRbysyPQxNJg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46m39j8p19-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 May 2025 11:38:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54D9BcUS016348;
 Tue, 13 May 2025 11:38:19 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46jh4tk2e5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 May 2025 11:38:19 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54DBcIeQ20709924
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 May 2025 11:38:18 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3614A5805F;
 Tue, 13 May 2025 11:38:18 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CCEBC58064;
 Tue, 13 May 2025 11:38:16 +0000 (GMT)
Received: from [9.61.132.237] (unknown [9.61.132.237])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 13 May 2025 11:38:16 +0000 (GMT)
Message-ID: <527b09b6-b7cc-4d5e-a82f-5ee87a7ca91e@linux.ibm.com>
Date: Tue, 13 May 2025 07:38:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v9 2/4] hw/vfio/ap: store object indicating AP config
 changed in a queue
To: Rorie Reyes <rreyes@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com
References: <20250512180230.50129-1-rreyes@linux.ibm.com>
 <20250512180230.50129-3-rreyes@linux.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20250512180230.50129-3-rreyes@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5xFgkTGWdvC5odoFtxH2ADn27hIDI-sL
X-Proofpoint-ORIG-GUID: 5xFgkTGWdvC5odoFtxH2ADn27hIDI-sL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDExMCBTYWx0ZWRfX9Cw0jdszVu7G
 xEcejQzI5GLuVpPbqYqks3kQHafDbK8ewOIJekKUtMzW9DyLzIkOVx2UNMARI1ib+Xnkn2HoERO
 R7uVlDKG31ctK3UOjY1KQKXOw2rdDLuD3h9ibIn9yi+UrA860K96of/NjqNa4vkBH/M4KawWSXN
 HvOADNKX66iveiEgyadT5Tge42pk0oMCGdxLaxNBiJWieasYQjZNhEftfa6cRCv1lqgwYmmKfBR
 JeF40FmDrLIHgqqu9lBs/gNGOcgJmalolRGej6ltbGNqpAO9HvZz/tD0nO+CmQqJryl+JiJeGNV
 ucO/1ut/+HX0z9gmenfSg5uZr7KZYDQZuRd9Q8P5h24ZTQ02CqG6f/g+/Oqg5Kq0K0UN8Hj2iXX
 /9i6Px39xWndm7zXkzFtmnob52vr2Wt0Lzhqjuw63NBr1H7M79Y1p9HBVYVd+PEJhbTZgY5S
X-Authority-Analysis: v=2.4 cv=Sfb3duRu c=1 sm=1 tr=0 ts=68232f2c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=5v0q2DLhJsiMCMKXfuEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_01,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 spamscore=0
 impostorscore=0 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505130110
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=akrowiak@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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




On 5/12/25 2:02 PM, Rorie Reyes wrote:
> Creates an object indicating that an AP configuration change event
> has been received and stores it in a queue. These objects will later
> be used to store event information for an AP configuration change
> when the CHSC instruction is intercepted.
>
> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>

Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>

> ---
>   hw/vfio/ap.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 3d0af7a54a..5ea5dd9cca 100644
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



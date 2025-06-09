Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39440C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 10:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOZb2-0000HM-H8; Mon, 09 Jun 2025 06:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1uOZb0-0000Gw-2L; Mon, 09 Jun 2025 06:19:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1uOZax-0000nQ-Rs; Mon, 09 Jun 2025 06:19:13 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 558LtddS015822;
 Mon, 9 Jun 2025 10:19:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=cSq2tc
 SGFprBBtt2yJmlCt5lU8OE60Dwpkzlt5bxcgg=; b=quSnFPYLL02TUfi5Ckmit/
 jSxk8U8HzbiJbCz+X2Pt4SaI1fDh3gPb20nVr2QiK7A2MkJ20AGgwJXT1Ot4XdkV
 y5Hrg4+lvcGkUjdxrF+oMMfO5A+6K9XmRQZ8cW8PeytxXIZHq+IZiNQgzHts62eE
 0/mrEqfSpMfoWvf+s7mCAn9rNUNVv593TeOB0Tgx21Zk47B9L0xAJqHfPpAzftrW
 Ha60T1RLjrNjzVQSZV05jbA4BNSDGj/E1sslQHl3VLIXX7hjaJmg1Hb3ZoiA9j0Y
 ZBkeiZR8oOPntzyO8D3FdzpJUdgQv+QfdT6RGmkEs2LSf/JnRo6mYFUhTnTwA3vg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474x4kw5t0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Jun 2025 10:19:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 559AGPXP014912;
 Mon, 9 Jun 2025 10:19:07 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4750rnw8a5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Jun 2025 10:19:06 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 559AJ5Ah32375336
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Jun 2025 10:19:05 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C33758060;
 Mon,  9 Jun 2025 10:19:05 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EE7195803F;
 Mon,  9 Jun 2025 10:19:03 +0000 (GMT)
Received: from [9.61.64.137] (unknown [9.61.64.137])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Jun 2025 10:19:03 +0000 (GMT)
Message-ID: <fb9f5bf3-68d4-4a2f-9f8a-e781e5059475@linux.ibm.com>
Date: Mon, 9 Jun 2025 06:19:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v12 2/4] hw/vfio/ap: store object indicating AP config
 changed in a queue
To: Rorie Reyes <rreyes@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com
References: <20250606183716.26152-1-rreyes@linux.ibm.com>
 <20250606183716.26152-3-rreyes@linux.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20250606183716.26152-3-rreyes@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Y4X4sgeN c=1 sm=1 tr=0 ts=6846b51b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=5v0q2DLhJsiMCMKXfuEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 3D86bnPixVU-Nri5P8xXrf-p5U4UzupC
X-Proofpoint-ORIG-GUID: 3D86bnPixVU-Nri5P8xXrf-p5U4UzupC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDA3OCBTYWx0ZWRfX1klzXMBzPz95
 tforhUV4Ak+ZIwmoGCIU0AajIMw6xrcGjSgJ/NXmtOyUwdKXX3k3/Ag6RiyYwFvjHg+HM7eyPS6
 K60iRtRKh403HZf8TOTABzPKugtq/MKosP0MOvg4OjaX/FZ7vADzfoNhZXL0svcPpuSoG/0ZkAO
 QqznkgeCr6B3UN6Kt4LqbVdqpi6ujvmgwG5AwkMPxGOHaCtMjWMNz2TCzhNQwfujC35xNmjBPXD
 g/2sfHTmm81VMVMPbMo8I05dR/KKsAvW6o5ShGQLdhOUOHSbKjTjuLKTUKE3kE+kBhwMKAj8iQJ
 teeCTjlSYE676+rUEX4RL/sndExJ40CIZxNI4vlzYSajInud8AakbHUaRCP+9W6Q8guO+KZ6Oeb
 d7rGVLr3Cwxvttr8+qibB15avpk/Rl9Bp+qa4FBYKgUcj6f9Fb5ZHgvhF5AxlhyBjE70Vudj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_04,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 spamscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506090078
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=akrowiak@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
> Creates an object indicating that an AP configuration change event
> has been received and stores it in a queue. These objects will later
> be used to store event information for an AP configuration change
> when the CHSC instruction is intercepted.
>
> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>

See comment below. With that change made:

Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>

> ---
>   hw/vfio/ap.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 93c74ebedb..fc435f5c5b 100644
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
> +static QTAILQ_HEAD(, APConfigChgEvent) cfg_chg_events =
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

Need locking here:

WITH_QEMU_LOCK_GUARD(&cfg_chg_events_lock) {

QTAILQ_INSERT_TAIL(&cfg_chg_events, cfg_chg_event, next);

}



> +
>       css_generate_css_crws(0);
>   
>   }



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B13C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 16:20:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0OIg-0002Wh-SQ; Fri, 26 Apr 2024 12:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1s0OIe-0002WU-QT; Fri, 26 Apr 2024 12:19:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1s0OIb-0004pB-4p; Fri, 26 Apr 2024 12:19:48 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43QGHF0P016475; Fri, 26 Apr 2024 16:19:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=r3KK1NOzobdFYveH+WlpJMwCQD8r0qXgpIk1rVecJTc=;
 b=tTGTWdgQN+UAWf2IwuynJhDAUi0qcQBacNeSIqNk+9/R+1x1DfbHAt4kJ1NSg5bA5J0t
 gz6lF3lsgFHVYdAuaO/aHoJzHIKtzUaqUWr0XoD1sMebFsfXF+DRc8lzJGNDJ3rYakhH
 2OfCW6exPYlS61+yypaLYEBM6pm9FArSnQOHwScF2+DE8JWJIw1bJXf3VUIINC6+Kqo1
 StNTc86a6oszUX9mJziVruqtdNj/bUuE+jY+Y/FCJHoKwZ/HPdOp/Fm4LvOvrvoQdX2k
 PodJRZMh+ADrhY4STgGCkHprzGMw1FDcqm5qKBdeU4GEsNSUxEgn3JHgvD6e1+GMNxZO tQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xrfnb8070-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 16:19:41 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43QGJewk020553;
 Fri, 26 Apr 2024 16:19:41 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xrfnb806x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 16:19:40 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43QGBGrd023052; Fri, 26 Apr 2024 16:19:39 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xms1pgp3b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 16:19:39 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43QGJaO338011422
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Apr 2024 16:19:38 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6EA9658060;
 Fri, 26 Apr 2024 16:19:36 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 943505803F;
 Fri, 26 Apr 2024 16:19:35 +0000 (GMT)
Received: from [9.61.150.35] (unknown [9.61.150.35])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 26 Apr 2024 16:19:35 +0000 (GMT)
Message-ID: <6178472f-7222-4cbb-a00b-5bb3cdb161c0@linux.ibm.com>
Date: Fri, 26 Apr 2024 12:19:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] vfio/ap: Use g_autofree variable in
 vfio_ap_register_irq_notifier()
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20240425090214.400194-1-clg@redhat.com>
 <20240425090214.400194-2-clg@redhat.com>
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20240425090214.400194-2-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 30Md2r-gwx98JRHQzbIxKb4aEYb31W8F
X-Proofpoint-GUID: y_SX-M2TZ43bbEGZ3lOK9GkGhbxkBP1b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_13,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404260111
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=akrowiak@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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


On 4/25/24 5:02 AM, Cédric Le Goater wrote:
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/vfio/ap.c | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)


LGTM

Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>


>
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 7c4caa5938636937680fec87e999249ac84a4498..03f8ffaa5e2bf13cf8daa2f44aa4cf17809abd94 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -77,7 +77,7 @@ static void vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
>       size_t argsz;
>       IOHandler *fd_read;
>       EventNotifier *notifier;
> -    struct vfio_irq_info *irq_info;
> +    g_autofree struct vfio_irq_info *irq_info = NULL;
>       VFIODevice *vdev = &vapdev->vdev;
>   
>       switch (irq) {
> @@ -104,14 +104,14 @@ static void vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
>       if (ioctl(vdev->fd, VFIO_DEVICE_GET_IRQ_INFO,
>                 irq_info) < 0 || irq_info->count < 1) {
>           error_setg_errno(errp, errno, "vfio: Error getting irq info");
> -        goto out_free_info;
> +        return;
>       }
>   
>       if (event_notifier_init(notifier, 0)) {
>           error_setg_errno(errp, errno,
>                            "vfio: Unable to init event notifier for irq (%d)",
>                            irq);
> -        goto out_free_info;
> +        return;
>       }
>   
>       fd = event_notifier_get_fd(notifier);
> @@ -122,10 +122,6 @@ static void vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
>           qemu_set_fd_handler(fd, NULL, NULL, vapdev);
>           event_notifier_cleanup(notifier);
>       }
> -
> -out_free_info:
> -    g_free(irq_info);
> -
>   }
>   
>   static void vfio_ap_unregister_irq_notifier(VFIOAPDevice *vapdev,


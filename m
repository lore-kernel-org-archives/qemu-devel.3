Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72CE0C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 13:15:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAUlD-0006xv-AU; Fri, 24 May 2024 09:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1sAUl9-0006sA-67; Fri, 24 May 2024 09:15:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1sAUl6-0004Wd-R1; Fri, 24 May 2024 09:14:58 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44OCbB0t010335; Fri, 24 May 2024 13:14:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=+ixvUAj6sN/MG6rhFsZTOvHqyr8xvnY9g6DE3YnyWl4=;
 b=Zn/E3s0wldOErgPEjnyq6hk9GK7WoAExzr2f+To2oip8gvazoNlGYhZobSKydrDFymmD
 tvK703u4O7L/nJVt8+HxUHvKwfwMIRGqFOpOHMyW+sFf4gJNw2wCWxysucs1WzYQxN30
 okloD0RICbbaX4msPJW5OmshAEkjBN5wSeyoTLuZfRf226yRiQWt7HHbBwDEpS8raDie
 FgQJfXsdjRii2z9oib/wuPF3A4kx00v27scFAtWttviyrdBMTzv8+4bLUo0SIjiwgnd1
 YoyDMaKx4VjrX55zkdzkdKtZ7p0xIvb4xtNM3VhHYfSqWgRnu0939HHgs8GqHUNZafvN qg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yau25r3bx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 May 2024 13:14:53 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44ODEr50010715;
 Fri, 24 May 2024 13:14:53 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yau25r3bt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 May 2024 13:14:53 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44OC31Zd000923; Fri, 24 May 2024 13:14:52 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y7720rxrc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 May 2024 13:14:52 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44ODEn1X6881906
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 May 2024 13:14:51 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E062058068;
 Fri, 24 May 2024 13:14:48 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 68C8258063;
 Fri, 24 May 2024 13:14:48 +0000 (GMT)
Received: from [9.61.26.241] (unknown [9.61.26.241])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 May 2024 13:14:48 +0000 (GMT)
Message-ID: <4cbe27d0-ee4c-4a8f-8a3e-76578f90c651@linux.ibm.com>
Date: Fri, 24 May 2024 09:14:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Anthony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH 5/7] vfio/ccw: Use the 'Error **errp' argument of
 vfio_ccw_realize()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
References: <20240522170107.289532-1-clg@redhat.com>
 <20240522170107.289532-6-clg@redhat.com>
Content-Language: en-US
In-Reply-To: <20240522170107.289532-6-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0WxaFHuCWWxulae69TAPFeTueXu2zI_Y
X-Proofpoint-ORIG-GUID: IaKSrfSRBJ_DNOLJcU3JwzEztALPV_K-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-24_04,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405240091
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


On 5/22/24 1:01 PM, Cédric Le Goater wrote:
> The local error variable is kept for vfio_ccw_register_irq_notifier()
> because it is not considered as a failing condition. We will change
> how error reporting is done in following changes.
>
> Remove the error_propagate() call.
>
> Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>


Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>


> ---
>   hw/vfio/ccw.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 9a8e052711fe2f7c067c52808b2af30d0ebfee0c..a468fa2342b97e0ee36bd5fb8443025cc90a0453 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -582,8 +582,8 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
>   
>       /* Call the class init function for subchannel. */
>       if (cdc->realize) {
> -        if (!cdc->realize(cdev, vcdev->vdev.sysfsdev, &err)) {
> -            goto out_err_propagate;
> +        if (!cdc->realize(cdev, vcdev->vdev.sysfsdev, errp)) {
> +            return;
>           }
>       }
>   
> @@ -596,17 +596,17 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
>           goto out_attach_dev_err;
>       }
>   
> -    if (!vfio_ccw_get_region(vcdev, &err)) {
> +    if (!vfio_ccw_get_region(vcdev, errp)) {
>           goto out_region_err;
>       }
>   
> -    if (!vfio_ccw_register_irq_notifier(vcdev, VFIO_CCW_IO_IRQ_INDEX, &err)) {
> +    if (!vfio_ccw_register_irq_notifier(vcdev, VFIO_CCW_IO_IRQ_INDEX, errp)) {
>           goto out_io_notifier_err;
>       }
>   
>       if (vcdev->crw_region) {
>           if (!vfio_ccw_register_irq_notifier(vcdev, VFIO_CCW_CRW_IRQ_INDEX,
> -                                            &err)) {
> +                                            errp)) {
>               goto out_irq_notifier_err;
>           }
>       }
> @@ -634,8 +634,6 @@ out_attach_dev_err:
>       if (cdc->unrealize) {
>           cdc->unrealize(cdev);
>       }
> -out_err_propagate:
> -    error_propagate(errp, err);
>   }
>   
>   static void vfio_ccw_unrealize(DeviceState *dev)


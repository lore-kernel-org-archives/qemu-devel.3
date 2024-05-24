Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B53C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 13:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAUks-0006LW-Fe; Fri, 24 May 2024 09:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1sAUkr-0006L1-G4; Fri, 24 May 2024 09:14:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1sAUkp-0004Rm-Ke; Fri, 24 May 2024 09:14:41 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44OD991e015029; Fri, 24 May 2024 13:14:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=xtQ72+PZrpROgtNo6AOqufj0Pja/upEVJj3fvyg8UjI=;
 b=UARMRqHupPp5LDvA5vnhksyWPvyQq/72OhCIBE5ZdyyYQpnB5etbA0rbthKbvX7Fg+DL
 ybjysdv3UjwR9ZmB0eFwfMNRiAjWfroRjqZ+l8pduUwiGi2yp6cJjMZErgh59YbPv2Y0
 +E7KnitEqkUM2G5LPGofIGtMV0Ehmzogme1h8tfl8SriQcxde0bPzqvx+Mqdw7an8G55
 l8IL5GZNjBa6+vWbnM+a7Mo2wWZTBQyWQfk1jIyGcfybLzrIYmZks/jGklmAVoSarc90
 ZAOLZNLOKJMhU+AEZ11SXRabKXQCw+X5P0q2/PhhkFd431Q9WEGwZoquJFkpoTk/Y/4U vQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yauga00kq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 May 2024 13:14:37 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44ODEaJ3023060;
 Fri, 24 May 2024 13:14:36 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yauga00kh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 May 2024 13:14:36 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44OCD8pc023460; Fri, 24 May 2024 13:14:35 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y77nprt5p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 May 2024 13:14:35 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44ODEWJ137028142
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 May 2024 13:14:34 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 989C258066;
 Fri, 24 May 2024 13:14:30 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 07F9C58065;
 Fri, 24 May 2024 13:14:30 +0000 (GMT)
Received: from [9.61.26.241] (unknown [9.61.26.241])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 May 2024 13:14:29 +0000 (GMT)
Message-ID: <fee6d720-77a6-47ef-928e-8e8b362e2e4e@linux.ibm.com>
Date: Fri, 24 May 2024 09:14:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Anthony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH 7/7] vfio/{ap, ccw}: Use warn_report_err() for IRQ notifier
 registration errors
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
References: <20240522170107.289532-1-clg@redhat.com>
 <20240522170107.289532-8-clg@redhat.com>
Content-Language: en-US
In-Reply-To: <20240522170107.289532-8-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8cTb9ScRhlgqrediIO2417lLJ__X1sh4
X-Proofpoint-GUID: 7BK6tXS0qcBT9tfq3DilUQh6wxMVwnlk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-24_04,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
> vfio_ccw_register_irq_notifier() and vfio_ap_register_irq_notifier()
> errors are currently reported using error_report_err(). Since they are
> not considered as failing conditions, using warn_report_err() is more
> appropriate.
>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>


Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>


> ---
>   hw/vfio/ap.c  | 2 +-
>   hw/vfio/ccw.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index c12531a7886a2fe87598be0861fba5923bd2c206..0c4354e3e70169ec072e16da0919936647d1d351 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -172,7 +172,7 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
>            * Report this error, but do not make it a failing condition.
>            * Lack of this IRQ in the host does not prevent normal operation.
>            */
> -        error_report_err(err);
> +        warn_report_err(err);
>       }
>   
>       return;
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 36f2677a448c5e31523dcc3de7d973ec70e4a13c..1f8e1272c7555cd0a770481d1ae92988f6e2e62e 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -616,7 +616,7 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
>            * Report this error, but do not make it a failing condition.
>            * Lack of this IRQ in the host does not prevent normal operation.
>            */
> -        error_report_err(err);
> +        warn_report_err(err);
>       }
>   
>       return;


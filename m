Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 938F2C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 13:15:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAUlB-0006tU-8Y; Fri, 24 May 2024 09:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1sAUl7-0006nF-9w; Fri, 24 May 2024 09:14:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1sAUl1-0004V1-Mw; Fri, 24 May 2024 09:14:54 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44OD9iE4009005; Fri, 24 May 2024 13:14:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=3tDl5jkJ6lh+sH3GsIiU2nTqcp2aY7dUJnSW10fzWvU=;
 b=qt13UiT76vSs1M5ecZA5gjJPSSl/W4RdZVZq0JmCYlG1DVFRLJ5zQk+Y53yT1zrpLPs8
 bUBl1mLuYcPfLaIxInwbePjEAAPj1xcfXPmCNJ0vNJCAum4vbwDRmNqQh128vuQx7lP4
 4aoSvDA6JWYox7ctKbcxWphzp9jy0uiizp1rh1XmxLHc9ZAKBJbMRyncxszVBw4ihPI+
 KJ1rUYm//KYFSAnaop63UVfumeZfGRJ4aoY382B5Co3JkuhXqmSM0pHsufWUERYiV90G
 tgh+HH0meeLeNHLb0n9hXd1iQghEwWq80NSz0nFKDvy1N4TNF0CEVoLFPHho/hHwiIO/ Iw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yaugq80fk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 May 2024 13:14:47 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44ODElqp016274;
 Fri, 24 May 2024 13:14:47 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yaugq80ff-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 May 2024 13:14:47 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44OBUHc9022087; Fri, 24 May 2024 13:14:46 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y76nu90ga-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 May 2024 13:14:46 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44ODEhIn22479402
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 May 2024 13:14:45 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 992BE5805D;
 Fri, 24 May 2024 13:14:43 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 19D2058066;
 Fri, 24 May 2024 13:14:43 +0000 (GMT)
Received: from [9.61.26.241] (unknown [9.61.26.241])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 May 2024 13:14:42 +0000 (GMT)
Message-ID: <8b8407de-4db3-45a6-be02-8a74df5cd9cd@linux.ibm.com>
Date: Fri, 24 May 2024 09:14:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Anthony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH 4/7] s390x/css: Make S390CCWDeviceClass::realize return
 bool
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
References: <20240522170107.289532-1-clg@redhat.com>
 <20240522170107.289532-5-clg@redhat.com>
Content-Language: en-US
In-Reply-To: <20240522170107.289532-5-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5jTXbSTWL0DUIkwYeZpxR3R-SkfoS8RI
X-Proofpoint-ORIG-GUID: RGjda59_a0hcWv4uGKydHM564TeJIlNs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-24_04,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 spamscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2405010000 definitions=main-2405240091
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=akrowiak@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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
> Since the realize() handler of S390CCWDeviceClass takes an 'Error **'
> argument, best practices suggest to return a bool. See the api/error.h
> Rules section. While at it, modify the call in vfio_ccw_realize().
>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>


Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>


> ---
>   include/hw/s390x/s390-ccw.h | 2 +-
>   hw/s390x/s390-ccw.c         | 7 ++++---
>   hw/vfio/ccw.c               | 3 +--
>   3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/include/hw/s390x/s390-ccw.h b/include/hw/s390x/s390-ccw.h
> index 2c807ee3a1ae8d85460fe65be8a62c64f212fe4b..2e0a70998132070996d6b0d083b8ddba5b9b87dc 100644
> --- a/include/hw/s390x/s390-ccw.h
> +++ b/include/hw/s390x/s390-ccw.h
> @@ -31,7 +31,7 @@ struct S390CCWDevice {
>   
>   struct S390CCWDeviceClass {
>       CCWDeviceClass parent_class;
> -    void (*realize)(S390CCWDevice *dev, char *sysfsdev, Error **errp);
> +    bool (*realize)(S390CCWDevice *dev, char *sysfsdev, Error **errp);
>       void (*unrealize)(S390CCWDevice *dev);
>       IOInstEnding (*handle_request) (SubchDev *sch);
>       int (*handle_halt) (SubchDev *sch);
> diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
> index b3d14c61d732880a651edcf28a040ca723cb9f5b..3c0975055089c3629dd76ce2e1484a4ef66d8d41 100644
> --- a/hw/s390x/s390-ccw.c
> +++ b/hw/s390x/s390-ccw.c
> @@ -108,7 +108,7 @@ static bool s390_ccw_get_dev_info(S390CCWDevice *cdev,
>       return true;
>   }
>   
> -static void s390_ccw_realize(S390CCWDevice *cdev, char *sysfsdev, Error **errp)
> +static bool s390_ccw_realize(S390CCWDevice *cdev, char *sysfsdev, Error **errp)
>   {
>       CcwDevice *ccw_dev = CCW_DEVICE(cdev);
>       CCWDeviceClass *ck = CCW_DEVICE_GET_CLASS(ccw_dev);
> @@ -117,7 +117,7 @@ static void s390_ccw_realize(S390CCWDevice *cdev, char *sysfsdev, Error **errp)
>       int ret;
>   
>       if (!s390_ccw_get_dev_info(cdev, sysfsdev, errp)) {
> -        return;
> +        return false;
>       }
>   
>       sch = css_create_sch(ccw_dev->devno, errp);
> @@ -142,7 +142,7 @@ static void s390_ccw_realize(S390CCWDevice *cdev, char *sysfsdev, Error **errp)
>   
>       css_generate_sch_crws(sch->cssid, sch->ssid, sch->schid,
>                             parent->hotplugged, 1);
> -    return;
> +    return true;
>   
>   out_err:
>       css_subch_assign(sch->cssid, sch->ssid, sch->schid, sch->devno, NULL);
> @@ -150,6 +150,7 @@ out_err:
>       g_free(sch);
>   out_mdevid_free:
>       g_free(cdev->mdevid);
> +    return false;
>   }
>   
>   static void s390_ccw_unrealize(S390CCWDevice *cdev)
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 2600e62e37238779800dc2b3a0bd315d7633017b..9a8e052711fe2f7c067c52808b2af30d0ebfee0c 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -582,8 +582,7 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
>   
>       /* Call the class init function for subchannel. */
>       if (cdc->realize) {
> -        cdc->realize(cdev, vcdev->vdev.sysfsdev, &err);
> -        if (err) {
> +        if (!cdc->realize(cdev, vcdev->vdev.sysfsdev, &err)) {
>               goto out_err_propagate;
>           }
>       }


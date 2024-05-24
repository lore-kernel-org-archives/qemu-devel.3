Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A918C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 13:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAUpP-0006aO-F4; Fri, 24 May 2024 09:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1sAUpG-0006ZZ-OT; Fri, 24 May 2024 09:19:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1sAUpE-0005XZ-AB; Fri, 24 May 2024 09:19:14 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44ODI0wT018623; Fri, 24 May 2024 13:19:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=sivt8qjnhVDlURqyFbjQ8KPRzLPwHctYobT+6qN5WZU=;
 b=IYWGzLDAzhQ32SWAxnD8fjvnW5cXyUOE+Bxz1g807yyxOuYeb7AR5gfrrmDh8Ib+Qmmg
 yBOxPGOFrBWOgLPnDx0X4PvtV80re53ye2JaxyBI+2jeDhYOOVak11aHoYEwMij0M3H9
 Ck86CbKVZlvh3XjxqBOC3Lpf4JFD29BHls4IFiLvPqleM+VHDd3xeHOKIBBk7NOEQzJB
 9PHNgV4D3hDPs5umAvZNA0emv5mE7GA7IFWyeaLrbKeOsJzOJVabZQz6pRNaXzewr3hF
 VMTJQgjlnZSzuMletq0FNiRcit3u/RTr4EttPVY8K0rIiaCyM6xHhXEDxBwuG0kWEwSq Nw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yaun300a4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 May 2024 13:19:09 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44ODJ884021174;
 Fri, 24 May 2024 13:19:08 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yaun300a0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 May 2024 13:19:08 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44OAD0as026462; Fri, 24 May 2024 13:16:22 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y785n0p1h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 May 2024 13:16:22 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44ODGIEh12124864
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 May 2024 13:16:21 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D3F4C5805D;
 Fri, 24 May 2024 13:16:18 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0BB1758059;
 Fri, 24 May 2024 13:16:18 +0000 (GMT)
Received: from [9.61.26.241] (unknown [9.61.26.241])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 May 2024 13:16:17 +0000 (GMT)
Message-ID: <bd9bffde-8df2-46c9-974d-172979bbe517@linux.ibm.com>
Date: Fri, 24 May 2024 09:16:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Anthony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH 05/16] vfio/helpers: Make vfio_device_get_name() return
 bool
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Thomas Huth <thuth@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 "open list:S390 general arch..." <qemu-s390x@nongnu.org>
References: <20240515082041.556571-1-zhenzhong.duan@intel.com>
 <20240515082041.556571-6-zhenzhong.duan@intel.com>
Content-Language: en-US
In-Reply-To: <20240515082041.556571-6-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8ippjkKBCopuAQgn0NSMacPbH3PC_k2i
X-Proofpoint-ORIG-GUID: J1OqUyBcv9DH-TZCBD3r_RvCEx2UF2uV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-24_04,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405240092
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


On 5/15/24 4:20 AM, Zhenzhong Duan wrote:
> This is to follow the coding standand in qapi/error.h to return bool
> for bool-valued functions.
>
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/hw/vfio/vfio-common.h | 2 +-
>   hw/vfio/ap.c                  | 2 +-
>   hw/vfio/ccw.c                 | 2 +-
>   hw/vfio/helpers.c             | 8 ++++----
>   hw/vfio/pci.c                 | 2 +-
>   hw/vfio/platform.c            | 5 ++---
>   6 files changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index fdce13f0f2..d9891c796f 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -280,7 +280,7 @@ int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>                             uint64_t size, ram_addr_t ram_addr, Error **errp);
>   
>   /* Returns 0 on success, or a negative errno. */
> -int vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
> +bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
>   void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp);
>   void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
>                         DeviceState *dev, bool ram_discard);
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index d8a9615fee..c12531a788 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -158,7 +158,7 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
>       VFIOAPDevice *vapdev = VFIO_AP_DEVICE(dev);
>       VFIODevice *vbasedev = &vapdev->vdev;
>   
> -    if (vfio_device_get_name(vbasedev, errp) < 0) {
> +    if (!vfio_device_get_name(vbasedev, errp)) {
>           return;
>       }


snip ...


>   
> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
> index 93e6fef6de..a69b4411e5 100644
> --- a/hw/vfio/helpers.c
> +++ b/hw/vfio/helpers.c
> @@ -605,7 +605,7 @@ bool vfio_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type)
>       return ret;
>   }
>   
> -int vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
> +bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
>   {
>       ERRP_GUARD();
>       struct stat st;
> @@ -614,7 +614,7 @@ int vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
>           if (stat(vbasedev->sysfsdev, &st) < 0) {
>               error_setg_errno(errp, errno, "no such host device");
>               error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->sysfsdev);
> -            return -errno;
> +            return false;
>           }
>           /* User may specify a name, e.g: VFIO platform device */
>           if (!vbasedev->name) {
> @@ -623,7 +623,7 @@ int vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
>       } else {
>           if (!vbasedev->iommufd) {
>               error_setg(errp, "Use FD passing only with iommufd backend");
> -            return -EINVAL;
> +            return false;
>           }
>           /*
>            * Give a name with fd so any function printing out vbasedev->name
> @@ -634,7 +634,7 @@ int vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
>           }
>       }
>   
> -    return 0;
> +    return true;
>   }


For the two functions above:

Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>


>   


snip ...




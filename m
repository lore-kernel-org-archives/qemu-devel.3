Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95AD1D462B9
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 14:50:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBEgd-0005XM-4Z; Wed, 13 Nov 2024 09:49:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1tBEgX-0005WI-OB; Wed, 13 Nov 2024 09:49:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1tBEgT-00039p-Th; Wed, 13 Nov 2024 09:49:33 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADDeR7A015317;
 Wed, 13 Nov 2024 14:49:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=L1XhW1
 wkVfpI/6R+Dj/173lh8cu7l1ZxvE3efsaX3Fg=; b=p56kibRtDeKUYnlSHaOT5R
 fEIySKT5AOFpGuHlpi9chND9tnWoqulLITadBlM+yjJW677FrSOwnlhAyf91soa1
 XWy7f/IWUQHKeGHe50PD4UqOQj/j+nMooi/MwWJzQiw+dqinYseQurRzj6sIpos/
 3FXczHEcR/6f5zetzbv4gPsHVwWDhezo73aVIUCykEidBch8N84hyDOBhRxUraEs
 kaFyYVfR1ZWc6sThJtoraTK5M4SAn2jQbN7bB5jEsAN96haPo1dphGWA/enfDCOK
 WjEzDhTk4WYvL6sI3Waw0mdwmSUOJfrn2b6nPfMbyaokPrMAh0YeTAf6r6s3pf5g
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42vw6r8ba2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 Nov 2024 14:49:26 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADEOHa2010502;
 Wed, 13 Nov 2024 14:49:25 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42tj2s6efh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 Nov 2024 14:49:25 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4ADEnO2352691208
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Nov 2024 14:49:25 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B97E658054;
 Wed, 13 Nov 2024 14:49:24 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 238895805A;
 Wed, 13 Nov 2024 14:49:24 +0000 (GMT)
Received: from [9.61.167.191] (unknown [9.61.167.191])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 13 Nov 2024 14:49:24 +0000 (GMT)
Message-ID: <bc1e420a-65c1-4e11-901e-24e55dc2265f@linux.ibm.com>
Date: Wed, 13 Nov 2024 09:49:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/s390x: Restrict "loadparm" property to devices that
 can be used for booting
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20241113114741.681096-1-thuth@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20241113114741.681096-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: K1lBSkxr8F5_0RAwQyPa282lbK0RZ5Ub
X-Proofpoint-GUID: K1lBSkxr8F5_0RAwQyPa282lbK0RZ5Ub
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 mlxlogscore=999 bulkscore=0 clxscore=1011 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411130124
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


On 11/13/24 6:47 AM, Thomas Huth wrote:
> Commit bb185de423 ("s390x: Add individual loadparm assignment to
> CCW device") added a "loadparm" property to all CCW devices. This
> was a little bit unfortunate, since this property is only useful
> for devices that can be used for booting, but certainly it is not
> useful for devices like virtio-gpu or virtio-tablet.
>
> Thus let's restrict the property to CCW devices that we can boot from
> (i.e. virtio-block, virtio-net and vfio-ccw devices).
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/s390x/ccw-device.h     | 5 +++++
>   hw/s390x/ccw-device.c     | 4 +---
>   hw/s390x/virtio-ccw-blk.c | 1 +
>   hw/s390x/virtio-ccw-net.c | 1 +
>   hw/vfio/ccw.c             | 1 +
>   5 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/hw/s390x/ccw-device.h b/hw/s390x/ccw-device.h
> index 1e1737c0f3..4439feb140 100644
> --- a/hw/s390x/ccw-device.h
> +++ b/hw/s390x/ccw-device.h
> @@ -51,4 +51,9 @@ static inline CcwDevice *to_ccw_dev_fast(DeviceState *d)
>   
>   OBJECT_DECLARE_TYPE(CcwDevice, CCWDeviceClass, CCW_DEVICE)
>   
> +extern const PropertyInfo ccw_loadparm;
> +
> +#define DEFINE_PROP_CCW_LOADPARM(_n, _s, _f) \
> +    DEFINE_PROP(_n, _s, _f, ccw_loadparm, typeof(uint8_t[8]))
> +
>   #endif
> diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
> index 230cc09e03..30f2fb486f 100644
> --- a/hw/s390x/ccw-device.c
> +++ b/hw/s390x/ccw-device.c
> @@ -73,7 +73,7 @@ static void ccw_device_set_loadparm(Object *obj, Visitor *v,
>       s390_ipl_fmt_loadparm(dev->loadparm, val, errp);
>   }
>   
> -static const PropertyInfo ccw_loadparm = {
> +const PropertyInfo ccw_loadparm = {
>       .name  = "ccw_loadparm",
>       .description = "Up to 8 chars in set of [A-Za-z0-9. ] to pass"
>               " to the guest loader/kernel",
> @@ -85,8 +85,6 @@ static Property ccw_device_properties[] = {
>       DEFINE_PROP_CSS_DEV_ID("devno", CcwDevice, devno),
>       DEFINE_PROP_CSS_DEV_ID_RO("dev_id", CcwDevice, dev_id),
>       DEFINE_PROP_CSS_DEV_ID_RO("subch_id", CcwDevice, subch_id),
> -    DEFINE_PROP("loadparm", CcwDevice, loadparm, ccw_loadparm,
> -            typeof(uint8_t[8])),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> diff --git a/hw/s390x/virtio-ccw-blk.c b/hw/s390x/virtio-ccw-blk.c
> index 8e0e58b77d..2364432c6e 100644
> --- a/hw/s390x/virtio-ccw-blk.c
> +++ b/hw/s390x/virtio-ccw-blk.c
> @@ -48,6 +48,7 @@ static Property virtio_ccw_blk_properties[] = {
>                       VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
>       DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
>                          VIRTIO_CCW_MAX_REV),
> +    DEFINE_PROP_CCW_LOADPARM("loadparm", CcwDevice, loadparm),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> diff --git a/hw/s390x/virtio-ccw-net.c b/hw/s390x/virtio-ccw-net.c
> index 484e617659..a4a3f65c7e 100644
> --- a/hw/s390x/virtio-ccw-net.c
> +++ b/hw/s390x/virtio-ccw-net.c
> @@ -51,6 +51,7 @@ static Property virtio_ccw_net_properties[] = {
>                       VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
>       DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
>                          VIRTIO_CCW_MAX_REV),
> +    DEFINE_PROP_CCW_LOADPARM("loadparm", CcwDevice, loadparm),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 24703c814a..c1cd7736cd 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -662,6 +662,7 @@ static Property vfio_ccw_properties[] = {
>       DEFINE_PROP_LINK("iommufd", VFIOCCWDevice, vdev.iommufd,
>                        TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
>   #endif
> +    DEFINE_PROP_CCW_LOADPARM("loadparm", CcwDevice, loadparm),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   

Hi Thomas,

Thanks for putting this fix together.  As we previously discussed, I do 
agree
that my naive implementation of the “loadparm” property at the top-level
CcwDevice was not satisfactory, and certainly virtio-gpu and virtio-tablet
should not have a “loadparm.”

The reason I had not yet submitted a fix is that I’ve gotten some 
feedback from
the Libvirt side that suggests the CcwDevice implementation is not 
sufficient
in general.  Libvirt will require that non-ccw devices (e.g. scsi-hd) also
support per-device loadparm.  I do not yet know how to add that type of 
support
and given that we are in hard freeze I’m not sure it is possible now.

Obviously this is not ideal, and I truly do apologize for the confusion.

I am amenable to the changes proposed in this patch if you want to 
include it
now, but I expect per-device loadparm will require further revision 
regardless.

Please let me know how you would like to proceed.  Thanks again,
  Jared Rossi


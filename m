Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4AA3C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 13:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAUkm-0006K1-A0; Fri, 24 May 2024 09:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1sAUkk-0006Iz-MB; Fri, 24 May 2024 09:14:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1sAUkh-0004Pk-Ru; Fri, 24 May 2024 09:14:33 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44OCHhPF032452; Fri, 24 May 2024 13:14:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=1spmH0gvvF2yQNgVhLDA0hxdvtf+7TkY3ZCFF9ci28I=;
 b=Qafe6HlYb2K6fbq0yTABUU1BGY7eIgHTYH8EQNSRQs23XmqGET0n+A4R7UPdxRsElBXn
 oIr0G1a6K2fH98ZreNxOnnUDvU5NG61yO7cewCAef6wQfuGFNGF8uSSrkImfl3mX+tmM
 RGG7TbdZcR7VpLlVlBUG6MPAm7g7bZRtGfe7q+ZaIVz7OmHxOK31tqZkteu+zeqPDpOA
 Gly90TDgjtScMfX/Mt+Q9KmXvhFmCh8aAjpGIAxDoQginGHP5SYglu9GBzITvH1uOA+y
 xLqrbWjWsC/670pMxKpDhJAMaT06St5+9Qx9azF6ODcg1AWv38jl4/4RhMJtUuTaq4a0 zg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yatryr505-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 May 2024 13:14:26 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44OD99mZ015029;
 Fri, 24 May 2024 13:14:26 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yatryr503-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 May 2024 13:14:26 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44OCC3Vo022112; Fri, 24 May 2024 13:14:25 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y76nu90fa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 May 2024 13:14:25 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44ODEMh663570356
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 May 2024 13:14:24 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 83BFC58067;
 Fri, 24 May 2024 13:14:22 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0456558065;
 Fri, 24 May 2024 13:14:22 +0000 (GMT)
Received: from [9.61.26.241] (unknown [9.61.26.241])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 May 2024 13:14:21 +0000 (GMT)
Message-ID: <dddb2047-4d33-4f8f-bd04-0d182187ec58@linux.ibm.com>
Date: Fri, 24 May 2024 09:14:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Anthony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH 2/7] s390x/css: Make CCWDeviceClass::realize return bool
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
References: <20240522170107.289532-1-clg@redhat.com>
 <20240522170107.289532-3-clg@redhat.com>
Content-Language: en-US
In-Reply-To: <20240522170107.289532-3-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kklqLG355Y8eRyXbzVCYZlFoqePi9sNO
X-Proofpoint-GUID: FBh2922ZcY7GmcecLgQ16Tu_rgvQpHTS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-24_04,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=938
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405240091
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
> Since the realize() handler of CCWDeviceClass takes an 'Error **'
> argument, best practices suggest to return a bool. See the api/error.h
> Rules section. While at it, modify the call in s390_ccw_realize().
>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>


Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>


> ---
>   hw/s390x/ccw-device.h | 2 +-
>   hw/s390x/ccw-device.c | 3 ++-
>   hw/s390x/s390-ccw.c   | 3 +--
>   3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/hw/s390x/ccw-device.h b/hw/s390x/ccw-device.h
> index 6dff95225df11c63f9b66975019026b215c8c448..5feeb0ee7a268b8709043b5bbc56b06e707a448d 100644
> --- a/hw/s390x/ccw-device.h
> +++ b/hw/s390x/ccw-device.h
> @@ -36,7 +36,7 @@ extern const VMStateDescription vmstate_ccw_dev;
>   struct CCWDeviceClass {
>       DeviceClass parent_class;
>       void (*unplug)(HotplugHandler *, DeviceState *, Error **);
> -    void (*realize)(CcwDevice *, Error **);
> +    bool (*realize)(CcwDevice *, Error **);
>       void (*refill_ids)(CcwDevice *);
>   };
>   
> diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
> index fb8c1acc64d5002c861a4913f292d8346dbef192..a7d682e5af9ce90e7e2fad8c24b30e39328c7cf4 100644
> --- a/hw/s390x/ccw-device.c
> +++ b/hw/s390x/ccw-device.c
> @@ -31,9 +31,10 @@ static void ccw_device_refill_ids(CcwDevice *dev)
>       dev->subch_id.valid = true;
>   }
>   
> -static void ccw_device_realize(CcwDevice *dev, Error **errp)
> +static bool ccw_device_realize(CcwDevice *dev, Error **errp)
>   {
>       ccw_device_refill_ids(dev);
> +    return true;
>   }
>   
>   static Property ccw_device_properties[] = {
> diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
> index a06e91dfb318e3500324851488c56806fa46c08d..4b8ede701df90949720262b6fc1b65f4e505e34d 100644
> --- a/hw/s390x/s390-ccw.c
> +++ b/hw/s390x/s390-ccw.c
> @@ -137,8 +137,7 @@ static void s390_ccw_realize(S390CCWDevice *cdev, char *sysfsdev, Error **errp)
>           goto out_err;
>       }
>   
> -    ck->realize(ccw_dev, &err);
> -    if (err) {
> +    if (!ck->realize(ccw_dev, &err)) {
>           goto out_err;
>       }
>   


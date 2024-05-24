Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE01C25B7A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 13:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAUkD-000691-SA; Fri, 24 May 2024 09:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1sAUkB-00068Z-1S; Fri, 24 May 2024 09:13:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1sAUk7-0004KZ-1O; Fri, 24 May 2024 09:13:58 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44OD2Xmx016034; Fri, 24 May 2024 13:13:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=bU7NRQs5sx7AEIYGWSl9Hs44nydCvkKAdTG8RGYsIlU=;
 b=Ssl9disK2AIW8UsoX+/2vCw/DPFtWhoAZ9+FkCV8OHTIl/SQcS+uXlL1DJAVeRP/BAFz
 kLMUT17/TbVcVF5b3LCHUyvfVgzgXPfLFG2QF1ixFkdckuUsXmB/ry4Qfj6S5/Z9EwTB
 DUN7i9pqZ77hzHqzSr6v9bcPoEWyBnCkfYLP17JKKJNRUt21qg44vxVI4qSxLUan8rc0
 O5d096Fw9xVtsXR10W5shBiIXhI8KHGbgyFSnlHN2QA/iZdFAdLR1DEKv7kPB+lepnCz
 qGywJG4fe90aR+ofry9eihJ0Z9weBEHViwv6AeVo4rLgRvL32l1+fhv/L1FBwbvYb3eu 1g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yaue08165-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 May 2024 13:13:50 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44ODDoPG001562;
 Fri, 24 May 2024 13:13:50 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yaue08160-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 May 2024 13:13:50 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44OB0J0j007818; Fri, 24 May 2024 13:13:49 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y79c3gbxs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 May 2024 13:13:49 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44ODDknb47186380
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 May 2024 13:13:48 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7FA5358062;
 Fri, 24 May 2024 13:13:46 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EBE1E58059;
 Fri, 24 May 2024 13:13:45 +0000 (GMT)
Received: from [9.61.26.241] (unknown [9.61.26.241])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 May 2024 13:13:45 +0000 (GMT)
Message-ID: <6f6295b9-6b69-4828-862e-826ca63caa51@linux.ibm.com>
Date: Fri, 24 May 2024 09:13:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Anthony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH 1/7] hw/s390x/ccw: Make s390_ccw_get_dev_info() return a
 bool
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
References: <20240522170107.289532-1-clg@redhat.com>
 <20240522170107.289532-2-clg@redhat.com>
Content-Language: en-US
In-Reply-To: <20240522170107.289532-2-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1olBp-7Fk-Aj3h7IUDVnGttwiIKRihx0
X-Proofpoint-GUID: 0CGPmAsD_RxSQRVk_we61zwsu4obN4mb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-24_04,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0 clxscore=1011
 impostorscore=0 mlxscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
> Since s390_ccw_get_dev_info() takes an 'Error **' argument, best
> practices suggest to return a bool. See the qapi/error.h Rules
> section. While at it, modify the call in s390_ccw_realize().
>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>


Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>


> ---
>   hw/s390x/s390-ccw.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
> index 5261e66724f1cc3157b9413b0d5fdf5289c92503..a06e91dfb318e3500324851488c56806fa46c08d 100644
> --- a/hw/s390x/s390-ccw.c
> +++ b/hw/s390x/s390-ccw.c
> @@ -71,7 +71,7 @@ IOInstEnding s390_ccw_store(SubchDev *sch)
>       return ret;
>   }
>   
> -static void s390_ccw_get_dev_info(S390CCWDevice *cdev,
> +static bool s390_ccw_get_dev_info(S390CCWDevice *cdev,
>                                     char *sysfsdev,
>                                     Error **errp)
>   {
> @@ -84,12 +84,12 @@ static void s390_ccw_get_dev_info(S390CCWDevice *cdev,
>           error_setg(errp, "No host device provided");
>           error_append_hint(errp,
>                             "Use -device vfio-ccw,sysfsdev=PATH_TO_DEVICE\n");
> -        return;
> +        return false;
>       }
>   
>       if (!realpath(sysfsdev, dev_path)) {
>           error_setg_errno(errp, errno, "Host device '%s' not found", sysfsdev);
> -        return;
> +        return false;
>       }
>   
>       cdev->mdevid = g_path_get_basename(dev_path);
> @@ -98,13 +98,14 @@ static void s390_ccw_get_dev_info(S390CCWDevice *cdev,
>       tmp = g_path_get_basename(tmp_dir);
>       if (sscanf(tmp, "%2x.%1x.%4x", &cssid, &ssid, &devid) != 3) {
>           error_setg_errno(errp, errno, "Failed to read %s", tmp);
> -        return;
> +        return false;
>       }
>   
>       cdev->hostid.cssid = cssid;
>       cdev->hostid.ssid = ssid;
>       cdev->hostid.devid = devid;
>       cdev->hostid.valid = true;
> +    return true;
>   }
>   
>   static void s390_ccw_realize(S390CCWDevice *cdev, char *sysfsdev, Error **errp)
> @@ -116,8 +117,7 @@ static void s390_ccw_realize(S390CCWDevice *cdev, char *sysfsdev, Error **errp)
>       int ret;
>       Error *err = NULL;
>   
> -    s390_ccw_get_dev_info(cdev, sysfsdev, &err);
> -    if (err) {
> +    if (!s390_ccw_get_dev_info(cdev, sysfsdev, &err)) {
>           goto out_err_propagate;
>       }
>   


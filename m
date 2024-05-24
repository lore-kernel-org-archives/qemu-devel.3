Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A7EFC41513
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 13:15:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAUl5-0006Xq-9c; Fri, 24 May 2024 09:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1sAUkz-0006U3-Hq; Fri, 24 May 2024 09:14:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1sAUkw-0004TG-J1; Fri, 24 May 2024 09:14:48 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44OCc56S020308; Fri, 24 May 2024 13:14:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=h5oaXVsppAYPo5ks/Dgdw9icMWJsO2tf5JCuhOSOGVc=;
 b=SePu+MfrjLW4KVm82sbvSzru8duhxGwW4tdVIZnOtIlcsyV54OkGVK2fepAzg2b640nZ
 3esum3V8H5z8et6syBsiF0E28bYTBgcGJe/CH5m3sr50vDmpA5VYmQMbEwJdleEDLu79
 zyM8i8ZvyRA3hFY7E/9AszU3pwH7pPNfW09F+OwAiveKsI/nqi0losKsPoGPPlIpQjuD
 MRYUrh6P1t2PZbsrJVh/SiFQB3rkN4h5+Qd39VNawnRobQuGcrnoPA1TImz5DAT20l81
 msUKtW+VODXyBoRos+XAB8Bu9A5huuNJNQaCUiL+HvVbrs/8jG5ChvJHCzmHAuJDGdVR xw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yau2k83f5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 May 2024 13:14:42 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44ODEgFv013734;
 Fri, 24 May 2024 13:14:42 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yau2k83f1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 May 2024 13:14:42 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44OAD0Zw026462; Fri, 24 May 2024 13:14:41 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y785n0nqs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 May 2024 13:14:41 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44ODEc3W48300366
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 May 2024 13:14:40 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 655AD5805D;
 Fri, 24 May 2024 13:14:38 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D4F3658059;
 Fri, 24 May 2024 13:14:37 +0000 (GMT)
Received: from [9.61.26.241] (unknown [9.61.26.241])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 May 2024 13:14:37 +0000 (GMT)
Message-ID: <629b7f55-5c5f-4b82-9924-dfdfde60222f@linux.ibm.com>
Date: Fri, 24 May 2024 09:14:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Anthony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH 3/7] hw/s390x/ccw: Remove local Error variable from
 s390_ccw_realize()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
References: <20240522170107.289532-1-clg@redhat.com>
 <20240522170107.289532-4-clg@redhat.com>
Content-Language: en-US
In-Reply-To: <20240522170107.289532-4-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6WSS6MlnEqmm5szLTKUmxGRb585t1igK
X-Proofpoint-ORIG-GUID: 4lX8KIcIdQkV8qf_FIFIU9on1WSEPIw8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-24_04,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405240091
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
> Use the 'Error **errp' argument of s390_ccw_realize() instead and
> remove the error_propagate() call.
>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>


Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>


> ---
>   hw/s390x/s390-ccw.c | 13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
> index 4b8ede701df90949720262b6fc1b65f4e505e34d..b3d14c61d732880a651edcf28a040ca723cb9f5b 100644
> --- a/hw/s390x/s390-ccw.c
> +++ b/hw/s390x/s390-ccw.c
> @@ -115,13 +115,12 @@ static void s390_ccw_realize(S390CCWDevice *cdev, char *sysfsdev, Error **errp)
>       DeviceState *parent = DEVICE(ccw_dev);
>       SubchDev *sch;
>       int ret;
> -    Error *err = NULL;
>   
> -    if (!s390_ccw_get_dev_info(cdev, sysfsdev, &err)) {
> -        goto out_err_propagate;
> +    if (!s390_ccw_get_dev_info(cdev, sysfsdev, errp)) {
> +        return;
>       }
>   
> -    sch = css_create_sch(ccw_dev->devno, &err);
> +    sch = css_create_sch(ccw_dev->devno, errp);
>       if (!sch) {
>           goto out_mdevid_free;
>       }
> @@ -132,12 +131,12 @@ static void s390_ccw_realize(S390CCWDevice *cdev, char *sysfsdev, Error **errp)
>       ccw_dev->sch = sch;
>       ret = css_sch_build_schib(sch, &cdev->hostid);
>       if (ret) {
> -        error_setg_errno(&err, -ret, "%s: Failed to build initial schib",
> +        error_setg_errno(errp, -ret, "%s: Failed to build initial schib",
>                            __func__);
>           goto out_err;
>       }
>   
> -    if (!ck->realize(ccw_dev, &err)) {
> +    if (!ck->realize(ccw_dev, errp)) {
>           goto out_err;
>       }
>   
> @@ -151,8 +150,6 @@ out_err:
>       g_free(sch);
>   out_mdevid_free:
>       g_free(cdev->mdevid);
> -out_err_propagate:
> -    error_propagate(errp, err);
>   }
>   
>   static void s390_ccw_unrealize(S390CCWDevice *cdev)


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD70C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 15:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVvF6-0003mq-HF; Mon, 22 Jul 2024 11:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1sVvF2-0003kg-0h; Mon, 22 Jul 2024 11:46:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1sVvEy-0003dP-Nn; Mon, 22 Jul 2024 11:46:23 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MFPGOA013292;
 Mon, 22 Jul 2024 15:46:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=I
 eY1LTQZW3Q0TVoNyptDwgyYBzbI95FYS/i3/BlD1As=; b=ehDJ3ibvp7VhHQ+ps
 8mhRFpxJ1iCqKugiNjenvf7Dhjscpi0v3HGSww1F9dfjlXj0XEOxapKwOoZxU1a+
 5qWzsJjN+zjA5o0zw4K43ts9GJm6FAYJQdHdAE4WKBAVbl4POoGabMZ8qJCVQmCb
 +KbYXIgXdtpLs+/3PIT8hWhys4lqFsysHhjcSBKn9mYi7VlahNeJXHUCU+CrpNyy
 YsCjdrhyzNFWY851lmXKjajWwh3ygc5xyypLQYKricZw52MsVSnk8km3SXgEte33
 NnoZGdF4MGniul2qcObZzTPnTZ6/W6sN/GEzAT5hss95/T4HNLcshKEKgd7c40SK
 kq+nQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40hnpx0qhq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jul 2024 15:46:16 +0000 (GMT)
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46MFkG6l012241;
 Mon, 22 Jul 2024 15:46:16 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40hnpx0qhn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jul 2024 15:46:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46MCALCv007908; Mon, 22 Jul 2024 15:46:14 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40gxn9p00x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jul 2024 15:46:14 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46MFkBi165733060
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2024 15:46:13 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3F48158054;
 Mon, 22 Jul 2024 15:46:11 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9984E5805A;
 Mon, 22 Jul 2024 15:46:09 +0000 (GMT)
Received: from [9.61.135.119] (unknown [9.61.135.119])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 22 Jul 2024 15:46:09 +0000 (GMT)
Message-ID: <aeb1fd39-6a2f-4bab-8cce-84d3b113a667@linux.ibm.com>
Date: Mon, 22 Jul 2024 11:46:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vfio/ap: Don't initialize HOST_IOMMU_DEVICE with mdev
To: Joao Martins <joao.m.martins@oracle.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Thomas Huth <thuth@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 "open list:S390 general arch..." <qemu-s390x@nongnu.org>
References: <20240722070713.1342711-1-zhenzhong.duan@intel.com>
 <20240722070713.1342711-2-zhenzhong.duan@intel.com>
 <ebd01af8-9e39-42e9-93bd-a5a4368bc647@oracle.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <ebd01af8-9e39-42e9-93bd-a5a4368bc647@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6affk64oANA7ww2TOSXgFsF1hCeM4s4c
X-Proofpoint-GUID: QZeTnt120ZGUsSSUOa1PxiILYqXacFxK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_10,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 clxscore=1011 mlxscore=0 priorityscore=1501 spamscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407220116
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=akrowiak@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
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


On 7/22/24 5:18 AM, Joao Martins wrote:
> On 22/07/2024 08:07, Zhenzhong Duan wrote:
>> mdevs aren't "physical" devices and when asking for backing IOMMU info,
>> it fails the entire provisioning of the guest. Fix that by setting
>> vbasedev->mdev true so skipping HostIOMMUDevice initialization in the
>> presence of mdevs.
>>
>> Fixes: 930589520128 ("vfio/iommufd: Implement HostIOMMUDeviceClass::realize() handler")
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


I'm at a bit of a loss here. We've been starting guests with AP devices 
being passed through using VFIO for years. Did the fix for

930589520128 precipitate this? Is there a bugzilla or something that 
describes how this problem was encountered?


> Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
>
>> ---
>>   hw/vfio/ap.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>> index 0c4354e3e7..391bfb72ca 100644
>> --- a/hw/vfio/ap.c
>> +++ b/hw/vfio/ap.c
>> @@ -230,6 +230,9 @@ static void vfio_ap_instance_init(Object *obj)
>>        */
>>       vfio_device_init(vbasedev, VFIO_DEVICE_TYPE_AP, &vfio_ap_ops,
>>                        DEVICE(vapdev), true);
>> +
>> +    /* AP device is mdev type device */
>> +    vbasedev->mdev = true;
>>   }
>>   
>>   #ifdef CONFIG_IOMMUFD


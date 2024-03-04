Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE041C54E4A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 15:13:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh9zw-0000E3-3c; Mon, 04 Mar 2024 10:13:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1rh9zt-00009m-UG; Mon, 04 Mar 2024 10:12:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1rh9zq-0003Qt-K2; Mon, 04 Mar 2024 10:12:57 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 424Ed2Ia025944; Mon, 4 Mar 2024 15:12:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=bdtbQKVHtF4NJDWJmquUW/ceLG7mk6IQq91g4Db7I1g=;
 b=DyrFnNHD0Ug9xbWnv/zBzTNdpuRBDitOGbW3UIJqtQ0syOhFT8xNcTm5u6VAl3EWut/8
 fErZ826jzRPEg72Q7qdwtH2LicVzC9/OUkKHk+9ccb88opH0+BIOZtGyMqswM1IG1LV5
 0hbG30HLjXbO08CWLfHz57Hs2xP2usWYMrd5m+A59ZpEDWEUvHNtyDeXDVT/Xg3sskI2
 UEbc4FyFYcgUUOc6DvEsx7tqOMTP6q1/tjIJnRb5EYs7Jp3dyZ0I6l/ccJebpVc6s5mi
 F1sgB0oMIQ2ieyqTkj+WN8zc89E6JHV/+zQxHyAE6H8Ph4k2yvsFUR3OMnRlpfCsX/6f gw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wng8bgv2b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 Mar 2024 15:12:48 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 424Edq9I028104;
 Mon, 4 Mar 2024 15:12:47 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wng8bgv1y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 Mar 2024 15:12:47 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 424CFltB010913; Mon, 4 Mar 2024 15:12:46 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmh520ue9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 Mar 2024 15:12:46 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 424FCeA625232118
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 4 Mar 2024 15:12:42 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 396125806A;
 Mon,  4 Mar 2024 15:12:40 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2DA2858056;
 Mon,  4 Mar 2024 15:12:39 +0000 (GMT)
Received: from [9.61.76.243] (unknown [9.61.76.243])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  4 Mar 2024 15:12:39 +0000 (GMT)
Message-ID: <0fa974fe-6be5-4468-8581-85bccd4b720b@linux.ibm.com>
Date: Mon, 4 Mar 2024 10:12:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/17] hw/vfio/ap: Fix missing ERRP_GUARD() for
 error_prepend()
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@linux.intel.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>
References: <20240229143914.1977550-1-zhao1.liu@linux.intel.com>
 <20240229143914.1977550-6-zhao1.liu@linux.intel.com>
 <7dadf54c-5a6f-4fe4-8dd3-1137e43c1756@redhat.com>
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <7dadf54c-5a6f-4fe4-8dd3-1137e43c1756@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ckrel7F4KOo1eUXX_mVWZCHwntryovsO
X-Proofpoint-ORIG-GUID: se4vdU-wN4T-xZl_wTBKiaPhCUu-CF6m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_10,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 phishscore=0 clxscore=1011
 mlxscore=0 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403040114
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=akrowiak@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


On 2/29/24 12:30 PM, Thomas Huth wrote:
> On 29/02/2024 15.39, Zhao Liu wrote:
>> From: Zhao Liu <zhao1.liu@intel.com>
>>
>> As the comment in qapi/error, passing @errp to error_prepend() requires
>> ERRP_GUARD():
>>
>> * = Why, when and how to use ERRP_GUARD() =
>> *
>> * Without ERRP_GUARD(), use of the @errp parameter is restricted:
>> ...
>> * - It should not be passed to error_prepend(), error_vprepend() or
>> *   error_append_hint(), because that doesn't work with &error_fatal.
>> * ERRP_GUARD() lifts these restrictions.
>> *
>> * To use ERRP_GUARD(), add it right at the beginning of the function.
>> * @errp can then be used without worrying about the argument being
>> * NULL or &error_fatal.
>>
>> ERRP_GUARD() could avoid the case when @errp is the pointer of
>> error_fatal, the user can't see this additional information, because
>> exit() happens in error_setg earlier than information is added [1].
>>
>> The vfio_ap_realize() passes @errp to error_prepend(), and as a
>> DeviceClass.realize method, its @errp is so widely sourced that it is
>> necessary to protect it with ERRP_GUARD().
>>
>> To avoid the issue like [1] said, add missing ERRP_GUARD() at the
>> beginning of this function.
>>
>> [1]: Issue description in the commit message of commit ae7c80a7bd73
>>       ("error: New macro ERRP_GUARD()").
>>
>> Cc: Alex Williamson <alex.williamson@redhat.com>
>> Cc: "Cédric Le Goater" <clg@redhat.com>
>> Cc: Thomas Huth <thuth@redhat.com>
>> Cc: Tony Krowiak <akrowiak@linux.ibm.com>
>> Cc: Halil Pasic <pasic@linux.ibm.com>
>> Cc: Jason Herne <jjherne@linux.ibm.com>
>> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
>> ---
>>   hw/vfio/ap.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>> index e157aa1ff79c..7c4caa593863 100644
>> --- a/hw/vfio/ap.c
>> +++ b/hw/vfio/ap.c
>> @@ -155,6 +155,7 @@ static void 
>> vfio_ap_unregister_irq_notifier(VFIOAPDevice *vapdev,
>>     static void vfio_ap_realize(DeviceState *dev, Error **errp)
>>   {
>> +    ERRP_GUARD();
>>       int ret;
>>       Error *err = NULL;
>
> Now this function looks like we need both, ERRP_GUARD and the local 
> "err" variable? ... patch looks ok to me, but maybe Markus has an idea 
> how this could be done in a nicer way?


Correct me if I'm wrong, but my understanding from reading the prologue 
in error.h is that errp is used to pass errors back to the caller. The 
'err' variable is used to report errors set by a call to the 
vfio_ap_register_irq_notification function after which this function 
returns cleanly. It does seem, however, that this function should return 
a value (possibly a boolean?)  for the cases where errp is passed to a 
function that sets an error to be propagated to the caller.


>
>  Thomas
>


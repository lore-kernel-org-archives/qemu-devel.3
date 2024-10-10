Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10DFCCEDDAA
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 01:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syi7t-0002wU-EZ; Wed, 09 Oct 2024 21:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1syi7m-0002ud-P3; Wed, 09 Oct 2024 21:37:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1syi7l-0007W3-AW; Wed, 09 Oct 2024 21:37:54 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49A1RaFp031709;
 Thu, 10 Oct 2024 01:37:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=w
 /zbJOTAk6WtezmCg6VYctHFBIYKTVcRC/LteYDqY/o=; b=MPVXscXUQfIQtbUtu
 PF1YnRJKghp3m133H+Lloz1b4xJ/Waw4QlMv8NeAMg6/e1mYAcjm2zB9ik18ekk8
 ILasqR+8jhODcSk/l5MZ2uymm5YbBrK8G8KZoHG6PMs1wFF+bMnA+Lem3bGlndsp
 CRkA4dPP3hAXNh4seXk6056G+Ocbn1fiJQzRbZnxuAhktKaB9pXQAu7OtQknaBjc
 N1amEFKQ0w8l74AJTqqOaisHkBcqPk4oom7o/En2BuTP8u2nKSs6KA45bCove6ez
 2FRhH1/DhQnLWvTL8kTxTopgffFXl/g86urf1FKcY8CUDf/z5tdq4xbxIiFg24Fs
 rqowg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42659600tr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 01:37:51 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49A1boXl019209;
 Thu, 10 Oct 2024 01:37:50 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42659600tn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 01:37:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49A0CPrV013784;
 Thu, 10 Oct 2024 01:37:50 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 423fssdb5d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 01:37:50 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49A1bn1121758634
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Oct 2024 01:37:49 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1097A58052;
 Thu, 10 Oct 2024 01:37:49 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A6BA458056;
 Thu, 10 Oct 2024 01:37:48 +0000 (GMT)
Received: from [9.61.177.235] (unknown [9.61.177.235])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 10 Oct 2024 01:37:48 +0000 (GMT)
Message-ID: <ae2ad791-6c8a-4578-93ec-6bbd74c32bb4@linux.ibm.com>
Date: Wed, 9 Oct 2024 21:37:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/19] pc-bios/s390-ccw: Remove panics from Netboot IPL
 path
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com
References: <20241008011552.2645520-1-jrossi@linux.ibm.com>
 <20241008011552.2645520-12-jrossi@linux.ibm.com>
 <e4731525-ce1b-488c-9c73-fbb9848f3aaf@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <e4731525-ce1b-488c-9c73-fbb9848f3aaf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LmuqOx5LrVbgTzCYMW5lh6bzh5feVU2m
X-Proofpoint-GUID: Y_CEqhV60JK2c6IMXBvmSt9006bO4aul
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_22,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0
 mlxlogscore=923 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410100005
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



On 10/9/24 7:35 AM, Thomas Huth wrote:
> On 08/10/2024 03.15, jrossi@linux.ibm.com wrote:
>> From: Jared Rossi <jrossi@linux.ibm.com>
>>
>> Remove panic-on-error from Netboot specific functions so that error 
>> recovery
>> may be possible in the future.
>>
>> Functions that would previously panic now provide a return code.
>>
>> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
>> ---
> ...
>> diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
>> index bc6ad8695f..0c2329c752 100644
>> --- a/pc-bios/s390-ccw/netmain.c
>> +++ b/pc-bios/s390-ccw/netmain.c
>> @@ -464,7 +464,7 @@ static bool find_net_dev(Schib *schib, int dev_no)
>>       return false;
>>   }
>>   -static void virtio_setup(void)
>> +static int virtio_setup(void)
>
> Maybe better use "bool" instead of "int" here...
>
>>   {
>>       Schib schib;
>>       int ssid;
>> @@ -495,10 +495,10 @@ static void virtio_setup(void)
>>           }
>>       }
>>   -    IPL_assert(found, "No virtio net device found");
>> +    return found;
>
> ... since the function obviously returns a boolean value.
>
>  Thomas
>

Fixed, changed return type to bool.

     Jared


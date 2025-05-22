Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB006C54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 14:30:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI6v3-0002Mr-Sv; Thu, 22 May 2025 10:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uI6us-0002Lo-5l; Thu, 22 May 2025 10:29:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uI6up-0000ID-3R; Thu, 22 May 2025 10:29:01 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54M7G45m002944;
 Thu, 22 May 2025 14:28:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=9Ch1Cn
 f5ye3lQWJsUxBc6vep3czy8phc+DiihmlY0YE=; b=shBRv12+owQBJUqZyfinS5
 Ar8Ikd3SrDc6ymQhXI1FKM2OoSal3ZEfD89wEv/G/qhoE/CnKbQ4u890K+W2x2gC
 l8cLd0+kdCbrJBosrbXp/bQH/vmpe6cLmT70egoc1Yvl7s90pdTGbSi0n57flpH5
 krSvvN6zqBLA46geXnQbEJ7lMEoNprwiVBrV8vlcAZ0ds0pUvB5la0QFGtQi1/nk
 LtPlhD0z+9sXwkU4gE9+zL8NSdKrnDEDui4Y69tRczTigxRLnrWuyPLAruui2oCS
 vZwHi1blijXM30ITjQZYQvgjkgqZgUuvgozu3pszw/ttQ0nNWtPIHRe3l3nITmaw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46smh74naq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 May 2025 14:28:53 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54MDpDLk015506;
 Thu, 22 May 2025 14:28:52 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46rwnnhu93-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 May 2025 14:28:52 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54MESobv23790182
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 May 2025 14:28:50 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 96B8958054;
 Thu, 22 May 2025 14:28:50 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 98C5F5805C;
 Thu, 22 May 2025 14:28:49 +0000 (GMT)
Received: from [9.61.251.113] (unknown [9.61.251.113])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 22 May 2025 14:28:49 +0000 (GMT)
Message-ID: <38ba5741-e564-4812-87e2-ba6235e077b1@linux.ibm.com>
Date: Thu, 22 May 2025 10:28:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v9 2/4] hw/vfio/ap: store object indicating AP config
 changed in a queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, thuth@redhat.com, akrowiak@linux.ibm.com
References: <20250512180230.50129-1-rreyes@linux.ibm.com>
 <20250512180230.50129-3-rreyes@linux.ibm.com>
 <f917f4f3-836b-4bdf-8dde-4d83cb226334@redhat.com>
Content-Language: en-US
From: Rorie Reyes <rreyes@linux.ibm.com>
In-Reply-To: <f917f4f3-836b-4bdf-8dde-4d83cb226334@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDE0MyBTYWx0ZWRfX8t+pGTVkuoo2
 GT+MVr7FbfFITFOtAKc6bRqQmEEmCSpaZJl0ddMPk5C/G0M0b0QiG05XaX01Aqi90hpdTtf4TiP
 CfOep+X6sC2odEyqc9DA55aYR9HngO2n4sj/tcRhNswefS2/1YVHsuNxHabWPcyvuYuBYjT4HLO
 RXF/UgFVl4vZyfrYp8wBDWTdt4LlxCnfJGZGeNMWlTx/O54eqlYN7JY+ND/XVLaPXsg+QRY4F7/
 c/luy6DKpu7W3oTtEIPueZEv/oAbvPkOqNOxhDOK3UmmBWaS+yiin0841/Ys8ld6AwzgxUttLXM
 wzrLj6w+fbY2Ehf259pesYvUcZO04FtjHMKu5bxiNh0pc0C9UIXBNFL6fnNr1AWs1hk6EOT8wgw
 u8rK+8cbOGxM4UFWg/Trj/qPlZC1axFZRdRVJFz7OStsNbFYfYP0PrMIGIGfDeTBohPojyBC
X-Proofpoint-GUID: yr9MB98s0KcQjgWkL6uJNihOEDENzS0J
X-Proofpoint-ORIG-GUID: yr9MB98s0KcQjgWkL6uJNihOEDENzS0J
X-Authority-Analysis: v=2.4 cv=EdfIQOmC c=1 sm=1 tr=0 ts=682f34a5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=NMZh27NZqID8-4F_MXgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_07,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 suspectscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 mlxlogscore=999
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505220143
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rreyes@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


On 5/22/25 9:27 AM, Cédric Le Goater wrote:
> On 5/12/25 20:02, Rorie Reyes wrote:
>> Creates an object indicating that an AP configuration change event
>> has been received and stores it in a queue. These objects will later
>> be used to store event information for an AP configuration change
>> when the CHSC instruction is intercepted.
>>
>> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
>> ---
>>   hw/vfio/ap.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>> index 3d0af7a54a..5ea5dd9cca 100644
>> --- a/hw/vfio/ap.c
>> +++ b/hw/vfio/ap.c
>> @@ -41,6 +41,13 @@ struct VFIOAPDevice {
>>       EventNotifier cfg_notifier;
>>   };
>>   +typedef struct APConfigChgEvent {
>> +    QTAILQ_ENTRY(APConfigChgEvent) next;
>> +} APConfigChgEvent;
>> +
>> +QTAILQ_HEAD(, APConfigChgEvent) cfg_chg_events =
>> +    QTAILQ_HEAD_INITIALIZER(cfg_chg_events);
>> +
>
> Could cfg_chg_events be static ?
>
>
> Thanks,
>
> C.
>
You make a good point, Cedric. I'm only using this variable in ap.c. 
Having it as a static would prevent it from being modified anywhere else


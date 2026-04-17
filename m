Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3600AF436B4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 14:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDkUz-0004lN-9f; Fri, 17 Apr 2026 10:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1wDkUx-0004kx-78; Fri, 17 Apr 2026 10:48:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1wDkUt-0007A4-NH; Fri, 17 Apr 2026 10:48:46 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63HDdOFe1842914; Fri, 17 Apr 2026 14:48:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=1yEQtz
 Dlg1LIZnMc+DxM2hjCJC0UEimSoVgHMDwcnZg=; b=gKXIn1G09kZMTa3PPE+4Kx
 VjNu0zJdfdKkKvUi27LLGQuyuwFKU4d2KPhtvt0sITz8HLfC91e0W/OIG8+LaS4k
 tA4+gqGHTFPckjXRoEmOe8jpUbwHNqD6Fv4syuwGqg6SZj6x1XEi2kYhE+7KLpPT
 uiS4lA9GHogwwy2Wd5CbMUEwi4u2SCTn76NZ3dq1fSCJcwVFhs/8xR2vBH8ELS+0
 NjxvXPCYa36IwtK8Dn2Tiw7zGH6mE06rLqjlv1APbmGQfTgofXFEHqqDlFxJ4fpo
 tgqup8i+lbFTWpiKfk/nWjWrL0ltA5+KZ0PJ4oBGgmZ397DcITr4XiOhUURgrfBw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89n33mb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Apr 2026 14:48:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63HAtuup015153;
 Fri, 17 Apr 2026 14:48:37 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg0msyt5q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Apr 2026 14:48:37 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63HEmAxI1114836
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Apr 2026 14:48:10 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E8A2F58052;
 Fri, 17 Apr 2026 14:48:35 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC8BB5805E;
 Fri, 17 Apr 2026 14:48:35 +0000 (GMT)
Received: from [9.16.58.46] (unknown [9.16.58.46])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 17 Apr 2026 14:48:35 +0000 (GMT)
Message-ID: <dc80892f-7ce6-4a47-b99d-790cf43b2913@linux.ibm.com>
Date: Fri, 17 Apr 2026 09:48:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] qapi/iothread: introduce poll-weight parameter for
 aio-poll
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, pbonzini@redhat.com,
 stefanha@redhat.com, fam@euphon.net, eblake@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, dave@treblig.org,
 sw@weilnetz.de, mjrosato@linux.ibm.com, farman@linux.ibm.com
References: <20260405200735.3075407-1-jhkim@linux.ibm.com>
 <20260405200735.3075407-4-jhkim@linux.ibm.com> <87eckfq7l0.fsf@pond.sub.org>
Content-Language: en-US
From: JAEHOON KIM <jhkim@linux.ibm.com>
In-Reply-To: <87eckfq7l0.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE0OSBTYWx0ZWRfXyYvqi9e5mbQl
 k3h3i8XNFWc9UWnARVreJ9Z9z/eoMG5wohgaxHsT0twtsHD0OYK3FilBs0Q0LoYfohN8Y5TCJHF
 jrFr+fcD1TIBABNlwSAAuPRm65h/Kb5BKtjXcUGtt4YxRBBmizDDlD6+A+spWXn3Y2Br4izg5bg
 k8k0jZ5ZKWkbbsGmcPuGcZGDoVaazcYy93CnwDUTL/pGS1u+XVlAx6SXACehFei2X0sZExp9lTh
 9pnmn96FX6jo1ZeMnqEHWQCDaCqq3AR0GG8rncv55Ji0+72IWNV0vVqO5YgWOq++a0wahBv3d/3
 hbGiXkGfXyTl6mpDlCnyn0ZF/t2GFjyziAwXt+9dk2QCZ+PDaFzXKbwmmYPj2jbzuIOzmKMKV3M
 K90+1Haoz8kSjcBw9Skz/dCwId3C5XvlgC5dKNn2bjIqglKXmdVodB/hRiUSahh8uTsbBcK8Yn1
 fXqKh2+bvjclYBZbH3A==
X-Authority-Analysis: v=2.4 cv=eJ4jSnp1 c=1 sm=1 tr=0 ts=69e24846 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=A1X0JdhQAAAA:8 a=I-RPsLozhxZaecLjI5IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: pdusM19ipjNRS3F7N0CRhIq4iFcc2b1e
X-Proofpoint-ORIG-GUID: pdusM19ipjNRS3F7N0CRhIq4iFcc2b1e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604170149
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jhkim@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/16/2026 9:54 AM, Markus Armbruster wrote:
> Jaehoon Kim <jhkim@linux.ibm.com> writes:
>
>> Introduce a configurable poll-weight parameter for adaptive polling
>> in IOThread. This parameter replaces the hardcoded POLL_WEIGHT_SHIFT
>> constant, allowing runtime control over how much the most recent
>> event interval affects the next polling duration calculation.
>>
>> The poll-weight parameter uses a shift value where larger values
>> decrease the weight of the current interval, enabling more gradual
>> adjustments. When set to 0, a default value of 3 is used (meaning
>> the current interval contributes approximately 1/8 to the weighted
>> average).
>>
>> This patch also removes the hardcoded default values for poll-grow
>> and poll-shrink parameters from the grow_polling_time() and
>> shrink_polling_time() functions, as these defaults are now properly
>> initialized in iothread.c during IOThread creation.
>>
>> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> [...]
>
>> diff --git a/qapi/misc.json b/qapi/misc.json
>> index 28c641fe2f..554b0c5717 100644
>> --- a/qapi/misc.json
>> +++ b/qapi/misc.json
>> @@ -85,6 +85,12 @@
> Note: this is IOThreadInfo, used only as return value of
> query-iothreads.
>
>>   # @poll-shrink: how many ns will be removed from polling time, 0 means
>>   #     that it's not configured (since 2.9)
>>   #
>> +# @poll-weight: the weight factor for adaptive polling.
>> +#     Determines how much the current event interval contributes to
>> +#     the next polling time calculation.  Valid values are 1 or
>> +#     greater.  0 selects the system default value which is currently
>> +#     3 (since 11.1)
> As far as I can tell, query-iothreads never returns "poll-weight": 0.
> So, scratch the last sentence.

Thank you for your feedback.

I will remove the sentence about 0 selecting the default and update it
as follows:

# @poll-weight: the effective weight factor for adaptive polling.
# Determines how much the current event interval contributes to
# the next polling time calculation. (since 11.1)

>
>> +#
>>   # @aio-max-batch: maximum number of requests in a batch for the AIO
>>   #     engine, 0 means that the engine will use its default (since 6.1)
>>   #
>> @@ -96,6 +102,7 @@
>>              'poll-max-ns': 'int',
>>              'poll-grow': 'int',
>>              'poll-shrink': 'int',
>> +           'poll-weight': 'int',
>>              'aio-max-batch': 'int' } }
>>   
>>   ##
>> diff --git a/qapi/qom.json b/qapi/qom.json
>> index c653248f85..dd45ac1087 100644
>> --- a/qapi/qom.json
>> +++ b/qapi/qom.json
>> @@ -606,6 +606,13 @@
>>   #     algorithm detects it is spending too long polling without
>>   #     encountering events.  0 selects a default behaviour (default: 0)
>>   #
>> +# @poll-weight: the weight factor for adaptive polling.  Determines
>> +#     how much the most recent event interval affects the next
>> +#     polling duration calculation.  If set to 0, the system default
>> +#     value of 3 is used.  Typical values: 1 (high weight on recent
>> +#     interval), 2-4 (moderate weight on recent interval).
>> +#     (default: 0) (since 11.1)
>> +#
>>   # The @aio-max-batch option is available since 6.1.
>>   #
>>   # Since: 2.0
>> @@ -614,7 +621,8 @@
>>     'base': 'EventLoopBaseProperties',
>>     'data': { '*poll-max-ns': 'int',
>>               '*poll-grow': 'int',
>> -            '*poll-shrink': 'int' } }
>> +            '*poll-shrink': 'int',
>> +            '*poll-weight': 'int' } }
>>   
>>   ##
>>   # @MainLoopProperties:
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index 69e5a874c1..8ddf6c8d36 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -6413,7 +6413,7 @@ SRST
>>   
>>               CN=laptop.example.com,O=Example Home,L=London,ST=London,C=GB
>>   
>> -    ``-object iothread,id=id,poll-max-ns=poll-max-ns,poll-grow=poll-grow,poll-shrink=poll-shrink,aio-max-batch=aio-max-batch``
>> +    ``-object iothread,id=id,poll-max-ns=poll-max-ns,poll-grow=poll-grow,poll-shrink=poll-shrink,poll-weight=poll-weight,aio-max-batch=aio-max-batch``
>>           Creates a dedicated event loop thread that devices can be
>>           assigned to. This is known as an IOThread. By default device
>>           emulation happens in vCPU threads or the main event loop thread.
>> @@ -6449,6 +6449,11 @@ SRST
>>           the polling time when the algorithm detects it is spending too
>>           long polling without encountering events.
>>   
>> +        The ``poll-weight`` parameter is the weight factor used in the
>> +        adaptive polling algorithm. It determines how much the most
>> +        recent event interval affects the calculation of the next
>> +        polling duration.
> This is now less detailed than the version in qom.json.  Care to add the
> details here, too?

I will update it to match qom.json in the next version.

>> +
>>           The ``aio-max-batch`` parameter is the maximum number of requests
>>           in a batch for the AIO engine, 0 means that the engine will use
>>           its default.
> [...]
>



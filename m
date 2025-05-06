Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDAEBC3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 12:17:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCHDz-0004ts-Iy; Tue, 06 May 2025 08:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1uCHDv-0004t5-4j; Tue, 06 May 2025 08:16:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1uCHDq-0007Sq-RB; Tue, 06 May 2025 08:16:34 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5465gOEe005962;
 Tue, 6 May 2025 12:16:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=sOe2hu
 JTmClTss0eflU/Rm7TkYQCqL3fzneyJcvCJNc=; b=AREoE96N2nUxwSNv1RsN8f
 l+c35t8FnQDsGwmNkBf/TzPPU9mYqyq5tNyHJa6zrm2dKjDEFHfPacFqJmzaTjTf
 wdwG4TssPCcVgjLh7l5b3RwOzmrTxD+3wPZupszXyFNfA/rVmV61hiZhH9qH7epP
 0ybdcQE5L4c+Z7jY7jtn4VHA0RnfIzIpVveGwRPU1n5pWn34YI0/XY38Ubvgx47o
 VFtxqL5z2aQ4dKFGcbMqGJ3CajgpqSkbtUfooHLb/6GHA+ikFLw6nFBhu6kLcKr9
 V6UVZTewK2qOBp0E0pyqfYq9KjrzaPEsDwgN7eFROB+PNrv3T1k9TWolKanQhODA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46fcgy1k30-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 May 2025 12:16:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5469LU4R032220;
 Tue, 6 May 2025 12:16:20 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46dxymk82s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 May 2025 12:16:20 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 546CGJjJ11993620
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 May 2025 12:16:19 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 24F7D58045;
 Tue,  6 May 2025 12:16:19 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 72D9058050;
 Tue,  6 May 2025 12:16:18 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 May 2025 12:16:18 +0000 (GMT)
MIME-Version: 1.0
Date: Tue, 06 May 2025 14:16:18 +0200
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Nina Schoetterl-Glausch <nsg@linux.ibm.com>, qemu-s390x mailing list
 <qemu-s390x@nongnu.org>, Daniel Berrange <berrange@redhat.com>, qemu-devel
 mailing list <qemu-devel@nongnu.org>, "<Shalini Chellathurai Saroja"
 <shalini@linux.ibm.com>
Subject: Re: [PATCH v4 1/4] hw/s390x: add SCLP event type CPI
In-Reply-To: <5077ebbe-5a4d-4db5-8a1d-067d88244bfb@redhat.com>
References: <ad66ac925ff301a945ac1f56fc1d31cc@linux.ibm.com>
 <db6dbf5b1baf3a6ada04168ecf9fde24890cc1c1.camel@linux.ibm.com>
 <5077ebbe-5a4d-4db5-8a1d-067d88244bfb@redhat.com>
Message-ID: <2d53cf272ae58736b7904c9a86a2a1ce@linux.ibm.com>
X-Sender: shalini@linux.ibm.com
Organization: IBM Deutschland Research & Development GmbH
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZY4hoNX8Ec8xnrM9v6RmzbmVhUPw_4Ts
X-Authority-Analysis: v=2.4 cv=Pa7/hjhd c=1 sm=1 tr=0 ts=6819fd95 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=XNCndNwiZuGsV_ZKw0UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ZY4hoNX8Ec8xnrM9v6RmzbmVhUPw_4Ts
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDExNiBTYWx0ZWRfXy2iGBPnpTE5U
 3QX/vw8flPQy5JI8qzSSckX+pYKMAZ8rS3PuLoIr19lHkDGAXrk0QPfr4tirwxeyfUgfaCCvc6K
 XwJ37MO73gWWub8P7ZiY9+zboQfa23shJCJbUSql48Xqg8qUv6LwvoXA4MSzbMCjHEZtzVEPVnU
 pEiEJpkKNPEo1fta4Mo2PCxKptlZiuZcf1BThoNpM4k7cRCmNyBuy33pV0ZrfT9sg/heBEXCyal
 sGIttsXq4ecewOGvcfBf/qEIB6F3p3x+aiW3q2ACZQuDRvsTo5XmDfS7z/Hg6mkyqvgWw2PE4++
 Z8lG1wZZxkVkj57apLpChQ10PXD2MUUh64km4YjJjZqa4lJdcvFyE0ApQDbhSGLcM1KQamzP0ct
 OqGpx7YLw8Rtl3ym7ko1mhujmx6LmFL9rUJlr2BG2wDWeYxmFmrPV6+1uxiXPIHppEULEv3q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_05,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505060116
Received-SPF: pass client-ip=148.163.158.5; envelope-from=shalini@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2025-05-06 09:48, Thomas Huth wrote:
> On 06/05/2025 08.48, Nina Schoetterl-Glausch wrote:
>> On Mon, 2025-05-05 at 08:55 +0200, Shalini Chellathurai Saroja wrote:
>>> On 2025-04-28 11:22, Janis Schoetterl-Glausch wrote:
>>>> On Thu, 2025-04-10 at 17:09 +0200, Shalini Chellathurai Saroja 
>>>> wrote:
>>>>> Implement the Service-Call Logical Processor (SCLP) event
>>>>> type Control-Program Identification (CPI) in QEMU. This
>>>>> event is used to send CPI identifiers from the guest to the
>>>>> host. The CPI identifiers are: system type, system name,
>>>>> system level and sysplex name.
>>>>> 
>>>>> System type: operating system of the guest (e.g. "LINUX").
>>>>> System name: user configurable name of the guest (e.g. "TESTVM").
>>>>> System level: distribution and kernel version, if the system type 
>>>>> is
>>>>> Linux
>>>>> (e.g. 0x50e00).
>>>>> Sysplex name: name of the cluster which the guest belongs to (if 
>>>>> any)
>>>>> (e.g. "PLEX").
>>>>> 
>>>>> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
>>>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>>>> ---
>>>>>   hw/s390x/event-facility.c         |  2 +
>>>>>   hw/s390x/meson.build              |  1 +
>>>>>   hw/s390x/s390-virtio-ccw.c        | 14 +++++
>>>>>   hw/s390x/sclpcpi.c                | 92
>>>>> +++++++++++++++++++++++++++++++
>>>>>   include/hw/s390x/event-facility.h | 13 +++++
>>>>>   5 files changed, 122 insertions(+)
>>>>>   create mode 100644 hw/s390x/sclpcpi.c
>>>>> 
>>>>> diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
>>>>> index 2b0332c20e..60237b8581 100644
>>>>> --- a/hw/s390x/event-facility.c
>>>>> +++ b/hw/s390x/event-facility.c
>> 
>> [...]
>> 
>>> It is possible to add the identifiers directly as the properties of
>>> sclpcpi (eg. system type as shown below) and remove the
>>> control-program-id.
>> 
>> This is what I meant, drop it from qom.

Ok.

>>> 
>>> virsh # qemu-monitor-command vm --pretty
>>> '{"execute":"qom-list","arguments": {"path":
>>> "/machine/sclp/s390-sclp-event-facility/sclpcpi"}}'
>>> {
>>>     "return": [
>>>       {
>>>         "name": "type",
>>>         "type": "string"
>>>       },
>>>       {
>>>         "name": "parent_bus",
>>>         "type": "link<bus>"
>>>       },
>>>       {
>>>         "name": "realized",
>>>         "type": "bool"
>>>       },
>>>       {
>>>         "name": "hotplugged",
>>>         "type": "bool"
>>>       },
>>>       {
>>>         "name": "hotpluggable",
>>>         "type": "bool"
>>>       },
>>>       {
>>>         "name": "system_type",
>>>         "type": "string"
>>>       },
>>>       {
>>>         "name": "control-program-id",
>>>         "type": "S390ControlProgramId"
>>>       }
>>>     ],
>>>     "id": "libvirt-16"
>>> }
>>> 
>>> virsh # qemu-monitor-command vm --pretty '{"execute":"qom-get",
>>> "arguments":{"path":"/machine/sclp/s390-sclp-event-facility/sclpcpi",
>>> "property":"system_type"}}'
>>> {
>>>     "return": "LINUX   ",
>>>     "id": "libvirt-17"
>>> }
>>> 
>>> However, Hendrik Brückner suggested to group the identifiers together
>>> during the initial discussion of this line item. So, I would prefer 
>>> to
>> 
>> They are grouped together under "sclpcpi", no?

Yes.

>> 
>>> leave this as it is. Please let me know if you still think otherwise.
>> 
>> I don't have a strong opinion on this, just wanted to mention it and 
>> see what other people say.
> 
> I guess it mostly depends on whether there are future plans for using
> the QOM type elsewhere. If this type is supposed to be used in other
> QAPI calls in the future, it makes sense to keep it separate now. If
> there are no such plans, it's maybe easier to integrate the values
> into sclpcpi directly. Hendrik, any opinion from your side?
> 
>  Thomas

Hello Hendrik,

I have provided the output of both the options below. Please let me know 
which option do you prefer.

I have incorporated the other comments. So I will be able to send V5 
after your response. Thank you very much!

Option 1: Control-program identifiers set as the properties of sclpcpi:

virsh # qemu-monitor-command vm --pretty 
'{"execute":"qom-list","arguments": {"path": 
"/machine/sclp/s390-sclp-event-facility/sclpcpi"}}'
{
   "return": [
     {
[...]
     },
     {
       "name": "system_level",
       "type": "uint64"
     },
     {
       "name": "system_name",
       "type": "string"
     },
     {
       "name": "system_type",
       "type": "string"
     },
     {
       "name": "timestamp",
       "type": "uint64"
     },
     {
       "name": "sysplex_name",
       "type": "string"
     }
   ],
   "id": "libvirt-14"
}

virsh # qemu-monitor-command vm --pretty '{"execute":"qom-get", 
"arguments":{"path":"/machine/sclp/s390-sclp-event-facility/sclpcpi", 
"property":"system_type"}}'
{
   "return": "LINUX   ",
   "id": "libvirt-18"
}
virsh # qemu-monitor-command vm --pretty '{"execute":"qom-get", 
"arguments":{"path":"/machine/sclp/s390-sclp-event-facility/sclpcpi", 
"property":"system_name"}}'
{
   "return": "TESTVM  ",
   "id": "libvirt-19"
}
virsh # qemu-monitor-command vm --pretty '{"execute":"qom-get", 
"arguments":{"path":"/machine/sclp/s390-sclp-event-facility/sclpcpi", 
"property":"sysplex_name"}}'
{
   "return": "PLEX    ",
   "id": "libvirt-20"
}
virsh # qemu-monitor-command vm --pretty '{"execute":"qom-get", 
"arguments":{"path":"/machine/sclp/s390-sclp-event-facility/sclpcpi", 
"property":"system_level"}}'
{
   "return": 74872343805430528,
   "id": "libvirt-21"
}


Option 2: control-program-id of type S390ControlProgramId set as a 
property of sclpcpi:

virsh # qemu-monitor-command vm --pretty 
'{"execute":"qom-list","arguments": {"path": 
"/machine/sclp/s390-sclp-event-facility/sclpcpi"}}'
{
   "return": [
     {
[...]
     },
     {
       "name": "control-program-id",
       "type": "S390ControlProgramId"
     }
   ],
   "id": "libvirt-14"
}

virsh # qemu-monitor-command vm --pretty '{"execute":"qom-get", 
"arguments":{"path":"/machine/sclp/s390-sclp-event-facility/sclpcpi", 
"property":"control-program-id"}}'
{
   "return": {
     "timestamp": 1746532735581612000,
     "system-level": 74872343805430528,
     "sysplex-name": "PLEX    ",
     "system-name": "TESTVM  ",
     "system-type": "LINUX   "
   },
   "id": "libvirt-22"
}



-- 
Mit freundlichen Grüßen / Kind regards
Shalini Chellathurai Saroja
Software Developer
Linux on IBM Z & KVM Development
IBM Deutschland Research & Development GmbH
Dept 1419, Schoenaicher Str. 220, 71032 Boeblingen
Vorsitzender des Aufsichtsrats: Wolfgang Wendt
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht 
Stuttgart, HRB 243294


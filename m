Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0807CC71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 07:22:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR4Ac-00068R-VZ; Mon, 16 Jun 2025 03:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1uR49r-00061E-6r; Mon, 16 Jun 2025 03:21:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1uR49o-0001mk-VT; Mon, 16 Jun 2025 03:21:30 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55FCbmrS027464;
 Mon, 16 Jun 2025 07:21:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=8ix9jQ
 zeyJmyz+wsJEnfXVjbGTG4maSx8ditjjBUxbA=; b=DH7++1rHl0XS9eYBymbp9k
 ai2THhHX+YLd7q4XE7jhNqIvYBTUbH9KvBy0e5B1ARnzGrg15FNy0Sq64WBox+f/
 WW/LD5rPBmrncl2155sopCDieewVG2WGn4kex3QiB42rne2t8GaXfG+Gob0FTWf/
 q7TYTAs23Yu4YKgG5ANhQYaWXst4VhEOd1hF3tWCoqfSseQSG3xihbypo6bomikl
 YIGizH79kD7YWAh7fpzI34Qyg+GMWd/PFUNO+UzMOKONSHm76Dn642aHK8RGbfkm
 lL4MweEeGoDu0Q1Ma5kqbwLkaC+nWLs9lbDDxO09e74qP1hlM5+D9ZEfZysL6FvQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4794qnyaba-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Jun 2025 07:21:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55G4fHxr025786;
 Mon, 16 Jun 2025 07:21:25 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 479xy5k47r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Jun 2025 07:21:25 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55G7LOCH22807172
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Jun 2025 07:21:24 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 53AB658061;
 Mon, 16 Jun 2025 07:21:24 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BA02958058;
 Mon, 16 Jun 2025 07:21:23 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 16 Jun 2025 07:21:23 +0000 (GMT)
MIME-Version: 1.0
Date: Mon, 16 Jun 2025 09:21:23 +0200
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Nina Schoetterl-Glausch <nsg@linux.ibm.com>, qemu-s390x mailing list
 <qemu-s390x@nongnu.org>, Daniel Berrange <berrange@redhat.com>, qemu-devel
 mailing list <qemu-devel@nongnu.org>, Hendrik Brueckner
 <brueckner@linux.ibm.com>
Subject: Re: [PATCH v5 2/3] hw/s390x: add Control-Program Identification to QOM
In-Reply-To: <00c7e7f0-1c94-4f6f-aa08-5e557bbb91aa@redhat.com>
References: <20250603135655.595602-1-shalini@linux.ibm.com>
 <20250603135655.595602-3-shalini@linux.ibm.com>
 <9bf3dbd97aea3e8811e3064c4f1f79ab3ba65ecd.camel@linux.ibm.com>
 <581bb44f-6549-44cc-9466-ef4172fe6ddc@redhat.com>
 <00c7e7f0-1c94-4f6f-aa08-5e557bbb91aa@redhat.com>
Message-ID: <487113e06568d2241bf89156a5dfb551@linux.ibm.com>
X-Sender: shalini@linux.ibm.com
Organization: IBM Deutschland Research & Development GmbH
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vPN_mTw4blgoLUuU-wGSefGV3PdJRPvi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDA0NyBTYWx0ZWRfX/nNi1vlmp9mV
 5Igxc69dcdN1OjXcWdH9Nx153rz3jdadfDAhjb878vJfuJdcODhLD9sYUo+wrGtr5b/6Sp3GkOh
 TkiF+j4PJWVy3J7t8DyKuZx/XDAU8LNwYsnpZfmnf0KWnW54wDRPObyC92rR5TuKge+HM+e5Eem
 NNWwy4DNGST+GbVrQ3KT/5fuBiXN6ARp1lyj4uiCgi8tTqeblbY1/JlKczVMELHVfVPUhC9wLQy
 MDBzfsm604JpLVemgiSt77niWzh7oY6T7xWOK6yMFCRT3b0Sjw+DeVcxLwTjoWZTYjRluzDOAaN
 paywcNgOmqol7FUid2hG3l/OHHYbUsQcllGCrqh6B3O2jFBg0BTHG3npt5tFWIftvv9xMLHPXPo
 vPHlJIq3KrLK8KkC7VqRlSehATDF9QGvqv9QTggvmZkMpU99vTPz94dhpMY8AodLJj4SSO1t
X-Authority-Analysis: v=2.4 cv=NYfm13D4 c=1 sm=1 tr=0 ts=684fc5f6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=ZiMIAIO6AAAA:8
 a=VnNF1IyMAAAA:8 a=MImhHGiYTA2aps24SKwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=KohFQSMcaiS2QNUyYz07:22
X-Proofpoint-ORIG-GUID: vPN_mTw4blgoLUuU-wGSefGV3PdJRPvi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_03,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506160047
Received-SPF: pass client-ip=148.163.158.5; envelope-from=shalini@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On 2025-06-05 14:03, Thomas Huth wrote:
> On 05/06/2025 13.56, Thomas Huth wrote:
>> On 05/06/2025 10.34, Nina Schoetterl-Glausch wrote:
>>> On Tue, 2025-06-03 at 15:56 +0200, Shalini Chellathurai Saroja wrote:
>>>> Add Control-Program Identification (CPI) data to the QEMU Object
>>>> Model (QOM), along with the timestamp in which the data was received
>>>> as shown below.
>>> 
>>> [...]
>>>> 
>>>> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
>>>> ---
>>>>   hw/s390x/sclpcpi.c                | 47 +++++++++++++++++++++++++
>>>>   include/hw/s390x/event-facility.h |  5 +++
>>>>   qapi/machine.json                 | 58 
>>>> +++++++++++++++++++++++++++++++
>>>>   3 files changed, 110 insertions(+)
>>>> 
>>>> diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
>>>> index 935fa87acd..ec711e2291 100644
>>>> --- a/hw/s390x/sclpcpi.c
>>>> +++ b/hw/s390x/sclpcpi.c
>>>> @@ -15,7 +15,9 @@
>>>>     */
>>> 
>>> [...]
>>>> +static void cpi_init(Object *obj)
>>>> +{
>>>> +    SCLPEventCPI *e = SCLP_EVENT_CPI(obj);
>>>> +
>>>> +    object_property_add_str(obj, "system_type", get_system_type, 
>>>> NULL);
>>>> +    object_property_add_str(obj, "system_name", get_system_name, 
>>>> NULL);
>>>> +    object_property_add_str(obj, "sysplex_name", get_sysplex_name, 
>>>> NULL);
>>>> +    object_property_add_uint64_ptr(obj, "system_level", 
>>>> &(e->system_level),
>>>> +                                   OBJ_PROP_FLAG_READ);
>>>> +    object_property_add_uint64_ptr(obj, "timestamp", 
>>>> &(e->timestamp),
>>>> +                                   OBJ_PROP_FLAG_READ);
>>>> +}
>>> 
>>> I think it would be cleaner if those were class properties.
>>> You could use object_class_property_add_str in cpi_class_init,
>>> but I think it'd be nice to use DEFINE_PROP_(STR|UINT64) and
>>> device_class_set_props.
>> 
>> For "normal" properties I'd say "yes" ... but in this case, this would 
>> also allow the user to set the properties from the host side - which 
>> would be a little bit weird? So I think it might be cleaner to keep it 
>> this way here without the "setter" functions? WDYT?
> 
> By the way, Shalini, could you please add a description of the
> properties via object_property_set_description() here, please?
> 
>  Thanks,
>   Thomas
> 

Hello Thomas,
I will add description for the properties via 
object_class_property_set_description(),
as I will be using object_class_property_add_str and 
object_class_property_add methods
based on Nina's feedback and Markus's summary on properties which you 
pointed out.

Thank you very much.

> PS: FWIW, Markus recently also provided a nice summery about the
> different property types here:
>  https://lore.kernel.org/qemu-devel/87o6vfzdig.fsf@pond.sub.org/

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


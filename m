Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 739AAC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 12:23:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqAFt-0003UW-Mo; Thu, 06 Mar 2025 07:23:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@imap.linux.ibm.com>)
 id 1tqAFr-0003UH-M8; Thu, 06 Mar 2025 07:23:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@imap.linux.ibm.com>)
 id 1tqAFp-0004Ts-Bj; Thu, 06 Mar 2025 07:23:11 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5263kBLD023805;
 Thu, 6 Mar 2025 12:23:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=w2tiYE
 GDAv8ZvsIcs5Z1s39WS70wAlmrWRpFj2oeVFo=; b=h9FBodQwTJ9m3t/c/ZO1Gp
 z1+Odtr6ZEjApTMlxyjUf8urviMLyWG2XDwUET5Tgoi4cAw/AgOeq8yQMAvyz0MW
 Gdx6O24l/flQl06I1uznBXbTkF+u9He3UYW4Wjc/BLBtub5PraT7WrKIVujQktMd
 w0qbC1xutC69TJkuRI1ziSXp5J0MkYFGQzeJJkthFIPB38taTKvUjhDmWwYSSf6z
 7zY4mhftgBjOyiPE6KtBtX5DyV71S9rbysf0jYZO47nXTrAv5jbnRytGW2dvmrnU
 BQjUyyjUnHvXfhONI3h1YH837FCQFthdVqF/dGjifocxu9UF7/O3/0bMfB4dVtEQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45743929ru-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Mar 2025 12:23:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 526CC4jp008934;
 Thu, 6 Mar 2025 12:23:05 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454cxyrrr5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Mar 2025 12:23:05 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 526CN4uu21496538
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 6 Mar 2025 12:23:04 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1FE1B58061;
 Thu,  6 Mar 2025 12:23:04 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 92D8658059;
 Thu,  6 Mar 2025 12:23:03 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  6 Mar 2025 12:23:03 +0000 (GMT)
MIME-Version: 1.0
Date: Thu, 06 Mar 2025 13:23:03 +0100
From: shalini <shalini@imap.linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Shalini Chellathurai Saroja <shalini@linux.ibm.com>, qemu-s390x mailing
 list <qemu-s390x@nongnu.org>, qemu-devel mailing list
 <qemu-devel@nongnu.org>, Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: Re: [PATCH qemu v2 1/3] hw/s390x: add CPI identifiers to QOM
In-Reply-To: <48caabe7-c112-4454-96a8-742d154c77ee@redhat.com>
References: <20250224120449.1764114-1-shalini@linux.ibm.com>
 <48caabe7-c112-4454-96a8-742d154c77ee@redhat.com>
Message-ID: <78b6c548212517ef8620fce0c6832e4f@imap.linux.ibm.com>
X-Sender: shalini@imap.linux.ibm.com
Organization: IBM Deutschland Research & Development GmbH
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hVTR2yhlcGAh1IM4sJ2OdOnoUI_tclOJ
X-Proofpoint-ORIG-GUID: hVTR2yhlcGAh1IM4sJ2OdOnoUI_tclOJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1034 mlxscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503060090
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=shalini@imap.linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_ADSP_NXDOMAIN=0.9,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NO_DNS_FOR_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On 2025-03-05 16:56, Thomas Huth wrote:
> On 24/02/2025 13.04, Shalini Chellathurai Saroja wrote:
>> Add Control-Program Identification (CPI) to the QEMU Object
>> Model (QOM). The CPI identifiers provide information about
>> the guest operating system. The CPI identifiers are:
>> system type, system name, system level and sysplex name.
>> 
>> The system type provides the OS type of the guest (e.g. LINUX).
>> The system name provides the name of the guest (e.g. TESTVM).
>> The system level provides the distribution and kernel version
>> of the guest OS (e.g. 0x50e00).
>> The sysplex name provides the sysplex name of the guest
>> (e.g. SYSPLEX).
>> 
>> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
>> ---
>>   hw/s390x/s390-virtio-ccw.c         | 29 
>> +++++++++++++++++++++++++++++
>>   include/hw/s390x/s390-virtio-ccw.h |  8 ++++++++
>>   qapi/machine.json                  | 24 ++++++++++++++++++++++++
>>   3 files changed, 61 insertions(+)
>> 
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index 51ae0c133d..13ea8db1b0 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -50,6 +50,7 @@
>>   #include "hw/s390x/virtio-ccw-md.h"
>>   #include "system/replay.h"
>>   #include CONFIG_DEVICES
>> +#include "qapi/qapi-visit-machine.h"
>>     static Error *pv_mig_blocker;
>>   @@ -803,6 +804,26 @@ static void machine_set_loadparm(Object *obj, 
>> Visitor *v,
>>       s390_ipl_fmt_loadparm(ms->loadparm, val, errp);
>>   }
>>   +static void machine_get_control_program_id(Object *obj, Visitor *v,
>> +                                           const char *name, void 
>> *opaque,
>> +                                           Error **errp)
>> +{
>> +    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
>> +    S390ControlProgramId *cpi;
>> +    cpi = &(S390ControlProgramId){
>> +        .system_type = g_strndup((char *) ms->cpi.system_type,
>> +                       sizeof(ms->cpi.system_type)),
>> +        .system_name = g_strndup((char *) ms->cpi.system_name,
>> +                       sizeof(ms->cpi.system_name)),
>> +        .system_level = g_strdup_printf("0x%lx", 
>> ms->cpi.system_level),
>> +        .sysplex_name = g_strndup((char *) ms->cpi.sysplex_name,
>> +                        sizeof(ms->cpi.sysplex_name)),
>> +        .timestamp = ms->cpi.timestamp
>> +    };
> 
> Could you please indend the sizeof() lines with the "(" after the
> g_strndup in the previous line?
> 

Hello Thomas,

Sure, I have provided a sample code below, please let me know if this is 
incorrect. Thank you.

>> +    cpi = &(S390ControlProgramId){
>> +        .system_type = g_strndup((char *) ms->cpi.system_type,
>> +                                 sizeof(ms->cpi.system_type)),


>> +
>> +    visit_type_S390ControlProgramId(v, name, &cpi, &error_abort);
>> +}
>> +
>>   static void ccw_machine_class_init(ObjectClass *oc, void *data)
>>   {
>>       MachineClass *mc = MACHINE_CLASS(oc);
>> @@ -854,6 +875,14 @@ static void ccw_machine_class_init(ObjectClass 
>> *oc, void *data)
>>               "Up to 8 chars in set of [A-Za-z0-9. ] (lower case chars 
>> converted"
>>               " to upper case) to pass to machine loader, boot 
>> manager,"
>>               " and guest kernel");
>> +    object_class_property_add(oc, "s390-control-program-id",
> 
> I think I'd rather drop the "s390-" prefix here. The property is
> already part of the s390-virtio-ccw machine, so it should be obvious
> that this is related to s390.
ok.

> 
>> +                              "S390ControlProgramId",
>> +                              machine_get_control_program_id,
>> +                              NULL, NULL, NULL);
>> +    object_class_property_set_description(oc, 
>> "s390-control-program-id",
>> +        "Control-progam identifiers provide data about the guest "
> 
> s/progam/program/
> 
ok.

>> +        "operating system");
>> +
>>   }
>>     static inline void s390_machine_initfn(Object *obj)

[...]

>> diff --git a/qapi/machine.json b/qapi/machine.json
>> index a6b8795b09..c6cbad87e1 100644
>> --- a/qapi/machine.json
>> +++ b/qapi/machine.json
>> @@ -1898,3 +1898,27 @@
>>   { 'command': 'x-query-interrupt-controllers',
>>     'returns': 'HumanReadableText',
>>     'features': [ 'unstable' ]}
>> +
>> +##
>> +# @S390ControlProgramId:
>> +#
>> +# Control-program identifiers provide data about Linux instance.
> 
> If I understood correctly, this could also theoretically be used by
> other guest operating systems? If so, please replace "Linux instance"
> with "guest operating system".
> 

Yes, that is correct. I will change the description of the attributes 
below based on the comments from you and Daniel, thank you.

>> +#
>> +# @system-type: operating system of Linux instance
> 
> Replace with:
> 
>  @system-type: operating system (e.g. "LINUX")
> 
> ?
> 
>> +#
>> +# @system-name: system name of Linux instance
> 
> Name of the VM instance ?
> 
>> +# @system-level: distribution and kernel version of Linux instance
>> +#
>> +# @sysplex-name: sysplex name of Linux instance
>> +#
>> +# @timestamp: latest update of CPI data
>> +#
>> +# Since: 9.2
> 
> 9.2 has already been released, so this should be 10.0.
> 

ok.

>> +##
>> +{ 'struct': 'S390ControlProgramId', 'data': {
>> +     'system-type': 'str',
>> +     'system-name': 'str',
>> +     'system-level': 'str',
> 
> Not sure, but would it make sense to use a number for the system-level
> instead? At least it's a number in ControlProgramId, not a string.
> 

The system-level, when interpreted as an int provides the output below

'system-level': 74872343805430528

But the desired output below is obtained only when interpreted as a str. 
please refer 
https://www.ibm.com/docs/en/linux-on-systems?topic=identification-system-level 
for details on system-level. I will also document this in the 
description of system-level as suggested by Daniel. Thank you.

'system-level': '0x10a000000060b00'

>  Thomas
> 
> 
>> +     'sysplex-name': 'str',
>> +     'timestamp': 'uint64' } }

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


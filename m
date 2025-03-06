Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA8F0C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 14:10:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqBvS-0004dJ-4a; Thu, 06 Mar 2025 09:10:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@imap.linux.ibm.com>)
 id 1tqBvQ-0004ag-1n; Thu, 06 Mar 2025 09:10:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@imap.linux.ibm.com>)
 id 1tqBvN-000169-Pz; Thu, 06 Mar 2025 09:10:11 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5268tg5U000310;
 Thu, 6 Mar 2025 14:10:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=1EshM3
 rJLlgr6k0eD82ERMk7nyso4/KVbcjKHOuhDpw=; b=mJL0B6CeLzlXSxNCsQlmUy
 lIW9fLzUQBVFlPZg6qPL8om5GAzTBmwXz2eRhziJQRzo6M8D7VBf9hCmtK2iFbaY
 yuAtKqpSLcIdojgltSU4yFPqljQAYmpbA1Z8zbDYcqXD1Bbwzlg1oB7hGOxOwW++
 7Np5CZ+uBNd+qZaZKLT2TAonMXPzoa1qlBUltCJ0P6nEA8PLXZsJ/ntBo0J/6HjB
 nZvyU5YuU1Gescyx9EDN+0Qfwi0nWZ7sFlUUNK0dcKo2YE8dyjftHD1AT5k5TKor
 ScuwVzS918gASYDRnyTnzwpWhbz6bA3Ob04edxmDCGZSsHY4MjvsXVBXSqJhedRQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 456x15m75s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Mar 2025 14:10:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 526BY7pF008958;
 Thu, 6 Mar 2025 14:10:06 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454cxys7xb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Mar 2025 14:10:06 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 526EA5Zn57475436
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 6 Mar 2025 14:10:05 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E6D3D58064;
 Thu,  6 Mar 2025 14:10:04 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9A3EC58056;
 Thu,  6 Mar 2025 14:10:04 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  6 Mar 2025 14:10:04 +0000 (GMT)
MIME-Version: 1.0
Date: Thu, 06 Mar 2025 15:10:04 +0100
From: shalini <shalini@imap.linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Shalini Chellathurai Saroja <shalini@linux.ibm.com>, qemu-s390x mailing
 list <qemu-s390x@nongnu.org>, qemu-devel mailing list
 <qemu-devel@nongnu.org>, Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: Re: [PATCH qemu v2 3/3] hw/s390x: support migration of CPI values
In-Reply-To: <f19d3690-e8af-4ccb-a4da-20a87a48852c@redhat.com>
References: <20250224120449.1764114-1-shalini@linux.ibm.com>
 <20250224120449.1764114-3-shalini@linux.ibm.com>
 <f19d3690-e8af-4ccb-a4da-20a87a48852c@redhat.com>
Message-ID: <ac723d90e0536e42707420b0fc329a5c@imap.linux.ibm.com>
X-Sender: shalini@imap.linux.ibm.com
Organization: IBM Deutschland Research & Development GmbH
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KrXSH44gZvqxqairUOSDPx2yJoENiPJP
X-Proofpoint-ORIG-GUID: KrXSH44gZvqxqairUOSDPx2yJoENiPJP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 impostorscore=0
 clxscore=1034 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503060106
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=shalini@imap.linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 2025-03-05 19:33, Thomas Huth wrote:
> On 24/02/2025 13.04, Shalini Chellathurai Saroja wrote:
>> Register Control-Program Identification data with the live
>> migration infrastructure.
>> 
>> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
>> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
>> ---
>>   hw/s390x/s390-virtio-ccw.c | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>> 
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index 13ea8db1b0..4d0838d037 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -260,6 +260,20 @@ static void s390_create_sclpconsole(SCLPDevice 
>> *sclp,
>>       qdev_realize_and_unref(dev, ev_fac_bus, &error_fatal);
>>   }
>>   +static const VMStateDescription vmstate_control_program_id = {
>> +    .name = "s390_control_program_id",
>> +    .version_id = 0,
>> +    .minimum_version_id = 0,
>> +    .fields = (const VMStateField[]) {
>> +        VMSTATE_UINT8_ARRAY(system_type, ControlProgramId, 8),
>> +        VMSTATE_UINT8_ARRAY(system_name, ControlProgramId, 8),
>> +        VMSTATE_UINT64(system_level, ControlProgramId),
>> +        VMSTATE_UINT8_ARRAY(sysplex_name, ControlProgramId, 8),
>> +        VMSTATE_UINT64(timestamp, ControlProgramId),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>>   static void ccw_init(MachineState *machine)
>>   {
>>       MachineClass *mc = MACHINE_GET_CLASS(machine);
>> @@ -308,6 +322,9 @@ static void ccw_init(MachineState *machine)
>>       ret = css_create_css_image(VIRTUAL_CSSID, true);
>>       assert(ret == 0);
>>   +    /* register CPI values */
>> +    vmstate_register_any(NULL, &vmstate_control_program_id, 
>> &ms->cpi);
> 
>  Hi again,
> 
> after looking at this for a while, I think it might be cleaner to
> store the state in the TYPE_SCLP_CPI device instead of storing it in
> the machine state. Then you can also use dc->vmsd there instead of
> using the legacy vmstate_register_any() function.
> 

Hello Thomas,

The SCLP event type CPI is used to transfer the data mentioned below 
from guest operating system to QEMU. The job of the CPI event is 
complete, when this transfer is done.

The received data must be saved in the QEMU object model, so that it is 
possible for the user to retrieve the data via QMP. The received data 
provides information about the guest virtual machine.

System type - Operating system of the guest (eg: LINUX)
System name - Hostname provided to the guest (eg: TESTVM)
System level - Kernel version of the guest operating system (eg: 
0x50e00)
Sysplex name - Sysplex refers to a cluster of logical partitions  that 
communicates and co-operates with each other. Sysplex name is the name 
of the cluster which the guest belongs to(If any).(eg: PLEX)

In my perspective, I believe that the s390 machine state is appropriate 
for storing the data about the guest virtual machine. Please do let me 
know if you still want to change this?, thank you.

> Additionally, I think you need some compat handling for backward
> migration in your patches. E.g. have you tried migrating from an old
> version of QEMU to a newer one (that includes your patches) and then
> back to the old one?
> I think the TYPE_SCLP_CPI device should only be instantiated for the
> machine types >= 10.0, but not for the older machine types, e.g. by
> introducing a "use-cpi" property to the TYPE_SCLP_EVENT_FACILITY (set
> to true by default). Then in ccw_machine_9_2_class_options(), make
> sure that this property gets switched to "off" again, so that older
> machine types don't have the new TYPE_SCLP_CPI device. WDYT?
> 

I will answer this shortly. Thank you.

>  Thomas

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


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 463ACC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 08:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqT7G-0007A0-6V; Fri, 07 Mar 2025 03:31:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1tqT76-00079e-RY; Fri, 07 Mar 2025 03:31:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1tqT74-0003xv-SE; Fri, 07 Mar 2025 03:31:24 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5276s1V7023081;
 Fri, 7 Mar 2025 08:31:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=qEHRgG
 GBSwto4+R736Zqb8VhUj4jy0lvTvxc1TvA4fM=; b=aO/aA3aBPSqoz3X1zPoj1F
 KBIqs5/ksXlbSUn+Mj/kZJoWrWfn8xmt2kVwNdh/gjl17y7MddvghHb+1pd3dnjI
 IdZJA7c03gyMtcnWTlKJ6Qzx8JwJYbTftSppBpCt/kRTrmXT4WLgb5ydqpz7mtcI
 JcrKInxY2x69nlnxotTLk1T1Uwf66mAjzmG/7XhJAiySySobCtK+AwuPtbLcD4kc
 m4MAhhfxVy5uhzgW5yzsMXuOC9G9J9/oqBo3KAxe5uKFsJbDTyifrK1tybFbZh7r
 uUR1+KSxrq8k/ZDR4JG6qJKpSk7uiRW6SkZwNnxRsD4yJx/ncf6EjFlcRn73TkKw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 457jvpamw3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Mar 2025 08:31:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5274mD7C032216;
 Fri, 7 Mar 2025 08:31:17 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 454cjtdxf9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Mar 2025 08:31:17 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5278VF2H46924282
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 7 Mar 2025 08:31:15 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F7EC58628;
 Fri,  7 Mar 2025 08:04:53 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8913258629;
 Fri,  7 Mar 2025 08:04:52 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  7 Mar 2025 08:04:52 +0000 (GMT)
MIME-Version: 1.0
Date: Fri, 07 Mar 2025 09:04:52 +0100
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x mailing list <qemu-s390x@nongnu.org>, qemu-devel mailing list
 <qemu-devel@nongnu.org>, Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>, "<Shalini Chellathurai Saroja"
 <shalini@linux.ibm.com>
Subject: Re: [PATCH qemu v2 3/3] hw/s390x: support migration of CPI values
In-Reply-To: <020b1851-1249-446f-844c-2bc598128446@redhat.com>
References: <20250224120449.1764114-1-shalini@linux.ibm.com>
 <20250224120449.1764114-3-shalini@linux.ibm.com>
 <f19d3690-e8af-4ccb-a4da-20a87a48852c@redhat.com>
 <ac723d90e0536e42707420b0fc329a5c@imap.linux.ibm.com>
 <020b1851-1249-446f-844c-2bc598128446@redhat.com>
Message-ID: <77054e690f8bb6ddf84bb869d00fe6e9@linux.ibm.com>
X-Sender: shalini@linux.ibm.com
Organization: IBM Deutschland Research & Development GmbH
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aOfwjjrtIsR3V1qdD6y2hNzyuJYaXiAy
X-Proofpoint-GUID: aOfwjjrtIsR3V1qdD6y2hNzyuJYaXiAy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_03,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 spamscore=0 suspectscore=0 malwarescore=0 clxscore=1015 adultscore=0
 mlxscore=0 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503070060
Received-SPF: pass client-ip=148.163.158.5; envelope-from=shalini@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2025-03-06 16:08, Thomas Huth wrote:
> On 06/03/2025 15.10, shalini wrote:
>> On 2025-03-05 19:33, Thomas Huth wrote:
>>> On 24/02/2025 13.04, Shalini Chellathurai Saroja wrote:
>>>> Register Control-Program Identification data with the live
>>>> migration infrastructure.
>>>> 
>>>> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
>>>> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
>>>> ---
>>>>   hw/s390x/s390-virtio-ccw.c | 17 +++++++++++++++++
>>>>   1 file changed, 17 insertions(+)
>>>> 
>>>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>>>> index 13ea8db1b0..4d0838d037 100644
>>>> --- a/hw/s390x/s390-virtio-ccw.c
>>>> +++ b/hw/s390x/s390-virtio-ccw.c
>>>> @@ -260,6 +260,20 @@ static void s390_create_sclpconsole(SCLPDevice 
>>>> *sclp,
>>>>       qdev_realize_and_unref(dev, ev_fac_bus, &error_fatal);
>>>>   }
>>>>   +static const VMStateDescription vmstate_control_program_id = {
>>>> +    .name = "s390_control_program_id",
>>>> +    .version_id = 0,
>>>> +    .minimum_version_id = 0,
>>>> +    .fields = (const VMStateField[]) {
>>>> +        VMSTATE_UINT8_ARRAY(system_type, ControlProgramId, 8),
>>>> +        VMSTATE_UINT8_ARRAY(system_name, ControlProgramId, 8),
>>>> +        VMSTATE_UINT64(system_level, ControlProgramId),
>>>> +        VMSTATE_UINT8_ARRAY(sysplex_name, ControlProgramId, 8),
>>>> +        VMSTATE_UINT64(timestamp, ControlProgramId),
>>>> +        VMSTATE_END_OF_LIST()
>>>> +    }
>>>> +};
>>>> +
>>>>   static void ccw_init(MachineState *machine)
>>>>   {
>>>>       MachineClass *mc = MACHINE_GET_CLASS(machine);
>>>> @@ -308,6 +322,9 @@ static void ccw_init(MachineState *machine)
>>>>       ret = css_create_css_image(VIRTUAL_CSSID, true);
>>>>       assert(ret == 0);
>>>>   +    /* register CPI values */
>>>> +    vmstate_register_any(NULL, &vmstate_control_program_id, 
>>>> &ms->cpi);
>>> 
>>>  Hi again,
>>> 
>>> after looking at this for a while, I think it might be cleaner to
>>> store the state in the TYPE_SCLP_CPI device instead of storing it in
>>> the machine state. Then you can also use dc->vmsd there instead of
>>> using the legacy vmstate_register_any() function.
>>> 
>> 
>> Hello Thomas,
>> 
>> The SCLP event type CPI is used to transfer the data mentioned below 
>> from guest operating system to QEMU. The job of the CPI event is 
>> complete, when this transfer is done.
>> 
>> The received data must be saved in the QEMU object model, so that it 
>> is possible for the user to retrieve the data via QMP. The received 
>> data provides information about the guest virtual machine.
>> 
>> System type - Operating system of the guest (eg: LINUX)
>> System name - Hostname provided to the guest (eg: TESTVM)
>> System level - Kernel version of the guest operating system (eg: 
>> 0x50e00)
>> Sysplex name - Sysplex refers to a cluster of logical partitions  that 
>> communicates and co-operates with each other. Sysplex name is the name 
>> of the cluster which the guest belongs to(If any).(eg: PLEX)
>> 
>> In my perspective, I believe that the s390 machine state is 
>> appropriate for storing the data about the guest virtual machine. 
>> Please do let me know if you still want to change this?, thank you.
> 
>  Hi Shalini,
> 
> yes, please change this patch to put the migration state into the
> SCLP_CPI device.
> 
> vmstate_register_any() is a legacy function, see its description in
> include/migration/vmstate.h ... so if anyhow possible, this should be
> avoided in new code.
> 
> You introduced a new device in patch 2 which will be handling the
> related data. Devices are the right place for storing migration data
> in new QEMU code, so I think this really should go into dc->vmsd of
> TYPE_SCLP_CPI.
> 
> For retrieving the information, the user should then just get the
> property from /machine/sclp/s390-sclp-event-facility/sclpcpi instead
> of /machine. This should be fine since it is a well-defined location,
> too.
> 

Good Morning Thomas,

Thank you very much for the explanation. I will change this.

>  Thanks!
>   Thomas

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


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BDAC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 15:29:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqZdQ-0007gz-T9; Fri, 07 Mar 2025 10:29:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1tqZdP-0007de-3u; Fri, 07 Mar 2025 10:29:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1tqZdN-0001qY-CD; Fri, 07 Mar 2025 10:29:10 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5278H94Y023090;
 Fri, 7 Mar 2025 15:29:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=cZ4Jld
 0Ad9R4vftsePQv1cyChyDqZ+iVn8sKtTxiPGo=; b=bIO6mZXjquuZpThPABbRpj
 PiW1MpMw30aHf+ftV46iCpUqjmguCp+L+DPoUOMgh1T9Y6vXcmpO6n/OpLCD7zvd
 TzzhYrWcqHPqO07TZzzXnU3kR5do1KuGR5scmkG8IfgY3kXHgTW//U9jhzlmsArI
 ZQneZ86RgbPmRybAC+rrmkJtG/X10pc1jpeoxPG5167zFV0tWdzv9iTmf22iY+Sy
 Os/lo8NNv3QzjY7NVYtD9YaAOJ6hqmM0unVNT3ue+k142HGef0NGJlMsFbZzppMH
 aqWDOZCdkhRj2fodhFRfy/MRsBBhIOyzIPERUdnq7a4YSB4nt5Ql+WvFQroS9HhA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 457jvpcpcc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Mar 2025 15:29:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 527DT2lc013743;
 Fri, 7 Mar 2025 15:29:06 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454e2m7ek3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Mar 2025 15:29:06 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 527FT5kY27918898
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 7 Mar 2025 15:29:05 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A227858056;
 Fri,  7 Mar 2025 15:29:05 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C63858052;
 Fri,  7 Mar 2025 15:29:05 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  7 Mar 2025 15:29:05 +0000 (GMT)
MIME-Version: 1.0
Date: Fri, 07 Mar 2025 16:29:05 +0100
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x mailing list <qemu-s390x@nongnu.org>, qemu-devel mailing list
 <qemu-devel@nongnu.org>, Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: Re: [PATCH qemu v2 3/3] hw/s390x: support migration of CPI values
In-Reply-To: <f19d3690-e8af-4ccb-a4da-20a87a48852c@redhat.com>
References: <20250224120449.1764114-1-shalini@linux.ibm.com>
 <20250224120449.1764114-3-shalini@linux.ibm.com>
 <f19d3690-e8af-4ccb-a4da-20a87a48852c@redhat.com>
Message-ID: <90d244afa7d4359bc9c26e9571df53da@linux.ibm.com>
X-Sender: shalini@linux.ibm.com
Organization: IBM Deutschland Research & Development GmbH
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: B3eS7lViUVXBoirbcGqP7fMirNNUYeEM
X-Proofpoint-GUID: B3eS7lViUVXBoirbcGqP7fMirNNUYeEM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_06,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 spamscore=0 suspectscore=0 malwarescore=0 clxscore=1015 adultscore=0
 mlxscore=0 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503070115
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
Hello Thomas,
That is correct. I will change this as per your suggestion. Thank you.

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


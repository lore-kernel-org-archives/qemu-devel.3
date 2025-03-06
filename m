Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6258C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 13:57:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqBjJ-0006v2-EY; Thu, 06 Mar 2025 08:57:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@imap.linux.ibm.com>)
 id 1tqBjG-0006uF-Oc; Thu, 06 Mar 2025 08:57:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@imap.linux.ibm.com>)
 id 1tqBjE-0007ln-7C; Thu, 06 Mar 2025 08:57:38 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526DWTiR023980;
 Thu, 6 Mar 2025 13:57:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=/hsIcq
 KLOEVBpQAGaPcPgqF7BrOUdEdxpLKytDl4ymg=; b=oCU6AH4A6wjMEK4jQz5tLc
 NqjYUrjl0iZweyFcxa+PRV6K/Vb1XXke4dfpZzcIc5ldoyZuIVWiJTd64PS4K/Bu
 b10m1Tk2KLuaokH014bI/65zSZEDXbdIxnXU2L6nDon4Voshy/ey+Ktr5Elq4550
 R6YgKJDhA7+mR27KdbS1DXREDvcgJpOTytU1p6esz4PC8zIRGsP/UipVwCBM9Nk/
 eiY+ZxY3V2JbJXtSvSS0vHyF9y9Vx2+mNDonupU2VBATAMUIBwxvBS0RsznuNF45
 ZwTQBcKKlhl4zp3dAsQbA9rCIEeldo6mWv2TurVWvXCAUIsqF4rAcXU4iYHStdCA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4574392sd5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Mar 2025 13:57:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 526AjewR025181;
 Thu, 6 Mar 2025 13:57:33 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 454f928k64-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Mar 2025 13:57:33 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 526DvWN725559670
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 6 Mar 2025 13:57:32 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 687C958063;
 Thu,  6 Mar 2025 13:57:32 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1D8785805D;
 Thu,  6 Mar 2025 13:57:32 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  6 Mar 2025 13:57:32 +0000 (GMT)
MIME-Version: 1.0
Date: Thu, 06 Mar 2025 14:57:31 +0100
From: shalini <shalini@imap.linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Shalini Chellathurai Saroja <shalini@linux.ibm.com>, qemu-s390x mailing
 list <qemu-s390x@nongnu.org>, qemu-devel mailing list
 <qemu-devel@nongnu.org>, Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: Re: [PATCH qemu v2 1/3] hw/s390x: add CPI identifiers to QOM
In-Reply-To: <6ddfe2ac-9d1f-446c-8ab4-9c14fdb46411@redhat.com>
References: <20250224120449.1764114-1-shalini@linux.ibm.com>
 <6ddfe2ac-9d1f-446c-8ab4-9c14fdb46411@redhat.com>
Message-ID: <e928d85f4a61af098aa175c75f143664@imap.linux.ibm.com>
X-Sender: shalini@imap.linux.ibm.com
Organization: IBM Deutschland Research & Development GmbH
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wBdoe0hjCk3gl-1xHyVWRM6OgnZ2KFD1
X-Proofpoint-ORIG-GUID: wBdoe0hjCk3gl-1xHyVWRM6OgnZ2KFD1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1034 mlxscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503060106
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

On 2025-03-05 19:05, Thomas Huth wrote:
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
>> +
>> +    visit_type_S390ControlProgramId(v, name, &cpi, &error_abort);
> 
> Forgot to say: Please use errp here instead -----------^
> 

Hello Thomas,

ok. Thank you.

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


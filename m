Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA6FC4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 15:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVYpa-0002Nb-Jo; Thu, 01 Feb 2024 10:18:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1rVYpZ-0002N2-DN; Thu, 01 Feb 2024 10:18:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1rVYpX-0005HK-KY; Thu, 01 Feb 2024 10:18:21 -0500
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 411F2TbD011713; Thu, 1 Feb 2024 15:18:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=8fkg77FbDWy0hbvoBxffAB6euUeRDNQrJo+6qYBrAoY=;
 b=szJNy4Q4qfhamIZHu8njY8BosCVZs+Au0zy2u6rYmPIbHNtjUquWv4LfJtNT/M4eGJJc
 Sd6fg2TAcNyyIdpq18f4ZKu1WFhTr3qv726veH69XQkbXoWB74rZqwfiGAlp/S2DjfXx
 JACYMOg2GHX8nVRkqGNdbOlhPLQphw0LiRoP9K4nTcOSfE9watlWvElF72eJ8s7WYYQq
 UQCL/tUxkvwMgxnT1uXF6WbLBUgNqXc4caumIyzs3fuKZedTM/KySa4ghw6HeyDe9Fk0
 Zi495VjK9FoIm6nXPf/wqU5SOe5tL5/6xSdQvL9jiWUhdKGLC+PGoaPLiDKfp7YYPzub YQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w0dkagh7g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Feb 2024 15:18:06 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 411F2axA012276;
 Thu, 1 Feb 2024 15:18:06 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w0dkagh4h-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Feb 2024 15:18:06 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 411C5WcF007168; Thu, 1 Feb 2024 14:53:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vwev2mc16-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Feb 2024 14:53:10 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 411Er8gN22086272
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Feb 2024 14:53:08 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D7F820040;
 Thu,  1 Feb 2024 14:53:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5FF6F20043;
 Thu,  1 Feb 2024 14:53:06 +0000 (GMT)
Received: from [9.109.208.159] (unknown [9.109.208.159])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  1 Feb 2024 14:53:06 +0000 (GMT)
Message-ID: <3d4a6a18-c81c-420e-948a-35746c1988ca@linux.ibm.com>
Date: Thu, 1 Feb 2024 20:23:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v7] ppc: Enable 2nd DAWR support on p10
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, danielhb413@gmail.com, clg@kaod.org, 
 david@gibson.dropbear.id.au, harshpb@linux.ibm.com,
 pbonzini@redhat.com, qemu-ppc@nongnu.org, kvm@vger.kernel.org
Cc: qemu-devel@nongnu.org
References: <170063834599.621665.9541440879278084501.stgit@ltcd48-lp2.aus.stglab.ibm.com>
 <CYM2N4QA6ZDB.8JC8WRV7JPK3@wheely>
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
In-Reply-To: <CYM2N4QA6ZDB.8JC8WRV7JPK3@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nVm7AfGLWHKW8pLAI1svBmbSMGd2tnkv
X-Proofpoint-GUID: JuKde7F9O9QJRtCoMD5umU3Y3KzS4JfL
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_03,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=922 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402010120
Received-SPF: pass client-ip=148.163.156.1; envelope-from=sbhat@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Thanks for the review Nick!

On 1/23/24 17:36, Nicholas Piggin wrote:
> On Wed Nov 22, 2023 at 5:32 PM AEST, Shivaprasad G Bhat wrote:
>> Extend the existing watchpoint facility from TCG DAWR0 emulation
>> to DAWR1 on POWER10.
>>
>> As per the PAPR, bit 0 of byte 64 in pa-features property
>> indicates availability of 2nd DAWR registers. i.e. If this bit is set, 2nd
>> DAWR is present, otherwise not. Use KVM_CAP_PPC_DAWR1 capability to find
>> whether kvm supports 2nd DAWR or not. If it's supported, allow user to set
>> the pa-feature bit in guest DT using cap-dawr1 machine capability.
<snip>
> I don't really like the macros. I have nightmares from Linux going
> overboard with defining functions using spaghetti of generator macros.
>
> Could you just make most functions accept either SPR number or number
> (0, 1), or simply use if/else, to select between them?
>
> Splitting the change in 2 would be good, first add regs + TCG, then the
> spapr bits.
Sure.
> [snip]
>
>> diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
>> index a05bdf78c9..022b984e00 100644
>> --- a/target/ppc/misc_helper.c
>> +++ b/target/ppc/misc_helper.c
>> @@ -204,16 +204,24 @@ void helper_store_ciabr(CPUPPCState *env, target_ulong value)
>>       ppc_store_ciabr(env, value);
>>   }
>>
>> -void helper_store_dawr0(CPUPPCState *env, target_ulong value)
>> -{
>> -    ppc_store_dawr0(env, value);
>> +#define HELPER_STORE_DAWR(id)                                                 \
>> +void helper_store_dawr##id(CPUPPCState *env, target_ulong value)              \
>> +{                                                                             \
>> +    env->spr[SPR_DAWR##id] = value;                                           \
>>   }
>>
>> -void helper_store_dawrx0(CPUPPCState *env, target_ulong value)
>> -{
>> -    ppc_store_dawrx0(env, value);
>> +#define HELPER_STORE_DAWRX(id)                                                \
>> +void helper_store_dawrx##id(CPUPPCState *env, target_ulong value)             \
>> +{                                                                             \
>> +    env->spr[SPR_DAWRX##id] = value;                                          \
>>   }
> Did we lose the calls to ppc_store_dawr*? That will
> break direct register access (i.e., powernv) if so.

Yes. My test cases were more focussed on caps-dawr1 with pSeries

usecases, and missed this. I have taken care in the next version.

>> +HELPER_STORE_DAWR(0)
>> +HELPER_STORE_DAWRX(0)
>> +
>> +HELPER_STORE_DAWR(1)
>> +HELPER_STORE_DAWRX(1)
> I would say open-code all these too instead of generating. If we
> ever grew to >= 4 of them maybe, but as is this saves 2 lines,
> and makes 'helper_store_dawrx0' more difficult to grep for.

I open coded all of the functions with barely 12 lines more adding up

without macros.


The next version posted at

https://lore.kernel.org/qemu-devel/170679876639.188422.11634974895844092362.stgit@ltc-boston1.aus.stglabs.ibm.com/T/#t


Thanks,

Shivaprasad



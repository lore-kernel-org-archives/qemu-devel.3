Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D61C7C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 21:45:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udyIP-0006t6-43; Mon, 21 Jul 2025 17:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1udyEb-0003eU-Jc; Mon, 21 Jul 2025 17:39:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1udyEZ-0007cG-CG; Mon, 21 Jul 2025 17:39:45 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LCYbeg023939;
 Mon, 21 Jul 2025 21:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=0WY0xK
 7TCerFmbUHUlcpyP7rSOLYgQu1BqO4o7/CQhQ=; b=Opt0AlNQ5YYb4PpBPirKfx
 2l0akh66AAyPLECZNOfm/XfNVQwLm3mhKed462IRBuiLxw6ITq8OSayXTFx0WHnz
 Vo6o7eZiTyqMtVPnm7g6TEwjBnCh5LDOy09PQSJmWO+1ydY1R8VB0Sp0sX4pY5TC
 /oFlJV+irtR0frKXy1Ta0azaV9L9uaL9WAJcrKTmNlVAJbHHfIu5tqkvkQiihSVp
 MLB0wd1nOYEEnzL/StWLXlwFFMZKwsMbRXZl0U9jTwZXsN/d5RznXWo6WcwlCwLL
 YCw/2rdsxDvD+KumLUfF19iGC5WhYrbydYIT7DS5IJt4diRivIeUd+lQQvUp5dnw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805ut2wq3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Jul 2025 21:39:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56LKMkVA005836;
 Mon, 21 Jul 2025 21:39:38 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 480tvqq868-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Jul 2025 21:39:38 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56LLdbqX33489454
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Jul 2025 21:39:37 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 137A858058;
 Mon, 21 Jul 2025 21:39:37 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F66E58057;
 Mon, 21 Jul 2025 21:39:36 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 21 Jul 2025 21:39:36 +0000 (GMT)
Message-ID: <5979bc7c-631f-4673-8d75-a94106a0b541@linux.ibm.com>
Date: Mon, 21 Jul 2025 17:39:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/28] s390x/diag: Introduce DIAG 320 for certificate
 store facility
From: Collin Walling <walling@linux.ibm.com>
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, pbonzini@redhat.com,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com
References: <20250711211105.439554-1-zycai@linux.ibm.com>
 <20250711211105.439554-6-zycai@linux.ibm.com>
 <5847016f-f4e7-49ca-82dd-3fb062a8ec0c@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <5847016f-f4e7-49ca-82dd-3fb062a8ec0c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDE5MyBTYWx0ZWRfXy5+iKdYswdqp
 BqVB/XwcWMuMVQratt7Kw1prptDJsl2pvTUUapwbQecAwzsnnooci+r7XTqlbbPCwrImuw1gLx0
 0eeMK/heWakI0Y4cu6BhjllTBVOvb4sRv0ONvtnJHOTnb1H8sBidnNnYhc7/fNSPCtMvKfcMl5n
 H3QwGx/wHr04XnXT9/r8t1JaHTiWPhTy0PE7SksvZlNX7EEWIo1lrTWGaYABUXCFFmolhqd5d9W
 lHwRUTP1OOuV7WCC6d4EQR3pb61EIQZJVMmezKePSco7xmWLA8Kya/dWmJ582nnXXUPQZQkc2Pb
 qWnaDghUTKr9NbmoRbdaflwgr2e1ua0o5KNksicybIIRjg0avxuYuWtvr1Ye2IrLmH5PuHt41CD
 xa2fOQCUosY84oqmrnsk5HED5eGwBIc99zchBB0NSmKDWKpC1bBPmztI9pQ+/75EvQk1FcsT
X-Proofpoint-ORIG-GUID: vzn16JX_XyLzZhm7yssPjdJacAykM2pc
X-Authority-Analysis: v=2.4 cv=cIDgskeN c=1 sm=1 tr=0 ts=687eb39b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=rTZLT0pRUQPfRY8HAscA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: vzn16JX_XyLzZhm7yssPjdJacAykM2pc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_05,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=905 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507210193
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
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

On 7/21/25 17:26, Collin Walling wrote:
> On 7/11/25 17:10, Zhuoying Cai wrote:

[...]

>> diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
>> index 8f655a4b7f..d5b3694600 100644
>> --- a/target/s390x/kvm/kvm.c
>> +++ b/target/s390x/kvm/kvm.c
>> @@ -98,6 +98,7 @@
>>  #define DIAG_TIMEREVENT                 0x288
>>  #define DIAG_IPL                        0x308
>>  #define DIAG_SET_CONTROL_PROGRAM_CODES  0x318
>> +#define DIAG_CERT_STORE                 0x320
>>  #define DIAG_KVM_HYPERCALL              0x500
>>  #define DIAG_KVM_BREAKPOINT             0x501
>>  
>> @@ -1560,6 +1561,16 @@ static void handle_diag_318(S390CPU *cpu, struct kvm_run *run)
>>      }
>>  }
>>  
>> +static void kvm_handle_diag_320(S390CPU *cpu, struct kvm_run *run)
>> +{
>> +    uint64_t r1, r3;
>> +
>> +    r1 = (run->s390_sieic.ipa & 0x00f0) >> 4;
>> +    r3 = run->s390_sieic.ipa & 0x000f;
>> +
>> +    handle_diag_320(&cpu->env, r1, r3, RA_IGNORED);
>> +}

One more piece I forgot to add here:

This handler function should check if the required facilities are
installed for DIAG 320.  For now, the Certificate Store facility is used
to indicate DIAG 320 is provided and possibly subcodes 0-3 are
available.  Please add a feature check here and throw a program
specification interrupt if the facility is not available before
handle_diag_320 is called.

>> +
>>  #define DIAG_KVM_CODE_MASK 0x000000000000ffff
>>  
>>  static int handle_diag(S390CPU *cpu, struct kvm_run *run, uint32_t ipb)

[...]

-- 
Regards,
  Collin


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E9F3D7877B
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 15:06:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE8kN-0007KQ-AL; Thu, 21 Nov 2024 10:05:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@imap.linux.ibm.com>)
 id 1tE3gl-0005tW-2e; Thu, 21 Nov 2024 04:41:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@imap.linux.ibm.com>)
 id 1tE3gj-0003JZ-HP; Thu, 21 Nov 2024 04:41:26 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL7AiBO024982;
 Thu, 21 Nov 2024 09:26:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Df8/cj
 xBV+GVZgoqlwKka5Wu7JX9PZRuNdyAuKVPpxI=; b=DQ9YkZzzbcqvfLTUp6KGCj
 v6sojsCqTs5QYP6PTsnR5CpB0bykUXtMcrNUWWlQdPQkLtvzl7GsGfotc+Y5Y9U7
 bjpqAyw7j8RiV/D96ahqaiwWkc3n9m6dnnHH3DdCzJa97P4eZoo1vzSgE44oWwpA
 TU8RNFtlbMRgkkyKXz3208IBsQXCW2udjxCGWpqLuYs0l77nMvn0OlPaIWtRbiGA
 V19KqUVRFFaSUIhkAP+s6t7MqaAh2mg2I/5ufDRK+b2VuSJeuzKQGz1YO7R7+Dg8
 HcoDPuyLhI8eyr09Wf33qslSOLzpq89Oy10guM5YMTz12VDwrwrUKSQ15WkfMb6Q
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xk2wb14g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Nov 2024 09:26:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL7chT3011747;
 Thu, 21 Nov 2024 09:26:21 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42y8e1gay4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Nov 2024 09:26:21 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4AL9QKpH28836394
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Nov 2024 09:26:21 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD54F58057;
 Thu, 21 Nov 2024 09:26:20 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 57A6258058;
 Thu, 21 Nov 2024 09:26:20 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 21 Nov 2024 09:26:20 +0000 (GMT)
MIME-Version: 1.0
Date: Thu, 21 Nov 2024 10:26:20 +0100
From: iii <iii@imap.linux.ibm.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>,
 Thomas Huth <thuth@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH v2] linux-user: Fix strace output for s390x mmap()
In-Reply-To: <faeded70-af8e-4c3f-af1a-0bd1e11f5394@linaro.org>
References: <20241120212717.246186-1-iii@linux.ibm.com>
 <faeded70-af8e-4c3f-af1a-0bd1e11f5394@linaro.org>
Message-ID: <66b61760a0cbc8001611a99678b4719e@imap.linux.ibm.com>
X-Sender: iii@imap.linux.ibm.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IMbtcbFi47xhUW-aPbItMKvimYtw1FAc
X-Proofpoint-GUID: IMbtcbFi47xhUW-aPbItMKvimYtw1FAc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 priorityscore=1501 phishscore=0 clxscore=1034 suspectscore=0 spamscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411210070
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=iii@imap.linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_ADSP_NXDOMAIN=0.9,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NO_DNS_FOR_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 21 Nov 2024 10:05:28 -0500
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

On 2024-11-21 10:00, Philippe Mathieu-Daudé wrote:
> On 20/11/24 22:26, Ilya Leoshkevich wrote:
>> print_mmap() assumes that mmap() receives arguments via memory if
>> mmap2() is present. s390x (as opposed to s390) does not fit this
>> pattern: it does not have mmap2(), but mmap() still receives arguments
>> via memory.
>> 
>> Fix by sharing the detection logic between syscall.c and strace.c.
>> 
>> Cc: qemu-stable@nongnu.org
>> Fixes: d971040c2d16 ("linux-user: Fix strace output for old_mmap")
>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>> ---
>> 
>> v1: 
>> https://lore.kernel.org/qemu-devel/20241119211138.148806-1-iii@linux.ibm.com/
>> v1 -> v2: Share the detection logic between syscall.c and strace.c
>>            (Richard).
>> 
>>   linux-user/strace.c       | 2 +-
>>   linux-user/syscall.c      | 5 +----
>>   linux-user/syscall_defs.h | 7 +++++++
>>   3 files changed, 9 insertions(+), 5 deletions(-)
>> 
>> diff --git a/linux-user/strace.c b/linux-user/strace.c
>> index b70eadc19ef..9c55f39b095 100644
>> --- a/linux-user/strace.c
>> +++ b/linux-user/strace.c
>> @@ -3971,7 +3971,7 @@ print_mmap(CPUArchState *cpu_env, const struct 
>> syscallname *name,
>>   {
>>       return print_mmap_both(cpu_env, name, arg0, arg1, arg2, arg3,
>>                              arg4, arg5,
>> -#if defined(TARGET_NR_mmap2)
>> +#ifdef TARGET_ARCH_WANT_SYS_OLD_MMAP
> 
> We still want to print for mmap2, so:
> 
>   #if defined(TARGET_NR_mmap2) || 
> defined(TARGET_ARCH_WANT_SYS_OLD_MMAP)
> 
>>                               true
>>   #else
>>                               false

mmap2() has its own flow from what I can see:

print_mmap2()
   print_mmap_both(..., is_old_mmap=false)

It should not call print_mmap(), which I'm changing here.

[...]


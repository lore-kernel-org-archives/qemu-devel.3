Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6633DD7877B
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 15:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE8kO-0007KY-0j; Thu, 21 Nov 2024 10:05:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@imap.linux.ibm.com>)
 id 1tE5MD-000561-Qj; Thu, 21 Nov 2024 06:28:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@imap.linux.ibm.com>)
 id 1tE5MA-0005dg-6o; Thu, 21 Nov 2024 06:28:21 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL7vG5u006352;
 Thu, 21 Nov 2024 10:12:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=KWSgKe
 07JV0XDIOFk7iX/wAVgsWTTtv4Ndf3x427RuM=; b=SPtaTm9moAgR7d9G4gHfsk
 qhKFcjKRQznQFRMjWognOoooZ7LihwCSqZAkiv/QW4XZZYHQ0O0ZzILkJ3jeJ5IY
 dABoyNf/AKG6OZe7FtXV9DcB19I51DIYXvcKItyphwzOfnQfPm2IigLM5ZfN72vA
 mgQ17WP59I61V6A3UvLW/2KxkW63Mwyo0nP/gK7Vk+WEV/dlaYTMaDKImJ7a3Npp
 fUuL9nYOSCgK09OhINaYSkvHllLYsXnRJxGWmMb/+RBVXo/k5kXe0HSiPVDvMS0R
 Iz/sKALPdPGNvUBD1IVV2zHCEx47qQOdy8k6PvHHlYO7gYVskdenbF2ugOIh1/kQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xk219t9d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Nov 2024 10:12:18 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4ALA4HJD021389;
 Thu, 21 Nov 2024 10:12:18 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xk219t9a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Nov 2024 10:12:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL72Trd011847;
 Thu, 21 Nov 2024 10:12:17 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42y7xjrdqv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Nov 2024 10:12:17 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4ALACGfv25232066
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Nov 2024 10:12:16 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6AFDA58057;
 Thu, 21 Nov 2024 10:12:16 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1148D5805D;
 Thu, 21 Nov 2024 10:12:16 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 21 Nov 2024 10:12:15 +0000 (GMT)
MIME-Version: 1.0
Date: Thu, 21 Nov 2024 11:12:15 +0100
From: iii <iii@imap.linux.ibm.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Helge Deller <deller@gmx.de>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-stable@nongnu.org,
 John Reiser <jreiser@bitwagon.com>
Subject: Re: [PATCH v2] linux-user: Fix strace output for s390x mmap()
In-Reply-To: <47e35ab6-65f7-451e-b557-8528e2542222@linaro.org>
References: <20241120212717.246186-1-iii@linux.ibm.com>
 <faeded70-af8e-4c3f-af1a-0bd1e11f5394@linaro.org>
 <66b61760a0cbc8001611a99678b4719e@imap.linux.ibm.com>
 <47e35ab6-65f7-451e-b557-8528e2542222@linaro.org>
Message-ID: <79a33b561bc6d5daf590380ddecea8d4@imap.linux.ibm.com>
X-Sender: iii@imap.linux.ibm.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DTgxX8QlGFpYwondxyx6dMwIDOmRSJQF
X-Proofpoint-GUID: NH17Sw1yDXMvQHToGeWh9ev-FBPySJu-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1034 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411210078
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=iii@imap.linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 2024-11-21 11:07, Philippe Mathieu-Daudé wrote:
> On 21/11/24 10:26, iii wrote:
>> On 2024-11-21 10:00, Philippe Mathieu-Daudé wrote:
>>> On 20/11/24 22:26, Ilya Leoshkevich wrote:
>>>> print_mmap() assumes that mmap() receives arguments via memory if
>>>> mmap2() is present. s390x (as opposed to s390) does not fit this
>>>> pattern: it does not have mmap2(), but mmap() still receives 
>>>> arguments
>>>> via memory.
>>>> 
>>>> Fix by sharing the detection logic between syscall.c and strace.c.
>>>> 
>>>> Cc: qemu-stable@nongnu.org
>>>> Fixes: d971040c2d16 ("linux-user: Fix strace output for old_mmap")
>>>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>>>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>>> ---
>>>> 
>>>> v1: 
>>>> https://lore.kernel.org/qemu-devel/20241119211138.148806-1-iii@linux.ibm.com/
>>>> v1 -> v2: Share the detection logic between syscall.c and strace.c
>>>>            (Richard).
>>>> 
>>>>   linux-user/strace.c       | 2 +-
>>>>   linux-user/syscall.c      | 5 +----
>>>>   linux-user/syscall_defs.h | 7 +++++++
>>>>   3 files changed, 9 insertions(+), 5 deletions(-)
>>>> 
>>>> diff --git a/linux-user/strace.c b/linux-user/strace.c
>>>> index b70eadc19ef..9c55f39b095 100644
>>>> --- a/linux-user/strace.c
>>>> +++ b/linux-user/strace.c
>>>> @@ -3971,7 +3971,7 @@ print_mmap(CPUArchState *cpu_env, const struct 
>>>> syscallname *name,
>>>>   {
>>>>       return print_mmap_both(cpu_env, name, arg0, arg1, arg2, arg3,
>>>>                              arg4, arg5,
>>>> -#if defined(TARGET_NR_mmap2)
>>>> +#ifdef TARGET_ARCH_WANT_SYS_OLD_MMAP
>>> 
>>> We still want to print for mmap2, so:
>>> 
>>>   #if defined(TARGET_NR_mmap2) || 
>>> defined(TARGET_ARCH_WANT_SYS_OLD_MMAP)
>>> 
>>>>                               true
>>>>   #else
>>>>                               false
>> 
>> mmap2() has its own flow from what I can see:
>> 
>> print_mmap2()
>>    print_mmap_both(..., is_old_mmap=false)
>> 
>> It should not call print_mmap(), which I'm changing here.
>> 
>> [...]
> 
> If so, better to clean that in a previous patch.

Sorry, I'm confused. What previous patch are you referring to?

> Cc'ing Helge since I'm a bit confused by commit d971040c2d intent
> ("linux-user: Fix strace output for old_mmap").

My understanding of the Helge's idea is that "defined(TARGET_NR_mmap2)" 
is
true if, and only if, mmap() takes arguments via memory.


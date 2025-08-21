Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7356ACA0EF8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 12:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up4VT-0006cu-75; Thu, 21 Aug 2025 08:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1up4VQ-0006cf-SW; Thu, 21 Aug 2025 08:35:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1up4VJ-0007fD-Dl; Thu, 21 Aug 2025 08:35:00 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L6a7ge012075;
 Thu, 21 Aug 2025 12:34:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=sGLYd0
 xhBWytqwStUPRUW3yDoDj5fich3tJBPLNXyFE=; b=no8o6UPNCEO6E4VY3cUZfA
 munhgc8NV42NjC/8Gg7gLJwMh+0lmdjOGYCs7Lbt6Kex3orfz8Wj2I6z3fg/Vnve
 TbaksBcxcpsTOEgMKBmUU9Ga+qcm/4XOs2w2GIF65+4KHW+AJ9SW+XhHNM4X/VRO
 iCjs6qrv8f8TNkDDvZVbLg7E7linTkskmFJgT3rItPXNBsl2jmAGcV7NzY7cpGRj
 AjBp6j8+csoi/gBX1VFjEgO+gxUVnHsdVo6CGkgps17d8vN7+TJILjqAL+jdkZlr
 8FHVHRP92DPkaosSK/710Lfqq/7STS+IO61QkyPzPMLlV54EvErnOOvAmjJiQFBw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vgmx9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Aug 2025 12:34:45 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57LCYj9L028876;
 Thu, 21 Aug 2025 12:34:45 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vgmx6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Aug 2025 12:34:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57LAo8vg015613;
 Thu, 21 Aug 2025 12:34:44 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48my42893a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Aug 2025 12:34:44 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57LCYeRS43843988
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Aug 2025 12:34:40 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7A0172004B;
 Thu, 21 Aug 2025 12:34:40 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F334020040;
 Thu, 21 Aug 2025 12:34:37 +0000 (GMT)
Received: from [9.39.19.55] (unknown [9.39.19.55])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 21 Aug 2025 12:34:37 +0000 (GMT)
Message-ID: <46991b45-3a03-4e66-a28d-f0178b8780fe@linux.ibm.com>
Date: Thu, 21 Aug 2025 18:04:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fix: Fix build error with CONFIG_POWERNV disabled
To: Thomas Huth <thuth@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20250820122516.949766-2-adityag@linux.ibm.com>
 <3xbdwul3qwdb246pk5xeeduotfvyeyjr6qkozzatb7h2zdrxlb@pcuu3ewglrjj>
 <f7a8b91e-e2df-4c11-818e-f244f8e648ad@redhat.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <f7a8b91e-e2df-4c11-818e-f244f8e648ad@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0rHnwpmlp8v0e0bAC8fSlWHIYu7EaYZg
X-Authority-Analysis: v=2.4 cv=IrhHsL/g c=1 sm=1 tr=0 ts=68a71265 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=keK3y0qNwfmjET115iUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfXyaIKYEWePgw/
 QbcHTlGeCbEfOHqPYjmgzJzkMrbLQsiIIBVnAm9zFpBhr9jpttiFt5fsMkYqi3buKH1K4k3KYgg
 LDEZoa43mtyQ7E0grlqL5ntv/g8255NC1J4F193NcdBmNN4n2D1e58cvqoqFrBudTmTo/UPxHRb
 jYczWFM7h1tJ/5slLfdyJ0JtsqRYIc27fOIFk6ylR2G/7d/KXMKkJsOljrBwyQ/438NxoMm/jQ7
 qHlH9+Lkc8JWVfHJst6IuCqDRwxQHAI42r4Y9zO6rRB9VrMzdnrWl7xp3kRg2zGUDBXr3qIwcaD
 reO+CEuUUz2zkf+nGckgCvavsq4e23QS7NQq6TmA6eDjAsv6EPc3XP6C155UMHmnOOLyprl3G3a
 pczS6i7ETFk5ucPWturUm+Fr14KlVw==
X-Proofpoint-ORIG-GUID: hyxkdMWBW0EpkFU-PKVKiXfXSFUr5gEM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508190222
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi Thomas,

On 21/08/25 17:35, Thomas Huth wrote:
> On 21/08/2025 12.53, Aditya Gupta wrote:
>> On 25/08/20 05:55PM, Aditya Gupta wrote:
>>> Currently when CONFIG_POWERNV is not enabled, the build fails, such as
>>> with --without-default-devices:
>>>
>>>      $ ./configure --without-default-devices
>>>      $ make
>>>
>>>      [281/283] Linking target qemu-system-ppc64
>>>      FAILED: qemu-system-ppc64
>>>      cc -m64 @qemu-system-ppc64.rsp
>>>      /usr/bin/ld: 
>>> libqemu-ppc64-softmmu.a.p/target_ppc_misc_helper.c.o: in function 
>>> `helper_load_sprd':
>>>      .../target/ppc/misc_helper.c:335:(.text+0xcdc): undefined 
>>> reference to `pnv_chip_find_core'
>>>      /usr/bin/ld: 
>>> libqemu-ppc64-softmmu.a.p/target_ppc_misc_helper.c.o: in function 
>>> `helper_store_sprd':
>>>      .../target/ppc/misc_helper.c:375:(.text+0xdf4): undefined 
>>> reference to `pnv_chip_find_core'
>>>      collect2: error: ld returned 1 exit status
>>>      ...
>>>
>>>> <...snip...>
>>
>> The following is also sufficient to fix the compilation issue. Wasn't
>> sure if #ifdef POWERNV looks good there:
>>
>>      diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
>>      index e7d94625185c..a8e55b2937c7 100644
>>      --- a/target/ppc/misc_helper.c
>>      +++ b/target/ppc/misc_helper.c
>>      @@ -323,6 +323,7 @@ void helper_store_sprc(CPUPPCState *env, 
>> target_ulong val)
>>             target_ulong helper_load_sprd(CPUPPCState *env)
>>       {
>>      +#ifdef CONFIG_POWERNV
>>           /*
>>            * SPRD is a HV-only register for Power CPUs, so this will 
>> only be
>>            * accessed by powernv machines.
>>      @@ -361,11 +362,14 @@ target_ulong helper_load_sprd(CPUPPCState 
>> *env)
>>                                         TARGET_FMT_lx"\n", sprc);
>>               break;
>>           }
>>      +#endif
>
> I don't think this is a good patch, it likely always disables the 
> code, even if the POWERNV machine is available? At least it lacks the 
> #include CONFIG_DEVICES that would be required here.


Ah, sorry. Agreed it's not fixing the issue then. Thanks for pointing this.

Meanwhile, I will wait for comments on original patch, if not the 
original one maybe
an alternate like this is better.


- Aditya G

>
>  Thomas
>


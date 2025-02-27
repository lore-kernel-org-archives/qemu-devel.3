Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4DCFC021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 12:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tncnc-0000Te-0W; Thu, 27 Feb 2025 07:15:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tncna-0000TG-0M; Thu, 27 Feb 2025 07:15:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tncnX-0004lr-Nb; Thu, 27 Feb 2025 07:15:29 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R5OoR0021089;
 Thu, 27 Feb 2025 12:15:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=t3FuNB
 qIzUAA7jg4vPZnQWn7Jo1Mpn/NpG+pnS19aww=; b=P5eMYrj42ETY2Luo0SIEfz
 VIGR8MVVuQnXYagI8ko9BMsmOlF6t/d/3RpTJaS9ph+mQk2x7OLP0wkDNYcuKINo
 NqJh2jh2qoT5Y0eJqWz2Jk16J/uxSFin9U2lFhzMIyYOvvNY/Kx1A+Me81atwWsW
 46ocVWdALoGcSA2Pjd+OgXoJOdvcFdL38+AGzcRFBM69Czxtg8R05Xxq8hr4XIkw
 K6h+c6m9vPVTqhX0CT0+XESM0th5yPeGiNvlq+eCKne19vUyEDfnO2WKCd54vs1D
 o46Rc6fdc4NDEjybrVlpRsMoO4aYe2qgyp5daltYR15tg7TuDyK/SJD/6eWaiauQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 452hv8sur9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Feb 2025 12:15:24 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51RCEOsT032020;
 Thu, 27 Feb 2025 12:15:24 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 452hv8suqy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Feb 2025 12:15:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51RAXGYj002588;
 Thu, 27 Feb 2025 12:15:23 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yu4k0679-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Feb 2025 12:15:23 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51RCFJjc19726794
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Feb 2025 12:15:19 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B54E22004B;
 Thu, 27 Feb 2025 12:15:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A780720040;
 Thu, 27 Feb 2025 12:15:17 +0000 (GMT)
Received: from [9.109.199.160] (unknown [9.109.199.160])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 27 Feb 2025 12:15:17 +0000 (GMT)
Message-ID: <ebf91be5-071d-4b5b-ad30-6d99d12af86e@linux.ibm.com>
Date: Thu, 27 Feb 2025 17:45:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] hw/ppc: Implement skeleton code for fadump in PSeries
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
References: <20250217071711.83735-1-adityag@linux.ibm.com>
 <20250217071711.83735-2-adityag@linux.ibm.com>
 <D82WB0T0PJ0H.3M2NGHZT4M9SW@gmail.com>
 <7ec1dc4f-e7b1-492a-8cf2-b971b11bc31b@linux.ibm.com>
 <D833JYHF1A5A.1QP2LM99MU7XE@gmail.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <D833JYHF1A5A.1QP2LM99MU7XE@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xpBuMe2R8Of8vWZKkmlFtnt-xM6297bQ
X-Proofpoint-GUID: AKLa3j09XNqjOwOXHKHuTyz8EIrkvh-w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_05,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502270091
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 27/02/25 14:18, Nicholas Piggin wrote:
> On Thu Feb 27, 2025 at 4:49 PM AEST, Aditya Gupta wrote:
>> Hi Nick,
>>
>> On 27/02/25 08:37, Nicholas Piggin wrote:
>>> On Mon Feb 17, 2025 at 5:17 PM AEST, Aditya Gupta wrote:
>>> <...snip...>
>> Ah, that is problematic agreed. I tried to move around things, but
>> arrived at this.
>>
>> I will spend some time thinking how to arrange this.
>>
>> Will need some guidance. How should I approach arranging the code in
>> such situations ?
>>
>> My idea was to
>> * First one is the skeleton: mentions the steps, but doesn't implement
>> the steps
>> * Middle patches implement the steps one by one
>> * Last patch enables it all. So in future if someone checks out the
>> "Enable fadump" commit they would have all the support ready.
>>
>> The major problem is "everything" remains unused till this last patch.
>> But this 1st patch gave me the chance to logically build upon this, eg.
>> first implement preserving memory regions, then add the fadump_trigger
>> in os-term rtas call, etc.
>>
>> Any advice to approach this ?
> Yeah, sometimes it's difficult to avoid. Especially with a new
> feature like this. If you can't find a better way, that's okay.
>
> One thing could be to return errors from calls. RTAS is a little
> bit tricky since there is no general "unsupported" error because
> the presence of the token implies some support. You could return
> -1 hardware error perhaps.
>
> Another option is implement the call but not all functionality.
> E.g., permit dump register/unregister, but don't actually provide
> a valid dump on reboot (you could ignore, or provide empty or
> invalid format). Downside of that is that if you bisect, a kernel
> test case could go bad because it appears to be supported but
> produces invalid result.
>
> To avoid that, perhaps you could trip an assert or just log an
> error message when performing a reboot with crash dump registered.
>
> But as I said, don't make it too convoluted or lots more work if
> it's not easy to rework.

Thanks for the ideas Nick. I guess the first one makes sense if we want 
to not need the unused functions.

Only thing I want to check there is, since the 
"ibm,configure-kernel-dump" rtas call is registered, kernel will think 
fadump is supported, and might try registering fadump (if "fadump=on" 
passed in kernel), will see what the kernel does on a failure to 
register fadump in earlyboot.

It generally falls back to kdump, will check.


>>>> +{
>>>> +    struct rtas_fadump_section_header header;
>>>> +    target_ulong cmd = rtas_ld(args, 0);
>>>> +    target_ulong fdm_addr = rtas_ld(args, 1);
>>>> +    target_ulong fdm_size = rtas_ld(args, 2);
>>>> +
>>>> +    /* Number outputs has to be 1 */
>>>> +    if (nret != 1) {
>>>> +        qemu_log_mask(LOG_GUEST_ERROR,
>>>> +                "FADUMP: ibm,configure-kernel-dump RTAS called with nret != 1.\n");
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    /* Number inputs has to be 3 */
>>>> +    if (nargs != 3) {
>>>> +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    switch (cmd) {
>>>> +    case FADUMP_CMD_REGISTER:
>>>> +        if (fadump_metadata.fadump_registered) {
>>>> +            /* Fadump already registered */
>>>> +            rtas_st(rets, 0, RTAS_OUT_DUMP_ALREADY_REGISTERED);
>>>> +            return;
>>>> +        }
>>>> +
>>>> +        if (fadump_metadata.fadump_dump_active == 1) {
>>>> +            rtas_st(rets, 0, RTAS_OUT_DUMP_ACTIVE);
>>>> +            return;
>>>> +        }
>>>> +
>>>> +        if (fdm_size < sizeof(struct rtas_fadump_section_header)) {
>>>> +            qemu_log_mask(LOG_GUEST_ERROR,
>>>> +                "FADUMP: Header size is invalid: %lu\n", fdm_size);
>>>> +            rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
>>>> +            return;
>>>> +        }
>>>> +
>>>> +        /* XXX: Can we ensure fdm_addr points to a valid RMR-memory buffer ? */
>>> RMR memory? There is spapr_rma_size() if that's what you need?
>>
>> Thanks, will use `spapr_rma_size`. The PAPR says fdm_addr should point
>> to a valid RMR buffer, I guess that means it should be in the RMA, ie.
>> `< spapr_rma_size()` ?
> Ah yes, PAPR glossray says:
>
> Real Mode Region. This is an obsolete term that is deprecated in favor of RMA.
>
> So that should do what you want.

Sure, thanks !


- Aditya Gupta

>
> Thanks,
> Nick
>


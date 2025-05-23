Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE202C54F2E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 13:38:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uISac-0006y5-LB; Fri, 23 May 2025 09:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uISaX-0006x9-Oz; Fri, 23 May 2025 09:37:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uISaV-0001Qo-Kh; Fri, 23 May 2025 09:37:29 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NC8jh9030278;
 Fri, 23 May 2025 13:37:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=6Z7Stk
 IPAd2Y2fkc9sVwBkrtnXyPF8XRGpWHmp7qzZE=; b=X0/5nAN1Yq6BoAhYsAqzDT
 K/jMJ4L4tkDSQ0/yJ5EMkEOpd7ReI/GlpZ13rU8sje6xOV4Ta4h3oP58EAp60KjY
 sEnN0/KIba7IEsosvNwE+mAj24xUPLstKIdwLOgmnFxgqUgkk/nTqJ/gec5Zp6cq
 gnyDddhBaQ3PsQBaJVP/WG79yttxzSfscBg20Oj1WVOY9AJd/tn1GMM6Emc93cx2
 3YKwWaGCe+Z2zZVeq80l2PRgEC1A4P8rbWxDEmeq2/Zr+BSkdGIN6UM9JBA4J11e
 O9opZT8ybhrWPrxzGUHFxl2IP0L8RVM7GV71Ozuuk6nQqfbbuN5TV23mAuEXQo/g
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46t669nm9y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 May 2025 13:37:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54N9d7pR032024;
 Fri, 23 May 2025 13:37:23 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46rwmqermk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 May 2025 13:37:23 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54NDbLpv33161916
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 May 2025 13:37:21 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CA94058063;
 Fri, 23 May 2025 13:37:21 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2E9B158058;
 Fri, 23 May 2025 13:37:21 +0000 (GMT)
Received: from [9.61.240.236] (unknown [9.61.240.236])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 23 May 2025 13:37:21 +0000 (GMT)
Message-ID: <2b3ec51f-0f60-41fa-b8ba-5882c019e8ac@linux.ibm.com>
Date: Fri, 23 May 2025 09:37:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v10 3/4] hw/vfio/ap: Storing event information for an
 AP configuration change event
To: Anthony Krowiak <akrowiak@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com
References: <20250523044741.59936-1-rreyes@linux.ibm.com>
 <20250523044741.59936-4-rreyes@linux.ibm.com>
 <073a01a0-dce2-4788-b07c-dbc75a54f54e@linux.ibm.com>
Content-Language: en-US
From: Rorie Reyes <rreyes@linux.ibm.com>
In-Reply-To: <073a01a0-dce2-4788-b07c-dbc75a54f54e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RrPFLDmK c=1 sm=1 tr=0 ts=68307a14 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=sWKEhP36mHoA:10
 a=l2k30bRfp1dmlEPDac4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: HT4w5lEI0xd7d6vTvTOgkwCAEtqrbQMC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDEyMCBTYWx0ZWRfX9EyV/o3MvcMZ
 GSsXiEttrcTT0WjUBth4C8tGdQuf3Md84FFBz1hXhnvPCNmiOCslxxPpMTV2kC5sfNH9mRg0qts
 omoHvFLevyFW+5WfIdOepA73o/LpBY83kCtal1FgmQjmdjmx2cgEwdISB7RqezWTTjP5oX7tap0
 WmIpiFnnlZxooctIh/P6qegSIwNG5YPj+2MZFSPd6mpd6xSHLCXVE0MKcHBzHZib6TsCaDKbuzk
 b7p2rfraWoYYiQNiVA44v6mTfCeNPj4y+FJUin5aTZSmIwtoAoRy4KrNumKUs+n4hRWGEQyFTKg
 Wgc5NCNKUIIA3Wd2TmPkp833gRhPLDMeOgktog1h8JziDoj6+C1SgxDJGqqfkVUewFMIdJCKsCJ
 aLI/kXhUXWNe40UyR5koARO/ParkrkFIPzSL+XW0B7TqnMC4Y/jDrZK38j+f/C75UiaJSmAb
X-Proofpoint-GUID: HT4w5lEI0xd7d6vTvTOgkwCAEtqrbQMC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_04,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0
 impostorscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505230120
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rreyes@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

>> @@ -96,6 +99,49 @@ static void vfio_ap_cfg_chg_notifier_handler(void 
>> *opaque)
>>     }
>>   +bool ap_chsc_sei_nt0_get_event(void *res)
>> +{
>> +    ChscSeiNt0Res *nt0_res  = (ChscSeiNt0Res *)res;
>> +    APConfigChgEvent *cfg_chg_event;
>> +
>> +    qemu_mutex_lock(&cfg_chg_events_lock);
>> +
>> +    if (!ap_chsc_sei_nt0_have_event()) {
>> +        qemu_mutex_unlock(&cfg_chg_events_lock);
>> +        return true;
>> +    }
>> +
>> +    cfg_chg_event = QTAILQ_FIRST(&cfg_chg_events);
>> +    QTAILQ_REMOVE(&cfg_chg_events, cfg_chg_event, next);
>> +
>> +    qemu_mutex_unlock(&cfg_chg_events_lock);
>> +
>> +    memset(nt0_res, 0, sizeof(*nt0_res));
>> +    g_free(cfg_chg_event);
>> +
>> +    /*
>> +     * If there are any AP configuration change events in the queue,
>> +     * indicate to the caller that there is pending event info in
>> +     * the response block
>> +     */
>> +    if (ap_chsc_sei_nt0_have_event()) {
>> +        nt0_res->flags |= PENDING_EVENT_INFO_BITMASK;
>> +    }
>> +
>> +    nt0_res->length = sizeof(ChscSeiNt0Res);
>> +    nt0_res->code = NT0_RES_RESPONSE_CODE;
>> +    nt0_res->nt = NT0_RES_NT_DEFAULT;
>> +    nt0_res->rs = NT0_RES_RS_AP_CHANGE;
>> +    nt0_res->cc = NT0_RES_CC_AP_CHANGE;
>> +
>> +    return false;
>> +}
>
> The boolean return values in the function above do not make logical 
> sense.
> What they are effectively saying is that event information has been 
> stored
> in the response when there is no event information to store (i.e., the 
> event
> queue is empty), and that event information has not been stored if the
> response has been filled with event information.
>
> After looking at the calling code in target/s390x/ionst.c, apparently 
> the meaning of
> the int value originally returned from the above function was not in 
> fact intended to
> be a boolean value. It looks like the caller uses this value to 
> indicate whether the
> response code should be set to 0x0001 (this function returns 0) or 
> 0x0005 (this
> function returns 1); so, the boolean values returned match what is 
> expected by
> the caller. I think this is why your original pass at returning a 
> boolean caused your
> patch to fail; because you did what made logical sense in this function.
>
> I think the calling code is very convoluted to say the least, so maybe 
> what makes sense
> here is to continue to return an int and use #define to document the 
> return value; for
> example:
>
> #define EVENT_INFORMATION_STORED           0
> #define EVENT_INFORMATION_NOT_STORED 1
>
> It would probably make a great deal of sense to refactor the calling 
> code, but that
> could potentially open up a large can of worms, so at least this makes 
> sense from
> the perspective of reading this code.
>
I agree with you on that, Tony. It makes sense to return an int due to 
the calling code. I will make these updates and set up the appropriate 
definitions in the header file, 'ap-bridge.h'. I'll also reflect the 
same type changes in the stub file to match
>> +
>> +bool ap_chsc_sei_nt0_have_event(void)
>> +{
>> +    return !QTAILQ_EMPTY(&cfg_chg_events);
>> +}
>
> It's probably fine to return boolean from the above function because it
> makes sense even from the caller's perspective.
>
I'll keep this as is as, but I'll update the stub file to match



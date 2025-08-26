Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F1E8CA0EFA
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 04:56:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqli6-0001Lm-54; Tue, 26 Aug 2025 00:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uqli1-0001L8-W5; Tue, 26 Aug 2025 00:55:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uqlhu-0008C9-JY; Tue, 26 Aug 2025 00:55:01 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PKDSmc028933;
 Tue, 26 Aug 2025 04:54:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=G++4m9
 REj0hY1xOKErOpXAXzUjEPxiicM2yRZbdKGlQ=; b=Y38l7qpUDZ4wU4ZdxbVHi8
 AL2suWf1GTNmLem9RplcMgQOTef0P5MUGSUZTTMLjGPVl50mVbNT0aTWVJMb7K5G
 jiIUbK1PguN34fK2ZUOFU2B1UUo4uLLFCieLTEzb2mofGlSwaoisXIdSmYzTZvcg
 zblvU7zZHUkS1A082HwSHLtqdR64WQVdlRMvxsB9Ha4zVZlIMEOjy91CNgkUDqm7
 6Q7IrIGMbILrbMi04BNheCPOaF2GzMZLuko6LfRNEKzvKg+Oz+c6oHtIHLz0hRMo
 R/hrMRx8LB0KYb5BH3fP/Cv0Xzw4/f+2+noqleofLbRxVURp87z+ZChiN1Mww81g
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q32vcsv6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Aug 2025 04:54:46 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57Q4qOXV026183;
 Tue, 26 Aug 2025 04:54:45 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q32vcsv3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Aug 2025 04:54:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q4JLM2017963;
 Tue, 26 Aug 2025 04:54:44 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48qtp38tnx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Aug 2025 04:54:44 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57Q4shlX10749124
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Aug 2025 04:54:43 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8EE0958056;
 Tue, 26 Aug 2025 04:54:43 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 836155803F;
 Tue, 26 Aug 2025 04:54:39 +0000 (GMT)
Received: from [9.109.242.24] (unknown [9.109.242.24])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 26 Aug 2025 04:54:39 +0000 (GMT)
Message-ID: <9b0253e4-a906-4be4-ab46-df41bea0f054@linux.ibm.com>
Date: Tue, 26 Aug 2025 10:24:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] target/ppc: Add IBM PPE42 family of processors
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Thomas Huth <thuth@redhat.com>, Glenn Miles <milesg@linux.ibm.com>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@redhat.com,
 npiggin@gmail.com, rathc@linux.ibm.com, richard.henderson@linaro.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250819212856.219932-1-milesg@linux.ibm.com>
 <20250819212856.219932-2-milesg@linux.ibm.com>
 <0d2c9aa2-2dcc-4c22-8f33-e5ecac907cf4@linux.ibm.com>
 <c13f63a6-5fef-42f2-89fe-946f71498f51@redhat.com>
 <fd855a38-976f-430e-9db1-1bdce1cf869d@linux.ibm.com>
 <dc6dc7db-f4c3-4641-9707-383737e2b678@redhat.com>
 <0b6d96c7-b28f-42c0-93db-579d80f0298b@linux.ibm.com>
 <fd6f2788-b1a8-41af-88b5-9eb2ebdfd9d8@redhat.com>
 <e946e0f7-cc9f-40fa-bd41-3044510ce261@linux.ibm.com>
 <cee8e481-8cfa-a86c-bca6-10ac3fbcffb6@eik.bme.hu>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <cee8e481-8cfa-a86c-bca6-10ac3fbcffb6@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zQy3VggCs09-4DavM4VFTvAUwcpahGz0
X-Proofpoint-GUID: N4jasUC0xPubsLDIQMO5BF1cT5PprPD-
X-Authority-Analysis: v=2.4 cv=AfSxH2XG c=1 sm=1 tr=0 ts=68ad3e16 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=f7IdgyKtn90A:10
 a=BkW6ZaEq_qAgNLOhhEwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAwMCBTYWx0ZWRfX/TM69pdtDZlt
 A5C1YqfqAc2nwWffqZObd4eLlyGX6lih5vZb5tAcuBHch55x+w1wO7HP7QUR0CJuy4Mwbx0lBhT
 AxTDneiJiLYzxPm+nEPJbZnvZJ1lqo54qNnFXbImRIC2tYhmEQuo4xUWtjkODY0B29rZyyEwrhy
 UNG/RalCKSQT21h3jQeM+QzFHPwTXS4Hku+rabfSN3IKmpqcyuWdTri4RBKm1r0RJg2mdvZoDH/
 bqRHOqrNsDuvbd0u3cOElMpaK/oGXtNdNDxB4mtYhdX9KHahFs9ykt+vM57DLlGcJdHQgsIY03n
 716OfXhIzS6cTt2jOlnyR32iqddMciJXQvBp8yzHl4/juJG2YskWqRUIZUVX8r++j+mSnflNW9i
 R6Rp5qr7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_01,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230000
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 8/25/25 20:03, BALATON Zoltan wrote:
> On Mon, 25 Aug 2025, Harsh Prateek Bora wrote:
>> On 8/25/25 17:52, Thomas Huth wrote:
>>> On 25/08/2025 14.08, Harsh Prateek Bora wrote:
>>>> On 8/25/25 17:28, Thomas Huth wrote:
>>>>> As I said, qemu-system-ppc64 is currently a full superset of 
>>>>> qemu-system- ppc. The ppc64 binary contains all the 32-bit code, 
>>>>> you can perfectly run a "g3beige" or "bamboo" machine with 
>>>>> qemu-system-ppc64, too. By disabling the ppe42 code in the ppc64 
>>>>> binary, this would now introduce an execption to that unwritten 
>>>>> rule, so I'd expect that we'd not rather want to do this now.
>>>>
>>>> My understanding is that above holds true only for default builds which
>>>> builds all targets. We certainly do not build 32 bit ppc code when 
>>>> using
>>>> --configure target-list=ppc64-softmmu. (we have ppc-softmmu for 32 
>>>> bit though)
> 
> We do build 32-bit machines in ppc64-softmmu but leave out 64-bit from 
> ppc-softmmu so it's only one way.
> 
>>> Just give it a try:
>>>
>>>   ./configure --target-list=ppc64-softmmu --disable-docs
>>>   make -j$(nproc)
>>>   ./qemu-system-ppc64 -M g3beige
>>>
>>> ... works perfectly fine for me.
>>>
>> This would work because the respective code is not restricted with 
>> #ifndef TARGET_PPC64.
>>
>> However, there are instance like below in hw/ppc/mac_oldworld.c:
>>
>> static void heathrow_class_init(ObjectClass *oc, const void *data)
>> {
>>    MachineClass *mc = MACHINE_CLASS(oc);
>>    FWPathProviderClass *fwc = FW_PATH_PROVIDER_CLASS(oc);
>>
>>    mc->desc = "Heathrow based PowerMac";
>>    mc->init = ppc_heathrow_init;
>>    mc->block_default_type = IF_IDE;
>>    /* SMP is not supported currently */
>>    mc->max_cpus = 1;
>> #ifndef TARGET_PPC64
>>    mc->is_default = true;
>> #endif
> 
> This is only because the default machine for ppc64-softmmu is different 
> than for ppc-softmmu as the 64-bit machines don't exist in ppc-softmmu 
> but ppc64-softmmu had different default machine before machines from 
> qemu-system-ppc got included in qemu-system-ppc64 so it kept that. 
> (Looks like the default used to be mac_newworld before commit 
> 159f8286b760dea but wasn't changed to match but to something else.) The 
> default machines are arbitrary, we could make "none" the default and 
> always require users to supply -machine but that would break existing 
> command lines so this wasn't done.
> 
>> Similarly, we have multiple instances with #else block for #ifdef
>> TARGET_PPC64 which doesnt get compiled with ppc64-softmmu, but only with
>> ppc-softmmu meant for 32-bit targets. See target/ppc/excp_helper.c for 
>> example.
> 
> This is again leaving out 64-bit code from ppc-softmmu but as Thomas 
> says 32-bit machines are always included in qemu-softmmu-ppc64. I can't 
> find the commit which changed this, previously we had these to be 
> separate and since some types are different in ppc64-softmmu it wasn't 
> clear if that could cause any problems for 32-bit CPUs and machines so 
> ppc-softmmu was kept until that's cleaned up which never happened. There 
> are also some pecularities in some machines like mac_newworld that 
> behaves differently in qemu-system-ppc and qemu-system-ppc64 and the 
> potentially lower performance of qemu-system-ppc64 in emulating 32-bit 
> machines which is why we still have ppc-softmmu.
> 

Ok, I see. So, if we wish to keep the 32-bit machines supported with 
qemu-system-ppc64, we will have them co-exist with run-time checks for 
!ppc64 and/or "unlikely" operations in the hot path routines, which 
wouldnt be needed otherwise. I hope we can deal with run-time checks for 
!ppc64 if such ops increase.

Thanks to Thomas and you for clarifying this.

regards,
Harsh

> Regards,
> BALATON Zoltan
> 
>> regards,
>> Harsh
>>
>>> AFAIK we don't have a switch to disable 32-bit code in the ppc64 binary.
>>>
>>>   Thomas
>>>
>>
>>


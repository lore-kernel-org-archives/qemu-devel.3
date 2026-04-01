Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC55D2ED0A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 13:44:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7vrN-0006jq-Cf; Wed, 01 Apr 2026 09:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w7vrB-0006Z8-7g
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 09:43:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w7vr8-0000N7-Oi
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 09:43:40 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6313jV0L3206997; Wed, 1 Apr 2026 13:43:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=5sxjMg
 anTxHqc+uKe3R6Eup60Q1OUxNsFAOsK2sHfFQ=; b=pgwch2o+344MRxO+pGGnno
 fuaAtGiNftkkTJaja7SFJO9/sUxn8gvN6qyoR8LyE2Z/1O+NhtW7huhabnYg9qnp
 UgUpU+KcvFCCFID3OFTIs7gsQyOdZBVmyriskrfaZwsUvcxK9P8jR8dtrqmyQ/lg
 6bmp/WqOuGPJdhzk3sDIkzqzDqr3XvrOJWiqQEAuyqF763VsyCHTdiWKHR4oTqno
 wvU+O93X4+huvF3d3dGd5i1F+VXKN7KQe+l/MP5nAwg2yksxnaYz2W7/SfazpgK2
 V3JQtnMJM3USMBXeit0LLLpQupYSspFSc/UePjSj+1p7S3Hoo41mqHIW65bKyvWw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66ms7jna-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Apr 2026 13:43:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 631BpOaL022266;
 Wed, 1 Apr 2026 13:43:29 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6tan5r4s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Apr 2026 13:43:29 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 631DhSPU22479428
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 1 Apr 2026 13:43:28 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1AF5058054;
 Wed,  1 Apr 2026 13:43:28 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CE51A5805A;
 Wed,  1 Apr 2026 13:43:26 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  1 Apr 2026 13:43:26 +0000 (GMT)
Message-ID: <90bb955a-c951-4bf0-a77f-084096f12423@linux.ibm.com>
Date: Wed, 1 Apr 2026 09:43:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 7/7] hw/tpm: Increase TPM TIS max buffer size to 8192
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 marcandre.lureau@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
References: <20260319135316.37412-1-armenon@redhat.com>
 <20260319135316.37412-8-armenon@redhat.com>
 <1334de4e-710c-4daf-aefd-3eee855aa35b@linux.ibm.com>
 <b6aed41c-c5fe-415f-8523-fb1b34ff77ec@linux.ibm.com>
 <acywxssfdmBqCIM3@fedora>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <acywxssfdmBqCIM3@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=J6enLQnS c=1 sm=1 tr=0 ts=69cd2102 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=xt6ew7UTAAAA:8
 a=NEAV23lmAAAA:8 a=20KFwNOVAAAA:8 a=BpXkEFmCJgDmFmsYqXkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=tn93DeGZTgJ6DdWMtdD4:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDEyMyBTYWx0ZWRfX1JHbkQpc7K+C
 nqkkMJMxP74HKW3LiwaHIzw2fC3aEsHvcFt4TWnwiYAkd2Enso+JrmWQ0JCEDYdhYPwJAMZQgvt
 8zE0VIKxqUXc3gsCI0guyQbPH5By1ZLvX3biEQpwUQmsE5d0WzilecBvAGlhK04xUWhXeaE59w3
 jkNPpsgf1ECRXUUAfFWbnJ1KmmmOgRFdQP1D0R+QxDEypFTLVc/7AqDfubU1m5jWgDjYbQYKgZA
 LdM7XnG9rqUmsCWiXlQFQgx7mw3aSiLIegopzZEk73+9M6EfKv0RJRm88w5C9OgrZ4LKzoUr7K/
 jyYdzPMISa9Ly/A/i00meGtwQR7fbcMX+cQWRZwVzsPn2zhZCh1Sc1c2moG/7PJlNEJq3f5ff4P
 EsCpA+h1w9I/V2s1zPQabDtGJW2cOqOq2RgnB4EFGb8WeIlR8zbigMI2NBvu/ZdlDUZqVuZJ2Vj
 +NYy3hqT5Yh909aggpQ==
X-Proofpoint-GUID: _uLqagVhCNA5hRnKf21xbRqjKNCBB-m7
X-Proofpoint-ORIG-GUID: X2hhu6eu2sWdFo_HV8jkvwBZVA9Mxmlk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010123
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 4/1/26 1:44 AM, Arun Menon wrote:
> Hi Stefan,
> 
> Thank you for looking into this and providing with the additional
> patches to handle TIS interface.
> 
> On Tue, Mar 31, 2026 at 03:31:43PM -0400, Stefan Berger wrote:
>>
>>
>> On 3/20/26 2:57 PM, Stefan Berger wrote:
>>>
>>>
>>> On 3/19/26 9:53 AM, Arun Menon wrote:
>>>> - Double the size from 4096 to 8192 so that we can have bigger buffer
>>>>     enabling support for PQC algorithms in the TPM TIS interface.
>>>> - v185 of TCG TPM rolls out PQC algorithm support. [1]
>>>>
>>>> [1] section 46 https://members.trustedcomputinggroup.org/wg/TCG/
>>>> document/previewpdf/45151
>>>>
>>>> Signed-off-by: Arun Menon <armenon@redhat.com>
>>>> ---
>>>>    hw/tpm/tpm_tis.h | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/tpm/tpm_tis.h b/hw/tpm/tpm_tis.h
>>>> index 184632ff66..0df35d5a54 100644
>>>> --- a/hw/tpm/tpm_tis.h
>>>> +++ b/hw/tpm/tpm_tis.h
>>>> @@ -33,7 +33,7 @@
>>>>    #define TPM_TIS_IS_VALID_LOCTY(x)   ((x) < TPM_TIS_NUM_LOCALITIES)
>>>> -#define TPM_TIS_BUFFER_MAX          4096
>>>> +#define TPM_TIS_BUFFER_MAX          8192
>>>
>>> Unfortunately TIS uses a fixed-size buffer that would now become bigger:
>>>
>>> typedef struct TPMState {
>>>       MemoryRegion mmio;
>>>
>>>       unsigned char buffer[TPM_TIS_BUFFER_MAX];  <-- now 8192; before 4096
>>>
>>>
>>> static const VMStateDescription vmstate_tpm_tis_isa = {
>>>       .name = "tpm-tis",
>>>       .version_id = 0,
>>>       .pre_save  = tpm_tis_pre_save_isa,
>>>       .fields = (const VMStateField[]) {
>>>           VMSTATE_BUFFER(state.buffer, TPMStateISA),    <-- now 8192;
>>> before 4096
>>
>> This will have to become VMSTATE_PARTIAL_BUFFER and the rest is saved with
>> VMSTATE_BUFFER_START_MIDDLE if necessary.
>>
>>>           VMSTATE_UINT16(state.rw_offset, TPMStateISA),
>>>
>>> Problem would be if an older version of the TIS (with size 4096) then
>>> receives this 8192 buffer, we would (probably) get a buffer overflow.
>>
>> I created 2 more patches for the TIS. It's now also in my branch here:
>>
>> https://github.com/stefanberger/qemu-tpm/commits/crb-chunking/
> 
> Looks good to me.
> 
>>
>> Both TIS and CRB can now transfer >4096 bytes packets.
>>
>>>
>>>
>>>
>>>>    typedef enum {
>>>>        TPM_TIS_STATE_IDLE = 0,
>>>
>>>
>>
> 
> Is it okay if I incorporate your commits, including the tests and
> profile enabling support into my next revision of this series?

Yes, that's okay. Unfortunately the test will not work for most people 
right now. The default-v2 profile is available via swtpm in git master 
but it doesn't support ML-DSA since libtpms code with PQC is not public, 
yet...

> 
> 
> 
> Regards,
> Arun Menon
> 



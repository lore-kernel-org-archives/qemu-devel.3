Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6101BCCFA13
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 20:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIYEb-0007DK-7c; Thu, 30 Apr 2026 16:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wIYEW-0007Cx-Ed
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 16:43:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wIYEU-0002DT-4X
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 16:43:39 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63UK4i2w1524774; Thu, 30 Apr 2026 20:43:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=5mrz55
 daiISJ6pI6GaU0U2Is1OXEbP/mYmQarNB2O60=; b=hxIP3V6o+j59k7JSbpmdRL
 +WR9kAk27o3wuLUOWE3f3YfaZqgrFRN4OdeyBXpAnm3T/DkNeX2aqKdZenEBekPd
 /l34miVSsMZZ/SzzbAJV0+YVLUBBYNqovG/NPg7CZBeEUHV+pUHQgjULDfl0Z33E
 kuezyjtK3pf11KURLDOMVQARmGxXCp8f8P9X43FqZjV93wJBVglJCb/i5xltXYOA
 xnVQfTNJQu2EJWOCD4m475fSji0ONon2Qs5uP4FEfA72kDzrcUSerm1OAC7wQ+6P
 X3mm8/TN6XPkfFL/SITOKW5u0HAAEbzc54f3t+eQd203Lzy3w10OxMW4FT5udJTQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn8vr0pu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Apr 2026 20:43:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63UKdFrV003255;
 Thu, 30 Apr 2026 20:43:28 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8xkcqu8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Apr 2026 20:43:28 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63UKhS0x32572074
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Apr 2026 20:43:28 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6195C5805C;
 Thu, 30 Apr 2026 20:43:28 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E21A75805A;
 Thu, 30 Apr 2026 20:43:27 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Apr 2026 20:43:27 +0000 (GMT)
Message-ID: <0544d36a-89b4-4948-9fb5-8cb013842fc7@linux.ibm.com>
Date: Thu, 30 Apr 2026 16:43:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm: Dynamically allocate tpm-tis buffer
From: Stefan Berger <stefanb@linux.ibm.com>
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20260427200134.453022-1-armenon@redhat.com>
 <765f0577-ee8f-4944-93fe-bb93e420668f@linux.ibm.com>
 <afBbLDmdYFY5feJx@fedora>
 <84607c2e-1da9-43d2-8a5b-e50e91c0f8ba@linux.ibm.com>
 <4b5c983e-8bbb-4851-bb0f-f478ad14121b@linux.ibm.com>
 <afJk9Lsn25UQOnwE@fedora>
 <43171c3b-339c-4335-b79b-387442048b11@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <43171c3b-339c-4335-b79b-387442048b11@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CIIamxrD c=1 sm=1 tr=0 ts=69f3bef1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=NEAV23lmAAAA:8
 a=iXWs5cuIQ_BhVmYrtoMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: sFNw2TNKp33bX5P7kO9GDKb8012chhyt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDIxMCBTYWx0ZWRfXy2MEsW4Heb0J
 CYShegceA5bbQhFuzekN3P5o5a9s2cBmYwT5ldkEYK74eTFskzWnwpHpQaPMHBG/4VFkj6aAW0z
 4lALsRnUi3KcWvEMKOIFb4AGKM2+C7EIb0IoCDw+QUDe/CR2SeGMTsj37owXUN3JwXrOoZNO5Tq
 sUKSE3Bi+dUwR+70QygZhq5aNmwsYcmKz++Nf84sw9xAFf2i8SJ/cktrndbgZwCmd/wrEnKy+MS
 2mCfpkXH3Qpa8KVHZ20Qtub/TIs0/8KxS6tl40bxvltJSVK/xFx8u1yeD6qzHQZXAzusJPB24vx
 GUqxqOtxCkW2lR7/KH/lkSb0B1/LuP8G/5P+7rwTQ+9QpYjF8F0e/v7DW7ueobvNcjAZafhz+ov
 xAZRZzggZuPam66SIXQi+YN3RpAd/gmksiG/E7682JfJPyrJkiwIAOSd9pteM7wMbaa8nrvKZZR
 1eTYheeh4bzVD93sggQ==
X-Proofpoint-GUID: sFNw2TNKp33bX5P7kO9GDKb8012chhyt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300210
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 4/29/26 11:40 PM, Stefan Berger wrote:
> 
> 
> On 4/29/26 4:07 PM, Arun Menon wrote:
>> Hi Stefan,
>>
>> On Wed, Apr 29, 2026 at 02:15:16PM -0400, Stefan Berger wrote:
>>>
>>>
>>> On 4/28/26 8:57 AM, Stefan Berger wrote:
>>>>
>>>>
>>>> On 4/28/26 3:01 AM, Arun Menon wrote:
>>>
>>>>>>
>>>>>> With MAX() it can now be bigger than TPM_TIS_BUFFER_MAX if the
>>>>>> backend says
>>>>>> so -- hm...
>>>>>
>>>>> TPM_TIS_BUFFER_MAX is still 4096.
>>>>
>>>> Oh, I had still based my patches on your TPM_TIS_BUFFER_MAX increase to
>>>> 8192 bytes. Let me fixes this along with a few other things. I will let
>>>> you know.
>>>>
>>>> I have another series that I will post now that can be applied to
>>>> master. It's adding a test for TIS over I2C but I will need to extend
>>>> that one also with the large transfer test case then.
>>>>
>>>>
>>>
>>> So I have resolved this issue now along with a few other things. My 
>>> branch
>>> is here: https://github.com/stefanberger/qemu-tpm/tree/work-tpm-for-11.1
>>>
>>> - I have applied the i2c swtpm test case series first since it could be
>>> easily upstreamed first
>>> - Then your patch "migration/vmstate: Add VMState support for 
>>> GByteArray"
>>> - Then the CRB chunk + TIS extended buffer support series. I modified my
>>> patches (last 4 in that series) to
>>>    - increased MAX_TIS_BUFFER_SIZE to 8192
>>>    - added migration blockers dynamically for TIS whenever >4096 
>>> bytes are
>>> either in the request or response; remove them later on again when 
>>> device
>>> goes into ready state for example
>>>    - added large transfer test also for i2c
>>>
>>> Please pick up those patches for v6 posting, or otherwise you can 
>>> split your
>>> v5 series up into CRB-only support for v6 and I post my (last 4) patches
>>> later on.
>>>
>>
>> Thank you. I agree. I will post v6 as CRB-only support. The GByteArray
>> patch is already accepted. The complex TIS changes can be posted
>> separately later.
>>
>> Regarding the TIS buffer: I saw you implemented the migration blockers
>> and 8192-byte increase in your branch. Should I discard my
> 
> It's quite dynamic with the blocker being set when 4097 bytes of a TPM 
> command were received or when a TPM response with > 4096 bytes is 
> received. The blocker is removed when the device goes into ready state. 
> The intention is to allow a user to choose an old machine type with a 
> PQC-enabled swtpm+libtpms and be able to migrate to an older version of 
> QEMU unless the blocker was set. Correct me if I am wrong in my thinking...

Another solution would be to limit the 8kb buffer to 4kb for 11.0 and 
older machines.



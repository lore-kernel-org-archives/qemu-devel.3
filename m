Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E995C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 17:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2DdF-0006do-Gb; Wed, 01 May 2024 13:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1s2Dd7-0006YA-9Y
 for qemu-devel@nongnu.org; Wed, 01 May 2024 13:20:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1s2Dd5-00084v-1m
 for qemu-devel@nongnu.org; Wed, 01 May 2024 13:20:29 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 441H29j9004461; Wed, 1 May 2024 17:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=6AEyHgxAPcn0geOTuRQaPnunlkzycD6EWCyBXBarfNI=;
 b=tRLxY4O0wuOdbfDhkBZKUMkx5IYEA+CKR7msxZa1MZmkqQFOPHU3tmg/syDKeUnSsrkM
 crOfdGYhUF2AHqVjlgv8YWgBuqgeQvjl7GFEA20koXxb0bReVy6HZcUuznIk+rl32FK4
 xtLJ0BSj+vfAr9jW6HZGs1nT8tbih3yZ+lWQo/kFbx0bTdb0EZlonMTwQYAWgUJhVVnD
 obd6MZUldCLYw921VgzEPDbhzshRcr8bcaQEzOYPDJ/vrvcxd8Ugk3CM1WSdkDuLL1gr
 9QX/6VGbdp5/k69h9+7elwbuJfRvEeOIKK5ajK7n93zsjSwVjTj5BkFWwo0EnOms5c3U BQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xussd813d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 May 2024 17:20:23 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 441HKMaX003247;
 Wed, 1 May 2024 17:20:22 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xussd813a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 May 2024 17:20:22 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 441GWsHM003036; Wed, 1 May 2024 17:20:21 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xscppkhux-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 May 2024 17:20:21 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 441HKJgG45548096
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 1 May 2024 17:20:21 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DDAA658068;
 Wed,  1 May 2024 17:20:18 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D5E458064;
 Wed,  1 May 2024 17:20:18 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  1 May 2024 17:20:18 +0000 (GMT)
Message-ID: <b7bc97f6-ba49-4ee8-8c59-cf79712933f1@linux.ibm.com>
Date: Wed, 1 May 2024 13:20:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/2] tpm: add backend for mssim
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20240430190855.2811-1-James.Bottomley@HansenPartnership.com>
 <20240430190855.2811-3-James.Bottomley@HansenPartnership.com>
 <2825c9bb-a4d5-4196-b025-5f46571b3953@linux.ibm.com>
 <c97f84c7d6e026450644466313b6347b00841a43.camel@HansenPartnership.com>
 <8347cf6a-7c9f-48f8-a3a7-4053aefd2176@linux.ibm.com>
 <f10810369c716e53dc9568868cb8b83efbe5be19.camel@HansenPartnership.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <f10810369c716e53dc9568868cb8b83efbe5be19.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aqwXvvyJ7Kctz2DlyeFsudPNkGyIy1sS
X-Proofpoint-ORIG-GUID: Jyv06TUd5WPslnWtddcbVZDwQny7CxBM
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0
 phishscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 mlxlogscore=881 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405010121
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 5/1/24 12:52, James Bottomley wrote:
> On Wed, 2024-05-01 at 12:31 -0400, Stefan Berger wrote:
>>
>>
>> On 5/1/24 12:21, James Bottomley wrote:
>>> On Tue, 2024-04-30 at 17:12 -0400, Stefan Berger wrote:
>>>> On 4/30/24 15:08, James Bottomley wrote:
>>> [...]
>>>>> +The mssim backend supports snapshotting and migration by not
>>>>> resetting
>>>>
>>>> I don't thing snapshotting is supported because snapshooting
>>>> would require you to be able to set the state of the vTPM from
>>>> the snapshot you started. I would remove the claim.
>>>
>>> I thought we established last time that it can definitely do both
>>> (and I've tested it because you asked me to).  Snapshotting and
>>> migration are essentially the same thing, with snapshotting being
>>> easier because it can be done on the same host meaning the same
>>> command line parameters.  If you migrate to a different host you
>>> need the socket to point back to the host serving the vTPM.
>>>
>>> To do this easily you simply keep the vTPM running while the VM is
>>> undergoing snapshot and migration.  If you're thinking of and
>>> extended down time for the snapshot, then it's up to the vTPM
>>> implementation to store the state (or simply keep it running for an
>>> extended time doing nothing).
>>
>> Which part of the code injects the state into the vTPM so that it
>> resumes with the state of the TPM (PCRs, NVRAM indices, keys,
>> sessions etc.) from when the snapshot was taken?
> 
> We've had this conversation before too:
> 
> https://lore.kernel.org/qemu-devel/f928986fd4095b1f27c83ede96f3b0dd65ad965e.camel@linux.ibm.com/T/#u
> 
> But the synopsis is nothing does.  The design is to be entirely
> independent of vTPM implementation: it will actually work with any TPM
> obeying the simulator IP protocol (MS reference, ibmswtpm2 or even your
> swtpm) but the price of this is that the user has to preserve the vTPM
> state, by whatever means they deem appropriate, independently of the VM
> snapshot image.

Unless your backend can retrieve the state upon snapshot save and inject 
state into the vTPM upon snapshot resume, 'snapshotting' is not working 
(correctly).

> 
> James
> 


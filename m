Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E152C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 16:32:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Crj-0008MC-4w; Wed, 01 May 2024 12:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1s2Crf-0008Lo-AJ
 for qemu-devel@nongnu.org; Wed, 01 May 2024 12:31:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1s2Crd-0008Ni-9P
 for qemu-devel@nongnu.org; Wed, 01 May 2024 12:31:27 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 441FxFnd031290; Wed, 1 May 2024 16:31:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=qvCkAvE+fgY/AJ19oMfv1tcQk+szB6hIJ40KC27YU6Q=;
 b=b8xnp7rHyFevZtkuDTg7R05zdDohMyDqBdmmyVMYEc753GfMiZYRVuwfABg8o7+onjSH
 mXle33MIRpIVjtk2GLOiGdS4qRGF1NAbcDB9PF48s2fN1F4jAQSnLOeOc8FGNYAVJCsk
 ltO0Li7imU+VhexyOP+sQ8z3N6Sv3WOCi7Y1ITuEPd21jUJ/rgKuVerwLFvrqUrkszXS
 U8u0xe6gmfcEKnkdio4w8SAgNwjbqGIG1b/aQ+YoMpNEUoM593lWMlOFgaw7k2u0d9pb
 bfx37d4vtVV0luXKUl/OIISYwe/1BJ1YSzRWYn3AbINJKMeUn2ZzS5uuIETALuOBBy45 HQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xurc8842e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 May 2024 16:31:20 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 441GVKwx013206;
 Wed, 1 May 2024 16:31:20 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xurc88429-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 May 2024 16:31:20 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 441EWCl1011730; Wed, 1 May 2024 16:31:19 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xsdwmb2wr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 May 2024 16:31:19 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 441GVGTw590380
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 1 May 2024 16:31:18 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E52E158069;
 Wed,  1 May 2024 16:31:14 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A747E5805D;
 Wed,  1 May 2024 16:31:14 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  1 May 2024 16:31:14 +0000 (GMT)
Message-ID: <8347cf6a-7c9f-48f8-a3a7-4053aefd2176@linux.ibm.com>
Date: Wed, 1 May 2024 12:31:14 -0400
MIME-Version: 1.0
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
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <c97f84c7d6e026450644466313b6347b00841a43.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SsbUH-7I3MRBajkYOl64BXekLOxr6ecf
X-Proofpoint-ORIG-GUID: 83hQR9n91VFsKBYN0-KPrvrBXe-K2qEy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=637 clxscore=1015 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405010116
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 5/1/24 12:21, James Bottomley wrote:
> On Tue, 2024-04-30 at 17:12 -0400, Stefan Berger wrote:
>> On 4/30/24 15:08, James Bottomley wrote:
> [...]
>>> +The mssim backend supports snapshotting and migration by not
>>> resetting
>>
>> I don't thing snapshotting is supported because snapshooting would
>> require you to be able to set the state of the vTPM from the snapshot
>> you started. I would remove the claim.
> 
> I thought we established last time that it can definitely do both (and
> I've tested it because you asked me to).  Snapshotting and migration
> are essentially the same thing, with snapshotting being easier because
> it can be done on the same host meaning the same command line
> parameters.  If you migrate to a different host you need the socket to
> point back to the host serving the vTPM.
> 
> To do this easily you simply keep the vTPM running while the VM is
> undergoing snapshot and migration.  If you're thinking of and extended
> down time for the snapshot, then it's up to the vTPM implementation to
> store the state (or simply keep it running for an extended time doing
> nothing).

Which part of the code injects the state into the vTPM so that it 
resumes with the state of the TPM (PCRs, NVRAM indices, keys, sessions 
etc.) from when the snapshot was taken?


> 
> 
>> Rest LGTM.
> 
> Thanks!
> 
> Regards,
> 
> James
> 


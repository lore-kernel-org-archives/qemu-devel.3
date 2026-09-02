Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4509DC624D6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 14:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1lqb-0002Ee-87; Wed, 02 Sep 2026 10:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x1lqZ-0002EG-EB
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 10:21:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x1lqX-0007l7-Ot
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 10:21:51 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682CVn5p4186871; Wed, 2 Sep 2026 14:21:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=X98fhH
 ZCL2ibGylLg3Ynng+QpNdW5zSuhpPhVAUpjhE=; b=OjqaWoKCL0xZz2czkkdGto
 xuB1Wnvi4zNHucWLwfOULp13hXeW67Iczs/fuREF9TQZBiWbcChRZXY5AkMEhPAb
 +QvPufo34Tj0nwzIypWok33dgK75ADOxILnPZfe+Zp4lobC9BGRDh2uV44AGfnnO
 3877xSREQkDN7mBxfqhP8I/d4d2s/wiv8lJJykr+COeLUwZPvNReYOcKQukymnpD
 t1c54BfsDaWtuNGoHu2zdv58Vt7wj68VFn1XvcjV+VyUQ9VoTNsiUb/YuCQVoaZf
 XpR39W7q1puAClh22EjPNzFEhI/m3mBDblzuMoPCkf95a/eI651WBmi86oOk5/rQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq54y5bf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Sep 2026 14:21:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 682EBJwA010102;
 Wed, 2 Sep 2026 14:21:44 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8hj6jr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Sep 2026 14:21:44 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 682ELi0u26018484
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 2 Sep 2026 14:21:44 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EB41658052;
 Wed,  2 Sep 2026 14:21:43 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A253E5805E;
 Wed,  2 Sep 2026 14:21:41 +0000 (GMT)
Received: from [9.47.158.153] (unknown [9.47.158.153])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  2 Sep 2026 14:21:41 +0000 (GMT)
Message-ID: <c9a3286a-79ea-4e3d-8b9c-9c7acc2001fd@linux.ibm.com>
Date: Wed, 2 Sep 2026 10:21:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Remove stale contact info for Stefan Berger
To: John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, QEMU <qemu-devel@nongnu.org>
References: <20260901195334.463267-1-jsnow@redhat.com>
 <CAJ+F1CKA-UPwzx7XLLhvA+VW8PuDQGbXKXDBK0mVfo0E4C6-hA@mail.gmail.com>
 <CAFn=p-Zix9rEXMQsCj=zanoOUXbS_dSTnWY3OaiLRSN4viTtjA@mail.gmail.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CAFn=p-Zix9rEXMQsCj=zanoOUXbS_dSTnWY3OaiLRSN4viTtjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEyNCBTYWx0ZWRfX4qz3VcQs+yQi
 a5w7X7V0tL82SC7vNbndl8SeG1yI6ZXzNLpuQiK9ZTq+nJQCloqiNH3AEmQYrY4j6L7rJad19SS
 fqNyF5Ru2e3iXAeW/CK/v2ftfBgLfREkcmASKK0O47j63DWXeCmPwxPeUNlbFU6dOKMoMoevQZM
 jFR0EF18Jfa87i4eyCr+X6tKEzHnTbc3sJgXGTINWa91hwpr/dAdZgs42vtg1iDQto96R6tnniW
 xqFx0hpXiemwyaudBvrrGfMTOyLBkZQMjW52OWG6AMWNmME5ZX1r8yaB3aoYvUaT7cKOHO/0slq
 BY/awAOshn+1qi/e7FqP4tUoNAy9NXRtn2N4ovADb9GlhqBl/hp3THZvRni6cD0GhoEEJ6u1fci
 AgAZB7+TOJs0xWqOIMDY7rr8vujnas/Mq0os468nkjie/8juGURok+T73HvtYlByeAB0rjWWtNM
 FJa/wo9cG7K9Ja8Ko4Q==
X-Proofpoint-ORIG-GUID: XvCS1d-2bjb-fR9aPVO053mpkGAm0Uvr
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a9830fa cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=pGLkceISAAAA:8
 a=20KFwNOVAAAA:8 a=UI_CKSYRHhG4zC55DrsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zgiPjhLxNE0A:10
X-Proofpoint-GUID: a_Gm7mdbX7mqKnf8K1jSEBWjE8O7v9tt
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEyNCBTYWx0ZWRfX+/u68oH/hJT4
 j8YG1Xiv6rnuydGjmt5Ebk/kNFU4rE8qFzV+ilGai+tQ8OYMtKa3xdzjUztd+qkwcs0jWmlCywN
 rkkOJgE1VwFOAZkqDQf3hh5NOUGecmU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020124
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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



On 9/1/26 6:11 PM, John Snow wrote:
> On Tue, Sep 1, 2026 at 4:18 PM Marc-André Lureau
> <marcandre.lureau@gmail.com> wrote:
>>
>>
>> Hi
>>
>> Le mar. 1 sept. 2026, 23:54, John Snow <jsnow@redhat.com> a écrit :
>>>
>>> I was unable to get in touch with Stefan and I am not currently sure
>>> if this module is maintained or not. To prevent an avalanche of
>>> bounced emails, remove his contact information.
>>
>>
>> Really? There must be something wrong. He is a very responsive and active maintainer.
> 
> All of the emails I have are bouncing; I hope they turn up! I would
> love to be proven hasty.

There was a problem with my email account but only over the last few 
days. The problem should be resolved now.

> 
> --js
> 
> 



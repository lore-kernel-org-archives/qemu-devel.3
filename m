Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E67FC3ABA3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 10:26:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAnah-0004xv-Cw; Fri, 02 May 2025 06:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uAnZs-0004G4-B8; Fri, 02 May 2025 06:25:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uAnZo-0000uI-GZ; Fri, 02 May 2025 06:25:07 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 542A47Ha029870;
 Fri, 2 May 2025 10:24:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=OSo0cG
 W8fVUQf+2fci42UWiutGwLweeHCFtaMRmmLww=; b=PzYenpRNoFR+yd6tmY3CQH
 eW4U7VPAy1FOJkdG/bMAiy9vpYWw9iPwhd2+t1YZda6DzLP4sJVV6wj9jQ4BpkOD
 MQM6l4zSma9GCNk+zMBWdwEHJuF3USK/Qg2FSLSCmhbF9unNI2W7QQZbJvwLxz4F
 GNfcmI2EUuBnryAuftupHMTQRFQt0o1awtSyaZsCjp7J0Hp0qhV3F7TGq9TWBfd0
 hZ38EMGe6x3lj60S+Yva5yVJBehyttcjQJIH6OoKA13dNJzYaipbqZgkFxT0Lx0H
 MCgc6uBjgzqQeUOrVAufUGY3khTYVzajevZtXHbsNOh2smKzqbiQ7EsTeOR0THfw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46cuyk82bm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 May 2025 10:24:51 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 542AKo8W005213;
 Fri, 2 May 2025 10:24:51 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46cuyk82bg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 May 2025 10:24:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54267cUi000700;
 Fri, 2 May 2025 10:24:49 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469atpsd9e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 May 2025 10:24:49 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 542AOnln54788368
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 2 May 2025 10:24:49 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3714D58056;
 Fri,  2 May 2025 10:24:49 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5248658052;
 Fri,  2 May 2025 10:24:47 +0000 (GMT)
Received: from [9.39.17.237] (unknown [9.39.17.237])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  2 May 2025 10:24:47 +0000 (GMT)
Message-ID: <c3da8671-7e7b-4fe5-83a3-6b004e1e3255@linux.ibm.com>
Date: Fri, 2 May 2025 15:54:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/14] ppc/spapr: remove deprecated machine pseries-3.0
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: npiggin@gmail.com, danielhb413@gmail.com
References: <20241007153838.1085522-1-harshpb@linux.ibm.com>
 <20241007153838.1085522-15-harshpb@linux.ibm.com>
 <68da6aab-eb1e-4c26-888f-54a1c8cad987@kaod.org>
 <13dbdee6-17f9-4fba-a8b2-ff4688496807@kaod.org>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <13dbdee6-17f9-4fba-a8b2-ff4688496807@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5p2NJheSSqHAcD1Q8IPLyQyddkcIghbZ
X-Proofpoint-ORIG-GUID: jIttFRh3zTGfqJl-ym2WGSK1rwfdK1rt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDA3OSBTYWx0ZWRfX+ntsR5HEStn2
 I46pPFvfXHyUTpw2+JNDulXFg5ShHAJkx/bmUQBUgIVZZpgPl7Sa/8zsjYtieaAxdjxaj+GKq2X
 ETUWldTL7sO/IkOaxetlKCNh6K0NWKNuAN0W6tID4V3JzWUbWo8fuW8G9ejuL2SmyHASparL+Jl
 3gk4JVlLtSW/umOCseeRXLSDCr7jr1Z/XnEz0JqrwP/tBU0jUYb9bZsVH7TaWihpqLhyLEWiPKQ
 eubVrGyqXkIMfHpO14WFyUeU0dL+491ISlAyxXV17U2Q8uyO3/tNEIAR/1hmEInWcAwzJyoVQHC
 ZPtzwfDefkqV9eyUQ4JxFPU2+V142469ruEcNrRi7e+vTSzqxXfiob55ZolZpsk8s9w5jw+dpuO
 KCVUT6E/trd+MeTk+kGwS5Uf1X3yBBpkBYIezB0ivcmtYsFsGA7Vm17QsT75lK/P8WrK5lMH
X-Authority-Analysis: v=2.4 cv=KYTSsRYD c=1 sm=1 tr=0 ts=68149d73 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=f7IdgyKtn90A:10 a=ID6ng7r3AAAA:8
 a=VwQbUJbxAAAA:8 a=aow-egSQAAAA:8
 a=VnNF1IyMAAAA:8 a=GII1vP590xVb74Ji_poA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=naT-Qou_QokA:10 a=RA7C4R-zLikA:10 a=AkheI1RvQwOzcTXhi5f4:22
 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 phishscore=0 malwarescore=0 mlxlogscore=796 spamscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505020079
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
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

Hi Cedric,

On 4/29/25 18:59, Cédric Le Goater wrote:
> Hello Harsh,
> 
> On 10/11/24 07:57, Cédric Le Goater wrote:
>> On 10/7/24 17:38, Harsh Prateek Bora wrote:
>>> As per Qemu's deprecation policy [1], and the mailing list discussion
>>> that happened on [2], pseries-3.0 is more than 6 years old since release
>>> and therefore due for deletion as already deprecated for >3 years.
>>>
>>> [1] https://www.qemu.org/docs/master/about/deprecated.html
>>> [2] 
>>> https://lore.kernel.org/qemu-devel/1d7c210e-d7a6-4233-b555-c99a41f3c4e2@kaod.org/
>>>
>>> While at it, also remove related legacy irq hacks which are now 
>>> obsolete.
>>>
>>> Suggested-by: Cédric Le Goater <clg@kaod.org>
>>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>>
>> I induced you in error. This version has not been deprecated yet.
>>
>> We will have to wait a little longer (2 cycles) to remove it when
>> the automatic deprecation process starts. See c9fd2d9a48ee. You
>> can resend when the 10.1 cycle starts, around april 2025.
> 
> Machines pseries-3.0, 3.1 and 4.0 can now be removed.

Sure, will look into it.

Thanks
Harsh

> 
> Thanks,
> 
> C.
> 
> $ QEMU_DELETE_MACHINES=1 ./install/bin/qemu-system-ppc64 -machine ? | 
> grep pseries
> pseries-10.0         pSeries Logical Partition (PAPR compliant)
> pseries              pSeries Logical Partition (PAPR compliant) (alias 
> of pseries-10.1)
> pseries-10.1         pSeries Logical Partition (PAPR compliant) (default)
> pseries-4.1          pSeries Logical Partition (PAPR compliant) 
> (deprecated)
> pseries-4.2          pSeries Logical Partition (PAPR compliant) 
> (deprecated)
> pseries-5.0          pSeries Logical Partition (PAPR compliant) 
> (deprecated)
> pseries-5.1          pSeries Logical Partition (PAPR compliant) 
> (deprecated)
> pseries-5.2          pSeries Logical Partition (PAPR compliant) 
> (deprecated)
> pseries-6.0          pSeries Logical Partition (PAPR compliant) 
> (deprecated)
> pseries-6.1          pSeries Logical Partition (PAPR compliant) 
> (deprecated)
> pseries-6.2          pSeries Logical Partition (PAPR compliant) 
> (deprecated)
> pseries-7.0          pSeries Logical Partition (PAPR compliant) 
> (deprecated)
> pseries-7.1          pSeries Logical Partition (PAPR compliant)
> pseries-7.2          pSeries Logical Partition (PAPR compliant)
> pseries-8.0          pSeries Logical Partition (PAPR compliant)
> pseries-8.1          pSeries Logical Partition (PAPR compliant)
> pseries-8.2          pSeries Logical Partition (PAPR compliant)
> pseries-9.0          pSeries Logical Partition (PAPR compliant)
> pseries-9.1          pSeries Logical Partition (PAPR compliant)
> pseries-9.2          pSeries Logical Partition (PAPR compliant)
> 


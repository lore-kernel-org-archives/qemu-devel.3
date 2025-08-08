Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F47C87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 07:20:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukHOc-0002Kh-JK; Fri, 08 Aug 2025 03:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1ukHOY-0001l7-FX; Fri, 08 Aug 2025 03:20:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1ukHOP-0007qo-Vf; Fri, 08 Aug 2025 03:20:03 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5781ipej017889;
 Fri, 8 Aug 2025 07:19:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=sVdIAN
 +g4D7hBDoHMxTIcwUZ6ffhMYyq5BTpxtJwGgQ=; b=CjFaT9Uv7tKzztvUJPKCXo
 78VRXYdU6opE8DLHkKgjtzRHipR7sMNYb4CAleykP4AxAcqoO9reUOyGB3JbqAaq
 7juB7ikUIuEEGSnWAZAQFBoFLNM4mESdphNqx3PCuWcyaIdP4n43jbYobR0H+/a/
 t/GMK3pSjJBWtbvLzJzE5Xjx3FRN2//tPc+6Rnt2mS4BzwQCBx/Suu+HjxF0FL0x
 6avTYmE3pR85qA5AZ/b7D7FeZwitzGg7blzSaIKDjT5NsEGJwAsLPJNCnDoeUUoe
 WAquenzn9/jZS1G00Izq+S+HvrRYztTJFuHiT9UvDacMVLuQGckpnzsj4W/THPTA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63ep4e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Aug 2025 07:19:53 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5787Gb11001240;
 Fri, 8 Aug 2025 07:19:53 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63ep4c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Aug 2025 07:19:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5785tGLW001574;
 Fri, 8 Aug 2025 07:19:52 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48bpwr4kdp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Aug 2025 07:19:52 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5787JgnJ62915046
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Aug 2025 07:19:43 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 588865805E;
 Fri,  8 Aug 2025 07:19:50 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 537665805A;
 Fri,  8 Aug 2025 07:19:47 +0000 (GMT)
Received: from [9.124.215.193] (unknown [9.124.215.193])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 Aug 2025 07:19:47 +0000 (GMT)
Message-ID: <46273c1e-c008-4ec6-8ccb-2cf55b467f72@linux.ibm.com>
Date: Fri, 8 Aug 2025 12:49:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/2] Deprecate Power8E and Power8NVL
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Aditya Gupta <adityag@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20250607110412.2342511-1-adityag@linux.ibm.com>
 <5b9e0a81-c2d9-4c55-b761-a43a69ec400c@redhat.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <5b9e0a81-c2d9-4c55-b761-a43a69ec400c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDA1NSBTYWx0ZWRfX9sxZqz0ZRwKs
 JJqcHqQHeREyahk8/UWxTljFVC4UtwZs7WOs49ijTfmNuJTygXjkXOwDIhLDLs6Ie8dQjToQ0Gl
 JuqAVIV+EY0pr/KERvb3C802pPPY1GBrv5RLV7Xo5wBaYLSU4gTSXtcnVLEu1l6yr4gddJyTqOb
 vjgitQ+9uDL2liMqvf14Bhgvanz7XA8IpXP68aSzj78Bzorbn9TLRw/lXi/Fv2FJ/pzn9Jwj0s1
 2a7Jreu+sX6L/ujs0na8ZLFgX6ohpJDqnlz+/w3wfC5yhBNfvjHzeqpU9/N/KkXfKAu5gxavHac
 TonIl9f9vR/Cgax1bvEIiyZKojpAdDzzGwsIA0FZ9X2sBgmSf6MaXjXIreoDM1Z5uaFqLBtZbLy
 o1C0FYajjYcWkxW1Q1DbLwuRamPkjZ50uwqO6nxAYzA+9BBJzfmSFyDjmaDXB7jvfi+ch+Mb
X-Proofpoint-GUID: uO87sP5C3Cn9iPj4Nrw-jdnFeyvaEWvG
X-Authority-Analysis: v=2.4 cv=PoCTbxM3 c=1 sm=1 tr=0 ts=6895a519 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=f7IdgyKtn90A:10
 a=ycksN_SKXF7NdCnFZcMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: TXJP1HVQNN_n-qezLsWNda2jvp4RIZCx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=953 mlxscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508080055
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

Hi Cedric,

On 8/8/25 12:45, Cédric Le Goater wrote:
>> Aditya Gupta (2):
>>    target/ppc: Introduce macro for deprecating PowerPC CPUs
>>    target/ppc: Deprecate Power8E and Power8NVL
>>
>>   docs/about/deprecated.rst |  9 +++++++++
>>   target/ppc/cpu-models.c   | 20 +++++++++++++++-----
>>   target/ppc/cpu_init.c     |  7 ++++++-
>>   3 files changed, 30 insertions(+), 6 deletions(-)
>>
> 
> It's too late for QEMU 10.1. Let's not forget these for the next cycle.

Sure, will add it in ppc-for-10.2 queue.

regards,
Harsh

> 
> Thanks,
> 
> C.


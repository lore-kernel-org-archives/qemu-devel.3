Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B82C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 07:19:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2nBo-0007r4-2Z; Fri, 03 May 2024 03:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1s2nBm-0007jg-Js; Fri, 03 May 2024 03:18:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1s2nBk-0000s8-L9; Fri, 03 May 2024 03:18:38 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 4435vrZK003118; Fri, 3 May 2024 07:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=vSQj1LgiSYWliMNCjXFADwiW7LHnXFq1AhUpVyJPzWg=;
 b=If9l5fvYJM2GqfRJLWl/sPiGRBrLV1F9s4B2bZf/Zvuxfe3ITugJK+kIfATqBj8vEdcm
 5QBcTBUfhdAWiK1iPXnzvxyRpcVOtuAamgJXKMgzdB6P7zmRoSOwJaoIdg3RXrVpPk6d
 yX53S8Rj39KFQvACgu5j9x0p2afAuUFesYpklgoTtEIEs1499JNbEs/9641aeSmk4Pzm
 +ik0VVz6a0BiJOJvcHvRDgeKNLeOVsCBwAYK8FKvLjrYhaKvT7FEDqj7pIrEmNRk5ixX
 fFkoEROz9NrXT6OYyaarCPtIspHPBCZ4OVBE28FKhzrz3JOgtLQi4qwSf23yatB/B2ht Tg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xvt7vr60e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 May 2024 07:18:22 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4437ILQl004330;
 Fri, 3 May 2024 07:18:21 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xvt7vr60b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 May 2024 07:18:21 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 4436YIM1003613; Fri, 3 May 2024 06:53:47 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xscppv9xv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 May 2024 06:53:47 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4436rfVh55836932
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 May 2024 06:53:43 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 446AD2006C;
 Fri,  3 May 2024 06:53:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C893E2005A;
 Fri,  3 May 2024 06:53:38 +0000 (GMT)
Received: from [9.109.199.72] (unknown [9.109.199.72])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 May 2024 06:53:38 +0000 (GMT)
Message-ID: <9f3bf2bb-34d9-4e13-9bdb-cdefea95771d@linux.ibm.com>
Date: Fri, 3 May 2024 12:23:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] ppc: Make Power11 as default cpu type for
 'pseries' and 'powernv'
To: Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20240426110023.733309-1-adityag@linux.ibm.com>
 <20240426110023.733309-10-adityag@linux.ibm.com>
 <3d64c7e6-6128-4723-b7c5-11967b0a7457@kaod.org>
 <D0ZQNVR81YNL.EMCJHV8VARRB@gmail.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <D0ZQNVR81YNL.EMCJHV8VARRB@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4AUoEKTg52-55ifJSoc2ryztkVf40svS
X-Proofpoint-GUID: e684Pb4rGqhA0ojzTkhluiZlTC8TwvB3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_03,2024-05-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=316 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405030051
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
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

On 03/05/24 10:22, Nicholas Piggin wrote:

> On Sat Apr 27, 2024 at 12:32 AM AEST, Cédric Le Goater wrote:
>> On 4/26/24 13:00, Aditya Gupta wrote:
>>> Make Power11 as default cpu type for 'pseries' and 'powernv' machine type,
>>> with Power11 being the newest supported Power processor in QEMU.
>> This is too early. We should merge Power11 support first, possibly in 9.1,
>> and then change default in a future release, 9.2, 10.0
> Agree. Since P10 is the released chip that is what users will want
> to use. Developers can set -cpu by hand.

Yes. I have dropped that patch from my v3.


About v3, I am blocked on a issue due to PCR values being same for P10 & 
P11. Will post the series after that gets sorted out.


Thanks,

Aditya Gupta

> Thanks,
> Nick


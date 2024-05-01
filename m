Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1132FC4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 14:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2B7q-0000X2-PO; Wed, 01 May 2024 10:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1s2B7m-00009Q-BY; Wed, 01 May 2024 10:39:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1s2B7k-0002eh-1n; Wed, 01 May 2024 10:39:58 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 441EWOxt011855; Wed, 1 May 2024 14:39:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=owqMuNs2PuJ+LI4WF5pATtFmVNFysTS4In073xDw06M=;
 b=rXWDpG8ybO4L2YZdSmw2ae0bNdfjwQN/OTGJaLeq1T7GMBs836RuwISVcVMpEE5UUKwm
 0gpzJ7KVpHNSwC5jUmLJMA9a8r0emNGj5xDSWhfvpmAUCiEjgKXhW9tK2tYCMcPxVNdz
 +ftYDMwrG1PUIWeeqlOhCq/DjM1E7CIzjhK0nCeTO4HWVyCZbN5LmueJ3B107H5LWWCe
 fsgYTOwxmaxrfFY6iHs37HcUvlyeGPyGjHd1vWIJIsIjVV0/AIUOQ+4BWvdVbVWJIaJs
 pFZwi11GSKdvZms4BRN1SLHlRRcCUFV0d4PrQeVVrNkuEe1REGzOcdq/YZucCbVhaT4u Cw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xuqjg80h6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 May 2024 14:39:43 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 441EdhFd021383;
 Wed, 1 May 2024 14:39:43 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xuqjg80h4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 May 2024 14:39:43 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 441Dsqni022334; Wed, 1 May 2024 14:39:42 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xsd6mttw9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 May 2024 14:39:42 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 441EdapH44237148
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 1 May 2024 14:39:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6A35A2004D;
 Wed,  1 May 2024 14:39:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D0FA020040;
 Wed,  1 May 2024 14:39:33 +0000 (GMT)
Received: from [9.179.7.120] (unknown [9.179.7.120])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  1 May 2024 14:39:33 +0000 (GMT)
Message-ID: <6263e5b1-853a-41bc-ba24-d3a68ba857c5@linux.ibm.com>
Date: Wed, 1 May 2024 20:09:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] ppc/pseries: Add Power11 cpu type
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20240426110023.733309-1-adityag@linux.ibm.com>
 <20240426110023.733309-2-adityag@linux.ibm.com>
 <d35b2a2d-1307-46bf-81ae-747a0e62d6be@kaod.org>
 <p57z4il36laqlccge3llmbzveepyzad7dokxpoipxh22t2y2s3@tsiegjpijeas>
 <f39f0e4a-6f9f-45f7-9f84-1663f20cd755@kaod.org>
 <358a26db-d447-453d-8313-376f00e8c902@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <358a26db-d447-453d-8313-376f00e8c902@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lcaDCk0zZfdQbUIKWAPapkjRLltkDdRD
X-Proofpoint-ORIG-GUID: KBfx_WW8DeaaGs2qLolTq13xES6rjIVf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_14,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 mlxlogscore=688 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405010102
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
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

Hi Cédric,

>>
>> Skiboot reports :
>>
>> [    0.121234172,6] P11 DD1.00 detected
>>
> It is a DD2.0, with major revision = 0x2, and minor revision = 0. 
> Might need some change in skiboot. Will post a v3 series with changes.
>
The issue was in QEMU, not skiboot.


QEMU sets CFAM id for Power10 as DD1.0 (hw/ppc/pnv.c: 2093):

         k->chip_cfam_id = 0x120da04900008000ull; /* P10 DD1.0 (with NX) */

CFAM is same for Power11, and hence for both 'powernv10' and 
'powernv11', skiboot shows DD1.0.

It should be `0x220da04980000000` for DD2.0.

Should I update the CFAM in a separate patch ?


Thanks,

Aditya Gupta


>
> Thanks,
>
> - Aditya Gupta
>
>>
>> C.


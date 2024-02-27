Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 358FFC5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 09:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1retru-0000wF-QI; Tue, 27 Feb 2024 04:35:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1retrr-0000uo-HT; Tue, 27 Feb 2024 04:35:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1retrj-0007dn-PL; Tue, 27 Feb 2024 04:35:19 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41R9Yuhl030071; Tue, 27 Feb 2024 09:35:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=UHKvTk3K78s+iJUuudFnjK4NuCVr0cYTqnBF8TnFG4w=;
 b=ZvQPtFVSNOzlypjnB3/UEdoFsDlaFebyCN1t+qdT9jx+PEdBHxw7IhAu6sVGBgWCmpwo
 Q2p/x+rR8ReH24v7DeFcQvIRRnwG+DaKTfKqivSYoonTMBAybnRdNRLRO1wzVq1jkQwJ
 +vC/Yjb/hol3WLbDhKHbtGPxkw/6NviOXDUCJCC9Qsqz8hn+Qh8rBmclt6Wrnpm9DmIn
 +797MeTCSWgTff76wYWFmcRPcIMMzRHYA5361ynBVgV/i7DU8UkdPTRBhTUc8T6nSyvy
 Tc0aj3AgDiyrDP4A+I0w18pzvbA2IHPM8TANa76YZaunHNdgzz1nxzVHiwuWptEWxCU8 Fg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3whcafhg58-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Feb 2024 09:34:59 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41R9QlNv006086;
 Tue, 27 Feb 2024 09:34:58 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3whcafhf9p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Feb 2024 09:34:57 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41R6b7aI021267; Tue, 27 Feb 2024 09:31:10 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfusnxsgn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Feb 2024 09:31:10 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41R9V73v19726958
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Feb 2024 09:31:09 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B81A658080;
 Tue, 27 Feb 2024 09:31:05 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C2BBE5806F;
 Tue, 27 Feb 2024 09:31:02 +0000 (GMT)
Received: from [9.109.243.35] (unknown [9.109.243.35])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Feb 2024 09:31:02 +0000 (GMT)
Message-ID: <8b71d5a6-7ed1-428f-8b08-dddf4fd09870@linux.ibm.com>
Date: Tue, 27 Feb 2024 15:01:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/15] spapr: nested: Document Nested PAPR API
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: clegoate@redhat.com, mikey@neuling.org, amachhiw@linux.vnet.ibm.com,
 vaibhav@linux.ibm.com, sbhat@linux.ibm.com, danielhb413@gmail.com,
 qemu-devel@nongnu.org
References: <20240220083609.748325-1-harshpb@linux.ibm.com>
 <20240220083609.748325-6-harshpb@linux.ibm.com>
 <CZFR7EN29EWC.EK4AP0CCTQJI@wheely>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <CZFR7EN29EWC.EK4AP0CCTQJI@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XXMomdVvC3JyzG0IpJPdna-ru7o3fvkb
X-Proofpoint-GUID: dE6JDtjz1Sz2fl3aREHSi6jS1yl0NbHq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0
 mlxscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 spamscore=0 suspectscore=0 mlxlogscore=894
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402270075
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 2/27/24 14:59, Nicholas Piggin wrote:
> On Tue Feb 20, 2024 at 6:35 PM AEST, Harsh Prateek Bora wrote:
>> Adding initial documentation about Nested PAPR API to describe the set
>> of APIs and its usage. Also talks about the Guest State Buffer elements
>> and it's format which is used between L0/L1 to communicate L2 state.
>>
>> Signed-off-by: Michael Neuling <mikey@neuling.org>
>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> 
> v2 is upstream in Linux now, I suppose you could reference that too?
> 
Yes, upstream Linux commit is mentioned in the doc at the end.

> Otherwise looks okay
> 
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Thanks
Harsh

> 
>> ---
>>   docs/devel/nested-papr.txt | 514 +++++++++++++++++++++++++++++++++++++
>>   1 file changed, 514 insertions(+)
>>   create mode 100644 docs/devel/nested-papr.txt


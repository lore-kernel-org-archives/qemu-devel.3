Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E576E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 02:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tViCy-00026P-In; Wed, 08 Jan 2025 21:23:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dantan@linux.ibm.com>)
 id 1tViCv-00025v-Kq; Wed, 08 Jan 2025 21:23:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dantan@linux.ibm.com>)
 id 1tViCt-0006IO-Qb; Wed, 08 Jan 2025 21:23:37 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508Iboke022507;
 Thu, 9 Jan 2025 02:23:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=BcW6ll
 EkPGCmZPL5ttkGcYwgeZOJvK7UIehf8kupdKY=; b=ktvg2Lzqikcjd6a4Fc+pS+
 Q06KF98xnE1i7Cfq59dUnB6LiE8ECIpJsDoN6mgDue3YRd8P1Wdct9eCqI1Jl0KV
 V2bsSx2Gg4RIUeqNlmOGVsN+j3IdLY2r3RtLoTiHq5HR3BGERXaLCyjbfdHGg/Le
 LcXxyxC3dB+OqNn90bgpnwU5KgEfCUzx3eAB8qjG+lOcApSvvx7loxFjKugOzZj2
 wDAMicHr2Fdhqd286m5veyIsBleimiBI5htEdhQrtdKRWHEGqZnLvAa1ywvmOngb
 T27cyxivcx4LGqV/s82FFsmIe5b0yjNFYZBsqyTpAeSGXwqKK/SGv9CcEmqvN0+g
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441nj3cdn6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Jan 2025 02:23:32 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5092HsKY027423;
 Thu, 9 Jan 2025 02:23:32 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441nj3cdn5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Jan 2025 02:23:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 508NfoRS008866;
 Thu, 9 Jan 2025 02:23:31 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43yfq0321r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Jan 2025 02:23:31 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5092NUS815008480
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 9 Jan 2025 02:23:30 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 25CE05805D;
 Thu,  9 Jan 2025 02:23:30 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9244A58058;
 Thu,  9 Jan 2025 02:23:29 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  9 Jan 2025 02:23:29 +0000 (GMT)
MIME-Version: 1.0
Date: Wed, 08 Jan 2025 20:23:29 -0600
From: dan tan <dantan@linux.ibm.com>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: dan tan <dantan@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 sbhat@linux.ibm.com, qemu-ppc@nongnu.org, npiggin@gmail.com,
 danielhb413@gmail.com
Subject: Re: [PATCH v3 0/2] Add new PowerPC Special Purpose Registers
In-Reply-To: <09859162-6319-48a7-8564-ba6023b38dd9@linux.ibm.com>
References: <20250107205102.20242-1-dantan@linux.vnet.ibm.com>
 <09859162-6319-48a7-8564-ba6023b38dd9@linux.ibm.com>
Message-ID: <6c58e6b9761fab2c34c382179061d916@linux.ibm.com>
X-Sender: dantan@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: x248dEma99WQWmTUvlmL_xwXjtlSxXnk
X-Proofpoint-GUID: WInO4NbCPTMyxbkde8TeYLQLc3r3Mmov
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 impostorscore=0 mlxlogscore=930 phishscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501090013
Received-SPF: pass client-ip=148.163.158.5; envelope-from=dantan@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi Harsh,

Thank you for pointing that out!
I will withdraw my submission.

regards,
--
email:dantan@linux.ibm.com


On 2025-01-08 00:17, Harsh Prateek Bora wrote:
> + Shivaprasad (had posted patches for DAWR1/DAWRX1 earlier)
> 
> https://lore.kernel.org/qemu-devel/170679876639.188422.11634974895844092362.stgit@ltc-boston1.aus.stglabs.ibm.com/
> 
> On 1/8/25 02:21, dan tan wrote:
>> From: dan tan <dantan@linux.ibm.com>
>> 
>> *** BLURB HERE ***
>> Version 3 summary:
>>      RWMR (Region Weighted Mode Register) -
>>          - change the register to generic read/write from nop/write
>> 
>> Version 2 summary:
>>      (DAWR1,DAWRX1):
>>          - spec reference: 
>> https://files.openpower.foundation/s/EgCy7C43p2NSRfR
>>          - corrected commit message format
>>          - combine DAWR(0/1) handling into a single function
>>          - add DAWR1 & DAWRX1 to init_proc_POWER10() only.
>> 
>>      RWMR (Region Weighted Mode Register) -
>>          - corrected the previous definition as ITV1
>>          - spec reference:
>>              
>> https://ibm.ent.box.com/s/tmklq90ze7aj8f4n32er1mu3sy9u8k3k (Power9)
>>          - it appears that part of the previous upstream request SPRs
>>            (SPR_POWER_MMCR3, SPR_POWER_SIER2, SPR_POWER_SIER3) are
>>            already in the current master. Therefore, removed those
>>            from this request.
>> 
>> dan tan (2):
>>    ppc/pnv: Add new PowerPC Special Purpose Registers (DAWR1,DAWRX1)
>>    ppc/pnv: Add new PowerPC Special Purpose Registers (RWMR)
>> 
>>   include/hw/ppc/spapr.h   |  2 +-
>>   target/ppc/cpu.h         |  8 +++--
>>   target/ppc/helper.h      |  4 +--
>>   target/ppc/spr_common.h  |  2 ++
>>   hw/ppc/spapr_hcall.c     | 24 ++++++++------
>>   target/ppc/cpu.c         | 69 
>> ++++++++++++++++++++++++++--------------
>>   target/ppc/cpu_init.c    | 20 ++++++++++++
>>   target/ppc/excp_helper.c | 11 ++++++-
>>   target/ppc/machine.c     |  5 ++-
>>   target/ppc/misc_helper.c |  8 ++---
>>   target/ppc/translate.c   | 21 ++++++++++--
>>   11 files changed, 127 insertions(+), 47 deletions(-)
>> 


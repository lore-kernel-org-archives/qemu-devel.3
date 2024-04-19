Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDADAC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 09:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxkr8-0004is-Lg; Fri, 19 Apr 2024 05:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.vnet.ibm.com>)
 id 1rxkr6-0004ig-UK; Fri, 19 Apr 2024 05:48:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.vnet.ibm.com>)
 id 1rxkr4-00017u-LE; Fri, 19 Apr 2024 05:48:28 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43J9RkpM026105; Fri, 19 Apr 2024 09:48:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=0WhHmNbS+fO/Ks9FD4MFzkzM31078QoV/o3ii6geQ/A=;
 b=g6YvJ7Az0fAswJdguPQ0ApBAOyjJN/92/Y3DJHfXsuuSWcHjsIN/WaSLSN1HQAsXpWt9
 AGqIVODpflLOeO12PdS2IRDl3T9LTFOLAm1b0D0X9bTpDmG/PwOXeD4Z4qhKvcuCSCGj
 xo3r4NaX/H/ifaNiNEtOV2APT1VyHGxBmLp7XfSz89FLQU0zOfFc7sMiKTkum45tax+i
 xaxy1eR8S7XErrMQP0bcxc6LER3gyywSUEs4pgXLaQRNS8f1FJyKz3MHNn2C42+r+LHi
 LIU0BMdrsvrPBwLmsLpaRV9kROUXwaabNxBlFDd1JFeC201PPcWWgWdMdGnboHIUOGIK 0g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xkp0er1em-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 09:48:24 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43J9mNoG027630;
 Fri, 19 Apr 2024 09:48:23 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xkp0er1ej-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 09:48:23 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43J8jIpu030287; Fri, 19 Apr 2024 09:26:20 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xkbmcjs4j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 09:26:19 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43J9QERV14352806
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Apr 2024 09:26:16 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C4BE20043;
 Fri, 19 Apr 2024 09:26:14 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 981FD2004B;
 Fri, 19 Apr 2024 09:26:12 +0000 (GMT)
Received: from [9.171.89.59] (unknown [9.171.89.59])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 19 Apr 2024 09:26:12 +0000 (GMT)
Message-ID: <ca6718a8-13dc-4b00-b18a-8a2b6882b3c6@linux.vnet.ibm.com>
Date: Fri, 19 Apr 2024 14:56:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] target/ppc: Move div/mod fixed-point insns (64 bits
 operands) to decodetree.
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com
References: <20240416063927.99428-1-rathc@linux.ibm.com>
 <20240416063927.99428-7-rathc@linux.ibm.com>
 <a5ed5846-7a8c-48fb-b84e-2ae285cd1b2c@linaro.org>
From: Chinmay Rath <rathc@linux.vnet.ibm.com>
In-Reply-To: <a5ed5846-7a8c-48fb-b84e-2ae285cd1b2c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6eh3p_YXcIkXbqAgat05z7grL7Ie6Kpv
X-Proofpoint-ORIG-GUID: cB1cZpMLmYPRgdvwcF44hOEwKl3xri-V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_06,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2404010000 definitions=main-2404190071
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=rathc@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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



On 4/17/24 00:08, Richard Henderson wrote:
> On 4/15/24 23:39, Chinmay Rath wrote:
>> Moving the below instructions to decodetree specification :
>>
>>     divd[u, e, eu][o][.]    : XO-form
>>     mod{sd, ud}        : X-form
>>
>> With this patch, all the fixed-point arithmetic instructions have been
>> moved to decodetree.
>> The changes were verified by validating that the tcg ops generated by 
>> those
>> instructions remain the same, which were captured using the '-d 
>> in_asm,op' flag.
>> Also, remaned do_divwe method in fixedpoint-impl.c.inc to do_dive 
>> because it is
>> now used to divide doubleword operands as well, and not just words.
>>
>> Signed-off-by: Chinmay Rath<rathc@linux.ibm.com>
>> ---
>>   target/ppc/helper.h                        |  4 +-
>>   target/ppc/insn32.decode                   |  8 +++
>>   target/ppc/int_helper.c                    |  4 +-
>>   target/ppc/translate.c                     | 65 ++--------------------
>>   target/ppc/translate/fixedpoint-impl.c.inc | 29 +++++++++-
>>   5 files changed, 42 insertions(+), 68 deletions(-)
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
Thanks,
Chinmay
> r~



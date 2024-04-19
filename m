Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1855C04FF6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 09:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxkOl-0001b6-3k; Fri, 19 Apr 2024 05:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.vnet.ibm.com>)
 id 1rxkOi-0001WM-Ht; Fri, 19 Apr 2024 05:19:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.vnet.ibm.com>)
 id 1rxkOh-0004IW-0t; Fri, 19 Apr 2024 05:19:08 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43J8wVqr016088; Fri, 19 Apr 2024 09:19:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=bCTT+cMdjs7/XKJtdnKzjioWn8/G3nftChCg1hG2krs=;
 b=IggrtikL7FlPzpefw7PqB+8aq5tj/0Smzk+bPaAMguu9WHC0IOlMsIiBxVzv6CKQJasb
 cd32AgRnLG7PjUJrvXwD4Cjia1T0h2nl1VszEfsSD9hbWJwRact6Fx8JdEsnIG8GU/9x
 tWN5zG/o9MWgzAJZZ236G+t5LtljGFORG2qzO6HjbnEBLnZmgrjJ9NDE4IcCxI6g3Rgy
 UiRF29ecsCQrhu3/dHbt3v7OnWiYJlPEuOEiZy3NMHuMHbVEUnQISDkgpbxbdd57RhvH
 loXJ0yW4ZilKUj40Ilyf56PLzcUvnpNYFCMSCA+icJ1822Tjas/o0UnCZB1/l4PowVgD wg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xknjmg1ce-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 09:19:05 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43J9J4Hm016930;
 Fri, 19 Apr 2024 09:19:04 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xknjmg1cd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 09:19:04 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43J8p3PY021033; Fri, 19 Apr 2024 09:19:04 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xkbm9jr01-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 09:19:03 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43J9Iw4D50266494
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Apr 2024 09:19:00 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4ED5C20040;
 Fri, 19 Apr 2024 09:18:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B88CB2004B;
 Fri, 19 Apr 2024 09:18:56 +0000 (GMT)
Received: from [9.171.89.59] (unknown [9.171.89.59])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 19 Apr 2024 09:18:56 +0000 (GMT)
Message-ID: <7e640296-3df3-4218-8380-ccec10aef5c3@linux.vnet.ibm.com>
Date: Fri, 19 Apr 2024 14:48:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] target/ppc: Move neg, darn, mod{sw, uw} to decodetree.
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com
References: <20240416063927.99428-1-rathc@linux.ibm.com>
 <20240416063927.99428-5-rathc@linux.ibm.com>
 <00d9243d-bc6b-44c8-a53c-15ca702058de@linaro.org>
From: Chinmay Rath <rathc@linux.vnet.ibm.com>
In-Reply-To: <00d9243d-bc6b-44c8-a53c-15ca702058de@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tHmlE_E_zjylkMhgh8ptxX-s4pqDQ7R5
X-Proofpoint-ORIG-GUID: uWkLPOud_GeLa4RPKo_8jLyYwEXyQgyn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_06,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 phishscore=0 mlxlogscore=812 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404190068
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



On 4/16/24 23:55, Richard Henderson wrote:
> On 4/15/24 23:39, Chinmay Rath wrote:
>> Moving the below instructions to decodetree specification :
>>
>>     neg[o][.]           : XO-form
>>     mod{sw, uw}, darn    : X-form
>>
>> The changes were verified by validating that the tcg ops generated by 
>> those
>> instructions remain the same, which were captured with the '-d 
>> in_asm,op' flag.
>>
>> Signed-off-by: Chinmay Rath<rathc@linux.ibm.com>
>> ---
>>   target/ppc/helper.h                        |  4 +-
>>   target/ppc/insn32.decode                   |  8 ++++
>>   target/ppc/int_helper.c                    |  4 +-
>>   target/ppc/translate.c                     | 56 ----------------------
>>   target/ppc/translate/fixedpoint-impl.c.inc | 44 +++++++++++++++++
>>   5 files changed, 56 insertions(+), 60 deletions(-)
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Thanks,
Chinmay
>
> r~



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B5CC04FF6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 09:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxkOX-0000Lw-Cd; Fri, 19 Apr 2024 05:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.vnet.ibm.com>)
 id 1rxkOR-00005Z-9g; Fri, 19 Apr 2024 05:18:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.vnet.ibm.com>)
 id 1rxkOO-0004F9-Am; Fri, 19 Apr 2024 05:18:51 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43J91s1T019798; Fri, 19 Apr 2024 09:18:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=IcaB+qRQfb1ue02VK2GrsHPtrzOxmaEWCOoaUzZYt08=;
 b=kCbk9t7SKJySNZdn/j5ucLJpam9MwG8EK9BScxCDZU+bG9De9WQcZaWsAozJhCOpLvbi
 MnLL+u+OwhGilmu6k5BkOh5cU4woBLX5hW5q5uLWM6UU7ffgHi7Lzmx55LI6lJj19nvU
 LGAwTMekrk+qDgnhB4YfXYG5MTiFJBNNZICVvcSxH4OG4GeJ8sAtAQuZZ6W7nFDIngOI
 IHSDpReMEYmXiJGk9MGmRAy4mN+fg6BJ3HtTCO2YMbat9CvSMhkz/S+jbxe3wxTXY9w/
 c+w+PjokeR1A409SS2hZQK1mXi9O+pvByD5a6RfSq+0PRelTJfHeKjZXjNN4Ww5Irlp4 Kg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xknmc014p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 09:18:45 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43J9Iihe013636;
 Fri, 19 Apr 2024 09:18:44 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xknmc014n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 09:18:44 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43J8uACJ027929; Fri, 19 Apr 2024 09:18:44 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xkbmpaqp4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 09:18:43 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43J9Ic1O48890138
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Apr 2024 09:18:40 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8ADAB2004F;
 Fri, 19 Apr 2024 09:18:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 033532004D;
 Fri, 19 Apr 2024 09:18:37 +0000 (GMT)
Received: from [9.171.89.59] (unknown [9.171.89.59])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 19 Apr 2024 09:18:36 +0000 (GMT)
Message-ID: <5cd6ec0b-1c60-48cb-9659-f0247c5ad608@linux.vnet.ibm.com>
Date: Fri, 19 Apr 2024 14:48:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] target/ppc: Move divw[u, e, eu] instructions to
 decodetree.
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com
References: <20240416063927.99428-1-rathc@linux.ibm.com>
 <20240416063927.99428-4-rathc@linux.ibm.com>
 <45204f85-3eb9-40f4-9f2a-3a3f0e75929e@linaro.org>
From: Chinmay Rath <rathc@linux.vnet.ibm.com>
In-Reply-To: <45204f85-3eb9-40f4-9f2a-3a3f0e75929e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dBNxT17Gp0HrTLO1DOOjnMRXrxACBN5S
X-Proofpoint-ORIG-GUID: FiFqrfrNy3k6WZWrZ8UHTwQ7Ay5dxE8Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_06,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 mlxscore=0
 mlxlogscore=777 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404190068
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=rathc@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 4/16/24 23:49, Richard Henderson wrote:
> On 4/15/24 23:39, Chinmay Rath wrote:
>> Moving the following instructions to decodetree specification :
>>      divw[u, e, eu][o][.]     : XO-form
>>
>> The changes were verified by validating that the tcg ops generated by 
>> those
>> instructions remain the same, which were captured with the '-d 
>> in_asm,op' flag.
>>
>> Signed-off-by: Chinmay Rath<rathc@linux.ibm.com>
>> ---
>>   target/ppc/helper.h                        |  4 +--
>>   target/ppc/insn32.decode                   |  5 ++++
>>   target/ppc/int_helper.c                    |  4 +--
>>   target/ppc/translate.c                     | 31 ----------------------
>>   target/ppc/translate/fixedpoint-impl.c.inc | 24 +++++++++++++++++
>>   5 files changed, 33 insertions(+), 35 deletions(-)
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
Thanks,
Chinmay
>
> r~



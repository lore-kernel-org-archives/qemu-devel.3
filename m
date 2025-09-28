Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C27FCAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 19:38:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2xA1-0003xL-1D; Sun, 28 Sep 2025 15:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v2xA0-0003x7-65; Sun, 28 Sep 2025 15:34:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v2x9u-0005ld-K8; Sun, 28 Sep 2025 15:34:15 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58S7e4K6009738;
 Sun, 28 Sep 2025 19:34:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=4kjXPe
 kc2vlePcNLVeQtfix3nc112uKHX+gqmBUv9Ek=; b=GAAx1cis4wa+0OO0pH2BFb
 CaWp8Ve9Sz8BSu3aavl9QD4qBvUcsH6TeZIti+37P/D8S4pczFLJ8OCS9/4jG+Yk
 XpZDMGs2/SRnAR9RXuAtl//a3qMmedRpjdD+30+qoOzhMoJNVVY0RvZJngThiTmb
 bf6ES5ydqCBy8ftihUPRo5nFr9fJJN0I8xZceTppGmit/dv4tTzTGOtCm3XdrxzS
 ELXhXpGuMTkHf0umULbM8YrPuFFWZZkuVavrsptWL2Z3QLTc3js5Vn0CGwrL0oTB
 ZR3nqJxTdMf35o/3VrctXcgYJDXrTL4CEfSm5R3+MHqkkZ5ky9gBljRxjLZtHkiw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7ktxqmq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 28 Sep 2025 19:34:02 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58SJQKQC003151;
 Sun, 28 Sep 2025 19:34:02 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7ktxqmp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 28 Sep 2025 19:34:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58SHFSYe003325;
 Sun, 28 Sep 2025 19:34:01 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49etmxk0r8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 28 Sep 2025 19:34:01 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58SJXxhX10224292
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 28 Sep 2025 19:34:00 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D770258056;
 Sun, 28 Sep 2025 19:33:59 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 21F2658052;
 Sun, 28 Sep 2025 19:33:57 +0000 (GMT)
Received: from [9.39.17.115] (unknown [9.39.17.115])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 28 Sep 2025 19:33:56 +0000 (GMT)
Message-ID: <586cd866-0f8b-4960-acda-316d6e2c0b92@linux.ibm.com>
Date: Mon, 29 Sep 2025 01:03:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/9] hw/ppc: Support for an IBM PPE42 CPU decrementer
To: Richard Henderson <richard.henderson@linaro.org>,
 Glenn Miles <milesg@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@redhat.com, npiggin@gmail.com, thuth@redhat.com, 
 rathc@linux.ibm.com
References: <20250925201758.652077-1-milesg@linux.ibm.com>
 <20250925201758.652077-8-milesg@linux.ibm.com>
 <f023d7c8-1556-448b-8cf6-1ee1cc2f7b50@linux.ibm.com>
 <50d8690f-d5a9-4cc4-9111-8f2d4e5bfd5f@linaro.org>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <50d8690f-d5a9-4cc4-9111-8f2d4e5bfd5f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=T7WBjvKQ c=1 sm=1 tr=0 ts=68d98daa cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=f7IdgyKtn90A:10
 a=6d6SYI82db8bXswPYFIA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=oH34dK2VZjykjzsv8OSz:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=jd6J4Gguk5HxikPWLKER:22
X-Proofpoint-GUID: kkQ_Ql1DVUU9hy5rYtSOA2xwSQ28EpHD
X-Proofpoint-ORIG-GUID: qWpGsZcsk8ipk1rSEbkQ12ytcqdJPpBY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfX90znaOLFry6C
 ruyYxZGvVSY7iUPFsDYgcxte6YCBJp96Hdr1VLH6e8AOJto8PMu4heoHuP8pG+nSUTzKmeGdF6M
 sIS/WsgwQkJtjL0oYulwkq3JY9TjQ5srf13Z4HEKyAO1JMYF9wXxgB4pn980P8KF5iNLIwlFugR
 9RDSgc2dVQuoHWPa9ichHqSuigd/Rvt92mYko5BnA6FCdX8pQ+urkEQRVFaQvYYcXfEQ1NOd7KZ
 0WLgoh8BIGIgiDBUiL58fkoW28WQoQr2LzMcUUl5V83o1erNv+NXugkXmiz7utZ18nz7q5tauSX
 Z8NvdeXA1zi0qtVipoSA5e2zbfb2kOpAhjXL+QjlPyFzYeOPQneC94bmT6eMQkbX705mnrXdy8f
 WE0ojejdipHjkw/UCr6lsTT+x3mxuQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-28_08,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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



On 9/29/25 00:57, Richard Henderson wrote:
> On 9/28/25 10:51, Harsh Prateek Bora wrote:
>>
>>
>> On 9/26/25 01:47, Glenn Miles wrote:
>>> The IBM PPE42 processors support a 32-bit decrementer
>>> that can raise an external interrupt when DEC[0]
>>> transitions from a 0 to a 1 (a non-negative value to a
>>
>> I guess it was meant to be 0 to -1 (0xffffffff)?
>> No need to re-spin just for that though.
> 
> No, Glenn is talking about bit DEC[0], so 0 or 1 only.

Oh, yeh. I just posted a pull-req after updating it to -1 though.
Not sure if we want a pull-req v2 for that.

regards,
Harsh

> 
> 
> r~


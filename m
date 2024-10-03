Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8699ACF3191
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 05:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swEHg-00013k-Ht; Thu, 03 Oct 2024 01:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1swEHe-00013S-Cx; Thu, 03 Oct 2024 01:21:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1swEHc-0001Cn-A7; Thu, 03 Oct 2024 01:21:50 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4935LbYx028763;
 Thu, 3 Oct 2024 05:21:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=c
 gM5dC/riAiQebZK4Z4SiJKH5/d5AYuyIhQYc2LH730=; b=P0UT3MaXav4jnIouJ
 fOQhK++oeEv/1MrorYW0CJl74xYmsWoOBmOuHDjRAmMww9d0LKpQDQtNkmvq1X56
 ABNDB0p6OgVKON4So9KpEez1qY4WjETRkU5Vf3xFbDAKOwzKBaFQo0NtKpXa1vMk
 BoS1H1uQPykJh3lph7/hlgfCRrL9MqIsb6MGdd3Q0Ah0pMR5YEsNwfCBAy6+mcHU
 B1PjzQWZkRtOJETiZPIWq1AKD2+GKwTgdYEt5bvDQ15rMXThyd0EIk1WtTO75+kk
 veHlgwB6zJMfkP5T9zyIIsAQNtHiQfLme9O26yT0NLvAGMqphrFuLfjpElt7CXGl
 wVljA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 421jt7gg9j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Oct 2024 05:21:42 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4935LfAP029433;
 Thu, 3 Oct 2024 05:21:41 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 421jt7gg0p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Oct 2024 05:21:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49353Ens014157;
 Thu, 3 Oct 2024 05:16:48 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xwmke1b0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Oct 2024 05:16:48 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4935Glgp34472260
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Oct 2024 05:16:47 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7FB785803F;
 Thu,  3 Oct 2024 05:16:47 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 997F158062;
 Thu,  3 Oct 2024 05:16:45 +0000 (GMT)
Received: from [9.109.242.165] (unknown [9.109.242.165])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  3 Oct 2024 05:16:45 +0000 (GMT)
Message-ID: <9228ccb5-ee38-4c66-aa54-667f52aa33ce@linux.ibm.com>
Date: Thu, 3 Oct 2024 10:46:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] ppc/spapr: remove deprecated machines specific
 code
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: npiggin@gmail.com, danielhb413@gmail.com
References: <20241001092910.1030913-1-harshpb@linux.ibm.com>
 <c39f54de-65f4-42a6-bde7-b5a4ea0c2056@kaod.org>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <c39f54de-65f4-42a6-bde7-b5a4ea0c2056@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1p93OW61LDDPOwY7MiyzK2bN9kkItC3V
X-Proofpoint-GUID: E7g31E0Oc89b4wt-usWXTCEO8H250vld
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_04,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 phishscore=0
 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0 mlxlogscore=646
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410030035
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/2/24 12:26, Cédric Le Goater wrote:
> Hello Harsh,
> 
> On 10/1/24 11:28, Harsh Prateek Bora wrote:
>> Commit 1392617d3576 intended to tag pseries-2.1 - 2.11 machines as
>> deprecated with reasons mentioned in its commit log.
>> Removing the arch specific code for the now deprecated machine types.
>>
>> v2: Addressed review comments from Cedric
>> v1: <20240917060300.943496-1-harshpb@linux.ibm.com>
>> Harsh Prateek Bora (11):
>>    ppc/spapr: remove deprecated machine pseries-2.1
>>    ppc/spapr: remove deprecated machine pseries-2.2
>>    ppc/spapr: remove deprecated machine pseries-2.3
>>    ppc/spapr: remove deprecated machine pseries-2.4
>>    ppc/spapr: remove deprecated machine pseries-2.5
>>    ppc/spapr: remove deprecated machine pseries-2.6
>>    ppc/spapr: remove deprecated machine pseries-2.7
>>    ppc/spapr: remove deprecated machine pseries-2.8
>>    ppc/spapr: remove deprecated machine pseries-2.9
>>    ppc/spapr: remove deprecated machine pseries-2.10
>>    ppc/spapr: remove deprecated machine pseries-2.11
> 
> LGTM, I had a few questions.
> 

Thanks, I shall address the review comments in next iteration.

> Please be aware that the next QEMU cycle will have more machines
> to deprecate.
> 

I realized that 2.12 had also been marked as deprecated earlier which I
can include in v3, however would like to understand the rationale behind
choosing the remaining until pseries-6.1 for deprecating in next release
cycle. Please enlighten.

regards,
Harsh

> pseries-2.1          pSeries Logical Partition (PAPR compliant) 
> (deprecated)
> pseries-2.10         pSeries Logical Partition (PAPR compliant) 
> (deprecated)
> pseries-2.11         pSeries Logical Partition (PAPR compliant) 
> (deprecated)
> pseries-2.12         pSeries Logical Partition (PAPR compliant) 
> (deprecated)
> pseries-2.12-sxxm    pSeries Logical Partition (PAPR compliant) 
> (deprecated)
> pseries-2.2          pSeries Logical Partition (PAPR compliant) 
> (deprecated)
> pseries-2.3          pSeries Logical Partition (PAPR compliant) 
> (deprecated)
> pseries-2.4          pSeries Logical Partition (PAPR compliant) 
> (deprecated)
> pseries-2.5          pSeries Logical Partition (PAPR compliant) 
> (deprecated)
> pseries-2.6          pSeries Logical Partition (PAPR compliant) 
> (deprecated)
> pseries-2.7          pSeries Logical Partition (PAPR compliant) 
> (deprecated)
> pseries-2.8          pSeries Logical Partition (PAPR compliant) 
> (deprecated)
> pseries-2.9          pSeries Logical Partition (PAPR compliant) 
> (deprecated)
> pseries-3.0          pSeries Logical Partition (PAPR compliant) 
> (deprecated)
> pseries-3.1          pSeries Logical Partition (PAPR compliant) 
> (deprecated)
> pseries-4.0          pSeries Logical Partition (PAPR compliant) 
> (deprecated)
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
> 
> Thanks,
> 
> C.
> 


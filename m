Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F255C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 20:24:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk7f0-0001he-CU; Mon, 17 Feb 2025 15:24:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dantan@linux.ibm.com>)
 id 1tk7ey-0001gt-4h; Mon, 17 Feb 2025 15:24:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dantan@linux.ibm.com>)
 id 1tk7ew-0007hX-EO; Mon, 17 Feb 2025 15:24:07 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51HAYUnD029535;
 Mon, 17 Feb 2025 20:24:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=jJJ4yw
 dz+cXMFIEIMQbMP94hkIgOaIxewJ55pznB/JU=; b=DbuVSC75jzsBEo3tiIpGkk
 MA72ovCimWQe95Q7W4uBBgTHko0AnvUCnUerlWiQ9i8jaXUdkHkcMB5Yaw/Zi15H
 I+Ca3V0p2XHdCXKWsTRoPfHWt78od9dZTfWStowzpPME2nelw0n/RsMcZzyzdIL7
 4MHlYwZR8VtYVfovzoPzc8rJR+RQebrGHPABBpF/C+Z+aJcTL2Jo8+YSjokLKymq
 jyof1Nsr+zBVwN1a+Rateyjk8M2ykY30NASyHwlSsMRrlwNqnNX+QoQ/UriEkKV0
 Km27lOFEb/kKGSU11OeQq/FT4JGjpc0KH4MZzC+uRtl4yDGg95pPNVeXzdHMlljQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44us5a5duq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Feb 2025 20:24:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51HHYDUu029528;
 Mon, 17 Feb 2025 20:24:03 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44v9mmghnq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Feb 2025 20:24:03 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51HKO20h10814022
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Feb 2025 20:24:02 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 67B3C5805A;
 Mon, 17 Feb 2025 20:24:02 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0921858052;
 Mon, 17 Feb 2025 20:24:02 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Feb 2025 20:24:01 +0000 (GMT)
MIME-Version: 1.0
Date: Mon, 17 Feb 2025 14:24:01 -0600
From: dan tan <dantan@linux.ibm.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: dan tan <dantan@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, stefanb@linux.vnet.ibm.com, pbonzini@redhat.com,
 farosas@suse.de, lvivier@redhat.com
Subject: Re: [PATCH v9 0/3] TPM TIS SPI Support
In-Reply-To: <413fd61d-a30d-4061-bc71-d0efe92e625f@linux.ibm.com>
References: <20250216221155.30013-1-dantan@linux.vnet.ibm.com>
 <413fd61d-a30d-4061-bc71-d0efe92e625f@linux.ibm.com>
Message-ID: <3a63ef12967ef52ca18d1ca140c283cb@linux.ibm.com>
X-Sender: dantan@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: q2zs_US66gecEY0kc6_5Bx9HOQ50XI8c
X-Proofpoint-GUID: q2zs_US66gecEY0kc6_5Bx9HOQ50XI8c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 spamscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502170157
Received-SPF: pass client-ip=148.163.156.1; envelope-from=dantan@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Stefan,

I have yet found a ppc64le Linux distro that has SPI enabled in the 
kernel. Attempts to build my own was not successful either. I am trying 
to get the LTC (Linux Technology Center) involved. They have more 
expertise in building the ppc64le kernel. I am hoping to get that tested 
soon.

thank you,
---
dan tan
power simulation
phone:+1.7373.099.138
email:dantan@linux.ibm.com


On 2025-02-17 14:12, Stefan Berger wrote:
> On 2/16/25 5:11 PM, dan tan wrote:
>> *** BLURB HERE ***
>> 
>> Version 9 summary:
>>      1/3 tpm/tpm_tis_spi: Support TPM for SPI
>>          - rebased with the master, and conform with the latest
>>            device property definition
>>      3/3 tests/qtest/tpm: add unit test to tis-spi
>>          - remove unnecessary tpm-tis-spi qtest start parameters
> 
> Were you able to test it with Linux now?


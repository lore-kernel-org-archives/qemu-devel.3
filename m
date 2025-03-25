Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B749BC3600B
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 17:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx7jV-0003Il-Kc; Tue, 25 Mar 2025 13:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tx7jQ-0003HV-AE; Tue, 25 Mar 2025 13:06:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tx7jN-0006aA-Hz; Tue, 25 Mar 2025 13:06:27 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PCSHEj012960;
 Tue, 25 Mar 2025 17:06:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=9n4KJZ
 tL360JmQptXelX/A/A1yc0sYW14Rm66eam35E=; b=R/fLoaVJak9MDSmvyqpGSQ
 41Kj2ZDdCDzjCo3HrCL5pvOGbTCs6SHdHiURTnDbLh443lA6QthLzidnf6xQM26f
 XV7vxw4xaXhmlMSGPJaiONxOkTOmYugrkxfmGqjVM7itTwaL7xxBd1MDHxPxVvBj
 3hhAFZQXyGQ8N41E4UUl0ygctjtCSRp9+7raZRM9WbDX0+e6ed+6AwSyLOkTTkVv
 z7Db/Q7UOCSfTpChu8oBDycXJ9CG95maPuthih3qU2op9lK2ElaEsjl9yyM0dtsz
 ZYf5VC1qH13JZ5tsV6bNd2Coh7UZiVtJ1DRoVGSrrEKcHz/cMvhFddQxQk56LTsw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kvh31hnv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Mar 2025 17:06:21 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52PGihTT022268;
 Tue, 25 Mar 2025 17:06:21 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kvh31hns-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Mar 2025 17:06:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52PECO6k005791;
 Tue, 25 Mar 2025 17:06:20 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45ja82c2gd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Mar 2025 17:06:20 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52PH6H2D37749042
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Mar 2025 17:06:17 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E2C672004D;
 Tue, 25 Mar 2025 17:06:16 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DCE8620043;
 Tue, 25 Mar 2025 17:06:13 +0000 (GMT)
Received: from [9.39.16.55] (unknown [9.39.16.55])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 25 Mar 2025 17:06:13 +0000 (GMT)
Message-ID: <fe32d0e4-7829-4e1d-82a1-373ae4d50da3@linux.ibm.com>
Date: Tue, 25 Mar 2025 22:36:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/10] ppc/pnv: Add SBE model for Power11
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20250325112319.927190-1-adityag@linux.ibm.com>
 <20250325112319.927190-6-adityag@linux.ibm.com>
 <46b180e0-af65-4da5-8245-2fb681bb487f@kaod.org>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <46b180e0-af65-4da5-8245-2fb681bb487f@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xrEctMiUHbT0twCLjmWasZgIAEjenCb_
X-Proofpoint-GUID: WsoyHLER6YuOI8pxN7O2h5dTSjJMMltt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_07,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=633 mlxscore=0
 clxscore=1015 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503250119
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
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

On 25/03/25 20:08, Cédric Le Goater wrote:

> On 3/25/25 12:23, Aditya Gupta wrote:
>> <...snip...>
>>
>> --- a/hw/ppc/pnv_sbe.c
>> +++ b/hw/ppc/pnv_sbe.c
>> @@ -366,6 +366,20 @@ static const TypeInfo pnv_sbe_power10_type_info = {
>>       .name          = TYPE_PNV10_SBE,
>>       .parent        = TYPE_PNV9_SBE,
>>       .class_init    = pnv_sbe_power10_class_init,
>> +    .class_base_init = pnv_sbe_power10_class_init,
>
> again why change .class_base_init ?

So that the P11 types which declared P10 types as parent, follow this 
.class_init. Same reason for the other models.


Will consider dropping these models, since same as P10s.


Thanks,

- Aditya Gupta

>
> C.
>


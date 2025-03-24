Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA418C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 08:39:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twdKw-0003jM-Oq; Mon, 24 Mar 2025 04:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1twdKY-0003hk-5i; Mon, 24 Mar 2025 04:38:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1twdKW-0002Qm-6r; Mon, 24 Mar 2025 04:38:45 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O3kRtD013975;
 Mon, 24 Mar 2025 08:38:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=WCRy4l
 DXSkOOjJaJSbt0mxicKspc6+9EqPI2WOcQqZw=; b=L1HR20vjoIES64crWikCI7
 mXTzVPSXDH+6+6qGIY83Opaf0RcC5oFI2oC9VbhIe2ztHzWNRE2juvhnCmUONvhA
 beRBo55spAHNYCCstFUASZ3DLGRVpqH2/OvSWhT7wjIL3lnM7rRbgJfxAS6yvcet
 OrmOO1am7B9MqxnToOpfByISgJLenKhLmwZaWEdXYYbkNP5ZNAs/Vmu2gyDf/cPh
 G0cY041Yy5T0Sc4z63mYqsgmASSHzWU8ySHvE+B61RO3XMmHA13MFbTB/Jn6Pte0
 ZSvwknVsmmkmZ13sqE9s5gA3IQ/jQbRzXLiXDpjMKCC27mJ711eBE11U4ENxzgNg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45jys915ut-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Mar 2025 08:38:33 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52O8WnRe021374;
 Mon, 24 Mar 2025 08:38:33 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45jys915ur-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Mar 2025 08:38:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52O75PfU030321;
 Mon, 24 Mar 2025 08:38:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j7ht5jkg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Mar 2025 08:38:32 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52O8cSSB55836942
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Mar 2025 08:38:28 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BD45E20043;
 Mon, 24 Mar 2025 08:38:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 885EE20040;
 Mon, 24 Mar 2025 08:38:26 +0000 (GMT)
Received: from [9.109.199.160] (unknown [9.109.199.160])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Mar 2025 08:38:26 +0000 (GMT)
Message-ID: <1df64072-b054-4c8e-b426-12f1ad76b550@linux.ibm.com>
Date: Mon, 24 Mar 2025 14:08:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/8] ppc/pnv: Add a Power11 Pnv11Chip, and a Power11
 Machine
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20250308205141.3219333-1-adityag@linux.ibm.com>
 <20250308205141.3219333-8-adityag@linux.ibm.com>
 <bce5dcfc-24d2-41e2-b11e-7cb5967f2132@kaod.org>
 <337b1a39-ed5f-4737-a98a-1ed2784aef7b@linux.ibm.com>
 <a724951a-738c-403d-8d47-8d3b83c68e13@kaod.org>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <a724951a-738c-403d-8d47-8d3b83c68e13@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -Ptg1P9QXAvR1Nfx22naKjB_sXSRZ4KJ
X-Proofpoint-GUID: YWpvxG_-khhjm8ILz5crkZv1twgxgW6a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 adultscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240061
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 24/03/25 13:05, Cédric Le Goater wrote:

> On 3/24/25 08:13, Aditya Gupta wrote:
>> Hi Cedric,
>>
>> <...snip...>
>>
>> When I do this, every function using Pnv10Chip* will need to be 
>> duplicated to use Pnv11Chip*.
>>
>> I will do that.
>>
>> But what do you say about changing Pnv10 chip to Pnv1x chip ? It may 
>> only be used by Pnv10 and Pnv11, not future chips. But is that 
>> unnecessary for just two versions of the chip ?
>>
>> Just tried to think of some ways to reduce duplication, or having 
>> different files such as pnv10.c, pnv11.c ? I am not sure because 
>> these might be unnecessary things too.
>
> Please open code (and duplicate) first. Then we will see how we
> can make things common. Checking the typename in the instance_init
> handleris a hack not for upstream.

Sure Cedric, will duplicate it then.


Thanks,

- Aditya Gupta


>
> Thanks,
>
> C.
>
>


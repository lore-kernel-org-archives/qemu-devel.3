Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3912C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 10:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1traPy-0002K1-6v; Mon, 10 Mar 2025 06:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1traPt-0002JC-U6; Mon, 10 Mar 2025 06:31:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1traPs-0001hB-AF; Mon, 10 Mar 2025 06:31:25 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52A78w79018245;
 Mon, 10 Mar 2025 10:31:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=rL6/G6
 P9e6PGVF/Gq2kilRzgVCHa/6g7KMixQ+UOhf8=; b=OaW9zX+cKUkLCWIIUdY0BS
 zXFbFdN7C9iZkc38zssrHgHva8O+7UFyslZw/mQleN9Ifih4zXTApxJC5JMXLKbg
 isptoT9/48Z6gxz+4OgPuRw1itmSoGfT2RQ+ZeeeL9Z/zIIIjxe0NnfK1f9w80Vz
 f6otYny2lspL0Foki26cJCQyUshIWembMcrsdFDFwLOkRSTxlSUustSXRzLETmai
 Y9Ty5apyJHA3rLOFYJfm5wDUi2c7FvHZhASIJeyDAzPq5WRZNyqpJSilHXO9LmGk
 KFsu3Nwu+2e1XL4Ww78x88ASDK2Ybb8821EZWRZ32igx/LTnetD3r5wZ2Cq1xdLQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 459cdnktca-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Mar 2025 10:31:19 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52AARhub008249;
 Mon, 10 Mar 2025 10:31:19 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 459cdnktc8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Mar 2025 10:31:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52A80FOh014921;
 Mon, 10 Mar 2025 10:31:18 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4592ek5ubv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Mar 2025 10:31:18 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52AAVF3u37093886
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Mar 2025 10:31:15 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC1472004D;
 Mon, 10 Mar 2025 10:31:14 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0BAA02004B;
 Mon, 10 Mar 2025 10:31:13 +0000 (GMT)
Received: from [9.109.199.160] (unknown [9.109.199.160])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 10 Mar 2025 10:31:12 +0000 (GMT)
Message-ID: <094f0623-e483-4097-aca0-9f320b27af1a@linux.ibm.com>
Date: Mon, 10 Mar 2025 16:01:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/8] ppc/pnv: Update skiboot to support Power11
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20250308205141.3219333-1-adityag@linux.ibm.com>
 <20250308205141.3219333-9-adityag@linux.ibm.com>
 <f9ea56e0-a104-4acd-a27e-7d2813efe319@kaod.org>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <f9ea56e0-a104-4acd-a27e-7d2813efe319@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MuXFOQov9W7JdWEkysjwjcOshZ68D3ih
X-Proofpoint-ORIG-GUID: wT4mwWZxHdbM0zQb3v766gmZ3KEIW0hA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_04,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 lowpriorityscore=0 spamscore=0 phishscore=0 mlxlogscore=873
 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503100083
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

On 09/03/25 19:40, Cédric Le Goater wrote:

> On 3/8/25 21:51, Aditya Gupta wrote:
>> Update skiboot.lid to below commit which adds support for booting on
>> Power11:
>>
>>      commit 785a5e3070a8 ("platform: Identify correct bmc platform 
>> based on bmc hw version")
>>
>> Built with glibc 2.40 and gcc 14.2 (Fedora 41)
>>
>> Signed-off-by: Aditya Gupta<adityag@linux.ibm.com>
>> ---
>> Should the roms/skiboot submodule also be updated ?
>>
>> I see it has generally been updated on skiboot releases with versions,
>> eg. 7.1, 7.0. No newer version available for upstream/master.
>> ---
>> ---
>>   pc-bios/skiboot.lid | Bin 2527328 -> 2527424 bytes
>>   1 file changed, 0 insertions(+), 0 deletions(-)
>
> This change should come first as a sub maintainer PR, to avoid sending 
> 2.5MB
> on the mailing list :/ See how SLOF is handled.
>
Sorry didn't know this. I just checked the git log of skiboot.lid and 
thought maybe it's this same way of sending patches.

Will skip sending this in v6.


Thanks,

- Aditya Gupta

>
> Thanks,
>
> C.
>
>


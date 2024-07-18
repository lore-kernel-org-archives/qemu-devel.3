Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1FBC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 16:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUUA3-0007Y0-FT; Thu, 18 Jul 2024 12:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sUUA0-0007Py-U0; Thu, 18 Jul 2024 12:39:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sUU9y-0005Lt-Iy; Thu, 18 Jul 2024 12:39:16 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46IFQhGx008958;
 Thu, 18 Jul 2024 16:38:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=m
 PtCw3ld4PLHJyeYccLdHjF+2yvusU/yXuwSSgmBbl4=; b=L0auPZ0hoick+LYGt
 M5yYXasb+NAcr6ulJQD2tNiJY8LAcXlHlW7cMiwCdVFKtnvlInVsvSFTUC3MUhk9
 cvcZVYUWG+NVApetg8VoTKa6cp2NSsl64xTiy5VRapByf3SEHQ6B964UogCT+aEx
 K3yDvgcFS3BhuyuIrspsPIXO0sVEv9cXkgZ3iyy7Wowqjr3n6c3VtUO9MRK2/TKd
 Umsh1P1dzpcJJ1+jG7H6xM6zreuFnY2KTrGh3lJJfJW6yplo1s5XyiigxLKjtZjo
 wmGHlg87fzIBxnmmKHdpdYF0Y/zDLcGpO0Cu+hwhLh3jeXC2jNHAAFNI6Igl+nWa
 5Ibkg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40f3y9gf3c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jul 2024 16:38:25 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46IGcONb020354;
 Thu, 18 Jul 2024 16:38:24 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40f3y9gf3b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jul 2024 16:38:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46IGKtmE006082; Thu, 18 Jul 2024 16:38:24 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40dwkmjmyk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jul 2024 16:38:24 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46IGcKZW28639598
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Jul 2024 16:38:22 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6E1E058063;
 Thu, 18 Jul 2024 16:38:20 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2BA4558057;
 Thu, 18 Jul 2024 16:38:20 +0000 (GMT)
Received: from [9.10.80.165] (unknown [9.10.80.165])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 18 Jul 2024 16:38:20 +0000 (GMT)
Message-ID: <4d5b20b4-7c78-40d4-9844-fa013e0eb8ec@linux.ibm.com>
Date: Thu, 18 Jul 2024 11:38:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] XIVE changes for Cache Watch, VSTs, STT and info
 pic
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Michael Kowal <kowal@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com
References: <20240716195633.12679-1-kowal@linux.vnet.ibm.com>
 <4b72c7b9-a812-43c6-b735-43eac8709fc6@kaod.org>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <4b72c7b9-a812-43c6-b735-43eac8709fc6@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ox6MWJHpISvEU_gL8mdynHbsIrb2l4HZ
X-Proofpoint-ORIG-GUID: Ys7qY6vKpuvWIV9r6XsUgCgMrguwMI3o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-18_11,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 lowpriorityscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407180106
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kowal@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


On 7/16/2024 3:18 PM, Cédric Le Goater wrote:
> Hello Mike,
>
> On 7/16/24 21:56, Michael Kowal wrote:
>> These changes provide enhanced support of the External Interrupt 
>> Virtualization
>> Engine.  The changes are focused on the following areas:
>>   - Cache Watch, Cache Flush and Sync Injection
>>   - Virtual Structure Tables
>>   - Set Translation Table
>>   - 'info pic' command data that is dumped
>>
>> Frederic Barrat (7):
>>    pnv/xive2: XIVE2 Cache Watch, Cache Flush and Sync Injection support
>>    pnv/xive2: Add NVG and NVC to cache watch facility
>>    pnv/xive2: Configure Virtualization Structure Tables through the PC
>>    pnv/xive2: Enable VST NVG and NVC index compression
>>    pnv/xive2: Set Translation Table for the NVC port space
>>    pnv/xive2: Fail VST entry address computation if table has no VSD
>>    pnv/xive2: Move xive2_nvp_pic_print_info() to xive2.c
>>
>> Michael Kowal (1):
>>    pnv/xive2: Structure/define alignment changes
>>
>> Nicholas Piggin (1):
>>    pnv/xive: Support cache flush and queue sync inject with 
>> notifications
>>
>>   hw/intc/pnv_xive2_regs.h    | 108 +++++++
>>   include/hw/ppc/pnv_chip.h   |   1 +
>>   include/hw/ppc/xive2_regs.h |   9 +
>>   hw/intc/pnv_xive2.c         | 566 ++++++++++++++++++++++++++++++------
>>   hw/intc/xive.c              |  12 +-
>>   hw/intc/xive2.c             |  33 ++-
>>   6 files changed, 633 insertions(+), 96 deletions(-)
>>
>> -- 
>> 2.43.0
>>
>
> Hello Mike,
>
> When you respin a series, it is useful to update the individual
> patches with the given R-b tags. To keep track of them, you can use
> the b4 command :
>     $ b4 am 20240715183332.27287-1-kowal@linux.vnet.ibm.com
>   Grabbing thread from 
> lore.kernel.org/all/20240715183332.27287-1-kowal@linux.vnet.ibm.com/t.mbox.gz
>   Analyzing 23 messages in the thread
>   Looking for additional code-review trailers on lore.kernel.org
>   Checking attestation on all messages, may take a moment...
>   ---
>     ✓ [PATCH v2 1/9] pnv/xive2: XIVE2 Cache Watch, Cache Flush and 
> Sync Injection support
>     ✓ [PATCH v2 2/9] pnv/xive2: Structure/define alignment changes
>       + Reviewed-by: Cédric Le Goater <clg@redhat.com>
>     ✓ [PATCH v2 3/9] pnv/xive: Support cache flush and queue sync 
> inject with notifications
>     ✓ [PATCH v2 4/9] pnv/xive2: Add NVG and NVC to cache watch facility
>     ✓ [PATCH v2 5/9] pnv/xive2: Configure Virtualization Structure 
> Tables through the PC
>       + Reviewed-by: Cédric Le Goater <clg@redhat.com>
>     ✓ [PATCH v2 6/9] pnv/xive2: Enable VST NVG and NVC index compression
>       + Reviewed-by: Cédric Le Goater <clg@redhat.com>
>     ✓ [PATCH v2 7/9] pnv/xive2: Set Translation Table for the NVC port 
> space
>       + Reviewed-by: Cédric Le Goater <clg@redhat.com>
>       + Reviewed-by: Cédric Le Goater <clg@kaod.org>
>     ✓ [PATCH v2 8/9] pnv/xive2: Fail VST entry address computation if 
> table has no VSD
>       + Reviewed-by: Cédric Le Goater <clg@redhat.com>
>       + Reviewed-by: Cédric Le Goater <clg@kaod.org>
>     ✓ [PATCH v2 9/9] pnv/xive2: Move xive2_nvp_pic_print_info() to 
> xive2.c
>     ---
>     ✓ Signed: DKIM/ibm.com (From: kowal@linux.vnet.ibm.com)
>
Thank you for the suggestion Cedric.  I can get `b4 am` to run but the 
attestation (signature checking?) fails.  In the future I will post the 
following, along with revision comments in the cover letter.  Following 
is the output for v3:

   [PATCH v3 1/9] pnv/xive2: XIVE2 Cache Watch, Cache Flush and Sync 
Injection support
     + Reviewed-by: Cédric Le Goater <clg@redhat.com>
   [PATCH v3 2/9] pnv/xive2: Structure/define alignment changes
     + Reviewed-by: Cédric Le Goater <clg@redhat.com>
   [PATCH v3 3/9] pnv/xive: Support cache flush and queue sync inject 
with notifications
     + Reviewed-by: Cédric Le Goater <clg@redhat.com>
   [PATCH v3 4/9] pnv/xive2: Add NVG and NVC to cache watch facility
     + Reviewed-by: Cédric Le Goater <clg@redhat.com>
   [PATCH v3 5/9] pnv/xive2: Configure Virtualization Structure Tables 
through the PC
     + Reviewed-by: Cédric Le Goater <clg@redhat.com>
   [PATCH v3 6/9] pnv/xive2: Enable VST NVG and NVC index compression
     + Reviewed-by: Cédric Le Goater <clg@redhat.com>
   [PATCH v3 7/9] pnv/xive2: Set Translation Table for the NVC port space
     + Reviewed-by: Cédric Le Goater <clg@redhat.com>
     + Reviewed-by: Cédric Le Goater <clg@kaod.org>
   [PATCH v3 8/9] pnv/xive2: Fail VST entry address computation if table 
has no VSD
     + Reviewed-by: Cédric Le Goater <clg@redhat.com>
     + Reviewed-by: Cédric Le Goater <clg@kaod.org>
   [PATCH v3 9/9] pnv/xive2: Move xive2_nvp_pic_print_info() to xive2.c
---
Total patches: 9

Thanks, Mike...


> Thanks,
>
> C.
>
>


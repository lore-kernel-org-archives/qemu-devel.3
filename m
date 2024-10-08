Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13226CEFC35
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 17:41:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syECk-0001ur-Ib; Tue, 08 Oct 2024 13:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1syECh-0001uY-Eg; Tue, 08 Oct 2024 13:40:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1syECe-0002aA-Bd; Tue, 08 Oct 2024 13:40:58 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498HJvCD016332;
 Tue, 8 Oct 2024 17:40:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=q
 eAbOElo2YeUlknGPju1AEPNVG+UqNsHAIZCtudPhV4=; b=B04V7AcriUxFIQ0VN
 nJMJDKtF5VH45TCTnr891GNPbKv9F+kgrs+CeJUqJwAYBaeXGnD7dsSXIL9Iwz5W
 54RKy0dsvBn4cgS/iexHD4qgHqCxeMxqz2rgYX73YaAHk7oIy5phYPlzT3Jdbn0A
 8ZQTBF99eW+MbeZG91dScMAsy3wQGOArYd1H/gFjHKuN5KH07qxVd6PpQteXuWsp
 1D3YRs5QR8iFC1St4Eb9t58qp62RDX0GNpjoccaSJsHZaqdPmLx+MNz0K12QQBOZ
 WPl4VExUvrtPF6vKIJWgKB+iSULCXJHcfCgS+ZvpNVpt4v702AakT+Vf8JR9YA87
 QWnxQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42591qr419-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 17:40:44 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 498Heigv030901;
 Tue, 8 Oct 2024 17:40:44 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42591qr414-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 17:40:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 498GUIVm030187;
 Tue, 8 Oct 2024 17:40:43 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 423gsmnr6t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 17:40:43 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 498Hedtb51315040
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Oct 2024 17:40:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C601820049;
 Tue,  8 Oct 2024 17:40:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0A7CE20040;
 Tue,  8 Oct 2024 17:40:37 +0000 (GMT)
Received: from [9.43.109.153] (unknown [9.43.109.153])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  8 Oct 2024 17:40:36 +0000 (GMT)
Message-ID: <7a0a26d9-64db-421e-a1c5-c354c58d72b6@linux.ibm.com>
Date: Tue, 8 Oct 2024 23:10:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.2 v3 0/3] hw/ssi/pnv_spi: Remove PnvXferBuffer and
 get_seq_index()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, calebs@linux.ibm.com,
 chalapathi.v@ibm.com, saif.abrar@linux.ibm.com,
 dantan@linux.vnet.ibm.com, milesg@linux.ibm.com, philmd@linaro.org,
 alistair@alistair23.me
References: <20240918165045.21298-1-chalapathi.v@linux.ibm.com>
 <D4Q989HQVNJA.3LVK3LEUYT1G4@gmail.com>
 <39750f12-b3ce-4653-91e0-988889ef0d02@kaod.org>
Content-Language: en-US
From: Chalapathi V <chalapathi.v@linux.ibm.com>
In-Reply-To: <39750f12-b3ce-4653-91e0-988889ef0d02@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1Z24KiMlFOL7_rIlCTY7r0t9CRo20u6i
X-Proofpoint-ORIG-GUID: fpZg4bWwmeztsDl8GmsIjVDyPs4GhKrI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_15,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 mlxlogscore=857 mlxscore=0 malwarescore=0 suspectscore=0 spamscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080111
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


On 08-10-2024 18:14, Cédric Le Goater wrote:
> On 10/8/24 09:43, Nicholas Piggin wrote:
>> On Thu Sep 19, 2024 at 2:50 AM AEST, Chalapathi V wrote:
>>> Hello,
>>>
>>> v3:
>>> 1. Update the PowerNV maintainer section to include hw/ssi/pnv_spi*
>>> 2. Use of PnvXferBuffer results in a additonal process overhead due to
>>> frequent dynamic allocations and hence use an existing Fifo8 buffer.
>>> 3. Use a local variable seq_index and use it with in while loop instead
>>> of repeatedly calling get_seq_index() and make sure s->seq_op doesn't
>>> overrun when seq_index is incremented.
>>>
>>> Tested:
>>> passed make check and make check-avocado
>>>
>>> Supersedes: <20240807202804.56038-1-philmd@linaro.org>
>>
>> Hi Chalapathi,
>>
>> To be clear, this fixes Coverity CID 1558831? A Resolves:
>> tag for the CID should be there, I guess it's patch 2?
>
>
> Patches should have a tag :
>
> Resolves: Coverity CID XYZZY
>
> Thanks,
>
> C.
Sure. Will update. Thank You
>
>
>>
>> I like patch 2, but since it is quite a significant change,
>> should we take the v2 series first which is much smaller,
>> then add this conversion on top of it?
>>
>> If it was long-standing code that would be important (because
>> you don't want to introduce regressions or conflicts when
>> backporting fixes). Since this is a new model I guess there
>> is leeway to just take v3 as is.
>>
>> Thanks,
>> Nick
>>
>>>
>>> Philippe Mathieu-Daudé (1):
>>>    MAINTAINERS: Cover PowerPC SPI model in PowerNV section
>>>
>>> Chalapathi V (2):
>>>    hw/ssi/pnv_spi: Replace PnvXferBuffer with Fifo8 structure
>>>    hw/ssi/pnv_spi: Use local var seq_index instead of get_seq_index().
>>>
>>>   MAINTAINERS              |   2 +
>>>   include/hw/ssi/pnv_spi.h |   3 +
>>>   hw/ssi/pnv_spi.c         | 228 
>>> +++++++++++++++------------------------
>>>   3 files changed, 89 insertions(+), 144 deletions(-)
>>
>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87660CEFC37
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 17:33:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syE4p-00077K-DZ; Tue, 08 Oct 2024 13:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1syE4m-00076U-NA; Tue, 08 Oct 2024 13:32:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1syE4k-0001V7-2y; Tue, 08 Oct 2024 13:32:47 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498Fo0Xl002243;
 Tue, 8 Oct 2024 17:32:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=m
 qGVq2Y29biRN3MUKQJETgNyFxMqpJ3auwnqSu/KxoI=; b=CFC9eddq0aCGTxsK5
 aBi6fgpfl9z+58VLDjonnv8UWXl9/9EA/Yam7YQR5AF2OHthVTcL9ThB9jZbZ83I
 XySJ2VjIT9LiWKAn9rTY/yQey8t82OQPs3ZdbHYiEu1IURpCdzc7XMVhQYVigkBU
 LZcpoaBadAD3N1oRkgDnSiLGYhPu35cuFbHM0Zaq23Qrs9WrhVTSVd5t+KQnRogG
 ltHM0/z3+sHv7j6BWKjrhKeKxpTdieCkQ3b4UE0ZDT6XnX4WXYW3DiUwEcRkFHM1
 3yiJgolnNexcsumjitMI8St2gLk9cPZzUsduY4Yn3wYupJBs0JlGNGV5EVwh1II+
 QUP/w==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4257qp8k97-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 17:32:32 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 498HWV9K012004;
 Tue, 8 Oct 2024 17:32:32 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4257qp8k8y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 17:32:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 498FEeLe013784;
 Tue, 8 Oct 2024 17:32:31 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 423fss5uk5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 17:32:30 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 498HWRPm50463098
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Oct 2024 17:32:27 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 75F0B2004D;
 Tue,  8 Oct 2024 17:32:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 633AC20040;
 Tue,  8 Oct 2024 17:32:24 +0000 (GMT)
Received: from [9.43.109.153] (unknown [9.43.109.153])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  8 Oct 2024 17:32:24 +0000 (GMT)
Message-ID: <9a1ca7f3-48aa-4d43-9684-9fc6782df835@linux.ibm.com>
Date: Tue, 8 Oct 2024 23:02:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] MAINTAINERS: Cover PowerPC SPI model in PowerNV
 section
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, clg@kaod.org,
 calebs@linux.ibm.com, chalapathi.v@ibm.com, saif.abrar@linux.ibm.com,
 dantan@linux.vnet.ibm.com, milesg@linux.ibm.com, philmd@linaro.org,
 alistair@alistair23.me
References: <20240918165045.21298-1-chalapathi.v@linux.ibm.com>
 <20240918165045.21298-2-chalapathi.v@linux.ibm.com>
 <D4Q994U5GSYV.2BL8PTP7YQZTG@gmail.com>
Content-Language: en-US
From: Chalapathi V <chalapathi.v@linux.ibm.com>
In-Reply-To: <D4Q994U5GSYV.2BL8PTP7YQZTG@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: L9Mx5iDmWRPCIw8vskDrzl28nu3tol5u
X-Proofpoint-ORIG-GUID: BiemTzylS83uPiulJ4SZTEuaBI_Sr4Ob
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_15,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 suspectscore=0 mlxlogscore=909 clxscore=1015 malwarescore=0
 impostorscore=0 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410080111
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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


On 08-10-2024 13:14, Nicholas Piggin wrote:
> On Thu Sep 19, 2024 at 2:50 AM AEST, Chalapathi V wrote:
>> From: "Philippe Mathieu-Daudé" <philmd@linaro.org>
>>
>> It is unfair to let the PowerNV SPI model to the SSI
>> maintainers. Also include the PowerNV ones.
>>
>> Fixes: 29318db133 ("hw/ssi: Add SPI model")
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
>> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
>> ---
>>   MAINTAINERS | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index ffacd60f40..b11c4edaf0 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1541,8 +1541,10 @@ F: hw/ppc/pnv*
>>   F: hw/intc/pnv*
>>   F: hw/intc/xics_pnv.c
>>   F: hw/pci-host/pnv*
>> +F: hw/ssi/pnv_spi.c
>>   F: include/hw/ppc/pnv*
>>   F: include/hw/pci-host/pnv*
>> +F: hw/ssi/pnv_spi*
> Should be include/hw/ssi/pnv_spi*

Sure. Will update in next version.

Thank You,

Chalapathi

>
> Otherwise,
>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
>
>>   F: pc-bios/skiboot.lid
>>   F: tests/qtest/pnv*
>>   F: tests/functional/test_ppc64_powernv.py


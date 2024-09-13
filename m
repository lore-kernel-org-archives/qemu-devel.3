Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AFF4FA3753
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 13:25:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp6IN-0004xv-2m; Fri, 13 Sep 2024 09:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1sp6IJ-0004uw-Lq; Fri, 13 Sep 2024 09:25:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1sp6IH-0003r1-9D; Fri, 13 Sep 2024 09:25:03 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48D9Ge5f018596;
 Fri, 13 Sep 2024 13:24:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=e
 qpP1jMOE0Zoa2NJIoBre2c4Dwti9awja84/K786h/U=; b=m4bh2p427CGWokQqs
 ZrdFseSK2D51K+JmhZHXtdrI7qgxThXUR72G15Ga8e6C9n17BuwqM4VG17DxeDFo
 91rq6zmNRwtcujTm9xdQrYu3JWQvSFTxfUxtrdE38B/5MiKzaOZm+jFNvntT70cC
 m8ZRNj0pGhCVK4XbSEZtlVd1AOPg7JczzPviUezU5RXltxafgwBtoCN8biKAaLQH
 flcbKcGcebEIlelePbe5IihXZd5kXb1494hfBxRX5DZBTMTUrCKrt05WGn8XQ5my
 CBEaciRU9I643NUkXUnCa9M3oq0qkxNfvVb6EcOz3+FyLrdco3XoeblihHT3KDWn
 0ONSg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gegxa831-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 13:24:46 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48DDN9ed007968;
 Fri, 13 Sep 2024 13:24:46 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gegxa82x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 13:24:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48DCgF2b027389;
 Fri, 13 Sep 2024 13:24:45 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41h3v3p1xh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 13:24:45 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48DDOf3440042924
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Sep 2024 13:24:41 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B775220043;
 Fri, 13 Sep 2024 13:24:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8ED9820040;
 Fri, 13 Sep 2024 13:24:39 +0000 (GMT)
Received: from [9.43.118.155] (unknown [9.43.118.155])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 13 Sep 2024 13:24:39 +0000 (GMT)
Message-ID: <d93476aa-d777-419b-90a2-b50bb2d861ff@linux.ibm.com>
Date: Fri, 13 Sep 2024 18:54:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v2 0/4] hw/ssi/pnv_spi: Fixes Coverity CID 1558831
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Alistair Francis <alistair@alistair23.me>
References: <20240807202804.56038-1-philmd@linaro.org>
 <d30b16a2-a45a-4596-bef8-2eac898a00e9@kaod.org>
Content-Language: en-US
From: Chalapathi V <chalapathi.v@linux.ibm.com>
In-Reply-To: <d30b16a2-a45a-4596-bef8-2eac898a00e9@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LRJX2N99OwaqzNLPbSdZwJwcZfzklCvN
X-Proofpoint-ORIG-GUID: b_ozIr5T0HbgxN8hMIGM_pLUD8sbJ6jN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_10,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 impostorscore=0 clxscore=1011 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409130091
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


On 12-09-2024 22:25, Cédric Le Goater wrote:
> Chalapthi,
>
> On 8/7/24 22:28, Philippe Mathieu-Daudé wrote:
>> v2:
>> - Cover PowerNV SSI in MAINTAINERS
>> - Use GLib API in pnv_spi_xfer_buffer_free()
>> - Simplify returning early
>>
>> Supersedes: <20240806134829.351703-3-chalapathi.v@linux.ibm.com>
>
> I was wondering where we were on this series. I see there were comments
> on the initial one that would need some response at least. Do you have
> plans for a respin ?
>
> Thanks,
>
> C.
>
Hello Cedric,

Thank You so much for reminding me. I apologize for not getting back on 
this sooner. I am working on the review comments from initial v1 
patchset and send the v2 patchset ASAP.

Thank You,

Chalapathi
>
>> Chalapathi V (1):
>>    hw/ssi/pnv_spi: Fixes Coverity CID 1558831
>>
>> Philippe Mathieu-Daudé (3):
>>    MAINTAINERS: Cover PowerPC SPI model in PowerNV section
>>    hw/ssi/pnv_spi: Match _xfer_buffer_free() with _xfer_buffer_new()
>>    hw/ssi/pnv_spi: Return early in transfer()
>>
>>   MAINTAINERS      |  2 ++
>>   hw/ssi/pnv_spi.c | 12 +++++++-----
>>   2 files changed, 9 insertions(+), 5 deletions(-)
>>
>
>


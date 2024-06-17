Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04B3C41513
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 10:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ9Sq-0008Og-Ar; Mon, 17 Jun 2024 06:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sJ9So-0008Nx-8A; Mon, 17 Jun 2024 06:19:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sJ9Sm-0007mM-LW; Mon, 17 Jun 2024 06:19:50 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45H9LRmb017196;
 Mon, 17 Jun 2024 10:19:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:from:to:cc:references
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=b
 naqF5f+MjHEjhwSQLKVYpfp4bPRng0ElmB95Sstn98=; b=JIpHRseJLKAOhD/As
 9oyAlbw37OA7utUSGOMzVCTNITnR047q4LkdQqhwkbwY8iC2Samejg3TiP7sD2+Y
 /v9s3IekuLcGqY+GWtcJZDKQhcvdJGD0YCnNbDGpFbZQVZGBzxIgmDXddHDLFFHE
 RdeZZqDOAJdtmMmoQIS1gvmZd8rTgw2OEMomqW6O6MWcm0L0PaVcYk2Z+FRw/UmP
 YalE3cr0ajiw1DQBoWQcEGoKiSffPZ9wuK/XqR/Fjjh5Ws2w0bfHiMhXI9/rY6fQ
 hS9K1VSDoRYGe+SP1Csgd4oaxuyvyHfqn8KcmT8EK77vRLtMl4Z2TPCQe7x1bqEE
 xnBtw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ytj3q86m3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Jun 2024 10:19:35 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45HAI9F5013850;
 Mon, 17 Jun 2024 10:19:34 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ytj3q86kx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Jun 2024 10:19:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45H8FtEJ009433; Mon, 17 Jun 2024 10:19:33 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ysqgm8qkq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Jun 2024 10:19:33 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 45HAJU8J25100858
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 17 Jun 2024 10:19:32 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8DFEC58068;
 Mon, 17 Jun 2024 10:19:30 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5B1555803F;
 Mon, 17 Jun 2024 10:19:24 +0000 (GMT)
Received: from [9.124.223.158] (unknown [9.124.223.158])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Jun 2024 10:19:24 +0000 (GMT)
Message-ID: <5fa7e414-efc6-4051-8472-a4f90263b106@linux.ibm.com>
Date: Mon, 17 Jun 2024 15:49:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/26] hw/ppc: Avoid using Monitor in
 pnv_phb3_msi_pic_print_info()
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20240610062105.49848-1-philmd@linaro.org>
 <20240610062105.49848-2-philmd@linaro.org>
 <81d3ec2b-2fec-4412-843a-159952dcd79d@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <81d3ec2b-2fec-4412-843a-159952dcd79d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PpQLTvjgZNjUJWqfogC31zPM0FXZ_6BS
X-Proofpoint-GUID: LgQ6zPAcOXUIYq7z14j9fx5mm0pJ2KrV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_08,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 impostorscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406170076
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Phillipe,

One query below:

On 6/17/24 15:41, Harsh Prateek Bora wrote:
> 
> 
> On 6/10/24 11:50, Philippe Mathieu-Daudé wrote:
>> Replace Monitor API by HumanReadableText one.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> 
>> ---
>>   include/hw/pci-host/pnv_phb3.h |  2 +-
>>   hw/pci-host/pnv_phb3_msi.c     | 21 ++++++++++-----------
>>   hw/ppc/pnv.c                   |  8 +++++++-
>>   3 files changed, 18 insertions(+), 13 deletions(-)
>>

<snip>

>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index 6e3a5ccdec..5356a4e295 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -38,6 +38,7 @@
>>   #include "hw/loader.h"
>>   #include "hw/nmi.h"
>>   #include "qapi/visitor.h"
>> +#include "qapi/type-helpers.h"
>>   #include "monitor/monitor.h"
>>   #include "hw/intc/intc.h"
>>   #include "hw/ipmi/ipmi.h"
>> @@ -774,8 +775,13 @@ static void 
>> pnv_chip_power8_pic_print_info(PnvChip *chip, Monitor *mon)
>>       for (i = 0; i < chip8->num_phbs; i++) {
>>           PnvPHB *phb = chip8->phbs[i];
>>           PnvPHB3 *phb3 = PNV_PHB3(phb->backend);
>> +        g_autoptr(GString) buf = g_string_new("");
>> +        g_autoptr(HumanReadableText) info = NULL;
>> +
>> +        pnv_phb3_msi_pic_print_info(&phb3->msis, buf);
>> +        info = human_readable_text_from_str(buf);
>> +        monitor_puts(mon, info->human_readable_text);
>> -        pnv_phb3_msi_pic_print_info(&phb3->msis, mon);
>>           ics_pic_print_info(&phb3->lsis, mon);

How is the memory allocated to info in human_readable_text_from_str 
being reclaimed here? Isnt it a mem leak ?

Thanks
Harsh

>>       }
>>   }
> 


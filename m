Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD49C54E67
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 04:58:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1royst-0004nk-Qv; Tue, 26 Mar 2024 00:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1roysY-0004k3-CB; Tue, 26 Mar 2024 00:57:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1roysT-0001lU-Td; Tue, 26 Mar 2024 00:57:42 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42Q40tEc003807; Tue, 26 Mar 2024 04:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=3AOS8E6v5/h8eE/cspkgTqdbz3NhPJN+ZjiqK0tDX/Y=;
 b=lsmxKze0V+2fab/ergeOgjp2kCY61P31rdX0QVZk9fcKjAdq48nuXYGslhZ+ycVW4TWo
 cRyJTMkoM9f9V4i1ZQY70y2IesS3R4YARqM2u87Bl7MOXx7geLqg/3fnlfazgpfFqu8V
 m1Z2F6DnTDhT9z/VZ6E+KgRLsHQWsn3MS60Be1Iq0rfyON9ycWjkZIWQDocWuG+Ax+el
 FtLatTea/j2Bq+WNvL0L3ITZUvWW+vbntjQ/GfcvKtisxDcVO6J00rwTIqNGYxBprfIU
 FkNNWBqfTFEHTwVC/8thxtXG80LCa++k38Gm+oXRsF4WfPcTvmCws+KlO8mpkNhGFR8s 7w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x3p6b068j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Mar 2024 04:57:32 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42Q4vVA3021605;
 Tue, 26 Mar 2024 04:57:31 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x3p6b068h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Mar 2024 04:57:31 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42Q2ovcb028685; Tue, 26 Mar 2024 04:57:31 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x2adp5md2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Mar 2024 04:57:31 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42Q4vSEb16843398
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Mar 2024 04:57:30 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7611758059;
 Tue, 26 Mar 2024 04:57:28 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A62E558043;
 Tue, 26 Mar 2024 04:57:26 +0000 (GMT)
Received: from [9.109.243.35] (unknown [9.109.243.35])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 26 Mar 2024 04:57:26 +0000 (GMT)
Message-ID: <caf9c25a-6851-4435-8f68-5d5c76443b5e@linux.ibm.com>
Date: Tue, 26 Mar 2024 10:27:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ppc/spapr: Include missing 'sysemu/tcg.h' header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20240322162459.7173-1-philmd@linaro.org>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20240322162459.7173-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 97woMP5exDT7JRONN3L-yBog5CHHXlX8
X-Proofpoint-ORIG-GUID: mvM9dSoq8AhHm8Pkysuh1ZoRcJFHsVvv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_02,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403260029
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
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



On 3/22/24 21:54, Philippe Mathieu-Daudé wrote:
> "sysemu/tcg.h" declares tcg_enabled(), and is implicitly included.
> Include it explicitly to avoid the following error when refactoring
> headers:
> 
>    hw/ppc/spapr.c:2612:9: error: call to undeclared function 'tcg_enabled'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>      if (tcg_enabled()) {
>          ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> ---
>   hw/ppc/spapr.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index c417f9dd52..e9bc97fee0 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -35,6 +35,7 @@
>   #include "sysemu/sysemu.h"
>   #include "sysemu/hostmem.h"
>   #include "sysemu/numa.h"
> +#include "sysemu/tcg.h"
>   #include "sysemu/qtest.h"
>   #include "sysemu/reset.h"
>   #include "sysemu/runstate.h"


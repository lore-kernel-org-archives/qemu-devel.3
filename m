Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B52ECCD185
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 04:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9G4b-000309-RN; Thu, 16 Oct 2025 00:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v9G4a-0002zs-CB; Thu, 16 Oct 2025 00:58:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v9G4Y-00080P-Bo; Thu, 16 Oct 2025 00:58:44 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FNln8F010186;
 Thu, 16 Oct 2025 04:58:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=8Zrx+q
 PyLTH/fw4Nui2hKlXFHLw/LlV6/wbJy/b6xdQ=; b=Hty4WkdmHz+bA8/c3+V+bw
 +Q44dFGBz8iczkM1ZeDrluvsNIB87ZbWm4vwOYBhM8hQ2z/eGybq0MfRHM3EXMyq
 nsYGo1DYhxX3Vme6LVTS5feXudrn5EHK7V2BdZtv16YB0E9g3l8GkATQvpL6w31N
 gySouVaUwidru+My0m46UH0IHXl4U5z+ZdcsjGJh6bDpRkx7qKrc8NC4/SVy/dpw
 +fBAlugipMXoq3Aco4pbDmo0vAnH+tHj18YRnmzGPZhDdn3KIzwGvYZppgoZ/1AP
 ZWAOwECdkYUjUY8tKnaC4UWeiUP2lZHaiEpThAET/nB60Yg5mkn9aFUzlWFRcXCQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qewu8g2r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 04:58:36 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59G4quM3008603;
 Thu, 16 Oct 2025 04:58:36 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qewu8g2k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 04:58:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59G2R0cO016745;
 Thu, 16 Oct 2025 04:58:34 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r32k3vp2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 04:58:34 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59G4wYeW65995034
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Oct 2025 04:58:34 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F25A58055;
 Thu, 16 Oct 2025 04:58:34 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D3FFE5804E;
 Thu, 16 Oct 2025 04:58:32 +0000 (GMT)
Received: from [9.109.242.24] (unknown [9.109.242.24])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Oct 2025 04:58:32 +0000 (GMT)
Message-ID: <467c85f5-12de-4bdb-9ab5-1c820e31f9de@linux.ibm.com>
Date: Thu, 16 Oct 2025 10:28:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/ppc/e500: Check for compatible CPU type instead of
 aborting ungracefully
To: Thomas Huth <thuth@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>
References: <20251015111243.1585018-1-thuth@redhat.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20251015111243.1585018-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EWq06oTyH3G0SjD6CxeHF-2swSPqmDke
X-Authority-Analysis: v=2.4 cv=Kr1AGGWN c=1 sm=1 tr=0 ts=68f07b7c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=zAi8430IooUuwH5XG9EA:9 a=QEXdDO2ut3YA:10 a=oH34dK2VZjykjzsv8OSz:22
 a=poXaRoVlC6wW9_mwW8W4:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-ORIG-GUID: -xlDW-4QDd6BkpW6Pk_dOyDjSsXbICJK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX/H/AW+zifNHz
 OsjxNxm0kkOzbGE2/4WDoJubpDzSZ1OrKlLmcqRyX7tq50+u/3b276l8up/hamuG4y4wlHkhE2t
 yRZQ0QzLYd0Mp4PMi6map+pn3p+6rh+lOELSyGA/yNDtduueDHfWSiQAf+vTTsQ/TWq21yPf+50
 a6OmgPiokebmCUnbyFg+6Nv4c/PbM5E4olckKS+K+X6c7559Drmy/Al5fdw+YoPPrf75PdxmvoH
 b0paC9AqQ62Y9Tm+/L64pTLnmKJ78B4dMHEzBjRS6BY2LvcokvDKCxaVt0lgzjawFAK2kzgf2ct
 g+Wes2tr4BdKhXQUUUA6G17zqOqmsS4EJwos7/MllMfGQbgOlDLe7QFm8wE69jQjyevM/YSXMJs
 vUXS78PC7Pe4HqPa6XtzD9fRUknIzg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 10/15/25 16:42, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> When using the ppce500 machine with an embedded CPU type that has
> the right MMU model, but is not part of the e500 CPU family, QEMU
> currently aborts ungracefully:
> 
>   $ ./qemu-system-ppc -machine ppce500 -cpu e200z5 -nographic
>   qemu-system-ppc: ../qemu/hw/core/gpio.c:108: qdev_get_gpio_in_named:
>    Assertion `n >= 0 && n < gpio_list->num_in' failed.
>   Aborted (core dumped)
> 
> The ppce500 machine expects a CPU with certain GPIO interrupt pins,
> so let's replace the coarse check for the MMU_BOOKE206 model with
> a more precise check that only allows CPUs from the e500 family.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3162
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   v2: Drop the old check for the MMU_BOOKE206 model
> 
>   hw/ppc/e500.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index 723c97fad2e..3d69428f31c 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -20,6 +20,7 @@
>   #include "qemu/guest-random.h"
>   #include "exec/target_page.h"
>   #include "qapi/error.h"
> +#include "cpu-models.h"
>   #include "e500.h"
>   #include "e500-ccsr.h"
>   #include "net/net.h"
> @@ -942,9 +943,8 @@ void ppce500_init(MachineState *machine)
>           env = &cpu->env;
>           cs = CPU(cpu);
>   
> -        if (env->mmu_model != POWERPC_MMU_BOOKE206) {
> -            error_report("MMU model %i not supported by this machine",
> -                         env->mmu_model);
> +        if (!(POWERPC_CPU_GET_CLASS(cpu)->svr & POWERPC_SVR_E500)) {
> +            error_report("This machine needs a CPU from the e500 family");
>               exit(1);

This indeed seems to be more appropriate check than checking against
mmu_model. Thanks to you and BALATON for catching this.

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

>           }
>   


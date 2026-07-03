Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E47CC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 17:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfhzq-0006VS-8q; Fri, 03 Jul 2026 13:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wfhzj-0006Sn-1U; Fri, 03 Jul 2026 13:48:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wfhzf-0006Yh-B8; Fri, 03 Jul 2026 13:48:05 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GIna63236652; Fri, 3 Jul 2026 17:47:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=C+fSEQ
 YD48a5wdIevKQXiLLI15J1f52+wt8655YLZv0=; b=AHeyM+9/Mm1+VUGEHETIvV
 L4RAQGX8MyBhMfVSPbuxU6zDltxi15b6k4vExvJ7oQh1sjjtw8SkiauU41aVMcBo
 ANTNP+QHmsfCelzlKevAfgLTDY7m/pD2M5en/DyOJ9wQ6cKZ/v412d/t5Wk18jrp
 oUSCmOiXaZaosjh1mKuZ1ty1reKOJRsRgGPf59WcZx5Pp4M1QjMD51dowmrc2cZ8
 sh5Hd3i1EAjm65kcZ2LzwxtBAp9QACvn3bXkD84AtIu4xsCZy5LBDi6Xy+AX8B+7
 pYzzq8wd4wdL82do+i+u6q8BKtSv1UqshDb4Qt0PKEKKh4mj38aSruH5mo/OFCJg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26rffs95-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 17:47:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 663HJaQR020398;
 Fri, 3 Jul 2026 17:47:58 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2gsrpa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 17:47:58 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 663Hlvsm12321322
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2026 17:47:58 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8A5A25804E;
 Fri,  3 Jul 2026 17:47:57 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A542A5803F;
 Fri,  3 Jul 2026 17:47:55 +0000 (GMT)
Received: from [9.61.65.1] (unknown [9.61.65.1])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2026 17:47:55 +0000 (GMT)
Message-ID: <462f8169-16ad-457e-8505-d12d9fe867dd@linux.ibm.com>
Date: Fri, 3 Jul 2026 13:47:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 24/33] pc-bios/s390-ccw: Add signed component address
 overlap checks
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260703170032.1893204-1-zycai@linux.ibm.com>
 <20260703170032.1893204-25-zycai@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260703170032.1893204-25-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a47f5cf cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=MHhQ7DiV7CNW8Tm783kA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: mv6L2sXLT-2NQFse7bLHras1PgncZdiI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE3MyBTYWx0ZWRfX/DnT8XrPA34T
 O6JxW4sVte4snuB8FavR0OfzsGh75ENQlUDVSDnK8ZvQctsP7+ue82KGA7DIGKSokYyH8uS7k6h
 XaXRm4u0lJEMWy5b59PWEiYdRgxnkFyfbvcIXiDKpiBoUk7iUO+NBaYNO5nF85eAj3BmnCyi9jf
 rxVizr3PU8Z8C3fAhu+u1UMrpSsaDM0iyeiq2p7w3eSdUWN5IHyLK9wDIRMwEPcoFzSFG6xoWrc
 7GJR8RKqGmT3sSgBY16pwN3V4htQO/aWos63fCGn24w9m84s+mKwNHWEegfVoEtj5r0zlCBOf5F
 9mvIvv49A3ha620ksMm3o1AN+vIuSjYiw1L+Yc0bAz1KyhJcepxJ2g2xM3hioq6SZRdVnIU/TBS
 1zlXvU4ZqMx4OrwkbzCuk0Old/Apgc/WFRiHlNsah2CY2CDADYlyBX4R036T7kKCzuYwt+euQZh
 +//CcYmQ5O0pzxHTZaw==
X-Proofpoint-GUID: mv6L2sXLT-2NQFse7bLHras1PgncZdiI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE3MyBTYWx0ZWRfX+GryhQLBNxdP
 yWpot9zplA8leZ6k7BXPxnMTIytPzjfSTYcDGkrEyDeY4n8gAi5OyRPtnI4Hr+su/mTvyPYujCn
 ioGivsVyIgPkYIY+cn+zL5a/IlT4jMk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030173
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/3/26 1:00 PM, Zhuoying Cai wrote:
> Add address range tracking and overlap checks to ensure that no
> component overlaps with a signed component during secure IPL.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
> ---

...

> --- a/pc-bios/s390-ccw/secure-ipl.h
> +++ b/pc-bios/s390-ccw/secure-ipl.h
> @@ -112,4 +112,10 @@ static inline bool verify_signature(IplDeviceComponentEntry comp_entry,
>      return false;
>  }
>  
> +static inline bool intersects(uint64_t addr0, uint64_t size0,
> +                              uint64_t addr1, uint64_t size1)
> +{
> +    return addr0 + size0 > addr1 && addr1 + size1 > addr0;

Another way to do this to avoid any possibility of u64 overflow
would be to use subtraction:

if (addr1 > addr0)
    return addr1 - addr0 < size0;
return addr0 - addr1 < size1;

With something like that:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>




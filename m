Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C4CC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 18:11:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfiLq-0002Me-Ob; Fri, 03 Jul 2026 14:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wfiLf-0002JK-Cc; Fri, 03 Jul 2026 14:10:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wfiLd-0003QB-Bl; Fri, 03 Jul 2026 14:10:46 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663HmU2N3426629; Fri, 3 Jul 2026 18:10:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=0RfEoe
 OyxaQFaXwu2b2Dau684fjcXvNN0fngPDZADp0=; b=oxHrDUWQgJtSopUcsS7/Tj
 W8ZHuSO/SXODJBuY/oI7N/WsJbjB6xe9osBQn1whE2iN/NR9aBoFMEl/GSCfEJyo
 NRZUDJucoKOchUOzaY7utYylD3jloyyXBib7NVhiP32zaM2I4C7XjwIPKmccmD1u
 YxspxFPBIN5BmEnXMTRchEXmUT+7Nu6JZ2SAJCwzOdAoINrcFlumKQCMG6oR2I79
 GrbuLJoCGKUGFgn6nLmfm0l/TplGIQJIcqSHU4/36R5zINv3mx7eu1fIZaAOcjoe
 Y6jaXyCYgPi35lx/dpdMQC21y+aChnPRxTzi8FQ7QycFe96aDYugenSw1yyUa2Rw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26rffupg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 18:10:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 663I4dut009405;
 Fri, 3 Jul 2026 18:10:39 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2sukhys5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 18:10:39 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 663IAcG140305342
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2026 18:10:38 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8AB3C5804E;
 Fri,  3 Jul 2026 18:10:38 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9FFC15803F;
 Fri,  3 Jul 2026 18:10:36 +0000 (GMT)
Received: from [9.61.65.1] (unknown [9.61.65.1])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2026 18:10:36 +0000 (GMT)
Message-ID: <417c2e1e-18cc-4e82-9b3b-57e0f693daf8@linux.ibm.com>
Date: Fri, 3 Jul 2026 14:10:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 18/33] hw/s390x/ipl: Rework s390_ipl_map_iplb_chain
 for certificate storage
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260703170032.1893204-1-zycai@linux.ibm.com>
 <20260703170032.1893204-19-zycai@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260703170032.1893204-19-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a47fb20 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=y9g2XmA_h5nA1cDnWbYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: DCcrkXZ2bdcHoB-ahD2cmGbeWkmmpjnc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE3OCBTYWx0ZWRfX6ZuDSWaBIJKx
 sZRGAQRItbS/WDks978o/Bi5wf+UTiZSn8za6rpHUQZvDQ1S/EN8jX9KUum9RHll7tAO90Z51b1
 RPOWfGctie/TB0Mu5FV+EOEHBoRSQkUX9o9zawJCyuzWvNatNM3DptdM3ZcC7XgcZD3VD4lbV7Q
 oo+NtteM/1MZwONbTuVgp1R4aYnl0lGU+gp3FrXzEaVIZdnCaMOU+G67vs5QrVTG0hCrPwMeL3e
 z8zs1QAM4wRxYn0r5nINGqQBrpQtdr7iJNlKc2pQbdX84EfaGOCBbNjaqR6ykhPgjscltppcWaU
 BvoTKahK8VKnLyq7UOwlZENPUFyXCK0+SiwMJTEDbC9wG/uwVYn45dUzEVjVDZi0yJg0gV8Q8TU
 74rmFQboFygEtAoZv6fpXjBo60eROmylLyvTxBqts/YMhVHGTa72kBX8Vz19/evpKZNYYZ9zvZZ
 VkmgsGCziMawgIZC2uQ==
X-Proofpoint-GUID: DCcrkXZ2bdcHoB-ahD2cmGbeWkmmpjnc
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE3OCBTYWx0ZWRfX+WeNXXfqpzUh
 oSfNCLq02vTXzkppF+Z25/LQdjhgixLt1j9tSh7168FgS+jiLTsO2t9RbtbSQULB0ktysFkfOFB
 Xs81GfpPUZyh6uL7n5bOgKGTPihtNms=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030178
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
> Rework s390_ipl_map_iplb_chain to always allocate maximum memory for
> the IPLB chain, regardless of the number of boot devices. This space
> is also used to store certificates during secure boot, providing a
> safe location for certificates until the kernel reads them during boot.
> 
> Rename next_iplb to ipl_data to better reflect its multiple purposes:
> storing both IPLB chains and certificate data.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Eric Farman <farman@linux.ibm.com>

...
> +QEMU_BUILD_BUG_MSG(sizeof(IplParameterBlock) * (MAX_BOOT_DEVS - 1) != CERT_BUF_SIZE,
> +                   "certificate buffer size is wrong");
>  
>  static void update_machine_ipl_properties(IplParameterBlock *iplb)
>  {
> diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
> index a2180719b1..58329fb5bc 100644
> --- a/include/hw/s390x/ipl/qipl.h
> +++ b/include/hw/s390x/ipl/qipl.h
> @@ -42,6 +42,7 @@ typedef enum S390IplType S390IplType;
>  #define S390_IPLB_MAX_LEN 4096
>  
>  #define MAX_CERTIFICATES  64
> +#define CERT_BUF_SIZE     (7 * 4096)

Isn't the idea here to just limit to the minimum amount of space
necessary to accommodate the largest number of possible boot
devices?

In other words, can this also use MAX_BOOT_DEVS e.g.

#define CERT_BUF_SIZE     ((MAX_BOOT_DEVS - 1) * 4096)

Then the bug message above would only fire if we change the
IplParameterBlock size, a far less obvious (and less likely) thing to
happen.

Or is there some other reason we cannot exceed 7 despite what QEMU
might request?

With that change (or an explanation on why we cannot and must bug out
if MAX_BOOT_DEVS != 8 || sizeof(IplParameterBlock) != 4K)

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>




Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C6BDC54EFC
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 09:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woeII-0001iY-L0; Tue, 28 Jul 2026 05:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1woeIG-0001hd-3L; Tue, 28 Jul 2026 05:40:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1woeIE-0007Gu-GF; Tue, 28 Jul 2026 05:40:11 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S8Hvvl521165; Tue, 28 Jul 2026 09:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=5Zt8jCyI7ZyP673H3DXohRcDcb0Xoq
 FyMcEgqynr9bc=; b=fFtfKlpCu+mMw0rmrpYodIGyZx78tIrqinnNQ4jSHUM9Vk
 dgrmXXW9xJdmIfDbXUWbmx68rWwSMkCn/HJ2sb/RPHHkPcvHAnkhb6xx5cbzOgbD
 sZkEAz+lL8OXMMRsgIPwknodtdYHyJ3Uv4rZ0rvzcREwAS787kax0ICVTJjBrHLS
 3DJpyqPoE0AH6kZ02+KKjtQmpT+IHfrBqCQ67cM+xo1+CgrgHfhwaUHtwiDow48R
 AYh+VMKI2RFF9YMfomLRwjz8mjmr0zkUHYLZGRY+E/a17Y1hIqZQyf6r37D8rOdz
 g2q+hDLQkx73aVCzRt+ve0QWKl4gcjP2ubQe/5dA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwcuxgy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jul 2026 09:40:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66S9QOo5031821;
 Tue, 28 Jul 2026 09:40:07 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fq9by8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jul 2026 09:40:07 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66S9e37k44302800
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jul 2026 09:40:03 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7980420043;
 Tue, 28 Jul 2026 09:40:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CBEDE20040;
 Tue, 28 Jul 2026 09:40:01 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 28 Jul 2026 09:40:01 +0000 (GMT)
Date: Tue, 28 Jul 2026 15:10:24 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Glenn Miles <milesg@linux.ibm.com>,
 qemu-ppc@nongnu.org, Chinmay Rath <rathc@linux.ibm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] target/ppc/cpu_init: make cpu listing determnistic
Message-ID: <20260728150627.b0e3b230-14-amachhiw@linux.ibm.com>
Mail-Followup-To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 qemu-devel@nongnu.org, Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org,
 Chinmay Rath <rathc@linux.ibm.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>
References: <20260720192403.66694-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720192403.66694-1-pierrick.bouvier@oss.qualcomm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: IVrhZVzkCClyGV7LKEhD4U-NcO4qpLv4
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA4MCBTYWx0ZWRfXxEiYxaQH6ma5
 t64EKbgHjptvqqgQA6fVLnFAmVlsB6pr6LUsSK8UpFxX/JdrgfL1mVFP7COvmsGA43Tb4pfZlbs
 8XZSNT+LPB3cCdAw5DuEm6UUYc/0RN8=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a6878f8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=Z-4x5wT5InqdIIAgZasA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA4MCBTYWx0ZWRfX1KvspSRpsISs
 vjLg//Dak4EMpVpWytlL3W9AJMsVp3TBxWlK6DOQ1aYG0nUEGOGKwwLUbvLy/JQZPo/uBjy315c
 ZC8T8BWbsNLKbdeeCcgHgAXgnef1+FPbjWTpf19Jrz5RiJxFrdni1AqS+wav6GLtcRofUSzwToN
 DDrJnxlszPCpG0KGiuv6w3tK1gzLYCm92I9DdE5IP8E2roBl/f1x+JECKJpMIPUEjmH2SfPIwyn
 0RRr1D320UszDmK0hkCCXP5mytalwhTij+7vG2efb3tbF5IF+8RMSNxmfrisJ/bz4U02jlRRBHX
 VJh9lGHNHS5SW5hjzEIPH0JQIqYBRsUl8DajMxWcF0FobMpVH7BhWbY+EoqOIxjHpUzc3MdpOcF
 LJ9Jy7goPxrwUARbPoRckINGFDbG5tLKNHiFVgWTbmyQIGH3chYhAjwspQrIpwrLJdE957iXFlx
 Vsfp41H2WXu7xg6SeUg==
X-Proofpoint-GUID: N-8DKGzM3jykyd47Y6yEsHg8KYsN3JeQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280080
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 2026/07/20 07:24 PM, Pierrick Bouvier wrote:
> The existing compare function only make sure that we list cpus with PVR
> order. However, we never compare cpu names.
> As a result, while cpus are grouped per PVR, the order within a group is
> non deterministic. Depending on QOM type initialization order, we get
> different results for -cpu help.
> 
> For instance, previous output could be:
> Available CPUs:
>   755_v1.0         PVR 00083100
>   745_v1.0         PVR 00083100
>   755_v1.1         PVR 00083101
>   745_v1.1         PVR 00083101
> 
> While a sorted output should be:
> Available CPUs:
>   745_v1.0         PVR 00083100
>   755_v1.0         PVR 00083100
>   745_v1.1         PVR 00083101
>   755_v1.1         PVR 00083101
> 
> Fix it by comparing cpu names to have a stable result.

Verified the before/after output of `qemu-system-ppc64 -cpu help`. The
patch correctly stabilises ordering in all PVR-collision groups.

No regressions: identical CPU set, ordering only.

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com> 
Tested-by: Amit Machhiwal <amachhiw@linux.ibm.com> 

Minor nit: subject line has a typo ("determnistic" should be
"deterministic").

Thanks,
Amit

> This allows us to record and compare various command line results across
> versions to make sure we didn't break anything while working on
> single-binary.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  target/ppc/cpu_init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index f404c7e549d..3443dbeeb01 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -7130,7 +7130,7 @@ static gint ppc_cpu_list_compare(gconstpointer a, gconstpointer b, gpointer d)
>          } else if (pcc_a->pvr > pcc_b->pvr) {
>              return 1;
>          } else {
> -            return 0;
> +            return strcmp(name_a, name_b);
>          }
>      }
>  }
> -- 
> 2.43.0
> 
> 


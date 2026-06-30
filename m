Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6AFCC44500
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 11:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weX1Q-0002WV-7B; Tue, 30 Jun 2026 07:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1weX1O-0002Ve-2H; Tue, 30 Jun 2026 07:52:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1weX1M-0001UV-El; Tue, 30 Jun 2026 07:52:57 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65U9nIpI1581758; Tue, 30 Jun 2026 11:52:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=KCxnIIaGEuIxO2XmE3sWJbEU5L+fBp
 bBF+/bCmtjHrs=; b=nmkSsOlnVqLmhoFeFcEm29ImcBna7F/Nf5Lxrnj6T9BhRt
 +d3vwu4k3EhXu6Fw8eyV9XC3bRZvXQLtKUkJornWOR2albspDVqogabS9zLoDGk8
 xxE4d+pMDM4I6jblWbOQO1wIHTQWdWlk1WJUeIrkxmBqkZligZwKKEBYhi6dKVuY
 r+b4lcHWb6yWoxWt3/IupPWZ396T3YyTkwc2RLdBLf6miMFCD/KltrfUDoFaB4Nd
 Fqui/sBHuh0KnDMMoVJMxDb4uxiJjqRk664o8jgsFylKYWRUskFunzrI/iX4sUsy
 deXzLABXPDe5Q+YrquJYaqR3ykvk80rC+/FOBPiQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26q9x9e1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 11:52:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UBnaD1015963;
 Tue, 30 Jun 2026 11:52:51 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruqa8fc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 11:52:51 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65UBqlTa39453004
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jun 2026 11:52:47 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C035720043;
 Tue, 30 Jun 2026 11:52:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2196820040;
 Tue, 30 Jun 2026 11:52:46 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 30 Jun 2026 11:52:45 +0000 (GMT)
Date: Tue, 30 Jun 2026 17:23:04 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: adityag@linux.ibm.com, harshpb@linux.ibm.com, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, milesg@linux.ibm.com, npiggin@gmail.com,
 amachhiw@linux.ibm.com
Subject: Re: [PATCH v3 1/2] ppc/pnv: avoid regenerating DTB if external DTB
 is present
Message-ID: <20260630172158.2d40c4a9-97-amachhiw@linux.ibm.com>
Mail-Followup-To: Shivang Upadhyay <shivangu@linux.ibm.com>, 
 adityag@linux.ibm.com, harshpb@linux.ibm.com, qemu-devel@nongnu.org, 
 qemu-ppc@nongnu.org, milesg@linux.ibm.com, npiggin@gmail.com
References: <20260630103508.254000-1-shivangu@linux.ibm.com>
 <20260630103508.254000-2-shivangu@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630103508.254000-2-shivangu@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEwOSBTYWx0ZWRfXyGvljQvlHx5h
 Qv/oc8IcL1xxU8kfs/IY7MdVZkPq1J7Fk4FTOsWegeYE3ZBFJggtjgo0/tR6DgSTf2xFL7DHu/y
 qZyh0M6xu5qt3gfqqbxwoiqaCIsT6bE7aaoGaieVInPUMugga7IVG5KRXHJdkcWCm8BAb5rtj0M
 maF4kjMzTJ8rf9Kmblr9cd1R+thf4qdGwNeQI5URmFqVjjWjk/abgh1H3O5yMxntCiQDwuldrpZ
 5gXapOahoHYfemnA6hvkdUwcZqr3lgaeeD06FnvYtZCxMgL7ifANN9GNiYN1+Ir5tHoJO/9gtyu
 dvgB3tFULxnNJUsDECI5/+2zqiHs9D+Hl5KrXve5UBsAWdjPMOQIdbuqyxP5lkL2Xmu4ak4lUQp
 34xu9JmvXR6IrUnWUXKcrb7vj1RWATZvUx69wNXepAF5ViiNHi+VuDD3Kx4Lk8Zmdw0r+LqigyF
 vVmq5KQ8qDmrYXOPCpQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEwOSBTYWx0ZWRfX0G10rh9P6kiP
 yr2Lja9W+SjFuLC9hQVoBwKAOG8CefFOYXXvkLKK8ygc8ZTkpmBgHX46jBRa2UWlhH8C+Z3+1TP
 qRG+gc9QoyFkxG0wO3bn35PxXhJdKt8=
X-Proofpoint-GUID: wpGCj5VS54YNY0a7FM0Oe1arMgOFFl_M
X-Proofpoint-ORIG-GUID: LIK_5m8EncOQNjLGTttePKqQKei793Nb
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a43ae14 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=NdBKe68Bqb0dG6RT75AA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300109
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

On 2026/06/30 04:05 PM, Shivang Upadhyay wrote:
> Currently externally provided dtb is overwritten in `pnv_reset`.
> Fix this by only creating dtb if not provided from `-dtb`.
> 
> Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> ---
>  hw/ppc/pnv.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

LGTM.

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

~Amit

> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 62812f22f8..afb6019b10 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -803,9 +803,13 @@ static void pnv_reset(MachineState *machine, ResetType type)
>          mpipl_write_succeeded = do_mpipl_write(pnv);
>      }
>  
> -    /* Regenerate device tree */
> -    fdt = pnv_dt_create(machine);
> -    _FDT((fdt_pack(fdt)));
> +    /* Only create new dt if not provided in -dtb */
> +    if (!machine->dtb) {
> +        fdt = pnv_dt_create(machine);
> +        _FDT((fdt_pack(fdt)));
> +    } else {
> +        fdt = machine->fdt;
> +    }
>  
>      /*
>       * If it's a MPIPL boot, add the "mpipl-boot" property, and reset the
> -- 
> 2.54.0
> 
> 


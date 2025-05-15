Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6488C3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:45:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFajM-0007QH-TO; Thu, 15 May 2025 11:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFajH-0007Eo-OE; Thu, 15 May 2025 11:42:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFajF-000651-Em; Thu, 15 May 2025 11:42:39 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCgPjB013188;
 Thu, 15 May 2025 15:42:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=rZstIUsAIvIMAd7WAvkbFMYgKQRpIiVao2F4kvHU4dM=; b=Dl4OpxmlD2JC
 yAdBvh0qYnOmdmWeZ2KeKO3TxEUqZdm2u6JZ9zzM5nrgS4S0GNADnSuA5w6DgAiJ
 gnwUln2WZ2dhBsf9FFIEEgFG5W0GhDOMIrQrtbSWMjzQ9+VBElevZYAhIvUbK7g+
 tvRcH/ndHykXzAUangPfa48GGWgt7LmdCTyuqOMS0Q+hCyJYGVRnUTx44G7iS5rI
 hQ0n3IG9S+5ZQxUA3rSNuAVjyJmcnY10yrvaHk0mNdYanC7oaH84aNko3AmEtLdq
 5m6giTbPGQcFXQ0n8ZIhq9QriiVSaVs05eVtAGfODyoMJmBfEbc5i5xJMh5N7uv3
 udf0ADnECQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0t9dhdr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:42:35 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FFgFMO026068;
 Thu, 15 May 2025 15:42:34 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0t9dhdn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:42:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FEKa9j015498;
 Thu, 15 May 2025 15:42:33 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfq303k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:42:33 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FFgVi814353028
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 15:42:32 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B9BA35805D;
 Thu, 15 May 2025 15:42:31 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 65C1C58059;
 Thu, 15 May 2025 15:42:31 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 15:42:31 +0000 (GMT)
Message-ID: <6bb381ea2a0a164636bb24566e1616e3ae922638.camel@linux.ibm.com>
Subject: Re: [PATCH 08/50] ppc/xive2: Use fair irq target search algorithm
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Fr=E9d=E9ric?= Barrat
 <fbarrat@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>, Caleb
 Schlossin <calebs@linux.vnet.ibm.com>
Date: Thu, 15 May 2025 10:42:31 -0500
In-Reply-To: <20250512031100.439842-9-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-9-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=etzfzppX c=1 sm=1 tr=0 ts=68260b6b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=jthM4rBR-rtT7kyaBgcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NSBTYWx0ZWRfX76HlZStN95xX
 FgLFWbKTenmee8mjo4OdLo1f6s7/EXFfqELub0NiNJ9+uhw/fIb+l/wYpJGYvVB7BqTR2EVVZ09
 PqEhI8lY2wxwFj2e7IQy71MdziOMMz/BeftCSMoGa0KpoNYkVh3OCSsl+NoAfRzc9SoWj78DvKt
 Bd/S4wkhP6TdJMcIIgFpMKIpl7rJGk6jicE0HdrCCI+4bdb8G3EnARoZ9qPlaYMlorGBQzO15M4
 uB8WV1TblmVSRUJu8fVUvFSVkjMOqwhkvj8Wr1J4S+AqYcSHLia1ngt+k6lm3K4fug9agabwx8b
 9XIbIzW8QXrSesRdmvpORanaEDkMq6eMgl2Pn/IfvbzGwQDqBorjDSmXBIFZzLrup+8C0w9KquS
 /9nReBULxL+pQ+F3wlSXcpF/j0NtDUJY2rgHR1KGTB+FeRBhYPy98n8vAdnGefzOQ81t9Dk+
X-Proofpoint-ORIG-GUID: Y0_IZf3Qk-kZ98JFeXeA3CiBOcb4vMdQ
X-Proofpoint-GUID: dttDyTchMBjqitaScKg5J2zL8TUZRsjh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 mlxlogscore=982 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150155
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

On Mon, 2025-05-12 at 13:10 +1000, Nicholas Piggin wrote:
> From: Glenn Miles <milesg@linux.ibm.com>
> 
> The current xive algorithm for finding a matching group vCPU
> target always uses the first vCPU found.  And, since it always
> starts the search with thread 0 of a core, thread 0 is almost
> always used to handle group interrupts.  This can lead to additional
> interrupt latency and poor performance for interrupt intensive
> work loads.
> 
> Changing this to use a simple round-robin algorithm for deciding which
> thread number to use when starting a search, which leads to a more
> distributed use of threads for handling group interrupts.
> 
> [npiggin: Also round-robin among threads, not just cores]
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> ---
>  hw/intc/pnv_xive2.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index 72cdf0f20c..d7ca97ecbb 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -643,13 +643,18 @@ static int pnv_xive2_match_nvt(XivePresenter *xptr, uint8_t format,
>      int i, j;
>      bool gen1_tima_os =
>          xive->cq_regs[CQ_XIVE_CFG >> 3] & CQ_XIVE_CFG_GEN1_TIMA_OS;
> +    static int next_start_core;
> +    static int next_start_thread;
> +    int start_core = next_start_core;
> +    int start_thread = next_start_thread;
>  
>      for (i = 0; i < chip->nr_cores; i++) {
> -        PnvCore *pc = chip->cores[i];
> +        PnvCore *pc = chip->cores[(i + start_core) % chip->nr_cores];
>          CPUCore *cc = CPU_CORE(pc);
>  
>          for (j = 0; j < cc->nr_threads; j++) {
> -            PowerPCCPU *cpu = pc->threads[j];
> +            /* Start search for match with different thread each call */
> +            PowerPCCPU *cpu = pc->threads[(j + start_thread) % cc->nr_threads];
>              XiveTCTX *tctx;
>              int ring;
>  
> @@ -694,6 +699,15 @@ static int pnv_xive2_match_nvt(XivePresenter *xptr, uint8_t format,
>                      if (!match->tctx) {
>                          match->ring = ring;
>                          match->tctx = tctx;
> +
> +                        next_start_thread = j + start_thread + 1;
> +                        if (next_start_thread >= cc->nr_threads) {
> +                            next_start_thread = 0;
> +                            next_start_core = i + start_core + 1;
> +                            if (next_start_core >= chip->nr_cores) {
> +                                next_start_core = 0;
> +                            }
> +                        }
>                      }
>                      count++;
>                  }



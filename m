Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7714ACA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 16:53:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCgVV-0001jc-VG; Fri, 02 Oct 2026 12:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xCgVQ-0001ig-6F; Fri, 02 Oct 2026 12:53:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xCgVO-0000Gb-8F; Fri, 02 Oct 2026 12:53:07 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692FZNoQ875436; Fri, 2 Oct 2026 16:52:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=Dja07UjBW5qHE5woE171Fy61IDnvwt/2guVD0AGJ4HU=; b=bL/rmwAqgSJa
 Pb9dn6DQGFqosoiFie8ErDt7ilZ+ZJ+vEdx4zK2uLo73/La9waQDzVbiDqhPGjEy
 MFgmC6rPZcr3mNuxMPs6nyHS/1TWqkv46NcYPe2iHcgun/cipglNNHc/AeSuph+7
 gGK0pAlM2kPw7DfG4hhtwl5eIBVJxmb3rvShu00fgckvtdHYlfIM/8BUfG1B0UBo
 kB6MmDPlwnOD0rl8E+XYuSDQW/ulXErbka9cgJ2uEec8SiM4KH8tPywmt6riL7u6
 QQM5u4QuoDAboBlvSZrZMgoYmG2qMB7D3HMQgNrkoWY8ASFgV2FCOUVsRBXOz8eu
 JUqMWfWW6w==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5s5ta88-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 02 Oct 2026 16:52:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 692GlT522806779; Fri, 2 Oct 2026 16:52:50 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h21nu2wvf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Oct 2026 16:52:50 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 692GqnvU4981304
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 2 Oct 2026 16:52:49 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 50A2358055;
 Fri,  2 Oct 2026 16:52:49 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 77EC458059;
 Fri,  2 Oct 2026 16:52:48 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  2 Oct 2026 16:52:48 +0000 (GMT)
Message-ID: <1c132f024d00d29ab2100e597791a2ceb39cebb0.camel@linux.ibm.com>
Subject: Re: [PATCH v3 2/5] ppc: Raise decrementer IRQ on zero write
From: Miles Glenn <milesg@linux.ibm.com>
To: "Kirill A. Korinsky" <kirill@korins.ky>, Harsh Prateek Bora
 <harshpb@linux.ibm.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Anushree Mathur <anushree.mathur@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>
Date: Fri, 02 Oct 2026 11:52:48 -0500
In-Reply-To: <20261001230058.11465-3-kirill@korins.ky>
References: <20261001230058.11465-1-kirill@korins.ky>
 <20261001230058.11465-3-kirill@korins.ky>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA2NiBTYWx0ZWRfX4+eH/NnBPg2n
 B0Idf8MMb6W1KGzLEhTsSfb4+4uN3chRudewmGDBpt7KJIAnabAIUDAWqYUVJYaS0hDvSjfmpHS
 QrfxfQ/DewtKBNMOknx969RdcvcUqic=
X-Authority-Analysis: v=2.4 cv=HJ5WhYtv c=1 sm=1 tr=0 ts=6abfe163 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=pcZqCyVeAAAA:8 a=Fw1mPT8r4YmRiSHXjYkA:9 a=QEXdDO2ut3YA:10
 a=SGy6VSG0Ue1xmPAwIFl9:22
X-Proofpoint-GUID: t59jOKSJokyH0Oq4bXAC-bJ6lNPjeKXp
X-Proofpoint-ORIG-GUID: zY90FkXCWHFvQ1AWRTTTqaRknIhs8JU4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA2NiBTYWx0ZWRfXyl3O8oEV0is7
 CY1bpCS59Jm/GxpWOyqIdcmpG45UblXa5hnxR09olj7kDtjoObvfhd48tka+sDAG9jFF6JpNHhu
 1Mg5LCfI3OKNw6bx0Raij/VaIuaPsvmdT2RgK0gWO+9E1X+Wb/7OWISM1+E4nwmRk7RBWy++HVJ
 3eafUyupYHU+IBD1INRhhNb1WTZN9J/M6ZwdMGsBy575B/UpC/dqt3ttkHrM0rSw9i4Mr+99Pvq
 Vl8ciVz0uSa4W+/PaqCZrm3+G4GUtQ+PrCslNENb1gQHNRlR7D5ICDBbyjsgEUV6/j+4o4TvG/M
 MjxEtWfUWLFa1Xsktjlds1IOPbmEaLLp3+iJO5I8mhn4PJ9Dzte6Hdnh5viHVPzwUSGj2XFZ3Oe
 i5dZZ4T3WalYvtVwhPqv7QPSCaCZp1S4OhcXag4V1Z5zcKJWUcg5Xl5FDyQT2Zh79aehoz+qSqa
 IWdJ95MBLU9QbiQ+Gkg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020066
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

No issues found.  LGTM!

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

Thanks,

Glenn

On Fri, 2026-10-02 at 00:59 +0200, Kirill A. Korinsky wrote:
> From: "Kirill A. Korinsky" <kirill@korins.ky>
> 
> OpenBSD writes zero to an edge triggered decrementer, then enters idle
> expecting its interrupt. QEMU defers the already due edge to a timer at
> the current virtual time, leaving the guest stalled.
> 
> Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
> Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Suggested-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>  hw/ppc/ppc.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index b123b4cc1c..6f99b61a28 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -885,6 +885,7 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, int64_t now, uint64_t *nextp,
>       * an edge interrupt, so raise it here too.
>       */
>      if (((flags & PPC_DECR_UNDERFLOW_LEVEL) && signed_value < 0) ||
> +        ((flags & PPC_DECR_ZERO_TRIGGERED) && value == 0) ||
>          ((flags & PPC_DECR_UNDERFLOW_TRIGGERED) && signed_value < 0
>            && signed_decr >= 0)) {
>          (*raise_excp)(cpu);
> @@ -1104,6 +1105,12 @@ void cpu_ppc_tb_init(CPUPPCState *env, uint32_t freq)
>      if (is_book3s_arch2x(env)) {
>          /* All Book3S 64bit CPUs implement level based DEC logic */
>          tb_env->flags |= PPC_DECR_UNDERFLOW_LEVEL;
> +    } else {
> +        /*
> +         * Classic 32-bit edge-triggered decrementer: zero write fires
> +         * immediately
> +         */
> +        tb_env->flags |= PPC_DECR_ZERO_TRIGGERED;
>      }
>      /* Create new timer */
>      tb_env->decr_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,



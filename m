Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF8B7CA5FA5
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 09:08:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCCiO-00022D-GZ; Thu, 01 Oct 2026 05:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1xCCgO-0001R5-2j; Thu, 01 Oct 2026 05:02:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1xCCgL-0007Uy-W4; Thu, 01 Oct 2026 05:02:27 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69175kj44041040; Thu, 1 Oct 2026 09:02:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=097BSk
 V9UqkroZtYdOMlBtL4sJZm2oSCqQka+6PSEWU=; b=NQVGDxh/5LRmd8aKwfzCX5
 nVv5dHPxt23xZMd807qh5rybY6jMNBXJtqhFmdPuP84AMSTCPSdrQApg1KHCIlBa
 hWQyctRgR1Z4lkqhaW8swogUL6veKSVbINUWNVbZIxUwZdeyY6nys85j1G4OaMER
 z/PSZbCWsxRqwK7Dt45cZ4KLMbBGL65LfA7Zm2Uk1bMkn8BHwUypxWv9ddzO6Ueu
 GZ/ZrUUyEyvnGBbXcah84x0996C0D6gOigry0XFlwnJbIzngAZ1Lq9UdxJmOdqi2
 2XVCmmKfaWf/F7hS0SCqQ2hOJtVO31zs2+ynyoC+R9jRAITldayi/MwHnaACIiRg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4feh3qe-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 01 Oct 2026 09:02:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69172Vev520693; Thu, 1 Oct 2026 09:02:16 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0hfpg049-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Oct 2026 09:02:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69192Cdf11141518
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Oct 2026 09:02:12 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C6C252004B;
 Thu,  1 Oct 2026 09:02:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB55120040;
 Thu,  1 Oct 2026 09:02:10 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu,  1 Oct 2026 09:02:10 +0000 (GMT)
Date: Thu, 1 Oct 2026 14:40:18 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: "Kirill A. Korinsky" <kirill@korins.ky>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: Re: [PATCH v2 2/5] ppc: Raise decrementer IRQ on zero write
Message-ID: <20261001143415.3f3b33fc-f8-amachhiw@linux.ibm.com>
Mail-Followup-To: "Kirill A. Korinsky" <kirill@korins.ky>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Chinmay Rath <rathc@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, 
 Anushree Mathur <anushree.mathur@linux.ibm.com>
References: <20260923230452.3765-1-kirill@korins.ky>
 <20260923230452.3765-3-kirill@korins.ky>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260923230452.3765-3-kirill@korins.ky>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abe2199 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=pcZqCyVeAAAA:8 a=_5QdOFVY6a3_dbhDXgkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=SGy6VSG0Ue1xmPAwIFl9:22 a=ojN_UKswjOqU4wFocON6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAzNCBTYWx0ZWRfX+zFnowf6C6rM
 0wj803sJEL/NtFfo2enP8cO5M9jJqlDib3EBDzsy51/xZpriU3UFk3c5BjjyoGtyz481d9sQzQw
 6DirKKl0dq4gk9xKT1tVJof1xAzozAY=
X-Proofpoint-ORIG-GUID: 3rqtt17uN7SuU3R9EsfBX9deHKtRzQfG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAzNCBTYWx0ZWRfX9ojgefR5N8ZT
 e41dd9uvV1kn4O/JI6boweCjLQPudkehteV8xKtGoMyFrzspUnATAbHXwZZds+KA9j73u9bGAmG
 M95u/zsEwy1UmzsKAea1xRsVLJAY56Q6/DVipeockLoh6kByipS0zDmSil4VlwMpWw7X4RN2ZMP
 od6rnFQuAP3bHvf+Dqv4EdzmPtaqDs2W5Miron8xKVJ2xsRAgIu1L1v0lC5Jxgh1FeYHFgy/OHu
 s+srnNZjvJSgNw2Cah8KNvyLsh/vpnNEZoV6OYIhAM3IMIgmMlLHuz3Dgbl5ibdU2cX7Ifc0OOK
 6fHNjlbedOdbbJvuzH7A+41dCirIMPf9umFPWePCMqs9bUcmneyBDk7asRRNAUgYK10P3i/U73T
 4iT50+fTcQVfWkemgMTqm0T0eFPsvSLc6bbuvbXBCyIbQnMnJ9mJv3WiOO8tDVzfgltRJDDBcWs
 j3NvTJvHK/R2FV01VzQ==
X-Proofpoint-GUID: O2Kzl3yEUUnzpQ8sLZPbojj2sDQF_vav
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010034
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

On 2026/09/24 01:03 AM, Kirill A. Korinsky wrote:
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
> index b123b4cc1c..736a37d32b 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -885,10 +885,17 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, int64_t now, uint64_t *nextp,
>       * an edge interrupt, so raise it here too.
>       */
>      if (((flags & PPC_DECR_UNDERFLOW_LEVEL) && signed_value < 0) ||
> +        ((flags & PPC_DECR_ZERO_TRIGGERED) && value == 0) ||

Thanks for the v2 — you got the guard right (PPC_DECR_ZERO_TRIGGERED in
__cpu_ppc_store_decr), but the flag-setting landed in the wrong place.

>          ((flags & PPC_DECR_UNDERFLOW_TRIGGERED) && signed_value < 0
>            && signed_decr >= 0)) {
>          (*raise_excp)(cpu);
>          return;
> +    } else {
> +        /*
> +         * Classic 32-bit edge-triggered decrementer: zero write fires
> +         * immediately
> +         */
> +        tb_env->flags |= PPC_DECR_ZERO_TRIGGERED;

My suggestion was to set PPC_DECR_ZERO_TRIGGERED once at init time in
cpu_ppc_tb_init().  In v2 it ended up inside the else block of
__cpu_ppc_store_decr() instead.

That mutates tb_env->flags at runtime on every DEC write that does not
immediately fire.  PPE42 goes through ppc_booke_timers_init() and gets
PPC_DECR_UNDERFLOW_TRIGGERED but not PPC_DECR_ZERO_TRIGGERED.  The first time a
guest writes a non-zero value to DEC on PPE42, this else block stamps
PPC_DECR_ZERO_TRIGGERED onto tb_env->flags — from that point on, every zero
write fires immediately, which contradicts the PPE42 architecture (commit
7197f6f7baf2).

The fix is the same two-liner I included in my v1 response:

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index b123b4cc1cce..6f99b61a2876 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -885,6 +885,7 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, int64_t now, uint64_t *nextp,
      * an edge interrupt, so raise it here too.
      */
     if (((flags & PPC_DECR_UNDERFLOW_LEVEL) && signed_value < 0) ||
+        ((flags & PPC_DECR_ZERO_TRIGGERED) && value == 0) ||
         ((flags & PPC_DECR_UNDERFLOW_TRIGGERED) && signed_value < 0
           && signed_decr >= 0)) {
         (*raise_excp)(cpu);
@@ -1104,6 +1105,12 @@ void cpu_ppc_tb_init(CPUPPCState *env, uint32_t freq)
     if (is_book3s_arch2x(env)) {
         /* All Book3S 64bit CPUs implement level based DEC logic */
         tb_env->flags |= PPC_DECR_UNDERFLOW_LEVEL;
+    } else {
+        /*
+         * Classic 32-bit edge-triggered decrementer: zero write fires
+         * immediately
+         */
+        tb_env->flags |= PPC_DECR_ZERO_TRIGGERED;
     }
     /* Create new timer */
     tb_env->decr_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,

PPE42 never enters cpu_ppc_tb_init() — it uses ppc_booke_timers_init() — so it
never gets PPC_DECR_ZERO_TRIGGERED and the new clause does not fire for it.  All
32-bit classic CPUs that go through cpu_ppc_tb_init() (7400, 750, 604, 7457)
take the else branch and get the flag set statically at boot, which is the right
place for it.

Thanks,
Amit


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED04C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 19:35:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96Ge-0007TP-UC; Tue, 22 Sep 2026 15:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1x96Ga-0007Rx-Hk; Tue, 22 Sep 2026 15:35:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1x96GW-0003dW-F2; Tue, 22 Sep 2026 15:34:58 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MI78SQ3447122; Tue, 22 Sep 2026 19:34:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ZFd3IY
 k8Ut0aD0xMInuvxRJJAA+ByXFN6vpK4+Km8rc=; b=XQ+XEBZQEMaHgJD6c24GbW
 1cXP+VkYDq+gFugEuEN3sZlYYGMKPg7iYRYxa2x78Th4JDSermrFV0w0pkawvRP7
 l/K69ekNxggUgpYX796KeMqAvX+Z8jxAr9tCby0K6cUluj0m8vkqzeZlOuo0TvdY
 Ufg+tCt1FskrzbvGEVe4jMDIulGlaMNXTdb6qN79kF8F4TBnk3Y6gujlk6CDWrp8
 IzGcjHFw6UQP6WJAMsxhU9+0U6UMUYQIrsIZRX65l/Zys3UCoGIiW1wkbjx7XnWv
 9mq/cieNmI4oOp6+ySwVmAyzQcc8bD1dht5icYsbORPaX8xrowMn4kJ16ZCeiJCw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1qmxt-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 19:34:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MIHi9f3198696; Tue, 22 Sep 2026 19:34:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt5qju7cc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 19:34:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68MJYgAX31588620
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 19:34:42 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 908ED20043;
 Tue, 22 Sep 2026 19:34:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D638620040;
 Tue, 22 Sep 2026 19:34:40 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 22 Sep 2026 19:34:40 +0000 (GMT)
Date: Wed, 23 Sep 2026 01:12:27 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: "Kirill A. Korinsky" <kirill@korins.ky>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Subject: Re: [PATCH 2/5] ppc: Raise decrementer IRQ on zero write
Message-ID: <20260923002139.9c3d31d4-37-amachhiw@linux.ibm.com>
Mail-Followup-To: "Kirill A. Korinsky" <kirill@korins.ky>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Chinmay Rath <rathc@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20260903115229.95811-1-kirill@korins.ky>
 <20260903115229.95811-3-kirill@korins.ky>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260903115229.95811-3-kirill@korins.ky>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: a_WLhGZnS1She4yF9y4HcypSZ-WSCXu-
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab2d858 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=zhRxUEseYeHzHtkwLcAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI4MCBTYWx0ZWRfXyzI3tB5AneUx
 cDDCzZP/LpmQL7CCtIQ807t1InriwaoL3EFF6YOxdDotLwFnD2PKDmfxecy8kCkz1MSv4v9jVYY
 WKmtb7XQPx2x4a6yzMtZuGujYJxDui8=
X-Proofpoint-GUID: EWAK_LL5VPz99uE27jhdOnT1WGaO8go4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI4MCBTYWx0ZWRfX9/P7Hs0fhjVx
 UWI+fXFLTXXLCNttgGeBGNHUoIYQVCsqvTqHBnqz6uwu9GYFtTIjxHE6DM3b0Ob7/2RFQxVs3VU
 azhe9XY8UxhOGn/wT2EGPwhf8iaUODhE186IEMh0ALqzfL4kR1u6f0gdnzd0qC6TTkeu2d8k8Yn
 FEu7hemTta1fAcEk+/fjcV5AxXOJvIpk2r/BI1WyQctD3BdC0tqLqeKV4Q2J+t9dDT/EAawGfTc
 K13yzw8id3pXC6GQTA9oicJOg8qUYWLMT+SbK/TYPdTKkr0iM4Bzq+Zqyz+wfJgJpvybIm5HWoC
 m252INx6cSK38/c8+fzciXQjirW+c5rSirI81+SKdlnVA/X/JIFeqW7GyP47WZt71RuXZHZYX7J
 zXC+5v4VCPi4W8TayW8ZGtWTs81M8VloDYPtKyGuAQGw8FzSuNSr5T7qR5SoauO7MZ9OxBdq/jm
 GEqIbl+h6YleGkoJSwA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220280
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026/09/03 01:50 PM, Kirill A. Korinsky wrote:
> OpenBSD writes zero to an edge triggered decrementer, then enters idle
> expecting its interrupt. QEMU defers the already due edge to a timer at
> the current virtual time, leaving the guest stalled.
> 
> Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
> ---
>  hw/ppc/ppc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index b123b4cc1c..d99e47d532 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -885,6 +885,7 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, int64_t now, uint64_t *nextp,
>       * an edge interrupt, so raise it here too.
>       */
>      if (((flags & PPC_DECR_UNDERFLOW_LEVEL) && signed_value < 0) ||
> +        ((flags & PPC_DECR_UNDERFLOW_TRIGGERED) && value == 0) ||

The fix is correct for mac99/G3/G4, but the guard flag is too broad and
introduces a regression on PPE42.

Commit 17dd1354c1d1 ("target/ppc: Decrementer fix BookE semantics") explicitly
removed the immediate raise on value==0 with the rationale: "BookE says a
decrementer interrupt should not be raised on a store of 0, only of a decrement
from 1."

The new clause:

    ((flags & PPC_DECR_UNDERFLOW_TRIGGERED) && value == 0)

also fires for PPE42, which goes through ppc_booke_timers_init() with
PPC_TIMER_PPE and gets PPC_DECR_UNDERFLOW_TRIGGERED set - introduced by commit
7197f6f7baf2 ("hw/ppc: Support for an IBM PPE42 CPU decrementer").  That commit
explicitly documents that PPE42 raises an interrupt when DEC[0] transitions from
0 to -1 (non-negative to negative) — not on a store of zero.  The new clause
contradicts this.

Note that __cpu_ppc_store_decr() is reached by BookE machines too — both on
direct guest writes to SPR_DECR and via the auto-reload path in booke_decr_cb()
(which calls cpu_ppc_store_decr(env, DECAR) when TCR_ARE is set; the existing
DECAR != 0 guard there already prevents a zero value from arriving via that
route).  So the safety of normal BookE targets (e500, sam460ex, bamboo, virtex)
is flag-based: they have PPC_DECR_ZERO_TRIGGERED set but not
PPC_DECR_UNDERFLOW_TRIGGERED, so neither the old clause nor the new one fires
for a guest write of zero.  That is the correct BookE behaviour per the
architecture.

PPC_DECR_ZERO_TRIGGERED already exists in ppc.h (defined as "Decr interrupt
triggered when the decrementer reaches zero") but is never checked in
__cpu_ppc_store_decr().  I think the minimal fix is to set it in
cpu_ppc_tb_init() for the non-64-bit path and guard the new clause on it:

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


All callers of cpu_ppc_tb_init() that use a 32-bit classic CPU (mac99 with 7400,
mac_oldworld/750, prep/604, pegasos/7457, amigaone/7457) take the else branch
and get PPC_DECR_ZERO_TRIGGERED.  64-bit Book3S machines (spapr, pnv, mac99 with
970fx) take the if branch and are unchanged.  PPE42 goes through
ppc_booke_timers_init() and never gets PPC_DECR_ZERO_TRIGGERED, so the new
clause does not fire for it.

This scopes the fix to the classic 32-bit edge-triggered path (mac99, pegasos,
prep, mac_oldworld, amigaone) and leaves PPE42 behaviour unchanged.  What do you
think?

Thanks,
Amit


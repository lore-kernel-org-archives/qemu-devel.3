Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E09D58D65
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 16:32:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFc0I-0003DJ-R3; Mon, 25 Nov 2024 11:32:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1tFc0H-0003CN-1c; Mon, 25 Nov 2024 11:32:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1tFc0F-0004X4-7g; Mon, 25 Nov 2024 11:32:00 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4APDlU9V012447;
 Mon, 25 Nov 2024 16:31:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=UC546h/lPFyVIukfOx1qRtW/NxbN25lrGPShRSQPwio=; b=FfhpIjAuk7f6
 8KLxb9YNVkpFv5uBCKyKjtCut/xpzk7OYlGfKZ1OT6cRZCVjiuDCe4ctZ8UWbSuz
 w35xCIdEAwd/5wLcqzdgzvmVuq9I6X63/w8WG2EuNloTVY6U7yoTvlumhF55APY5
 TLE/H0pmAWAzNbsREiKDgnjzCrFUETZhJ+7teMz3Cs9L71JFT43l8bCkKHiyJ9ii
 15pkXGxl+RowZHg6lDeWyYvCZEmYNuhB6omq89/tLRl43WlyN+EtSKr1hItDmC4o
 mWQIJjaZR4dbCC1uOGtniYKxaceOGNus6Rf+EXI43BWIdD4atqqtyK3CYDljA4xG
 Plm4ll3ckw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386n9f65-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Nov 2024 16:31:57 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4APGUM9D013143;
 Mon, 25 Nov 2024 16:31:56 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386n9f63-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Nov 2024 16:31:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AP60L40026326;
 Mon, 25 Nov 2024 16:31:55 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 433v30tnxj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Nov 2024 16:31:55 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4APGVsBq50331982
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Nov 2024 16:31:55 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E094258057;
 Mon, 25 Nov 2024 16:31:54 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A8EDF58066;
 Mon, 25 Nov 2024 16:31:54 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 25 Nov 2024 16:31:54 +0000 (GMT)
Message-ID: <d62ad308a4b243503dde319bbe35c7466522dccf.camel@linux.ibm.com>
Subject: Re: [PATCH 2/4] ppc/pnv: Fix direct controls quiesce
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Chalapathi V <chalapathi.v@linux.ibm.com>, Harsh
 Prateek Bora <harshpb@linux.ibm.com>
Date: Mon, 25 Nov 2024 10:31:54 -0600
In-Reply-To: <20241125132042.325734-3-npiggin@gmail.com>
References: <20241125132042.325734-1-npiggin@gmail.com>
 <20241125132042.325734-3-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8_8.2) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _QJGC31orimFnuKbJdZMnG_KKR3JGZKm
X-Proofpoint-ORIG-GUID: 4KxYKtBP1ie8WBlYD_E7VXSVtK-YEjAs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 mlxlogscore=763 suspectscore=0 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411250138
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.93, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

On Mon, 2024-11-25 at 23:20 +1000, Nicholas Piggin wrote:
> powernv CPUs have a set of control registers that can stop, start,
> and
> do other things to control a thread's execution.
> 
> Using this interface to stop a thread puts it into a particular state
> that can be queried, and is distinguishable from other things that
> might stop the CPU (e.g., going idle, or being debugged via gdb, or
> stopped by the monitor).
> 
> Add a new flag that can speficially distinguish this state where it
> is stopped with control registers. This solves some hangs when
> rebooting powernv machines when skiboot is modified to allow QEMU
> to use the CPU control facility (that uses controls to bring all
> secondaries to a known state).
> 
> Fixes: c8891955086 ("ppc/pnv: Implement POWER10 PC xscom registers
> for direct controls")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> 
> There might still be a bigger issue with how we handle CPU stop
> requests. Multiple different sources may want to stop a CPU, there
> may be situations where one of them resumes a CPU before all agree?
> A stop_request mask or refcount might be a nice way to consolidate
> all these.
> ---
>  target/ppc/cpu.h  | 1 +
>  hw/ppc/pnv_core.c | 9 +++++++--
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 945af07a64..0b4f1013b8 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1355,6 +1355,7 @@ struct CPUArchState {
>       * special way (such as routing some resume causes to 0x100,
> i.e. sreset).
>       */
>      bool resume_as_sreset;
> +    bool quiesced;
>  #endif
>  
>      /* These resources are used only in TCG */
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index a30693990b..cbfac49862 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -217,8 +217,8 @@ static uint64_t pnv_core_power10_xscom_read(void
> *opaque, hwaddr addr,
>      case PNV10_XSCOM_EC_CORE_RAS_STATUS:
>          for (i = 0; i < nr_threads; i++) {
>              PowerPCCPU *cpu = pc->threads[i];
> -            CPUState *cs = CPU(cpu);
> -            if (cs->stopped) {
> +            CPUPPCState *env = &cpu->env;
> +            if (env->quiesced) {
>                  val |= PPC_BIT(0 + 8 * i) | PPC_BIT(1 + 8 * i);
>              }
>          }
> @@ -244,20 +244,25 @@ static void pnv_core_power10_xscom_write(void
> *opaque, hwaddr addr,
>          for (i = 0; i < nr_threads; i++) {
>              PowerPCCPU *cpu = pc->threads[i];
>              CPUState *cs = CPU(cpu);
> +            CPUPPCState *env = &cpu->env;
>  
>              if (val & PPC_BIT(7 + 8 * i)) { /* stop */
>                  val &= ~PPC_BIT(7 + 8 * i);
>                  cpu_pause(cs);
> +                env->quiesced = true;
>              }
>              if (val & PPC_BIT(6 + 8 * i)) { /* start */
>                  val &= ~PPC_BIT(6 + 8 * i);
> +                env->quiesced = false;
>                  cpu_resume(cs);
>              }
>              if (val & PPC_BIT(4 + 8 * i)) { /* sreset */
>                  val &= ~PPC_BIT(4 + 8 * i);
> +                env->quiesced = false;
>                  pnv_cpu_do_nmi_resume(cs);
>              }
>              if (val & PPC_BIT(3 + 8 * i)) { /* clear maint */
> +                env->quiesced = false;
>                  /*
>                   * Hardware has very particular cases for where
> clear maint
>                   * must be used and where start must be used to
> resume a



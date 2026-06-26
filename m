Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A1A6CDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd11q-0000iK-RD; Fri, 26 Jun 2026 03:31:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1wd11m-0000i5-Gq; Fri, 26 Jun 2026 03:31:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1wd11k-0000Zx-U3; Fri, 26 Jun 2026 03:31:06 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65Q6mWnY2220327; Fri, 26 Jun 2026 07:31:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=M8FBMvROeq5VdqngjQwIN4UFIRAdyE
 6iIKCTa76UvbY=; b=SpiyqVk7sleCduej4IJt09qhzOgNQVXsW2CJSqqOrYDFRy
 s4sDXEUn2/b/fSEbxjLRXgnp5OYT2ioaJ5JIfsfYYafQhk0i9HLW6k4yR8KRvpIV
 mOO20jeB9Y1i8hINY3+GmY/zorpuACSQTZLEH4EulB5JkTWcSNTb1T7v2hOWu/nX
 Oa8QC2PMSd0df94hMM/6bcN48MOE7oUjsX/o2GGSs55IqgwOrymR2Qsimr4XBouu
 cKGin0NOwtCH0n6Hrs4kHGta/wrxlgTL7GHwOLO7tay1PKBuJJSdKyFX0CxwaLjZ
 cF+4p5ztjllv64LAG+6sAF0yPpG7hv33uxQfA1Zw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewg9j5rdr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jun 2026 07:31:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65Q7JerH005289;
 Fri, 26 Jun 2026 07:31:00 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56qt8dy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jun 2026 07:31:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65Q7Uvtq26804742
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Jun 2026 07:30:57 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 27C592004B;
 Fri, 26 Jun 2026 07:30:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 96FC220040;
 Fri, 26 Jun 2026 07:30:55 +0000 (GMT)
Received: from Gautams-MacBook-Pro.local (unknown [9.39.20.26])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 26 Jun 2026 07:30:55 +0000 (GMT)
Date: Fri, 26 Jun 2026 13:00:49 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Cc: npiggin@gmail.com, rathc@linux.ibm.com, milesg@linux.ibm.com,
 harshpb@linux.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] target/ppc: Expose the TB offset of the guest in QEMU
 monitor
Message-ID: <aj4qqeplExZaS4Ta@Gautams-MacBook-Pro.local>
References: <20260623052303.5274-1-gautam@linux.ibm.com>
 <87jyro14z5.fsf@vajain21.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jyro14z5.fsf@vajain21.in.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: u6LBaBEo3_n2B2vESSXuVifPX3y6hNYD
X-Proofpoint-GUID: tsZfwxpimIOduL8wQBryNUZuaw6_bVU6
X-Authority-Analysis: v=2.4 cv=Y4XIdBeN c=1 sm=1 tr=0 ts=6a3e2ab6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=pSTbB7s77_JVs2PdU3YA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDA1NiBTYWx0ZWRfX35/65/lHvBjR
 L/QfqnWr71yEYM8qruyATpvO9t+pzNzVQecpb7EROs8KpsR5jTplEwUff5oZw3mumQwmB4f5M/K
 XXCprG8iTG5vfcYonWMI/YNBLPnAyBSDy16xepANTE6opk23Udua5irwjL0fa2mTtolMgibno6H
 va9M+S019Rtoww6YvNUYSH+ZWz7GE7h4G1ppOtVu2gqB2TM1Kr3LJk/qd1fX9nPJ9LTGwbJmI6C
 gGQ+DIqOeV0IflWZl6dZhj+tLMz7kGFvqVFsUaPbxAePHitTeUaexzORA+79jFYol++5gD1azHb
 2jGTB4M48AT+lb2fx1EyDuqAFHyFb03VgwOVWFLZajaS8AsVc09Cz86KlSTlI/cz2QTW7+NhBjK
 3WAK2B2V6xWtUU2j4W9fjvL895HygZ2ZAbweUNO9HzwEGETR84hsO070d+Hw71k5D7+owpVVkcq
 XrYeQ5j8d1Wig5dqjFA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDA1NiBTYWx0ZWRfX+znqpcvrxBD4
 aoBf1Hojt038jCmqMSplo0JukAWDfS/7Da5qQLA3qQlVH0mLaJIG8+7IrpfMiS3kTXwVlC1N8B2
 7xvd4yzeL2X6GTsnjT+eZKWBdoxMQT4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260056
Received-SPF: pass client-ip=148.163.158.5; envelope-from=gautam@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On Wed, Jun 24, 2026 at 06:16:06PM +0530, Vaibhav Jain wrote:
> Hi Gautam,
> 
> Thanks for the patch. My review comments inline below:
> 
> Gautam Menghani <gautam@linux.ibm.com> writes:
> 
> > When debugging issues in KVM guests, it is sometimes helpful to have a
> > unified trace log of both guest and host to see where things are going
> > wrong. Expose the TB (timebase) offset through QEMU monitor to enable
> > capturing of unified log.
> >
> > The below steps can be then used to get a unified log:
> > 1. In host
> > trace-cmd record -e kvm_hv:kvm_guest_enter -e kvm_hv:kvm_guest_exit \
> >     -C ppc-tb -o trace_host.dat
> >
> > 2. In guest
> > trace-cmd record -e powerpc:hcall_entry -e powerpc:hcall_exit -C ppc-tb \
> >     --ts-offset <TB offset from QEMU monitor> -o trace_guest.dat
> >
> > 3. Transfer the guest logs to the host with scp/rsync
> >
> > 4. Unify the logs
> > trace-cmd report -i trace_host.dat -i trace_guest.dat > combined_log
> >
> > Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> > ---
> >  hw/ppc/ppc.c          | 5 +++++
> >  target/ppc/cpu.h      | 1 +
> >  target/ppc/cpu_init.c | 4 +++-
> >  3 files changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> > index a512d4fa64..1e8eb0ceef 100644
> > --- a/hw/ppc/ppc.c
> > +++ b/hw/ppc/ppc.c
> > @@ -515,6 +515,11 @@ uint64_t cpu_ppc_get_tb(ppc_tb_t *tb_env, uint64_t vmclk, int64_t tb_offset)
> >      return ns_to_tb(tb_env->tb_freq, vmclk) + tb_offset;
> >  }
> >  
> > +int64_t cpu_ppc_load_tb_offset(CPUPPCState *env)
> > +{
> > +    return llabs(*(&env->tb_env->tb_offset));
> Why are you doing both pointer ref and deref ?
> Also why llabs is needed for tb_offset. You are anyways returning signed
> value and printing signed value later in ppc_cpu_dump_state.

Since tb_offset is negative, I thought it would be better from user
perspective if the offset is a positive number. Copy pasting it in the
trace-cmd command would be easier. But on a second thought, I think we
can leave it as negative number since this is for debugging anyways,
I'll update the steps to reflect this.

> 
> I think you can just do
> 
> return env->tb_env->tb_offset;

Ack. Will change it in v2.

> 
> > +}
> > +
> >  uint64_t cpu_ppc_load_tbl (CPUPPCState *env)
> >  {
> >      ppc_tb_t *tb_env = env->tb_env;
> > diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> > index 057c54bbb8..cbd5964b1a 100644
> > --- a/target/ppc/cpu.h
> > +++ b/target/ppc/cpu.h
> > @@ -1693,6 +1693,7 @@ void cpu_ppc_store_hdecr(CPUPPCState *env, target_ulong value);
> >  void cpu_ppc_store_tbu40(CPUPPCState *env, uint64_t value);
> >  uint64_t cpu_ppc_load_purr(CPUPPCState *env);
> >  void cpu_ppc_store_purr(CPUPPCState *env, uint64_t value);
> > +int64_t cpu_ppc_load_tb_offset(CPUPPCState *env);
> >  #if !defined(CONFIG_USER_ONLY)
> >  target_ulong load_40x_pit(CPUPPCState *env);
> >  void store_40x_pit(CPUPPCState *env, target_ulong val);
> > diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> > index a02187ce5a..a77adc3e62 100644
> > --- a/target/ppc/cpu_init.c
> > +++ b/target/ppc/cpu_init.c
> > @@ -7620,8 +7620,10 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, int flags)
> >  #if !defined(CONFIG_USER_ONLY)
> >      if (env->tb_env) {
> >          qemu_fprintf(f, "TB %08" PRIu32 " %08" PRIu64
> > +                     " TB_OFFSET %016" PRId64
> Minor:
> There might be some userspace tooling depending on this dump
> format. Would prefer if you introduce the new field to the end of
> string.

Sure will do.

Thanks,
Gautam


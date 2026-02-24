Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 638CAF4BB8E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 21:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv0EC-0001Dm-E8; Tue, 24 Feb 2026 16:46:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1vv0E7-0001Cp-Os; Tue, 24 Feb 2026 16:45:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1vv0E3-0007Vq-De; Tue, 24 Feb 2026 16:45:54 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61OF4rL8733353; Tue, 24 Feb 2026 21:45:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=B7ooQBV1s5FpwK9r0zSAZM5fCCMKGJx/4aieekpReGI=; b=tNH0DDvuI6y3
 dj34dFX1UDgZP4OMlIPPEayvoUd4Xt+gPfSABn4zp6AUOH1qr+7JBcNkjw6rgfKJ
 6e/ADkN0mOxdRaJBpZDnqIyaf20G5zSCsmZgtsrsuFGzu/BEIwSjkBDKOnj0uTnX
 QswQExSL9hC6QUnhi1kgvr9Wm+vw/tQH4G3ptgl+2gmSnkVPqyrpBODjjnB9/vcM
 T44sYA06U4+GllQCPE6+M+3NrEJ4MZA5Mu5KNbjAYJOeJK70fWkXS3Fi9hgFIU1E
 3ZpsaMcSwRHJLFXvG2bDa35omlgSl6l4RkTsfRf+UybXpGgEoPEzYPmImZiWTWMR
 1pFLLxUsJw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf24gd8h9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Feb 2026 21:45:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61OKVW66013419;
 Tue, 24 Feb 2026 21:45:47 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfqdy2u1u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Feb 2026 21:45:47 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61OLjjmw30999276
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Feb 2026 21:45:45 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C694E5805D;
 Tue, 24 Feb 2026 21:45:45 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5D8B558043;
 Tue, 24 Feb 2026 21:45:45 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 24 Feb 2026 21:45:45 +0000 (GMT)
Message-ID: <68b51c772ce69080e289ad2045a199787193950f.camel@linux.ibm.com>
Subject: Re: [PATCH] target/ppc/translate: Fix TCG debug assert translating
 CLRBWIBC
From: Miles Glenn <milesg@linux.ibm.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-stable@nongnu.org, Nicholas Piggin
 <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>, Richard Henderson
 <richard.henderson@linaro.org>, Harsh Prateek Bora <harshpb@linux.ibm.com>
Date: Tue, 24 Feb 2026 15:45:45 -0600
In-Reply-To: <CAFEAcA9B6-egOf9MuYqimWNSjkUEVGSOm8NCM4ObOLsnjRmBfw@mail.gmail.com>
References: <20260212150753.1749448-1-peter.maydell@linaro.org>
 <CAFEAcA9B6-egOf9MuYqimWNSjkUEVGSOm8NCM4ObOLsnjRmBfw@mail.gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TNRIilla c=1 sm=1 tr=0 ts=699e1c0c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=KKAkSRfTAAAA:8
 a=69wJf7TsAAAA:8 a=ss9Do0Uowje5AuL3rVEA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: neMo-k0iGGAixwhA0vCQokic37R1ROUe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDE4OSBTYWx0ZWRfX+K/8rctrvitM
 uMAS2ldRtvNj3yceHG8ECIBEI+qcnw3PO+jwsr8RsKnXZmRmp5Egu7RaShYDWiedlh3Ueo75PD6
 Pg3hMb1IgpUA8/tMsDHWgwmt854SH1HQ8jpPht8wL3aZ8z4bQildzPKv85nINS0+dP6/m0sJUNC
 tiIc94WzAuOL1PztZOQZK3ilgHTmIFJGBTgIewcqk4vdGMX88f8aGW1hVov/xHvgC/aZLd24XRO
 fRXSlHz8nAml7Q5C7o0WhEKQVcCgJqKqYWTQG+EUIXhzv2okg/EiFfndkLaYq7+ew0KLniLzy+O
 QT4XCzJf5CcC/FeY22fhCW8Un98UBf0qoL0YKYZys2X1elUSh9sDwVt2i5lPP35e+oe0r/AStY1
 4+IuhnwOvjL3S19vrdPWXUCEC6F3ShAoyWYhXZ2hpvRi5YxXDkLsFJsarCW49+R/gi/m/fwEf0m
 QKve+Gsj8KHBGvrlZvA==
X-Proofpoint-ORIG-GUID: 6t4fQjc7vV9pPQ3K0v6hKLNFPyqkQbc2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602240189
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

+Harsh

Harsh, would you be the right person to do the pull on this PPC TCG
fix?  If so, maybe we should go ahead and make it official in the
MAINTAINERS file?

Thanks,

Glenn

On Tue, 2026-02-24 at 11:28 +0000, Peter Maydell wrote:
> Thanks for the code review -- is anybody going to take this via a
> PPC pull request? If not, I can take it via target-arm.next as a
> one-off -- let me know if you'd prefer that.
> 
> thanks
> -- PMM
> 
> On Thu, 12 Feb 2026 at 15:07, Peter Maydell <peter.maydell@linaro.org> wrote:
> > The test case in the ppe42 functional test triggers a TCG debug
> > assertion, which causes the test to fail in an --enable-debug
> > build or when the sanitizers are enabled:
> > 
> > #6  0x00007ffff4a3b517 in __assert_fail
> >     (assertion=0x5555562e7589 "!temp_readonly(ots)", file=0x5555562e5b23 "../../tcg/tcg.c", line=4928, function=0x5555562e8900 <__PRETTY_FUNCTION__.23> "tcg_reg_alloc_mov") at ./assert/assert.c:105
> > #7  0x0000555555cc2189 in tcg_reg_alloc_mov (s=0x7fff60000b70, op=0x7fff600126f8) at ../../tcg/tcg.c:4928
> > #8  0x0000555555cc74e0 in tcg_gen_code (s=0x7fff60000b70, tb=0x7fffa802f540, pc_start=4294446080) at ../../tcg/tcg.c:6667
> > #9  0x0000555555d02abe in setjmp_gen_code
> >     (env=0x555556cbe610, tb=0x7fffa802f540, pc=4294446080, host_pc=0x7fffeea00c00, max_insns=0x7fffee9f9d74, ti=0x7fffee9f9d90)
> >     at ../../accel/tcg/translate-all.c:257
> > #10 0x0000555555d02d75 in tb_gen_code (cpu=0x555556cba590, s=...) at ../../accel/tcg/translate-all.c:325
> > #11 0x0000555555cf5922 in cpu_exec_loop (cpu=0x555556cba590, sc=0x7fffee9f9ee0) at ../../accel/tcg/cpu-exec.c:970
> > #12 0x0000555555cf5aae in cpu_exec_setjmp (cpu=0x555556cba590, sc=0x7fffee9f9ee0) at ../../accel/tcg/cpu-exec.c:1016
> > #13 0x0000555555cf5b4b in cpu_exec (cpu=0x555556cba590) at ../../accel/tcg/cpu-exec.c:1042
> > #14 0x0000555555d1e7ab in tcg_cpu_exec (cpu=0x555556cba590) at ../../accel/tcg/tcg-accel-ops.c:82
> > #15 0x0000555555d1ff97 in rr_cpu_thread_fn (arg=0x555556cba590) at ../../accel/tcg/tcg-accel-ops-rr.c:285
> > #16 0x00005555561586c9 in qemu_thread_start (args=0x555556ee3c90) at ../../util/qemu-thread-posix.c:393
> > #17 0x00007ffff4a9caa4 in start_thread (arg=<optimized out>) at ./nptl/pthread_create.c:447
> > #18 0x00007ffff4b29c6c in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:78
> > 
> > This can be reproduced "by hand":
> > 
> >  ./build/clang/qemu-system-ppc -display none -vga none \
> >     -machine ppe42_machine -serial stdio \
> >     -device loader,file=$HOME/.cache/qemu/download/03c1ac0fb7f6c025102a02776a93b35101dae7c14b75e4eab36a337e39042ea8 \
> >     -device loader,addr=0xfff80040,cpu-num=0
> > 
> > (assuming you have the image file from the functional test
> > in your local cache).
> > 
> > This happens for this input:
> > 
> > IN:
> > 0xfff80c00:  07436004  .byte    0x07, 0x43, 0x60, 0x04
> > 
> > which generates (among other things):
> > 
> >  not_i32 $0x80000,$0x80000
> > 
> > which the TCG optimization pass turns into:
> > 
> >  mov_i32 $0x80000,$0xfff7ffff             dead: 1  pref=0xffff
> > 
> > and where we then assert because we tried to write to a constant.
> > 
> > This happens for the CLRBWIBC instruction which ends up in
> > do_mask_branch() with rb_is_gpr false and invert true.  In this case
> > we will generate code that sets mask to a tcg_constant_tl() but then
> > uses it as the LHS in tcg_gen_not_tl().
> > 
> > Fix the assertion by doing the invert in the translate time C code
> > for the "mask is constant" case.
> > 
> > Cc: qemu-stable@nongnu.org
> > Fixes: f7ec91c23906 ("target/ppc: Add IBM PPE42 special instructions")
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  target/ppc/translate/ppe-impl.c.inc | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> > 
> > diff --git a/target/ppc/translate/ppe-impl.c.inc b/target/ppc/translate/ppe-impl.c.inc
> > index 0a0590344e..1c27facb89 100644
> > --- a/target/ppc/translate/ppe-impl.c.inc
> > +++ b/target/ppc/translate/ppe-impl.c.inc
> > @@ -424,11 +424,15 @@ static bool do_mask_branch(DisasContext *ctx, arg_FCB * a, bool invert,
> >          shift = tcg_temp_new();
> >          tcg_gen_andi_tl(shift, cpu_gpr[a->rb], 0x1f);
> >          tcg_gen_shr_tl(mask, tcg_constant_tl(0x80000000), shift);
> > +        if (invert) {
> > +            tcg_gen_not_tl(mask, mask);
> > +        }
> >      } else {
> > -        mask = tcg_constant_tl(PPC_BIT32(a->rb));
> > -    }
> > -    if (invert) {
> > -        tcg_gen_not_tl(mask, mask);
> > +        target_ulong mask_const = PPC_BIT32(a->rb);
> > +        if (invert) {
> > +            mask_const = ~mask_const;
> > +        }
> > +        mask = tcg_constant_tl(mask_const);
> >      }
> > 
> >      /* apply mask to ra */
> > --
> > 2.43.0
> > 



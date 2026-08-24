Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7915FC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 14:27:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyVdL-0001zl-6B; Mon, 24 Aug 2026 10:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wyVdI-0001zE-AA; Mon, 24 Aug 2026 10:26:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wyVdF-0001NL-MV; Mon, 24 Aug 2026 10:26:40 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OD1Wom1957962; Mon, 24 Aug 2026 14:26:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=jNzacyJGIgMvdlqT6nQfV06SLMS7Ljnd+6sD18Dvsf0=; b=V75aeO9zfhXW
 jJFU7nRR21h+AQqL7lnzUu8DfDWd+n1KXFZZkQ4w2GQBePVpBLGiLG94XftHnvhm
 qdV5nqwH0OR6JKGrb0FujMvMxqDrGDXrvkgDtcGyh1H/8TCFWcjCIO8e4CU9cbU3
 K6ycP9jblNvQuV0fZUCetwFzh5xIt+kCq9Y2Lk/k7LChKm08mjIutWgcoMMpbo66
 JumECtyeO1XyOpY+eDLxu5/P1xYRBrwU9jS9it7qjyil9NjqT8cEaX9bI2r7bf+o
 htytnOKpmPlv+DfZjtrJTWmPgY0wEfjYe+5vQoG4eIo4sBe/DpuEBR6RqF8GP2pI
 0V3MJGCD3g==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4hx5p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 14:26:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OEQJxt030489;
 Mon, 24 Aug 2026 14:26:32 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkgxdqm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 14:26:32 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67OEQVWB1704626
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 14:26:31 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2C61958052;
 Mon, 24 Aug 2026 14:26:31 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C8A758056;
 Mon, 24 Aug 2026 14:26:30 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Aug 2026 14:26:30 +0000 (GMT)
Message-ID: <17cce9b41277a6ecb92934c5dc52c6c89f1dc10b.camel@linux.ibm.com>
Subject: Re: [PATCH 04/29] target/ppc: Move vector merge instructions to
 decodetree
From: Miles Glenn <milesg@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, harshpb@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, sv@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com
Date: Mon, 24 Aug 2026 09:26:30 -0500
In-Reply-To: <5a9d61b9fe34019ee35106ba9f3b32cf417a11f5.camel@linux.ibm.com>
References: <20260820140114.327023-1-rathc@linux.ibm.com>
 <20260820140114.327023-5-rathc@linux.ibm.com>
 <5a9d61b9fe34019ee35106ba9f3b32cf417a11f5.camel@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 2UCY74KmDzSSBKpl0ctJ037nkoSEqcgy
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDExOCBTYWx0ZWRfX+RoizSV0ZA0X
 HMfhW1ZE8VhxGM/hN4QPOWSalpeKlGY+XhCAMY/0qunwYpkdvpx1EI2uTQOVNSLGN48PqF9KXNu
 fXX7XOoxRyku5zv8EgE1KEYYLpxheVA=
X-Proofpoint-GUID: ZHW9QF_EZiKWUUlr3NIVyRWi72KPZXI6
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8c549a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=qwwfrqhgP3C5eMb1UQwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDExOCBTYWx0ZWRfX1vEmqw7vWJOv
 G3frEi6jO1YrVNgWiBrafgaOivySu4RTEbUXR9Joy/yyV2UOP6uI2e2u14Pj0w+ujHEWp1uS9Ro
 7yjdqumXDC88Gspk4xDqDJrrBSeT72eGxGVa3thcPPJ4xyUzkl5vZaskA/JowqJnTrDp8ClMd2H
 VkCU9JapCOSn7xsPshlG3/SBc5820BfUeJZcT9Xk6O8drfvjGpsOtZnXXCVoNMoDwVAr6BC8scy
 aJVaLdtVmYbtZyJ+qIbbf/V9kgLZCUrSYEbbZLk7kfObLWFu+n5HzwLtKe5AhxV/4CC5lTQ3PRJ
 lDFUZbrmzR8whnDHisPuGAMn55k5EYvBuHldAR//tMZtFpx3YmcoZ0Rl82lkoUmkjLR8qu/dc4u
 e3v196BtXboVHptJimO/qcfQIQdSGyxv8a5ovmwSoPyyUz3tNrUoqWKtABQRK5+jLri0SR5pVlx
 1LkpkP48blgsjrh8C0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240118
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

On Mon, 2026-08-24 at 09:20 -0500, Miles Glenn wrote:
> On Thu, 2026-08-20 at 19:30 +0530, Chinmay Rath wrote:
> > From: Aboorva Devarajan <aboorvad@linux.ibm.com>
> > 
> 
> Was the 'From' tag above added by mistake?
> 
> -Glenn
> 
> 

Nevermind.  I wasn't aware of this practice, but I looked it up and see
that it is normal.

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

Thanks,

Glenn

> > Move below instructions to decodetree specification:
> > 
> >         vmrg{hb, hh, hw, lb, lh, lw}           : VX-form
> > 
> > The individual gen_vmrg* functions generated by GEN_VXFORM are
> > replaced by a shared do_vmrg() helper dispatching to the existing
> > gen_helper_VMRG* TCG helpers via the TRANS_FLAGS() macro, which
> > also handles the ALTIVEC facility check.
> > 
> > The changes were verified by validating that the tcg ops generated by
> > those instructions remain the same, which were captured with the '-d
> > in_asm,op' flag.
> > 
> > Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> > Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
> > Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> > ---
> >  target/ppc/helper.h                 | 12 ++++++------
> >  target/ppc/insn32.decode            |  9 +++++++++
> >  target/ppc/int_helper.c             | 12 ++++++------
> >  target/ppc/translate/vmx-impl.c.inc | 25 +++++++++++++++++++------
> >  target/ppc/translate/vmx-ops.c.inc  |  6 ------
> >  5 files changed, 40 insertions(+), 24 deletions(-)
> > 
> > diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> > index 46ad78d1d4..6db917935c 100644
> > --- a/target/ppc/helper.h
> > +++ b/target/ppc/helper.h
> > @@ -173,12 +173,12 @@ DEF_HELPER_4(vcmpeqfp_dot, void, env, avr, avr, avr)
> >  DEF_HELPER_4(vcmpgefp_dot, void, env, avr, avr, avr)
> >  DEF_HELPER_4(vcmpgtfp_dot, void, env, avr, avr, avr)
> >  DEF_HELPER_4(vcmpbfp_dot, void, env, avr, avr, avr)
> > -DEF_HELPER_FLAGS_3(vmrglb, TCG_CALL_NO_RWG, void, avr, avr, avr)
> > -DEF_HELPER_FLAGS_3(vmrglh, TCG_CALL_NO_RWG, void, avr, avr, avr)
> > -DEF_HELPER_FLAGS_3(vmrglw, TCG_CALL_NO_RWG, void, avr, avr, avr)
> > -DEF_HELPER_FLAGS_3(vmrghb, TCG_CALL_NO_RWG, void, avr, avr, avr)
> > -DEF_HELPER_FLAGS_3(vmrghh, TCG_CALL_NO_RWG, void, avr, avr, avr)
> > -DEF_HELPER_FLAGS_3(vmrghw, TCG_CALL_NO_RWG, void, avr, avr, avr)
> > +DEF_HELPER_FLAGS_3(VMRGLB, TCG_CALL_NO_RWG, void, avr, avr, avr)
> > +DEF_HELPER_FLAGS_3(VMRGLH, TCG_CALL_NO_RWG, void, avr, avr, avr)
> > +DEF_HELPER_FLAGS_3(VMRGLW, TCG_CALL_NO_RWG, void, avr, avr, avr)
> > +DEF_HELPER_FLAGS_3(VMRGHB, TCG_CALL_NO_RWG, void, avr, avr, avr)
> > +DEF_HELPER_FLAGS_3(VMRGHH, TCG_CALL_NO_RWG, void, avr, avr, avr)
> > +DEF_HELPER_FLAGS_3(VMRGHW, TCG_CALL_NO_RWG, void, avr, avr, avr)
> >  DEF_HELPER_FLAGS_3(VMULESB, TCG_CALL_NO_RWG, void, avr, avr, avr)
> >  DEF_HELPER_FLAGS_3(VMULESH, TCG_CALL_NO_RWG, void, avr, avr, avr)
> >  DEF_HELPER_FLAGS_3(VMULESW, TCG_CALL_NO_RWG, void, avr, avr, avr)
> > diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
> > index 6b1cf9a0a9..8aca8a00c0 100644
> > --- a/target/ppc/insn32.decode
> > +++ b/target/ppc/insn32.decode
> > @@ -795,6 +795,15 @@ VNOR            000100 ..... ..... ..... 10100000100    @VX
> >  VXOR            000100 ..... ..... ..... 10011000100    @VX
> >  VEQV            000100 ..... ..... ..... 11010000100    @VX
> >  
> > +## Vector Merge Instructions
> > +
> > +VMRGHB          000100 ..... ..... ..... 00000001100    @VX
> > +VMRGHH          000100 ..... ..... ..... 00001001100    @VX
> > +VMRGHW          000100 ..... ..... ..... 00010001100    @VX
> > +VMRGLB          000100 ..... ..... ..... 00100001100    @VX
> > +VMRGLH          000100 ..... ..... ..... 00101001100    @VX
> > +VMRGLW          000100 ..... ..... ..... 00110001100    @VX
> > +
> >  ## Vector Integer Average Instructions
> >  
> >  VAVGSB          000100 ..... ..... ..... 10100000010    @VX
> > diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
> > index ef4b2e75d6..a3adf746bd 100644
> > --- a/target/ppc/int_helper.c
> > +++ b/target/ppc/int_helper.c
> > @@ -950,7 +950,7 @@ void helper_VMLADDUHM(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c,
> >  }
> >  
> >  #define VMRG_DO(name, element, access, ofs)                                  \
> > -    void helper_v##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)            \
> > +    void helper_V##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)            \
> >      {                                                                        \
> >          ppc_avr_t result;                                                    \
> >          int i, half = ARRAY_SIZE(r->element) / 2;                            \
> > @@ -963,11 +963,11 @@ void helper_VMLADDUHM(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c,
> >      }
> >  
> >  #define VMRG(suffix, element, access)          \
> > -    VMRG_DO(mrgl##suffix, element, access, half)   \
> > -    VMRG_DO(mrgh##suffix, element, access, 0)
> > -VMRG(b, u8, VsrB)
> > -VMRG(h, u16, VsrH)
> > -VMRG(w, u32, VsrW)
> > +    VMRG_DO(MRGL##suffix, element, access, half)   \
> > +    VMRG_DO(MRGH##suffix, element, access, 0)
> > +VMRG(B, u8, VsrB)
> > +VMRG(H, u16, VsrH)
> > +VMRG(W, u32, VsrW)
> >  #undef VMRG_DO
> >  #undef VMRG
> >  
> > diff --git a/target/ppc/translate/vmx-impl.c.inc b/target/ppc/translate/vmx-impl.c.inc
> > index 92d6e8c603..00b359f031 100644
> > --- a/target/ppc/translate/vmx-impl.c.inc
> > +++ b/target/ppc/translate/vmx-impl.c.inc
> > @@ -350,12 +350,25 @@ GEN_VXFORM_V(vsububm, MO_8, tcg_gen_gvec_sub, 0, 16);
> >  GEN_VXFORM_V(vsubuhm, MO_16, tcg_gen_gvec_sub, 0, 17);
> >  GEN_VXFORM_V(vsubuwm, MO_32, tcg_gen_gvec_sub, 0, 18);
> >  GEN_VXFORM_V(vsubudm, MO_64, tcg_gen_gvec_sub, 0, 19);
> > -GEN_VXFORM(vmrghb, 6, 0);
> > -GEN_VXFORM(vmrghh, 6, 1);
> > -GEN_VXFORM(vmrghw, 6, 2);
> > -GEN_VXFORM(vmrglb, 6, 4);
> > -GEN_VXFORM(vmrglh, 6, 5);
> > -GEN_VXFORM(vmrglw, 6, 6);
> > +
> > +static bool do_vmrg(DisasContext *ctx, arg_VX *a,
> > +                    void (*helper)(TCGv_ptr, TCGv_ptr, TCGv_ptr))
> > +{
> > +    TCGv_ptr ra, rb, rd;
> > +    REQUIRE_VECTOR(ctx);
> > +    ra = gen_avr_ptr(a->vra);
> > +    rb = gen_avr_ptr(a->vrb);
> > +    rd = gen_avr_ptr(a->vrt);
> > +    helper(rd, ra, rb);
> > +    return true;
> > +}
> > +
> > +TRANS_FLAGS(ALTIVEC, VMRGHB, do_vmrg, gen_helper_VMRGHB);
> > +TRANS_FLAGS(ALTIVEC, VMRGHH, do_vmrg, gen_helper_VMRGHH);
> > +TRANS_FLAGS(ALTIVEC, VMRGHW, do_vmrg, gen_helper_VMRGHW);
> > +TRANS_FLAGS(ALTIVEC, VMRGLB, do_vmrg, gen_helper_VMRGLB);
> > +TRANS_FLAGS(ALTIVEC, VMRGLH, do_vmrg, gen_helper_VMRGLH);
> > +TRANS_FLAGS(ALTIVEC, VMRGLW, do_vmrg, gen_helper_VMRGLW);
> >  
> >  static void trans_vmrgew(DisasContext *ctx)
> >  {
> > diff --git a/target/ppc/translate/vmx-ops.c.inc b/target/ppc/translate/vmx-ops.c.inc
> > index e28958a126..b8f77d3d2c 100644
> > --- a/target/ppc/translate/vmx-ops.c.inc
> > +++ b/target/ppc/translate/vmx-ops.c.inc
> > @@ -33,12 +33,6 @@ GEN_VXFORM_DUAL(vsubuhm, bcdsub, 0, 17, PPC_ALTIVEC, PPC_NONE),
> >  GEN_VXFORM_DUAL(vsubuwm, bcdus, 0, 18, PPC_ALTIVEC, PPC2_ISA300),
> >  GEN_VXFORM_DUAL(vsubudm, bcds, 0, 19, PPC2_ALTIVEC_207, PPC2_ISA300),
> >  GEN_VXFORM_300(bcds, 0, 27),
> > -GEN_VXFORM(vmrghb, 6, 0),
> > -GEN_VXFORM(vmrghh, 6, 1),
> > -GEN_VXFORM(vmrghw, 6, 2),
> > -GEN_VXFORM(vmrglb, 6, 4),
> > -GEN_VXFORM(vmrglh, 6, 5),
> > -GEN_VXFORM(vmrglw, 6, 6),
> >  GEN_VXFORM_300(vextublx, 6, 24),
> >  GEN_VXFORM_300(vextuhlx, 6, 25),
> >  GEN_VXFORM_DUAL(vmrgow, vextuwlx, 6, 26, PPC_NONE, PPC2_ALTIVEC_207),



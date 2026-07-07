Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9057C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 04:47:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgxiC-0002a1-UK; Tue, 07 Jul 2026 00:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikhilks@linux.ibm.com>)
 id 1wgxi0-0002Za-7t; Tue, 07 Jul 2026 00:47:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikhilks@linux.ibm.com>)
 id 1wgxhy-0004d5-6P; Tue, 07 Jul 2026 00:47:00 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6674IQ7Q1651438; Tue, 7 Jul 2026 04:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=laugY/
 vRzxko+XkMid37upwnAeU9sR6UxgifKd6cY9M=; b=J0BXj4izYtiYhy+6JCIuwL
 0cMfpJeIIIMBPFTqY/yluBPYIm52KxokDhGEErlZ2Ukv/jdNhJ/NOat0I7u5fEQY
 Ko459vBVZIvVb4wNwLmtV7j7BhqjCgQZgH+PgXzfkf6XMJPEFpv17/ITdVxvT2sc
 w5SSbhy8iW0Ewkeaq0PSPpERLhUe8en1qlTkXEzFmsCrTpC/5bVPFM/UVjlmiAF6
 0h09H9ONWT/4pVYz1VGwYJVmQt/idR27IaaeGpoYArM1EeWVzMCUd3LaGj26DYBM
 pj3Or7oxcFrEDDUAkOr8to773S5Fz/2s4ojcWflPwwiErkVB80IHtMavfcap1uEA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rkdnng2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 04:46:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6674Ykfm007585;
 Tue, 7 Jul 2026 04:46:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgq144x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 04:46:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6674knTo47710558
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jul 2026 04:46:49 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 74D3E20049;
 Tue,  7 Jul 2026 04:46:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 20E9D20040;
 Tue,  7 Jul 2026 04:46:41 +0000 (GMT)
Received: from [9.67.174.189] (unknown [9.67.174.189])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Jul 2026 04:46:40 +0000 (GMT)
Message-ID: <5989ac89-95dc-436d-addb-da85d05dc78e@linux.ibm.com>
Date: Tue, 7 Jul 2026 10:16:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 04/28] target/ppc: Move vector merge instructions to
 decodetree
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 richard.henderson@linaro.org, peter.maydell@linaro.org, stefanha@redhat.com
Cc: milesg@linux.ibm.com, vishalc@linux.ibm.com, tshah@linux.ibm.com,
 shivangu@linux.ibm.com, ojaswin@linux.ibm.com, aboorvad@linux.ibm.com,
 amachhiw@linux.ibm.com, sv@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com
References: <20260520160728.2283628-1-rathc@linux.ibm.com>
 <20260520160728.2283628-5-rathc@linux.ibm.com>
Content-Language: en-US
From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
In-Reply-To: <20260520160728.2283628-5-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a4c84be cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=ofI7FyNq1RD1R-BscFsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDAzNyBTYWx0ZWRfX2JTXjkJbDD1E
 AgOYfuZRGrqH85MeOxwGAFy/7wqKJqzsCUeuBsMSriVJmCi9PB3japFMChHNiVR90vHYwzsLdxi
 /Lc3HO+7wH8tnB2A9JZVp6fJyndqn+CO5kY/XgeNdySf6LfoTiPnLpxJj9rWPnFED1GMLOBartZ
 /V+jCcm3bWeISHZI6lomGJbe7+kBH8F1AhJkQoCJYq8ZEAp+OrIiWJbHHuZkZR8+g4yU8T6IiHM
 U+NDc0AIvHU7kuN2zNbEXG4eavNHR8CpNAMp4U5AjZO0F4SJkkI8hdD5DmBCEZC70IBNshtF77J
 hsrEB4gPBFCcBeySgz4VEsjTSHQNhSK4oqNxwgyJlX59ndQBLXcOgtK36L69B3SV9M3aKxOxYhZ
 s7D1aRwt5FcXvi44Hfs0D7YOM1nRtMkBMx+m7Nb5E0dmS9aC8rwYPUhiaCJoeZBCydN+4Tc/U25
 ZTLMeaLaviWcGFyJk3A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDAzNyBTYWx0ZWRfX3dJim4BWYRHi
 jXBr1RNimQ1I5KcavbqvCy8fEKqPzUrxsOXi6IuZ/IoOTtKMTe9xP/4bTTOV9i6GKFJx7PQVXxE
 HwJzQhYQfWMdBvFHJmJeqkQaAqIAFZk=
X-Proofpoint-GUID: c0vLbxVkBDLmIQLlBCmT-K-qvSMQXVI0
X-Proofpoint-ORIG-GUID: PqiqLZrO9UG5H7-NP5ohydJzsGSaiVsB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070037
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=nikhilks@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>

Thanks,
~ Nikhil

On 20/05/26 21:37, Chinmay Rath wrote:
> From: Aboorva Devarajan <aboorvad@linux.ibm.com>
>
> Move below instructions to decodetree specification:
>
>          vmrg{hb, hh, hw, lb, lh, lw}           : VX-form
>
> The individual gen_vmrg* functions generated by GEN_VXFORM are
> replaced by a shared do_vmrg() helper dispatching to the existing
> gen_helper_VMRG* TCG helpers via the TRANS_FLAGS() macro, which
> also handles the ALTIVEC facility check.
>
> The changes were verified by validating that the tcg ops generated by
> those instructions remain the same, which were captured with the '-d
> in_asm,op' flag.
>
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>   target/ppc/helper.h                 | 12 ++++++------
>   target/ppc/insn32.decode            |  9 +++++++++
>   target/ppc/int_helper.c             | 12 ++++++------
>   target/ppc/translate/vmx-impl.c.inc | 25 +++++++++++++++++++------
>   target/ppc/translate/vmx-ops.c.inc  |  6 ------
>   5 files changed, 40 insertions(+), 24 deletions(-)
>
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index 37803ebb17..d23260ddd0 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -174,12 +174,12 @@ DEF_HELPER_4(vcmpeqfp_dot, void, env, avr, avr, avr)
>   DEF_HELPER_4(vcmpgefp_dot, void, env, avr, avr, avr)
>   DEF_HELPER_4(vcmpgtfp_dot, void, env, avr, avr, avr)
>   DEF_HELPER_4(vcmpbfp_dot, void, env, avr, avr, avr)
> -DEF_HELPER_FLAGS_3(vmrglb, TCG_CALL_NO_RWG, void, avr, avr, avr)
> -DEF_HELPER_FLAGS_3(vmrglh, TCG_CALL_NO_RWG, void, avr, avr, avr)
> -DEF_HELPER_FLAGS_3(vmrglw, TCG_CALL_NO_RWG, void, avr, avr, avr)
> -DEF_HELPER_FLAGS_3(vmrghb, TCG_CALL_NO_RWG, void, avr, avr, avr)
> -DEF_HELPER_FLAGS_3(vmrghh, TCG_CALL_NO_RWG, void, avr, avr, avr)
> -DEF_HELPER_FLAGS_3(vmrghw, TCG_CALL_NO_RWG, void, avr, avr, avr)
> +DEF_HELPER_FLAGS_3(VMRGLB, TCG_CALL_NO_RWG, void, avr, avr, avr)
> +DEF_HELPER_FLAGS_3(VMRGLH, TCG_CALL_NO_RWG, void, avr, avr, avr)
> +DEF_HELPER_FLAGS_3(VMRGLW, TCG_CALL_NO_RWG, void, avr, avr, avr)
> +DEF_HELPER_FLAGS_3(VMRGHB, TCG_CALL_NO_RWG, void, avr, avr, avr)
> +DEF_HELPER_FLAGS_3(VMRGHH, TCG_CALL_NO_RWG, void, avr, avr, avr)
> +DEF_HELPER_FLAGS_3(VMRGHW, TCG_CALL_NO_RWG, void, avr, avr, avr)
>   DEF_HELPER_FLAGS_3(VMULESB, TCG_CALL_NO_RWG, void, avr, avr, avr)
>   DEF_HELPER_FLAGS_3(VMULESH, TCG_CALL_NO_RWG, void, avr, avr, avr)
>   DEF_HELPER_FLAGS_3(VMULESW, TCG_CALL_NO_RWG, void, avr, avr, avr)
> diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
> index 0fbabefba9..d9cc191de5 100644
> --- a/target/ppc/insn32.decode
> +++ b/target/ppc/insn32.decode
> @@ -795,6 +795,15 @@ VNOR            000100 ..... ..... ..... 10100000100    @VX
>   VXOR            000100 ..... ..... ..... 10011000100    @VX
>   VEQV            000100 ..... ..... ..... 11010000100    @VX
>   
> +## Vector Merge Instructions
> +
> +VMRGHB          000100 ..... ..... ..... 00000001100    @VX
> +VMRGHH          000100 ..... ..... ..... 00001001100    @VX
> +VMRGHW          000100 ..... ..... ..... 00010001100    @VX
> +VMRGLB          000100 ..... ..... ..... 00100001100    @VX
> +VMRGLH          000100 ..... ..... ..... 00101001100    @VX
> +VMRGLW          000100 ..... ..... ..... 00110001100    @VX
> +
>   ## Vector Integer Average Instructions
>   
>   VAVGSB          000100 ..... ..... ..... 10100000010    @VX
> diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
> index ef4b2e75d6..a3adf746bd 100644
> --- a/target/ppc/int_helper.c
> +++ b/target/ppc/int_helper.c
> @@ -950,7 +950,7 @@ void helper_VMLADDUHM(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c,
>   }
>   
>   #define VMRG_DO(name, element, access, ofs)                                  \
> -    void helper_v##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)            \
> +    void helper_V##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)            \
>       {                                                                        \
>           ppc_avr_t result;                                                    \
>           int i, half = ARRAY_SIZE(r->element) / 2;                            \
> @@ -963,11 +963,11 @@ void helper_VMLADDUHM(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c,
>       }
>   
>   #define VMRG(suffix, element, access)          \
> -    VMRG_DO(mrgl##suffix, element, access, half)   \
> -    VMRG_DO(mrgh##suffix, element, access, 0)
> -VMRG(b, u8, VsrB)
> -VMRG(h, u16, VsrH)
> -VMRG(w, u32, VsrW)
> +    VMRG_DO(MRGL##suffix, element, access, half)   \
> +    VMRG_DO(MRGH##suffix, element, access, 0)
> +VMRG(B, u8, VsrB)
> +VMRG(H, u16, VsrH)
> +VMRG(W, u32, VsrW)
>   #undef VMRG_DO
>   #undef VMRG
>   
> diff --git a/target/ppc/translate/vmx-impl.c.inc b/target/ppc/translate/vmx-impl.c.inc
> index 92d6e8c603..00b359f031 100644
> --- a/target/ppc/translate/vmx-impl.c.inc
> +++ b/target/ppc/translate/vmx-impl.c.inc
> @@ -350,12 +350,25 @@ GEN_VXFORM_V(vsububm, MO_8, tcg_gen_gvec_sub, 0, 16);
>   GEN_VXFORM_V(vsubuhm, MO_16, tcg_gen_gvec_sub, 0, 17);
>   GEN_VXFORM_V(vsubuwm, MO_32, tcg_gen_gvec_sub, 0, 18);
>   GEN_VXFORM_V(vsubudm, MO_64, tcg_gen_gvec_sub, 0, 19);
> -GEN_VXFORM(vmrghb, 6, 0);
> -GEN_VXFORM(vmrghh, 6, 1);
> -GEN_VXFORM(vmrghw, 6, 2);
> -GEN_VXFORM(vmrglb, 6, 4);
> -GEN_VXFORM(vmrglh, 6, 5);
> -GEN_VXFORM(vmrglw, 6, 6);
> +
> +static bool do_vmrg(DisasContext *ctx, arg_VX *a,
> +                    void (*helper)(TCGv_ptr, TCGv_ptr, TCGv_ptr))
> +{
> +    TCGv_ptr ra, rb, rd;
> +    REQUIRE_VECTOR(ctx);
> +    ra = gen_avr_ptr(a->vra);
> +    rb = gen_avr_ptr(a->vrb);
> +    rd = gen_avr_ptr(a->vrt);
> +    helper(rd, ra, rb);
> +    return true;
> +}
> +
> +TRANS_FLAGS(ALTIVEC, VMRGHB, do_vmrg, gen_helper_VMRGHB);
> +TRANS_FLAGS(ALTIVEC, VMRGHH, do_vmrg, gen_helper_VMRGHH);
> +TRANS_FLAGS(ALTIVEC, VMRGHW, do_vmrg, gen_helper_VMRGHW);
> +TRANS_FLAGS(ALTIVEC, VMRGLB, do_vmrg, gen_helper_VMRGLB);
> +TRANS_FLAGS(ALTIVEC, VMRGLH, do_vmrg, gen_helper_VMRGLH);
> +TRANS_FLAGS(ALTIVEC, VMRGLW, do_vmrg, gen_helper_VMRGLW);
>   
>   static void trans_vmrgew(DisasContext *ctx)
>   {
> diff --git a/target/ppc/translate/vmx-ops.c.inc b/target/ppc/translate/vmx-ops.c.inc
> index e28958a126..b8f77d3d2c 100644
> --- a/target/ppc/translate/vmx-ops.c.inc
> +++ b/target/ppc/translate/vmx-ops.c.inc
> @@ -33,12 +33,6 @@ GEN_VXFORM_DUAL(vsubuhm, bcdsub, 0, 17, PPC_ALTIVEC, PPC_NONE),
>   GEN_VXFORM_DUAL(vsubuwm, bcdus, 0, 18, PPC_ALTIVEC, PPC2_ISA300),
>   GEN_VXFORM_DUAL(vsubudm, bcds, 0, 19, PPC2_ALTIVEC_207, PPC2_ISA300),
>   GEN_VXFORM_300(bcds, 0, 27),
> -GEN_VXFORM(vmrghb, 6, 0),
> -GEN_VXFORM(vmrghh, 6, 1),
> -GEN_VXFORM(vmrghw, 6, 2),
> -GEN_VXFORM(vmrglb, 6, 4),
> -GEN_VXFORM(vmrglh, 6, 5),
> -GEN_VXFORM(vmrglw, 6, 6),
>   GEN_VXFORM_300(vextublx, 6, 24),
>   GEN_VXFORM_300(vextuhlx, 6, 25),
>   GEN_VXFORM_DUAL(vmrgow, vextuwlx, 6, 26, PPC_NONE, PPC2_ALTIVEC_207),


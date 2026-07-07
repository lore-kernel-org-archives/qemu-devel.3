Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 837AFC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 04:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgxj5-00032O-8o; Tue, 07 Jul 2026 00:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikhilks@linux.ibm.com>)
 id 1wgxj4-000326-1j; Tue, 07 Jul 2026 00:48:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikhilks@linux.ibm.com>)
 id 1wgxj1-0004uC-Eg; Tue, 07 Jul 2026 00:48:05 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6674IY7r2385827; Tue, 7 Jul 2026 04:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=4BQ63N
 60bXh7hR0jpwh1gXlagfgQz5+S6X2bHvSXgzI=; b=q4O++6bQpKuMTEh5BlWY6u
 ml5tCKP7ikgbqi8iL9fwUZPocI2zJ3JjZe5sBzHHAm2FH+s2tI33saO1kAeAfRL0
 HsP8TLYY7EEf/0R4wAayFsjsXT04pXq+xd5vlOl3k5sZd6rka4F0NR3yNTMiWL22
 O1eWLJ5IedTDQ4ocK0IBQVxJfZ2GlMFRYXXaazSXk0bvCTO96yyCDTH53xv4zf6R
 B+AwZ/et9J/OT/qDsU18o5FVxIpDrIkoZvlMX19Z8dNVfHwKvYyVlBxQvc7hiPOh
 1TvtU5PjpBBtcNUOqFxSXNvhHuITAifAbAaWlQCpDXjBFZyHJY/rwk9bsLhXJ22w
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp3n4we-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 04:47:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6674Yc2E006517;
 Tue, 7 Jul 2026 04:47:58 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqg0pc0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 04:47:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6674ltIs31392258
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jul 2026 04:47:55 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EBFAA20049;
 Tue,  7 Jul 2026 04:47:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A4BC20040;
 Tue,  7 Jul 2026 04:47:46 +0000 (GMT)
Received: from [9.67.174.189] (unknown [9.67.174.189])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Jul 2026 04:47:45 +0000 (GMT)
Message-ID: <b9a840f7-7c9b-46e8-8c7d-c1200c6a2dcd@linux.ibm.com>
Date: Tue, 7 Jul 2026 10:17:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 05/28] target/ppc: Move vector pack instructions to
 decodetree
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 richard.henderson@linaro.org, peter.maydell@linaro.org, stefanha@redhat.com
Cc: milesg@linux.ibm.com, vishalc@linux.ibm.com, tshah@linux.ibm.com,
 shivangu@linux.ibm.com, ojaswin@linux.ibm.com, aboorvad@linux.ibm.com,
 amachhiw@linux.ibm.com, sv@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com
References: <20260520160728.2283628-1-rathc@linux.ibm.com>
 <20260520160728.2283628-6-rathc@linux.ibm.com>
Content-Language: en-US
From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
In-Reply-To: <20260520160728.2283628-6-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4c8500 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=xtOYt3Np0Ld6yBaeOzAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA0MyBTYWx0ZWRfX511oEKtO5Q1v
 caIwOqTV05giM1n2mT1i/kokqTmj8gHo2qeSIifrnrlV8du9P6A/FCQuw8TBJvtl0/rpJwyP7mo
 NWpvejMG9s/cDyMjRC6PG1ph5qP1llU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA0MyBTYWx0ZWRfX4IYC8x5oa9bR
 QwfBAWur/zmr7vduccNywLD7A6pm5RFGn3VFLnjfc6HqlAyjqhrofqQw2indepONUwPUVFcgunL
 edvx7irPZF/kl9MM5PYK5s4QTQwczHhptqeHEARbqYQkkrdPL/QVnwkqFv/r3H2YdhfzhTIDTZR
 16RCsSSxTUhBT51X0GSZWsE2MFQZrjU9TI/urSBCOjxoX63PX8DuwJ68vof++j3nySRLbU7z4Wz
 x3JLAWhZhgi4VGignPgWqyKcSVfmRDFyJfcTsIb+P/1FKgTodPnDrmehf83lndjgf5Xz80/lXKM
 cklHxv0Ve3m5jFPrJOh6IEEF/sKO2yMra1cJzENi9kA1FNF4+XDckZgikC4XFX+ASipF6dLxHbc
 Ga9TTb+YYanRrR1LUpLy/FZgrpmHxZZ7/LbVqBywQycUfWe3vt77sP9LDvtgOPLM6seySn6mv2K
 C2gc5KDu4dH2ygAIJrw==
X-Proofpoint-ORIG-GUID: Xhcqx27raXaNzm-E6m8xoFbAEcptyElv
X-Proofpoint-GUID: LGzD3LLISJ2_yQu1Z2o1rYR-I0tTvQ3R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070043
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=nikhilks@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>

Thanks,
~ Nikhil

On 20/05/26 21:37, Chinmay Rath wrote:
> From: Aboorva Devarajan <aboorvad@linux.ibm.com>
>
> Move below instructions to decodetree specification:
>
>          vpkuhum, vpkuwum, vpkuhus, vpkuwus  : VX-form (PPC_ALTIVEC)
>          vpkshus, vpkswus, vpkshss, vpkswss  : VX-form (PPC_ALTIVEC)
>          vpkpx                                : VX-form (PPC_ALTIVEC)
>          vpkudum, vpkudus, vpksdus, vpksdss  : VX-form (PPC2_ALTIVEC_207)
>
> The legacy GEN_VXFORM_ENV/GEN_VXFORM macros that generated gen_vpk*()
> functions reading register fields from ctx->opcode are replaced by new
> do_vpk_env()/do_vpk() helpers in vmx-impl.c.inc that use the
> pre-extracted decodetree argument fields (a->vrt, a->vra, a->vrb)
> directly.  The existing gen_helper_vpk*() implementations in
> int_helper.c are reused without changes.
>
> The changes were verified by validating that the tcg ops generated by
> those instructions remain the same, which were captured with the '-d
> in_asm,op' option before and after the patch.
>
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>   target/ppc/helper.h                 | 26 +++++++--------
>   target/ppc/insn32.decode            | 16 +++++++++
>   target/ppc/int_helper.c             | 28 ++++++++--------
>   target/ppc/translate/vmx-impl.c.inc | 51 +++++++++++++++++++++--------
>   target/ppc/translate/vmx-ops.c.inc  | 13 --------
>   5 files changed, 81 insertions(+), 53 deletions(-)
>
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index d23260ddd0..33bb9c9443 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -250,19 +250,19 @@ DEF_HELPER_FLAGS_4(VMSUMUBM, TCG_CALL_NO_RWG, void, avr, avr, avr, avr)
>   DEF_HELPER_FLAGS_4(VMSUMMBM, TCG_CALL_NO_RWG, void, avr, avr, avr, avr)
>   DEF_HELPER_FLAGS_4(VPERM, TCG_CALL_NO_RWG, void, avr, avr, avr, avr)
>   DEF_HELPER_FLAGS_4(VPERMR, TCG_CALL_NO_RWG, void, avr, avr, avr, avr)
> -DEF_HELPER_4(vpkshss, void, env, avr, avr, avr)
> -DEF_HELPER_4(vpkshus, void, env, avr, avr, avr)
> -DEF_HELPER_4(vpkswss, void, env, avr, avr, avr)
> -DEF_HELPER_4(vpkswus, void, env, avr, avr, avr)
> -DEF_HELPER_4(vpksdss, void, env, avr, avr, avr)
> -DEF_HELPER_4(vpksdus, void, env, avr, avr, avr)
> -DEF_HELPER_4(vpkuhus, void, env, avr, avr, avr)
> -DEF_HELPER_4(vpkuwus, void, env, avr, avr, avr)
> -DEF_HELPER_4(vpkudus, void, env, avr, avr, avr)
> -DEF_HELPER_4(vpkuhum, void, env, avr, avr, avr)
> -DEF_HELPER_4(vpkuwum, void, env, avr, avr, avr)
> -DEF_HELPER_4(vpkudum, void, env, avr, avr, avr)
> -DEF_HELPER_FLAGS_3(vpkpx, TCG_CALL_NO_RWG, void, avr, avr, avr)
> +DEF_HELPER_4(VPKSHSS, void, env, avr, avr, avr)
> +DEF_HELPER_4(VPKSHUS, void, env, avr, avr, avr)
> +DEF_HELPER_4(VPKSWSS, void, env, avr, avr, avr)
> +DEF_HELPER_4(VPKSWUS, void, env, avr, avr, avr)
> +DEF_HELPER_4(VPKSDSS, void, env, avr, avr, avr)
> +DEF_HELPER_4(VPKSDUS, void, env, avr, avr, avr)
> +DEF_HELPER_4(VPKUHUS, void, env, avr, avr, avr)
> +DEF_HELPER_4(VPKUWUS, void, env, avr, avr, avr)
> +DEF_HELPER_4(VPKUDUS, void, env, avr, avr, avr)
> +DEF_HELPER_4(VPKUHUM, void, env, avr, avr, avr)
> +DEF_HELPER_4(VPKUWUM, void, env, avr, avr, avr)
> +DEF_HELPER_4(VPKUDUM, void, env, avr, avr, avr)
> +DEF_HELPER_FLAGS_3(VPKPX, TCG_CALL_NO_RWG, void, avr, avr, avr)
>   DEF_HELPER_5(VMHADDSHS, void, env, avr, avr, avr, avr)
>   DEF_HELPER_5(VMHRADDSHS, void, env, avr, avr, avr, avr)
>   DEF_HELPER_FLAGS_4(VMSUMUHM, TCG_CALL_NO_RWG, void, avr, avr, avr, avr)
> diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
> index d9cc191de5..8c8eca5e46 100644
> --- a/target/ppc/insn32.decode
> +++ b/target/ppc/insn32.decode
> @@ -1054,6 +1054,22 @@ VSTRIHR         000100 ..... 00011 ..... . 0000001101   @VX_tb_rc
>   VCLRLB          000100 ..... ..... ..... 00110001101    @VX
>   VCLRRB          000100 ..... ..... ..... 00111001101    @VX
>   
> +## Vector Pack Instructions
> +
> +VPKUHUM         000100 ..... ..... ..... 0000000111 0    @VX
> +VPKUWUM         000100 ..... ..... ..... 0000100111 0    @VX
> +VPKUDUM         000100 ..... ..... ..... 1000100111 0    @VX
> +VPKUHUS         000100 ..... ..... ..... 0001000111 0    @VX
> +VPKUWUS         000100 ..... ..... ..... 0001100111 0    @VX
> +VPKUDUS         000100 ..... ..... ..... 1001100111 0    @VX
> +VPKSHUS         000100 ..... ..... ..... 0010000111 0    @VX
> +VPKSWUS         000100 ..... ..... ..... 0010100111 0    @VX
> +VPKSDUS         000100 ..... ..... ..... 1010100111 0    @VX
> +VPKSHSS         000100 ..... ..... ..... 0011000111 0    @VX
> +VPKSWSS         000100 ..... ..... ..... 0011100111 0    @VX
> +VPKSDSS         000100 ..... ..... ..... 1011100111 0    @VX
> +VPKPX           000100 ..... ..... ..... 0110000111 0    @VX
> +
>   # VSX Load/Store Instructions
>   
>   LXSD            111001 ..... ..... .............. 10    @DS
> diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
> index a3adf746bd..dc55ccadf7 100644
> --- a/target/ppc/int_helper.c
> +++ b/target/ppc/int_helper.c
> @@ -1465,7 +1465,7 @@ void helper_VPMSUMD(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
>   #else
>   #define PKBIG 0
>   #endif
> -void helper_vpkpx(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
> +void helper_VPKPX(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
>   {
>       int i, j;
>       ppc_avr_t result;
> @@ -1488,7 +1488,7 @@ void helper_vpkpx(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
>   }
>   
>   #define VPK(suffix, from, to, cvt, dosat)                               \
> -    void helper_vpk##suffix(CPUPPCState *env, ppc_avr_t *r,             \
> +    void helper_VPK##suffix(CPUPPCState *env, ppc_avr_t *r,             \
>                               ppc_avr_t *a, ppc_avr_t *b)                 \
>       {                                                                   \
>           int i;                                                          \
> @@ -1507,18 +1507,18 @@ void helper_vpkpx(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
>           }                                                               \
>       }
>   #define I(x, y) (x)
> -VPK(shss, s16, s8, cvtshsb, 1)
> -VPK(shus, s16, u8, cvtshub, 1)
> -VPK(swss, s32, s16, cvtswsh, 1)
> -VPK(swus, s32, u16, cvtswuh, 1)
> -VPK(sdss, s64, s32, cvtsdsw, 1)
> -VPK(sdus, s64, u32, cvtsduw, 1)
> -VPK(uhus, u16, u8, cvtuhub, 1)
> -VPK(uwus, u32, u16, cvtuwuh, 1)
> -VPK(udus, u64, u32, cvtuduw, 1)
> -VPK(uhum, u16, u8, I, 0)
> -VPK(uwum, u32, u16, I, 0)
> -VPK(udum, u64, u32, I, 0)
> +VPK(SHSS, s16, s8, cvtshsb, 1)
> +VPK(SHUS, s16, u8, cvtshub, 1)
> +VPK(SWSS, s32, s16, cvtswsh, 1)
> +VPK(SWUS, s32, u16, cvtswuh, 1)
> +VPK(SDSS, s64, s32, cvtsdsw, 1)
> +VPK(SDUS, s64, u32, cvtsduw, 1)
> +VPK(UHUS, u16, u8, cvtuhub, 1)
> +VPK(UWUS, u32, u16, cvtuwuh, 1)
> +VPK(UDUS, u64, u32, cvtuduw, 1)
> +VPK(UHUM, u16, u8, I, 0)
> +VPK(UWUM, u32, u16, I, 0)
> +VPK(UDUM, u64, u32, I, 0)
>   #undef I
>   #undef VPK
>   #undef PKBIG
> diff --git a/target/ppc/translate/vmx-impl.c.inc b/target/ppc/translate/vmx-impl.c.inc
> index 00b359f031..65230f3461 100644
> --- a/target/ppc/translate/vmx-impl.c.inc
> +++ b/target/ppc/translate/vmx-impl.c.inc
> @@ -1070,19 +1070,44 @@ TRANS(VRLQMI, do_vector_rotl_quad, false, true)
>   
>   GEN_VXFORM_TRANS(vsl, 2, 7);
>   GEN_VXFORM_TRANS(vsr, 2, 11);
> -GEN_VXFORM_ENV(vpkuhum, 7, 0);
> -GEN_VXFORM_ENV(vpkuwum, 7, 1);
> -GEN_VXFORM_ENV(vpkudum, 7, 17);
> -GEN_VXFORM_ENV(vpkuhus, 7, 2);
> -GEN_VXFORM_ENV(vpkuwus, 7, 3);
> -GEN_VXFORM_ENV(vpkudus, 7, 19);
> -GEN_VXFORM_ENV(vpkshus, 7, 4);
> -GEN_VXFORM_ENV(vpkswus, 7, 5);
> -GEN_VXFORM_ENV(vpksdus, 7, 21);
> -GEN_VXFORM_ENV(vpkshss, 7, 6);
> -GEN_VXFORM_ENV(vpkswss, 7, 7);
> -GEN_VXFORM_ENV(vpksdss, 7, 23);
> -GEN_VXFORM(vpkpx, 7, 12);
> +static bool do_vpk_env(DisasContext *ctx, arg_VX *a,
> +                       void (*gen_helper)(TCGv_ptr, TCGv_ptr,
> +                                          TCGv_ptr, TCGv_ptr))
> +{
> +    TCGv_ptr ra, rb, rd;
> +    REQUIRE_VECTOR(ctx);
> +    ra = gen_avr_ptr(a->vra);
> +    rb = gen_avr_ptr(a->vrb);
> +    rd = gen_avr_ptr(a->vrt);
> +    gen_helper(tcg_env, rd, ra, rb);
> +    return true;
> +}
> +
> +static bool do_vpk(DisasContext *ctx, arg_VX *a,
> +                   void (*gen_helper)(TCGv_ptr, TCGv_ptr, TCGv_ptr))
> +{
> +    TCGv_ptr ra, rb, rd;
> +    REQUIRE_VECTOR(ctx);
> +    ra = gen_avr_ptr(a->vra);
> +    rb = gen_avr_ptr(a->vrb);
> +    rd = gen_avr_ptr(a->vrt);
> +    gen_helper(rd, ra, rb);
> +    return true;
> +}
> +
> +TRANS_FLAGS(ALTIVEC, VPKUHUM, do_vpk_env, gen_helper_VPKUHUM)
> +TRANS_FLAGS(ALTIVEC, VPKUWUM, do_vpk_env, gen_helper_VPKUWUM)
> +TRANS_FLAGS2(ALTIVEC_207, VPKUDUM, do_vpk_env, gen_helper_VPKUDUM)
> +TRANS_FLAGS(ALTIVEC, VPKUHUS, do_vpk_env, gen_helper_VPKUHUS)
> +TRANS_FLAGS(ALTIVEC, VPKUWUS, do_vpk_env, gen_helper_VPKUWUS)
> +TRANS_FLAGS2(ALTIVEC_207, VPKUDUS, do_vpk_env, gen_helper_VPKUDUS)
> +TRANS_FLAGS(ALTIVEC, VPKSHUS, do_vpk_env, gen_helper_VPKSHUS)
> +TRANS_FLAGS(ALTIVEC, VPKSWUS, do_vpk_env, gen_helper_VPKSWUS)
> +TRANS_FLAGS2(ALTIVEC_207, VPKSDUS, do_vpk_env, gen_helper_VPKSDUS)
> +TRANS_FLAGS(ALTIVEC, VPKSHSS, do_vpk_env, gen_helper_VPKSHSS)
> +TRANS_FLAGS(ALTIVEC, VPKSWSS, do_vpk_env, gen_helper_VPKSWSS)
> +TRANS_FLAGS2(ALTIVEC_207, VPKSDSS, do_vpk_env, gen_helper_VPKSDSS)
> +TRANS_FLAGS(ALTIVEC, VPKPX, do_vpk, gen_helper_VPKPX)
>   GEN_VXFORM_ENV(vsum4ubs, 4, 24);
>   GEN_VXFORM_ENV(vsum4sbs, 4, 28);
>   GEN_VXFORM_ENV(vsum4shs, 4, 25);
> diff --git a/target/ppc/translate/vmx-ops.c.inc b/target/ppc/translate/vmx-ops.c.inc
> index b8f77d3d2c..2820976c0f 100644
> --- a/target/ppc/translate/vmx-ops.c.inc
> +++ b/target/ppc/translate/vmx-ops.c.inc
> @@ -59,19 +59,6 @@ GEN_VXFORM_300(bcdtrunc, 0, 20),
>   GEN_VXFORM_300(bcdutrunc, 0, 21),
>   GEN_VXFORM(vsl, 2, 7),
>   GEN_VXFORM(vsr, 2, 11),
> -GEN_VXFORM(vpkuhum, 7, 0),
> -GEN_VXFORM(vpkuwum, 7, 1),
> -GEN_VXFORM_207(vpkudum, 7, 17),
> -GEN_VXFORM(vpkuhus, 7, 2),
> -GEN_VXFORM(vpkuwus, 7, 3),
> -GEN_VXFORM_207(vpkudus, 7, 19),
> -GEN_VXFORM(vpkshus, 7, 4),
> -GEN_VXFORM(vpkswus, 7, 5),
> -GEN_VXFORM_207(vpksdus, 7, 21),
> -GEN_VXFORM(vpkshss, 7, 6),
> -GEN_VXFORM(vpkswss, 7, 7),
> -GEN_VXFORM_207(vpksdss, 7, 23),
> -GEN_VXFORM(vpkpx, 7, 12),
>   GEN_VXFORM(vsum4ubs, 4, 24),
>   GEN_VXFORM(vsum4sbs, 4, 28),
>   GEN_VXFORM(vsum4shs, 4, 25),


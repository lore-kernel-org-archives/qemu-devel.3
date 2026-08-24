Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8575BC5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 14:47:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyVx9-0003Ow-58; Mon, 24 Aug 2026 10:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wyVx7-0003Nu-4o; Mon, 24 Aug 2026 10:47:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wyVx4-0000MX-PR; Mon, 24 Aug 2026 10:47:08 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OD1WU01935730; Mon, 24 Aug 2026 14:47:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=bDjMsUZpE8GrnUMxHs13mv0dzo7IYKkpya0RG2VU/bQ=; b=IgBFXbdKpIqE
 MLMq6wq6cIUz2t5k74xv18uq/dfyAzRMUcFY5+R9eLUYDri8Lhe0KlAX2ByrP1Q6
 xXW9fQTeLhNo+OywOD0us06UcBBaOEMQLgzSDK24cPQOCEC86tcS42s+x3eXuCAA
 nWek5YfyNQb7ewXTj88Q66sXWG8HJYqGlhWDE0/q/bj24ELc1K2prkVCKgetjrmG
 VI+CgP36Ks/SElZoFI5Rlf+nc8hkiptCXX7hVETH3TuKuyvoxJ2lAGa6Hilv/jCd
 id2ZQj48y3XGzvFt/iJJXSbUsWyA+q63nxZVWdSzJdCUbMTg/nI9FOJw0kxOCvJR
 p1SgsDTKkA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g7393t3gb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 14:47:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OEfL9O016711;
 Mon, 24 Aug 2026 14:47:02 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3jpm21-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 14:47:02 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67OEl0xe6620034
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 14:47:00 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7F7F95805A;
 Mon, 24 Aug 2026 14:47:00 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2D70A58054;
 Mon, 24 Aug 2026 14:46:59 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Aug 2026 14:46:59 +0000 (GMT)
Message-ID: <beb52495a541ff3c70da84d196ef4c17e1a81d8f.camel@linux.ibm.com>
Subject: Re: [PATCH 17/29] target/ppc: Move wait instruction to decodetree
From: Miles Glenn <milesg@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, harshpb@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, sv@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com
Date: Mon, 24 Aug 2026 09:46:58 -0500
In-Reply-To: <20260820140114.327023-18-rathc@linux.ibm.com>
References: <20260820140114.327023-1-rathc@linux.ibm.com>
 <20260820140114.327023-18-rathc@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Di9ClkfjGQunO-SsxeBFJDHuzVshphaG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfXzykuwyrCRnZs
 xqNCYm4rzWSq7x/bmoxtc7r6vcWKlVSyA+OOcflAB6riLn76xZbMjwANzLxSXgNwPnhQaIXToZr
 w1dUyRZ4sWV8zoGx5Y5W2wZy6leRWgma/5eMRwdyV1Cp9kLlpXXCPHdbFwx9vwDwhgSbKddQlT/
 WJGsSwOxNlPYGCwHxRVIWpn1M/vKmn5NpDMY9v3j4ivhi1IHDfuwynZ7pWaIksSV9SVNvmGs0h6
 Ys9DRDX8gt+kFZsNFAq//fEP4XrNBY2yUTWhFYqyOdd8ToyeFsXgudb0yBHbjcDeR4i2oDG/6n9
 YKXgQ/60DjEajFYzAz6ToNofrEU1MqV91D4vGyUL0bQ2A93BZuPwsHxHwEFiFE2T/O3262TZ0kV
 iOUwes3Vt3QA7vMR0t2CqaicWPUBHkqfc/UnAeddtCthrXUwmAMjT5ENsOV2xd0W/7Z/AH/DQDa
 LuEpPCXgNoDlE0zod1g==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a8c5968 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=cZRAMAzoDBRNjgz5moMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfXwF4k8Hxq6iSr
 JZRC4po7KpOjY9ZmXAPGP06U/wfgChat/ymusPSG2DwKKL5Hg4GJ95j2a6p9V8urnJpEtDs9PWN
 3Wa7rB2Gg3TrFZ1bAPHK9PQSLVyD5Mo=
X-Proofpoint-ORIG-GUID: XlVe_4a1dZcDA0DAILCO0kFE_HZX5pSH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240122
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

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

Thanks,

Glenn

On Thu, 2026-08-20 at 19:30 +0530, Chinmay Rath wrote:
> From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> 
> Implement wait instruction using decodetree with
> proper handling of WC and PL fields across different ISA
> versions. Since the opcode changed between ISA 2.x and 3.x
> we have defined 2 different decodetree instructions that
> are handled by the same helper.
> 
> The changes have been tested by comparing the tcg generated
> before and after the change for wait instruction. The test
> was repeated for 2 types of machines:
> 
> Power10 - which should use the newer wait implementation
> e500mc - which should use older PPC_WAIT implementation
> 
> Both generated the same tcg ops with and without the change.
> Further, with the changes we were able to boot into Fedora
> distro as well.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>  target/ppc/insn32.decode                     |  15 +++
>  target/ppc/translate.c                       |  91 -----------------
>  target/ppc/translate/storage-ctrl-impl.c.inc | 100 +++++++++++++++++++
>  3 files changed, 115 insertions(+), 91 deletions(-)
> 
> diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
> index 67fb181542..3b8387b60c 100644
> --- a/target/ppc/insn32.decode
> +++ b/target/ppc/insn32.decode
> @@ -1480,6 +1480,21 @@ ISYNC           010011 ----- ----- ----- 0010010110 -
>  @XL_bfa         ...... bf:3 .. bfa:3 .. ..... ..... ..... .
>  MCRF            010011 ... -- ... -- ----- 00000 00000 -       @XL_bfa
>  
> +# Wait Instructions
> +
> +# We can use the same X_wait argument set for both WAIT and older ISA2.x
> +# compliant WAIT_2_x. Depending on the version, we may or may not use the
> +# arguments. For more information, check do_wait() helper.
> +
> +&X_wait         wc pl
> +@X_wait         ...... ..- wc:2 --- pl:2 ----- .......... -  &X_wait
> +
> +# According to ISA v3.1, bit 6 and 7 are implementation dependent and "unless
> +# the intention is to use the implementation-dependent field, these bits must be
> +# coded zero". Hence, we code them to 0.
> +WAIT            011111 00-.. ---.. ----- 0000011110 -  @X_wait
> +WAIT_ISA_2_X    011111 ---.. ---.. ----- 0000111110 -  @X_wait
> +
>  # Branch History Rolling Buffer (BHRB) Instructions
>  
>  &XFX_bhrbe      rt bhrbe
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index f7c7f53d82..2d5157080c 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -2727,95 +2727,6 @@ static inline void gen_check_tlb_flush(DisasContext *ctx, bool global)
>  static inline void gen_check_tlb_flush(DisasContext *ctx, bool global) { }
>  #endif
>  
> -/* wait */
> -static void gen_wait(DisasContext *ctx)
> -{
> -    uint32_t wc;
> -
> -    if (ctx->insns_flags & PPC_WAIT) {
> -        /* v2.03-v2.07 define an older incompatible 'wait' encoding. */
> -
> -        if (ctx->insns_flags2 & PPC2_PM_ISA206) {
> -            /* v2.06 introduced the WC field. WC > 0 may be treated as no-op. */
> -            wc = WC(ctx->opcode);
> -        } else {
> -            wc = 0;
> -        }
> -
> -    } else if (ctx->insns_flags2 & PPC2_ISA300) {
> -        /* v3.0 defines a new 'wait' encoding. */
> -        wc = WC(ctx->opcode);
> -        if (ctx->insns_flags2 & PPC2_ISA310) {
> -            uint32_t pl = PL(ctx->opcode);
> -
> -            /* WC 1,2 may be treated as no-op. WC 3 is reserved. */
> -            if (wc == 3) {
> -                gen_invalid(ctx);
> -                return;
> -            }
> -
> -            /* PL 1-3 are reserved. If WC=2 then the insn is treated as noop. */
> -            if (pl > 0 && wc != 2) {
> -                gen_invalid(ctx);
> -                return;
> -            }
> -
> -        } else { /* ISA300 */
> -            /* WC 1-3 are reserved */
> -            if (wc > 0) {
> -                gen_invalid(ctx);
> -                return;
> -            }
> -        }
> -
> -    } else {
> -        warn_report("wait instruction decoded with wrong ISA flags.");
> -        gen_invalid(ctx);
> -        return;
> -    }
> -
> -    /*
> -     * wait without WC field or with WC=0 waits for an exception / interrupt
> -     * to occur.
> -     */
> -    if (wc == 0) {
> -        TCGv_i32 t0 = tcg_constant_i32(1);
> -        tcg_gen_st_i32(t0, tcg_env,
> -                       -offsetof(PowerPCCPU, env) + offsetof(CPUState, halted));
> -        /* Stop translation, as the CPU is supposed to sleep from now */
> -        gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
> -    }
> -
> -    /*
> -     * Other wait types must not just wait until an exception occurs because
> -     * ignoring their other wake-up conditions could cause a hang.
> -     *
> -     * For v2.06 and 2.07, wc=1,2,3 are architected but may be implemented as
> -     * no-ops.
> -     *
> -     * wc=1 and wc=3 explicitly allow the instruction to be treated as a no-op.
> -     *
> -     * wc=2 waits for an implementation-specific condition, such could be
> -     * always true, so it can be implemented as a no-op.
> -     *
> -     * For v3.1, wc=1,2 are architected but may be implemented as no-ops.
> -     *
> -     * wc=1 (waitrsv) waits for an exception or a reservation to be lost.
> -     * Reservation-loss may have implementation-specific conditions, so it
> -     * can be implemented as a no-op.
> -     *
> -     * wc=2 waits for an exception or an amount of time to pass. This
> -     * amount is implementation-specific so it can be implemented as a
> -     * no-op.
> -     *
> -     * ISA v3.1 allows for execution to resume "in the rare case of
> -     * an implementation-dependent event", so in any case software must
> -     * not depend on the architected resumption condition to become
> -     * true, so no-op implementations should be architecturally correct
> -     * (if suboptimal).
> -     */
> -}
> -
>  #if defined(TARGET_PPC64)
>  static void gen_doze(DisasContext *ctx)
>  {
> @@ -5197,8 +5108,6 @@ GEN_HANDLER(lswx, 0x1F, 0x15, 0x10, 0x00000001, PPC_STRING),
>  GEN_HANDLER(stswi, 0x1F, 0x15, 0x16, 0x00000001, PPC_STRING),
>  GEN_HANDLER(stswx, 0x1F, 0x15, 0x14, 0x00000001, PPC_STRING),
>  /* ISA v3.0 changed the extended opcode from 62 to 30 */
> -GEN_HANDLER(wait, 0x1F, 0x1E, 0x01, 0x039FF801, PPC_WAIT),
> -GEN_HANDLER_E(wait, 0x1F, 0x1E, 0x00, 0x039CF801, PPC_NONE, PPC2_ISA300),
>  GEN_HANDLER(rfi, 0x13, 0x12, 0x01, 0x03FF8001, PPC_FLOW),
>  #if defined(TARGET_PPC64)
>  GEN_HANDLER(rfid, 0x13, 0x12, 0x00, 0x03FF8001, PPC_64B),
> diff --git a/target/ppc/translate/storage-ctrl-impl.c.inc b/target/ppc/translate/storage-ctrl-impl.c.inc
> index 943229c438..21c7999d5d 100644
> --- a/target/ppc/translate/storage-ctrl-impl.c.inc
> +++ b/target/ppc/translate/storage-ctrl-impl.c.inc
> @@ -270,3 +270,103 @@ static bool do_tlbie(DisasContext *ctx, arg_X_tlbie *a, bool local)
>  
>  TRANS_FLAGS(MEM_TLBIE, TLBIE, do_tlbie, false)
>  TRANS_FLAGS(MEM_TLBIE, TLBIEL, do_tlbie, true)
> +
> +/*
> + * Decodetree populates a->wc and a->pl based on ISA v3.1, however they may
> + * or may not be used based on the ISA:
> + *   For ISA < 2.06 - both wc and pl are ignored
> + *   For ISA == 2.06, 2.07, 3.0 - wc is used and pl is ignored
> + *   For ISA 3.1 - both wc and pl are used
> + */
> +static bool do_wait(DisasContext *ctx, arg_X_wait *a)
> +{
> +    uint32_t wc;
> +
> +    if (ctx->insns_flags & PPC_WAIT) {
> +        /* v2.03-v2.07 define an older incompatible 'wait' encoding. */
> +
> +        if (ctx->insns_flags2 & PPC2_PM_ISA206) {
> +            /* v2.06 introduced the WC field. WC > 0 may be treated as no-op. */
> +            wc = a->wc;
> +        } else {
> +            wc = 0;
> +        }
> +
> +    } else if (ctx->insns_flags2 & PPC2_ISA300) {
> +        /* v3.0 defines a new 'wait' encoding. */
> +        wc = a->wc;
> +        if (ctx->insns_flags2 & PPC2_ISA310) {
> +            uint32_t pl = a->pl;
> +
> +            /* WC 1,2 may be treated as no-op. WC 3 is reserved. */
> +            if (wc == 3) {
> +                gen_invalid(ctx);
> +                return true;
> +            }
> +
> +            /* PL 1-3 are reserved. If WC=2 then the insn is treated as noop. */
> +            if (pl > 0 && wc != 2) {
> +                gen_invalid(ctx);
> +                return true;
> +            }
> +
> +        } else { /* ISA300 */
> +            /* WC 1-3 are reserved */
> +            if (wc > 0) {
> +                gen_invalid(ctx);
> +                return true;
> +            }
> +        }
> +
> +    } else {
> +        warn_report("wait instruction decoded with wrong ISA flags.");
> +        gen_invalid(ctx);
> +        return true;
> +    }
> +
> +    /*
> +     * wait without WC field or with WC=0 waits for an exception / interrupt
> +     * to occur.
> +     */
> +    if (wc == 0) {
> +        TCGv_i32 t0 = tcg_constant_i32(1);
> +        tcg_gen_st_i32(t0, tcg_env,
> +                       -offsetof(PowerPCCPU, env) + offsetof(CPUState, halted));
> +        /* Stop translation, as the CPU is supposed to sleep from now */
> +        gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
> +    }
> +
> +    /*
> +     * Other wait types must not just wait until an exception occurs because
> +     * ignoring their other wake-up conditions could cause a hang.
> +     *
> +     * For v2.06 and 2.07, wc=1,2,3 are architected but may be implemented as
> +     * no-ops.
> +     *
> +     * wc=1 and wc=3 explicitly allow the instruction to be treated as a no-op.
> +     *
> +     * wc=2 waits for an implementation-specific condition, such could be
> +     * always true, so it can be implemented as a no-op.
> +     *
> +     * For v3.1, wc=1,2 are architected but may be implemented as no-ops.
> +     *
> +     * wc=1 (waitrsv) waits for an exception or a reservation to be lost.
> +     * Reservation-loss may have implementation-specific conditions, so it
> +     * can be implemented as a no-op.
> +     *
> +     * wc=2 waits for an exception or an amount of time to pass. This
> +     * amount is implementation-specific so it can be implemented as a
> +     * no-op.
> +     *
> +     * ISA v3.1 allows for execution to resume "in the rare case of
> +     * an implementation-dependent event", so in any case software must
> +     * not depend on the architected resumption condition to become
> +     * true, so no-op implementations should be architecturally correct
> +     * (if suboptimal).
> +     */
> +     return true;
> +}
> +
> +TRANS_FLAGS(WAIT, WAIT_ISA_2_X, do_wait)
> +TRANS_FLAGS2(ISA300, WAIT, do_wait)
> +



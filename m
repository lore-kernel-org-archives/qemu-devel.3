Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3DA5F364C8
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 22:22:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAxkr-0008QD-80; Thu, 09 Apr 2026 18:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wAxkl-0008PM-Q8
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 18:21:35 -0400
Received: from ci-2001h-snip4-11.eps.apple.com ([57.103.91.73]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wAxkj-0003yk-Kx
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 18:21:35 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-8 (Postfix) with ESMTPS id
 2A14D18004BB; Thu, 09 Apr 2026 22:21:29 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775773292; x=1778365292;
 bh=1S+KCDXLXFB/Kj87zI3VKRRzMJGdeDz76gzdf/4QWiI=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=Rlg6cmBHHIo3I/dj0VCtfJ2kNgMNfqGjbdq2V8DMChS/Q51egam7h+7ikNnr3X6CQHLavBwm9fl7EChgmTMl/gwyGkM02sQeuw451UqSJ6vpEtn4ydR7quC14OUo63zZbVjAwFEIOdJm6dqe1EvPHOs0JGMdmSMMlFpg+XUFLWHK034Cd8Un8etir/aEYT/xcn55u+SYbEA1pda29pvs1NKeCfqnir0aTO4FFsy/EbrY3VNbQdoI2PBequKpSs1fdFHf3dWYTGSN0HAh5I5Trdc8Dl4RNqcpODedB9iiqHeVHbfvSgyukZaDz+3Iat/UZOqiiiYJhTJsMrj9arYKrA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-8 (Postfix) with ESMTPSA id
 6F3DD1800179; Thu, 09 Apr 2026 22:21:28 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v6 5/6] target/arm/emulate: add atomic, compare-and-swap, 
 and PAC load
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260409220614.65558-6-lucaaamaral@gmail.com>
Date: Fri, 10 Apr 2026 00:21:16 +0200
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, agraf@csgraf.de,
 peter.maydell@linaro.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9AD3250E-71F9-4B8B-95B3-01C56AF885F9@unpredictable.fr>
References: <20260409220614.65558-1-lucaaamaral@gmail.com>
 <20260409220614.65558-6-lucaaamaral@gmail.com>
To: Lucas Amaral <lucaaamaral@gmail.com>
X-Mailer: Apple Mail (2.3864.500.181)
X-Authority-Info-Out: v=2.4 cv=H5vWAuYi c=1 sm=1 tr=0 ts=69d8266a
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=RvG5qpVF8LBdndDRM_8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDIwNiBTYWx0ZWRfX4ZMlYQN47q7k
 bz2QnRiNseuQdFN5juaO5PEI8IXfWyFLUiWasLAh1ZhLnPmt5X6+RRyY2RPBMHTbeRBEDGxXxgL
 NiUVzmjNJVEoD3ddDNOEPx+j528E2asdkCawwA+srLictWqkaFNrlRwQ3Zg8YunUsv90dV7RtcQ
 Mxg3SvVH7Y9CFpC2uHO4sfKjll4+KeYafbvfBUcgrvD9K+zmIBvr61tf8Fy2YdHE/FinEMSlaSv
 MbDvYTlL4kp+XPcZgFj1wM31yQkxr+wHzxWWCQkIuvUv3HGEJTIrJHS0D7EB9h37FFtk2hKunYG
 rJsWwjxIkPG0xDK2lYVGoWDOk7UmmxvYMbOoX2Ix+swTnRqy/V1yWm5bKmaONA=
X-Proofpoint-ORIG-GUID: N0aJYCftXxOWRXKtuMfSfXIhN0gDlVF-
X-Proofpoint-GUID: N0aJYCftXxOWRXKtuMfSfXIhN0gDlVF-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=932
 phishscore=0 lowpriorityscore=0 clxscore=1030
 mlxscore=0 suspectscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604090206
Received-SPF: pass client-ip=57.103.91.73;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



> On 10. Apr 2026, at 00:06, Lucas Amaral <lucaaamaral@gmail.com> wrote:
>=20
> Add emulation for remaining ISV=3D0 load/store instruction classes.
>=20
With the caveat of =E2=80=9Cwhy does this even happen=E2=80=9D:

Maybe there should be a restriction to put a warning message
somewhere if an op happens on a non-MMIO range=E2=80=A6

Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>


> Atomic memory operations (DDI 0487 C3.3.2):
>  - LDADD, LDCLR, LDEOR, LDSET: arithmetic/logic atomics
>  - LDSMAX, LDSMIN, LDUMAX, LDUMIN: signed/unsigned min/max
>  - SWP: atomic swap
>  Non-atomic read-modify-write, sufficient for MMIO where concurrent
>  access is not a concern.  Acquire/release semantics are ignored.
>=20
> Compare-and-swap (DDI 0487 C3.3.1):
>  - CAS/CASA/CASAL/CASL: single-register compare-and-swap
>  - CASP/CASPA/CASPAL/CASPL: register-pair compare-and-swap
>  CASP validates even register pairs; odd or r31 returns UNHANDLED.
>=20
> Load with PAC (DDI 0487 C6.2.121):
>  - LDRAA/LDRAB: pointer-authenticated load, offset/pre-indexed
>  Pointer authentication is not emulated (equivalent to auth always
>  succeeding), which is correct for MMIO since PAC is a software
>  security mechanism, not a memory access semantic.
>=20
> Decodetree differences from TCG:
>  - %ldra_imm extracts the raw S:imm9 field; the handler scales by
>    << 3.  TCG applies !function=3Dtimes_8 in the formatter.
>  - @ldra uses wildcards for fixed opcode bits that TCG locks down
>    (bits 31:30, bit 20, bit 11); the fixed bits are matched by the
>    instruction pattern instead.
>  - @cas is an explicit format template; TCG uses inline field
>    extraction.
>=20
> CASP uses two explicit decode patterns for the 32/64-bit size
> variants.  LDRA's offset immediate is stored raw in the decode;
> the handler scales by << 3.
>=20
> Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
> ---
> target/arm/emulate/a64-ldst.decode |  45 ++++++
> target/arm/emulate/arm_emulate.c   | 233 +++++++++++++++++++++++++++++
> 2 files changed, 278 insertions(+)
>=20
> diff --git a/target/arm/emulate/a64-ldst.decode =
b/target/arm/emulate/a64-ldst.decode
> index fadf6fd2..9292bfdf 100644
> --- a/target/arm/emulate/a64-ldst.decode
> +++ b/target/arm/emulate/a64-ldst.decode
> @@ -16,6 +16,16 @@
> # Load/store pair (GPR and SIMD/FP)
> &ldstpair       rt2 rt rn imm sz sign w p
>=20
> +# Atomic memory operations
> +&atomic         rs rn rt a r sz
> +
> +# Compare-and-swap
> +&cas            rs rn rt sz a r
> +
> +# Load with PAC (LDRAA/LDRAB, FEAT_PAuth)
> +%ldra_imm       22:s1 12:9
> +&ldra           rt rn imm m w
> +
> # Load/store register offset
> &ldst           rm rn rt sign ext sz opt s
>=20
> @@ -36,6 +46,15 @@
> # Load/store pair: imm7 is signed, scaled by element size in handler
> @ldstpair       .. ... . ... . imm:s7 rt2:5 rn:5 rt:5          =
&ldstpair
>=20
> +# Atomics
> +@atomic         sz:2 ... . .. a:1 r:1 . rs:5 . ... .. rn:5 rt:5   =
&atomic
> +
> +# Compare-and-swap: sz extracted by pattern (CAS) or set constant =
(CASP)
> +@cas            .. ...... . a:1 . rs:5 r:1 ..... rn:5 rt:5        =
&cas
> +
> +# Load with PAC
> +@ldra           .. ... . .. m:1 . . ......... w:1 . rn:5 rt:5     =
&ldra imm=3D%ldra_imm
> +
> # Load/store register offset
> @ldst           .. ... . .. .. . rm:5 opt:3 s:1 .. rn:5 rt:5   &ldst
>=20
> @@ -241,6 +260,32 @@ STR_v           00 111 1 00 10 1 ..... ... . 10 =
..... .....    @ldst sign=3D0 ext=3D
> LDR_v           sz:2 111 1 00 01 1 ..... ... . 10 ..... .....  @ldst =
sign=3D0 ext=3D0
> LDR_v           00 111 1 00 11 1 ..... ... . 10 ..... .....    @ldst =
sign=3D0 ext=3D0 sz=3D4
>=20
> +### Compare-and-swap
> +
> +# CAS / CASA / CASAL / CASL
> +CAS             sz:2 001000 1 . 1 ..... . 11111 ..... .....     @cas
> +
> +# CASP / CASPA / CASPAL / CASPL (pair: Rt,Rt+1 and Rs,Rs+1)
> +CASP            00 001000 0 . 1 ..... . 11111 ..... .....       @cas =
sz=3D2
> +CASP            01 001000 0 . 1 ..... . 11111 ..... .....       @cas =
sz=3D3
> +
> +### Atomic memory operations
> +
> +LDADD           .. 111 0 00 . . 1 ..... 0000 00 ..... .....    =
@atomic
> +LDCLR           .. 111 0 00 . . 1 ..... 0001 00 ..... .....    =
@atomic
> +LDEOR           .. 111 0 00 . . 1 ..... 0010 00 ..... .....    =
@atomic
> +LDSET           .. 111 0 00 . . 1 ..... 0011 00 ..... .....    =
@atomic
> +LDSMAX          .. 111 0 00 . . 1 ..... 0100 00 ..... .....    =
@atomic
> +LDSMIN          .. 111 0 00 . . 1 ..... 0101 00 ..... .....    =
@atomic
> +LDUMAX          .. 111 0 00 . . 1 ..... 0110 00 ..... .....    =
@atomic
> +LDUMIN          .. 111 0 00 . . 1 ..... 0111 00 ..... .....    =
@atomic
> +SWP             .. 111 0 00 . . 1 ..... 1000 00 ..... .....    =
@atomic
> +
> +### Load with PAC (FEAT_PAuth)
> +
> +# LDRAA (M=3D0) / LDRAB (M=3D1), offset (W=3D0) / pre-indexed (W=3D1)
> +LDRA            11 111 0 00 . . 1 ......... . 1 ..... .....  @ldra
> +
> ### System instructions =E2=80=94 DC cache maintenance
>=20
> # SYS with CRn=3DC7 covers all data cache operations (DC CIVAC, CVAC, =
etc.).
> diff --git a/target/arm/emulate/arm_emulate.c =
b/target/arm/emulate/arm_emulate.c
> index 7f876355..6601c9dc 100644
> --- a/target/arm/emulate/arm_emulate.c
> +++ b/target/arm/emulate/arm_emulate.c
> @@ -547,6 +547,239 @@ static bool trans_LDXP(DisasContext *ctx, =
arg_stxr *a)
>     return true;
> }
>=20
> +/*
> + * Atomic memory operations (DDI 0487 C3.3.2)
> + *
> + * Non-atomic read-modify-write; sufficient for MMIO.
> + * Acquire/release semantics ignored (sequentially consistent by =
design).
> + */
> +
> +typedef uint64_t (*atomic_op_fn)(uint64_t old, uint64_t operand, int =
bits);
> +
> +static uint64_t atomic_add(uint64_t old, uint64_t op, int bits)
> +{
> +    return old + op;
> +}
> +
> +static uint64_t atomic_clr(uint64_t old, uint64_t op, int bits)
> +{
> +    return old & ~op;
> +}
> +
> +static uint64_t atomic_eor(uint64_t old, uint64_t op, int bits)
> +{
> +    return old ^ op;
> +}
> +
> +static uint64_t atomic_set(uint64_t old, uint64_t op, int bits)
> +{
> +    return old | op;
> +}
> +
> +static uint64_t atomic_smax(uint64_t old, uint64_t op, int bits)
> +{
> +    int64_t a =3D sextract64(old, 0, bits);
> +    int64_t b =3D sextract64(op, 0, bits);
> +    return (a >=3D b) ? old : op;
> +}
> +
> +static uint64_t atomic_smin(uint64_t old, uint64_t op, int bits)
> +{
> +    int64_t a =3D sextract64(old, 0, bits);
> +    int64_t b =3D sextract64(op, 0, bits);
> +    return (a <=3D b) ? old : op;
> +}
> +
> +static uint64_t atomic_umax(uint64_t old, uint64_t op, int bits)
> +{
> +    uint64_t mask =3D (bits =3D=3D 64) ? UINT64_MAX : (1ULL << bits) =
- 1;
> +    return ((old & mask) >=3D (op & mask)) ? old : op;
> +}
> +
> +static uint64_t atomic_umin(uint64_t old, uint64_t op, int bits)
> +{
> +    uint64_t mask =3D (bits =3D=3D 64) ? UINT64_MAX : (1ULL << bits) =
- 1;
> +    return ((old & mask) <=3D (op & mask)) ? old : op;
> +}
> +
> +static bool do_atomic(DisasContext *ctx, arg_atomic *a, atomic_op_fn =
fn)
> +{
> +    int esize =3D 1 << a->sz;
> +    int bits =3D 8 * esize;
> +    uint64_t va =3D base_read(ctx, a->rn);
> +    uint8_t buf[8];
> +
> +    if (mem_read(ctx, va, buf, esize) !=3D 0) {
> +        return true;
> +    }
> +
> +    uint64_t old =3D mem_ld(ctx, buf, esize);
> +    uint64_t operand =3D gpr_read(ctx, a->rs);
> +    uint64_t result =3D fn(old, operand, bits);
> +
> +    mem_st(ctx, buf, esize, result);
> +    if (mem_write(ctx, va, buf, esize) !=3D 0) {
> +        return true;
> +    }
> +
> +    /* Rt receives the old value (before modification) */
> +    gpr_write(ctx, a->rt, old);
> +    return true;
> +}
> +
> +static bool trans_LDADD(DisasContext *ctx, arg_atomic *a)
> +{
> +    return do_atomic(ctx, a, atomic_add);
> +}
> +
> +static bool trans_LDCLR(DisasContext *ctx, arg_atomic *a)
> +{
> +    return do_atomic(ctx, a, atomic_clr);
> +}
> +
> +static bool trans_LDEOR(DisasContext *ctx, arg_atomic *a)
> +{
> +    return do_atomic(ctx, a, atomic_eor);
> +}
> +
> +static bool trans_LDSET(DisasContext *ctx, arg_atomic *a)
> +{
> +    return do_atomic(ctx, a, atomic_set);
> +}
> +
> +static bool trans_LDSMAX(DisasContext *ctx, arg_atomic *a)
> +{
> +    return do_atomic(ctx, a, atomic_smax);
> +}
> +
> +static bool trans_LDSMIN(DisasContext *ctx, arg_atomic *a)
> +{
> +    return do_atomic(ctx, a, atomic_smin);
> +}
> +
> +static bool trans_LDUMAX(DisasContext *ctx, arg_atomic *a)
> +{
> +    return do_atomic(ctx, a, atomic_umax);
> +}
> +
> +static bool trans_LDUMIN(DisasContext *ctx, arg_atomic *a)
> +{
> +    return do_atomic(ctx, a, atomic_umin);
> +}
> +
> +static bool trans_SWP(DisasContext *ctx, arg_atomic *a)
> +{
> +    int esize =3D 1 << a->sz;
> +    uint64_t va =3D base_read(ctx, a->rn);
> +    uint8_t buf[8];
> +
> +    if (mem_read(ctx, va, buf, esize) !=3D 0) {
> +        return true;
> +    }
> +
> +    uint64_t old =3D mem_ld(ctx, buf, esize);
> +    mem_st(ctx, buf, esize, gpr_read(ctx, a->rs));
> +    if (mem_write(ctx, va, buf, esize) !=3D 0) {
> +        return true;
> +    }
> +
> +    gpr_write(ctx, a->rt, old);
> +    return true;
> +}
> +
> +/* Compare-and-swap: CAS, CASP (DDI 0487 C3.3.1) */
> +
> +static bool trans_CAS(DisasContext *ctx, arg_cas *a)
> +{
> +    int esize =3D 1 << a->sz;
> +    uint64_t va =3D base_read(ctx, a->rn);
> +    uint8_t buf[8];
> +
> +    if (mem_read(ctx, va, buf, esize) !=3D 0) {
> +        return true;
> +    }
> +
> +    uint64_t current =3D mem_ld(ctx, buf, esize);
> +    uint64_t mask =3D (esize =3D=3D 8) ? UINT64_MAX : (1ULL << (8 * =
esize)) - 1;
> +    uint64_t compare =3D gpr_read(ctx, a->rs) & mask;
> +
> +    if ((current & mask) =3D=3D compare) {
> +        uint64_t newval =3D gpr_read(ctx, a->rt) & mask;
> +        mem_st(ctx, buf, esize, newval);
> +        if (mem_write(ctx, va, buf, esize) !=3D 0) {
> +            return true;
> +        }
> +    }
> +
> +    /* Rs receives the old memory value (whether or not swap =
occurred) */
> +    gpr_write(ctx, a->rs, current);
> +    return true;
> +}
> +
> +/* CASP: compare-and-swap pair (Rs,Rs+1 compared; Rt,Rt+1 stored) */
> +static bool trans_CASP(DisasContext *ctx, arg_cas *a)
> +{
> +    /* CASP requires even register pairs; odd or r31 is UNPREDICTABLE =
*/
> +    if ((a->rs & 1) || a->rs >=3D 31 || (a->rt & 1) || a->rt >=3D 31) =
{
> +        return false;
> +    }
> +
> +    int esize =3D 1 << a->sz;                   /* per-register size =
*/
> +    uint64_t va =3D base_read(ctx, a->rn);
> +    uint8_t buf[16];
> +
> +    if (mem_read(ctx, va, buf, 2 * esize) !=3D 0) {
> +        return true;
> +    }
> +    uint64_t cur1 =3D mem_ld(ctx, buf, esize);
> +    uint64_t cur2 =3D mem_ld(ctx, buf + esize, esize);
> +
> +    uint64_t mask =3D (esize =3D=3D 8) ? UINT64_MAX : (1ULL << (8 * =
esize)) - 1;
> +    uint64_t cmp1 =3D gpr_read(ctx, a->rs) & mask;
> +    uint64_t cmp2 =3D gpr_read(ctx, a->rs + 1) & mask;
> +
> +    if ((cur1 & mask) =3D=3D cmp1 && (cur2 & mask) =3D=3D cmp2) {
> +        uint64_t new1 =3D gpr_read(ctx, a->rt) & mask;
> +        uint64_t new2 =3D gpr_read(ctx, a->rt + 1) & mask;
> +        mem_st(ctx, buf, esize, new1);
> +        mem_st(ctx, buf + esize, esize, new2);
> +        if (mem_write(ctx, va, buf, 2 * esize) !=3D 0) {
> +            return true;
> +        }
> +    }
> +
> +    gpr_write(ctx, a->rs, cur1);
> +    gpr_write(ctx, a->rs + 1, cur2);
> +    return true;
> +}
> +
> +/*
> + * Load with PAC: LDRAA / LDRAB (FEAT_PAuth)
> + * (DDI 0487 C6.2.121)
> + *
> + * Pointer authentication is not emulated -- the base register is =
used
> + * directly (equivalent to auth always succeeding).
> + */
> +
> +static bool trans_LDRA(DisasContext *ctx, arg_ldra *a)
> +{
> +    int64_t offset =3D (int64_t)a->imm << 3;  /* S:imm9, scaled by 8 =
*/
> +    uint64_t base =3D base_read(ctx, a->rn);
> +    uint64_t va =3D base + offset;  /* auth not emulated */
> +    uint8_t buf[8];
> +
> +    if (mem_read(ctx, va, buf, 8) !=3D 0) {
> +        return true;
> +    }
> +
> +    gpr_write(ctx, a->rt, mem_ld(ctx, buf, 8));
> +
> +    if (a->w) {
> +        base_write(ctx, a->rn, va);
> +    }
> +    return true;
> +}
> +
> /* PRFM, DC cache maintenance -- treated as NOP */
> static bool trans_NOP(DisasContext *ctx, arg_NOP *a)
> {
> --=20
> 2.52.0
>=20
>=20



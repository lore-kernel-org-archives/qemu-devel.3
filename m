Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB86F433C7
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 05:00:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDEpp-0002v8-Dr; Thu, 16 Apr 2026 01:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wDEpk-0002qT-GY
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 01:00:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wDEpg-0003Vr-Mz
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 01:00:08 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G1BVJP2834774
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 04:59:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AAIfmiEuQhUBJz1pm0NwBxfGFGXBFIdlvZd4oYgAe48=; b=FmlaaRL+aDlyiquW
 X7qxmNeFZ1CeVpOnweBPvMSUHtIaFixTnwoaCv3gMAYw50+0gTI1/kjAJoFjruYu
 IWiXbgMAviog9l+Sjf1zVdHUMpQPpCxX4Zz/ThvY0Op/VhrZg97AclOHkCGudJAV
 JmmdsTqYcCVLSzhiX7acYEcUL+8KB/X/noC4FgITvs44HF7WgWQGoVw0mEkxnbzH
 Vo6y3ajgRrm66u1hYurxXJStwl7gmiM1EZJs/6etg25x/WIiYex/hMiEPVyRadIX
 6lRCrFlNgAhQVvK0n/+et4CU2q06f0kf4EWgr9zyTDrnsVK0qRhchjSs/ZIIKT68
 kRSfYw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djcsvjb9c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 04:59:59 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2bdf75bc88fso11365678eec.0
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 21:59:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776315599; cv=none;
 d=google.com; s=arc-20240605;
 b=S3mPGQEyokUz8UwlY9JcUzE1xF71yoBzQgoXvvBxvsQzpKZxI/hXKdALDcTXkqJpyD
 2wLNU3gAs+MuDYWgqrcNuq7ycLeqanqh/DJrvXNXcwW/v6dJmV9jYc8JTPslF857G6OD
 yqrSdj83W5WwX1DC2jg9kri5XkvEt60/MerCLVdfEMRW5XmJRglzXnUc0IGmPBxP17kM
 4xkcjEmIn8TNek7oS6PKKV+02zwWsUIYPuyqRY9rvhaGIjFJZwhUKm2+BidIBFn4MsNE
 dICtS2WfITaYWnhLAjNUo/r2TxMHuFP7kf5dvPgyZIrPTUZsLS1sI6uP2zTvuooW6HWt
 FObg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AAIfmiEuQhUBJz1pm0NwBxfGFGXBFIdlvZd4oYgAe48=;
 fh=bd4NqF8mWkw5BKad7KyyuY5CBD+jIgRsk3tsaCztl6A=;
 b=TMRx5mgeslriuZZ22Kncf/kFPYVlOfAMTLiu7xsGNJgo4wZd39/L+uxuBCEMEqmYW+
 NJ1q7azh6GZrtjGO7e0pswQ9OzvGGvRtNSA1e/fU8yyxeAHooa7SH5px4ELgPdBfKouj
 AsDQ+olMQ+MbiimxZhkPLsUkLDkjxtJGB0y3qzbZTOkUIzXFA5t91lls3nrVzYmfwV5C
 jwyWB55YvfKTp+s8ZTQCgZvr1H/CwyFbQ2D2y1jBV5eRbhJtzsvCs9WjxYWH9v+LHFvb
 NR7iSuC+RKHRnu2OGcVAO2P9R5OCCBcS0/OTB54ZY65l6caWZTuOtUbO3yS7ut7i4VA6
 DsEg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776315599; x=1776920399; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AAIfmiEuQhUBJz1pm0NwBxfGFGXBFIdlvZd4oYgAe48=;
 b=XrJ9DyXQTa0a+USTiBwYCCHIhE4LBrmuhlxxsdJ8Ws3HLphJzb+CR/3O5xflNLVcIy
 aKz5YXWqEd7G7UCkIvlYm0/+vluwmvGzk8wM6F7ldAuqvhAhl/dJ5umFYBnrIZnDGP/F
 7tTRI4Ua/8eTc65GYKr7+NqMqKiX9FloDawipRZb6p4uZOPsbe4vFPmCuUZL6r7IYI+z
 2hm4zWrGdFOZzte0XVvuCdB833eiYuE17Qw5/M/gIkb7oIEsr48bFeP0G4sfUW4GP5tb
 ElUA1nedNy7NX+a7WaPgfK/h49N5L7jiGtTPkVePHMY3atZeXgSFXSJEMc75ekB0QvHx
 ok0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776315599; x=1776920399;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AAIfmiEuQhUBJz1pm0NwBxfGFGXBFIdlvZd4oYgAe48=;
 b=hL+tg/+PgXC1Gv+mWwkDn6BxnZnOprQe1kOTBa36zWeiZXPMhWVlgvy6dHaK6ibY71
 WFkMCs/zXhxmW1Iw34J1CYjAuufgy8taT17ncP6l92mzlr00AN/1VNenw+jB1zh3VavV
 tQHK3rgzizOw5fVdPzmG0dK9uPOCoA73dApwZ6j9v7jC8i9st9q7cF6WnmPWxa+sP2FT
 zebnKTqdLJvosI+XHsvnZGM8/sFG0yhDBv6x6aCSp0UEdMfv5/MjHqfDwiFmug1MNDKA
 E204S7JyK9Jyn3xa00JTFZsxy/w819DCUyyfR8epu6pqf2y89hbXGe0Ngt/hbwunxtiV
 6JOw==
X-Gm-Message-State: AOJu0Yy/L2mHnbB4Ae+oo40bGUNdyfcIEMkv3peT+1QwFHttj5cUOtx+
 MiwJSdRIIi744/55625G7UQdeN4WI0tKWh+ngwtBDrzXyFBdipHJtBs1EQQuK3K2oIg7GnaTEd7
 HEVieykRCgLBzDAWBXOAySq30D1s/Q8+jmF8sKTEel7bNNIOXpedSFWLZCB3mcDUV98LUT1Ef+D
 CKZO2i9VOhDdHZTwz2qP8N4gc33yoJegLB
X-Gm-Gg: AeBDievW+kiZ41a63TcFpbVSBVdqi2TtJajWhY589a6atWifW6PPwLzgJyJZ5Iu5B9p
 Ik+7NBXY5PNLlh9EkShPrsIOOuEyBRxIYlTtPfeaAfbMpf0IDyFvis0VMmxCGnzklWwbXUzHpEI
 xLQ4L4YzGNvdPuO9wHDtv/C6rwZyZ/jhK7M17fho3ZY0mnuJsYFWeqPuQ45rEVB1XhvZGRKGmZy
 6OZPRI=
X-Received: by 2002:a05:7022:618:b0:12a:85ef:1e50 with SMTP id
 a92af1059eb24-12c34e899e2mr14418031c88.12.1776315598640; 
 Wed, 15 Apr 2026 21:59:58 -0700 (PDT)
X-Received: by 2002:a05:7022:618:b0:12a:85ef:1e50 with SMTP id
 a92af1059eb24-12c34e899e2mr14418016c88.12.1776315597939; Wed, 15 Apr 2026
 21:59:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1775843299.git.matheus.bernardino@oss.qualcomm.com>
 <d408ee2b2c7004e7241aa2beaa136c2f28c73985.1775843299.git.matheus.bernardino@oss.qualcomm.com>
In-Reply-To: <d408ee2b2c7004e7241aa2beaa136c2f28c73985.1775843299.git.matheus.bernardino@oss.qualcomm.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Wed, 15 Apr 2026 23:59:41 -0500
X-Gm-Features: AQROBzDRGwZKji6At9AzFLPNFvzC2_e7QhELNlBAEHrvjVy6Dgp3sY4poBlh5pY
Message-ID: <CAEqNhNbPq9HVQzL=7kiRRAfcxmcwyoSVjBYjWZhePvLbm9MFMA@mail.gmail.com>
Subject: Re: [PATCH v4 11/16] target/hexagon: add v73 HVX IEEE bfloat16 insns
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, ale@rev.ng,
 anjo@rev.ng, ltaylorsimpson@gmail.com, marco.liebel@oss.qualcomm.com,
 philmd@linaro.org, quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 961EV5DyojkQDBm1GHsUO1B__V1GTG-K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA0NCBTYWx0ZWRfX4lrtUZJi17jY
 DhUelMkNtTIOvVA6YSpmMKhoNLIx1Sm7Yum94/nfaqAurN98zIbWjW8oxpeUphCUKEjLcq9sS8B
 UqFqjG1WBxCLrTAgJUgI/aoKW3sos04MZ8Q0oEQ1DpGr4T0s4nVTd6vkzF6cG9bpfsl9Xekzd0+
 NDbhuICCyxGOPOWVm31Tmz0LjSEsJy3g6OV5U/eFiV4bO+HL7oKM6H4/u4loEHM2a+4cDXNsGAo
 qEHJFR0d9+CVy82PevnXZIKyvawkq14h4zpA0KX7ffOSND0F2tVupkuct2QMXogNWD+c/kquvik
 M5Pm5AP5Cb0LFfqptGx+r/Ucv6vJ/l5rxCsU05Kr1rpXL8eWdW2/7x5x7IaEl5R3ro60B5W/iq9
 YYgMNjdv3K/x611uuD87CcAKuEfj+ONchhzVWDIvPII87DlaP0fZK67vvWH+OEptDX/Wtl6zMGT
 cR/dg/mFUAooXhGSlDw==
X-Authority-Analysis: v=2.4 cv=Iby3n2qa c=1 sm=1 tr=0 ts=69e06ccf cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=nerjL1la8kgMMoSsQgYA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: 961EV5DyojkQDBm1GHsUO1B__V1GTG-K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160044
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Fri, Apr 10, 2026 at 12:56=E2=80=AFPM Matheus Tavares Bernardino
<matheus.bernardino@oss.qualcomm.com> wrote:
>
> Add HVX IEEE bfloat16 (bf16) instructions:
>
> Arithmetic operations:
> - V6_vadd_sf_bf, V6_vsub_sf_bf: add/sub bf16 widening to sf output
> - V6_vmpy_sf_bf: multiply bf16 widening to sf output
> - V6_vmpy_sf_bf_acc: multiply-accumulate bf16 widening to sf output
>
> Min/Max operations:
> - V6_vmin_bf, V6_vmax_bf: bf16 min/max
>
> Comparison operations:
> - V6_vgtbf: greater-than compare
> - V6_vgtbf_and, V6_vgtbf_or, V6_vgtbf_xor: predicate variants
>
> Conversion operations:
> - V6_vcvt_bf_sf: convert sf to bf16
>
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcom=
m.com>
> ---
>  target/hexagon/mmvec/hvx_ieee_fp.h           | 37 ++++++++++++
>  target/hexagon/mmvec/macros.h                |  4 ++
>  target/hexagon/mmvec/mmvec.h                 |  1 +
>  target/hexagon/imported/mmvec/encode_ext.def | 15 +++++
>  target/hexagon/imported/mmvec/ext.idef       | 62 ++++++++++++++++++++
>  5 files changed, 119 insertions(+)
>
> diff --git a/target/hexagon/mmvec/hvx_ieee_fp.h b/target/hexagon/mmvec/hv=
x_ieee_fp.h
> index 01728121eb..b7e379b089 100644
> --- a/target/hexagon/mmvec/hvx_ieee_fp.h
> +++ b/target/hexagon/mmvec/hvx_ieee_fp.h
> @@ -9,8 +9,11 @@
>
>  #include "fpu/softfloat.h"
>
> +#define FP32_DEF_NAN 0x7FFFFFFF
> +
>  #define f16_to_f32(A) float16_to_float32((A), true, &env->hvx_fp_status)
>  #define f32_to_f16(A) float32_to_float16((A), true, &env->hvx_fp_status)
> +#define bf16_to_f32(A) bfloat16_to_float32(A, &env->hvx_fp_status)
>
>  float32 fp_mult_sf_hf(float16 a1, float16 a2, float_status *fp_status);
>  float32 fp_vdmpy(float16 a1, float16 a2, float16 a3, float16 a4,
> @@ -29,4 +32,38 @@ int16_t conv_h_hf(float16 a, float_status *fp_status);
>  uint32_t cmpgt_sf(float32 a1, float32 a2, float_status *fp_status);
>  uint16_t cmpgt_hf(float16 a1, float16 a2, float_status *fp_status);
>
> +/* IEEE BFloat instructions */
> +
> +#define fp_mult_sf_bf(A, B) \
> +    float32_mul(bf16_to_f32(A), bf16_to_f32(B), &env->hvx_fp_status)
> +
> +#define fp_add_sf_bf(A, B) \
> +    float32_add(bf16_to_f32(A), bf16_to_f32(B), &env->hvx_fp_status)
> +
> +#define fp_sub_sf_bf(A, B) \
> +    float32_sub(bf16_to_f32(A), bf16_to_f32(B), &env->hvx_fp_status)
> +
> +#define fp_mult_sf_bf_acc(f1, f2, f3) \
> +    float32_muladd(bf16_to_f32(f1), bf16_to_f32(f2), f3, 0, &env->hvx_fp=
_status)
> +
> +static inline bfloat16 f32_to_bf16(float32 A, float_status *fp_status)
> +{
> +    uint32_t rslt =3D A;
> +    if ((rslt & 0x1FFFF) =3D=3D 0x08000) {
> +        /* do not round up if exactly .5 and even already */
> +    } else if ((rslt & 0x8000) =3D=3D 0x8000) {
> +        rslt +=3D 0x8000; /* rounding to nearest number */
> +    }
> +    rslt =3D float32_is_any_nan(A) ? FP32_DEF_NAN : rslt;
> +    return float32_to_bfloat16(rslt, fp_status);
> +}
> +
> +#define fp_min_bf(A, B) \
> +    f32_to_bf16(float32_min(bf16_to_f32(A), bf16_to_f32(B), &env->hvx_fp=
_status), \
> +             &env->hvx_fp_status);
> +
> +#define fp_max_bf(A, B) \
> +    f32_to_bf16(float32_max(bf16_to_f32(A), bf16_to_f32(B), &env->hvx_fp=
_status), \
> +             &env->hvx_fp_status);
> +
>  #endif
> diff --git a/target/hexagon/mmvec/macros.h b/target/hexagon/mmvec/macros.=
h
> index 318d44efb7..4945a61194 100644
> --- a/target/hexagon/mmvec/macros.h
> +++ b/target/hexagon/mmvec/macros.h
> @@ -25,6 +25,9 @@
>  #include "accel/tcg/probe.h"
>  #include "mmvec/hvx_ieee_fp.h"
>
> +#define fBFLOAT()
> +#define fCVI_VX_NO_TMP_LD()
> +
>  #ifndef QEMU_GENERATE
>  #define VdV      (*(MMVector *restrict)(VdV_void))
>  #define VsV      (*(MMVector *restrict)(VsV_void))
> @@ -358,5 +361,6 @@
>
>  #define fCMPGT_SF(A, B) cmpgt_sf(A, B, &env->hvx_fp_status)
>  #define fCMPGT_HF(A, B) cmpgt_hf(A, B, &env->hvx_fp_status)
> +#define fCMPGT_BF(A, B) fCMPGT_SF((uint32_t)(A) << 16, (uint32_t)(B) << =
16)
>
>  #endif
> diff --git a/target/hexagon/mmvec/mmvec.h b/target/hexagon/mmvec/mmvec.h
> index 31909303b5..ab991471b1 100644
> --- a/target/hexagon/mmvec/mmvec.h
> +++ b/target/hexagon/mmvec/mmvec.h
> @@ -40,6 +40,7 @@ typedef union {
>      int8_t    b[MAX_VEC_SIZE_BYTES / 1];
>      float32  sf[MAX_VEC_SIZE_BYTES / 4];
>      float16  hf[MAX_VEC_SIZE_BYTES / 2];
> +    bfloat16 bf[MAX_VEC_SIZE_BYTES / 2];
>  } MMVector;
>
>  typedef union {
> diff --git a/target/hexagon/imported/mmvec/encode_ext.def b/target/hexago=
n/imported/mmvec/encode_ext.def
> index 3572e4de4c..16f043b77d 100644
> --- a/target/hexagon/imported/mmvec/encode_ext.def
> +++ b/target/hexagon/imported/mmvec/encode_ext.def
> @@ -868,4 +868,19 @@ DEF_ENC(V6_vgthf_or,"00011100100vvvvvPP1uuuuu001101x=
x")
>  DEF_ENC(V6_vgtsf_xor,"00011100100vvvvvPP1uuuuu111010xx")
>  DEF_ENC(V6_vgthf_xor,"00011100100vvvvvPP1uuuuu111011xx")
>
> +/* BFLOAT instructions */
> +DEF_ENC(V6_vmpy_sf_bf,"00011101010vvvvvPP1uuuuu100ddddd")
> +DEF_ENC(V6_vmpy_sf_bf_acc,"00011101000vvvvvPP1uuuuu000xxxxx")
> +DEF_ENC(V6_vadd_sf_bf,"00011101010vvvvvPP1uuuuu110ddddd")
> +DEF_ENC(V6_vsub_sf_bf,"00011101010vvvvvPP1uuuuu101ddddd")
> +DEF_ENC(V6_vmax_bf,"00011101010vvvvvPP1uuuuu111ddddd")
> +DEF_ENC(V6_vmin_bf,"00011101010vvvvvPP1uuuuu000ddddd")
> +DEF_ENC(V6_vcvt_bf_sf,"00011101010vvvvvPP1uuuuu011ddddd")
> +
> +/* BFLOAT compare instructions */
> +DEF_ENC(V6_vgtbf,"00011100100vvvvvPP1uuuuu011110dd")
> +DEF_ENC(V6_vgtbf_and,"00011100100vvvvvPP1uuuuu110100xx")
> +DEF_ENC(V6_vgtbf_or,"00011100100vvvvvPP1uuuuu001110xx")
> +DEF_ENC(V6_vgtbf_xor,"00011100100vvvvvPP1uuuuu111100xx")
> +
>  #endif /* NO MMVEC */
> diff --git a/target/hexagon/imported/mmvec/ext.idef b/target/hexagon/impo=
rted/mmvec/ext.idef
> index a7043d598c..44135a8eea 100644
> --- a/target/hexagon/imported/mmvec/ext.idef
> +++ b/target/hexagon/imported/mmvec/ext.idef
> @@ -3163,6 +3163,15 @@ ITERATOR_INSN_SHIFT_SLOT_FLT(16, vconv_hf_h,"Vd32.=
hf=3DVu32.h",
>      } \
>  }
>
> +#define VCMPGT_BF(DEST, ASRC, ASRCOP, CMP, N, SRC, MASK, WIDTH) \
> +{ \
> +    fBFLOAT(); \
> +    for (fHIDE(int) i =3D 0; i < fVBYTES(); i +=3D WIDTH) { \
> +        fHIDE(int) VAL =3D fCMPGT_BF(VuV.SRC[i/WIDTH],VvV.SRC[i/WIDTH]) =
? MASK : 0; \
> +        fSETQBITS(DEST,WIDTH,MASK,i,ASRC ASRCOP VAL); \
> +    } \
> +}
> +
>  /* Vector SF compare */
>  #define MMVEC_CMPGT_SF(TYPE,TYPE2,DESCR,N,MASK,WIDTH,SRC) \
>      EXTINSN(V6_vgt##TYPE##_and, "Qx4&=3Dvcmp.gt(Vu32." TYPE2 ",Vv32." TY=
PE2 ")", \
> @@ -3201,8 +3210,61 @@ ITERATOR_INSN_SHIFT_SLOT_FLT(16, vconv_hf_h,"Vd32.=
hf=3DVu32.h",
>          DESCR" greater than", \
>          VCMPGT_HF(QdV, , , ">", N, SRC, MASK, WIDTH))
>
> +/* Vector BF compare */
> +#define MMVEC_CMPGT_BF(TYPE,TYPE2,DESCR,N,MASK,WIDTH,SRC) \
> +    EXTINSN(V6_vgt##TYPE##_and, "Qx4&=3Dvcmp.gt(Vu32." TYPE2 ",Vv32." TY=
PE2 ")",\
> +        ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VA,A_CVI_VA_2SRC,A_HVX_FLT), \
> +        DESCR" greater than with predicate-and", \
> +        VCMPGT_BF(QxV, fGETQBITS(QxV,WIDTH,MASK,i), &, ">", N, SRC, MASK=
, WIDTH)) \
> +    EXTINSN(V6_vgt##TYPE##_xor, "Qx4^=3Dvcmp.gt(Vu32." TYPE2 ",Vv32." TY=
PE2 ")", \
> +        ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VA,A_CVI_VA_2SRC,A_HVX_FLT), \
> +        DESCR" greater than with predicate-xor", \
> +        VCMPGT_BF(QxV, fGETQBITS(QxV,WIDTH,MASK,i), ^, ">", N, SRC, MASK=
, WIDTH)) \
> +    EXTINSN(V6_vgt##TYPE##_or, "Qx4|=3Dvcmp.gt(Vu32." TYPE2 ",Vv32." TYP=
E2 ")", \
> +        ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VA,A_CVI_VA_2SRC,A_HVX_FLT), \
> +        DESCR" greater than with predicate-or", \
> +        VCMPGT_BF(QxV, fGETQBITS(QxV,WIDTH,MASK,i), |, ">", N, SRC, MASK=
, WIDTH)) \
> +    EXTINSN(V6_vgt##TYPE, "Qd4=3Dvcmp.gt(Vu32." TYPE2 ",Vv32." TYPE2 ")"=
, \
> +        ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VA,A_CVI_VA_2SRC,A_HVX_FLT), \
> +        DESCR" greater than", \
> +        VCMPGT_BF(QdV, , , ">", N, SRC, MASK, WIDTH))
> +
>  MMVEC_CMPGT_SF(sf,"sf","Vector sf Compare ", fVELEM(32), 0xF, 4, sf)
>  MMVEC_CMPGT_HF(hf,"hf","Vector hf Compare ", fVELEM(16), 0x3, 2, hf)
> +MMVEC_CMPGT_BF(bf,"bf","Vector bf Compare ", fVELEM(16), 0x3, 2, bf)
> +
> +/***********************************************************************=
*******
> + BFloat arithmetic and max/min instructions
> + ***********************************************************************=
*******/
> +
> +ITERATOR_INSN_IEEE_FP_DOUBLE_32(32, vadd_sf_bf,
> +    "Vdd32.sf=3Dvadd(Vu32.bf,Vv32.bf)",  "Vector IEEE add: bf widen to s=
f",
> +    VddV.v[0].sf[i] =3D fp_add_sf_bf(VuV.bf[2*i], VvV.bf[2*i]);
> +    VddV.v[1].sf[i] =3D fp_add_sf_bf(VuV.bf[2*i+1], VvV.bf[2*i+1]); fBFL=
OAT())
> +ITERATOR_INSN_IEEE_FP_DOUBLE_32(32, vsub_sf_bf,
> +    "Vdd32.sf=3Dvsub(Vu32.bf,Vv32.bf)",  "Vector IEEE sub: bf widen to s=
f",
> +    VddV.v[0].sf[i] =3D fp_sub_sf_bf(VuV.bf[2*i], VvV.bf[2*i]);
> +    VddV.v[1].sf[i] =3D fp_sub_sf_bf(VuV.bf[2*i+1], VvV.bf[2*i+1]); fBFL=
OAT())
> +ITERATOR_INSN_IEEE_FP_DOUBLE_32(32, vmpy_sf_bf,
> +    "Vdd32.sf=3Dvmpy(Vu32.bf,Vv32.bf)",  "Vector IEEE mul: hf widen to s=
f",
> +    VddV.v[0].sf[i] =3D fp_mult_sf_bf(VuV.bf[2*i], VvV.bf[2*i]);
> +    VddV.v[1].sf[i] =3D fp_mult_sf_bf(VuV.bf[2*i+1], VvV.bf[2*i+1]); fBF=
LOAT())
> +ITERATOR_INSN_IEEE_FP_DOUBLE_32(32, vmpy_sf_bf_acc,
> +    "Vxx32.sf+=3Dvmpy(Vu32.bf,Vv32.bf)", "Vector IEEE fma: hf widen to s=
f",
> +    VxxV.v[0].sf[i] =3D fp_mult_sf_bf_acc(VuV.bf[2*i], VvV.bf[2*i], VxxV=
.v[0].sf[i]);
> +    VxxV.v[1].sf[i] =3D fp_mult_sf_bf_acc(VuV.bf[2*i+1], VvV.bf[2*i+1], =
VxxV.v[1].sf[i]);
> +    fCVI_VX_NO_TMP_LD(); fBFLOAT())
> +ITERATOR_INSN_IEEE_FP_16(32, vcvt_bf_sf,
> +    "Vd32.bf=3Dvcvt(Vu32.sf,Vv32.sf)",   "Vector IEEE cvt: sf to bf",
> +    VdV.bf[2*i]   =3D f32_to_bf16(VuV.sf[i], &env->hvx_fp_status);
> +    VdV.bf[2*i+1] =3D f32_to_bf16(VvV.sf[i], &env->hvx_fp_status); fBFLO=
AT())
> +
> +ITERATOR_INSN_IEEE_FP_16_32_LATE(16, vmax_bf, "Vd32.bf=3Dvmax(Vu32.bf,Vv=
32.bf)",
> +    "Vector IEEE max: bf", VdV.bf[i] =3D fp_max_bf(VuV.bf[i], VvV.bf[i])=
;
> +    fBFLOAT())
> +ITERATOR_INSN_IEEE_FP_16_32_LATE(16, vmin_bf, "Vd32.bf=3Dvmin(Vu32.bf,Vv=
32.bf)",
> +    "Vector IEEE max: bf", VdV.bf[i] =3D fp_min_bf(VuV.bf[i], VvV.bf[i])=
;
> +    fBFLOAT())

Looks like a copy/paste error here - referring to "Vector IEEE max"
for the "vmin" instruction?

>
>  /***********************************************************************=
*******
>   DEBUG Vector/Register Printing
> --
> 2.37.2
>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA359CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 21:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBflp-0004do-9f; Tue, 29 Sep 2026 17:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xBfln-0004dU-Ix
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:53:51 -0400
Received: from mail-lf2-x11.google.com ([2a00:1450:4864:36::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xBfll-0006Rp-Lf
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:53:51 -0400
Received: by mail-lf2-x11.google.com with SMTP id
 2adb3069b0e04-5b8e6ec4d9bso3769180e87.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 14:53:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790718827; cv=none;
 d=google.com; s=arc-20260327;
 b=mds8WvRcpbjQMDa7neEIpCODVyeHJm5sgIZmTOSgp+0uh3iDZk7SO/S2SuLSkppu+6
 ILtCB9wiCnX5e6j+qlD8CNmiE/TkythBrYlpWmoHLLF3fGQuNbHhztCW1UZVrJMrRrGn
 9EM0HHX5fPkUmAma5lohc1xFHJBB7SG9p19GDHTf3yb9ZTZTuzjIabqhDnxzhbo8I58+
 cbpzG09HYwOeomislGb/Ivz2eKauGCMVzb5esG1pBy0SebmrAb2mTGptPvOQ2SF7M8D2
 IanxhCa4TFDMQA2v8MdKAImvxEy6tWSHjv7dBoMt+Y1IDEnhjufdrliNPMvN/SgaoBF8
 sJQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MK4R1FZ+CPXIAcl1Zm8og+0culY+W9n7jrlejYSx69M=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=aer1cWsfff9Arz//DSubhsRVxyoAGJl6BecVvY6o4/MA+wGKnZRUNPy5wEXgzHZgg+
 C7KprQemesDoCqNJ0grM7CDKM0jT2dCNAS2Cg2ME3LcI3H0fnb9ZXo/tC9jUon37l404
 k2h0rheBS+yWIcsADW8LDPjeT+SUqmU1WQfC2XYx3CSEqo4G60Ccr+aHwWDth8GUkUSW
 m3mWwBuVJAsbGmtWSTDXYH16n9UpjzQl/qxotuLYeN89GWZDD0SQxXCsyqGzreuCtYg6
 6gJgrwRAwF1yNDqh70qi294rNYz5jy41Om36Sggm58i4pkFvQC8afmpDLoyR1w4PdH9B
 l3WQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790718827; x=1791323627; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MK4R1FZ+CPXIAcl1Zm8og+0culY+W9n7jrlejYSx69M=;
 b=cKBtAAKeV4WRGoTyUUhYIc0ZwKx3+F5e3K0Q7CcLhwqLMPWTzxUAb+sio146RfGM8q
 G0idm4zAGpFmgkpSl2RGGiT/GLUYqDS+w22N9z8DlrL2V1SwuGqIa2wiylx2khqulHpY
 7BCY2gtqRJMW9BtD1pHJteRIETSA/lW5bi+gpsNjtbaX33raq0/GbU7Rr58H39+vK9aS
 yjYViH47fKxAU1uaPo8KOQ1d5PCLcsYRXDr2RmcC2eGFroeSfR6mpxil0E4t3yMuJT1L
 3OQNo9Lx1PFKZEMn/kokJ8TchsEeZwueXU5E0tCHeirNZG6WfEZrPFewPnNFkqoPnAQe
 MIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790718827; x=1791323627;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MK4R1FZ+CPXIAcl1Zm8og+0culY+W9n7jrlejYSx69M=;
 b=2IL1YR+QtTwRLv0Z1NhBSiinma6SPOTEa0PPDScnq9Tma+wuJwUw3yhuhak3RiRPfF
 BWTeJldqt96bwepHDrZiRp239lY7LYCibPWOhOb7rNbBUjV8bfEl7eN2t9l1cXnf+ayR
 msNA7+CkDOmBohjX2ihsvGzv20kUKPmf4ieETYeSosAZh765cUKTgvF5eda6IMDt+8te
 eCQEWca2XKLB9wbZNwZ/ZeBsKP0V9BLpm2CZ6jjssBt19MMiljUdlUtqQ9r6Dq/RywWK
 RQTYrQXgH4Ckev6DSyt9/ew6hjisgdRmdQnoVf7BFwyZsaNrWeTYWSbbYxl8elpSXzT4
 nKlA==
X-Gm-Message-State: AFq9FYK8rr51+nIykqef4gAP7YavtAlCLqPIILv4FWwWp3YHoLE1yVHD
 V7X1rUMljrxz7Gr927NQvCE5yxqfGoi7E4KhQb4weLvB4UHZsUFTpX3vrFaqFGzY+dzlw4MwxRs
 /xxE07Ujo5uV3yZUPxSi1ohrCGN4DfIA=
X-Gm-Gg: AYBFou0zvcqV/bGeCYvsQ3ty0kJyYdVq7dIUTeAXnwhJgkmpgrGmPPCdetcyn43pnS3
 WvSd3h8jTnEndlImWCaYbE8O0azwqr14xhwydpWEaUba+/Hy7ajA4Mvoe7EVzfSe8mx3617JXhx
 E/+D83MKY8+C8XswRaedqoNOnsP17A5yvxDFV1xRtqfQe16L576MWV3nsFFws+qga0Iekn7nVkS
 imYHOJ/vsjq2QYHb/ud5hscMLIjv/n6BW3Uk9kpCsKQ+t4SNbAoAbYibbMxtP3e1OXpHoNfSUNu
 ydluHMWurMZJBFn6DHbHFeLAOMeTDh//BAwPg3w4jvGG3ywvUKM9wyd4A7cgKDZ2M0XPClq3QiB
 wofPoZtGUv3JaNi3LOETJRQpl
X-Received: by 2002:a05:6512:3dac:b0:5b0:137f:9476 with SMTP id
 2adb3069b0e04-5ba3bf3cbffmr274813e87.16.1790718827303; Tue, 29 Sep 2026
 14:53:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-16-richard.henderson@linaro.org>
In-Reply-To: <20260927090011.10724-16-richard.henderson@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Tue, 29 Sep 2026 17:53:32 -0400
X-Gm-Features: AclHuK8L117uCSLFG5MD623VVuhPE1pC0LEdTocd8qx6qL9NmGcTalCqpvSifLA
Message-ID: <CAEdQ38HDzHj=RZUqj8TDYSf2FJZFACGT75p2PTZB1iCyw4q0_Q@mail.gmail.com>
Subject: Re: [PATCH v5 015/101] tcg: Generic expansion of tcg_gen_subi_*
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:36::11;
 envelope-from=mattst88@gmail.com; helo=mail-lf2-x11.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
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

On Sun, Sep 27, 2026 at 5:00=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/tcg/tcg-op-common.h  |  2 --
>  include/tcg/tcg-op-def.h.inc |  1 +
>  tcg/tcg-op.c                 | 15 +++++----------
>  3 files changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
> index 8444044ed57..ff15e3b88ae 100644
> --- a/include/tcg/tcg-op-common.h
> +++ b/include/tcg/tcg-op-common.h
> @@ -124,7 +124,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned me=
minfo);
>  /* 32 bit ops */
>
>  void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2);
> -void tcg_gen_subi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
>  void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
>  void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
>  void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
> @@ -225,7 +224,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
>  /* 64 bit ops */
>
>  void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2);
> -void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
>  void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
>  void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
>  void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
> diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
> index 51d5ec6e06a..55249c4dd6f 100644
> --- a/include/tcg/tcg-op-def.h.inc
> +++ b/include/tcg/tcg-op-def.h.inc
> @@ -7,3 +7,4 @@ DEF1(discard, TCGV)
>  DEF2(mov, TCGV, TCGV)
>  DEF2(movi, TCGV, TINT)
>  DEF3(sub, TCGV, TCGV, TCGV)
> +DEF3(subi, TCGV, TCGV, TINT)
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index 2865de65d39..9bcf79ccbfc 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -399,6 +399,11 @@ void tcg_gen_sub(TCGType type, TCGTemp *dst, TCGTemp=
 *src1, TCGTemp *src2)
>      tcg_gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
>  }
>
> +void tcg_gen_subi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src=
2)
> +{
> +    tcg_gen_addi(type, dst, src1, -src2);

Double check me on this, but since src2's type changed from int32_t to
int64_t, I think this will produce a value that isn't sign-extended
for I32.

E.g. for I32 with src2 =3D=3D INT32_MIN this now produces 0x80000000
rather than the 0xffffffff80000000 the old code produced.
tcg_constant_internal() doesn't canonicalize, so we end up with an I32
constant that isn't sign-extended, which optimize.c assumes can't
happen.

Going to make a quick sweep over the rest of the series to look for
this issue specifically.

> +}
> +
>  /* 32 bit ops */
>
>  void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2)
> @@ -410,11 +415,6 @@ void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, T=
CGv_i32 arg2)
>      }
>  }
>
> -void tcg_gen_subi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
> -{
> -    tcg_gen_addi_i32(ret, arg1, -arg2);
> -}
> -
>  void tcg_gen_neg_i32(TCGv_i32 ret, TCGv_i32 arg)
>  {
>      tcg_gen_op2_i32(INDEX_op_neg, ret, arg);
> @@ -1537,11 +1537,6 @@ void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1,=
 TCGv_i64 arg2)
>      }
>  }
>
> -void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
> -{
> -    tcg_gen_addi_i64(ret, arg1, -arg2);
> -}
> -
>  void tcg_gen_neg_i64(TCGv_i64 ret, TCGv_i64 arg)
>  {
>      tcg_gen_op2_i64(INDEX_op_neg, ret, arg);
> --
> 2.53.0
>


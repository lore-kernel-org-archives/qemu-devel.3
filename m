Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ECC6C5DF85
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 16:11:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwirt-0008GU-45; Wed, 19 Aug 2026 12:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wwirr-0008Fy-Kl
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 12:10:19 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wwirp-0000oJ-Uu
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 12:10:19 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-38dfe910e9dso1473618a91.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 09:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1787155816; x=1787760616; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=N5k8iI9ddDwB1USK9A9PV/6m61r1JqDVegOl0mOVc3M=;
 b=f2ZLkT0QWKf2p2Ln9SbqVctibxyFXeDDOEfp0kdtGIQ0lcaS39Ie+lRVRACbTDEUpw
 H7tEucR+IfbGlPVLuQEETYBjs3Tl3PLvZ725fx1k0yBew5hoFvocoQeX/DsGQvj9N3eF
 RM6lpWRuzTNQfcSZRZEMbiSukpALRmbL0rYIRVilp9S9VYT/eZVnUEVBOMcSEjP4fTfY
 1hj0C5w0IxbvUx0pigEVHk0bo3y4aB9Y4ah/rbAshNzOdse0j0ZrGtrpKSekV/fmnSYc
 apPyQTY1gGcmNGrYRuV9OOyJNWDpOAMgLeiwjApJVtniJdoeUaTQnFM8nwbZreLq88X8
 lQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787155816; x=1787760616;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N5k8iI9ddDwB1USK9A9PV/6m61r1JqDVegOl0mOVc3M=;
 b=ohUnqwkrLRFxRm9ma0c+17MnOQ94SGrcQoMW44vbcjskivvcuwa+xCyiiDmCob/tvH
 wIcB/omI/mTHLifodVaUceksAiuzAgU4JyKa6/rrZvxDEUTkDRaSI67qpkorqMpwn6pl
 +GKyQW/Edp0MywV2MLzoGeDIrRP6oZGV6kz9tuhyCDjhXCiVJZ0eCo8O9tHgOOeXsFF3
 xJdUu1FP7GZTFbnwl/ioaF50wXDO3u+7lk45w14YbwIq0IF5MAwm1kz5HSbZkY53sD1H
 KX0fUvVmfLirIhS41wLq3GdGb35dvg2vQs/waQu/gCk1AqVjo9v8hmXq2Box07fz5AP6
 Vxxw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq9h9tonw0D7IFp98I6Y8tRt1aU/OzKT1Yf1Ntd9m3AeaWtewcCrRI3YTN80NoQKWJEiB3ItAx7Hns6@nongnu.org
X-Gm-Message-State: AFuF++mPPbbcDQHstn4W3sM2JRltVt/XT0w/t9uC1AAimIkxvDIxEd9F
 6Z0+QFo9yCBo3GRH1NSPNISoUIcop//OnAg9N7HpNJ7WNqKy34aa9eHB6onud8Rg7xk=
X-Gm-Gg: AR+sD13bbGrXviSJAfAPosABROcXZr+vBkVIYsV6EcNtcjNWcSTKzvnBufsLJ8Yn2Vx
 cn0Cyjs2+7/u3/ZSscXPGRjPSy+EdEXjCBGzHigtu4rbUUkmRMS26riW4BovzoxUFAceBThm4IW
 NNRka0qpT53E3poIk9HSBSzebNu3cePUkUwTdwEmj3n1P6BJc3Fd0wNeBMVT59yeHHlXkZSaAVU
 ksKfWIoNgwLUuDvgUb+9KByz/yENNt6PZRcri5wNLZytcJK2lxxh4uNWy+J/hgJpRhCi5v0Ezg9
 vk5JHrgY/rVK41wbhGD0q8x8nHpWUYMcCk/4lVeaL9SAYwAUXMUhpcWVQIICXSelLvitD8phGrg
 +FM3ZB2SXBrcTIIfGsrbQuY8rGciEXV/YJX6m9lBg8y7eU4XrJtT+bajF/qTACCZhWEVLbzLCH6
 dkjTKeJAnYZeafkPI5ox1qaK67UcK8RCIEBSR8qGahOvPFinwIo5QZUVXhX6IPRX1g0kjXzCjwm
 pXXfLVO99+EpcsJvfAYEMPCltvDYhD96WI=
X-Received: by 2002:a17:90b:2792:b0:395:5404:95 with SMTP id
 98e67ed59e1d1-3958108bb19mr12077549a91.12.1787155815880; 
 Wed, 19 Aug 2026 09:10:15 -0700 (PDT)
Received: from sifive.com ([136.226.240.165]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3957fb304easm3070184a91.14.2026.08.19.09.10.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 09:10:15 -0700 (PDT)
Date: Thu, 20 Aug 2026 00:10:11 +0800
From: Max Chou <max.chou@sifive.com>
To: Molly Chen <xiaoou@iscas.ac.cn>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 06/18] target/riscv: Add packed SIMD shift instructions
Message-ID: <aoXO5KIBKDQZSdd4@sifive.com>
References: <cover.1784280142.git.xiaoou@iscas.ac.cn>
 <193352ab49c6febc51250ececb4c431ffa165be6.1784280142.git.xiaoou@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <193352ab49c6febc51250ececb4c431ffa165be6.1784280142.git.xiaoou@iscas.ac.cn>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2026-07-17 10:06, Molly Chen wrote:
> Signed-off-by: Molly Chen <xiaoou@iscas.ac.cn>
> ---
>  target/riscv/helper.h                       |  43 ++++++
>  target/riscv/insn32.decode                  |  57 ++++++++
>  target/riscv/tcg/insn_trans/trans_rvp.c.inc |  43 ++++++
>  target/riscv/tcg/psimd_helper.c             | 149 ++++++++++++++++++++
>  4 files changed, 292 insertions(+)
...
> diff --git a/target/riscv/tcg/psimd_helper.c b/target/riscv/tcg/psimd_helper.c
> index 034afe5a054..8b106a336f5 100644
> --- a/target/riscv/tcg/psimd_helper.c
> +++ b/target/riscv/tcg/psimd_helper.c
> @@ -1903,3 +1903,152 @@ GEN_PSIMD_BINOP(mslt, uint32_t, int32_t, uint32_t,
>  GEN_PSIMD_BINOP(msltu, uint32_t, uint32_t, uint32_t,
>                  EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_LT_MASK)
>  
> +/* Shift operations (immediate and register) */
> +
> +GEN_PSIMD_SHIFTOP(pslli_b, target_ulong, uint8_t, uint8_t,
> +                  EXTRACT8, INSERT8, ELEMS_B, 0x07, PSIMD_DO_SLL)
> +GEN_PSIMD_SHIFTOP(psll_bs, target_ulong, uint8_t, uint8_t,
> +                  EXTRACT8, INSERT8, ELEMS_B, 0x07, PSIMD_DO_SLL)

The spec instead specifies a uniform 5-bit mask (shamt = X[rs2][4:0]),
regardless of element width.
So the SHMASK should be 0x1f for PSLL/PSRL/PSRA.[BS|HS] instructions.

...

> +
> +/**
> + * SSHAR - 32-bit scalar variable shift with rounding and saturation
> + */
> +uint32_t HELPER(sshar)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
> +{
> +    int32_t a = (int32_t)rs1;
> +    int8_t shamt = (int8_t)(rs2 & 0xFF);
> +    int sat = 0;
> +    int32_t res;
> +
> +    if (shamt >= 0) {
> +        int64_t shifted = (int64_t)a << shamt;
> +        res = signed_saturate_w(shifted, &sat);
> +    } else {
> +        int right = -shamt;
> +        if (right >= 32) {
> +            res = (a < 0) ? -1 : 0;

According to the p ext isa spec, SSHAR here extracts a sign-filled
33-bit value and then applies RNU rounding. The result here should be
0 for both positive and negative inputs.

> +        } else {
> +            int64_t rounded = ((a >> (right - 1)) + 1) >> 1;

Here may has undefined behavior for negative sources at in-range
amounts.

I think that we could extract the SSHAR implementation from
GEN_PSIMD_VAR_SSHAR and share it between here and
GEN_PSIMD_VAR_SSHAR.

rnax


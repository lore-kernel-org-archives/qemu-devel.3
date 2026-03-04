Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E98EF8FF3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 15:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxnlW-0007OU-Vl; Wed, 04 Mar 2026 10:03:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vxnlV-0007O2-5u
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 10:03:57 -0500
Received: from mail-dy1-x1343.google.com ([2607:f8b0:4864:20::1343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vxnlT-0000Uy-LI
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 10:03:56 -0500
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-2be1c918173so4614251eec.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 07:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772636634; x=1773241434; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=z5U3y46cZE2cVLyZII62rbXxhZstPWKPz5R4EPI7AWo=;
 b=AEc75vSt4+dtxl+7CSp/6neb8Jy64AEXXdd/x20cYU9C383/WS5n9tCeeA7XnbTNGk
 Ye/J9xvuxZNpO+BXvzvhRq+lX7eMg1tKU0OcVUUordcxDPkHzHj8jkzcPb89PkjW5yoY
 M/xTwEYhLF0fSYTUwJuYbPpjlPxT7yDFCcc1/jwtlb8jAnd/pN0V67iKa1mFgtZe1WNI
 tEfqhGODESVBqfGUaCdfkmdMfAya2y/3mgtiZrLm9/Y1ZjvX9H76UNh6T5qX1lB2M7Wn
 qG41saBdXlPQrBNW5U18OFexpRDb9BV5C+flDrOaCUs/T8Fq7YLi536DpsTOGT7qDvR6
 +G9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772636634; x=1773241434;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z5U3y46cZE2cVLyZII62rbXxhZstPWKPz5R4EPI7AWo=;
 b=BHpc2PZvSYGre5QbJOTJNu19Tt7p18vpsf6MaTtmbqvJr6r9oqrdI1ToxDa0njiFmb
 1gDX/K6rJgbbJrQVV4iEf0/o3tTy4OhLRsjVw3U/vnUdZfvxOz4a1GMl8lQwjsGLC6se
 uQ7pzQ6nboawY1gW9ztA8A58lX8dH5kDofy6sBY8vN7Wir6boybLzK521qJ5sxElfLF4
 yByJd2c9EBMphR7DVgywiSwE9n4KaKg1Clu6nMO7VqxD9sBR33Fk4v5zZyAmwRcRV1g9
 8qLF2mLGXucVcktPpuDnP94B9jryCDcY1o3xK+LkW+RX9XHpfCqoReCuxXM8rbjHyUzk
 I5ww==
X-Gm-Message-State: AOJu0Yy3LW+4KFo4qOcZFhnWcs3dfgOvdDHpNLjdJtlk3DsJ2JcvXKGW
 j5f4TXnVIUSpymbwADCREMxCfH2yD5PshP38KHrWIuecMJLM1xg8oGO9
X-Gm-Gg: ATEYQzzgNEW0A2ZUPk747J2jY21laV4PtFBcNn82LphcC8CJRfH7VztXkxAVwssJWMi
 VupS31Gw4wdmLzBZ5x82u/lA3ULLtijRyCcV7Yx3C37WUXZYLF6YW40fRc0BU3NBQ4sIAzoUDkM
 q3wKn3GrqjQwRsDtdQPygIqCcsvaILLqblYHh3z2sqECP0vgoXvAKKP3b3foApUckooATWoTIcQ
 xWLLalPlJI1w5PscM9Pafn94cOYAtePQWvyfspocsQgI+volUEeScA9NXj4SRd8+on+RcYYDzOP
 JgiTswRmi4lAS22mPo7KuWoRwd/cBxj2Nla0gmqdw+RMwYRBcu12I8u4xgywnTLv38RSSlZoLAJ
 qDThV7oFfS61WkVB8VjzgM3Q06eaU2DG3BOIuj/T1EFseWN/IK5Vd/o8VH8rZQ10aUHlcdy7Vmo
 onBTwd8yk1jJCzL8Sq2ZkuaZK9Dn9QXTuG2xmJBaGoN+YNAvkTkVpfzvr3fpWvlu8L6gMRLWmcH
 zFQsy8ZQxTFvq19/fkZBlOUAQ8QfaK+4CR9Zu7hkQ==
X-Received: by 2002:a05:7300:1495:b0:2b8:4c95:365d with SMTP id
 5a478bee46e88-2be30fd0f16mr1003061eec.10.1772636632574; 
 Wed, 04 Mar 2026 07:03:52 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be0d7e0d40sm8037197eec.12.2026.03.04.07.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 07:03:52 -0800 (PST)
Date: Wed, 4 Mar 2026 23:03:26 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v4 05/14] target/riscv: rvv: Make vfncvtbf16.f.f.w
 support BF16 to OFP8 conversion for Zvfofp8min extension
Message-ID: <aahJmqBQOQlTX_HJ@ZEVORN-PC.localdomain>
References: <20260304134006.2908449-1-max.chou@sifive.com>
 <20260304134006.2908449-6-max.chou@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304134006.2908449-6-max.chou@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1343;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1343.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Mar 04, 2026 at 09:39:57PM +0800, Max Chou wrote:
> According to the Zvfofp8min extension, the vfncvtbf16.f.f.w instruction
> supports BF16 to OFP8 conversion without satuation when SEW is 8.
"satuation" should be "saturation".

Thanks,
Chao
> And the VTYPE.altfmt field is used to select the OFP8 format.
> * altfmt = 0: BF16 to OFP8.e4m3
> * altfmt = 1: BF16 to OFP8.e5m2
> 
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>  target/riscv/insn_trans/trans_rvbf16.c.inc | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/target/riscv/insn_trans/trans_rvbf16.c.inc b/target/riscv/insn_trans/trans_rvbf16.c.inc
> index 9aafd4d2ef..16f4403909 100644
> --- a/target/riscv/insn_trans/trans_rvbf16.c.inc
> +++ b/target/riscv/insn_trans/trans_rvbf16.c.inc
> @@ -67,11 +67,20 @@ static bool trans_fcvt_s_bf16(DisasContext *ctx, arg_fcvt_s_bf16 *a)
>  static bool trans_vfncvtbf16_f_f_w(DisasContext *ctx, arg_vfncvtbf16_f_f_w *a)
>  {
>      REQUIRE_FPU;
> -    REQUIRE_ZVFBFMIN(ctx);
>  
> -    if (opfv_narrow_check(ctx, a) && (ctx->sew == MO_16)) {
> +    if (opfv_narrow_check(ctx, a) &&
> +        ((ctx->sew == MO_16 && ctx->cfg_ptr->ext_zvfbfmin) ||
> +         (ctx->sew == MO_8 && ctx->cfg_ptr->ext_zvfofp8min))) {
> +        gen_helper_gvec_3_ptr *fn;
>          uint32_t data = 0;
>  
> +        if (ctx->sew == MO_16) {
> +            fn = gen_helper_vfncvtbf16_f_f_w;
> +        } else {
> +            fn = ctx->altfmt ? gen_helper_vfncvtbf16_f_f_w_ofp8e5m2 :
> +                               gen_helper_vfncvtbf16_f_f_w_ofp8e4m3;
> +        }
> +
>          gen_set_rm_chkfrm(ctx, RISCV_FRM_DYN);
>  
>          data = FIELD_DP32(data, VDATA, VM, a->vm);
> @@ -81,8 +90,7 @@ static bool trans_vfncvtbf16_f_f_w(DisasContext *ctx, arg_vfncvtbf16_f_f_w *a)
>          tcg_gen_gvec_3_ptr(vreg_ofs(ctx, a->rd), vreg_ofs(ctx, 0),
>                             vreg_ofs(ctx, a->rs2), tcg_env,
>                             ctx->cfg_ptr->vlenb,
> -                           ctx->cfg_ptr->vlenb, data,
> -                           gen_helper_vfncvtbf16_f_f_w);
> +                           ctx->cfg_ptr->vlenb, data, fn);
>          finalize_rvv_inst(ctx);
>          return true;
>      }
> -- 
> 2.52.0
> 


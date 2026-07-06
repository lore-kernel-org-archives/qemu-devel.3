Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B08AFC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 05:01:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgbRk-00005V-QI; Mon, 06 Jul 2026 01:00:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wgbRY-0008WT-Aa
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 01:00:33 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wgbRW-0001km-4r
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 01:00:32 -0400
Received: by mail-pg1-x544.google.com with SMTP id
 41be03b00d2f7-c9e607d81fcso1297744a12.2
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 22:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783314028; x=1783918828; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CH9zxXaJecOaIafp6Y6g5MamIPgX8tEUj6zW19omUb8=;
 b=DVlPfhyMEvbniFeXKopU6zglyD9GbVgStVXNK6RxwoXjheNkYuCFWgEPgEND8PuPYQ
 KJkLkoKCE2cgqnEzdcPqDEh1H+P39RsmZ70Q05Ptcj+QAXw6j0Y+YPeizM4GrDRR6brE
 sD1+mjA4IUZ3D7rBxTmzBL1TJ8gHpeyJUhshiYQEot7ispBiE0TR3JPBYDirmX6up6F3
 TXMOmZqeVGmD7Q0Xx94SvkBUEZCpYKoqX54dLsh4BkqTaW2p81Q6NykcgNJoGzPRHCJJ
 heA/GFWn/ajfmUy4cajCt0WdzC+B+S2pd+U00KubqfOP524gGhk1nqkfF64THhep3K3r
 stAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783314028; x=1783918828;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CH9zxXaJecOaIafp6Y6g5MamIPgX8tEUj6zW19omUb8=;
 b=e3tOiABmOS4lgn2D/S1Y/g7r6QL7slq+J6JBB9EVv9X10JFeisnEvFvw+r1N7d3HQ3
 cWXAkcoXlY9teChmN7twoD1+IIJ+4KE+1rhsGBVqvU5pFemBWawh3kY2wA7KNTO1qOqZ
 QEHHoZ7jC0NaqIenJGua5jDPjvQt+XyItNIEWO1cmq+y3HSy45IJdUnAWBEy2ocZgYCQ
 Ktzy2gp4Gh0HQrerZxtNHTdKjM2OibiP7J4H3I+j6Mb4gpekwaGIqgENZI1kxt1ZAJ4x
 GOlMK2JrTQaQ1nwMv6Nf47Gr1AkhXA8fcxw0kclObD256GOYAX8Eqs/yAcj0R96130AJ
 F7dQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpi/ZWgi528cuQQJFgJsQZweut7u6JG2/2KltZb4M0/+vRr1Dnk5/WiKQp1QybCzMlhduSiOX3taMVo@nongnu.org
X-Gm-Message-State: AOJu0YwTI7Ob64q7EVArmmhq4DWh3C073vvgkosKltM6JeVDrkdP2kkm
 KeynvoTfbVMn23L52Hf+hLDU5HYAZUzN/r3KJ5aqfgMBCxRM4HGODjVp
X-Gm-Gg: AfdE7cl85XO97YBRToZlRmu+r3gWnV5xc9g9mtTcL9nGiw2dnjolMHEf53a+GVlAQt8
 /192aexgQR5rCBOD7EV8WSiq/49X+dQwwQvfV/WmMsJVlJTZYmWuX4Eg8RxdD0El7va1ujpu/rh
 XlOKNjqT1H520svham/tbtHrfxgJCP03V3mOph6aMoc9qhpJ3XkgNdJ4fVMCRa2aMKmXKg0Lmu3
 P1/C6mnEpB/7770fZ/XGeEKMHc7B7YaFkkDmrVyGQZUpNPSVUdzMVqebmgRbbF4yRZl0Mdg1+7p
 lU7JJMvHpILhTIvTjvLwblZj3lc/2Dhjiictq4ZGFhHPvCDAaXo5DzyS+u/f7VtLdIhITcnRGn8
 F2TcnXtC/quXEVj5sAuG7rV/z0YrfLKWEsHtk39RQpNfPhfM7fjzV5OgaEadyBi5TLKVDmhJhL0
 CW0DpaoYR9cPgUpFvmCT6ey3Juk+dlmtque1pN5XzdaRguHqzV7qqnvKtlRkk=
X-Received: by 2002:a05:6a21:32a3:b0:3b4:b24e:27b4 with SMTP id
 adf61e73a8af0-3c03e1ff0b4mr10957041637.1.1783314027728; 
 Sun, 05 Jul 2026 22:00:27 -0700 (PDT)
Received: from localhost ([64.186.250.142]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f1cbfc285sm38937415eec.5.2026.07.05.22.00.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 22:00:27 -0700 (PDT)
Date: Mon, 6 Jul 2026 13:00:24 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, bin.meng@windriver.com,
 vivahavey@gmail.com, 
 Alvin Chang <alvinga@andestech.com>, Yu-Ming Chang <yumin686@andestech.com>, 
 Joel Stanley <joel@jms.id.au>
Subject: Re: [RFC PATCH 04/25] target/riscv/debug: Fix icount trigger
 privilege check
Message-ID: <aksuyTm7d3N7URTj@ChaodeMacBook-Pro.local>
References: <20260114044701.1173347-1-npiggin@gmail.com>
 <20260114044701.1173347-5-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114044701.1173347-5-npiggin@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pg1-x544.google.com
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

On Wed, Jan 14, 2026 at 02:46:37PM +0800, Nicholas Piggin wrote:
> The check_itrigger_priv() did not check privilege bits properly. Move
> all priv checks into functions and have the icount check follow the same
> form as the others.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  target/riscv/debug.c | 82 ++++++++++++++++++++------------------------
>  1 file changed, 37 insertions(+), 45 deletions(-)
> 
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index c92bd9860e..2effbb49af 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -306,48 +306,50 @@ static void do_trigger_action(CPURISCVState *env, target_ulong trigger_index)
>   * Check the privilege level of specific trigger matches CPU's current privilege
>   * level.
>   */
> +static bool type2_priv_match(CPURISCVState *env, target_ulong tdata1)
> +{
> +    /* type 2 trigger cannot be fired in VU/VS mode */
> +    if (env->virt_enabled) {
> +        return false;
> +    }
> +    /* check U/S/M bit against current privilege level */
> +    return (((tdata1 >> 3) & 0b1011) & BIT(env->priv));
> +}
> +
> +static bool type6_priv_match(CPURISCVState *env, target_ulong tdata1)
> +{
> +    if (env->virt_enabled) {
> +        /* check VU/VS bit against current privilege level */
> +        return (((tdata1 >> 23) & 0b11) & BIT(env->priv));
> +    } else {
> +        /* check U/S/M bit against current privilege level */
> +        return (((tdata1 >> 3) & 0b1011) & BIT(env->priv));
> +    }
> +}
The new logic looks correct to me, but now it uses open-coded shifts
and masks to check the privilege bits.

Since we already have these bits defined in debug.h, like `TYPE2_U/S/M`,
`TYPE6_VU/VS/U/S/M` and `ITRIGGER_VU/VS/U/S/M`, I think it would be
better to use those masks through a small helper instead of spelling
out `>> 3`, `>> 6`, `>> 23` and `0b1011` here.

That would make the code easier to read and maintain later.

like:

```
static bool trigger_priv_bit_match(target_ulong tdata1,
                                   target_ulong u_mask,
                                   target_ulong s_mask,
                                   target_ulong m_mask,
                                   target_ulong priv)
{
    switch (priv) {
    case PRV_U:
        return (tdata1 & u_mask) != 0;
    case PRV_S:
        return (tdata1 & s_mask) != 0;
    case PRV_M:
        return (tdata1 & m_mask) != 0;
    default:
        g_assert_not_reached();
    }
}

static bool trigger_vpriv_bit_match(target_ulong tdata1,
                                    target_ulong vu_mask,
                                    target_ulong vs_mask,
                                    target_ulong priv)
{
    switch (priv) {
    case PRV_U:
        return (tdata1 & vu_mask) != 0;
    case PRV_S:
        return (tdata1 & vs_mask) != 0;
    default:
        return false;
    }
}
```

So we can call it this way:

```
static bool type2_priv_match(CPURISCVState *env, target_ulong tdata1)
{
    /* type 2 trigger cannot be fired in VU/VS mode */
    if (env->virt_enabled) {
        return false;
    }

    return trigger_priv_bit_match(tdata1, TYPE2_U, TYPE2_S, TYPE2_M,
                                  env->priv);
}

static bool type6_priv_match(CPURISCVState *env, target_ulong tdata1)
{
    if (env->virt_enabled) {
        return trigger_vpriv_bit_match(tdata1, TYPE6_VU, TYPE6_VS,
                                       env->priv);
    }

    return trigger_priv_bit_match(tdata1, TYPE6_U, TYPE6_S, TYPE6_M,
                                  env->priv);
}

static bool icount_priv_match(CPURISCVState *env, target_ulong tdata1)
{
    if (env->virt_enabled) {
        return trigger_vpriv_bit_match(tdata1, ITRIGGER_VU, ITRIGGER_VS,
                                       env->priv);
    }

    return trigger_priv_bit_match(tdata1, ITRIGGER_U, ITRIGGER_S, ITRIGGER_M,
                                  env->priv);
}
```

And I don't mean going back to `get_field(mask) == env->priv`; that pattern
is easy to get wrong for `PRV_U == 0`. The helper should just test the mask
selected by the current privilege.

Thanks,
Chao
> +
> +static bool icount_priv_match(CPURISCVState *env, target_ulong tdata1)
> +{
> +    if (env->virt_enabled) {
> +        /* check VU/VS bit against current privilege level */
> +        return (((tdata1 >> 25) & 0b11) & BIT(env->priv));
> +    } else {
> +        /* check U/S/M bit against current privilege level */
> +        return (((tdata1 >> 6) & 0b1011) & BIT(env->priv));
> +    }
> +}
> +
>  static bool trigger_priv_match(CPURISCVState *env, trigger_type_t type,
>                                 int trigger_index)
>  {
> -    target_ulong ctrl = env->tdata1[trigger_index];
> +    target_ulong tdata1 = env->tdata1[trigger_index];
>  
>      switch (type) {
>      case TRIGGER_TYPE_AD_MATCH:
> -        /* type 2 trigger cannot be fired in VU/VS mode */
> -        if (env->virt_enabled) {
> -            return false;
> -        }
> -        /* check U/S/M bit against current privilege level */
> -        if ((ctrl >> 3) & BIT(env->priv)) {
> -            return true;
> -        }
> -        break;
> +        return type2_priv_match(env, tdata1);
>      case TRIGGER_TYPE_AD_MATCH6:
> -        if (env->virt_enabled) {
> -            /* check VU/VS bit against current privilege level */
> -            if ((ctrl >> 23) & BIT(env->priv)) {
> -                return true;
> -            }
> -        } else {
> -            /* check U/S/M bit against current privilege level */
> -            if ((ctrl >> 3) & BIT(env->priv)) {
> -                return true;
> -            }
> -        }
> -        break;
> +        return type6_priv_match(env, tdata1);
>      case TRIGGER_TYPE_INST_CNT:
> -        if (env->virt_enabled) {
> -            /* check VU/VS bit against current privilege level */
> -            if ((ctrl >> 25) & BIT(env->priv)) {
> -                return true;
> -            }
> -        } else {
> -            /* check U/S/M bit against current privilege level */
> -            if ((ctrl >> 6) & BIT(env->priv)) {
> -                return true;
> -            }
> -        }
> -        break;
> +        return icount_priv_match(env, tdata1);
>      case TRIGGER_TYPE_INT:
>      case TRIGGER_TYPE_EXCP:
>      case TRIGGER_TYPE_EXT_SRC:
> @@ -665,17 +667,7 @@ itrigger_set_count(CPURISCVState *env, int index, int value)
>  
>  static bool check_itrigger_priv(CPURISCVState *env, int index)
>  {
> -    target_ulong tdata1 = env->tdata1[index];
> -    if (env->virt_enabled) {
> -        /* check VU/VS bit against current privilege level */
> -        return (get_field(tdata1, ITRIGGER_VS) == env->priv) ||
> -               (get_field(tdata1, ITRIGGER_VU) == env->priv);
> -    } else {
> -        /* check U/S/M bit against current privilege level */
> -        return (get_field(tdata1, ITRIGGER_M) == env->priv) ||
> -               (get_field(tdata1, ITRIGGER_S) == env->priv) ||
> -               (get_field(tdata1, ITRIGGER_U) == env->priv);
> -    }
> +    return icount_priv_match(env, index);
>  }
>  
>  bool riscv_itrigger_enabled(CPURISCVState *env)
> -- 
> 2.51.0
> 
> 


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BEA10F996B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXlD-0000Nr-Hj; Wed, 08 Apr 2026 14:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wAXlB-0000M5-2T
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:36:17 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wAIze-0003RA-LH
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 22:50:16 -0400
Received: by mail-qk1-x741.google.com with SMTP id
 af79cd13be357-8cb20bcff5aso591933585a.3
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 19:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775616613; x=1776221413; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7FfSqwOf/vKCgoAQPL1Ir9xgAVPRAa4tNwXvc7lfqe4=;
 b=WKoBW+Ip/AsJzZ8RMbAs95m0l+HFJgI9o/GcxiAOQ8UKfxe1S8FyB6oxjG7XmYA1qW
 i6Fu2kMXtDKH2bUd3gB6PCwxbCwrnrJTyeoD7Nz3JYRoGvPWqZJhyEDmFCA9ACujdV/T
 CMV88Kdcicby3jQZm1zDQX++MCUFLUVlNc82mZvtYKLiAt8/hRp+rQup31o/fOuJSGSC
 C9dT+1PgZIaM2+GR0grnu9GhBOXyWNmwEqGCnI0LIEhQt0NDqtf+0nFwSfLpJ/vkTqUb
 1c/NJv1iAOfgKbXN9Zs1ysKzt03JVgHha25jPtcsHJAEhwSuosK6HGf/1raMlvdhrnDu
 JoFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775616613; x=1776221413;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7FfSqwOf/vKCgoAQPL1Ir9xgAVPRAa4tNwXvc7lfqe4=;
 b=fjvOIwLaZjeb2FjBL1SDesjgRZNyJX+19OiGoXy4YoJvhqE2hP4z+2QtZokWsgUMPH
 BsdNMErWCL5z2TaSbUhiqv2w/LrtBRB3u2KU1xEvqJ3lLQzu0EXxG8LQ75JEFj5V2/0D
 czksONscXO3rsulGZEH6wsnIGFfm1SyL+aOKqlFbd17rMs5GINUx50B2qm5U5ao1GQIj
 ZpVUIW8f+oZ9C+x8loD+R295h/mUKZQaRnvfR3pWhAdAMRhSJRActjlSj6OtTxoHzVGw
 Dw1HhOdmv0KFia07Gj4f3fsFvldcwdsY2JLSKJbEa+Meh5zBP4rT0gDsxQO118Xz11AG
 eGRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6h0dXEghpH053trOPk0m7Y0o8Y2glh6+2QuJODRDW68IzGfsCUuQIzOIsv1kc91TnV+vt3S6PiAYw@nongnu.org
X-Gm-Message-State: AOJu0Yxh5XxeaCSovRX8cDhX3eKa/EXd0uqCA1r6N/lgHWxCpkWJen9f
 AuLxUtR2E/X2aA9rTVQMGLZ6df/nuPrjuXRuiA2049FmYiJB9vPeR9OV
X-Gm-Gg: AeBDietKjU15lvoSqFdUc581b7ZbUf5MhQ5N8QiOkMUl+S935Bevrr70+GlpsoN7OvR
 msvb/dcdm8QBgb/ZQeyc04cI50aUJKdrthyX/5i3rMDjtVjR4oGOnzBm3RXag+fYp/g6i4uNWjT
 aU5yVmuyFb0Ly5G4t3TlLauW3JBT2LZ0obwMq/6lqjLpPB/FSXUoIXCG2SLdVKWY/mVpyBxdE8F
 uzOCns9BaMk6N+DqRKeWqILQH67p1lOw5VieamKB+h6ls1n2tzXy1cpsFikZT78mKbRpxDx4Yny
 KXwfip67gMRMjVELqlJDPeU2eLwRqFN0iy/iU/a7f/zZvIEP4j9+UJGNv8HX1BUFkk9XtYz4WZt
 axxviEM9b3fPMV1+6yhZHwP+lXxYCbY++Wc2gFx7UR3TR2nMHCck5IZK5yhvNem/eKWhVlcvCNw
 KOohB9NlQdF7NpgX+Sl2HmbgGrk0Z7tJ0DlLr6TWsvtRzDImXfdRBXndnckAHunrleY8EGobfA
X-Received: by 2002:a05:620a:29d4:b0:8cd:9bf2:60e8 with SMTP id
 af79cd13be357-8d41e81fbf7mr2690134385a.59.1775616612866; 
 Tue, 07 Apr 2026 19:50:12 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d5e69afdb6sm933208285a.40.2026.04.07.19.50.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 19:50:12 -0700 (PDT)
Date: Wed, 8 Apr 2026 10:49:49 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: alistair23@gmail.com
Cc: palmer@dabbelt.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 qemu-riscv@nongnu.org, 
 qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 3/5] target/riscv: Don't OR mip.SEIP when mvien is one
Message-ID: <adW2H1fSi1g_9677@ZEVORN-PC.localdomain>
References: <20260407043614.372871-1-alistair.francis@wdc.com>
 <20260407043614.372871-4-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260407043614.372871-4-alistair.francis@wdc.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::741;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-qk1-x741.google.com
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

On Tue, Apr 07, 2026 at 02:36:12PM +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> The RISC-V spec states that
> 
> """
> But when bit 9 of mvien is one, bit SEIP in mip is read-only and does
> not include the value of bit 9 of mvip. Rather, the value of mip.SEIP
> is simply the supervisor external interrupt signal from the hart’s
> external interrupt controller (APLIC or IMSIC).
> """
> 
> From my understanding this means we should remove MIP_SEIP from the
> alias mask.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2828
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/csr.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index a75281539b..2a2f9497db 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -3796,6 +3796,14 @@ static RISCVException rmw_mvip64(CPURISCVState *env, int csrno,
>          /* Remove bits that are zero in both mideleg and mvien. */
>          alias_mask &= (env->mideleg | env->mvien);
>          nalias_mask &= (env->mideleg | env->mvien);
> +    } else {
> +        if (env->mvien & MIP_SEIP) {
> +            /*
> +             * Bit SEIP in mip is read-only and does not
> +             * include the value of bit 9 of mvip
> +             */
> +            alias_mask &= ~MIP_SEIP;
This needs some discussion. I did a simple derivation of the
alias_mask initial value for bit 9 across all four combinations:

  alias_mask = ((S_MODE_INTERRUPTS | LOCAL_INTERRUPTS) &
      (env->mideleg | ~env->mvien)) | MIP_STIP;

  mideleg[9] mvien[9] | ~mvien[9] mideleg|~mvien | alias[9] nalias[9]
  ---------- -------- + --------- -------------- + -------- ---------
       0        0     |     1           1        |    1        0
       0        1     |     0           0        |    0        1
       1        0     |     1           1        |    1        0
       1        1     |     0           1        |    1        0

Checking only mvien[9]=1 actually includes two cases:
 - combo 2: mideleg=0, mvien=1
 - combo 4: mideleg=1, mvien=1

Combo 2 already has alias_mask[9]=0, so the else branch is a
no-op there. The only effective case is combo 4, where
alias_mask[9] goes from 1 to 0. But nalias_mask[9] is also 0
for combo 4, so SEIP disappears from MVIP entirely.

Per the truth table in the function header:

  mideleg[i]=1, mvien[i]=X -> mvip[i] aliases mip[i]

Is there a special intent to break this alias for SEIP? Could
you clarify?

Per the AIA spec, I think the fix should be in rmw_mip64()
instead — make mip.SEIP read-only when mvien[9]=1, similar
to how sstc makes STIP read-only:

  static RISCVException rmw_mip64(CPURISCVState *env, int csrno,
                                  uint64_t *ret_val,
                                  uint64_t new_val, uint64_t wr_mask)
  {
      uint64_t old_mip, mask = wr_mask & delegable_ints;
      uint32_t gin;

  +   /*
  +    * When mvien[9]=1, mip.SEIP is read-only and reflects only
  +    * the external interrupt signal from the interrupt controller.
  +    */
  +   if (env->mvien & MIP_SEIP) {
  +       mask &= ~MIP_SEIP;
  +   }
  +
      if (mask & MIP_SEIP) {
          env->software_seip = new_val & MIP_SEIP;
          new_val |= env->external_seip * MIP_SEIP;
      }
      ...

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao
> +        }
>      }
>  
>      /*
> -- 
> 2.53.0
> 


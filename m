Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2067AC88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 09:32:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6PWE-0003fV-CT; Tue, 15 Sep 2026 05:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1x6PW5-0003eq-Th
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 05:31:55 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1x6PW4-0001Ss-AY
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 05:31:53 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc4cdc0d663so32793a12.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 02:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1789464710; x=1790069510; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TUBN0s7qDBNrqjic8a+/7xYR5JVbaPpd9amBBDddmvI=;
 b=kbgxagyzSuFjjrMIIaOIY5IlYr/GxtxqhSSe5GnnqX6Cd0waNpbJdJaAmjSxQsmfpV
 nH4InTDIFa2CwtRPJhbh7nyS2+xVcGwsmI5uuHoIa4yM2id+gBSQD32sNsM+SnQpAcUK
 7UyvROLYvtIKtpYXaQ9u/4ikZtgV82xpZe0PiE/uHtYVRirm9X4gna4wp8xLsnzjB2Vk
 JppRSqcb+lMcK5MeG/teXbD/fNs9s/o1mw96elIlDdXTnEFQxBY/17OY73KxtST77EKB
 O3gQRYJFp0sV7TeHASpAg+/gDX6uhl8lbrjH18w7Pua1ijl1+Ws5cZgcGAyTPwESgsPL
 S74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789464710; x=1790069510;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TUBN0s7qDBNrqjic8a+/7xYR5JVbaPpd9amBBDddmvI=;
 b=o+vG/59TDIvHRGU0NvXe747Z5VvP6zcZQcW5ASroUEEzpQM9zukSfnSd/4ouXVzi21
 Fd8Gb4XI+GjvxEggCxNVUDzPRHdFhEkEkYS2/FE2nFGzlqoESI5uV8rtF91Ct5iek85E
 HYve1QezLFTadS2Huh91uLADsB54vikEXoD9VxR7uz5n3YdhodAgPZklYn8MNmpFdylK
 01o538Mda3HzIzcF8VyZr2/1NiykXFNb4OCPxlBshM74jMVYhFXOnZqfwLc+8DrK9qPr
 JLa86grRBIIRyF/lF24NSFXG6JS6STRH+rONXjuUoPYldZ9Y3+e57Zgr1kdaw4/9e9k1
 iYiw==
X-Gm-Message-State: AFuF++mXcF0bwEomOH0CxulCA/hygkBZcJBFEdJjB7I4HCiPNCGQpV4u
 xc0I/+1SJWBdozHjCDqgNeiD9883RBp8fTj+1lfaiegVZqWE/FvkmcLy5d6GplyLHBY=
X-Gm-Gg: AYBFou25AzYQ9YrTXGd6mbYLLT9M2RTdwSUkmL/Uc6vNvCHQ/ecyw5sDY5Ae8bT7nEz
 li53IlzpSk8l/oKKPkL700LA4lJr3Y3O1gaAF+YVw+bSN00SdfWgtXfK3f/26O4xwwDIxy5FgSq
 RjGa1Ovi9HQ4OUbG6dAjmiDwo+Zwzuji8KCIs8ORbd38Msx0kpEo0A56IM21MOGbHsdlpKg4juv
 JC5cUCoDcFHeHIwWhBehYIaVXXmjpluEqjuBuFBQDWIFY7XVZBu5zpBMfGDlDC1qNv7prUjdmpz
 ji37tUNzZ6CjvGmjCG+eoBrKpqF4GmqX02kmO8EfHTQdGX+MLvrWaQDtDxf/5dqlFrXhsiq5wsQ
 3sb4d6/NelM5dWzqdUKYsz2rKfxFHdAuE6krKucyxwX1lvbDe7O2viDpkrmzPcqgG0wGt0pYPGO
 H+TYbtrPSI6JUDyuUd8aYP+jaEfGk7PoEfMXzp2wLPBRRvdN5KeN/eLbX21z6HB6OgDe/Ic/IFB
 hBpS64Gbm1JjTUVYjxM3aJJA20AP/I5BtsNGerlrX+1
X-Received: by 2002:a17:90b:164f:b0:398:c3ca:1ebc with SMTP id
 98e67ed59e1d1-39e1103fe18mr128823a91.18.1789464710476; 
 Tue, 15 Sep 2026 02:31:50 -0700 (PDT)
Received: from sifive.com ([136.226.240.165]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39dfdd58af8sm4154361a91.12.2026.09.15.02.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 02:31:50 -0700 (PDT)
Date: Tue, 15 Sep 2026 17:31:45 +0800
From: Max Chou <max.chou@sifive.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: Re: [PATCH] tcg/riscv64: Set vtype before whole-register vector moves
Message-ID: <aqkL1X-VcAOkPZLr@sifive.com>
References: <20260903170011.3627720-1-max.chou@sifive.com>
 <784414c5-0e93-442e-844e-79c648964a92@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <784414c5-0e93-442e-844e-79c648964a92@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=max.chou@sifive.com; helo=mail-pz2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2026-09-10 12:11, Richard Henderson wrote:
> On 9/3/26 07:00, Max Chou wrote:
> > According to the RISC-V unpriviledge spec,
> >    "vset{i}vl{i} and whole register loads and stores do not depend upon
> >     vtype."
> > The whole-register vector move instructions reuqire legal vtype that
> > trap when VILL is set.
> > 
> > The tcg_out_mov in tcg/riscv64 missed the vtype setup before emitting the
> > OPC_VMVNR_V.
> > 
> > Fixes: d4be6ee1111 ("tcg/riscv: Implement vector mov/dup{m/i}")
> > Signed-off-by: Max Chou <max.chou@sifive.com>
> > ---
> >   tcg/riscv64/tcg-target.c.inc | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
> > index 2ce9d47a633..fbfb4c44470 100644
> > --- a/tcg/riscv64/tcg-target.c.inc
> > +++ b/tcg/riscv64/tcg-target.c.inc
> > @@ -778,6 +778,8 @@ static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
> >           {
> >               int lmul = type - riscv_lg2_vlenb;
> >               int nf = 1 << MAX(lmul, 0);
> > +
> > +            set_vtype_len(s, type);
> >               tcg_out_opc_vi(s, OPC_VMVNR_V, ret, arg, nf - 1);
> >           }
> >           break;
> 
> If I understand correctly, this happens when vtype is completely unset, such
> as the first use within the TB, or call-clobbered after a helper.
> 
> We don't actually need @type, just not the "uninitialized" type,
> TCG_TYPE_COUNT, per init_setting_vtype.
> 

Hi Richard,

Thanks for the suggestion. Will send v2 for this part.

> That you encountered a reg-reg move in such a situation makes me wonder if
> we have failed to correctly mark all of these vector registers
> call-clobbered?

I just checked the tcg_target_init to confirm that all the vector
registers (v0-v31) are marked call-clobbered.

rnax

> 
> 
> r~


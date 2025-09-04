Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40272CA1014
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 05:06:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu2AW-00073s-VM; Thu, 04 Sep 2025 01:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uu2AU-00071b-AB; Thu, 04 Sep 2025 01:05:54 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uu2AR-0000Ye-Tb; Thu, 04 Sep 2025 01:05:54 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-772301f8a4cso904150b3a.3; 
 Wed, 03 Sep 2025 22:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756962350; x=1757567150; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1707WDvxHrj3Yafw6elzRzsB3loZXulJhOUZqizDVZY=;
 b=GjId3EnBfwmkDbWUVHza5284koNbTQWIZKfCWLknYBeLMyi6ouP5i6/OhDNTzKAQ4E
 mtVtehvJTk7kMIvmso50QqRAaovpvtF17Gx5gD5IS7ACnSXkNddZgWiT5cd6EiekFwjQ
 X9/+jyJeRqJ/qgv9cLswOj9VXJHaHs/pkarH3Nd0eMqOgu4cxtlfw7Jqwst3XsaU3rvR
 fvp92EqEA4/q+zL4zFXBBGX7a+zuJEbXygbYrDx/lrnnKMwF6sFtJkYresc9ZAyWG92O
 LFrHfp3bHf4wzL+Hm32ANOxMyDRJ6KxwWPgbmmsiJvU+alrK9hT1jITFV5gv0svLYglf
 zd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756962350; x=1757567150;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1707WDvxHrj3Yafw6elzRzsB3loZXulJhOUZqizDVZY=;
 b=Z6ejjFgKHQXeTjPRI6JRKoG5a6S48TCidc+G7TplBaqlbhC7oM06hOWKBBHMAv3sGK
 QpkjNytiPTFFKXnssGyskJoVLoYuNSRch6Y2GV4vfI1CjxaRCfhZLhT0wK64g39qlLNB
 TNtGIEWk2uemmMPqpMFH+/HspYXCm/wsTW3afdCIZus+7OrErFTVRTGiYWZnsyEJkXa4
 uU+d3Jbto9TbwDkivlD8NQTu4NRce/rnJIMM34fekhCFQfRYSFZg1IJ4q7oD9suMsL3v
 NMvf7tdgyvm2TonDtUsRsxk6gc+qXwV9iwum8/30rVbc+m6ZFDXV5v/12E3sGH2f9/bd
 XZHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/0kjN3jGjA+MowtSngZ3gMCSz7qjMwb9qjn9HPhGL3MqT4Ic8OsMMoGDMmYzppMqlDQvht1H7v3U/pg==@nongnu.org,
 AJvYcCXVMWz9opbYfcc7QrXfgGaHaVy+LUIFXw7ef2reNM7VSkJfIKdDpfigkmO5HC8J6aEwZOg0yoHvP6so@nongnu.org
X-Gm-Message-State: AOJu0YxL6bScYpHEFai4cDEtylatDivsKDJwHbKF5h9TUq3Dbc25N1Cm
 RMMeloGMGtagiLHSVldBdTju7VPqZeVgMn3Nzk0gszGlwreIu6kWKAr2U4deFg==
X-Gm-Gg: ASbGncuFkDFMKG2g4oMe6z4S+VxewF58A71TSMG5DJu3ODernBpls6zb0vmbSOlfkdY
 IXD2MESPjToE8L9o32x1R3/i3QnhnxXnwRdq1+Q6sC2GnbEprpW1g+eSmtKfQSMi9xdx/954aTl
 CvOLocKVwQab5yPF/Rh3mf0czMvC14vgYVNbw/nUnQRetGG8yl33AxD1qXiQChf5pYBa8UTUJ3k
 W/4GbgzFyEoC5cfeIMYKsv/1K2IIOQRRYU7Wq/89c1ldumzcwwB4JkuTBVT8lCnm1etJMXPmflV
 uHZxz42L0TyZyLBZB2t9UfftPWkVXgUwtCSPpIqoFi3ghHINHFjCskBIxTiEiXVN399P0sGcTsD
 WOyXpQARh7E3UYvx7Etbi6tSWCEiiX2PSzI19pOcZVJmnTjO20mKeu2dW5JWih+C2/SttfLCRRj
 7UGlmTEmw/wg==
X-Google-Smtp-Source: AGHT+IFKykp/Uu1/kjW728DrAuoW/Pb/VLibVj5h0TvkVoFfIAAsUlRor90MSuHaofnqGBDxzcoGFQ==
X-Received: by 2002:a05:6a20:7284:b0:243:be7c:2d63 with SMTP id
 adf61e73a8af0-243d6f3937cmr26197168637.42.1756962349782; 
 Wed, 03 Sep 2025 22:05:49 -0700 (PDT)
Received: from localhost (123.253.189.97.qld.leaptel.network. [123.253.189.97])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-3298520c7d0sm12794197a91.3.2025.09.03.22.05.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 22:05:49 -0700 (PDT)
Date: Thu, 4 Sep 2025 15:05:46 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Chao Liu <chao.liu@zevorn.cn>
Cc: richard.henderson@linaro.org, paolo.savini@embecosm.com, 
 ebiggers@kernel.org, dbarboza@ventanamicro.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Chao Liu <chao.liu@yeah.net>
Subject: Re: [PATCH v6 1/2] target/riscv: Generate strided vector
 loads/stores with tcg nodes.
Message-ID: <eimd6dqomns6jqkh4rnma42lxlzlroyibbgm32yb7oztljensy@gw4u4flnwpwo>
References: <cover.1756906528.git.chao.liu@zevorn.cn>
 <bcb383174cf82be8116685273e271cdbdda28a59.1756906528.git.chao.liu@zevorn.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcb383174cf82be8116685273e271cdbdda28a59.1756906528.git.chao.liu@zevorn.cn>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Sep 03, 2025 at 09:52:01PM +0800, Chao Liu wrote:
> From: Chao Liu <chao.liu@yeah.net>

> +static void gen_ldst_stride_main_loop(DisasContext *s, TCGv dest, uint32_t rs1,
> +                                      uint32_t rs2, uint32_t vm, uint32_t nf,
> +                                      gen_tl_ldst *ld_fn, gen_tl_ldst *st_fn,
> +                                      bool is_load)
> +{
> +    TCGv addr = tcg_temp_new();
> +    TCGv base = get_gpr(s, rs1, EXT_NONE);
> +    TCGv stride = get_gpr(s, rs2, EXT_NONE);
> +
> +    TCGv i = tcg_temp_new();
> +    TCGv i_esz = tcg_temp_new();
> +    TCGv k = tcg_temp_new();
> +    TCGv k_esz = tcg_temp_new();
> +    TCGv k_max = tcg_temp_new();
> +    TCGv mask = tcg_temp_new();
> +    TCGv mask_offs = tcg_temp_new();
> +    TCGv mask_offs_64 = tcg_temp_new();
> +    TCGv mask_elem = tcg_temp_new();
> +    TCGv mask_offs_rem = tcg_temp_new();
> +    TCGv vreg = tcg_temp_new();
> +    TCGv dest_offs = tcg_temp_new();
> +    TCGv stride_offs = tcg_temp_new();
> +
> +    uint32_t max_elems = MAXSZ(s) >> s->sew;
> +
> +    TCGLabel *start = gen_new_label();
> +    TCGLabel *end = gen_new_label();
> +    TCGLabel *start_k = gen_new_label();
> +    TCGLabel *inc_k = gen_new_label();
> +    TCGLabel *end_k = gen_new_label();
> +
> +    MemOp atomicity = MO_ATOM_NONE;
> +    if (s->sew == 0) {
> +        atomicity = MO_ATOM_NONE;
> +    } else {
> +        atomicity = MO_ATOM_IFALIGN_PAIR;
> +    }
> +
> +    tcg_gen_addi_tl(mask, (TCGv)tcg_env, vreg_ofs(s, 0));
> +
> +    /* Start of outer loop. */
> +    tcg_gen_mov_tl(i, cpu_vstart);
> +    gen_set_label(start);
> +    tcg_gen_brcond_tl(TCG_COND_GE, i, cpu_vl, end);
> +    tcg_gen_shli_tl(i_esz, i, s->sew);
> +    /* Start of inner loop. */
> +    tcg_gen_movi_tl(k, 0);
> +    gen_set_label(start_k);
> +    tcg_gen_brcond_tl(TCG_COND_GE, k, tcg_constant_tl(nf), end_k);
> +    /*
> +     * If we are in mask agnostic regime and the operation is not unmasked we
> +     * set the inactive elements to 1.
> +     */
> +    if (!vm && s->vma) {
> +        TCGLabel *active_element = gen_new_label();
> +        /* (i + k * max_elems) * esz */
> +        tcg_gen_shli_tl(mask_offs, k, get_log2(max_elems << s->sew));
> +        tcg_gen_add_tl(mask_offs, mask_offs, i_esz);
> +
> +        /*
> +         * Check whether the i bit of the mask is 0 or 1.
> +         *
> +         * static inline int vext_elem_mask(void *v0, int index)
> +         * {
> +         *     int idx = index / 64;
> +         *     int pos = index  % 64;
> +         *     return (((uint64_t *)v0)[idx] >> pos) & 1;
> +         * }
> +         */
> +        tcg_gen_shri_tl(mask_offs_64, mask_offs, 3);
> +        tcg_gen_add_tl(mask_offs_64, mask_offs_64, mask);
> +        tcg_gen_ld_i64((TCGv_i64)mask_elem, (TCGv_ptr)mask_offs_64, 0);
> +        tcg_gen_rem_tl(mask_offs_rem, mask_offs, tcg_constant_tl(8));

Could this be faster with tcg_gen_andi_tl(mask_offs_rem, mask_offs, 7)?

> +        tcg_gen_shr_tl(mask_elem, mask_elem, mask_offs_rem);
> +        tcg_gen_andi_tl(mask_elem, mask_elem, 1);
> +        tcg_gen_brcond_tl(TCG_COND_NE, mask_elem, tcg_constant_tl(0),
> +                          active_element);
> +        /*
> +         * Set masked-off elements in the destination vector register to 1s.
> +         * Store instructions simply skip this bit as memory ops access memory
> +         * only for active elements.
> +         */
> +        if (is_load) {
> +            tcg_gen_shli_tl(mask_offs, mask_offs, s->sew);
> +            tcg_gen_add_tl(mask_offs, mask_offs, dest);
> +            st_fn(tcg_constant_tl(-1), (TCGv_ptr)mask_offs, 0);

One more small thing. This is implementing load and store instructions,
yet there are these ld_fn and st_fn, which makes it a bit confusing.
Calling them something like read_vreg / write_vreg might help make them
a bit clearer.

I also suggest try to split the at generation of access for the vector
data and mask registers to see if you can split them into helper
functions. That could make this function smaller and a bit nicer to
review.

Thanks,
Nick


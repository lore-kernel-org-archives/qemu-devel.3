Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B294DC5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 08:33:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsG06-0004W4-MX; Fri, 07 Aug 2026 04:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wsG01-0004Vb-TH
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 04:32:19 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wsG00-00061Z-Cp
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 04:32:17 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-38dc4553f62so3414020a91.0
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 01:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1786091534; x=1786696334; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=86Ot1pAX+6bobD2sRroSovuqr2dOqFZR86bns7QwDAc=;
 b=Mwjbr3syfhYkFgtLmP9Ucevopo/S5sQzS5p6buM7fyS3c+a2pA02QJGax9an5gSUf4
 knxsi7rNyyPBYSd0TtU5Hct2slGkZjeb70sTNmVL/ZDRCTAextXWgVL1DrOTDD7Toi09
 D6iPrY2HKjgTcDqHkNJZEyNN+m+UC8gol0W73mLs2aJhep7J0dZz5NG/+EEAbh+mauu1
 v+gYrN7JwE1XGLcqzcC6sasO9JyqlGMXqJ4va80Y152jvgfnUEsrJ1vVUEqselgdyaZd
 v3+ESod3dMcnbOzq+TxP00al9WOW89oTEYA7K6E74YDeobKR1uuvZYHuj6dzrk+AMV27
 Pr3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786091534; x=1786696334;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=86Ot1pAX+6bobD2sRroSovuqr2dOqFZR86bns7QwDAc=;
 b=CqXk82sTMlIp7ov3qRajwiOYdUJZJ4b36tT2SxqM5FVwM5fYaCBzi3DJ3wcRcSGJkQ
 hpjqqdKMN0dbcP2ORaDvMWTuHaOo0trTt1I8KaL1PrdRAO8SOD5ThB0IjMGVazUlDmnZ
 I00qZsRIcW91JidKEYWId3mwvn3XNOlyXnoOg63O2nIh/dQnkg31e4BYeMtEuDaQMYCt
 8RhROhHdFBl1PKk8d4Jzev5Il9vDgUpfoo5kBA73e8ItjIApa853zmYPghyuFkj7UPK6
 i70xZ709RF3sY4OkgcTAMLqgh045b1B12pfVxA6Zny/AvvmI1f1m3Ac/M5a/Paxzx0RF
 qM6Q==
X-Gm-Message-State: AOJu0YwUMghAHvSmoB9RRsBJUhEqidwObj85Hbjso2R/A/csYbJ2nEqO
 V2EyajS2v3oRSMCYjp9U5vokJnnyBBhkJ9jXA8pYipeBNmXsJ3RfsXc/QKtu8N9ayDM=
X-Gm-Gg: AR+sD10bWtySkQxZzpbr0QdttznAPq9jfrY2tG5oqL1zIVgs+Lykrlt/u7kIZr+38sm
 cRbTL0jxBYN0kDtsdJhltbxkFtUQq/qgQCW/m+5X6+1tRzh2pEDMblrmq5TIuk4ucqg7K06odS2
 EI8aiGQdWmeD2oPe3hE2fmvaduqajg3bhHPJx7B+h7AtOM9jh/pvjaqYQT6kiG75tPezagvvvdn
 Q40ivy+orbd5IwkVSaQX9Xwg9oxHzpQ9R1Kaq7KZ1Xd9a9JGZGh0/PDERLuK77NwZeaVIoIXMPX
 zaGOLhn4w4sZlpPp4CL2gX2u8OX3uTygZ//x8oO9Fmi4O5XQf99rL//TOEVlaUAs0DkaH3/UZGc
 fO8JiTbbQwyAbQp5DJs3BJidaNQ+raNfX8DVywXxpmGw2/r4OtkO+ZiXX/c74ayiq3ma23wxlAu
 QUyPFSJKrrVRXkn52dPO3qQ2uaCPHO2xsJjp34MboCln6qJgPh7pwoz0r51nFdp4z/lAMjPCVqz
 SmlwE2J8zvUNvsNrbHzmYsBKuteZSM3SGc=
X-Received: by 2002:a17:90b:520a:b0:38f:5828:a40c with SMTP id
 98e67ed59e1d1-3903c59a6eemr22064796a91.10.1786091534545; 
 Fri, 07 Aug 2026 01:32:14 -0700 (PDT)
Received: from sifive.com ([136.226.240.165]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3925fa4fc7fsm1619706a91.0.2026.08.07.01.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 01:32:14 -0700 (PDT)
Date: Fri, 7 Aug 2026 16:32:10 +0800
From: Max Chou <max.chou@sifive.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, Frank Chang <frank.chang@sifive.com>
Subject: Re: [PATCH 2/5] target/riscv: Add SiFive custom int8 matmul
 extension implied rules
Message-ID: <anWW2Z-t0OEqZFt2@sifive.com>
References: <20260721122034.1567146-1-max.chou@sifive.com>
 <20260721122034.1567146-3-max.chou@sifive.com>
 <0a052a0c-ab06-410a-a163-4ca6e8b7211f@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0a052a0c-ab06-410a-a163-4ca6e8b7211f@oss.qualcomm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1034.google.com
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

On 2026-08-06 18:07, Daniel Henrique Barboza wrote:
> 
> 
> On 7/21/2026 9:20 AM, Max Chou wrote:
> > From: Frank Chang <frank.chang@sifive.com>
> > 
> > Add SiFive custom int8 matmul extension implied rules to enable the
> > implied extensions of SiFive custom int8 matmul extension recursively.
> > 
> > Signed-off-by: Frank Chang <frank.chang@sifive.com>
> > Signed-off-by: Max Chou <max.chou@sifive.com>
> > ---
> >   target/riscv/cpu.c | 19 +++++++++++++++++++
> >   1 file changed, 19 insertions(+)
> > 
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index e643d7c7af..70baa054f9 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -2811,6 +2811,24 @@ static RISCVCPUImpliedExtsRule ZVFBFA_IMPLIED = {
> >       },
> >   };
> > +static RISCVCPUImpliedExtsRule XSFVQMACCDOD_IMPLIED = {
> > +    .ext = CPU_CFG_OFFSET(ext_xsfvqmaccdod),
> > +    .implied_multi_exts = {
> > +        CPU_CFG_OFFSET(ext_zve32x),
> > +
> > +        RISCV_IMPLIED_EXTS_RULE_END
> > +    },
> > +};
> > +
> > +static RISCVCPUImpliedExtsRule XSFVQMACCQOQ_IMPLIED = {
> > +    .ext = CPU_CFG_OFFSET(ext_xsfvqmaccqoq),
> > +    .implied_multi_exts = {
> > +        CPU_CFG_OFFSET(ext_zve32x),
> > +
> > +        RISCV_IMPLIED_EXTS_RULE_END
> > +    },
> > +};
> > +
> >   RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
> >       &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
> >       &RVM_IMPLIED, &RVV_IMPLIED, &RVG_IMPLIED,
> > @@ -2832,6 +2850,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
> >       &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SHA_IMPLIED,
> >       &SSCFG_IMPLIED, &SUPM_IMPLIED, &SSPM_IMPLIED, &SMCTR_IMPLIED,
> >       &SSCTR_IMPLIED, &SSSTATEEN_IMPLIED,
> > +    &XSFVQMACCDOD_IMPLIED, &XSFVQMACCQOQ_IMPLIED,
> 
> Not related to this patch but I wonder if we should put one rule per line
> in this array.  Every once in a while we have to add a rule that is
> in a line that already has a lot of stuff, then we need to change multiple
> lines to accommodate the new rule.
> 
> 
Hi Daniel,

Actually, I share the same observation and thought, and I agree with
you. Let me update this part in v2.

Thanks for the suggestion!
rnax

> As for the patch:
> 
> 
> 
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> 
> 
> 
> 
> 
> >       NULL
> >   };
> 


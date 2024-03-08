Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC0C6C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riYqT-0000RZ-Eu; Fri, 08 Mar 2024 06:57:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1riYqR-0000QL-AT
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:56:59 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1riYqP-00087z-7D
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:56:59 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-29996cc6382so1416179a91.3
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 03:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1709899015; x=1710503815; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ciJX/JW8933uO3WRfae3QxoiJBeHecoR2sZBfpWJmWw=;
 b=NbDc82ltpSNsVgMPDofgqbVufp+8SQH7ZJOvUHAO2jM9ATkYzD3rJz5uJy94aJbBcR
 JvHfnBSs2cAE/HsdgugXBWGxktNDf7aN/GpnRjuSl/m54WjY9E5L9a4Wcuff7uzmwg5b
 yXm3crfeULx+Zh25J6zMWrxhxcmHayhIet2u0PLDhb/rvpraYIdoWQq/ER4S+urk4uvJ
 RdgcmuXN+6TzTtbC6sL8BAnSRXNgFA3Ehi1Rqnjw3IjAOWx+PKwZSYm6Gy4mn30YRV69
 C8OCDZUDgdCobEkrJWgOt6Je/SO5IurAB0vc4UuC3+yJOe9u8onlqEY7S0jENzXA+skd
 Ej6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709899015; x=1710503815;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ciJX/JW8933uO3WRfae3QxoiJBeHecoR2sZBfpWJmWw=;
 b=QQ2gZukB/VpAZ8LOfe8fuxVPO+jLKta6NMCglO+WCzoZPkpojiJ3rxdbhiesUZ4Us+
 BRmJSxp9kf9C+AIPy7IDOeoaASmFgdYdto7VgUz0hdA4y0Ok6B4O5XiZr0iY6N9khibQ
 oVr0Q2x7Wa9eAM1laVX5rt/Zz3BLgPntb+Or+VOf5ibHRNN9qgfhKc+JQdShO1LiE6ba
 VR0Z4JTU0fWA3Sn5UvT79boJytgAu7G2Jria7Gmahf5p1LaaeSFsMRFU8WnuQeyLGie4
 po7+Lv9blFlCsAhbO28E19627WzYTKE3hlgfx2LDrsmrH41EMQFSDGcRCiDI8zwPwbMC
 Rrzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2Cc9HOYXoESLfSKwdzAe/hIvjQAFwdPNknK6aCt86lIMdqsMsSvdAz2ZNTbsVkFaT/H/B4JpyYij5JFE4yX9GC7kzC98=
X-Gm-Message-State: AOJu0YxEfHRCY98QlaVPfDhIc0CBEFbbGvSd1CzlPKPXGTvQ6o9CHnuW
 fwphAcPOtmlVwb1P6O547Dtyco6IlXBPYr3yLFjH/27iK55VKXbw6LQeaA7K4cFpiZDQd+GAC1K
 FQRnNYQurnT+5V2yDAqOj64hfSU1wLQq/7UJBoBsZ2O3nxeXVYB0=
X-Google-Smtp-Source: AGHT+IHD1OBDr0rnESxh2VrIx7Vdt6udRoR+4K1F2wynQ7YWTUkt1mFRYwvP75736vCpQUldXKsinLcBjh8jBbpOyl8=
X-Received: by 2002:a17:90a:f404:b0:29b:bd2c:7238 with SMTP id
 ch4-20020a17090af40400b0029bbd2c7238mr340750pjb.7.1709899015550; Fri, 08 Mar
 2024 03:56:55 -0800 (PST)
MIME-Version: 1.0
References: <20240306093308.35188-1-eric.huang@linux.alibaba.com>
 <9b9c1af9-5dca-4270-8dfe-a62223c8cbbb@ventanamicro.com>
 <d86b22f7-e601-4bd0-9edc-88d84f572595@linaro.org>
 <dc9f673a-3f5a-4703-b171-b8599bdec22e@linaro.org>
In-Reply-To: <dc9f673a-3f5a-4703-b171-b8599bdec22e@linaro.org>
From: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Date: Fri, 8 Mar 2024 12:56:43 +0100
Message-ID: <CAEg0e7hS+pntt75jmEREJaUoGfT6fpqS4M9E-aJ2LTXtiM78Pw@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Implement dynamic establishment of custom
 decoder
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Huang Tao <eric.huang@linux.alibaba.com>, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com, 
 liwei1518@gmail.com, bin.meng@windriver.com, alistair.francis@wdc.com, 
 palmer@dabbelt.com, Philipp Tomsich <philipp.tomsich@vrull.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=christoph.muellner@vrull.eu; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Mar 7, 2024 at 9:35=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> >>> -        for (size_t i =3D 0; i < ARRAY_SIZE(decoders); ++i) {
> >>> -            if (decoders[i].guard_func(ctx->cfg_ptr) &&
> >>> -                decoders[i].decode_func(ctx, opcode32)) {
> >>> +        for (size_t i =3D 0; i < decoder_table_size; ++i) {
> >>> +            if (ctx->decoder[i](ctx, opcode32)) {
> >>>                   return;
>
> By the way, you're adding layers of pointer chasing, so I suspect you'll =
find all of this
> is a wash or worse, performance-wise.
>
>
> Indeed, since some of the predicates are trivial, going the other way mig=
ht help: allow
> everything to be inlined:
>
>      if (decode_insn32(...)) {
>          return;
>      }
>      if (has_xthead_p(...) && decode_xthead(...)) {
>          return;
>      }
>      ...
>
>
> Even if there are 10 entries here, so what?  All of the code has to be co=
mpiled into QEMU.
>   You're not going to somehow add truly dynamic code that you've loaded f=
rom a module.

I just tested this with GCC -O2/-O3. The generated code from the
existing decoder loop will
result in exactly what you have listed here (loop unrolling,
transforming the indirect calls
to direct calls, inlining, and evaluation of statically known conditions).
has_xthead_p() can get inlined as well, if the inlining costs are
considered low enough
(thank you, Richard, for giving some hints about that below).

What the commit message is not mentioning (and what this patch was
actually addressing and
therefore should have been mentioned):
Having dynamic control of the decoder order was meant to allow adding
a vendor_decoder
before decode_insn32() with minimal overhead (no guard_func) for users
that don't need
this particular vendor_decoder.

Being more explicit: there is interest in supporting the
non-conforming (conflicting) instruction
extension XTheadVector:
  https://github.com/T-head-Semi/thead-extension-spec/blob/master/xtheadvec=
tor.adoc
XTheadVector uses the RVV 0.7.1 draft encoding, which conflicts with
the ratified RVV spec.
The idea is to avoid these conflicts with a call to
decode_xtheadvector() before decode_insn32().
This implies that everyone has to call has_xtheadvector_p() before
calling decode_insn32().
And the intent of this patch is to provide a mechanism to reduce this overh=
ead.

When suggesting the dynamic decoder list, I was not aware that
always_true_p() will be
eliminated by the compiler. Since this is the case, I agree with the
"wash or worse" for
decode_insn32(). The elimination of following guard functions for
vendor decoders is likely
less performance relevant.

I don't think we should discuss efficiency any further unless we have
some data to
justify any changes. E.g. emulating a RISC-V SPEC CPU 2017 run on x86_64 an=
d
looking at the runtimes could give the relevant insights for the
following scenarios:
* existing code on upstream/master
* existing code + adding a new extension that comes before
decode_insn32 in decoders[]
* existing code + this patch (dynamic decoders)
Related overheads that could be measured: adding 20 new instructions
to decode_insn32(),
which are not executed (to put the costs into perspective).

> You could perhaps streamline predicates such as has_xthead_p to not test =
11 variables by
> adding an artificial "ext_xthead_any" configuration entry that is the sum=
 of all of those.
>
>
> r~


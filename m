Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5CE9CD4F39
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 18:08:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNaT5-0002Th-5b; Thu, 14 May 2026 14:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wNaT4-0002SV-3D
 for qemu-devel@nongnu.org; Thu, 14 May 2026 14:07:30 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wNaT0-0002ww-Tz
 for qemu-devel@nongnu.org; Thu, 14 May 2026 14:07:29 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-82f8b60e54dso6703739b3a.2
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 11:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778782043; x=1779386843; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=80ZgKXKDVvOmJaYEAUBsg2rNRUfSuGYDY6q/0mAxEic=;
 b=RVE9ibHm4XpCsOZlzxhd9kugVTRSaEYJRcRxAj2+5noWLYAKl84aAEq/kLRCf2YNed
 iDMfAm7gMUMw0wlCtOGAtbfgb9kfOQsIqRif2wnxIdLhRx7QVIQEDOJ3mesCREqJG8po
 dWGgoxXVEDSu4oXoGK1DFNKFwcaBpr6CAUpdrgRU4Gcjyck+Rd+ftQjqjjLAm/qUytak
 xX8cffxEdHw5rQCg6xGKQ+AMoox9HsFy814ZBNOV6CMxJmlbXBIzfIwiIDlnhEtVc86o
 uon2nGqWC6HvfPMBYumgEyj0K1rL2ln7fCzzHjAxr3jBnJRUBqUgmfNDIB3wb86azxH4
 mZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778782043; x=1779386843;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=80ZgKXKDVvOmJaYEAUBsg2rNRUfSuGYDY6q/0mAxEic=;
 b=V0EfmWchCofXQ7KpT7BvyOV2ghsceyROaaVxOjfyuJXrZTStjFMLjJSc8AXvEqE87g
 2Tf4bvr8id2+oG5g9NJ9Qlz+OBs9Q642vtGrrzXCWA6S6iP/ZGGk25N1blfUOoQBF/ty
 R5RAZVGB7SCVPHML0NMN/tYU4SZBg9N4u9jOHwmRmnrEJ15IniUO0X+iDB8U339Aw0tM
 jl3TTK5OFw5nPbKUh0NWjwggs1r8qy+ifrNJNhaAa5sIMbKMsIDbee1YSk4e059qm75F
 3Z6s0DQ4UrmsWKFhxuOrVk5WgiUocUgy9EFOtkoXF0Qt835VgKFM58UwXCe8rET9Iz6Q
 18wg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/4cKTo9Wnd4jcoDCxKD/+kW2NAijrCIQ8SIf4kBiRI/QH7vAPNWT3mAx2Gu6RtNj1EjPAXZcChocYb@nongnu.org
X-Gm-Message-State: AOJu0Yye4fiT8v2UO5EiKkJ6hwsgW8Gae9kVIGzjsFlH8AcvADf3xk82
 ckQG3H/bx86fS47RyCXPl9AcWHfiKXt13c08RakfD+P2TZl1+BWdmmIX
X-Gm-Gg: Acq92OFLQJO7iFP27qIrW5LpV3Uc9ZhXkJj6tkbli1J6F7VDOkhbXVuXLoM0nVm7yRH
 NFBNAl/kYA4kNR+jnk7IvswO7PLYpWIho0Zz1QGJ2rfEjy0TqFuOEHvq2fvAibRQoof0Lu6Cjbs
 7mVEPf0ZESx0GHbg8jhrzcvZueYZmi3FxJc/XTwcp+XUs9dZaRiX9Mkn3Ir/chpYzDpU3uxiCHs
 PZ9aiIvjfhvLGcI8u9np6pYKKyPaaLV9pfpizQrqoxK9Aft4BCDQSL8nBd8rcTYIjYhPpLGAG2E
 lqy3xu2NlUzHxbCYW2M7WdVWpVynsFYo/ay0fbqTyB7yWsWS6Jf+v5eRai7t5KQCtlO4PSN92bR
 GvlU2EDL4d4xo1d909bR0JbIg+MnaOZLHhQdpitC4OQ3nQiCma22d07E27BziLhidrwY+Y8PwZZ
 xZALhPM7OOQeYP7yJmme1ZEpwjcKWY85BFOQ==
X-Received: by 2002:a05:6a00:94f9:b0:835:45bf:9660 with SMTP id
 d2e1a72fcca58-83f33df29e4mr655042b3a.42.1778782043358; 
 Thu, 14 May 2026 11:07:23 -0700 (PDT)
Received: from google.com ([118.150.148.19]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19c7c74fsm4330143b3a.49.2026.05.14.11.07.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 11:07:22 -0700 (PDT)
Date: Fri, 15 May 2026 02:07:18 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Chao Liu <chao.liu.zevorn@gmail.com>
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, christoph.muellner@vrull.eu,
 farosas@suse.de, lvivier@redhat.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, marscheng@google.com,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: Re: [PATCH v2 1/6] target/riscv: Add stubs for T-Head PMU CSRs
Message-ID: <agYPVpDlY30lSD1Y@google.com>
References: <20260514011528.1263665-1-visitorckw@gmail.com>
 <20260514011528.1263665-2-visitorckw@gmail.com>
 <agU2IzvCDigXHSM5@ZEVORN-PC.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agU2IzvCDigXHSM5@ZEVORN-PC.localdomain>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=visitorckw@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Chao,

On Thu, May 14, 2026 at 10:48:07AM +0800, Chao Liu wrote:
> On Thu, May 14, 2026 at 01:15:23AM +0000, Kuan-Wei Chiu wrote:
> > T-Head CPUs use custom CSRs for performance monitoring, specifically
> > mcounterinten (0x7ca) and mcounterof (0x7cb). [1]
> > 
> > Since we don't implement these custom PMU registers yet, the system
> > crashes with an illegal instruction trap when OpenSBI like this:
> > 
> > system_opcode_insn: Failed to access CSR 0x7ca from M-mode
> > sbi_trap_error: hart0: trap1: illegal instruction handler failed (error -1)
> > 
> > Add simple read/write stubs for these two CSRs. By silently ignoring
> > writes and returning 0 on reads, we prevent the fatal exceptions and
> > allow to continue normally.
> > 
> > Link: https://occ-intl-prod.oss-ap-southeast-1.aliyuncs.com/resource/XuanTie-OpenC906-UserManual.pdf [1]
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > ---
> >  target/riscv/th_csr.c | 30 ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> > 
> > diff --git a/target/riscv/th_csr.c b/target/riscv/th_csr.c
> > index 49eb7bbab5..b095364c31 100644
> > --- a/target/riscv/th_csr.c
> > +++ b/target/riscv/th_csr.c
> > @@ -21,12 +21,19 @@
> >  #include "cpu_vendorid.h"
> >  
> >  #define CSR_TH_SXSTATUS 0x5c0
> > +#define CSR_TH_MCOUNTERINTEN 0x7ca
> > +#define CSR_TH_MCOUNTEROF    0x7cb
> >  
> >  /* TH_SXSTATUS bits */
> >  #define TH_SXSTATUS_UCME        BIT(16)
> >  #define TH_SXSTATUS_MAEE        BIT(21)
> >  #define TH_SXSTATUS_THEADISAEE  BIT(22)
> >  
> > +static RISCVException mmode(CPURISCVState *env, int csrno)
> > +{
> > +    return RISCV_EXCP_NONE;
> > +}
> We can add an RVM extension check, similar in form to smode():
> 
> static RISCVException mmode(CPURISCVState *env, int csrno)
> {
>     if (riscv_has_ext(env, RVM)) {

Thanks for your review.
However, I think this might not be correct.

IIUC, RVM represents the standard M extension for integer
multiplication and division instructions, rather than indicating
whether M mode is implemented. Is it even possible for a riscv machine
implementation to not have M mode?

Looking at the misa csr description in the spec, the 'S' and 'U' bits
specifically denote the implementation of supervisor and user modes,
respectively, but there is no corresponding bit for M mode. I assume
this implies M mode is unconditionally required?

>         return RISCV_EXCP_NONE;
>     }
> 
>     return RISCV_EXCP_ILLEGAL_INST;
> }
> 
> For your reference, I have added more T-Head CSR support in the
> K230 patchset.
> 
> https://lore.kernel.org/qemu-devel/1c7319cd00a50bffeb41f9cc13339a8cd0c07350.1778516731.git.chao.liu.zevorn@gmail.com/

It looks like your patch covers much more ground than mine and has
already received quite a few reviews. I assume once your series is
merged, I can simply drop my patch #1.

So I guess the most sensible workflow here is for me to wait until your
patchset is merged into the subsystem maintainer's tree (assuming it
will route through Alistair's tree [1] I guess?, please correct me if
I'm wrong!), and then I'll rebase my series on top of it and send out
v3?

[1]: https://github.com/alistair23/qemu.git riscv-to-apply.next

Regards,
Kuan-Wei

> 
> As for this patch, I think the other changes look mostly fine.
> 
> Thanks,
> Chao
> > +
> >  static RISCVException smode(CPURISCVState *env, int csrno)
> >  {
> >      if (riscv_has_ext(env, RVS)) {
> > @@ -49,11 +56,34 @@ static RISCVException read_th_sxstatus(CPURISCVState *env, int csrno,
> >      return RISCV_EXCP_NONE;
> >  }
> >  
> > +static RISCVException read_th_pmu(CPURISCVState *env, int csrno,
> > +                                  target_ulong *val)
> > +{
> > +    *val = 0;
> > +    return RISCV_EXCP_NONE;
> > +}
> > +
> > +static RISCVException write_th_pmu(CPURISCVState *env, int csrno,
> > +                                   target_ulong val, uintptr_t retaddr)
> > +{
> > +    return RISCV_EXCP_NONE;
> > +}
> > +
> >  const RISCVCSR th_csr_list[] = {
> >      {
> >          .csrno = CSR_TH_SXSTATUS,
> >          .insertion_test = test_thead_mvendorid,
> >          .csr_ops = { "th.sxstatus", smode, read_th_sxstatus }
> >      },
> > +    {
> > +        .csrno = CSR_TH_MCOUNTERINTEN,
> > +        .insertion_test = test_thead_mvendorid,
> > +        .csr_ops = { "th.mcounterinten", mmode, read_th_pmu, write_th_pmu }
> > +    },
> > +    {
> > +        .csrno = CSR_TH_MCOUNTEROF,
> > +        .insertion_test = test_thead_mvendorid,
> > +        .csr_ops = { "th.mcounterof", mmode, read_th_pmu, write_th_pmu }
> > +    },
> >      { }
> >  };
> > -- 
> > 2.54.0.563.g4f69b47b94-goog
> > 


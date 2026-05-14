Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D905CD4F39
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 22:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNeba-0004Uc-Lj; Thu, 14 May 2026 18:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wNebW-0004UE-57
 for qemu-devel@nongnu.org; Thu, 14 May 2026 18:32:30 -0400
Received: from mail-dl1-x1243.google.com ([2607:f8b0:4864:20::1243])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wNebT-00089A-FD
 for qemu-devel@nongnu.org; Thu, 14 May 2026 18:32:29 -0400
Received: by mail-dl1-x1243.google.com with SMTP id
 a92af1059eb24-13317450f83so3254853c88.0
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 15:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778797946; x=1779402746; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=I36iP4R7GB6PH+qUHoG9DyDbO4S27NkHwDlPIHqghqo=;
 b=ZYaV2ah9l+EyF8kvv7HZu5PsyzQqQwZ2mrcIvDh5u7Ak24N/stZOCOqi/ItDHi3Upz
 SBq/ytCc4TxlH/NNq3d+AhZVgIIWbOb/+e7c39LQ3+QPqN2L9KO7Xtd8bmSE809jMFD0
 FG7PVstcF8rpIDswVcVK4CbJS1jxybbL7wceGrGxHkoflWBk+AC1JAXkSwU1mC+LNtHR
 587etGz0g83aPqljWJdXbmZ05XgFqyW03PIi8v8nqNgy/Dzxe0Cndbfek2yShhz3YDLy
 EjoYqG4cKe3YMTk7eHGa7oCCO3F3S1n2agZzGkcc0i03LPOQNej30y3py0JXL5v0s55o
 Fhog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778797946; x=1779402746;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I36iP4R7GB6PH+qUHoG9DyDbO4S27NkHwDlPIHqghqo=;
 b=bUxmzTMVDqeUc7eSvvMHVmHXO2NNi1dZ2Ur2xIPgov7kXoP/iWGPnMS1TIrVTZ3tS1
 3klszVqwVX9/BzShOp/z4w44Wfe3kWhNcy78erylfmkrz6pyv7htix+dIcJDqRIUEowo
 mBN2w6aYeXo/KcKc6yn48Y8VYyD/zSyeSSG9i/FHF6gT5oiohdHen5ptPs7OGR8H6eJR
 z4bFXXl83dT0BTs3nBf8tr2vlmOPEb58Ug1MsgzdX7fqqjs4gyHVirCqImBHKYlF4/km
 mjnWMqr9QWXR+SFC+U6z0+orw/SuqU3WyTzFKJBuPLOULf/tjm489LYL88u0tlnHnM8p
 d0Yw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8kSAAssJNAurGxYvLLwY3qjdca7khXp9AchnbixL+gZvPCuBOwLK0qO/3wj/ewZIe+3ybxtSreEWrs@nongnu.org
X-Gm-Message-State: AOJu0YwQx59yvlIxh/Gv0NAkGE5iP54+duhs2GksmdPWkLo9sj2SoQlQ
 UUVNhiGK2Nr5YJBUs9dW1B6xsTrXJAvCMtaPijvMMaMVS7x0k/2U+fei
X-Gm-Gg: Acq92OFu7GBkeraEdqzisQua9BB+qXaHMtIiDUbe7VaDBx2Ql1sJ/kWPLk2kIfo4c3I
 /9+i1NRnD3EOunAsulmKOIjE++p3lhFDdjofw4hc6kYEHAFixhmTtWw8CeK6iIPJohV160Lf6ec
 YLpJFJ3pBpNCKbW/lTemeBRl/RLIxHH0rnCZuSGE3ZiJAyEfhxBa7CsEV08wlRTGNX550J1Jfr0
 t7CirDRCKlTVMU8lLQ7ZG1Dw20Z2lGLtWE3lnxhhnmvBp4IIbbMGP3lje/r/DaVfrTTnsGmWTI+
 x6R17pfFeLcciKyBnAPV4fAsaMyci4aFmx5SzUnI7RQHk6RpydQCgg7xKn2YLH4JcX0+L0Z6nbP
 5lfA3Qem2ACjxjdrSHEr20xIq0Bii/A+TlEZHmjHmeMRgb25wX+8kqFpE6w9tcLVHEtFHr4Eu5T
 CauSFLUkvwZhGzZAhsNHTIVWLy/cnfVhH9sW4L2LwznkIZisvv9eWBqqSoj7P8ab1OZaB81jsft
 al3q/HekiUTFQRYomqOGitZ9ar4yOhrlGbQ/eZyjA==
X-Received: by 2002:a05:7022:1a85:b0:12d:d972:b96e with SMTP id
 a92af1059eb24-1350542e8e5mr487170c88.20.1778797945617; 
 Thu, 14 May 2026 15:32:25 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cc33aac9sm5218556c88.14.2026.05.14.15.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 15:32:25 -0700 (PDT)
Date: Fri, 15 May 2026 06:32:15 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, christoph.muellner@vrull.eu, farosas@suse.de,
 lvivier@redhat.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, 
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, marscheng@google.com, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: Re: [PATCH v2 1/6] target/riscv: Add stubs for T-Head PMU CSRs
Message-ID: <agZFchak-jsc2moK@ZEVORN-PC.localdomain>
References: <20260514011528.1263665-1-visitorckw@gmail.com>
 <20260514011528.1263665-2-visitorckw@gmail.com>
 <agU2IzvCDigXHSM5@ZEVORN-PC.localdomain>
 <agYPVpDlY30lSD1Y@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agYPVpDlY30lSD1Y@google.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1243;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1243.google.com
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

On Fri, May 15, 2026 at 02:07:18AM +0800, Kuan-Wei Chiu wrote:
> Hi Chao,
> 
> On Thu, May 14, 2026 at 10:48:07AM +0800, Chao Liu wrote:
> > On Thu, May 14, 2026 at 01:15:23AM +0000, Kuan-Wei Chiu wrote:
> > > T-Head CPUs use custom CSRs for performance monitoring, specifically
> > > mcounterinten (0x7ca) and mcounterof (0x7cb). [1]
> > > 
> > > Since we don't implement these custom PMU registers yet, the system
> > > crashes with an illegal instruction trap when OpenSBI like this:
> > > 
> > > system_opcode_insn: Failed to access CSR 0x7ca from M-mode
> > > sbi_trap_error: hart0: trap1: illegal instruction handler failed (error -1)
> > > 
> > > Add simple read/write stubs for these two CSRs. By silently ignoring
> > > writes and returning 0 on reads, we prevent the fatal exceptions and
> > > allow to continue normally.
> > > 
> > > Link: https://occ-intl-prod.oss-ap-southeast-1.aliyuncs.com/resource/XuanTie-OpenC906-UserManual.pdf [1]
> > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > ---
> > >  target/riscv/th_csr.c | 30 ++++++++++++++++++++++++++++++
> > >  1 file changed, 30 insertions(+)
> > > 
> > > diff --git a/target/riscv/th_csr.c b/target/riscv/th_csr.c
> > > index 49eb7bbab5..b095364c31 100644
> > > --- a/target/riscv/th_csr.c
> > > +++ b/target/riscv/th_csr.c
> > > @@ -21,12 +21,19 @@
> > >  #include "cpu_vendorid.h"
> > >  
> > >  #define CSR_TH_SXSTATUS 0x5c0
> > > +#define CSR_TH_MCOUNTERINTEN 0x7ca
> > > +#define CSR_TH_MCOUNTEROF    0x7cb
> > >  
> > >  /* TH_SXSTATUS bits */
> > >  #define TH_SXSTATUS_UCME        BIT(16)
> > >  #define TH_SXSTATUS_MAEE        BIT(21)
> > >  #define TH_SXSTATUS_THEADISAEE  BIT(22)
> > >  
> > > +static RISCVException mmode(CPURISCVState *env, int csrno)
> > > +{
> > > +    return RISCV_EXCP_NONE;
> > > +}
> > We can add an RVM extension check, similar in form to smode():
> > 
> > static RISCVException mmode(CPURISCVState *env, int csrno)
> > {
> >     if (riscv_has_ext(env, RVM)) {
> 
> Thanks for your review.
> However, I think this might not be correct.
> 
> IIUC, RVM represents the standard M extension for integer
> multiplication and division instructions, rather than indicating
> whether M mode is implemented. Is it even possible for a riscv machine
> implementation to not have M mode?
> 
> Looking at the misa csr description in the spec, the 'S' and 'U' bits
> specifically denote the implementation of supervisor and user modes,
> respectively, but there is no corresponding bit for M mode. I assume
> this implies M mode is unconditionally required?
> 
Good catch, your analysis is correct. I will fix this in the next version.

> >         return RISCV_EXCP_NONE;
> >     }
> > 
> >     return RISCV_EXCP_ILLEGAL_INST;
> > }
> > 
> > For your reference, I have added more T-Head CSR support in the
> > K230 patchset.
> > 
> > https://lore.kernel.org/qemu-devel/1c7319cd00a50bffeb41f9cc13339a8cd0c07350.1778516731.git.chao.liu.zevorn@gmail.com/
> 
> It looks like your patch covers much more ground than mine and has
> already received quite a few reviews. I assume once your series is
> merged, I can simply drop my patch #1.
> 
> So I guess the most sensible workflow here is for me to wait until your
> patchset is merged into the subsystem maintainer's tree (assuming it
> will route through Alistair's tree [1] I guess?, please correct me if
> I'm wrong!), and then I'll rebase my series on top of it and send out
> v3?
> 
I think both are fine, we need to see what Alistair suggests.

Thanks,
Chao

> [1]: https://github.com/alistair23/qemu.git riscv-to-apply.next
> 
> Regards,
> Kuan-Wei
> 
> > 
> > As for this patch, I think the other changes look mostly fine.
> > 
> > Thanks,
> > Chao
> > > +
> > >  static RISCVException smode(CPURISCVState *env, int csrno)
> > >  {
> > >      if (riscv_has_ext(env, RVS)) {
> > > @@ -49,11 +56,34 @@ static RISCVException read_th_sxstatus(CPURISCVState *env, int csrno,
> > >      return RISCV_EXCP_NONE;
> > >  }
> > >  
> > > +static RISCVException read_th_pmu(CPURISCVState *env, int csrno,
> > > +                                  target_ulong *val)
> > > +{
> > > +    *val = 0;
> > > +    return RISCV_EXCP_NONE;
> > > +}
> > > +
> > > +static RISCVException write_th_pmu(CPURISCVState *env, int csrno,
> > > +                                   target_ulong val, uintptr_t retaddr)
> > > +{
> > > +    return RISCV_EXCP_NONE;
> > > +}
> > > +
> > >  const RISCVCSR th_csr_list[] = {
> > >      {
> > >          .csrno = CSR_TH_SXSTATUS,
> > >          .insertion_test = test_thead_mvendorid,
> > >          .csr_ops = { "th.sxstatus", smode, read_th_sxstatus }
> > >      },
> > > +    {
> > > +        .csrno = CSR_TH_MCOUNTERINTEN,
> > > +        .insertion_test = test_thead_mvendorid,
> > > +        .csr_ops = { "th.mcounterinten", mmode, read_th_pmu, write_th_pmu }
> > > +    },
> > > +    {
> > > +        .csrno = CSR_TH_MCOUNTEROF,
> > > +        .insertion_test = test_thead_mvendorid,
> > > +        .csr_ops = { "th.mcounterof", mmode, read_th_pmu, write_th_pmu }
> > > +    },
> > >      { }
> > >  };
> > > -- 
> > > 2.54.0.563.g4f69b47b94-goog
> > > 


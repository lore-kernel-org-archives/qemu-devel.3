Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80D3EF8FEB
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 14:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxn9A-0005tS-U7; Wed, 04 Mar 2026 09:24:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vxn99-0005lX-Ky
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 09:24:19 -0500
Received: from mail-dl1-x1244.google.com ([2607:f8b0:4864:20::1244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vxn97-00075w-C7
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 09:24:19 -0500
Received: by mail-dl1-x1244.google.com with SMTP id
 a92af1059eb24-1270ac5d3efso6711091c88.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 06:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772634256; x=1773239056; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=F+weyz1q5d66tpoHSPWtvl4krrJuInVus+fD1G8iZ6A=;
 b=Rbs05SJ02oXWeJpRdlHTIXrpN47BytAEFY0LWsACL1UarKP6XpYE5vSSr3y782PYBw
 c9JrDv7ZqyJXKTZYT68QybEn2TyvwedYyIwgJ6HGUqjyOJMTUR38UmHhO1hhenOUVArB
 +XWd5XkbRlUmNemIjSQNDKxFIhWT87NpFjA5pJVPZi+1SbjMjKdAxfFkArLCpbEfX8cg
 G7i47rRzCenvdhoVwv7aSSLU8hYDt/uCO20Ql/mc2CRa1GSTQeZwUHA8H2+K8eIwNVHI
 G/8XqU867SS5TKJcDkBCWtVNAMMoCX2q3SzxTrCUDJnRGIUHUOqYzsEbTucpsNALA9WK
 kYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772634256; x=1773239056;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F+weyz1q5d66tpoHSPWtvl4krrJuInVus+fD1G8iZ6A=;
 b=QrjXGE+GWc2hdja1C5ITMJa9MIyUmkQusN+FkfrSvYv/raLhAThKTe8J75OgiNmiNp
 4wAUTk/QYPcG27iFX61CycCKaAo1k1pFVP2YXBgXQw+vPkFgCd7BHAS5YC8PqrjWG8NO
 BvqQyLBLzEug56YXtx33UA7JdgncQ3WFEbG1vqeLK24aedPDyIrXZJYMc+z6jHtNyG9Z
 ByJ5UsAApbtDzTdMmVHD5sBRbHTomsJI5bLSBkq3rLPQFA7t1jwAbBsp2mru59tctnQ4
 Gy9g/berIJA4ycDFHcgcEpbZ6jGXfXmSkbMgKIG5iQSclYV8BqPTlrTTcSHeVKCorl3K
 GyaQ==
X-Gm-Message-State: AOJu0Yzcofkwfu7PqwSGJl0mj/d2LwI0RaF9fpJhVGMlHLAMwpHUEUr8
 XWoAtI07wOkuMl6XTenS2DBczwojRn1S64YJ5WYR8JF5xSdoHaMx+QS/
X-Gm-Gg: ATEYQzzFjyKnMAxZd4eudIpSqE4t6CjLB9Uhjij9/hY7k1OMtgbiRwgktM+/jU6k5/p
 GxYCmkxGxLgjemXXOpj399gLZZ8+UDzwA5KJm/E12QtaalDLiobgabYNCQ85fMhs4K9gqKk7TW2
 DzgFFJ/66mwybmWbDuhNJgzwIhCC3kVfabMjKlr7RC4yO6Od9ZvEDk4aHF5IhIem2btmtX7xSG9
 /EaFOTcKCGASUNb6GaZW9AC6DWLgaUn9YI625A44SKH+xYNVPVQlF0zcyNhWMIaXdRP/FAvFa2u
 DXGZTo/n+q4MXGXN/3rJvLLr/9E8W1wyc0YJKav3zABsUhyhUVXjU7fh9Hy3D3P/rnKZ82yNRuW
 T+iwXuUCxyX/SJ4jRPH6HiVMsrHTWKppESwxrE/OAp81OrIPWE2JcpznZmTnLkELAR/9BvEg+9z
 Tf0GB+wzvheMrMPy56h1nsasuYBP0y+te8S3GNu2q3BikS2E9hai/UHyK8uxWDGwz9/Vy3qTJ8p
 HKbitnHj5kizs92zqKmF5cj0fBoAN2vmOxSYlDoGg==
X-Received: by 2002:a05:7022:238b:b0:123:35cb:96e3 with SMTP id
 a92af1059eb24-128b71067admr980863c88.46.1772634255481; 
 Wed, 04 Mar 2026 06:24:15 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12789a43a18sm23486142c88.13.2026.03.04.06.24.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 06:24:15 -0800 (PST)
Date: Wed, 4 Mar 2026 22:23:49 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Jay Chang <jay.chang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Frank Chang <frank.chang@sifive.com>
Subject: Re: [PATCH v2] target/riscv: Support Smpmpmt extension
Message-ID: <aag_t5Xg1OWOhGdU@ZEVORN-PC.localdomain>
References: <20251107023136.89181-1-jay.chang@sifive.com>
 <CACNNAjP+Nhay5hE22nFnR6z5nHiyQGKqENg128+rTv5B3cv0eQ@mail.gmail.com>
 <CACNNAjPWpMf-jQCd6bZRwsEuy9GmbpLt_3TA-D27oxnGy1pJvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACNNAjPWpMf-jQCd6bZRwsEuy9GmbpLt_3TA-D27oxnGy1pJvQ@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1244;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1244.google.com
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

On Wed, Mar 04, 2026 at 01:30:18PM +0800, Jay Chang wrote:
> Hi,
> 
> Gentle ping on this patch.
> 
> Thanks,
> Jay Chang
> 
> On Mon, Dec 1, 2025 at 1:11 PM Jay Chang <jay.chang@sifive.com> wrote:
> 
> > Hi,
> >
> > Gentle ping on this patch.
> >
> > Thanks,
> > Jay Chang
> >
> > On Fri, Nov 7, 2025 at 10:31 AM Jay Chang <jay.chang@sifive.com> wrote:
> >
> >> The Smpmpmt extension provides a mechanism to control memory attributes
> >> at the granularity of PMP (Physical Memory Protection) registers, similar
> >> to how Svpbmt controls memory attributes at the page level.
> >>
> >> Version 0.6
> >>
> >> https://github.com/riscv/riscv-isa-manual/blob/smpmpmt/src/smpmpmt.adoc#svpbmt
> >>
> >> Signed-off-by: Jay Chang <jay.chang@sifive.com>
> >> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> >> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> >>
> >> ---
> >> v2:
> >>     Place smpmpmt in the correct riscv,isa order.
> >>
> >> Signed-off-by: Jay Chang <jay.chang@sifive.com>
> >> ---
> >>  target/riscv/cpu.c                |  2 ++
> >>  target/riscv/cpu_cfg_fields.h.inc |  1 +
> >>  target/riscv/pmp.c                | 12 ++++++++++++
> >>  target/riscv/pmp.h                |  1 +
> >>  4 files changed, 16 insertions(+)
> >>
> >> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> >> index ae8b721e55..0760ee7d9e 100644
> >> --- a/target/riscv/cpu.c
> >> +++ b/target/riscv/cpu.c
> >> @@ -203,6 +203,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
> >>      ISA_EXT_DATA_ENTRY(smcsrind, PRIV_VERSION_1_13_0, ext_smcsrind),
> >>      ISA_EXT_DATA_ENTRY(smdbltrp, PRIV_VERSION_1_13_0, ext_smdbltrp),
> >>      ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
> >> +    ISA_EXT_DATA_ENTRY(smpmpmt, PRIV_VERSION_1_12_0, ext_smpmpmt),
> >>      ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
> >>      ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_13_0, ext_smmpm),
> >>      ISA_EXT_DATA_ENTRY(smnpm, PRIV_VERSION_1_13_0, ext_smnpm),
> >> @@ -1262,6 +1263,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[]
> >> = {
> >>      MULTI_EXT_CFG_BOOL("svinval", ext_svinval, false),
> >>      MULTI_EXT_CFG_BOOL("svnapot", ext_svnapot, false),
> >>      MULTI_EXT_CFG_BOOL("svpbmt", ext_svpbmt, false),
> >> +    MULTI_EXT_CFG_BOOL("smpmpmt", ext_smpmpmt, false),
smpmpmt is an sm* extension but it's placed here among the
sv* entries (between svpbmt and svrsw60t59b). It should be
grouped with other sm* extensions around smepmp/smrnmi.

This seems like a copy-paste from v1 that wasn't updated.

> >>      MULTI_EXT_CFG_BOOL("svrsw60t59b", ext_svrsw60t59b, false),
> >>      MULTI_EXT_CFG_BOOL("svvptc", ext_svvptc, true),
> >>
> >> diff --git a/target/riscv/cpu_cfg_fields.h.inc
> >> b/target/riscv/cpu_cfg_fields.h.inc
> >> index a154ecdc79..b1096da664 100644
> >> --- a/target/riscv/cpu_cfg_fields.h.inc
> >> +++ b/target/riscv/cpu_cfg_fields.h.inc
> >> @@ -57,6 +57,7 @@ BOOL_FIELD(ext_svadu)
> >>  BOOL_FIELD(ext_svinval)
> >>  BOOL_FIELD(ext_svnapot)
> >>  BOOL_FIELD(ext_svpbmt)
> >> +BOOL_FIELD(ext_smpmpmt)
Same ordering concern here — ext_smpmpmt is placed among
the sv* fields (after ext_svpbmt). It would be more
consistent to group it with the sm* fields.

> >>  BOOL_FIELD(ext_svrsw60t59b)
> >>  BOOL_FIELD(ext_svvptc)
> >>  BOOL_FIELD(ext_svukte)
> >> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> >> index 3ef62d26ad..52a7677683 100644
> >> --- a/target/riscv/pmp.c
> >> +++ b/target/riscv/pmp.c
> >> @@ -165,6 +165,18 @@ static bool pmp_write_cfg(CPURISCVState *env,
> >> uint32_t pmp_index, uint8_t val)
> >>                            "ignoring pmpcfg write - invalid\n");
> >>          } else {
> >>              uint8_t a_field = pmp_get_a_field(val);
> >> +
> >> +            if (!riscv_cpu_cfg(env)->ext_smpmpmt) {
> >> +                /* If smpmpmt not supported, clear the MTMATCH bit */
> >> +                val &= ~PMP_MTMATCH;
> >> +            } else if ((val & PMP_MTMATCH) == PMP_MTMATCH) {
> >> +                /*
> >> +                 * If trying to set reserved value (0x3) for MT field,
> >> +                 * preserve the original MT field from current config.
> >> +                 */
> >> +                val = (val & ~PMP_MTMATCH) |
> >> +                    (env->pmp_state.pmp[pmp_index].cfg_reg &
> >> PMP_MTMATCH);
> >> +            }
The WARL write-filtering logic looks correct to me. Nice
handling of the reserved value case.

PS: this patch implements the CSR interface for the
MT field but doesn't change PMP access-check behavior based
on the memory type.

For QEMU emulation this is fine since cache attributes have no
functional impact, but it might be worth a brief comment noting
that the MT field is stored but not acted upon during access
checks, so future readers don't wonder if it's missing.

> >>              /*
> >>               * When granularity g >= 1 (i.e., granularity > 4 bytes),
> >>               * the NA4 (Naturally Aligned 4-byte) mode is not selectable
> >> diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
> >> index 271cf24169..467fb6b4b1 100644
> >> --- a/target/riscv/pmp.h
> >> +++ b/target/riscv/pmp.h
> >> @@ -29,6 +29,7 @@ typedef enum {
> >>      PMP_WRITE = 1 << 1,
> >>      PMP_EXEC  = 1 << 2,
> >>      PMP_AMATCH = (3 << 3),
> >> +    PMP_MTMATCH = (3 << 5),
Looks good — bits [6:5] for the MT field per the spec.

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Best regards,
Chao Liu
> >>      PMP_LOCK  = 1 << 7
> >>  } pmp_priv_t;
> >>
> >> --
> >> 2.48.1
> >>
> >>


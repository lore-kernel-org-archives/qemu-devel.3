Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98DF2CD8C9F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 12:53:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWZTd-0000Y5-In; Mon, 08 Jun 2026 08:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWZTb-0000Vp-M4
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 08:53:11 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWZTZ-0000Al-TI
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 08:53:11 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-7dd5a8dc8a2so28313357b3.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 05:53:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780923188; cv=none;
 d=google.com; s=arc-20240605;
 b=NlJL7efpfHZFia6gGI8gD0LSXbxMpC1fLpKb+Cod2e0wJtfkCEkuN1wWsFQyhFdsUa
 iWnKva01Qu8zLwyRSDRe57EfWGhD7BQL0Oji8DQHLGvBebqz5gL4N5xKjSTcQgRbYjOq
 ZOSN6QNwfCxfr8DuVcklIkWM1UWzlIsesEYHkeTjg0N0VnxFl3Zf+WAddDJE4GeVvykg
 TdeAdALQjhgdoW8sZ6JcKNLXUhgzu+E/yMiba8Zwso+yNR4jVwlz/X26I5E2QKKu7y8W
 C1jPbGtlzaNipelBKWRdkUWh/yW2Dg2XzM65yKewDP0lcN+6DhOpNdntTPr51/KKmi4K
 no2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MLurEieTvUE5iGfTkUGDqnafLAm8vIqPoAXz4cpA3D0=;
 fh=0Yr8oJaBK5cFJ0k5qmLByBDTX3eKRYQ53ouvGuISXf4=;
 b=LF/fV/xtZHGyOK7+l+H6DuE1hS07KIvJ1/PilBXKQinC6JGdKiZedTl7xRhCUU3wwJ
 nV5SHL+b3A84YX5Ttt/Q98y6+QyVB+7/KwZtyPxpngyTxrAUEuik0Kv4oFI3hX4CLE4W
 fyjrj/nf72h0Ep6qBK8+Gk1nzXsIDJl/b+W+2/AmviyMzO6jwNfNHNkPHqe6IZTncrL+
 aJBC+bOWUO1PdzsRSm2qE+z0NFxmv58vTo7tjboALpACFGHpJQx2bDaqP23nVDWJAzFt
 OPC3PS27NMUISsmw9QSNoxQYOvIUwY+hgfEFNqbcjLmZiHRNmINtRt1CQIaO3WX3/1uJ
 tthA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780923188; x=1781527988; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MLurEieTvUE5iGfTkUGDqnafLAm8vIqPoAXz4cpA3D0=;
 b=Spi1o8ezeUdyJVf18i+0ubD0z5EcZB4i/n78Ax4HficVE5OVT6+CxP26zdAdBiZVNb
 9e4UI6zrcEHsMC17iUIWp/MjGsiCLsVtSy87tVyZ1Xv1UU1CDxrh4tq5bxU2npzI3afd
 9PWKplABJoGE5KWGJeD8kMZRjYknniJTz500NPHuwqjTai9nLS2XusgfM/cnRQQqhOP8
 JGKDX3V8q/XJWyJdvDEUvmIVFsZH6n90VIEI0KctWQWvCyMhVx6vnAqMIpvDDSbz1pGf
 b0k5bxCWprRw5NfF6ssOtsawkcb+63r5z/ORajniHip0tbGKTgK4yLSDyRT4x4cPcCU1
 wvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780923188; x=1781527988;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MLurEieTvUE5iGfTkUGDqnafLAm8vIqPoAXz4cpA3D0=;
 b=pCTEyUoi3BXF5G82bStQ8TvboJ9LBDZWMgcEFRjEglVZsUQ8zF/9kJrufo3H4mf6te
 1f2hWZJgEpOpCiUGqYMuUt8Btq6z/DqCRaCBLTetGdHTOEWI5aa1Kv0UeRyJWnMNdYV4
 Ufz0mJoitAuBzno+hSGS148MQUnWYBXJCEmWLI8UCAzbT7XYAvGG80BO5dZRsmrEWf08
 o18tJWrsBxx2gtpGFZEGsWiGl05Dtlrir1CUAX8hTLgMBawoRpTeMbYh76UVPcw/RFyh
 S2hpzMcVFBDbD1z5WyUNuouqWqPPM0pRmxly+YEx6erOM0OuB4iaoqympWBW9Sjrmevj
 0lcg==
X-Gm-Message-State: AOJu0Yz6mteZL31O7YFJ3IA9xfDQ79on8GafU197WJjCukVdR7mjWh9W
 i4r37GKLyg3GPpzlPqTWfv6m1L2OXABqsycp775tSYMIo5OrqIJIqkFkhMu3YuPPjG8bG6pGuk+
 zSkwZeLNvGmKTUpYUX/EKcMsgXNguOHoj0yRFqznN/A==
X-Gm-Gg: Acq92OHJXgeLvbZ41GeoTqFAuCpd/LMk0WTTrgMBjiT8R/6AKXDlxMM87K8vRx7xrQG
 6BemUq6J6yWPFFVPhVeO01hWiSnfuO4VyPY0yuLwP0DCeGFWK0HNRBoTI0JU1NXUByGAx1Q3Xig
 7IJuuvKoXfc8U+3YONBP5aJmbzhu2yEgY/wdY/QiRDXsV5PG8blc/rLzxTLTkSWKf5IsMWzXfAg
 Orh7RRD8RxOq10MhT+2UIOU+pRm2wwv73O929tc0u+z8MhEF63B/OfFOLwMzs32kqSOuwH9nfNd
 iGPIvgibzLPjTfF2PzsSa6mTvhvPQZEioptPFadYrZfg0o6gLQQY0a5hD0ms97cRL+Y3rbtY9EM
 X+Q==
X-Received: by 2002:a53:d005:0:b0:65e:3bde:7c14 with SMTP id
 956f58d0204a3-66106f3f76cmr11771240d50.32.1780923187925; Mon, 08 Jun 2026
 05:53:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260602190857.1506939-1-daniel.barboza@oss.qualcomm.com>
 <CAFEAcA9WZLV_fsFRN7g9-3NdJ0ecXGYqJHbp6kPPpSAiwM5PnQ@mail.gmail.com>
 <98b5f348-aac4-4be9-a897-95da11c19aa5@oss.qualcomm.com>
 <CAFEAcA-P4OySVHDziG59Ln7CuqLFArHjc5v8NsAQafD9HxsuyA@mail.gmail.com>
 <be7ea7b6-4e6c-4ab4-94d3-2c82f225c1ad@oss.qualcomm.com>
In-Reply-To: <be7ea7b6-4e6c-4ab4-94d3-2c82f225c1ad@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2026 13:52:53 +0100
X-Gm-Features: AVVi8CdrpTTtIyzJfJIpl82dAxf6LKxNzFS13nVyN54XDzGTcf-t1-bB36n77ZE
Message-ID: <CAFEAcA8OdLtjbBRK9QWjwy0mCFPbYsA2Yztp4o6C+jam7aonNQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] memory.c: make memory_region_dispatch_* report
 ACCESS_ERROR
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, philmd@mailo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Mon, 8 Jun 2026 at 13:16, Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
> On 6/8/2026 7:08 AM, Peter Maydell wrote:
> > On Mon, 8 Jun 2026 at 10:47, Daniel Henrique Barboza
> > <daniel.barboza@oss.qualcomm.com> wrote:
> > Do you have a reference in the architecture spec for the check that
> > you're trying to implement here ?
>
> Sure.  It's on the RISC-V Privileged ISA, chapter 12, section
> 12.3.2 "Virtual Address Translation Process":
>
> https://docs.riscv.org/reference/isa/_attachments/riscv-privileged.pdf
>
> 9. If pte.a=3D0, or if the original memory access is a store and pte.d=3D=
0:
> - If the Svade extension is implemented, stop and raise a page-fault
>    exception corresponding to the original access type
> - If a store to the PTE at address a+va.vpn[i]=C3=97PTESIZE would violate=
 a
>    PMA or PMP check, raise an access-fault exception corresponding to
>    the original access type.
>
> At this moment we're throwing a page-fault exception for both cases.  We
> want the second case to throw an access-fault exception.  PMA stands for
> "Physical Memory Access", i.e. the read/write/execute bits of the PTE.
> PMP is an optional physical-memory protection scheme.  Both are related
> to a PTE permission to be read/write/executed, regardless of other
> failures like address misaligned/wrong operation size.

Are you sure that's what a PMA check is ? Section 3.6 seems to me
to be describing something else, where the hardware uses some
combination of hardwired info and unspecified platform-specific
registers to determine whether the physical address is to somewhere
that supports particular access widths, atomic insns, cacheability,
and ability to read, write or exec.

I can't see where in the spec it defines what's supposed to happen
if the page-table-entry read fails because it's to an invalid
physical address, so presumably that's just a subtype of "failed
a PMA check". (3.6.1 has a note that supports that reading, where
it says that previous spec versions had a "vacant region" concept,
presumably corresponding to our "decode error", but that these are
now treated as I/O regions that have none of r/w/x access permissions.)

In that case the riscv page table walk code should:
 - fail with page-fault exception for "pte.a field is zero"
   (and do not attempt a load from physaddr 0)
 - otherwise, do the load, and report any kind of failure of the
   load as an access-fault exception

Do you implement emulation of these platform-specific PMA registers?
If so, those sound to me like they should be some extra level of
checks that your page-table-walk code does before it does the
real physical-address load, similar to how you do the PMP checks.
It doesn't sound to me quite the same as the return value from
QEMU's address_space_ld* functions, which is more the case of
"the guest misconfigured the PMA registers and did an access
that passed the PMA checks but which the actual device rejected".

thanks
-- PMM


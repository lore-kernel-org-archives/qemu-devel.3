Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB267C3065C
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 07:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPGqU-00018p-Hj; Thu, 04 Jul 2024 03:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPGqP-00017a-VX; Thu, 04 Jul 2024 03:25:32 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPGqM-0008IN-RC; Thu, 04 Jul 2024 03:25:29 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-70b0428f793so60594b3a.3; 
 Thu, 04 Jul 2024 00:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720077923; x=1720682723; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZQrUtpG+xlk+hJGI1Ct2rMyBgiDEOKzTfhr3UYC3Iow=;
 b=AM8K4FuZWxjHWaKl42JRL8T2qrjhCjY++3Pn8j3UL+tCinBIUFbUMnGeE4rN18qh40
 YICtjkZlfiJszcMnB0GvestYqqoqQXRwrJyuF72SqPjwFZLc2i+KtGJjJw3qz0tkcw18
 CMt6/x0kp3qGJWjUgGKs+epOSlpG1VvxuQu7Pa0gf7SqdmKObVXpPYnibHE8mkZRQ+6T
 2yy3RE96wGQGw+JvECDibWjp+I4vdc7f+3dZAWiMsrbYxjuOWuxwF+i+QmehtSoKgWLF
 +ei6WzBLgMuCl11hLcTQSdlheKAxAlPJcXB18L/FsL5aG9dohSnfh7n71CCHKVvgojDs
 auAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720077923; x=1720682723;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZQrUtpG+xlk+hJGI1Ct2rMyBgiDEOKzTfhr3UYC3Iow=;
 b=QJj37kNnYzcmVMEujWDsCAHRmN4hmgzi1O9N2dPq0HhzyKN6FWJDRMhzo8w4KLe2f+
 EpJXRfQ7JUcd++e+kIYvYSu4manbQtVBW7963Fj1RVOLYDtbXAL3BtfN5wPDJz2DpQ/g
 //ZvqKPezpvUXOb2+IA5J/ao1Bxh4WxVd//ZKcAZnLQUfZY80ZC9oPfwCDrgo3i5+j40
 jb9nWP/BZRVDGXchAMM6wEMNAf0iBv7gse3mWqzInki1DAUcyfTd/LheJiKvRM1+GjYu
 57ZSCYRuUcJjnMNXgWypGShtCHnX/9CQaebTJDSvcBUMjbQNkyhOpunc8KJ2mHbkA4mM
 rRMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdjjlUa2Go0tSvqixDfQMzwyRudLSJwickBFP9TdLHBTmjFoBFJseEx1cbLtyqSdOFPWja7P0iqydV1wWmMikiuYULKEQDeMlIGkGA2D0jk8hfoO1sxpCN0+M=
X-Gm-Message-State: AOJu0Yz6RgmM8klMpzg6Xgf3EzeRl31O7j9OsNmLu8FSy/D/QDIbybUh
 u4UIcgKeGK8Xc8//NeRV+1uz26LrErcz9A0wkKv4syGFnP3IHIGFAZHewA==
X-Google-Smtp-Source: AGHT+IEd9XWTmdOrp/kTYSD7nGreY6JbRzHiOcIbw+BBNELlyFzaCfERop4RBa0LPNwtaWcIB0Ds9A==
X-Received: by 2002:a05:6a00:2292:b0:708:10:f42d with SMTP id
 d2e1a72fcca58-70b0095b829mr791280b3a.14.1720077923420; 
 Thu, 04 Jul 2024 00:25:23 -0700 (PDT)
Received: from localhost ([1.146.24.72]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70afeb4186esm800778b3a.41.2024.07.04.00.25.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 00:25:23 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 17:25:17 +1000
Message-Id: <D2GKQEIL9SE1.9Q0GOOG6V6M8@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH 40/43] target/ppc: Change parameter type of
 ppc64_v3_radix()
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1716763435.git.balaton@eik.bme.hu>
 <4cdbb66fc918f00f51e6fb6266e1b0714496b266.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <4cdbb66fc918f00f51e6fb6266e1b0714496b266.1716763435.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
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

On Mon May 27, 2024 at 9:13 AM AEST, BALATON Zoltan wrote:
> This function takes PowerPCCPU but only needs the env from it. Change
> its parameter to CPUPPCState *env.

Acked-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/ppc/spapr_rtas.c        | 2 +-
>  target/ppc/mmu-book3s-v3.h | 4 ++--
>  target/ppc/mmu_common.c    | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index f329693c55..38e94fc0d7 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -177,7 +177,7 @@ static void rtas_start_cpu(PowerPCCPU *callcpu, Spapr=
MachineState *spapr,
>           * New cpus are expected to start in the same radix/hash mode
>           * as the existing CPUs
>           */
> -        if (ppc64_v3_radix(callcpu)) {
> +        if (ppc64_v3_radix(&callcpu->env)) {
>              lpcr |=3D LPCR_UPRT | LPCR_GTSE | LPCR_HR;
>          } else {
>              lpcr &=3D ~(LPCR_UPRT | LPCR_GTSE | LPCR_HR);
> diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
> index be66e26604..e52129ff7f 100644
> --- a/target/ppc/mmu-book3s-v3.h
> +++ b/target/ppc/mmu-book3s-v3.h
> @@ -75,9 +75,9 @@ bool ppc64_v3_get_pate(PowerPCCPU *cpu, target_ulong lp=
id,
>   * dig out the partition table in the fast path. This is
>   * also how the HW uses it.
>   */
> -static inline bool ppc64_v3_radix(PowerPCCPU *cpu)
> +static inline bool ppc64_v3_radix(CPUPPCState *env)
>  {
> -    return !!(cpu->env.spr[SPR_LPCR] & LPCR_HR);
> +    return !!(env->spr[SPR_LPCR] & LPCR_HR);
>  }
> =20
>  #endif /* TARGET_PPC64 */
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index b45eb64f6e..ab055ca96b 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -565,7 +565,7 @@ void dump_mmu(CPUPPCState *env)
>          dump_slb(env_archcpu(env));
>          break;
>      case POWERPC_MMU_3_00:
> -        if (ppc64_v3_radix(env_archcpu(env))) {
> +        if (ppc64_v3_radix(env)) {
>              qemu_log_mask(LOG_UNIMP, "%s: the PPC64 MMU is unsupported\n=
",
>                            __func__);
>          } else {
> @@ -810,7 +810,7 @@ bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAcces=
sType access_type,
>      switch (cpu->env.mmu_model) {
>  #if defined(TARGET_PPC64)
>      case POWERPC_MMU_3_00:
> -        if (ppc64_v3_radix(cpu)) {
> +        if (ppc64_v3_radix(&cpu->env)) {
>              return ppc_radix64_xlate(cpu, eaddr, access_type, raddrp,
>                                       psizep, protp, mmu_idx, guest_visib=
le);
>          }



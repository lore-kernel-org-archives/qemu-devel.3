Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39FBD132C7
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 13:39:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7xHz-0007Fz-I6; Mon, 04 Nov 2024 08:38:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t7xHr-0007Dg-E5
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 08:38:31 -0500
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t7xHp-00029U-1P
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 08:38:31 -0500
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2fb5be4381dso37432121fa.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 05:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730727507; x=1731332307; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=go9/v40Y/7RdK76AIxCKH2IKaRhoqjtAJzDbG/iGJ6A=;
 b=T6lKTxVK4PKCGTnH2F5otPq4Va5uUFZgSBQd44jlHigPVZ7sUyX09GFHXtZTscrsQZ
 VRHxy98U224BOBQuqam4OeNyVjhPl14X4NDw5PN1K6sb8XpPNcmICMc3aU1hTr5eNYKm
 sLu/0kArT0wHSDPK63Du2v8vGSbUZwg4gMbdvAwdz1165M9J0DpL++2SkbCzEXzdZ87A
 YPMvotcABx6gTzUrwpXKHvSmjbCMlne2iwVEn31v+8x4MBboHvdSEaXXZgc7Jdu/z/D6
 2sEB7XbEbZsaMuShaTwOf5CiHOZSYCFV+q0HTf5KOPsiDQq0PLWaw+T7YumN9bxlwmRo
 cXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730727507; x=1731332307;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=go9/v40Y/7RdK76AIxCKH2IKaRhoqjtAJzDbG/iGJ6A=;
 b=W5iUIPWYBblP0ZyDAHpz50cCk1SF+zZO2uwRvKtXE66a8MY5VPZJHrRQSs9IPIUvnH
 UnQ1rPS/EgMTOYtc9qDTRtqvJLzHzqD2W5L3xAkVsg1GmN0vYa48TkI4O9qtoXaNzeR7
 1Jjj5pm86X7zwSrV/BtRrgRF3fd+W/EVSlKRB7tm1SSjxwW4UW0EfsRU4QGGHGF03L5H
 a5ZlkTxg04w+xe5seHa9XBgus45UVkBAtL2xOLbIxij80YeBufO7HqleBns1ytFbsGFE
 ZmiQGEtrmjF4Rvjk6PxndmF4eDot60JK2IzD4XjAkylCoXaiwnbaEzeTFIQCWHrEzJe8
 u0Wg==
X-Gm-Message-State: AOJu0Yx4a7qWf2sthzt21zB8WUZK9QfzyTRZxKNSEDkwGOKtvvky5Y/L
 Ozi2itrpxH60E5yV46m6IfHQa33wVMhQ11Veeu068GHVNOVTk9rQFxBk6ILinopNpHpB6br+BIH
 hmhWSb5WWadba9XS3GhLxILGFy8Cg9sWcOow7pg==
X-Google-Smtp-Source: AGHT+IE40dRHnJ9VMhdmQ2IW9Gu+tsqZR7xVnmFn+hcCvSbAIIHkBIT2uGmWtii2jURArYbNVxk5XBDnK/Z391/R6Uc=
X-Received: by 2002:a2e:be84:0:b0:2fb:4f2e:5be7 with SMTP id
 38308e7fff4ca-2fcbdfe4a77mr158336871fa.24.1730727506909; Mon, 04 Nov 2024
 05:38:26 -0800 (PST)
MIME-Version: 1.0
References: <20241101013541.883785-1-gustavo.romero@linaro.org>
In-Reply-To: <20241101013541.883785-1-gustavo.romero@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Nov 2024 13:38:15 +0000
Message-ID: <CAFEAcA-aNf7ca1jYc0YnzSYKjvC42u178gmFTB+5p+TSgz0MfA@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Enable FEAT_CMOW for -cpu max
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, alex.bennee@linaro.org, 
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x235.google.com
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

On Fri, 1 Nov 2024 at 01:36, Gustavo Romero <gustavo.romero@linaro.org> wrote:
>
> FEAT_CMOW introduces support for controlling cache maintenance
> instructions executed in EL0/1 and is mandatory from Armv8.8.
>
> On real hardware, the main use for this feature is to prevent processes
> from invalidating or flushing cache lines for addresses they only have
> read permission, which can impact the performance of other processes.
>
> QEMU implements all cache instructions as NOPs, and, according to rule
> [1], which states that generating any Permission fault when a cache
> instruction is implemented as a NOP is implementation-defined, no
> Permission fault is generated for any cache instruction when it lacks
> read and write permissions.
>
> QEMU does not model any cache topology, so the PoU and PoC are before
> any cache, and rules [2] apply. These rules states that generating any
> MMU fault for cache instructions in this topology is also
> implementation-defined. Therefore, for FEAT_CMOW, we do not generate any
> MMU faults either, instead, we only advertise it in the feature
> register.
>
> [1] Rule R_HGLYG of section D8.14.3, Arm ARM K.a.
> [2] Rules R_MZTNR and R_DNZYL of section D8.14.3, Arm ARM K.a.
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>  docs/system/arm/emulation.rst | 1 +
>  target/arm/cpu-features.h     | 5 +++++
>  target/arm/cpu.h              | 1 +
>  target/arm/tcg/cpu64.c        | 1 +
>  4 files changed, 8 insertions(+)
>
> diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
> index 35f52a54b1..a2a388f091 100644
> --- a/docs/system/arm/emulation.rst
> +++ b/docs/system/arm/emulation.rst
> @@ -26,6 +26,7 @@ the following architecture extensions:
>  - FEAT_BF16 (AArch64 BFloat16 instructions)
>  - FEAT_BTI (Branch Target Identification)
>  - FEAT_CCIDX (Extended cache index)
> +- FEAT_CMOW (Control for cache maintenance permission)
>  - FEAT_CRC32 (CRC32 instructions)
>  - FEAT_Crypto (Cryptographic Extension)
>  - FEAT_CSV2 (Cache speculation variant 2)
> diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
> index 04ce281826..e806f138b8 100644
> --- a/target/arm/cpu-features.h
> +++ b/target/arm/cpu-features.h
> @@ -802,6 +802,11 @@ static inline bool isar_feature_aa64_tidcp1(const ARMISARegisters *id)
>      return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, TIDCP1) != 0;
>  }
>
> +static inline bool isar_feature_aa64_cmow(const ARMISARegisters *id)
> +{
> +    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, CMOW) != 0;
> +}
> +
>  static inline bool isar_feature_aa64_hafs(const ARMISARegisters *id)
>  {
>      return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, HAFDBS) != 0;
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 8fc8b6398f..1ea4c545e0 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1367,6 +1367,7 @@ void pmu_init(ARMCPU *cpu);
>  #define SCTLR_EnIB    (1U << 30) /* v8.3, AArch64 only */
>  #define SCTLR_EnIA    (1U << 31) /* v8.3, AArch64 only */
>  #define SCTLR_DSSBS_32 (1U << 31) /* v8.5, AArch32 only */
> +#define SCTLR_CMOW    (1ULL << 32) /* FEAT_CMOW */
>  #define SCTLR_MSCEN   (1ULL << 33) /* FEAT_MOPS */
>  #define SCTLR_BT0     (1ULL << 35) /* v8.5-BTI */
>  #define SCTLR_BT1     (1ULL << 36) /* v8.5-BTI */
> diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
> index 0168920828..2963d7510f 100644
> --- a/target/arm/tcg/cpu64.c
> +++ b/target/arm/tcg/cpu64.c
> @@ -1218,6 +1218,7 @@ void aarch64_max_tcg_initfn(Object *obj)
>      t = FIELD_DP64(t, ID_AA64MMFR1, ETS, 2);      /* FEAT_ETS2 */
>      t = FIELD_DP64(t, ID_AA64MMFR1, HCX, 1);      /* FEAT_HCX */
>      t = FIELD_DP64(t, ID_AA64MMFR1, TIDCP1, 1);   /* FEAT_TIDCP1 */
> +    t = FIELD_DP64(t, ID_AA64MMFR1, CMOW, 1);     /* FEAT_CMOW */
>      cpu->isar.id_aa64mmfr1 = t;
>
>      t = cpu->isar.id_aa64mmfr2;

We don't need to do anything for the actual cache operations,
but we do need to make sure that the SCTLR_ELx and HCRX_EL2
control bits for it can be set and read back. Our sctlr_write()
doesn't impose a mask, so no change nedeed there, but
our hcrx_write() does set up a valid_mask and doesn't allow
the guest to write bits that aren't in that mask. So we
need to add an
   if (cpu_isar_feature(aa64_cmow, cpu)) {
       valid_mask |= HCRX_CMOW;
   }
in there.

thanks
-- PMM


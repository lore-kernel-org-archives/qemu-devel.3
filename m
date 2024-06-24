Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA9CC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 13:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLjjP-0003Pp-CG; Mon, 24 Jun 2024 09:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sLjjF-0003Oh-SY
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:27:29 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sLjj5-0008Sg-AF
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:27:27 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-57d10354955so4729155a12.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 06:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719235636; x=1719840436; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=50nYGk586z/gKiWcz9UDdTQVKsHnISgxYYZdpSgqZqA=;
 b=SfSgCvBJfwbJC0bhwzD6waASkFEe9HaTAUYLijXmcqQ4c1/mduEOt6jV7vN195tgRG
 SJa6Rfz8NklY/wSp2czgA5m3LSt3Iu3YfNSO3RLc8Akhd1N7orDeA2wED82pCQLh6wze
 /g4g03DQwNY+lPbB5WoVR8nyqAjNR/kMVsMVFkYXYaHf0KNFQ9Hp2pN/RsINprB50paX
 UhWexBhB/0hz4UDObYLYEArje0IWYzNAeGjsfhoO6dl4EQR+817W9rue8Z1W7IApWWpY
 pbz8izT3kKKJI/tgxo+xygIkwaK2N8WaEafIIbBvCG4Zd6r7WlohSA+TjKCRqKu9flnT
 qrag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719235636; x=1719840436;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=50nYGk586z/gKiWcz9UDdTQVKsHnISgxYYZdpSgqZqA=;
 b=o1fKR9Sw7JKBG/pV402h2yY2pH0J/9W7fRjFkfSh22OzmvhAcYMXPyo8eXF3P0Dxf7
 RKGFWLSRpF7MePNwMiULjegxNXhbtwtJtPbu4mCYZHr5FbQzq5oMoUIUhXLOnxU9PfUn
 jm9I1LWo5V9nOU0qioKiN3Mls1qT3aXPKTTlHYJAZbKXgCFmIusDQ6uBL2oF5jGTqVmF
 fz+1OiMsMHC85RKPcXFHxtfPmw4pr7RzzEFyppMh4O9+J5RVkLOUnL5OkdvgpGdAIyvU
 YQUD24R8zXAZkybo43UeQg0xUiaHo9OZAwOnJLMMSiXDkFgPmQVt4NVxsXdzHl6rhQ3e
 rGow==
X-Gm-Message-State: AOJu0YxlSyhkZX/p60Zsya9PcSAeAb2xaegYxcrJw+oxspY5gvnXHZSJ
 D79cZxeuMIr23eFR/CMYnMYBxZDvZxsC8hM+7Ko9oVQXS3BpFBmUwVi7suEG5VAcV2Se+dEqva+
 VCTPtBh8/S78LoEUYGSQXZAw/R7K1tki/ndE7Rg==
X-Google-Smtp-Source: AGHT+IGygVPw927zyTHptOApZJWM3M/fjSLxb1Rm66H2ppnru5hfckRUGTQQaSURRCp2q4/k5V/mlKVS7Csj51yFpyI=
X-Received: by 2002:a50:d504:0:b0:57c:749f:f5ef with SMTP id
 4fb4d7f45d1cf-57d4a020170mr3045706a12.34.1719235636161; Mon, 24 Jun 2024
 06:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240621143903.3598230-1-gustavo.romero@linaro.org>
 <20240621143903.3598230-3-gustavo.romero@linaro.org>
In-Reply-To: <20240621143903.3598230-3-gustavo.romero@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jun 2024 14:27:05 +0100
Message-ID: <CAFEAcA_tNM7Oo+rHHTCBW=LpibieQNktczqv2R=34gPv5smD_g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] target/arm: Enable FEAT_Debugv8p8 for -cpu max
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, 
 richard.henderson@linaro.org, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Fri, 21 Jun 2024 at 15:39, Gustavo Romero <gustavo.romero@linaro.org> wrote:
>
> Enable FEAT_Debugv8p8 for max CPU. This feature is out of scope for QEMU
> since it concerns the external debug interface for JTAG, but is
> mandatory in Armv8.8 implementations, hence it is reported as supported
> in the ID registers.
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>  target/arm/tcg/cpu32.c | 6 +++---
>  target/arm/tcg/cpu64.c | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
> index b155a0136f..a1273a73a3 100644
> --- a/target/arm/tcg/cpu32.c
> +++ b/target/arm/tcg/cpu32.c
> @@ -82,8 +82,8 @@ void aa32_max_features(ARMCPU *cpu)
>      cpu->isar.id_pfr2 = t;
>
>      t = cpu->isar.id_dfr0;
> -    t = FIELD_DP32(t, ID_DFR0, COPDBG, 9);        /* FEAT_Debugv8p4 */
> -    t = FIELD_DP32(t, ID_DFR0, COPSDBG, 9);       /* FEAT_Debugv8p4 */
> +    t = FIELD_DP32(t, ID_DFR0, COPDBG, 10);       /* FEAT_Debugv8p8 */
> +    t = FIELD_DP32(t, ID_DFR0, COPSDBG, 10);      /* FEAT_Debugv8p8 */
>      t = FIELD_DP32(t, ID_DFR0, PERFMON, 6);       /* FEAT_PMUv3p5 */
>      cpu->isar.id_dfr0 = t;
>
> @@ -93,7 +93,7 @@ void aa32_max_features(ARMCPU *cpu)
>      t = 0x00008000;
>      t = FIELD_DP32(t, DBGDIDR, SE_IMP, 1);
>      t = FIELD_DP32(t, DBGDIDR, NSUHD_IMP, 1);
> -    t = FIELD_DP32(t, DBGDIDR, VERSION, 6);       /* Armv8 debug */
> +    t = FIELD_DP32(t, DBGDIDR, VERSION, 10);      /* FEAT_Debugv8p8 */
>      t = FIELD_DP32(t, DBGDIDR, CTX_CMPS, 1);
>      t = FIELD_DP32(t, DBGDIDR, BRPS, 5);
>      t = FIELD_DP32(t, DBGDIDR, WRPS, 3);
> diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
> index 71e1bfcd4e..fe232eb306 100644
> --- a/target/arm/tcg/cpu64.c
> +++ b/target/arm/tcg/cpu64.c
> @@ -1253,7 +1253,7 @@ void aarch64_max_tcg_initfn(Object *obj)
>      cpu->isar.id_aa64zfr0 = t;
>
>      t = cpu->isar.id_aa64dfr0;
> -    t = FIELD_DP64(t, ID_AA64DFR0, DEBUGVER, 9);  /* FEAT_Debugv8p4 */
> +    t = FIELD_DP64(t, ID_AA64DFR0, DEBUGVER, 10); /* FEAT_Debugv8p8 */
>      t = FIELD_DP64(t, ID_AA64DFR0, PMUVER, 6);    /* FEAT_PMUv3p5 */
>      t = FIELD_DP64(t, ID_AA64DFR0, HPMN0, 1);     /* FEAT_HPMN0 */
>      cpu->isar.id_aa64dfr0 = t;
> --

We also need to add Feat_Debugv8p8 to the (alphabetically-sorted)
list of emulated features in docs/system/arm/emulation.rst.

thanks
-- PMM


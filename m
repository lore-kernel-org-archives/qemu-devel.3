Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D703DC87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 20:20:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiIh8-00016E-QW; Sat, 02 Aug 2025 16:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiIct-0006CR-6Q
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:14:43 -0400
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiIcr-00025m-4Z
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:14:42 -0400
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e8e014c1d19so1591678276.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 13:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754165679; x=1754770479; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rjbXbAyuKLaEofKyKoOMeUrPxubelBMgbQd2XMVAI+0=;
 b=zZAl3/10VUUDtB2N4edAId/F1PH6Be6WUjvIh4RU+xu3Grp7NHh0AeZjuIljYR0lE/
 wCQY+Nk1iR8keKWxyzqBF6JliMaIxJiSQtcALQJxIqaG72ih/lp6smeUtyq8qoBhGD3E
 DIdoFnEDhoMFA5/j6cF4tWNzOFnttaI39Cd2EMVLsRWj7e0NTBI1jkl4wz8RONtgxtoi
 nIBiHF4F4oEs8qC9wpcksvlUfvOpKrNS8K3hntO+sydT4Ie3IWOnNxwVULs4jCi/2M+0
 bExfbJZB0dFiU6yoEkPw7vxtn+a0yFWwCAn4ZG5Vz4CJLWl5IcUXG+aMsuJfhGMoPTsL
 W5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754165679; x=1754770479;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rjbXbAyuKLaEofKyKoOMeUrPxubelBMgbQd2XMVAI+0=;
 b=NK9P0ZBHtfRINTlPmDwyhmlmd6+WtKOisu+Tzv3dD5Gu+3M1Pf4puZtbkXtAD30xzo
 pcIzPgcrpgxZQv/Q1/JcB/jaK0zqx1RadM0hicDAosZDdRM23t3XyIf7Efy4bt5eJGrz
 v1kakS8bwdAVE05kaErvgyY+QVUcapw+iSr2StX/aQEpkK340FtWy0B11RRL+01J4BDc
 C/gSEZrTKdvhWSH59meTSei/u6OnS7DLihKTwmlC7FCtk6ifBbFJ4MaHC8rPUHZtGMM3
 kVPd3kwD50h4SVUkMrqAXJLyiTWtyrioi4zSdLYtzmzy6l903hXnFJBtB0D/qskBk8kJ
 /g3Q==
X-Gm-Message-State: AOJu0YzFYcbHV5po4FOPa0ptWUMYMkMJ5Bf09L5oBFyLYOQWVMhNeCUJ
 s5RHJNyhLO4LbRUvsre2X0fAA9KcsmTxEn82UxNbS7YWllVhc5/fu5ftBwSs9vrtv0x2RHH28Um
 GnBlq5PkkDiv5NeuBob+J9K/hYdr/nFHOm7KII4thY12ITO4SSTb7
X-Gm-Gg: ASbGnct1kj73U0j2OEjnd2sm8L16fJA8DcFpL0ayz5o5AKYeKwH634Kr4vA0Gg2+D2o
 4v5xF8ZAmE9ga62SlgIFq6F21DQXw4iBWixGD2ar1jd49siaWJ5cnH5QUYmDItbPP0vkYYFYVAL
 4cKJPGvHrNconpWA8Lh1868rYBB//VgdhTFdPochsL/vMg3ME84lRDPAlG5ZxHHe2I3rJDTocwB
 rT4giroYO2KzfdDsJ0=
X-Google-Smtp-Source: AGHT+IHraeP6oAIoC8Ljl6qPBBROGC3vh6qFatHW6J7BDD8N2jbTYfJzz/g/eJ+Katzz8drf9WR7u1ZsEn+goX4dRB4=
X-Received: by 2002:a05:690c:17:b0:71a:1f26:5d1a with SMTP id
 00721157ae682-71b7ed84355mr45697247b3.11.1754165679502; Sat, 02 Aug 2025
 13:14:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-62-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-62-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 2 Aug 2025 21:14:28 +0100
X-Gm-Features: Ac12FXxzGxFSMyFcQfbJNMkdqeXpCewfNtGnLyP9eHGaWsZxbMmZB3UYG6Ww_-k
Message-ID: <CAFEAcA_wfr5rTAFv-yJyHqSmiYRVrPgDHyzhZFkFLn0gZmuUmw@mail.gmail.com>
Subject: Re: [PATCH 61/89] linux-user: Move get_elf_cpu_model to
 target/elfload.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb30.google.com
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

On Wed, 30 Jul 2025 at 01:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Rename from cpu_get_model to emphasize that this is
> an elf-specific function.  Declare the function once
> in loader.h.
>
> This frees up target_elf.h for other uses.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


> @@ -805,7 +804,7 @@ int main(int argc, char **argv, char **envp)
>      }
>
>      if (cpu_model == NULL) {
> -        cpu_model = cpu_get_model(get_elf_eflags(execfd));
> +        cpu_model = get_elf_cpu_model(get_elf_eflags(execfd));
>      }
>      cpu_type = parse_cpu_option(cpu_model);

Since this patch is just moving stuff around
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

but this got me wondering how the bflt loader works -- it
looks like get_elf_eflags() will always return 0 for a
bflt executable, and because most of the cpu_get_model()
functions for bflt architectures[*] return a fixed string
it all works out, but this seems more like we get lucky
than we actually intended this.

[*] arm, aarch64, m68k, microblaze, sh4, xtensa:
all except m68k return a fixed string; m68k handles
eflags == 0 as "m68040", which may or may not be the
best choice.

thanks
-- PMM


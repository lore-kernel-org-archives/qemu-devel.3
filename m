Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3CD8CF884D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:43:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swlNa-00036s-Jp; Fri, 04 Oct 2024 12:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1swlNQ-0002QP-P6
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:42:02 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1swlNP-0007FA-5U
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:42:00 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2fad784e304so29934341fa.2
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728060117; x=1728664917; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=azbDa+uUZgkoiE0nNqqk7LWwWBBMF8y1EYny/ldtwuc=;
 b=Siw6XttcNgnP1CxMx7nnE0XZvLzNSTXA7J0GPjMigaOOrjYoZ81UBOEDDals4sokpT
 L3bdbnB19AQKMXW2P1TvdqFMEmnwMlKaQHhHz8H2EvpH4DIasSlFdC7XnK8ttFD53h4h
 vz8ChpB8Hy4kYNr3vR+Up/gASMjDipiFmZVthyKQkota0b1G8LPI163oRejDiY9u0frG
 5Bwv72LGkjRNwhlJwDBixtUsxd9mnb1hxDECmxK64geb+ne/P+T9HlbrM7FjtVyl61vH
 BRUxaE1FmPBUXCsMRNoFxD6J285TluxMoGIn7WoJmE/T2MV9WHsXxeUwgnKP9GOvnM4B
 pcdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728060117; x=1728664917;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=azbDa+uUZgkoiE0nNqqk7LWwWBBMF8y1EYny/ldtwuc=;
 b=K78OBu4T3Q3dUjO1zd6nxiK2TxJUR/fi/+cl30vqwUx1JtynPR2vyBVT8hR0xHePvI
 E922wHhml1Jn851ZVz8Lv5HjkDQATdYSqpgep3YJMUPON3yaOU1veJLn2XLJVr3JdYCD
 4GPf0n8NoTrJMEjHBcYoJ7/8nzOtU+XI+k1b9OXFtOowd2V5foprW1DVtxCQxsrgEadW
 ocrsJtqXV5pIqeKBQVeMd7ucVIsyAv8oJ7GqHqs2q41fkE9sKoZyEk/CrK4/1DjWzwIz
 HZGeM2xbKqur7buDkXDvurWHbnjKooUi23lfewbah6kgaSuRk3kJXDiwrFWfRktiWGrL
 9oKw==
X-Gm-Message-State: AOJu0YyCGyS0P00FZJazlhaWYgesoCaS8NJLReWkluabNydrDRqwHdg+
 a8jU5JHPjlicCjv09LiWoJCWNDnuCK2s19UwGkMuUURdXEpyekGoRn6xCBbpSXJEPyDpp/AdAMI
 NJy8ZlmgSwdTt11uZRjl3XS04vqrA+BIRW53igw==
X-Google-Smtp-Source: AGHT+IEanF88ezrZq0a0+UAFeMFMgV8vZJIrOkXklt6SHXOjy5q59K0j68mgJKG63hP4ruHUg9de18XkB4f1Tr7xABM=
X-Received: by 2002:a05:651c:220d:b0:2f7:5d53:7196 with SMTP id
 38308e7fff4ca-2faf3c016cbmr23090901fa.4.1728060117507; Fri, 04 Oct 2024
 09:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <20241004162118.84570-1-philmd@linaro.org>
 <20241004162118.84570-3-philmd@linaro.org>
In-Reply-To: <20241004162118.84570-3-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Oct 2024 17:41:46 +0100
Message-ID: <CAFEAcA_X38bhELuwwKLPrbfC+vLnwpUHP5RNCDv1V2r69dbJ7w@mail.gmail.com>
Subject: Re: [PATCH 2/8] hw/core/cpu: Introduce CPUClass::is_big_endian()
 handler
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, 
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-arm@nongnu.org, 
 Zhao Liu <zhao1.liu@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x234.google.com
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

On Fri, 4 Oct 2024 at 17:22, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Introduce the CPUClass::is_big_endian() handler and its
> common default.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/hw/core/cpu.h | 3 ++-
>  hw/core/cpu-common.c  | 7 +++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 04e9ad49968..22ef7a44e86 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -150,6 +150,7 @@ struct CPUClass {
>      ObjectClass *(*class_by_name)(const char *cpu_model);
>      void (*parse_features)(const char *typename, char *str, Error **errp=
);
>
> +    bool (*is_big_endian)(CPUState *cpu);
>      bool (*has_work)(CPUState *cpu);
>      int (*mmu_index)(CPUState *cpu, bool ifetch);
>      int (*memory_rw_debug)(CPUState *cpu, vaddr addr,

What does this actually mean, though? Arm for instance
has multiple different kinds of "big-endian" depending
on the CPU: both BE32 and BE8, and data-endianness not
necessarily being the same as instruction-endianness.

This series doesn't introduce any users of this new API.
It's hard to say without seeing what the intended use is,
but I would expect that probably they would want to be testing
something else, depending on what they're trying to do.

It's pretty uncommon for anything out in the system to
want to know what endianness a runtime-configurable CPU
happens to be set to, because in real hardware a device
has no way to tell. (This is why cpu_virtio_is_big_endian()
is named the way it is -- to discourage anybody from trying
to use it outside the virtio devices where we need it for
legacy "the spec wasn't written thinking about endianness
very hard" reasons.)

thanks
-- PMM


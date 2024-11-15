Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA7DD68BC6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 15:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tByeM-0001OV-0g; Fri, 15 Nov 2024 10:54:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tByeL-0001ON-1V
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:54:21 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tByeJ-000246-Jm
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:54:20 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5cece886771so3258438a12.0
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 07:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731686058; x=1732290858; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rLfvASpctiDDurpEVlal7+rKcaWW5LTZwKkhBB2f9+M=;
 b=FVvC+caxMTrwZQbYp9WxCoG11LrUIWFge2J/mA2RrmuUuGq0X+h+ep9E7Nx6NqeCih
 nJb6pXgU2J1N4uQN9JOOXzXNnQY0hke+WsjOYoWNMYOUniD/lQ/ABr1edFAcFHC+KYuY
 tUEZffFf/0cRibPvyTJdyCFTR81XB66XsBTB+IZw9TNJ82E2GRTk/AFesPz9hp48g1VD
 37ZXnehgHgJt+NFPMrD1NhvcZU/lkfNVJ/5djSybBHS6+Ers0fpT9cXPW4Q+5j1caHjZ
 VXum/B1vYQj4+VClHRJjTxjAtpTDNq7JSHnrbUk6dDe4ufR+bb1KyC65Pi2lsSs4Xy46
 QcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731686058; x=1732290858;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rLfvASpctiDDurpEVlal7+rKcaWW5LTZwKkhBB2f9+M=;
 b=P19MhUQZg4JYkqDVkh3oNu9czCvxqhnzkDhSY08vLCdxJlVcBHuuRxS9Yzw1eV3+pM
 PyN3CaIi+ZDlgz4dH3TOnTpjWHTKMqcL7BW35mJ6gs9mWcCLpm0aOvPgvjNHLD5tz5Dc
 XgRDhPxMRGrDyRe7Vu5Qm/03gkzQ0yaDRnnOfGSmCggughbpyl8b+Anb1pjIxkMpq/XH
 d5KtdsirhxGKJWW/8H4ttZKm9O8SFVxhJDTdpvJEBBrsIWjwWLe0bHL/oB3HmaFqJAk8
 P62m9tjNbglMhaQbLwOP2KI91NC233rFHvBP1puplBGuqQk5UtrtllKpE/VcKew6WXHu
 3oww==
X-Gm-Message-State: AOJu0Yxpc5JD5cXzzT0YgtExnvYApL7FsQiCJI01+G4kA6nPWHyKCLuY
 uvJD+4R4GQxIC6NzpFAL6tSh2sOaz0TW8uBaqMkrYrbyoEi9wknRovgzu7XArbYB3Wg8UY5nnSZ
 sHgf5nzne5U2+F6o99g5KEtKrAKpd4MKH5i0lvg==
X-Google-Smtp-Source: AGHT+IGQiaTSi7ZLJA4V5YxkVDGRrBf0AmLUd2viwvz7YlN7dG2SzB1bf0fbWzSVEi4pOs/wO29bXTnf/Rm4xUW3qHY=
X-Received: by 2002:a05:6402:5d3:b0:5cf:8593:8e95 with SMTP id
 4fb4d7f45d1cf-5cf8593951bmr4908445a12.15.1731686057589; Fri, 15 Nov 2024
 07:54:17 -0800 (PST)
MIME-Version: 1.0
References: <20241115152053.66442-1-philmd@linaro.org>
 <20241115152053.66442-9-philmd@linaro.org>
In-Reply-To: <20241115152053.66442-9-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Nov 2024 15:54:06 +0000
Message-ID: <CAFEAcA8X8zp7oXKjiVOL_uCGdM8r00jW6S1efkm-M6f4fEuGdg@mail.gmail.com>
Subject: Re: [PATCH 08/10] hw/core/cpu: Pass CPUArchState to set/get_pc()
 handlers
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Fri, 15 Nov 2024 at 15:22, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> CPUClass set_pc() and get_pc() handlers are target specific.
> Rather than passing a generic CPUState and forcing QOM casts,
> we can directly pass the target CPUArchState, simplifying.

> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index db8a6fbc6e..70f5f8c3bf 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -160,8 +160,8 @@ struct CPUClass {
>      int64_t (*get_arch_id)(CPUState *cpu);
>      bool (*cpu_persistent_status)(CPUState *cpu);
>      bool (*cpu_enabled_status)(CPUState *cpu);
> -    void (*set_pc)(CPUState *cpu, vaddr value);
> -    vaddr (*get_pc)(CPUState *cpu);
> +    void (*set_pc)(CPUArchState *env, vaddr value);
> +    vaddr (*get_pc)(CPUArchState *env);
>      int (*gdb_read_register)(CPUState *cpu, GByteArray *buf, int reg);
>      int (*gdb_write_register)(CPUState *cpu, uint8_t *buf, int reg);
>      vaddr (*gdb_adjust_breakpoint)(CPUState *cpu, vaddr addr);

This is effectively the table of methods for the CPUClass
class. I think that methods on class A should take a pointer to the
object of that type, not to something else.

thanks
-- PMM


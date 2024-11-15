Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 823EAD68BC8
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 15:51:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBybJ-0007Ji-Db; Fri, 15 Nov 2024 10:51:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBybB-0007JQ-54
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:51:07 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tByb8-0001iK-SB
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:51:04 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c9693dc739so2723381a12.3
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 07:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731685860; x=1732290660; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dx5US8P7+hXocxh21Fhd99IuDnLxqT6uyR8PKEdsGyY=;
 b=CSWW6mM25q/RvKJq5O3O9eon5Wbhd9CGCo9gGfi4rJj+T/yJD9ZrGfw/JxsV5XI0I0
 sY1x31FBXuTjj/R2h8LRnZzdOjOPaMVFjRXdQWxO2m7Xj1MbQ6LN9AYjIE8Cd3xh4FXc
 68wa9w8P42OrHsljCq/ic9ASysYGBHEeLvOn++JqMGfEUCDaERcjeGILR9WdJwdPSVxL
 InpDKaCtZLQsSmORYikCXXsoDa5gQ8bbwpOjL4aUCObJMPGCGDOr+k9hjSmSBxGTDg3+
 I9wYyqYFMa0lDVhDO6x2IT6hvKQAMOMpZHXJnWsg0B0VXrsgpXDiEQ6pwH6QQo0KGC4l
 gHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731685860; x=1732290660;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dx5US8P7+hXocxh21Fhd99IuDnLxqT6uyR8PKEdsGyY=;
 b=Idt3glwQEFEWrvEIDVXsbZkNn81za7mJkxV++tWHnaeixcbupD+wveIHk2sEIpSesQ
 Y60Ih2bOA6dTaSlXqMFdp9HljTQxw5adK453onOsTNommUd/ZvgRtXYzdnXGQG9t0WQz
 wlCl80GrN4wMlACWcVXAULm+q2yvlpza9As7sKNVXMyNkyjDCRm3cKPG+UJgstOKI1Ds
 8v3aeJDKuWfEMzSf/VCb4JKwHh/se/wZ8gIl5LaniHA73o4/6hlMwnPWeroo/J+LHHp2
 a8TRiCTcwkTx9fTZlnTibMh20uug1RhHt4AQm49oZQgxh0TDkqRaXQOjmCknReGEQg2/
 2tyQ==
X-Gm-Message-State: AOJu0YzkHsFfR2qYXl5o68hHyOJ5npFTb3mNwVzKTmq6A1UNsCSgRzQ1
 SVwFqy2dTF6K/d4Y6BVweDQToMVYju4yEdP6DuweaaxbfVxelP1m3t5hy557h+K1PaDuzcW+ZFS
 Rsg+fCylhUM5yT8/FNymAo6TPxQLtyxfK6J9H+g==
X-Google-Smtp-Source: AGHT+IEnbhUzDjIGOWkRmOO2uIWnhXRa56aFhWujSI6mMRHbvOK3bj4A7Zi6D79nGSmen+oSG363KWGN5c4KNEpuCE4=
X-Received: by 2002:a05:6402:3508:b0:5cf:719d:1fa1 with SMTP id
 4fb4d7f45d1cf-5cf8fc5486bmr2173045a12.6.1731685860010; Fri, 15 Nov 2024
 07:51:00 -0800 (PST)
MIME-Version: 1.0
References: <20241115152053.66442-1-philmd@linaro.org>
 <20241115152053.66442-7-philmd@linaro.org>
In-Reply-To: <20241115152053.66442-7-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Nov 2024 15:50:49 +0000
Message-ID: <CAFEAcA8VoFaxt5qT1st=y3NEWmjhgf34t8om1JvZ8zve1besjQ@mail.gmail.com>
Subject: Re: [PATCH 06/10] accel/tcg: Remove cpu_unwind_state_data() unused
 CPUState argument
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Fri, 15 Nov 2024 at 15:23, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/exec/translate-all.h | 3 +--
>  accel/tcg/translate-all.c    | 2 +-
>  target/i386/helper.c         | 3 ++-
>  target/openrisc/sys_helper.c | 7 +++----
>  4 files changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/include/exec/translate-all.h b/include/exec/translate-all.h
> index f06cfedd52..9303318953 100644
> --- a/include/exec/translate-all.h
> +++ b/include/exec/translate-all.h
> @@ -23,7 +23,6 @@
>
>  /**
>   * cpu_unwind_state_data:
> - * @cpu: the cpu context
>   * @host_pc: the host pc within the translation
>   * @data: output data
>   *
> @@ -32,7 +31,7 @@
>   * function returns false; otherwise @data is loaded.
>   * This is the same unwind info as given to restore_state_to_opc.
>   */
> -bool cpu_unwind_state_data(CPUState *cpu, uintptr_t host_pc, uint64_t *d=
ata);
> +bool cpu_unwind_state_data(uintptr_t host_pc, uint64_t *data);
>
>  /* translate-all.c */
>  void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr);
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index fdf6d8ac19..8d5530e341 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -243,7 +243,7 @@ bool cpu_restore_state(CPUState *cpu, uintptr_t host_=
pc)
>      return false;
>  }
>
> -bool cpu_unwind_state_data(CPUState *cpu, uintptr_t host_pc, uint64_t *d=
ata)
> +bool cpu_unwind_state_data(uintptr_t host_pc, uint64_t *data)
>  {
>      if (in_code_gen_buffer((const void *)(host_pc - tcg_splitwx_diff))) =
{
>          TranslationBlock *tb =3D tcg_tb_lookup(host_pc);
> diff --git a/target/i386/helper.c b/target/i386/helper.c
> index 01a268a30b..b848936441 100644
> --- a/target/i386/helper.c
> +++ b/target/i386/helper.c
> @@ -29,6 +29,7 @@
>  #endif
>  #include "qemu/log.h"
>  #ifdef CONFIG_TCG
> +#include "exec/translate-all.h"

Ah, here are those includes. These should be in the
previous patch I think.


-- PMM


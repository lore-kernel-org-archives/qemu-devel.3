Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A4BFC677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 13:42:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPLij-0006aA-8V; Wed, 11 Jun 2025 09:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uPLiY-0006Ym-J8
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 09:42:15 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uPLiW-0001Hy-7y
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 09:42:14 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-60702d77c60so13170523a12.3
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 06:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749649330; x=1750254130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JBeERC2OpBWAx0hdl5mRJmA1H22rFdhWdwR9cbDOlkg=;
 b=NBZEO5U6N3riiv8a8mMtkSa6ST0ww8mrPq+ohf0qiCiU+5+GoYyqs95sWctdf4C8sp
 mLlqEbEoY7dfPCaY8Ej7FbY69tNa2PKqes/MGMrjroihlMjBkMv0HdgCR4UgrjRziE7P
 kbQRDMovPBZbjSk0SPGtMA5SL+3Nc4lZJMKHR1gPHvbhdSpy82MB6kKYrv8fbvElUYmG
 CrY9meJs9keuQANgbVtkV8ksmLVul/teiBPY2vj7BK9bUelvZPm6A+WwlC5a95raePKA
 t6VF7z5hDhyPBtJ58gdeeCMP3KOkPu09v3aaMZtNXwD59Boe2SHj6lXuqOBuXHYcMbxH
 leIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749649330; x=1750254130;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JBeERC2OpBWAx0hdl5mRJmA1H22rFdhWdwR9cbDOlkg=;
 b=AoN/Fd2J8owxJnaUy+DGUankcxn7JpF4uXWGymtaXJ7wTleMdoXkOEsOfwKz+miZ9E
 hVgaFaQAF4bLuUEJQvnoBGXEzzxYpUc0Qjoejo+6+czvwJso4ZYbqDq4IG/v97NcDlBA
 5fd+L5/T0Mok2+bYmiHmztslKgwMn8Wi7zUn+ySHOF5izjjavfj+jRd20P7Ez5PO49dr
 bPgA+u6vU/R1VxCGYoQKz2fhjr1/M94j8ACZavcgnGm9x8oiihgMgE+yuxhqD5TsbC5B
 SRuFXo3XU6e+AObwQTyeWBmdul+BrEFZIcbepDmPbQNYW/znCvLTFhcfeBcQYWOqTunY
 3dgw==
X-Gm-Message-State: AOJu0Yws7FhoUNSNvUMLi71Vm8745UIQQeV2aOsEAImFrfH/bpaEd54b
 hs2xPQaHArQrr/Fbdg0zpyMy4nWQVrqZtKj7hBNU2TI6NKmL6kmsoknrjPOS3RrVj58=
X-Gm-Gg: ASbGnctKXNUJyZ3p9/xbKIakK5Dfenx/jEfMrq6S5LpihKBvQZmQWsTvNAxqxoVszSP
 ZcOyhpOsh0B9TVlx0BLNQnYyOXma1hMLgSRVxZg/ZW6uMGgso3DKgX6QgAhMtQ1PNnOTowHnFpj
 F/+Kj4VbJm52DLQiAZMs8/811zAsE40kbdMvGGU80pHsQuXi9TqF8s0KRBYn7CEdCps2yBsvP4c
 UWrrZsiKFuBWBexJSA8X8rJnajdt4E6BMb+W60Hn3sy3HmqUulVbWJDSpns3prI0puB/WWVCSIM
 msBxJbw13AEw8uvGlZu5AUKjqzcFoeHT4LdBWKZ7xTcvGsZfZ+VAiuQgxdRiq44=
X-Google-Smtp-Source: AGHT+IFgO51fkredh8af2O9Sy4tY2VGCLP6W53AyM62HTCueMsWFYc8VY10Mow5izFFnftK9Qjv0Lw==
X-Received: by 2002:a05:6402:90b:b0:607:e77:f840 with SMTP id
 4fb4d7f45d1cf-60846cb0b51mr2751498a12.26.1749649330024; 
 Wed, 11 Jun 2025 06:42:10 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-607edb5f303sm4341650a12.16.2025.06.11.06.42.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 06:42:09 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 70F1C5F7CB;
 Wed, 11 Jun 2025 14:42:08 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>
Subject: Re: [RFC PATCH 03/19] accel: Keep reference to AccelOpsClass in
 AccelClass
In-Reply-To: <20250606164418.98655-4-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 6 Jun 2025 18:44:02
 +0200")
References: <20250606164418.98655-1-philmd@linaro.org>
 <20250606164418.98655-4-philmd@linaro.org>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Wed, 11 Jun 2025 14:42:08 +0100
Message-ID: <871prql7in.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Allow dereferencing AccelOpsClass outside of accel/accel-system.c.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/qemu/accel.h       | 2 ++
>  include/system/accel-ops.h | 3 ++-
>  accel/accel-system.c       | 3 ++-
>  accel/tcg/tcg-accel-ops.c  | 4 +++-
>  4 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/include/qemu/accel.h b/include/qemu/accel.h
> index fbd3d897fef..23c62cbeb07 100644
> --- a/include/qemu/accel.h
> +++ b/include/qemu/accel.h
> @@ -37,6 +37,8 @@ typedef struct AccelClass {
>      /*< public >*/
>=20=20
>      const char *name;

A comment wouldn't go a amiss here:

 "Cached by accel_init_ops_interfaces when created"?
=20
> +    AccelOpsClass *ops;
> +
>      int (*init_machine)(MachineState *ms);
>      bool (*cpu_common_realize)(CPUState *cpu, Error **errp);
>      void (*cpu_common_unrealize)(CPUState *cpu);
> diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
> index 4c99d25aeff..44b37592d02 100644
> --- a/include/system/accel-ops.h
> +++ b/include/system/accel-ops.h
> @@ -10,6 +10,7 @@
>  #ifndef ACCEL_OPS_H
>  #define ACCEL_OPS_H
>=20=20
> +#include "qemu/accel.h"
>  #include "exec/vaddr.h"
>  #include "qom/object.h"
>=20=20
> @@ -31,7 +32,7 @@ struct AccelOpsClass {
>      /*< public >*/
>=20=20
>      /* initialization function called when accel is chosen */
> -    void (*ops_init)(AccelOpsClass *ops);
> +    void (*ops_init)(AccelClass *ac);
>=20=20
>      bool (*cpus_are_resettable)(void);
>      void (*cpu_reset_hold)(CPUState *cpu);
> diff --git a/accel/accel-system.c b/accel/accel-system.c
> index a0f562ae9ff..64bc991b1ce 100644
> --- a/accel/accel-system.c
> +++ b/accel/accel-system.c
> @@ -85,8 +85,9 @@ void accel_init_ops_interfaces(AccelClass *ac)
>       * non-NULL create_vcpu_thread operation.
>       */
>      ops =3D ACCEL_OPS_CLASS(oc);
> +    ac->ops =3D ops;
>      if (ops->ops_init) {
> -        ops->ops_init(ops);
> +        ops->ops_init(ac);
>      }
>      cpus_register_accel(ops);
>  }
> diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
> index b24d6a75625..da2e22a7dff 100644
> --- a/accel/tcg/tcg-accel-ops.c
> +++ b/accel/tcg/tcg-accel-ops.c
> @@ -198,8 +198,10 @@ static inline void tcg_remove_all_breakpoints(CPUSta=
te *cpu)
>      cpu_watchpoint_remove_all(cpu, BP_GDB);
>  }
>=20=20
> -static void tcg_accel_ops_init(AccelOpsClass *ops)
> +static void tcg_accel_ops_init(AccelClass *ac)
>  {
> +    AccelOpsClass *ops =3D ac->ops;
> +
>      if (qemu_tcg_mttcg_enabled()) {
>          ops->create_vcpu_thread =3D mttcg_start_vcpu_thread;
>          ops->kick_vcpu_thread =3D mttcg_kick_vcpu_thread;

otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


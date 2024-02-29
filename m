Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F47FC54E41
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 15:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfiFa-0007Xd-NL; Thu, 29 Feb 2024 10:23:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfiFY-0007VZ-8J
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 10:23:08 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfiFW-0004cd-IK
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 10:23:08 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-33e1878e357so21737f8f.3
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 07:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709220185; x=1709824985; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p7a7cmw9D7kG1CrrnA+QDIOpeu9Q/U4tj8lWc5ws3b0=;
 b=Q0GfkStzLvzi9a/wBjIj+Lsjc7CnLAlF9cc5HgOoXE738YDicJakIBQx3ylVqjBU3q
 IR5nGdmcyrP/y6xIFqQ8UXmZnWdtO6AAcuRIRk/rWz9cHSlcs4QFkTKtzpijfUIQDs1l
 5lurLSyHJUP8wdBP9U1gbByHQivTSM95R00CdArwn/toFhew7TGZbkgNkDq46Uc1S9vF
 AqD0+RUoDa6hUfJVql7wAn9RyKeKjoV5bljUl0EWcmL/iUefOzA/EnkxQu3vCDK0eqle
 YvMhuypabIShc0AGJJCdDj43abPSdwQwXs54HwX2E2m1p8C3Vok2wBrliYLTmg4+OhU4
 ilpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709220185; x=1709824985;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p7a7cmw9D7kG1CrrnA+QDIOpeu9Q/U4tj8lWc5ws3b0=;
 b=lX38LNznKGE06fqhX/G65L1B6CCVaGy6efqhtrHde3dGr3YPKaeV2JhaTxvu6Yhfxo
 XLfvbWu4hW/W/es1hJu1YGlr8OQuoS1oZwEZdeWsFq+OXfUXbZKGsIT9UY7uLUdsb84D
 yjqCKCrKpiZjMYO6oD7JHxImKT6RM8r8WBRJG7dQWwyPr6ENi/5OIIhcaBr3UrMsEKUk
 lgOS9zjEuIxxDvyktGUocaQ50gZFGdiGa2gvipWvzUQ0Rfca4QIInYPnR/R4Y7GNW5l+
 Dt1bZsubCjZm4IogAOjy/DSRj+euMahNyxPfvEqsO/2G7p8nvJSxCcbkPyDQ+dvpGvyC
 aaJg==
X-Gm-Message-State: AOJu0YzM5e0d0yIxHaiyHEL4bCmgYrhv9Dtw+5CEDkB5L08gT7ojRkF3
 SiRB/oG/6rfK0vv17xZ/QCtkTzRlh6PTpcy64EE3WhphDflUu/5BOTIvTmgSLyw=
X-Google-Smtp-Source: AGHT+IFISg8OWdooq8wcPPRtNjMFM/wYSYmFX47OxhcFbRTka3H2FLNdx+le9Cg0zEbiPjTsdhztqA==
X-Received: by 2002:a5d:6e0d:0:b0:33e:67c:7721 with SMTP id
 h13-20020a5d6e0d000000b0033e067c7721mr1887182wrz.26.1709220184870; 
 Thu, 29 Feb 2024 07:23:04 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bn26-20020a056000061a00b0033e032bc26bsm2068225wrb.82.2024.02.29.07.23.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 07:23:04 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C4B525F8F9;
 Thu, 29 Feb 2024 15:23:03 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nicolas Eder <nicolas.eder@lauterbach.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, "Christian Boenig" <christian.boenig@lauterbach.com>
Subject: Re: [PATCH v5 03/18] gdbstub: GDBRegisterState moved to gdbstub.h
 so it can be used outside of the gdbstub
In-Reply-To: <20231220162555.19545-4-nicolas.eder@lauterbach.com> (Nicolas
 Eder's message of "Wed, 20 Dec 2023 17:25:40 +0100")
References: <20231220162555.19545-1-nicolas.eder@lauterbach.com>
 <20231220162555.19545-4-nicolas.eder@lauterbach.com>
User-Agent: mu4e 1.12.0; emacs 29.1
Date: Thu, 29 Feb 2024 15:23:03 +0000
Message-ID: <87jzmn8fc8.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Nicolas Eder <nicolas.eder@lauterbach.com> writes:

> ---
>  debug/gdbstub/gdbstub.c | 8 --------
>  include/exec/gdbstub.h  | 8 ++++++++
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/debug/gdbstub/gdbstub.c b/debug/gdbstub/gdbstub.c
> index f43d4355c0..5df7841878 100644
> --- a/debug/gdbstub/gdbstub.c
> +++ b/debug/gdbstub/gdbstub.c
> @@ -45,14 +45,6 @@
>=20=20
>  #include "internals.h"
>=20=20
> -typedef struct GDBRegisterState {
> -    int base_reg;
> -    int num_regs;
> -    gdb_get_reg_cb get_reg;
> -    gdb_set_reg_cb set_reg;
> -    const char *xml;
> -} GDBRegisterState;
> -
>  GDBState gdbserver_state;
>=20=20
>  void gdb_init_gdbserver_state(void)
> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
> index d8a3c56fa2..cdbad65930 100644
> --- a/include/exec/gdbstub.h
> +++ b/include/exec/gdbstub.h
> @@ -27,6 +27,14 @@ typedef struct GDBFeatureBuilder {
>  typedef int (*gdb_get_reg_cb)(CPUArchState *env, GByteArray *buf, int re=
g);
>  typedef int (*gdb_set_reg_cb)(CPUArchState *env, uint8_t *buf, int reg);
>=20=20
> +typedef struct GDBRegisterState {
> +    int base_reg;
> +    int num_regs;
> +    gdb_get_reg_cb get_reg;
> +    gdb_set_reg_cb set_reg;
> +    const char *xml;
> +} GDBRegisterState;
> +

There is a clash with the recent GDBFeature changes. I think this is
still private to the debug sub-system so maybe it belongs in:

 debug/registers.h

and then the subdirs can just do:

  #include "../registers.h"

>  /**
>   * gdb_register_coprocessor() - register a supplemental set of registers
>   * @cpu - the CPU associated with registers

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


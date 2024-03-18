Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA319C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 17:45:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmH2I-0004As-31; Mon, 18 Mar 2024 13:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rmH2G-00049t-6j
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 13:44:32 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rmH2A-0004c5-6b
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 13:44:29 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a28a6cef709so699122566b.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 10:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710783863; x=1711388663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+JVxF+9Fn2CBZqEc5cVMjIAZykPNOYMGBJCn69nOpEQ=;
 b=SffREY7KMqaqAun7nkXzjfpLPWPztvlZzMNu34UfAQwxQiQWAuAoUxIIHpFtMEp8l7
 NDm+eg9j8ckytskk2sG2GYZt+VR+mTvw0F0o3VWnxoeLHWtTId3hKg6NX91/S4elcTie
 +uitHuDUpW4LVRuE52ysaBnajKonkYlrw1mNapZ5RaWizlKEpm+onmrqkmVL4aD34lql
 MvaDNsVJMCOHV/HBzknJIdY5cun5KgoNGkqEoPA5m7+eafoI5uejZhTZksWsSX55Aspj
 BbTQw5NLSaL3RCo5kcEAYiqj09feUu9AJRXKDdx+3J/ZVsNDlnuQIDmSPSzgOVNhsR67
 USRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710783863; x=1711388663;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+JVxF+9Fn2CBZqEc5cVMjIAZykPNOYMGBJCn69nOpEQ=;
 b=lMjAGwFGGX/ys297HVLuYhQqkU0Xn6s65pwIZEuaQUAc7NYFrjvlxHFDQ0JRg3ALUy
 OTeFbmtBEFgg3a+6kRskBx/O/fvw/2avksXoOjIu4DUvm4DAOtpZI0/NBM0zBw63sLmE
 7S908DrZ3KOX0fB+lL9iYjjDLmPGyz9W1k899Lv6jGk4QJDVLPtSL+dJT+K7/rh0dRYa
 x9VUgvkgHh5VKvNBBDAlQ/N73MtpEkCkLkdL0dmqzpaYvV3b76jl1mSw/9RJjArUF1k2
 0JzVawZIfdp/A01pDc2VOFnCaxZHvn7Xim/tQdJuxqYp4Cx8vzut841lLp0rYz7V+mMu
 h5lg==
X-Gm-Message-State: AOJu0YxhwIpDFjprS+tBW8a7Z7zzqvueCVoTST4hBBTK8WUekmFofgJm
 TS76ulkUFEuqBiIO/13k5zcWjN09LsYNnmtIPr/lLL+Sb1UpAt5UBoXuscVcT08=
X-Google-Smtp-Source: AGHT+IHvU2aRRXGxieAvvzTeBST+BxwwLjNtvmdHe7AusK3Wq2IiUbZk/McWls4ZITdV1VC28l8Ukw==
X-Received: by 2002:a17:906:4c43:b0:a46:d592:43ea with SMTP id
 d3-20020a1709064c4300b00a46d59243eamr377382ejw.76.1710783862739; 
 Mon, 18 Mar 2024 10:44:22 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 go34-20020a1709070da200b00a44180ab871sm5033788ejc.50.2024.03.18.10.44.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 10:44:22 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EE3D05F856;
 Mon, 18 Mar 2024 17:44:21 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  pierrick.bouvier@linaro.org
Subject: Re: [PATCH 20/22] plugins: Move qemu_plugin_insn_cleanup_fn to tcg.c
In-Reply-To: <20240316015720.3661236-21-richard.henderson@linaro.org> (Richard
 Henderson's message of "Fri, 15 Mar 2024 15:57:18 -1000")
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
 <20240316015720.3661236-21-richard.henderson@linaro.org>
User-Agent: mu4e 1.12.2; emacs 29.2
Date: Mon, 18 Mar 2024 17:44:21 +0000
Message-ID: <87il1j5tai.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> This is only used in one place, and usage requires an
> out-of-line function.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/qemu/plugin.h | 12 ------------
>  tcg/tcg.c             | 12 ++++++++++++
>  2 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
> index 07b1755990..201889cbee 100644
> --- a/include/qemu/plugin.h
> +++ b/include/qemu/plugin.h
> @@ -116,18 +116,6 @@ struct qemu_plugin_scoreboard {
>      QLIST_ENTRY(qemu_plugin_scoreboard) entry;
>  };
>=20=20
> -/*
> - * qemu_plugin_insn allocate and cleanup functions. We don't expect to
> - * cleanup many of these structures. They are reused for each fresh
> - * translation.
> - */
> -
> -static inline void qemu_plugin_insn_cleanup_fn(gpointer data)
> -{
> -    struct qemu_plugin_insn *insn =3D (struct qemu_plugin_insn *) data;
> -    g_byte_array_free(insn->data, true);
> -}
> -
>  /* Internal context for this TranslationBlock */
>  struct qemu_plugin_tb {
>      GPtrArray *insns;
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index d248c52e96..d7abc514c4 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -761,6 +761,18 @@ QEMU_BUILD_BUG_ON((int)(offsetof(CPUNegativeOffsetSt=
ate, tlb.f[0]) -
>                    < MIN_TLB_MASK_TABLE_OFS);
>  #endif
>=20=20
> +#ifdef CONFIG_PLUGIN
> +/*
> + * We don't expect to cleanup many of these structures.
> + * They are reused for each fresh translation.
> + */
> +static void qemu_plugin_insn_cleanup_fn(gpointer data)
> +{
> +    struct qemu_plugin_insn *insn =3D (struct qemu_plugin_insn *) data;
> +    g_byte_array_free(insn->data, true);
> +}
> +#endif
> +

You could expand the ifdef to the next function and make an alternate
empty alloc_tcg_plugin_context. Alternatively maybe we should consider
dropping the CONFIG_PLUGIN gymnastics and make it a first class TCG
feature?

Is the null case still visible on the code generation benchmarks? Does
anyone using TCG actually --disable-plugins?

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


>  static void alloc_tcg_plugin_context(TCGContext *s)
>  {
>  #ifdef CONFIG_PLUGIN

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


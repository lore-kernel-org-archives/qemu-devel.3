Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C757AD0E6E2
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 10:23:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2pZ4-00016Z-D5; Mon, 21 Oct 2024 06:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t2pZ2-000165-AY
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 06:23:04 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t2pZ0-0000WO-JC
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 06:23:04 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5cb6b2b7127so1134894a12.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 03:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729506181; x=1730110981; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aAZAMq4h0dUbSYpqhLV27fcFvIDNn+A3QR2RorL7Lv4=;
 b=SarV+v0vn9O1ak9QBIsbvPIQ6vaRKbQnKIztyfGurBtKdh+wbUdB3tzln5gz0q5eHp
 tBMEEUnSbqAF4D9kb3Yw33ghPh7SRlKQ6598grNpsFF3q6pCf2Ljsvaz8TX68/GdGZez
 ILAALNz5rrb4IKUPLQYHmM5obh2drwydSO5goZeCFYpRkd9hz1J5RFqt2zvZKHTfS8ca
 TzIa36LESbMvNNTCE2bGC/G0dlcnZCcfvvC45bv7PPNFjiIXwn/dQFvXccnBNSbOeV9e
 UGXLr/sB0/9VRcXKrwCl1BjkkIsSIOJdbpzs9QFi1jSDyst7LZ8phrBTNaIPJXwvK5/K
 AELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729506181; x=1730110981;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aAZAMq4h0dUbSYpqhLV27fcFvIDNn+A3QR2RorL7Lv4=;
 b=XiAldY5DZdX+ZmQDCaEs8URYUeQSyzgdUeTgVgLAeso/kDv956QqTIHs6Q2vqqxhbO
 Sj2pEjsP8OPfXAGky+lz3BQ6Z2+R1HJRy/D+o086f2S9U1omyX7YmL4rgllWKWyDyzUA
 6QuQkiwlJ+BVJSO6/geWfw9Jm366mQFcqxDJ+MHlLa8Cf2tpsXVoiSvB5uxtJsk1RSi+
 fQP5b9KiR1bfQwaqRbL+7VrRiRn6bmFwoiwMyjXUbgPHY7sZOrhEvL676wv/2PJPfgR8
 09BQELf/n0X5RTc4KHmU8C/Go1bAG82E+DYHlNzDt/Kuq6JBy/MmCxfaqhXRXazu+I+R
 DbJw==
X-Gm-Message-State: AOJu0YzDWUWlsqITWZYZgGllou3/cRqwaP5xmhA2pUE8R4T5vqUuGcvl
 fwQ5bkLSLWDzvo2JH0hfRdIzY43kBw3CB5gUwZDMAF2s7CCNWdpMYKq7cysCTi0=
X-Google-Smtp-Source: AGHT+IHPBsxKhnwO+WuHZFsnzK5aPVBFaf/fmUPHi4FxvsUXeGRdgDS+Lq7wth9CmPLjmqnHvuBovg==
X-Received: by 2002:a05:6402:90b:b0:5c7:20fb:fce3 with SMTP id
 4fb4d7f45d1cf-5ca0ae86568mr8204570a12.21.1729506180946; 
 Mon, 21 Oct 2024 03:23:00 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cb66c72685sm1795591a12.85.2024.10.21.03.23.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 03:23:00 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B90B45F8B9;
 Mon, 21 Oct 2024 11:22:59 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2] plugins: fix qemu_plugin_reset
In-Reply-To: <20241015003819.984601-1-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Mon, 14 Oct 2024 17:38:19 -0700")
References: <20241015003819.984601-1-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Mon, 21 Oct 2024 11:22:59 +0100
Message-ID: <87msixoiv0.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> 34e5e1 refactored the plugin context initialization. After this change,
> tcg_ctx->plugin_insn is not reset inconditionnally anymore, but only if
> one plugin at least is active.
>
> When uninstalling the last plugin active, we stopped reinitializing
> tcg_ctx->plugin_insn, which leads to memory callbacks being emitted.
> This results in an error as they don't appear in a plugin op sequence as
> expected.
>
> The correct fix is to make sure we reset plugin translation variables
> after current block translation ends. This way, we can catch any
> potential misuse of those after a given block, in more than fixing the
> current bug.
>
> v2: do not reset tcg_ctx->plugin_tb as it gets reused between
> translations.

For reference put version information bellow

---

and then the git tools will trim it out of the commit message.

Queued to plugins/next, thanks.

>
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2570
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  accel/tcg/plugin-gen.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
> index 2ee4c22befd..0f47bfbb489 100644
> --- a/accel/tcg/plugin-gen.c
> +++ b/accel/tcg/plugin-gen.c
> @@ -467,4 +467,8 @@ void plugin_gen_tb_end(CPUState *cpu, size_t num_insn=
s)
>=20=20
>      /* inject the instrumentation at the appropriate places */
>      plugin_gen_inject(ptb);
> +
> +    /* reset plugin translation state (plugin_tb is reused between block=
s) */
> +    tcg_ctx->plugin_db =3D NULL;
> +    tcg_ctx->plugin_insn =3D NULL;
>  }

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 061F0CCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:25:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68Zx-0001xs-Vr; Tue, 07 Oct 2025 10:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v68Zg-0001ok-KA
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:22:00 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v68ZW-00048v-TO
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:21:56 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3fa528f127fso4804460f8f.1
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846902; x=1760451702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a9c9EAkaEb3e0aaWagaM4Bs6jRIg9LYLzZ2Rp9h0qIA=;
 b=p/oBEn+60rwk/u/B2c/7oxwkiFBr5qqb/bQ4i26pVlLSysZ0khcTc6U3I84m4GRthw
 sCzsAgk001cU2tQQPPC98+q7O9jgtYjWkTE+DT4vaMQCStxH9FrGEcHIIWaJOxudZht/
 HyMPM6/j6LtT5PYv1sxD2HF+1Az3bjLnjO/+t5GQPxOQUFNn5LEXvpwsFjLnzCstrDCE
 Q5oLM+RpqJiTHDXPOKEfdZdEhfBixM1exiloEFOGxJEOI4dvmvMWpd7xlBmnsbXWXFdQ
 5S1qKsEX4ULhas3sG8jCwPX/SjuAO2lANVAKDF5HldwNzhqC+T9aPv4d6alKCEUYMG4v
 XhMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846902; x=1760451702;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a9c9EAkaEb3e0aaWagaM4Bs6jRIg9LYLzZ2Rp9h0qIA=;
 b=g1p26ojcFSFd5hH4B4W+Mjvh3eMvRzB1QLWkp2UJ71UCsgyQ4Esxr3QZ6OgkKo0RLt
 BiF4eQbl76ls7VnHbk2/dnlnLpsjpX8cWaQzC0i4mV9pkRC0KIMf3PmGtSl5IY010xq6
 ppt73sGlPgv6vPG243nSRmPVPRci9DlhtjbV5kgnH0FII+d5YsHJV1cxr6vhIt6kX50h
 m048Np81Ia7ckIy2nlIwkZ84zb7UktSdHeMBkb5+E6b12cPY8NfcNzf33mcY9LRz8ao0
 IUqbZKHB0e5VfjigSiwcIUDc2IY0LjfI8FwStDCKZoCNU/izNuKl0AVkJ6TXEmx6ndeH
 60Fg==
X-Gm-Message-State: AOJu0Yxozi4wJFlgpwa80eW/speig9MZEWSCAky0iaTRFzntZRnpcN3d
 jZA7fjcNk5UIiPIXqZEb1iqxRLWdqo6qGOmrjcGJOT4hRK9PHUV0nO4diuz9iEabfAE=
X-Gm-Gg: ASbGncsW5poIb6CKyhWnTk327WI6HdSYkN9Q1n3WkpEZca/SnlDJFoQE6BcJV/bwRnA
 Cfp1hyfwDl6oa+nhmBBcDpqOz6U7NnTSN51pbyQtPpKYp9P4BpHhr5yDaKZuHKlGiFe+qEyD7sN
 48v8bpGP92uwqrpY8CAB3CgUQKHf8EDs0Ip6iVLwRM+Fee0MFswmk1zoHUuWxHJJO12jpAadGXL
 +UYnOnFzpsqqI+FYgwMz2mTD4V4vGcR2CfP0rhFk4bzPFWS1HkkFEWqbITNrYfPHUi6ZaACynIw
 WLyvHDCzjnkYIGVgVQ3XsxSuuYRUdhSrpOawNC/qCgmJhfYFYh+dhA3+WkfVQxxgUnKTDNMXKD+
 6MBA80lTtN99m8AvNTxlZUnRgEBJE9DPsTSbJHbQ4uSsZ/3ayH/I=
X-Google-Smtp-Source: AGHT+IGtZRNdv6YpkbQhCy1DuHKmk/bHn4jdyQOpQtwwAomKI/t+YRlszPNzFg0qeV5sJaZLoveMPw==
X-Received: by 2002:a05:6000:2912:b0:3df:22a3:d240 with SMTP id
 ffacd0b85a97d-425829a5a07mr2401696f8f.4.1759846901724; 
 Tue, 07 Oct 2025 07:21:41 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8abe90sm25528791f8f.23.2025.10.07.07.21.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:21:40 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3423F5F812;
 Tue, 07 Oct 2025 15:21:39 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Zhao Liu <zhao1.liu@intel.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH v6 04/39] system/cpus: Assert interrupt handling is done
 with BQL locked
In-Reply-To: <20250703173248.44995-5-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 3 Jul 2025 19:32:10
 +0200")
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-5-philmd@linaro.org>
User-Agent: mu4e 1.12.14-dev1; emacs 30.1
Date: Tue, 07 Oct 2025 15:21:39 +0100
Message-ID: <87zfa2yeq4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/tcg/tcg-accel-ops.c | 2 --
>  system/cpus.c             | 2 ++
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
> index b24d6a75625..6116644d1c0 100644
> --- a/accel/tcg/tcg-accel-ops.c
> +++ b/accel/tcg/tcg-accel-ops.c
> @@ -93,8 +93,6 @@ static void tcg_cpu_reset_hold(CPUState *cpu)
>  /* mask must never be zero, except for A20 change call */
>  void tcg_handle_interrupt(CPUState *cpu, int mask)
>  {
> -    g_assert(bql_locked());
> -
>      cpu->interrupt_request |=3D mask;
>=20=20
>      /*
> diff --git a/system/cpus.c b/system/cpus.c
> index d16b0dff989..a43e0e4e796 100644
> --- a/system/cpus.c
> +++ b/system/cpus.c
> @@ -265,6 +265,8 @@ static void generic_handle_interrupt(CPUState *cpu, i=
nt mask)
>=20=20
>  void cpu_interrupt(CPUState *cpu, int mask)
>  {
> +    g_assert(bql_locked());
> +

Is this really the case since 27e76d01010 (cpu-common: use atomic access
for interrupt_request). In fact I think tcg_handle_interrupt now uses
cpu_set_interrupt.


>      if (cpus_accel->handle_interrupt) {
>          cpus_accel->handle_interrupt(cpu, mask);
>      } else {

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


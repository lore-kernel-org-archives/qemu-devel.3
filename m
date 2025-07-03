Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E67C83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 16:37:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXMwE-0001KH-Tm; Thu, 03 Jul 2025 12:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uXMwB-0001JM-QE
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:37:28 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uXMw0-0002VW-SM
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:37:26 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-60702d77c60so93428a12.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 09:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751560632; x=1752165432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nSyh+1vh7aSraI20cmAs9cIwR7F3plutizErUW5+m3o=;
 b=LxzEN48yDKzIpC00YB+T3mQTikYo7JMtskv8rR4WB9g7xUvxuMyMhoAkfZu1lsHuDi
 wtmtLoqIxY6JlJJfPSFxkrt1zgk5Jaeqts+vxLd3f0kwgyUHMOlcwBjAEh8jn7q8hE0i
 X6/zw2GosB3MbC0Blh5dGGZKL48hczvfU+Vf72G7vyGEK8bdm500MdyPbPetqo9fkoMh
 VQTNviEuvMC8/JTQNsTUfzzklE7Si09TAhEaKJiLkTr9cTYw1JmDQ1MD0OeVKOacFVZp
 Gl6GKlsW1RjOGaDhmpW19U0q0dbOJpzRuIBxtp5xPIhWOz0EXrqd/ajzvB8T9XwpiiIq
 Q26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751560632; x=1752165432;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nSyh+1vh7aSraI20cmAs9cIwR7F3plutizErUW5+m3o=;
 b=O+6GY5y6PB+tmsm8Hzv8XFFh8vi1vqeBeOsbIbU3Q0vd4W0mvw4lzZZNDNm1jNHQ9t
 lJ6dc3lj6pypHI+t7sBFjMN3x728enAOn9WAnPm4GdcAwnKTjhFexLgGdIGX+bPpvcYJ
 +CQD9IGj+jVxLY+KM9dlEzl399s8G2PKB+YmuOcWhn/04W1LhcsKRjjEVsungVdKVl7p
 Ga+iKyG/f6SdTb8CcYI56M45DeU8mPk2dPl3wLLMeTtuLodEW5xXbh2ng2dTtE1Yov/T
 gOvqpakHB+GXq8C6sb76CAqo07nj5CVcK/Dz82922HRG8slJUL2mA07LCe+1uUkp/4CE
 RF6w==
X-Gm-Message-State: AOJu0Yz45llWKr1lK4LORH1/2zaPkWOh5ay6EqA8mLBRRZENHNepmIeA
 AmZryi5pik4nheCZ+8dZW/6XY53zgpdH2RaGcUbi+kl4i98ruDSxBMh2GULGrAzSgpo=
X-Gm-Gg: ASbGnctzmVNAeIpd2tM3WH8sgCml+kocw9tXqKp31q5hquLOEwhIjSosRjyVoKOm9nD
 kRf4++duZ1SWjRklTQdQwJUYeCiSMYhjjO5NdDXCJml6yOFDO616piERK89RRG9JRDUap9AQ9I8
 50NO5VhTP0d6v61fzm/AvmsokKsq8QVZPFuid/GN/NMl27Sh8t3KvQK66+knP4BrHQtB28CJsKK
 vbU0lhgVsGyRTiV4KFFiHGkwUBLljhGYIrMhkOCTOBsVoUcUEf8Qlc+qTawKAnwiTtgxZDmCuH9
 RyvIN3h6XdsT/hNU+UTTd00yQAKTmLcoaBsvJdE9CgmSmYZbWzbhVHC+5dZnfYA=
X-Google-Smtp-Source: AGHT+IHPI6Y54BWIL3edYUnr9absOp8cR90n/m/sIrlggH3I1vpdJFHqnWemkKRQQqDvROIDcaFx2A==
X-Received: by 2002:a17:907:e2e1:b0:ae3:f2a0:459f with SMTP id
 a640c23a62f3a-ae3f2a048c1mr88274766b.54.1751560632067; 
 Thu, 03 Jul 2025 09:37:12 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f6ac3831sm3069666b.84.2025.07.03.09.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 09:37:11 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7C4F35F8AE;
 Thu, 03 Jul 2025 17:37:10 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Peter Xu <peterx@redhat.com>,  David
 Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4 02/65] system/cpus: Defer memory layout changes until
 vCPUs are realized
In-Reply-To: <20250702185332.43650-3-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 2 Jul 2025 20:52:24
 +0200")
References: <20250702185332.43650-1-philmd@linaro.org>
 <20250702185332.43650-3-philmd@linaro.org>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Thu, 03 Jul 2025 17:37:10 +0100
Message-ID: <87cyahcjt5.fsf@draig.linaro.org>
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> vCPUs are not really usable until fully realized. Do not attempt
> to commit memory changes in the middle of vCPU realization. Defer
> until realization is completed and vCPU fully operational.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  system/physmem.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/system/physmem.c b/system/physmem.c
> index ff0ca40222d..8b2be31fa7e 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -2792,6 +2792,14 @@ static void tcg_commit(MemoryListener *listener)
>      cpuas =3D container_of(listener, CPUAddressSpace, tcg_as_listener);
>      cpu =3D cpuas->cpu;
>=20=20
> +    if (!qdev_is_realized(DEVICE(cpu))) {
> +        /*
> +         * The listener is also called during realize, before
> +         * all of the tcg machinery for run-on is initialized.
> +         */
> +        return;
> +    }
> +

This is a c&p of the wording bellow:

     * That said, the listener is also called during realize, before
     * all of the tcg machinery for run-on is initialized: thus halt_cond.

which is now redundant because of the early exit?


>      /*
>       * Defer changes to as->memory_dispatch until the cpu is quiescent.
>       * Otherwise we race between (1) other cpu threads and (2) ongoing

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


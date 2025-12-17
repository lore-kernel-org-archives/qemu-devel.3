Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0529D6554E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 14:11:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVsEi-0003GE-IO; Wed, 17 Dec 2025 09:10:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vVsEh-0003FF-3d
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 09:10:39 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vVsEf-0008Q7-Fh
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 09:10:38 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b735e278fa1so1058871566b.0
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 06:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765980635; x=1766585435; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0EmwGnLOQObF/7cxus/deBZ8zEsUnVmeldhCqCAi8uU=;
 b=UheMls4OuLXS/dkuTEtnCrHQsUFOPNM2pHnPFiTzvOCseMM997jI3kkqeWbIhgrkb0
 Wgy7BtP1ZUJy4XQLZAA5qt3PGObuC2uOfrmkZeFNeEJsJ3S2KcWRydjUOJ2/JV+O8oun
 LX5qgx1cY+yNtz7MZIujo0p5WojWmxhoJ+d9hrhBeSPnrJ+DFaJX21JjpOQj+mfw+w4N
 pQ8+F2MtnexrUrfFY+n/qcTpnHxeGO5RtHCffSUJMqrq67WrGkV0x6vNEiVrVHNrP7EB
 sc0fWrdfwnW8WRzE77io0bsIcX3szgpLpqiH1E9CkRyFP2TdfxrggDNqbeO79UG/PTRu
 zJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765980635; x=1766585435;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0EmwGnLOQObF/7cxus/deBZ8zEsUnVmeldhCqCAi8uU=;
 b=KHksZMqDpDg/VL0a3EEQAsHvtKuqyv00ML5NXV84xBfh4P9kYDblaLg0nS9wtj77Ui
 F6BXjBm86z75Wh70pwyrLaRvWQWbGdqe0whl1/t9iji3aQGRT1FfPiGBa0DOV+6HdHOC
 zPs1LFIH1+q9hNLMA05a1Xatix4/ht1hateqefCjU+yTpV6o1hax7zT31YyeyPDSxrtP
 UBZHe1dQGqWFUy496YT5chW0fXlprxJZQk5HHGn0rJEXA4bszLvvrs1/vcRiXQ+utD1Z
 PI73WivwBGDatdkUtlEuSjqENiPnE/9jvrhNYS/2iaWzyU5AabBrKm5B8VLxed3gdQIQ
 Dnug==
X-Gm-Message-State: AOJu0Yxv3j5a6XfgLD31kZilJUThVabiRcV5lcLAiJOrwEu2JTwuP8NF
 kE6YzBPaGmPjsYXZ4VD8aPw2CSh0zKn/R5Bapt6D6G35ewedsfU31+0pcAHY01dhQKjpgC04hZ3
 ClE1hrrpVyJBA13OQQ+KYA/KrW1QTB+DDbcsL2xFsckhLW1nJ4lcy2wI=
X-Gm-Gg: AY/fxX4ml9P8Y23/orpOxCNIbSC5gyDDhXQvAtMAkvk2sVEXA9ovGp7Z22edAF/dN+0
 OYLUjEkg797JK2JnUqLZi7V4bXIStavNxXh7ktd4ksoCbB6xLhkCUjnWzsQIGn1b2z3RDzx5eT5
 uyTSGSzVPogVOsDkznytkzbjKaQDvD+NeQuT4w+ETm7q3lK/LY8dzRl3stbCxzaTNECZZMMMYih
 37rzWJ7tmRCIB5YArX7KY9fUr61JLiNuY1Rm4s9C1pZksnlbaxglcDNxPu+C3nhKGNwFQ==
X-Google-Smtp-Source: AGHT+IFcCV5jgSV+sa++oChVfaZaUoq0xMDTrVY4XZWNS7xuGa6adOONrmvml1MBtD2IJMCM9hYfL3Rfu7TEmDDzzJE=
X-Received: by 2002:a17:907:5c8:b0:b73:5936:77fc with SMTP id
 a640c23a62f3a-b7d235c7f43mr1947663066b.13.1765980635197; Wed, 17 Dec 2025
 06:10:35 -0800 (PST)
MIME-Version: 1.0
References: <20251217140658.89715-1-philmd@linaro.org>
In-Reply-To: <20251217140658.89715-1-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 17 Dec 2025 16:10:09 +0200
X-Gm-Features: AQt7F2q5NoR8ZXjDb2BjmIEXWIc0iQ_gqkjXsKVoCLmyPG4HVnk8qpXb1gbHMM4
Message-ID: <CAAjaMXYeJjenZ8tWd0q72hy2uqNYg1XsYv1FJkk04wmT51uKvA@mail.gmail.com>
Subject: Re: [PATCH] hw/arm: Deprecate legacy VirtIO devices on big-endian
 guests
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, 
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, devel@lists.libvirt.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 qemu-arm@nongnu.org, Jason Wang <jasowang@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62c.google.com
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

On Wed, Dec 17, 2025 at 4:07=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> We couldn't find a way (guest OS with VirtIO drivers) to test
> a legacy VirtIO device on a ARM vCPU running in big-endian.
>
> Deprecate for the v11.0 release, giving 1 year to users who
> really care to contribute functional tests.
>
> Suggested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  docs/about/deprecated.rst | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index ac31a2bce42..3a69facb0f1 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -515,6 +515,17 @@ It was implemented as a no-op instruction in TCG up =
to QEMU 9.0, but
>  only with ``-cpu max`` (which does not guarantee migration compatibility
>  across versions).
>
> +VirtIO devices
> +''''''''''''''
> +
> +Legacy VirtIO devices on Big-Endian ARM architecture (since 11.0)
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +There are no functional tests for legacy virtio devices used by ARM
> +machines running in big-endian order, which makes harder to maintain

Nit: s/makes/makes it/

> +the code path while the code base evolve.

s/evolve/evolves

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>


> +
> +
>  Backwards compatibility
>  -----------------------
>
> --
> 2.52.0
>


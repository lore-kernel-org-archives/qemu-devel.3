Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A96ABCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 16:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3zNo-0007ws-P6; Wed, 01 Oct 2025 12:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v3zNb-0007sB-GX
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 12:08:36 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v3zNQ-0003bD-Go
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 12:08:35 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-635283199a9so103396d50.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 09:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759334897; x=1759939697; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1uhjImz1ARsjEJI8cAqVGDV5ReAvP4bsdRzz2Hi4V9c=;
 b=J/DL6Qekw3kALfj8U0KZyjh/WK5rgRPYQ6KzGhfJkejyZzvAijxxa3vcT1b0KNaXyc
 TDdeBPOfGb6BKO9r4RbxqYUuxEz5xsBIg+XUwC8o2bTcZU93QTuLUvBkMJMOFJjdaR52
 x+HiV9UkL+yoNVrRldvMg+pUOciydQA8oAxf3saELTRq9A0wRj7BjUuKNGHvsRAjFyKx
 daQHuPuHpsVG0odQ+rXUfO4QTnjgVfS1YzwbLt6hy6eE4En0hAL7xV7//m+jHHI2/EJq
 Bl9EJ85Sa8ilQsmMeZ1WwDnHQtH0leCjVwFIGYq8NpJ9j1ebXixysRLgOv3ZdtzM/mL2
 VCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759334897; x=1759939697;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1uhjImz1ARsjEJI8cAqVGDV5ReAvP4bsdRzz2Hi4V9c=;
 b=m4IU5LpaOZj4oPx63KCBiQAWbsMxcV8XZ50G2LR/5BgjwqC3/G9z4jiXIuaIH512fC
 lSU31fzHrxR7kYbM71W6Vl99RbJTl9qOqqYMPvp/hMb+d/A7SQkUy8C9/pLlurKI+mBX
 zkZqgxJuuDpI332vthfdTLBYfCYSRH2s57AwXdHf7E5aqPVgSZ5XtCfHGU43SHPK4Cbx
 tapEJ0zmGbJ4klXAkP+ZwE6H9z0lf4X8NkdOG7eEbRdNfXI+fFOf7H5LEhrwa1tT7Oi9
 uAoS4y8i1cpbzPLjBg1fV3as4FyJtw6bhNiB4Ra8JHwVXBSvT3XiL/idZuHWBdfrS6tt
 /FZg==
X-Gm-Message-State: AOJu0YwUyde7TsNPpmFQVCsvGcg4x2dyGIMiEVsUHNhRskdyQYybDzz+
 AjXmlforJio7+kW8HyQY+BlPpBvKB53ZBFL3ofB3U00uRU7lPprr1bM+sAKHJO6VdVV1vSVmp/B
 1d/yoEdQslAFc7t8gp2GRe2yBlAINe9qILsQRDLxYBQ==
X-Gm-Gg: ASbGncuPiCwT4P2MsqsIomcFP1SEM9aiFBajSciXJoFX83+jWSjW1fC3wY8JsixYQ2G
 z5vlpr54/aCDH9WF/l/nKdkgKzxbhxF111F3NQ82eqDhs+460LPCjpE77nTddPxA8C0M1ovgnAV
 YNVbatUVtpkJs64OkotAB/rkYjeXOHFyZaecvqA04M+gaeTqM929kTbzejGzYeDs53q/svF66Wq
 l5a7hl4gaQ+/Dj/UqtiLICWdGTnO8knhtd70cU8hAs=
X-Google-Smtp-Source: AGHT+IHoYmujh+ngr61sUEQChrIjRT7eIMmc3+Maq5QgQ/YNihIQq6LdvIUOvIYoA0mpB6KXjQYBWJm1phxDB5HlVF8=
X-Received: by 2002:a53:db09:0:b0:633:aff2:d73 with SMTP id
 956f58d0204a3-63b6fec8f93mr3901206d50.5.1759334897047; Wed, 01 Oct 2025
 09:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <20251001150529.14122-1-philmd@linaro.org>
In-Reply-To: <20251001150529.14122-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 1 Oct 2025 17:08:04 +0100
X-Gm-Features: AS18NWCCjl9FtX38MysgzZN9RRCNI1ODO31lSIAWe3O_HbUNCUneU4cyytbeDdM
Message-ID: <CAFEAcA-daogqBPxt72qTM6BuMuD1wuw+vXZwxLUQftwY2FZk=w@mail.gmail.com>
Subject: Re: [PATCH 00/22] hw/core/cpu: Remove @CPUState::as field
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Wed, 1 Oct 2025 at 16:05, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Instead of using the convenient @CPUState::as shortcut, use
> cpu_get_address_space(asidx=3D0) to get the vCPU first address
> space.
>
> The goal is to reduce the risk of AS mis-use for targets
> that uses multiple ASes per vCPU.

I'm not sure I agree with this. The cpu->as is handy for
the large number of targets which only use one AddressSpace:
which is everything except arm and x86 right now.

Targets that use multiple address spaces need to be careful
about which AS they use by definition. Unless we have a
track record of code in those targets carelessly using
cpu->as when it should do something else, I'm not sure
that there's a benefit that makes it worth making the
"use the one and only AS this CPU will ever have" more awkward.

thanks
-- PMM


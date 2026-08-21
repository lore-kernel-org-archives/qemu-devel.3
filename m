Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E3AC5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 10:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxMSf-0004mA-WE; Fri, 21 Aug 2026 06:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wxMSe-0004lf-Nl
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 06:26:56 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wxMSc-0004tP-To
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 06:26:56 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c15ca7a7ca9so100134266b.0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 03:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787308013; x=1787912813; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Dg3CiEYsyDNW/bZP32EasqmYY+4b11u/dJQBRxZREow=;
 b=aUeeCCc+gwt2922cYUW5X7I0A5uecQLo9NSAalSc+JCY2F1wIVJlQGrlyf7Prz0/AQ
 DINS+1olAJ2xfgl4v/3wiHoesH3gdt7Ro+H9bK/BmbrOBZSmqgDUWjqnzfkMp52Fsume
 Iirhb9mvO5ydIEet3+eotLyOazENxYw+DTaOXyz+U6GIa76UUC6sBQBlsfq46ZJ9Y7II
 69iZ+CxQaFWtTk/yUxj3Qjzfzk219b4odwDJYkslXhIo+zZab+ryTCxY8zUxbaP8+cJ4
 tJt9nfsPuT6rvJdjT4LuSzHMdpzuOFTpjKKL5OtVUZHVMVUj3G6bBIvFGOTea8mXBksr
 qHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787308013; x=1787912813;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Dg3CiEYsyDNW/bZP32EasqmYY+4b11u/dJQBRxZREow=;
 b=QqW0F+/pqW1OX0kwuHs2Wa+5BWhh0igIvT6VPA3W6Yo7bWpXh5Tw5EY7t5ymI8JOMS
 ct+FjRP70CmbtXeqD2Z7X/lNa5YYJx6brDxqoG8jODqrcoz5u1D4Am8GponI371al8XN
 XZS5+OVsI/vXBDEkGS03yUbc0xN7kf2wyMss4BdWuPnJsnjxFp9oZ6SmNUQJOPYR0fOa
 8/khicQl5s9l+AOP5+gk68pqjy6UwEXV+/5RaQO98w+2SYILfF1Sdyre7cMXYAnlRUI+
 G7yrcPD0ttxS25utnGNq6Dt0rYbSD8l7h6nvpACvpn4aIBKQKuHsPw7gsnwAO7ee5ROB
 dZcg==
X-Gm-Message-State: AFuF++nSYlAXkVhHhgUypbDvx0464amKfSo/+VHmQ/jIPo8wHFW5Suiy
 NT8WHHk0QjxsDZ5cj63Jp82NWg1PgOF5B1Ld2JYU/xCNdAUqaiQ6nuKGoIKvzY3fB1U=
X-Gm-Gg: AR+sD12KDdglbXhcifwXRuzjkP31XIXkOvyfiQpX3xRg0UfZ9XjdmchRIKV5xWnx70o
 Uc4enEmPqzUkBnzSaMp2HXgaHjWln/NQg7fKSNS3CpM8cOxE4AYj4/bbFBV0BjP5KhlPzKXhlE4
 0V1GNh/TCQhZpYAhOUfSrxneIwsQwwnjHjf0pplNl65c20JyMtNpz/TQAVd+nDa2aeQIYQBOFcU
 ekbb/OdtmmjL6X7D9ZRIlvfpthwW2uW9WCvCTw6Ab8FMc5sefOlxYv+fIdJ+nHi8mTL3hJSTCTn
 PPRWWZaNFNyXbZZgkj5a/VABj7dxPFONHK2ya4IszcxIgc6ZaTcTJhJxFyTjE6N9Uu5UBQkAw+V
 TV499kIa4ncEJuZxHWgNv7XEaSM8HRNaKXPUx+Q47trvdZptrb2djMUJhpH7Ethz2jClhz+fiBY
 4xdub8uwqnDLg5fV9ICyIVIv8H5AUbJ+H3DaKMem/el9Q3/Ckq4h4teGuaqEXZ
X-Received: by 2002:a17:907:842:b0:c21:74ad:8b11 with SMTP id
 a640c23a62f3a-c246a60ca24mr510962366b.15.1787308013032; 
 Fri, 21 Aug 2026 03:26:53 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2459222200sm374475566b.56.2026.08.21.03.26.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 03:26:52 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E8AEE5F809;
 Fri, 21 Aug 2026 11:26:50 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  Peter Maydell
 <peter.maydell@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,
 Bin Meng <bmeng.cn@gmail.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [RFC PATCH v2 00/14] hw/arm: add TI AM64x SoC and am64-virt
 machine
In-Reply-To: <20260820124824.618671-1-wafgo01@gmail.com> (Wadim Mueller's
 message of "Thu, 20 Aug 2026 14:48:00 +0200")
References: <20260820124824.618671-1-wafgo01@gmail.com>
User-Agent: mu4e 1.14.3; emacs 30.1
Date: Fri, 21 Aug 2026 11:26:50 +0100
Message-ID: <87qzjrojkl.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Wadim Mueller <wafgo01@gmail.com> writes:

> Add support for the TI AM64x (Sitara AM6442) SoC and a board around it,
> ``am64-virt``. The model is complete enough to run the stock TI boot chain
> end to end:
>
>   ROM boot (tiboot3.bin) -> R5 SPL -> TF-A/OP-TEE -> U-Boot -> Linux SMP
>
> This is a resend: I posted a first RFC back in May [1] but got no feedback
> on it. Since then was the series rebased onto actual master, reworked for
> style and split into reviewable pieces, so I send it out again in the hope
> of getting some review.
>
> RFC because I would like feedback on the overall approach before polishing
> further; see the open questions at the end.
>
> [1] https://lore.kernel.org/qemu-devel/20260528211210.74266-1-wafgo01@gma=
il.com/
>
> What is modelled
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
<snip>
> Open questions
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>   * pc-bios/dtb/am64-virt.dtb: patch 13 checks in a generated DTB (with
>     its source) for convenience. I am not sure a machine-specific blob
>     belongs in pc-bios; happy to drop it and have the functional test
>     generate it with dtc instead, or drop the Linux-boot part of the test.
>
>   * Splitting the DMSC: hw/misc/ti-dmsc.c is large because TI-SCI is
>     large. It could be split per message class (clocks / devices /
>     processor boot / security) if reviewers prefer, at the cost of a
>     non-functional intermediate state.
>
>   * Only one of the four R5F cores is modelled. mc->max_cpus reserves
>     room for the rest. Because the SoC realizes M4F/R5F vCPUs in addition
>     to the A53s and every vCPU needs a TCG context slot inside
>     smp.max_cpus, the machine defaults to the full vCPU budget. I would
>     appreciate a better idea than the actual "fail early with an
>     explanatory message" handling when the user passes a too-small -smp.
>
>   * The register-level stubs (DDRSS in particular) fake success rather
>     than modelling the hardware. That is deliberate, but tell me if you
>     would rather see them as plain unimplemented-device windows plus
>     firmware quirks elsewhere.

I would add one more which is who is committing to maintain this model
if it is merged?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


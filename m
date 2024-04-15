Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 718E9C04FF8
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 12:53:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwLpC-0005BP-2k; Mon, 15 Apr 2024 08:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rwLo6-0004Eq-GA
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 08:51:37 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rwLnw-00030G-2X
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 08:51:28 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-56e509baddaso2918140a12.1
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 05:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713185481; x=1713790281; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z8AepQQxvUrPrG9q2kSM9bsltAFNkulnFvczKTzhPCw=;
 b=ivJXcFpoLg20ubV/D6V5trRcSZYO8XwUq/Rj1amhIaJgSTqYKkAcywUSWEz7FTmihN
 koQoj+0TqCM6/WmlMOtUUtfgITxk0pE4Q6XpYRi0CZOxEiewsNwKOQrgdlxve9x9EPY6
 h0S7tP1jo8xON8nIM0ekhbGpTf+RfBZLWOaIfgRr0p7xX7Xssq5sCHl++t/Kc3Cl64Tp
 1bnM5MGhz0p8eCh9IjU1Ll18QT8Iq9+gITjyxwI5iHL+9q2YlqwCT8/BQ4FyhTiBwTT0
 hjDIJBQNfu8E7cjBgmfzaEDTzIvLI0Gf7nsy/vz7Jdm/zNkg0Ej1afcmDjNKitrk/1rN
 UP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713185481; x=1713790281;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z8AepQQxvUrPrG9q2kSM9bsltAFNkulnFvczKTzhPCw=;
 b=NZhrRTFWeEAbMIYN7RDNoOx6Cg88wfkgJbdRIQsSY9iZxzQCsUGBZJUK/lafkaIOKT
 nzUGmdIoSIHESrV6CwSnvk6P6F4K5p7ePyyD8we1zWnSypl6y7LgUtq9xfEl5MtUifJz
 ZCx+nnbcjjOiFmMEQ5YWwvxXwIRhI1QWl2WbaaMhFB22zNiY9Dm5icbNGZ/Xkcxtlmj+
 EwZfJ/FEaqUItka5s9nAiCtJkiJgkP+AWlEhf2eg4wkogF/3WMkRVx+hwwY6P6J63FsS
 RM27ML/QmKsXeY/w/YiMdHz/v8awwQ8PGyz+zfsKJh8D0aJgJpfB+aaSZnU9cGl9P3hJ
 thaw==
X-Gm-Message-State: AOJu0YzwiIxrlBj1LVQ2pyw6zRTE5DD5Xt6Zlc5d11M7LlQ+zMnoOBy4
 +wCCH0J3wLW4yJlUWJTJFLb/tEtH3AzHOPlLFV2K5mPb6asm4269lCTiMESFv1IA+rVixkvvvaA
 uXkwQzo+fDzTK8eI/bpxj5Nl5jv6/EjToYjKMIA==
X-Google-Smtp-Source: AGHT+IFlwlfQBWDoHyNbxCNLd9ijV5sDceLSaIFl+tiUsiCuuNWlHW1Efuh+39WEMcVwy2jY3DUORRrOqQYBvT8AhnA=
X-Received: by 2002:a50:aad1:0:b0:56d:e6f6:f73c with SMTP id
 r17-20020a50aad1000000b0056de6f6f73cmr5686900edc.42.1713185481193; Mon, 15
 Apr 2024 05:51:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240118200643.29037-1-philmd@linaro.org>
 <20240118200643.29037-9-philmd@linaro.org>
In-Reply-To: <20240118200643.29037-9-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Apr 2024 13:51:09 +0100
Message-ID: <CAFEAcA_snH+ucZQELesLgf0uDUgON8Sj==4JYPHh=4oLbczxQQ@mail.gmail.com>
Subject: Re: [PATCH 08/20] target/arm: Rename arm_cpu_mp_affinity
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Thu, 18 Jan 2024 at 20:07, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> From: Richard Henderson <richard.henderson@linaro.org>
>
> Rename to arm_build_mp_affinity.  This frees up the name for
> other usage, and emphasizes that the cpu object is not involved.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Hi; I just had cause to re-look at this commit. The problem
here is that to determine the right MP affinity value the
CPU *should* be involved. This is because for some Arm
CPUs the MPIDR MT bit is 0, and the CPU number is in Aff0,
but for others the MPIDR MT bit is 1, and the CPU number is
in Aff1, and Aff0 is 0. We don't currently model the latter
CPUs correctly, treating everything as MT=3D0, but we should.
So really arm_build_mp_affinity() ought to take a CPU
argument (which is awkward because we don't always have one
to hand at the callsite)...

thanks
-- PMM


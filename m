Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11552C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 16:18:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbjLj-0004qS-Kx; Wed, 07 Aug 2024 12:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sbjLh-0004p3-JC
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 12:17:17 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sbjLf-0002ge-Kp
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 12:17:17 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5af6a1afa7bso2490454a12.1
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 09:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723047433; x=1723652233; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MGB7lsf0ZQyPy4LluEQ3IekLkGnIH4iLXtYJ/dh0y5k=;
 b=Lyw9BDmuO4a6eODbihBqJwPAC9q23uqx+dX8+zSUVM25qtRvGHCCGPvEYCtXLBIjFV
 6w75SwVE3es/LX++DtUCWfvgElg8gKh32rm/IrPfZDvQTZ+CNoKJ/jU7ij5/TWSiehE5
 0p4boB0w/+cfaPD3/1QCq5xGG70PRWWqnAn2g73QmXNXgnwDio+C2n3PwNwJkHaM5qB8
 Ex9DYVtiNY7s/EppYj6qkrcdcxdBRR+UKrnH9dZGGrsYUivA/t7Yz8Rbhniut+7NC2AP
 aLNHZoQkv0N21CQe1WatV/4Xjl5ngkOs+Mj5o7aXhbsdaJmcfPBEgbY1Hy2TlhtWRQ8l
 KCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723047433; x=1723652233;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MGB7lsf0ZQyPy4LluEQ3IekLkGnIH4iLXtYJ/dh0y5k=;
 b=r16YaTVjJ6wGzNeG4k3dXV8U95OSK+3FMA0Bt6efQWEzcD2reIJSj1qha+YrqkWWSd
 WowPDGt5aFpg1QG6EkjCIwS6syUL6pteSMFhylpBJ/qJbUrbeoILvWlu6LcPKBCl8cgo
 TOz/mOrMY8e1H8jCTIpEB4M/0eD1FY36dJZJ2Lm9pnA6f+ZXJWwqsTIXce+GJUuTvROm
 JDrKAW4q3EY2HoC+BOmi/od2ZwuD2qL/ZSOChYgk1iauSrBCrymBsETEHV4/AvTXeBZL
 5PTZ2FjXzGprQPLN503c2EDOHgPm7eZws8wkQ3tLv+1pK/8idHkOU7olM0vk5wPlKylG
 Rwxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHBzy1vI1QdNkDs4ZOzyUO5SfpxYMbFv34zNQa4IbVQuADLDz9S2BxIKBU4Rh7Bh1L7MCJBtdnqTBU@nongnu.org
X-Gm-Message-State: AOJu0YwC31R0ynjS787bDvNLMCMOUEGb9LeNXCaAssohdzm2w3cluE4z
 11GhSy2n60b7wqfDM68kaD3U6fDu6tFuSB80PZyK5WQ+vDoJCvwJISnW+m9R5coxDoq0d+jPm1c
 Sy2QPzPaFCMmB3oM2vF2z2WWSHQz1MesPzl68yg==
X-Google-Smtp-Source: AGHT+IGNYkll1AZ+eliCrBAnJfO5mv/cCCoutsHpU2vS2icXYe6kpooh/qcJvwlnJmm5ya4huGsU/2Xycc5fgrZ7cFk=
X-Received: by 2002:a50:eac1:0:b0:5a4:2c8:abda with SMTP id
 4fb4d7f45d1cf-5b7f36f58e2mr13728476a12.3.1723047433030; Wed, 07 Aug 2024
 09:17:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240806141940.22095-1-philmd@linaro.org>
 <20240806141940.22095-2-philmd@linaro.org>
 <f82397e9-3be4-49be-b291-5598acdaf39b@linaro.org>
In-Reply-To: <f82397e9-3be4-49be-b291-5598acdaf39b@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Aug 2024 17:17:01 +0100
Message-ID: <CAFEAcA9emwsK07+itUzMxReOLG8gHaxNdDE8ymuwyuBfsoY2Pg@mail.gmail.com>
Subject: Re: [RFC PATCH-for-9.1? 1/2] target/arm: Move
 qmp_query_gic_capabilities() to hw/intc/
To: Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, 
 qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Wed, 7 Aug 2024 at 04:46, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/7/24 00:19, Philippe Mathieu-Daud=C3=A9 wrote:
> > qmp_query_gic_capabilities() is not specific to the ARM
> > architecture but to the GIC device which is modelled in
> > hw/intc/, so move the code there for clarity.
>
> But the GIC is certainly arm architecture specific.
> It's built into the CPU, and shares state.
>
> The fact that it's modeled in hw/intc/ and not in target/arm/ has always =
been a needle in
> the side, though it seems there are no good options.

In retrospect I wonder if we should have modelled the
"GIC stream protocol" described in the GIC architecture
spec, which formalises the communication between the
CPU (including the GIC CPU interface) and the rest of
the GIC (redistributors, distributor). It would probably
have been more work and perhaps less efficient but it
would have been a cleaner way to split the hw/intc
code from the target/arm code. But regardless I don't
think it would really be very feasible to move to that
design at this point.

WRT the commit message, the GIC is definitely
Arm architecture specific. There might be boards
with both Arm cores and non-Arm cores and a GIC,
but the GIC will be connected to the Arm cores, and
there won't be boards with a GIC but no Arm cores.

The QAPI command which this code is implementing is
also (a) target-specific and (b) unfortunately
designed so that it doesn't get passed a particular
CPU or particular device to query, it's just assumed
to be a part of the whole simulation.

-- PMM


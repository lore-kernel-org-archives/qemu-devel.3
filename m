Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C8DFED2F8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 09:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0cIm-0001ot-Rt; Thu, 12 Mar 2026 05:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0cIj-0001oW-HL
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 05:25:53 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0cIi-0003QX-3Q
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 05:25:53 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-64ca9ec3ee7so884698d50.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 02:25:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773307551; cv=none;
 d=google.com; s=arc-20240605;
 b=KAYClcje5bLWk9HX2MwPNdye6IEgj2Uwvgm0awhpf4M/o/Kycoc6cISXfZCmcS9QSW
 Gu+knJDXnMYLVgztxLy8rAI2KWIRVkdPVZ2RGD+Uvbu49VZl0z+c+AkIPnnC4te8VKrq
 JFXIrvOKztNe8EBzaDNbQD8AcnlpzRju1eH9OMDG8Xx2UXxoJxVooUEw9Sue+JDJAm/w
 RPvnAMe4dimWtWvFYPBF1sKhGQUXbz1l4jrx3kz7h/vNKI5tMzTH3ZfYw0o7faJx2OqC
 1g3LRL8qekCqpDxwqjk4zKhK+xKSeq8tzlAORsEbc408KDRc9GiNVf0hfEbXKWKdaQPk
 dH0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gM+u27XvQ3utWic/ozwMv6+2ClPGymibucEYGELtJt4=;
 fh=k3ChZzPxUfJJcY6qRYCKUe7e8UpIbjQ6JU1zCmZzITs=;
 b=A6Zs+OKFMIoXKPe26YUO+uYlr5dLDYDyOfRzCpEsSPI8zvAfC7vb7D6GBk7t/BS5Ub
 46voMCvvm4KI7sucTgAc3TI82ZkH727qOWvZmUhdrNZ2SUYEuQJ1uHgxFBndvdQM6SOB
 EMA5m1Jo43dpDcINozQzLrEfiWIJiNYyS3JpFT4U+QjA9WJ9lyoKv4p5EvjwHMCyklzP
 ibutqjQDMrUyav9asVb+AA+K8pSLZbd+epWtRPUJcYSHPCdoNYwp2HE0jFoMGDGM9Qv1
 aW2Qrgqzq1kMWz3wvngEoPM0dyE7RS3yJCwQFzHxW93q71Df7Ccxrdt4AbKljmz6mPQK
 ZGcg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773307551; x=1773912351; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gM+u27XvQ3utWic/ozwMv6+2ClPGymibucEYGELtJt4=;
 b=rGev14NLdBMPfZkhxhzr3T26CSS7jvPXHsavq1RkS3gM27/xc92yatV8QIfSzafUqD
 id/F++p0YPFRmg2LPAEPHsR8/Uvif9DlRy6XAlUTVTxtitvYcx7hh3XnKz0HU17dZ3fr
 VhYfPcSuAonrgN1HHxM2xVlss1Fv1jZN/gYvZTXK6iosXZVFE9K5PPhNC4MfLSIaVXpy
 6MXVQZtw1MfrpdD42Rqr9f/sJo7W4+N54lEKqG1Gx8ossDNEsBXVxV4AW5gHsAp8049Z
 tIeVGkoyJ+DYKSHJRT9XC67hX3mMJWVQCxbCZGaIgGfCIRfNlVHQg5Jlm8sCfc1khJfp
 WxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773307551; x=1773912351;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gM+u27XvQ3utWic/ozwMv6+2ClPGymibucEYGELtJt4=;
 b=Rcv2gMRBPkAfGioa5CmGkj7OjRaiR6m5t2HuJPtxQN4ahQTUfObfg+lQcYUfq4VnLP
 BwcXjYrSq1jKshSxk71qwNTAoiOd4lLhLHQ++Y+bDNxOQIRaA75lm6uozYcEY6Bq9hay
 ds2nnIPLTsdoHA68xuxS7rXNVA6Z3QsdpGq9qdoQaUhS3FlB99OPBoDMbJNnGhqRMMTe
 SQz377Qb7L2SnzZFkJfufT3o20z3EwakZFXVr6ElzgGvWO33FrKQciL7S+IiBjRCHF5m
 v+NQoiSC5fYJVqLmkFlICp1eDx8iB3J/3tj8oIT7cQMUAhvBaIa9QP3hY6he5sN2yU1l
 xLBw==
X-Gm-Message-State: AOJu0Yxr3PGz7pPzI4vNJ3aMb42fIv3vhF5wiCMZK48vnGXA0ko6YpHb
 TKBsFgWul+pPbJJRxkc7Ckk8FunwUV43/tDm8uKeyGf0x9a80UmsJG6h0IrSx2hLCNev/a92X/9
 sBUvn1kvMSTWmVi/jICZZWeP/L7AiEzze3rQ9sUSJbw==
X-Gm-Gg: ATEYQzwAKcaiWOLP5qYZIi9g14PgY0yC4NN4DISGudLthYcP60Wq7mRIFAovO2MperV
 /MATGyqn0FSPIhagY1TRl0AABL5Ox1p2z+46BAgmRmefkbmYj7Db8ALyPNS8ki8YtxGTaM/kFJJ
 hz9378rJioq0R5OKnBI3w/h95LtQoTGb/YULhSmZzw7iLer0vv1UL0/8xUvObStOsrUf0+eSOMz
 FoaaGurAc/9gorbWel9gP3014995ts33MOH6mILci6yqb+4CWjIMITiJc9PrRJelhd4ahinVBJz
 I3/jVh9SiQ6xrKN7+rADey8sbaqpZhGY+/xGi1c3c9w2yBLDgIW9m+maWUqrjDLGYHI=
X-Received: by 2002:a53:e195:0:b0:649:ef87:5bc8 with SMTP id
 956f58d0204a3-64d656c79b3mr4230210d50.7.1773307550911; Thu, 12 Mar 2026
 02:25:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260312043158.4191378-1-alistair.francis@wdc.com>
 <20260312043158.4191378-4-alistair.francis@wdc.com>
In-Reply-To: <20260312043158.4191378-4-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2026 09:25:39 +0000
X-Gm-Features: AaiRm50gTQ5_r77tby4dEcent5ePeDCpO1s5BQ0aZV04QYPdxhftVU6pIu16nQo
Message-ID: <CAFEAcA8PjHZN0kxKqp=8y2xG3wefmh2JioV06p0Hgw9dkg3_Ug@mail.gmail.com>
Subject: Re: [PATCH 3/7] hw/arm: xlnx-zynqmp: Don't call qdev_get_machine in
 soc init
To: alistair23@gmail.com
Cc: qemu-devel@nongnu.org, armbru@redhat.com, pbonzini@redhat.com, 
 berrange@redhat.com, peterx@redhat.com, philmd@linaro.org, 
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Thu, 12 Mar 2026 at 04:32, <alistair23@gmail.com> wrote:
>
> From: Alistair Francis <alistair.francis@wdc.com>
>
> Calling qdev_get_machine() in the soc_init function would result in
> the following assert
>
>     ../hw/core/qdev.c:858: qdev_get_machine: Assertion `dev' failed.
>
> when trying to run
>
>     ./qemu-system-aarch64 -S -display none -M virt -device xlnx-zynqmp,help
>
> as the machine wasn't created yet. We call qdev_get_machine() to obtain
> the number of CPUs in the machine. So instead of initialising the CPUs in
> the SoC init let's instead do it in the realise where the machine
> will exist.

Here I'm not sure I agree. We should init child objects in init, not in
realize, unless there's a strong reason we need to not do that.
Working around "we crash if the user does something pointless
on the command line" isn't a strong enough reason IMHO.

The problem here, though, is of the kind "what child objects we
need depends on the configuration of this device", which kind of
pushes "init children" into "realize". We do that in some places
already. But I don't like that -- it makes us inconsistent about
how we handle child init. If we're OK doing some child init in
the parent's realize method, why not do all child init in realize?

thanks
-- PMM


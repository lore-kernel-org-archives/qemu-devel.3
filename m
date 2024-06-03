Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7CB7C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 14:59:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE98v-0004a3-Nk; Mon, 03 Jun 2024 10:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sE98t-0004Z2-LQ
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 10:58:35 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sE98r-0001rq-T2
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 10:58:35 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-57a50fecbadso2203534a12.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 07:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717426711; x=1718031511; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vYSMhdiBptCCxxftJKQ0L/QW7zUSoAmxXntOTKFaTm4=;
 b=gA0GKRxGOFjh1QzYPVja8WizMObxqJtqpBWT0Sm+4KmXhH0Ax64DjGZC4+f1BViSlb
 R4klU2GYkh8ciudeBl7ErNfL/azmTI1/0a8NkKw4yOT2Cr/EDbrXd0WBBU9qAKwMxagT
 9kS8IKSWh47yPbvWS4aEYMuswSCR5+II/88WsbQWb0D8McrCLqBVwAuZ6fiaV2XLJgGi
 6J90g/1cvXjpHR4j5nB2jFTYLBz0XjdD9v5Engmd6KBNLvRILqYFYPREc8TuCoAQEkiv
 ADWtulZU+r+c7iujuFCE8LD9VlRzat2Rg7MD1iBA+o6+pye2Qvn2NWhlKT1hnEcA9h8M
 Qt+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717426711; x=1718031511;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vYSMhdiBptCCxxftJKQ0L/QW7zUSoAmxXntOTKFaTm4=;
 b=fUkkx6PpL1UjAnb2ZO/Lm9bdI7TywXeLRTchd4CxP3lC078F548FUf8sZR2vYP9ASC
 BeyLVm/V8w+0E9z9t5Uv+wEXgCpCfPTHNF35DSlxD8YMz73oKV7B2x6smn63qMjr7/N6
 ns+5OTH8TCM6YhGMN8ES9wldWNEZJLacCR6VOLI1xUp1yEF0yXiTEZSWdUB38kZoPHly
 gDzcmkngUHRLLpL1eiSMxsiNIsjU1q5CfCYwQBv2rTQUvvxLNsl9F27psS7ddi29ycGq
 4/buJMCFlRTXubimzfsGivEoRvd/FkK+EOKW+K4UvyrsR0Z3QTYOZL9U7YxaCx03qxsM
 V6Ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeMlNCsehB1G6++4ZsBgtgAjl7iiCOPNwi7R4MgpsJlEJhCenIlrata5XVUt/a7JOmeSEMOY+OlAzyX6+uRQlDdNGCJVI=
X-Gm-Message-State: AOJu0YxRxoD1M7XmpS+NdAmnYUMs2NQemGVwDQysUbts70by6knZyov4
 ZgSIBoUc/jQcLYlpEbC5a3rK1FAZ1R48kksWscdXL0B3QduBVowpgDvYbsFtuIN5iBk+2xz1M0k
 qM5xJWNEm1WIa48K6Ekl1hRVZFXlKfLTYq0O+Eg==
X-Google-Smtp-Source: AGHT+IHa7IoYxrwvD6KFiyxGUiXC/QGYVvmox78BaSVnwZhVIJ7vK44NOe22rzEIwsa0+V/JbZkSKQf9i/bQ2tWVCZc=
X-Received: by 2002:a50:9313:0:b0:578:5a44:722b with SMTP id
 4fb4d7f45d1cf-57a363b4939mr5377170a12.7.1717426710937; Mon, 03 Jun 2024
 07:58:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240529133106.1224866-1-thuth@redhat.com>
 <CAFEAcA8yOgGS8VdFRmJJKaUZe9Q=jDDh7itK6Q7vUH4TtEbFnw@mail.gmail.com>
 <Zl27orDnp8hOqgKo@redhat.com>
 <844ed2cb-9f91-439f-bd6a-73003acfdef1@redhat.com>
 <Zl3YBQQ5yWdQoH4y@redhat.com>
In-Reply-To: <Zl3YBQQ5yWdQoH4y@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Jun 2024 15:58:19 +0100
Message-ID: <CAFEAcA_kkM6VgeVKxbSB_=UHOn0a6aFFUTUOeNP4otEoboYtvg@mail.gmail.com>
Subject: Re: [PATCH] io/channel-socket: Fix -fsanitize=undefined problem with
 latest Clang
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 3 Jun 2024 at 15:49, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
> We can't rely on the sanitizers to catch all cases where we're casting
> functions, as we don't have good enough code coverage in tests to
> identify all places that way.
>
> Unless there's a warning flag we can use to get diagnosis of this
> problem at compile time and then fix all reported issues, I won't have
> any confidence in our ability to remove -fsanitize-cfi-icall-generalize-p=
ointers
> for CFI.

You might think that -Wcast-function-type would detect them at compile
time, but that has two loopholes:
 1. void(*) (void)  matches everything
 2. any parameter of pointer type matches any other pointer type

It seems to me rather inconsistent that the sanitizers do
not match up with the warning semantics here. I think I
would vote for raising that with the compiler folks --
either the sanitizer should be made looser so it matches
the -Wcast-function-type semantics, or else a new tighter
warning option that matches the sanitizer should be
provided. Ideally both, I think. But it's definitely silly
to have a runtime check that flags up things that the
compiler perfectly well could detect at compile time but
is choosing not to.

thanks
-- PMM


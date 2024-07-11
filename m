Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94397C3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 06:51:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRndg-0004TL-9F; Thu, 11 Jul 2024 02:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1sRnde-0004SZ-BI
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 02:50:46 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1sRndR-0003Kd-LL
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 02:50:46 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2c967e21888so459417a91.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 23:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1720680632; x=1721285432; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wPgMjfksUIjXSL1ShTlJg87xhI3lwLC1qofvujd4npU=;
 b=DwM9F6a9Ki6+q7WCZlaD7/IAyIhkPITTP9ArnRAQQErQjkdV8v7SAM0sxY1bUIPTuL
 zaxHkg548lHWOqTAUGKtaEqS6P4r932rrlfC6aWwCzhnlnonSl5DyTBtFEExrFfWPhl/
 gTZuIH3m8pwgjdpro0lx3ENbMPY4eBlM8lmK/3bmvEc1zIwNJCmH4rnFA7ItqkNEISAg
 suW9p67tFxRGgXqNHLoI1XgWcyy/Iill7TJfjsLwsPuOamRVc7Dq0YWCxv3umKWT6dOA
 auX+uYG2506cLq6CLGgv2/0d+Sy1XTDZ4Ch4I46RU4M6GQhlanBavY0nxNmUpJdWw2Xa
 jnUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720680632; x=1721285432;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wPgMjfksUIjXSL1ShTlJg87xhI3lwLC1qofvujd4npU=;
 b=aAfTWcMJE6pLz3WbCUk5PAH9tV64/N5DLQFh+9BXzYT+LMCbyZNPxi8hPaL4pe4Cni
 Fys8w/l9+8+CyYxl8+dk5ZV6AVcnl51+iIW7HYursTw9XbHxs8VhoBim3Ggt2qx4IkeO
 g4A44JJP4ro0BWDHxdCjeLFEolud+/KoMG7IagP3+HttghdYTcHnmlzqIlr226V1e1g9
 5zPAdknqYDaUxhyXzuaTzm2pSqTREBxEZtP90CZ/aaHCKlE73jZE9yxfUn7SBoAeQXGP
 9UiDpeeZYSt331z3lDpi3i+i5ZpgLPTPPO57RND6JfXqgHr2H81CGGtAyxzonp59lPKF
 IxiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4JIvrwSW98OExYv6UZ+R17avQ+0clsD/gpJFcifHEtqrCGaFSgo3JwQrwl7kY0hbUsVjOFjvI3Y1TloRv/0ifn+mAt+4=
X-Gm-Message-State: AOJu0YyVzE8Od6dlYAvhNIQfGsPj+PCDYM2JlW6xwE6iX/eyA5WbUAY4
 tRuMSvy0Iug5e/AoPJSAbulgbRxm93vJQ/jahwIOe2Uk1gwZdsj+1nykGWr8vzEZ3y54SQwDvvk
 PC+K4MnnTHbAEX1tgg3/A8Dkb9fq8AxAMkXP9
X-Google-Smtp-Source: AGHT+IGu4+luV3xLpp4/1IsalKUaN84DkU0A38LTMngkousXTmp52VdDn8L3ecH9xp5v5QszprwLVrLlyDhzf7ioTEc=
X-Received: by 2002:a17:90a:bd82:b0:2c4:aa78:b48b with SMTP id
 98e67ed59e1d1-2ca35d486cbmr6474048a91.38.1720680631968; Wed, 10 Jul 2024
 23:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240710111755.60584-1-thuth@redhat.com>
 <87o775qnfm.fsf@draig.linaro.org>
In-Reply-To: <87o775qnfm.fsf@draig.linaro.org>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Thu, 11 Jul 2024 08:50:20 +0200
Message-ID: <CAJ307EhFr2HODXGBCxZHxiHFtkmGRVjidRuwxrOMbaBqFO5zTw@mail.gmail.com>
Subject: Re: [PATCH] tests/avocado: Remove non-working sparc leon3 test
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=chigot@adacore.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Jul 10, 2024 at 5:25=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> Thomas Huth <thuth@redhat.com> writes:
>
> > The test has been marked as broken more than 4 years ago, and
> > so far nobody ever cared to fix it. Thus let's simply remove it
> > now ... if somebody ever needs it again, they can restore the
> > file from an older version of QEMU.
> >
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
>
> Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Yeah, it's been on my todo list for far too long but I still didn't
find time to work on it.

Reviewed-by: Cl=C3=A9ment Chigot <chigot@adacore.com>


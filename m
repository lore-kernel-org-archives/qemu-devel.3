Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45A8C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 17:01:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMV05-0007Hh-BT; Tue, 03 Jun 2025 13:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oleg.tolmatcev@gmail.com>)
 id 1uMUzt-0007H7-6L
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 13:00:21 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <oleg.tolmatcev@gmail.com>)
 id 1uMUzm-0001rs-Tg
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 13:00:20 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5534edc6493so2640938e87.1
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 10:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748970010; x=1749574810; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pk2Xmq+xko3Yx2sqGkPQhvITIbQuYi89MkRY4rluKoc=;
 b=OkLlICLrSqwgwYPGZndNNTRHtbs2f59TNaSJlW+B7sDl0e7KD/FKVhxZOT+t/YUkYM
 TT1x1wpoteBZ12Z9bZCoNcoSseC53KEHLnOEgSuM4etxcNRCPu1XwcA6qOZAP8oFw1NR
 sP83Yu8IbR6XPmzCEWMgIqzKwVs43zb0Cn+bMTdG5dovbsrC46qMEp5BZ8OmIMQ+ZRYc
 Toa2H6rnWH762vc0NtemZHryn9cDPnAz2eZpmp6s5Rsb6lj7HDtiCWy42oYUa+2WvcM3
 QlgQGpUddmKEI3pOT5LV+gNqMbch2naqMTheGi85F/04Lg5QAGpD0/M/qT9HMo6/lc/w
 JF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748970010; x=1749574810;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pk2Xmq+xko3Yx2sqGkPQhvITIbQuYi89MkRY4rluKoc=;
 b=dOdGVNPlY6ROMo6Gs4zWR/bZfyhidjfonIejU2/Qq5vtT5nabsooe9rN+NJo47jcGG
 jB2kriwXa+75SwUEE4HpI/OSAHYC8VfVx/e1k5R8r1sC+t6nE7vy+rBSbPyDD/YyZDYq
 TDs1XUhimpcO75ZiJOh6zn3ajKREu7GwTYL4YUZCBXFuU5uUWfqel6mpqT1dfhbEUEm2
 xrmeQm+0jJKImitoWIwQB+t0zkwLJy1daZDzQVtH+JNjyfm8lHcxw58yHoFhhQhcQ2fR
 /9kMKj5mOX4yyD/bkBfq3n+pi7ojRU807d8421pKuzahww5jSNtNVE2xZkHZjdJ3YasA
 0qIg==
X-Gm-Message-State: AOJu0YwT+BI+k1Q4FV94IlD8QahkUGpKGry7fr/LUaj06dp4It7jWOgw
 zHhXExwW2MXvNOyE0naLDKH/YqXeiRVoXVUIA6n6nlQonYhdeXicZdqO58pEtv7UhRnlGKTf2h6
 4mG2GHYdWDV91xZpTq5ix5Jd09tugvZs=
X-Gm-Gg: ASbGnctXRmywEoCuFJTFhBnYKeow4gug8jkPvS0qlBbZ5VPPGFKlmRE+joamK/HsB+2
 kqLxcEFZbyPgih6mfwSUDQH/4saMcx5QKGdoUyUcA9FgMf9MtNHWRjSWv2yqy3EptSSVrZtKez3
 BdcYwZiWdIJ6KnonK1RgRWCpnrmY+HQ4ddxEHUsfSOPdlqyqMoJ1zAh5OR7tRZSis=
X-Google-Smtp-Source: AGHT+IHThnOnqjTAolDWd6kXDi3iHtRtiGRE+vtMUg5qKe4+41l0y80JRZHsac1p/9sU/eGv8FAPu6qjLP9kk9qDwGg=
X-Received: by 2002:a05:6512:b94:b0:553:2e10:a79e with SMTP id
 2adb3069b0e04-5533d16b40fmr5796749e87.14.1748970009457; Tue, 03 Jun 2025
 10:00:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250529085437.1479-2-oleg.tolmatcev@gmail.com>
 <CAJSP0QVT56Sx8-T2+qF2LnFksL=feGL+v0CJPnX+ZuQ6iMMMRg@mail.gmail.com>
In-Reply-To: <CAJSP0QVT56Sx8-T2+qF2LnFksL=feGL+v0CJPnX+ZuQ6iMMMRg@mail.gmail.com>
From: Oleg Tolmatcev <oleg.tolmatcev@gmail.com>
Date: Tue, 3 Jun 2025 18:59:57 +0200
X-Gm-Features: AX0GCFuaEtbEl72iw94sOzchA4fYu2pZloj3U_ff6JL3kpTAP6XnEysgRY5MWmc
Message-ID: <CACcXsZgbzf+Rp8AujP_cGgh8J9xk=uadLM5Bem_6PCV=EzP2kg@mail.gmail.com>
Subject: Re: [PATCH v2] meson: fix Windows build
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=oleg.tolmatcev@gmail.com; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Am Mo., 2. Juni 2025 um 20:45 Uhr schrieb Stefan Hajnoczi <stefanha@gmail.com>:
>
> > +    try:
> > +        event_filename = os.path.relpath(event.filename)
> > +    except ValueError:
> > +        event_filename = event.filename
> > +    event_filename = PurePath(event_filename).as_posix()
>
> Please do this in one place to avoid code duplication in the backends.
> Perhaps event.filename or a new field can hold the properly formatted
> value so backends don't need to call relpath() themselves.

I'll move the code to "tracetool/__init__.py".

> I noticed that out_filename is also emitted with #line but, unlike
> event.filename, no special processing (relpath() or as_posix()) is
> used there. Is it possible to drop relpath() and avoid the whole
> issue?

"out_filename" is not a problem because it is a relative path in POSIX
format. "relpath" was introduced in this commit
9d672e290475001fcecdcc9dc79ad088ff89d17f. I can not decide whether it
should be dropped or not.


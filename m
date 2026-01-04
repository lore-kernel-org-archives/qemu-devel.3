Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DBFEC2A06C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Jan 2026 05:46:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcGvu-0006XA-4N; Sun, 04 Jan 2026 00:45:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vcGvl-0006WB-RZ
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 00:45:34 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vcGvk-0007Or-7A
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 00:45:33 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b802d5e9f06so1675742266b.1
 for <qemu-devel@nongnu.org>; Sat, 03 Jan 2026 21:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767505529; x=1768110329; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u/axX/9+3e8zutKmyxLf5ge1oeM1TXw8e81dE/+XPbs=;
 b=Tp0DjuGDPsQfvUz+qNJykYESraOwdcl9WXKT5AbTLIbggvHyVJoiDQLbuBIrWTIKqz
 8N7znbJcE8B/5OCmJHWRbg8p3k7CVhHdnwPKZoLGxXyqHPPHPqqz8XYSWv1nwyUvbetE
 rqyg74oZkombSSctOHsxgCkn1d8OOxSs2CivVp+8cebI8MuqDMtRlett7cW4gBUX+XKT
 4YfcdDtcX1M/wi/1fFjifEvqVGl5PIwE1plWaRcS6fIBTiRrKiThjw8eVUM66tPX3m1b
 qDXGHg6Sun3saVTjOkrQlXqCFsGjBc8+GEL+pLrew4m2z/3KIMYafNuBIC+QDS6BqXCW
 pY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767505529; x=1768110329;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u/axX/9+3e8zutKmyxLf5ge1oeM1TXw8e81dE/+XPbs=;
 b=lNYDyUSv9b0PxZ3blnkF4eUzh8/pW9UA+qXWGwjVA1VapjDplsaL4WHEsDVbqmiOvv
 /iBiY5tvPn1eqJCbVtRr2aZgYd9D7JdKSsbn3Z0unriex4hLN9hRA0VYkZb1XtI0sfGl
 Ud7u9Az+/3ugwzE8j15NFfBUZcJwwjVuNKewlixOXYfxeN6CxPgI+8uQwwP7zMHHaf6q
 3rqBIvZwfuefLv8J2W92QwkIdCer/wlmseS3WTW+soJJMGWKpCE0txMwABXxgrs9/4Bd
 6kmVmEzG8JZkIJoMsRwye2PKC+myHiZRW21XLKXH5h5h0QGuJlha9xI+8Mo9+zPFgIjk
 c/Qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRnob7CKVhiykReDWStAcVhFA+O0uU8fy1dVD2coi26M4lNDAYwn+xNNTUl56CveIhDm+G81GzPo6W@nongnu.org
X-Gm-Message-State: AOJu0Yze6ZRAMR5Zq2NA5QvmlSNDivkZAlB13FcxLOE+R1r5WApV1ywJ
 EGAg+0BtWv+K69RMfeXGifKCez5MYYuwiPdopbWCwcBmW4knA4plwV2MdnH42LV9JrG931cSw20
 ysEHUabM9hrwZtgpbp4XMWFaEOtzDgcE=
X-Gm-Gg: AY/fxX4liVM3ysrxq2XFH9hFz/WZSDZPmhrTWdgJ8a00wyVwoWq4J+k9qhhxJ1QFl3Y
 WwwhxGzCk2SwkVZj1Sr/PUND37MSS4A5xW7rANKMLRzNui4LCu+yuYHa1Jp7ZETqG/2Y01UY/Zt
 x/t0eCdGyaSxVQoQFnTHVFCmLZyGWnFPkqF9Gj0mUjqa6YxKKUjv9SiqU3AAg1ZQoB7NWjx5UQc
 uaZv5DMMcmbLnn3li38FUu/CqzOVqKYdSs/zB/cVCm9brfH6Fz1Nt+DCoqFJZpZ4sihhKqOcBUp
 S8SVJw==
X-Google-Smtp-Source: AGHT+IHvZ7IAoIIixz1/9Uyl2UbwC/VR5W+dsy4pKBoOx3GOXhufFOiox9yDvgKYbk01OeZH1m8HHwcU7hf0Y0SAVCA=
X-Received: by 2002:a17:907:3ccb:b0:b73:8cea:62bb with SMTP id
 a640c23a62f3a-b80371a3d87mr5284127066b.31.1767505528819; Sat, 03 Jan 2026
 21:45:28 -0800 (PST)
MIME-Version: 1.0
References: <20251230-colo_unit_test_multifd-v1-0-f9734bc74c71@web.de>
 <aVPpg_LwlGFIPfen@x1.local>
In-Reply-To: <aVPpg_LwlGFIPfen@x1.local>
From: Zhang Chen <zhangckid@gmail.com>
Date: Sun, 4 Jan 2026 13:44:52 +0800
X-Gm-Features: AQt7F2rIYYfdH2D9eRf6LSeV8bzJt2XjihSpTNjN1PhvXIlHjdhqpuw8M_11YFY
Message-ID: <CAK3tnv+f8b9fd_n9_6Od3f__ZuNUtuT2Q_MXszam_k=ooRPqyQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] migration: Add COLO multifd support and COLO
 migration unit test
To: Peter Xu <peterx@redhat.com>
Cc: Lukas Straub <lukasstraub2@web.de>, qemu-devel@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@trasno.org>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x62c.google.com
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

On Tue, Dec 30, 2025 at 11:02=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote=
:
>
> On Tue, Dec 30, 2025 at 03:05:43PM +0100, Lukas Straub wrote:
> > Hello everyone,
> > This adds COLO multifd support and migration unit tests for COLO migrat=
ion
> > and failover.
>
> Hi, Lukas,
>
> I'll review the series after the new year.
>
> Could you still introduce some background on how you're deploying COLO?  =
Do
> you use it in production, or for fun?
>
> COLO is still a nice and interesting feature, said that, COLO has quite a
> lot of code plugged into migration core.  I wished it's like a multifd
> compressor which was much more self-contained, but it's not.  I wished we
> can simplify the code in QEMU migration.
>
> We've talked it through before with current COLO maintainers, it looks to
> me there aren't really much users using it in production, meanwhile COLO
> doesn't look like a feature to benefit individual QEMU users either.
>
> I want to study the use case of COLO in status quo, and evaluate how much
> effort we should put on it in the future.  Note that if it's for fun we c=
an
> always use a stable branch which will be there forever.  We'll need to
> think about QEMU evolving in the future, and what's best for QEMU.
>
> Thanks,
>

Hi Lukas and Peter,

Thanks for this series, I will support for background info if Peter
have any questions.
And CC Hailiang Zhang, although he hasn't replied to emails for a long time=
.
If no one objects, I think Lukas can replease Hailiang for COLO Framework.

COLO Framework
M: Hailiang Zhang <zhanghailiang@xfusion.com>
S: Maintained
F: migration/colo*
F: include/migration/colo.h
F: include/migration/failover.h
F: docs/COLO-FT.txt

Thanks
Chen

> >
> > Regards,
> > Lukas
> >
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > ---
> > Lukas Straub (3):
> >       multifd: Add colo support
> >       migration-test: Add -snapshot option for COLO
> >       migration-test: Add COLO migration unit test
> >
> >  migration/meson.build              |   2 +-
> >  migration/multifd-colo.c           |  57 ++++++++++++++++++
> >  migration/multifd-colo.h           |  26 +++++++++
> >  migration/multifd.c                |  14 ++++-
> >  tests/qtest/meson.build            |   7 ++-
> >  tests/qtest/migration-test.c       |   1 +
> >  tests/qtest/migration/colo-tests.c | 115 +++++++++++++++++++++++++++++=
++++++++
> >  tests/qtest/migration/framework.c  |  69 +++++++++++++++++++++-
> >  tests/qtest/migration/framework.h  |  10 ++++
> >  9 files changed, 294 insertions(+), 7 deletions(-)
> > ---
> > base-commit: 942b0d378a1de9649085ad6db5306d5b8cef3591
> > change-id: 20251230-colo_unit_test_multifd-8bf58dcebd46
> >
> > Best regards,
> > --
> > Lukas Straub <lukasstraub2@web.de>
> >
>
> --
> Peter Xu
>


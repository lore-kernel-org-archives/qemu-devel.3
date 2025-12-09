Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA5ED3B7EA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 08:02:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSsfy-0004jr-7H; Tue, 09 Dec 2025 03:02:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vSsfw-0004jh-TK
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 03:02:24 -0500
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vSsfv-0006Dq-AL
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 03:02:24 -0500
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-8b2f2c5ec36so567131185a.1
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 00:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765267342; x=1765872142; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A8J/6qrLxlu9XXNg2wCG4W6UI0SNQDF8KRdtJiDD9eU=;
 b=baJXSb0nXlaSSjMEauxHf7zKNy6sKu/9ypTIG4ELPd90n5o3g77JJxpIFxs54tplMs
 XRaftYmvrGBeeStHXn1Gd2uqWI+L0kZ1DnCDs+Og/IhsPFI+HAUksqzDunaXkwXVshjl
 bA6JC0YVXgFyujVcjXRvb/KCXYxTRPBZYxkFxRZOyhTc0QJMTx/s9e4dl24V7jHNbtA0
 71KEpcQcGlHgk07Lo/eS94ulT8ja2epffOl2nNVnwRILEnSwnkVQu38Na00dCIHrBQaX
 ccw202W9U+RWblRpPVRrqdQ2Cjd2FHZXD/B2x+iiiFQklA1sJDz/ORqjT18CZyLtc1wD
 ADeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765267342; x=1765872142;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A8J/6qrLxlu9XXNg2wCG4W6UI0SNQDF8KRdtJiDD9eU=;
 b=Gd3oUrt3M30pnKduybcjccIJ1nUnXjSXYSDI223SOUh5VjcV9TIbYoqWmJaSJmil7m
 mPDgaQzHJc0FPnRbDZHCsnxAcA5ttVMwLzcyOYW7GBJpoVlQ4UOtHm0tv62ThrFz56I3
 sV7RPr/T/Q0cwIjQQ4D9+a2FnRlER7PUAaKJ386t4xpTle7ZiPF8Q5ztA0vkZ+Ty4T3J
 j4AvwqHuGPQF8JnBpZkhtlDrGlnJ7lv/5nJV6WK4GXIzsBE1MmLdb6vgP6sgVzI8NmaU
 bA0lzWJj4s6hzQI87bXS8etYfHUKFlX0kL2MUQD16kJMS8Vvk797taiBBwVl4ENgTOqF
 r48A==
X-Gm-Message-State: AOJu0YwxGqqeoR+fMWZWE/iTJ0Yx/gp23JlLrhm6NJyR0L7coLpYCAJz
 5JI0hHneziXBLnK0HuIezl42WC1Gi5hE/VIH+Sqemi6AnDgkSexSy9XWKVrf/FFDBHOGmeYOVF8
 83TTOFj4nS7OjS8Te+Ox6mNowxqcvoQs=
X-Gm-Gg: ASbGncsDy/l21AkcXl2CYiiGs43iqOtd5onC/WGc9Z+l4CGOl0JnsUVanlSgWZjKMS9
 5Iw+LTD9UzrnJwaoFoB7X/DDin/sagvZ+EPQ+THHUVGg/NFgjcpJZC/+5190ILKRAUyntHNKLaW
 uP2k6pQ0mXGk/aF8L9+sFe5ZiTpl3xym8WISTlAeqtQzJwaRuHSAhOm9fa5topegAS1Ummm4Zq0
 flfmwubzu+eKpcpPyMPLkMTQ1XDI1bdQx1/SNvu6RTtg8zqGmXpLFRuDHMyB43WUmx35v0kAQ4j
 13H4JZMdckrJkq0/wVQiYpLz5P4=
X-Google-Smtp-Source: AGHT+IERWbAr4He6xXRBcOouPuI3lPFZ15RIPNAJtgsNuc9Wb26bUSbmczNDYRmEA5EIGrKydy4/eStAqHlyxpIgebU=
X-Received: by 2002:a05:620a:2902:b0:8b2:faa3:4c77 with SMTP id
 af79cd13be357-8b6a232e102mr1389589385a.0.1765267341640; Tue, 09 Dec 2025
 00:02:21 -0800 (PST)
MIME-Version: 1.0
References: <20251208225849.705554-1-erickra@cs.utexas.edu>
In-Reply-To: <20251208225849.705554-1-erickra@cs.utexas.edu>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 9 Dec 2025 12:02:10 +0400
X-Gm-Features: AQt7F2oqlH958UmzeVnL_hjX2qLyttkd7XjHZuqllU18jZOvMDccuMTIiFSv8ko
Message-ID: <CAJ+F1C+-v-O=avgRPD7HO_E4hWFkET3FjzG0Jb8k6fdfk=FLPA@mail.gmail.com>
Subject: Re: [PATCH] char-udp: Fix initial backend open status
To: Eric K <erickra@cs.utexas.edu>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::734;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x734.google.com
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

Hi Eric

On Tue, Dec 9, 2025 at 5:18=E2=80=AFAM Eric K <erickra@cs.utexas.edu> wrote=
:
>
> This patch removes the `*be_opened =3D false` override for the UDP charde=
v
> backend. Since UDP is connectionless it never sends a `CHR_EVENT_OPENED`
> so it is never marked open. This causes some frontends (e.g. virtio-seria=
l)
> to never perform any operations on the socket.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2993
> Signed-off-by: Eric K <erickra@cs.utexas.edu>

UDP is connection-less, so it will not be notified when a client is
ready to receive. If we make the chardev always open, the device may
send data too early though.

At the same time, a chardev that only reads isn't very useful.

I don't think we need to introduce a property for the change of behaviour.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  chardev/char-udp.c     | 2 --
>  tests/unit/test-char.c | 2 ++
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/chardev/char-udp.c b/chardev/char-udp.c
> index 572fab0ad1..1025f577a0 100644
> --- a/chardev/char-udp.c
> +++ b/chardev/char-udp.c
> @@ -215,8 +215,6 @@ static void qmp_chardev_open_udp(Chardev *chr,
>      g_free(name);
>
>      s->ioc =3D QIO_CHANNEL(sioc);
> -    /* be isn't opened until we get a connection */
> -    *be_opened =3D false;
>  }
>
>  static void char_udp_class_init(ObjectClass *oc, const void *data)
> diff --git a/tests/unit/test-char.c b/tests/unit/test-char.c
> index 8a98e42cad..2869c4e09d 100644
> --- a/tests/unit/test-char.c
> +++ b/tests/unit/test-char.c
> @@ -1012,6 +1012,8 @@ static void char_udp_test_internal(Chardev *reuse_c=
hr, int sock)
>          qemu_chr_fe_init(fe, chr, &error_abort);
>      }
>
> +    g_assert(chr->be_open);
> +
>      d.chr =3D chr;
>      qemu_chr_fe_set_handlers(fe, socket_can_read_hello, socket_read_hell=
o,
>                               NULL, NULL, &d, NULL, true);
> --
> 2.52.0
>
>


--=20
Marc-Andr=C3=A9 Lureau


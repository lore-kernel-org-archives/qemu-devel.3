Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EACEACD98C7
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 08:32:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXaor-00086H-Se; Thu, 11 Jun 2026 04:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wXaop-000863-TJ
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 04:31:19 -0400
Received: from mail-dy1-x132c.google.com ([2607:f8b0:4864:20::132c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wXaoo-0000kR-DQ
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 04:31:19 -0400
Received: by mail-dy1-x132c.google.com with SMTP id
 5a478bee46e88-307631dbfedso526583eec.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 01:31:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781166676; cv=none;
 d=google.com; s=arc-20240605;
 b=LlhgSWJehdA5F06UbgoP4iksbg2sQQGV140NbTwLfRoxeRg2dgMdvQFtLym2rMliR0
 m+ViDxOVtqqr8Im6p3TLBTzHVrHEztfdX+wJ6PVrwETV6SVlVOxMAvLTXgOrMxnRUFFw
 vBzyvHSFGNk2BRssOBcXNZOm1go6ly1etC/y3Da2oQohrKCBBfa/PM8WNzgi8P9v2MvT
 ZtZgBIHtywT2t6vpw62uJDRFA5SLurb6NJNboRa0U7Aj8nZa0glsAuuxptqcP85rEyBU
 ov0ldfHOwCAdpjLggDodwufquitcJpHJ40k/su/e5+F9e/f4nJqyce9A4icv1aK9lDkh
 HpRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=J8n+5coUrKAXZcW60GtWGL9jL9B1lxqrRPUFPq8t4Ek=;
 fh=AZkZ0b1lNOWrPAvx6utUMPvNnVTPoQb/VE06IgS7KRU=;
 b=Od6E53FVoTrvVxrPvsbqaIgm51rCgSViejCvh9xwkwqrcc3PPEOQAoZnY1iIsE4rvr
 x4IPWKiI4SYXLHJTVyMGg68ahzWcxxzP4tX/ZwM4pizxMf9E5sgK/rPqe8rl8R8M3WVI
 4KzhAuKTSePPwiqANc9hSFy2BA+bIzSTY9TXwBAwZIOhdtVzouILqjUMtrs/0nIlbtAQ
 53FFsawszuOEuiUZxZPiegsRj+34g5DIUX0iuiWqvcLjRjMRK6eglkinFrrFE+e6HaOo
 Ss45459ilury1baLx0S2dUyFsvazZ438zS+D9nNRM+kB7C179Jrz7ZrA9HoqjF3U3d5j
 c2gA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781166676; x=1781771476; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J8n+5coUrKAXZcW60GtWGL9jL9B1lxqrRPUFPq8t4Ek=;
 b=hxXR3dgaIWNESk6DR87PF0VUUnvcu0wjropYViPYGdcRc2AnaiwAY4YtVAbBCa1LUp
 ysiTksDZdkE9g5mwIy0TsWg/FD2TLeNK4MHJRvIJkKT+4PPuCnvbd8ApxsCAZOKkRNl8
 XetD1y18tcMvwRvPgFxh0K3jNhPKCKaOQbdKvqpMS2Ck7uqEgG/0f5rvZfh3/3J2BItm
 CiKW2XfbuqC/GOPoSuLo4bBE06l4vhdAPxB7OVwqq6ioyElBsZ+zUAh9vCbEDgei9U3E
 PwjpBaDo/Jz05UrBmdmWo8F8sTGrKmglkB6EfymV1yxyCchbdE9oTL9iV+48m3ITIRz2
 /iKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781166676; x=1781771476;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J8n+5coUrKAXZcW60GtWGL9jL9B1lxqrRPUFPq8t4Ek=;
 b=D4Xan2tESxXyhLRoEJVSsgsqecsSp/mClbiwfxLFGjLhr/0pJOZTOyP87LShsEWKjI
 /RSdt72FjjS7fehmzcA5X6acanghJ1nSkzVtsxwoxPP4Vi80sn9qXtvVYgEE5EG13NGs
 efGQnYTLm344R25XASzNAmjmIq8ntIxLF/m2oOg9ZQwIn2B9SBOZW339tk9I8EHNU+Dk
 KS+ewqO+rb+rd0pMduCD/p6573AAqPeaymxh3Hf3+CtQ6dG8MWD4EPFswoA9HCmfOt1n
 DcABEE0W0nKfBrNqtzDijuT2LYBP7gTGPnVhsXsODKFOrmyZhzufszdPxkuT4LF8J/Bf
 Fapw==
X-Gm-Message-State: AOJu0YzyGgvgC4TCRjrpEhz7btNcm6bUphTHZzMGjIG1deCx2pYMQmoI
 R5S/sXCSKdp91cxqCZQ4jOAQ5yrFrWhqZjc+npixZsa77ZTzSAfQH3IzyOS3ZLxn2fvJaAR2gy4
 QsKSjHrPx8NmT1oXnXTCJBX64FkBlX7Q=
X-Gm-Gg: Acq92OFTA4Jyk11SHJMKDH6n6vnE28GvYSgtmRdeK2TSG38OaDt4BF1YTJoN8/6COCQ
 CAgYW+J9MezoPgGowZplG/yFo7cUMpmS9FbyS4s6J7Tc1Ym48nGeguw/B/1wg9hk+D8hL8ahQrw
 fFxH5OutW+OqzgBeMRPSmW1I+FNFXJyiaOvqrqoUC5qRHjy8QHV8l7ouNUsZSNYdsooB/1iW/zE
 0Sx8KbGhXlV0zMEa7DiphWJO93nUt4GfvSwYxY/hkpPFrWVa3WpFz8ga2jsn3I0ylyBqRu6oC7R
 9UI21ykQtQeom7+TZwtp6ZSQPH75WRDD8+yFM5kNAQldvBrkcw==
X-Received: by 2002:a05:7300:5713:b0:2ea:b7a9:580d with SMTP id
 5a478bee46e88-308047f2728mr1493274eec.9.1781166676027; Thu, 11 Jun 2026
 01:31:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260608-b4-ui-v2-0-9ea6355ea08f@redhat.com>
 <20260608-b4-ui-v2-30-9ea6355ea08f@redhat.com>
 <ab53b726-97dc-48e4-93c3-7a32eacf65a5@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <ab53b726-97dc-48e4-93c3-7a32eacf65a5@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jun 2026 12:31:03 +0400
X-Gm-Features: AVVi8CfWHm_gtOb3agZNP6HJUEVXrofn74K1Tr0tOsjWp-3ZQqhMewKZ6JVkZAc
Message-ID: <CAJ+F1CKN7gmmM=Od0pXKj1qOLM1w5W+HNPuxWo7U+DerzK7h9w@mail.gmail.com>
Subject: Re: [PATCH v2 30/33] ui/console: register console in QOM tree
 dynamically
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Alex Williamson <alex@shazbot.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::132c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x132c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi

On Thu, Jun 11, 2026 at 11:51=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2026/06/08 16:16, Marc-Andr=C3=A9 Lureau wrote:
> > Consoles created after init_displaystate() (e.g. hotplugged
> > display devices) were never added to the /backend/console[N]
> > QOM tree. Extract qemu_console_add_to_qom() and call it from
> > qemu_console_register() when the display is already initialized.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   ui/console.c | 17 ++++++++++++-----
> >   1 file changed, 12 insertions(+), 5 deletions(-)
> >
> > diff --git a/ui/console.c b/ui/console.c
> > index 975eaf15706..e01d893df4b 100644
> > --- a/ui/console.c
> > +++ b/ui/console.c
> > @@ -376,6 +376,13 @@ void qemu_text_console_put_string(QemuTextConsole =
*s, const char *str, int len)
> >       }
> >   }
> >
> > +static void qemu_console_add_to_qom(QemuConsole *con)
> > +{
> > +    g_autofree gchar *name =3D g_strdup_printf("console[%d]", con->ind=
ex);
> > +    object_property_add_child(object_get_container("backend"),
> > +                              name, OBJECT(con));
> > +}
> > +
> >   static void
> >   qemu_console_register(QemuConsole *c)
> >   {
> > @@ -413,6 +420,10 @@ qemu_console_register(QemuConsole *c)
> >               }
> >           }
> >       }
> > +
> > +    if (phase_check(PHASE_MACHINE_READY)) {
> > +        qemu_console_add_to_qom(c);
> > +    }
>
> Coldplugged consoles are not added to the QOM tree when -preconfig is
> specified because x-exit-preconfig will happen after init_displaystate()
> but before phase_advance(PHASE_MACHINE_READY). Below is an LLM-written
> reproduction case:
>
> build/qemu-system-x86_64 \
>    -machine q35 -nodefaults -display none -S -preconfig \
>    -device bochs-display,id=3Dgfx0 -qmp stdio <<'EOF'
> {"execute":"qmp_capabilities"}
> {"execute":"qom-list","arguments":{"path":"/backend"}}
> {"execute":"x-exit-preconfig"}
> {"execute":"qom-list","arguments":{"path":"/backend"}}
> {"execute":"qom-list","arguments":{"path":"/machine/peripheral"}}
> {"execute":"qom-list","arguments":{"path":"/backend/console[0]"}}
> {"execute":"quit"}
> EOF

good catch, I will have to introduce a state for when display is initialize=
d.


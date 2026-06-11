Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78AB6CD98D4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 08:41:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXayF-0002Jm-8v; Thu, 11 Jun 2026 04:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wXayC-0002JQ-JF
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 04:41:00 -0400
Received: from mail-dl1-x122c.google.com ([2607:f8b0:4864:20::122c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wXay9-0003zF-Qo
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 04:40:59 -0400
Received: by mail-dl1-x122c.google.com with SMTP id
 a92af1059eb24-135e7f4a295so477754c88.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 01:40:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781167256; cv=none;
 d=google.com; s=arc-20240605;
 b=ifoBZojSmQH+DLVQ0X5HTeGvJr/+qD+9xCWXQcQqQCt58hhrSk74NhTmPMSA3jS8jA
 S6sfgRLUhrLfIFNTSZd+Cgb1tfPqCf+0kPNeuLWUHMNrSTMhrR1vg58yN3npLshP+Ple
 HiTsPcZ0vj+Jl6Dv2lW2BmAtiO7rlKnfYRo+/T64VUdla73YtS2aB2xrei0/C0hm0npB
 BbV6QmBz4+4WR47FC15mbQYG/U1q+38bE0hQ0EKBtATCuDDdNTpSyks5EXV9MT6S9KbQ
 OcqbP7AUe5GAtNYqsVhJJvfr3IcUlTDBV9G7+Z3W8zP7MaKj8ZQQvYLjWmaqBV2pWDoB
 YEWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JEjDFfS7s3rmGjv0aDT1jmW7c1PhCjpXYp/T57O1E9Q=;
 fh=AZkZ0b1lNOWrPAvx6utUMPvNnVTPoQb/VE06IgS7KRU=;
 b=CWPUWDycRujrkok4YTiUn3FomHeZTH1ObJ6VgyHbseCPThm27dwTvLx1BMt7MmqGEA
 zs5bms1BsvUTPUfrc2G2nweNXtoSKoiJnJe1pvG8lMYDWPJ1Y4fCxO0L4S8UJdrPuQmC
 QeJhxbQTPp+8R57MHQL4RwqLVJfjCPQHXArjyMb0J8B16nr9y9r00u/eQPqR+EVasoFH
 mENtm/8VYfEcGZG/EEP80MxNpUGg06rPNIkUnM7qKQI8MQeYElECU+dy6HAoMrZVFpYJ
 5eHdAE8uBr96Y76IZNtqpEH1yJQ/ylaOhC+b+jP1N9rgN6Mbmh5XAPQUn6Y1qyny8o+G
 oHpg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781167256; x=1781772056; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JEjDFfS7s3rmGjv0aDT1jmW7c1PhCjpXYp/T57O1E9Q=;
 b=Ab38WDDGnL6qA0NLdqQKU8Ws27Rsw38WDf6ZK7kq8qeYAiDvEVfAAt9fd5C2ApCrU8
 nJv2Jr8cciX8YKwSaR29BXug2MCVcTCkvnzSpnwqYTn2hICmyEOvaMtNPFkckA1Dm8z+
 AghbGEg9gVzqJOeMJ/M+c+mljacieyIjyVAGgw8KByH6oxwVwyeIu5fCFZ6WDiRiGFq8
 vIAMCDkP6nOdGC8amjoCXWiNQlVMAIdBxqAeRvBNIy9zQA4qdUEyup30odxrbDN9D8xw
 oT+P/MSb1/EIDJYQEmuAX6QNmIAVrNoBteiA8ydkjxEcMN/gH7WNRcVQJ/8vH2aZjOAI
 IL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781167256; x=1781772056;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JEjDFfS7s3rmGjv0aDT1jmW7c1PhCjpXYp/T57O1E9Q=;
 b=PHc8u1KbItrUgCG8Z89gJbKFfNDIZRRYdc1lCqZvbNAbeixxYokAfjoLZ2oMyVunjL
 BZTpMiZ7eki+jYwGKLeycxUK2GSEAMvDRlrAV2Ru0HJy9Y7jjjIHWi8bSpv6fr/h4pyN
 /3VbFfO5zy3I6QtTYKCKfNdCBd7OjYD/9iQBof4GI6mn/Z1LVDF6DabBdcTpA+trLWfl
 lJs54fa99mmgOvLG7PsZ3Z1QPk+MwEHq9KdOtG/CKCRBZk19NC9pZcnZuxKskTcodLxv
 WUrqgGF7t5zeJ2+dtDBD5C64Q3qmWZL8Ks4p5oHfDeaLRPTeZURaLRvqGhmRtt3JFg+A
 Pn2w==
X-Gm-Message-State: AOJu0Yyc+6tqE0yg8D1SYPjjvxyRwreF1NAF8mU3Ox1HugUcKtxtG1D9
 eUUV46htmsiUB2/PDVghj7wJQw9pJ8Dx3ykNLskl3CPRe20trPYEuuNBRJSci57pcV4yQ4Ud/cJ
 vmzJSSGPpuKAD9+8CHfNf+us6tA8i/YE=
X-Gm-Gg: Acq92OFwXjkWA1V6aZhYQ48QXdDAYKz3KubrZpeifSbicJ9pAwsPGd1xfEDpNxxnw+j
 nwYvWFQ391pq584H4WylicuIPUOp5cIRcyCk+UKh72DYH1PROsindlTkl7pG3VmWmEMEhqQ3RZE
 m6A/e/AnkD+ho0aRjYKDDYYlfw3WE6NeyDLYCW5rjqTbTTBWxeaxMIeyajEiqEclSr3DADfqsSL
 YfOhYw9hay/GTVpApVYbW9rS/qz5GdDd2878gOBPJRW3ywuLaEG17jyu7WFwQi+/z6DMBzy/qpW
 PcOixHZgpxXufTwmXjXK7eHQa2J2MTlidiPHzmVtfAyw9FAy9g==
X-Received: by 2002:a05:7022:38f:b0:136:4faf:eb09 with SMTP id
 a92af1059eb24-13842e36306mr955771c88.7.1781167256031; Thu, 11 Jun 2026
 01:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260608-b4-ui-v2-0-9ea6355ea08f@redhat.com>
 <20260608-b4-ui-v2-8-9ea6355ea08f@redhat.com>
 <bf524c77-f300-4ec3-867a-e3a6882c72e0@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <bf524c77-f300-4ec3-867a-e3a6882c72e0@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jun 2026 12:40:43 +0400
X-Gm-Features: AVVi8CdfzDlvWkVMkJrQM3LOkAgYhlum6ciDu_oOruhO1oTUzY9NEbKSHsej-uE
Message-ID: <CAJ+F1CJmvfZ9ig1zUB4cv0kVmnZ9RGvFMBYLEfMiYGdpTA3rmA@mail.gmail.com>
Subject: Re: [PATCH v2 08/33] ui/dbus: remove led handler
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::122c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dl1-x122c.google.com
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

On Thu, Jun 11, 2026 at 12:01=E2=80=AFPM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2026/06/08 16:16, Marc-Andr=C3=A9 Lureau wrote:
> > Reported-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   ui/dbus-console.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/ui/dbus-console.c b/ui/dbus-console.c
> > index 0813a08f85e..f784ccbe572 100644
> > --- a/ui/dbus-console.c
> > +++ b/ui/dbus-console.c
> > @@ -53,6 +53,7 @@ struct _DBusDisplayConsole {
> >       guint last_x;
> >       guint last_y;
> >       Notifier mouse_mode_notifier;
> > +    QEMUPutLEDEntry *kbd_leds_updated;
> >   };
> >
> >   G_DEFINE_TYPE(DBusDisplayConsole,
> > @@ -152,6 +153,7 @@ dbus_display_console_dispose(GObject *object)
> >
> >       qemu_console_unregister_listener(&ddc->dcl);
> >       qemu_remove_mouse_mode_change_notifier(&ddc->mouse_mode_notifier)=
;
> > +    qemu_remove_led_event_handler(ddc->kbd_leds_updated);
>
> It is better to avoid call qemu_remove_led_event_handler() here because
> GObject.ObjectClass.dispose is documented as it may be run multiple
> times and qemu_remove_led_event_handler() will cause double free if that
> happens.
>

right, I will use g_clear_pointer (remove NULL is guarded)

> Regards,
> Akihiko Odaki
>
> >       g_clear_object(&ddc->iface_touch);
> >       g_clear_object(&ddc->iface_mouse);
> >       g_clear_object(&ddc->iface_kbd);
> > @@ -578,7 +580,8 @@ dbus_display_console_new(DBusDisplay *display, Qemu=
Console *con)
> >
> >       ddc->kbd =3D qkbd_state_init(con);
> >       ddc->iface_kbd =3D qemu_dbus_display1_keyboard_skeleton_new();
> > -    qemu_add_led_event_handler(dbus_kbd_qemu_leds_updated, ddc);
> > +    ddc->kbd_leds_updated =3D qemu_add_led_event_handler(
> > +        dbus_kbd_qemu_leds_updated, ddc);
> >       g_object_connect(ddc->iface_kbd,
> >           "swapped-signal::handle-press", dbus_kbd_press, ddc,
> >           "swapped-signal::handle-release", dbus_kbd_release, ddc,
> >
>
>


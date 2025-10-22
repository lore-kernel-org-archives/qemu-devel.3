Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A35CCD1BF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 11:01:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBWaR-0001cX-1j; Wed, 22 Oct 2025 07:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vBWaQ-0001aT-15
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 07:00:58 -0400
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vBWaO-0005gg-6Q
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 07:00:57 -0400
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-4e89183fe47so9871611cf.2
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 04:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761130854; x=1761735654; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SS3UBAmh5I+Rc7RHIzo/OLa4JTD0iG67exwNIlhDnRI=;
 b=Y28PQlkojfQNXPypZrZ+lvJIEkqUEGuWfZlvZ/Ght1sGdLo38pihzXe8WyKVyJ3NOY
 /sYQZslTwsWOjoEhiQU9KeBk6Ilw3rlohon1Cxzqps6c/Vw3PQwSKzSUiPCLKvcdTNrR
 dUOUCpnklDvsrLUzwVOo2gBef/eS1Y0awTfIG5nXfy6CDeSkDh/FbgYOOwmQsBu44ZVU
 gH0Cw18b3WOsvRGYmUMQzGzQeq4Egrb9XsmW3q7SgsXBY8xoJPvQxCdYZEl++mVBofsS
 SYSTfU4Z5/ktlxBYasYIKIsg00T4eCpg5trYWCkA9OuufoGjUoTLz8PG4FIK7vukl62J
 YnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761130854; x=1761735654;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SS3UBAmh5I+Rc7RHIzo/OLa4JTD0iG67exwNIlhDnRI=;
 b=raX6ZPW5XAr2SYri4wcDdsn+c6kOWY177Q4ZRoBKOb2hrr7tMQ4mfBmtwuJym+J2+R
 K02mt6QiHNtzYMRzqtSD21/f/Lo5RRcV1c7Mj0SULfiBqc9LtMIFg0Jhk2eG8km9F8cA
 tiC3nUGP9hVg/gFZCeDeUANHNkx2dksxZIbH+hjxUFe+v0xdzW/iAgssRQul6mmaBxb7
 /MeJuLETuWPsbm4VwEqiS+zYS3tv9QPx4I8aMQd5rridrC3bamGbNjK+8RJ8Y4OqBck7
 G1qgevEbIO3ZDw/UYi1i6DjC8NWHU7HMNnxD8Yg75Pjj3SnFNoMyiNGse4e3i1eZxoPH
 dJQQ==
X-Gm-Message-State: AOJu0YybeMR+yTZcARtmUFAEkmnrqEwjsJjVt9yLu2PHbYcaeCq8XAR1
 KjmdmpKm845GaHusqugoalLocZ/CvRYEv06OoIcwmRVMLSRJQCJTxyJR9cPjA6BMFpAEJMftqN4
 iH/TsTuo/JzOKOteCnLoLicuKChO//S8=
X-Gm-Gg: ASbGnctGXL1kozctt8WiBqNhE5eHIw4W3rjiyxZTXDiSD4euLpgQAMMgGpIQOue516f
 YvZbhUpIszJxf4KhoeWdxg7gZWdWf84LFhDx/G66DopkIkXVrvyjv5zf+L5kzFGZgozNK8o2lKa
 1JrjHyLfZlCLiVzw6fZE4IAvOjWsuJgGgVP3aax0C4T8lurQbrJtBsCmrxeAiQb4t6WDWaGi5s8
 3zPuF4WGg9VZdDVOGskABHjasZLCFFYveE5GUY5l0qyMXGY4JeKi3h/X7+DXBHfDuRduUO/qj0j
 iEbb4qtuIZzubmES
X-Google-Smtp-Source: AGHT+IHv1k5dcjuvk1D63hKsg5G0T/sqChZYtOSDNUgwSrzV5CM7/wOo90WvNIls03KiOn+K0wziF0NDsPy6yNuEUEI=
X-Received: by 2002:ac8:7c54:0:b0:4e8:b3cf:b9fa with SMTP id
 d75a77b69052e-4e8b3cfbabdmr168191641cf.29.1761130854362; Wed, 22 Oct 2025
 04:00:54 -0700 (PDT)
MIME-Version: 1.0
References: <20251022101420.36059-1-armbru@redhat.com>
 <20251022101420.36059-3-armbru@redhat.com>
In-Reply-To: <20251022101420.36059-3-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 22 Oct 2025 15:00:43 +0400
X-Gm-Features: AS18NWCMQMFb9kZhi1fmpBIjM3FcjahLBlGImUVMkyGaM1wlTmkcXvQQr3giKSg
Message-ID: <CAJ+F1C+g5BKUsYoo1Qpi7Hmuhowi2X37JSBWoQwid+t58U6X7Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] qdev: Fix "info qtree" to show links
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82d.google.com
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

On Wed, Oct 22, 2025 at 2:15=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> qdev_print_props() retrieves a property's value from its legacy
> property if it exists.  A legacy property is created by
> qdev_class_add_legacy_property() when the property has a print()
> method or does not have a get() method.
>
> If it has a print() method, the legacy property's value is obtained
> from the property's print() method.  This is used to format PCI
> addresses nicely, i.e. like 01.3 instead of 11.
>
> Else, if doesn't have a get() method, the legacy property is
> unreadable.  "info qtree" silently skips unreadable properties.
>
> Link properties don't have a get() method, and are therefore skipped.
> This is wrong, because the underlying QOM property *is* readable.
>
> Change qdev_print_props() to simply use a print() method directly if
> it exists, else get the value via QOM.
>
> "info qtree" now shows links fine.  For instance, machine "pc" onboard
> device "PIIX4_PM" property "bus" is now visible.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  system/qdev-monitor.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> index 2ac92d0a07..850f0c6606 100644
> --- a/system/qdev-monitor.c
> +++ b/system/qdev-monitor.c
> @@ -745,19 +745,18 @@ static void qdev_print_props(Monitor *mon, DeviceSt=
ate *dev, DeviceClass *dc,
>      for (int i =3D 0, n =3D dc->props_count_; i < n; ++i) {
>          const Property *prop =3D &dc->props_[i];
>          char *value;
> -        char *legacy_name =3D g_strdup_printf("legacy-%s", prop->name);
>
> -        if (object_property_get_type(OBJECT(dev), legacy_name, NULL)) {
> -            value =3D object_property_get_str(OBJECT(dev), legacy_name, =
NULL);
> +        if (prop->info->print) {
> +            value =3D prop->info->print(OBJECT(dev), prop);
>          } else {
>              value =3D object_property_print(OBJECT(dev), prop->name, tru=
e,
>                                            NULL);
>          }
> -        g_free(legacy_name);
>
>          if (!value) {
>              continue;
>          }
> +
>          qdev_printf("%s =3D %s\n", prop->name,
>                      *value ? value : "<null>");
>          g_free(value);
> --
> 2.49.0
>
>


--=20
Marc-Andr=C3=A9 Lureau


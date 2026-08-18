Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A7EC5DF7E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 12:15:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwIiV-0000vw-Ft; Tue, 18 Aug 2026 08:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wwIiS-0000vR-GL
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 08:14:52 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wwIiQ-0001P3-IY
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 08:14:52 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2cf6d65d8a7so58110065ad.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 05:14:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787055289; cv=none;
 d=google.com; s=arc-20260327;
 b=fuwrI24NSyxjPXS7DHIlgVfr0dW0elWt4q7taj+F3epFxM7ToBRRm0iID0r9CJB3lB
 4TpTkKTjRqoWpYFM4elKCLkyXfG6QWMc3E0ZmQ9mvC99pRSFc7skj0rq0jRHEj8Ojnis
 xYZpAnxQXbgM6JlekKUsXCEjUwJCh74NGrTzm8RzCPnuYLeQvnH/Ge3qbyM517ZhShza
 mULQmG+C3IeBwgp7M8CZM9ZQ84JrAPvKfyxW28oJ2quBnuGAn1x757piCVC/Prwa9ehd
 V3zTHChky1LY27sHL6WaUsC49OCFKU6K8QjcG4uGXT4XJF6FG0iP91HvNHwfSqeWniSn
 z1YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7H1Rz0Je1rNqHjh5H2JQHC8UmH8MFo0qQsXzr2Z29rY=;
 fh=wNIBB09whFX4aqH2z8BcDR9CesbTcDsK1XevePNeRLw=;
 b=G4wi9WsLTU66lhWtsd6iDqiUFa9PBX1Uwmr6PyhBR7/9ip7DfplKRjDdDBOeyOs3vL
 BnKmCaq6HP137HJLQokG6F7tIUtOjlSP4/RXZJHziRxwTg5K3+mZHH7P+tO7IYvVOIXa
 FDeyyMbkYAzERQsZgF9n4f8ENYwbig4vViOmONOhStB3HlZsFeEud7Uyqph0IJiK/y2z
 QCR/6zYfEJflUEYL/m3gdX3XOts7FfNmbfYm38ULf1Q3jLsJlRl0oD2xOp/mDjcJXJhJ
 fEGq/G7UprNRvIm+pfw9dcagjBa7SnN+dze/97FoCuce4cvYhPPXcPJndmOuXmLlD6KW
 DUmQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787055289; x=1787660089; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7H1Rz0Je1rNqHjh5H2JQHC8UmH8MFo0qQsXzr2Z29rY=;
 b=iOme79Ypg23SocprE/Ic5pG763kVPqOa/cTN483jaJDA4ojHX7Ctbly2DazhUnx4je
 Kgxp9lQCbLwxLxyispqvPNd6Zfoj4Oqem3rEFz/H5MbEJptSzP/Qp2EQCFrx16ywKp2X
 QRYtAhdk3OkCFXUHlLDChvwitwoT1QUvltfl12pkNcsCI9xEgQYCzCByGK17LFOkHtLv
 N8cLJDk3GJ/17O/h7b6ji6pWBzamkWcu9z5ghMd564IDV/Bb6VgjuqSKajnLNwMmcMnd
 4OnohSq6wWuIjOnzWkVBAfsix7pE+pXFdJIm+vuXKgM20uMrAOylXwxIQGW86EYRg818
 xMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787055289; x=1787660089;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7H1Rz0Je1rNqHjh5H2JQHC8UmH8MFo0qQsXzr2Z29rY=;
 b=Ol0q/daUAxiTyCRcaXV8WfD7R/2X/avY3tC2ywniR8Qnju0g3hDcfEbQSsAZVM+nEs
 PcB7TGoO/9MYH3ziQYsmCJrVsTt1hTCDVzwNyuhXauVzFby20rQl6sj5xlHxqLxgI4Sr
 OOCF/Jss5U/14kzQNapwvnQgSEXmTd9N2RiZkoXBcFwQD9CfC1/nD6lrb1SOyuxAX9WO
 SJap8FTmBtksvLMl3CfY+V6QRalWDSAG4ZIj2RLejJoVSNZy/AtN5n71/FhBnwMVjTsP
 hneg5kbUKNGILSIpIc6c2U1xBZfgEsTkS6MsZYmGUlw4j9d8qvPCh2/Y/Br+3qRXBp6d
 2+lA==
X-Gm-Message-State: AOJu0Yz17CicVPyj9Dmf8FhHmXsTJguw1qm7+PHc4tnAHTCegHVY8zqz
 /wdoV0trBdFoEU82uqzt+BZ/XKZ771ODbNz5QRSa6EE5HVtlM7RyejtquftpR7NY+l5nV7xZNMj
 qnXETaJl9F45uYxlFQ+026/Mfk/XbPJz9KvEpOnU=
X-Gm-Gg: AR+sD10FUhKGBM3JJjpBxiOF1W5yW83yHEe6jjQBL11QoiZeBlbIhSGiYYuVMb2+5Ng
 2iiIzSW8RJhddDYOeL28iaMR7sNunM+imKdYD3Og3M0T7+eoS4Q1KOZJn5g8Qk8T98x8zSQBD0S
 H1XSDsDYG40Ii2w4CoTwKwxin8ULNl87M5Yqs+sJsT5iVstb6OIotKfe31Pk1UAWywMPjLghFqY
 6Sy4d0fHDEgM+yDj99UbIr2H3tm2uWmMM6tscmBs6vbA5e+3TGC7Mze76xCBIvB4Pjrl/mqyWxY
 XuS3f5wOeSElI4Q9nj9PH6LcsuZSNLIqpgH5nV+n2eZD+2F1FYoUDSkAJ4AMvYo4/0qpjVrKfTj
 q831DqWvhNfY=
X-Received: by 2002:a17:903:22cb:b0:2ca:61bc:317c with SMTP id
 d9443c01a7336-2d3b0c5df17mr334333975ad.13.1787055288660; Tue, 18 Aug 2026
 05:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260818115258.429605-1-colazcyg@gmail.com>
 <20260818115258.429605-2-colazcyg@gmail.com>
In-Reply-To: <20260818115258.429605-2-colazcyg@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 16:14:36 +0400
X-Gm-Features: AcwNN1UFmpEGpB2VKZP0UWaFOTs-e4xnugZi56J4wKczzA0pg_HllOoD_Ao72jc
Message-ID: <CAJ+F1C+BWmJ3svmx1OmJHvMZ45DTtqHaq1q9C_rD4jL=TTQOKg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/1] ui/dbus: add org.qemu.Display1.UIInfo interface
To: Chengyang Zhu <colazcyg@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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

On Tue, Aug 18, 2026 at 3:53=E2=80=AFPM Chengyang Zhu <colazcyg@gmail.com> =
wrote:
>
> Currently, the SetUIInfo method cannot set a refresh rate.
> Simply adding a refresh_rate argument would break the method signature.
>
> This patch adds the UIInfo interface containing
>   * properties as staged display settings.
>   * the method `Apply` applying staged settings.
>   * the method `Reload` reloading settings from the console.
>
> Signed-off-by: Chengyang Zhu <colazcyg@gmail.com>
> ---
>  ui/dbus-console.c    | 86 ++++++++++++++++++++++++++++++++++++++++++++
>  ui/dbus-display1.xml | 32 +++++++++++++++++
>  2 files changed, 118 insertions(+)
>
> diff --git a/ui/dbus-console.c b/ui/dbus-console.c
> index e1ac06814b..dc5c991f80 100644
> --- a/ui/dbus-console.c
> +++ b/ui/dbus-console.c
> @@ -55,6 +55,8 @@ struct _DBusDisplayConsole {
>      guint last_x;
>      guint last_y;
>      Notifier mouse_mode_notifier;
> +
> +    QemuDBusDisplay1UIInfo *iface_ui_info;
>  };
>
>  G_DEFINE_TYPE(DBusDisplayConsole,
> @@ -155,6 +157,7 @@ dbus_display_console_dispose(GObject *object)
>      qemu_input_led_notifier_remove(&ddc->led_notifier);
>      qemu_console_unregister_listener(&ddc->dcl);
>      qemu_remove_mouse_mode_change_notifier(&ddc->mouse_mode_notifier);
> +    g_clear_object(&ddc->iface_ui_info);
>      g_clear_object(&ddc->iface_touch);
>      g_clear_object(&ddc->iface_mouse);
>      g_clear_object(&ddc->iface_kbd);
> @@ -528,6 +531,80 @@ dbus_mouse_mode_change(Notifier *notify, void *data)
>      dbus_mouse_update_is_absolute(ddc);
>  }
>
> +static gboolean
> +dbus_ui_info_reload(DBusDisplayConsole *ddc,
> +                    GDBusMethodInvocation *invocation)
> +{
> +    if (!qemu_console_ui_info_supported(ddc->dcl.con)) {
> +        g_dbus_method_invocation_return_error(invocation,
> +                                              DBUS_DISPLAY_ERROR,
> +                                              DBUS_DISPLAY_ERROR_UNSUPPO=
RTED,
> +                                              "UIInfo is not supported")=
;
> +        return DBUS_METHOD_INVOCATION_HANDLED;
> +    }
> +
> +    QemuUIInfo ui_info =3D *qemu_console_get_ui_info(ddc->dcl.con);
> +
> +    g_object_set(ddc->iface_ui_info,
> +                "width-mm", ui_info.width_mm,
> +                "height-mm", ui_info.height_mm,
> +                "xoff", ui_info.xoff,
> +                "yoff", ui_info.yoff,
> +                "width", ui_info.width,
> +                "height", ui_info.height,
> +                "refresh-rate", ui_info.refresh_rate,
> +                NULL);

Let's use the qemu_dbus_display1_uiinfo_set.. setters if possible

> +
> +    qemu_dbus_display1_uiinfo_complete_reload(ddc->iface_ui_info, invoca=
tion);
> +    return DBUS_METHOD_INVOCATION_HANDLED;
> +}
> +
> +static gboolean
> +dbus_ui_info_apply(DBusDisplayConsole *ddc,
> +                   GDBusMethodInvocation *invocation)
> +{
> +    if (!qemu_console_ui_info_supported(ddc->dcl.con)) {
> +        g_dbus_method_invocation_return_error(invocation,
> +                                              DBUS_DISPLAY_ERROR,
> +                                              DBUS_DISPLAY_ERROR_UNSUPPO=
RTED,
> +                                              "UIInfo is not supported")=
;
> +        return DBUS_METHOD_INVOCATION_HANDLED;
> +    }

Can we add a read-only bool property "supported" on the interface, so
clients can check before?


> +
> +    guint width_mm;
> +    guint height_mm;
> +    gint xoff;
> +    gint yoff;
> +    guint width;
> +    guint height;
> +    guint refresh_rate;
> +
> +    g_object_get(G_OBJECT(ddc->iface_ui_info),
> +                "width-mm", &width_mm,
> +                "height-mm", &height_mm,
> +                "xoff", &xoff,
> +                "yoff", &yoff,
> +                "width", &width,
> +                "height", &height,
> +                "refresh-rate", &refresh_rate,
> +                NULL);
> +
> +    QemuUIInfo ui_info =3D {
> +        .width_mm =3D (uint16_t)width_mm,

Can we call the accessors directly? qemu_dbus_display1_uiinfo_get_width_mm(=
) etc

That should avoid some extra variables and casting

> +        .height_mm =3D (uint16_t)height_mm,
> +        .xoff =3D (int)xoff,
> +        .yoff =3D (int)yoff,
> +        .width =3D (uint32_t)width,
> +        .height =3D (uint32_t)height,
> +        .refresh_rate =3D (uint32_t)refresh_rate
> +    };
> +
> +    qemu_console_set_ui_info(ddc->dcl.con, &ui_info, false);
> +    qemu_dbus_display1_uiinfo_complete_apply(ddc->iface_ui_info, invocat=
ion);
> +
> +    return DBUS_METHOD_INVOCATION_HANDLED;
> +}
> +
>  int dbus_display_console_get_index(DBusDisplayConsole *ddc)
>  {
>      return qemu_console_get_index(ddc->dcl.con);
> @@ -550,6 +627,7 @@ dbus_display_console_new(DBusDisplay *display, QemuCo=
nsole *con)
>          "org.qemu.Display1.Keyboard",
>          "org.qemu.Display1.Mouse",
>          "org.qemu.Display1.MultiTouch",
> +        "org.qemu.Display1.UIInfo",
>          NULL
>      };
>
> @@ -626,5 +704,13 @@ dbus_display_console_new(DBusDisplay *display, QemuC=
onsole *con)
>      qemu_add_mouse_mode_change_notifier(&ddc->mouse_mode_notifier);
>      dbus_mouse_update_is_absolute(ddc);
>
> +    ddc->iface_ui_info =3D qemu_dbus_display1_uiinfo_skeleton_new();
> +    g_object_connect(ddc->iface_ui_info,
> +        "swapped-signal::handle-reload", dbus_ui_info_reload, ddc,
> +        "swapped-signal::handle-apply", dbus_ui_info_apply, ddc,
> +        NULL);
> +    g_dbus_object_skeleton_add_interface(G_DBUS_OBJECT_SKELETON(ddc),
> +        G_DBUS_INTERFACE_SKELETON(ddc->iface_ui_info));
> +
>      return ddc;
>  }
> diff --git a/ui/dbus-display1.xml b/ui/dbus-display1.xml
> index d96bae2ed6..a766fd0862 100644
> --- a/ui/dbus-display1.xml
> +++ b/ui/dbus-display1.xml
> @@ -1159,4 +1159,36 @@
>      -->
>      <property name=3D"Encoding" type=3D"s" access=3D"read"/>
>    </interface>
> +
> +  <!--
> +      org.qemu.Display1.UIInfo:
> +
> +        WidthMm: the physical display width in millimeters.

Document individually each property/method above its declaration, with
@references. Check the doc build results.

> +        HeightMm: the physical display height in millimeters.
> +        XOff: horizontal offset, in pixels.
> +        YOff: vertical offset, in pixels.
> +        Width: console width, in pixels.
> +        Height: console height, in pixels.
> +        RefreshRate: display refresh rate, in millihertz.
> +
> +      Reload:
> +        Set the staged properties to the state of the display.
> +      Apply:
> +        Apply the staged properties to the display.
> +  -->
> +  <interface name=3D"org.qemu.Display1.UIInfo">
> +    <property name=3D"WidthMm" type=3D"q" access=3D"readwrite"/>
> +    <property name=3D"HeightMm" type=3D"q" access=3D"readwrite"/>
> +    <property name=3D"XOff" type=3D"i" access=3D"readwrite"/>
> +    <property name=3D"YOff" type=3D"i" access=3D"readwrite"/>
> +    <property name=3D"Width" type=3D"u" access=3D"readwrite"/>
> +    <property name=3D"Height" type=3D"u" access=3D"readwrite"/>
> +    <property name=3D"RefreshRate" type=3D"u" access=3D"readwrite"/>
> +
> +    <method name=3D"Reload">
> +    </method>
> +
> +    <method name=3D"Apply">
> +    </method>
> +  </interface>
>  </node>
> --
> 2.55.0
>
>

thanks


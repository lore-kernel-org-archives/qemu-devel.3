Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63BBDC61DD9
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2026 11:49:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0e1m-00058g-C1; Sun, 30 Aug 2026 07:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x0e1l-00058X-CN
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 07:48:45 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x0e1j-0007Xx-BY
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 07:48:45 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2d7200b2e15so27099975ad.3
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 04:48:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788090521; cv=none;
 d=google.com; s=arc-20260327;
 b=c6Nwf3cjwcp9ZAbsJ1pc2I0PbdYpfJelgkqAm20FF61n4jPhfFmDtG0nNIK6U5Iiu1
 vwQVVE4zr1iIyFIHHMN44l7odxx3bdcNj+eKmsF8wObMU7/G+LhJXXNfMS/2NC4g2coo
 Dfim7CDHyoDBWcn02rX43JzEFXC+KGhnHbFxagW2S61Ei+MoleRuhA7HLooi55zK9tVl
 ILjUpFdxQXjeCsOOEpJ+0N+WoxIGXUSzatIXnrXklKb9bwGnf6YgzJxN8B5VLe1cVriR
 vIm54Wiivm3gLVybG/CxviNM1Fiouw2jR/vK8UgG7d1nSwaM7Kk5TnacJUhVMo4ZLrXP
 a8Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4dnbNGdSGtZ91Zw3n9WlYxvAC+/7WcuMMCImA4XhsSY=;
 fh=wNIBB09whFX4aqH2z8BcDR9CesbTcDsK1XevePNeRLw=;
 b=EUDy0N/rRkF1T1LGBmMm/8XeQkLfUE2tk02DJUFiLgLgY84XSJhD8BlgDK4lQ7LOar
 0Gr8Jwc8wp/WisyvxsyL0+fwOBSpb+cGjYE9l6oBVa39XXQP0eeM0cfmFt66EslVU1gX
 OU6vxY7gPLhTPznfSxx3etoYJp//xFWE3IQ293XCxkx0iFQuWTUKQvTGrGAD7F5yjPGP
 os8xgkY5vd0hALn/qk9JamZPOCm1G2pzX1YDfERBzPBkCJKtAD+Mmnsy7dccjATbPH2I
 COW52gDdHs2BtkpX/kwowF+CGmwpT+G2RsQDV3wH9dQNmjydzDWqbAfZRzznbZWB78sY
 eT3Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788090521; x=1788695321; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4dnbNGdSGtZ91Zw3n9WlYxvAC+/7WcuMMCImA4XhsSY=;
 b=qLDAv78YmotYboaCUU9V3ihhaCEXeEIFxH9W+Sg2SXjWsWP5N1P/F1EbfRM76eFaRY
 fLlnOFlAYn6aUFMtbk0817YS/2jYkgtQoJuIjWRkGXGNliYgMAZN6qVSFt8FS7lcpsbv
 0Lb5cKjN91wvp3sMGHkra5We7j9UpBM5/a6TTjOOwozaTN4njd/IVe3udNrfjWgMervC
 dBqvd17IPK1Vv6pTAGbLFn9CcCWSjPrrwODN4AhI30HGE4cXcleWE4OWJvVkzEJf0xWP
 B4rRElhZXO8qeyAmhuW94t7O1ltt/zay2GN/g/c1PodnY6LJFaIFvU6nJBHeEhX/JBUj
 W07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788090521; x=1788695321;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4dnbNGdSGtZ91Zw3n9WlYxvAC+/7WcuMMCImA4XhsSY=;
 b=iCdZ5NZ1nRcxsPH0ohbHX1uzsWlMVzLWQHIAP4NhQLlHJF1tTnJdnuCruC3HBbardr
 yBF3U+LHpKG5Lf2B1JHc4y0mBbt4IIPifRupowd/77B4hAipXDBa99lKK0ou2LzBYqyi
 X2qGEKDLR3kOLPqoaO3H7nXHLS8t6cYn4o1M/Ot3N3wWcZwZozWuINHWMlf7lPOuzdDv
 /X3NdUrLN0/DAsDB/1zaqSs6GxjZM+tL3EDKHekyY7EPrjEWm9m+0hq38S+HURuFXjVO
 39XefqXvHPfZp4NvNNwH57mRSW/ltZxlaktk3qJo2oH/pftKso0fU+kTJ7oVQcggCWgQ
 Z3dw==
X-Gm-Message-State: AFuF++mfdwKjAZzgteuSZeRe7omlFKIbjVq3KhGmzreWQmFZG8PU+vu6
 scX23fTIT8PBFhThf3qohf1La/Xcc6Epvlo8lVnzyX1TyP0uMSHv7rdQnM9nyT04FgIOzOeTbhs
 CWCrWzuc3KIfnqueyutUsa75P2yi35+s=
X-Gm-Gg: AYBFou3BFW5UcA9L2g63hXtKzlnS6EMK0+hSetc7JqLSP2ykHHuWQsA0dtSTwYwPE+k
 yiz8w5a9yXaFSyOW72vJJpS00Am5Xwmfg+3RhCL0tU7nvGPeZ+e154NuWzJo/NgW3AAg5V2sMpR
 bQh5pIeI24Iqsr1WtTuL8GxNFIopWXJmM00NuIa8fSU3z/xjt643DK7xUfpTSPDBFafHOfRNZRt
 pHOvb/spkX3B7t9jeVqiMeFaIVMY/eT/WP1G6g/gcvZSuJXOGx3vF3JZteakoJrN4gMVqsV9h6k
 zRwYW5qC/SFK3KqgqmzPYusza09gZNHDMOf/C3Foh9oJ4wPO6HAlHFfVMCc2wia4kuhKhfZIiTQ
 w
X-Received: by 2002:a17:902:f549:b0:2d5:e9d5:8ae with SMTP id
 d9443c01a7336-2d74dc5e8c3mr205548975ad.5.1788090521492; Sun, 30 Aug 2026
 04:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260830054641.45437-1-colazcyg@gmail.com>
 <20260830054641.45437-2-colazcyg@gmail.com>
In-Reply-To: <20260830054641.45437-2-colazcyg@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sun, 30 Aug 2026 15:48:29 +0400
X-Gm-Features: AcwNN1WqlavCtY_Vj1oG7BLsxYChdcT7F5zMI4sNDdFlezGC07H6Gmla1VbRNCo
Message-ID: <CAJ+F1CJjQm4dHy5U7MbTFSLgAu5Fgu3LdHrJvkvDPQQcxPtztA@mail.gmail.com>
Subject: Re: [PATCH RFC v4 1/1] ui/dbus: add org.qemu.Display1.UIInfo interface
To: Chengyang Zhu <colazcyg@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pl1-x636.google.com
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

On Sun, Aug 30, 2026 at 9:47=E2=80=AFAM Chengyang Zhu <colazcyg@gmail.com> =
wrote:
>
> Currently, the SetUIInfo method cannot set a refresh rate.
> Simply adding a refresh_rate argument would break the method signature.
>
> This patch adds the UIInfo interface containing
>   * property `Supported` indicating whether console UI info is supported.
>   * the method `Apply` taking a dictionary as input.
>   * the method `Get` returning the current UI info as a dictionary.
>
> Signed-off-by: Chengyang Zhu <colazcyg@gmail.com>
> ---
>  ui/dbus-console.c    | 106 +++++++++++++++++++++++++++++++++++++++++++
>  ui/dbus-display1.xml |  50 ++++++++++++++++++++
>  2 files changed, 156 insertions(+)
>
> diff --git a/ui/dbus-console.c b/ui/dbus-console.c
> index e1ac06814b..947c3b3a54 100644
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
> @@ -528,6 +531,98 @@ dbus_mouse_mode_change(Notifier *notify, void *data)
>      dbus_mouse_update_is_absolute(ddc);
>  }
>
> +static gboolean
> +dbus_ui_info_get(DBusDisplayConsole *ddc,
> +                 GDBusMethodInvocation *invocation)
> +{
> +    QemuUIInfo ui_info;
> +    GVariantDict dict;
> +
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
> +    ui_info =3D *qemu_console_get_ui_info(ddc->dcl.con);
> +    g_variant_dict_init(&dict, NULL);
> +
> +    g_variant_dict_insert(&dict, "width_mm", "q", ui_info.width_mm);
> +    g_variant_dict_insert(&dict, "height_mm", "q", ui_info.height_mm);
> +    g_variant_dict_insert(&dict, "xoff", "i", ui_info.xoff);
> +    g_variant_dict_insert(&dict, "yoff", "i", ui_info.yoff);
> +    g_variant_dict_insert(&dict, "width", "u", ui_info.width);
> +    g_variant_dict_insert(&dict, "height", "u", ui_info.height);
> +    g_variant_dict_insert(&dict, "refresh_rate", "u", ui_info.refresh_ra=
te);
> +
> +    qemu_dbus_display1_uiinfo_complete_get(ddc->iface_ui_info, invocatio=
n,
> +                                           g_variant_dict_end(&dict));
> +
> +    return DBUS_METHOD_INVOCATION_HANDLED;
> +}
> +
> +static bool
> +dbus_ui_info_apply_lookup(GDBusMethodInvocation *invocation,
> +                          GVariantDict *dict,
> +                          const gchar *key,
> +                          const gchar *fmt_str,
> +                          void *res)
> +{
> +    if (g_variant_dict_contains(dict, key) &&
> +        !g_variant_dict_lookup(dict, key, fmt_str, res)) {
> +        g_dbus_method_invocation_return_error(invocation,
> +                                              DBUS_DISPLAY_ERROR,
> +                                              DBUS_DISPLAY_ERROR_INVALID=
,
> +                                              "%s must have D-Bus signat=
ure %s",
> +                                              key, fmt_str);
> +        return false;
> +    }
> +    return true;

A bit surprising that the function returns true for unknown/invalid keys, b=
ut ok

> +}
> +
> +static gboolean
> +dbus_ui_info_apply(DBusDisplayConsole *ddc,
> +                   GDBusMethodInvocation *invocation,
> +                   GVariant *arg_ui_info)
> +{
> +    QemuUIInfo ui_info;
> +    g_auto(GVariantDict) dict =3D G_VARIANT_DICT_INIT(arg_ui_info);
> +
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
> +    ui_info =3D *qemu_console_get_ui_info(ddc->dcl.con);
> +
> +    if (!dbus_ui_info_apply_lookup(invocation, &dict, "width_mm", "q",
> +                                   &ui_info.width_mm) ||
> +        !dbus_ui_info_apply_lookup(invocation, &dict, "height_mm", "q",
> +                                   &ui_info.height_mm) ||
> +        !dbus_ui_info_apply_lookup(invocation, &dict, "xoff", "i",
> +                                   &ui_info.xoff) ||
> +        !dbus_ui_info_apply_lookup(invocation, &dict, "yoff", "i",
> +                                   &ui_info.yoff) ||
> +        !dbus_ui_info_apply_lookup(invocation, &dict, "width", "u",
> +                                   &ui_info.width) ||
> +        !dbus_ui_info_apply_lookup(invocation, &dict, "height", "u",
> +                                   &ui_info.height) ||
> +        !dbus_ui_info_apply_lookup(invocation, &dict, "refresh_rate", "u=
",
> +                                   &ui_info.refresh_rate)) {
> +        return DBUS_METHOD_INVOCATION_HANDLED;
> +    }
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
> @@ -550,6 +645,7 @@ dbus_display_console_new(DBusDisplay *display, QemuCo=
nsole *con)
>          "org.qemu.Display1.Keyboard",
>          "org.qemu.Display1.Mouse",
>          "org.qemu.Display1.MultiTouch",
> +        "org.qemu.Display1.UIInfo",
>          NULL
>      };
>
> @@ -626,5 +722,15 @@ dbus_display_console_new(DBusDisplay *display, QemuC=
onsole *con)
>      qemu_add_mouse_mode_change_notifier(&ddc->mouse_mode_notifier);
>      dbus_mouse_update_is_absolute(ddc);
>
> +    ddc->iface_ui_info =3D qemu_dbus_display1_uiinfo_skeleton_new();
> +    qemu_dbus_display1_uiinfo_set_supported(ddc->iface_ui_info,
> +        qemu_console_ui_info_supported(ddc->dcl.con));
> +    g_object_connect(ddc->iface_ui_info,
> +        "swapped-signal::handle-get", dbus_ui_info_get, ddc,
> +        "swapped-signal::handle-apply", dbus_ui_info_apply, ddc,
> +        NULL);
> +    g_dbus_object_skeleton_add_interface(G_DBUS_OBJECT_SKELETON(ddc),
> +        G_DBUS_INTERFACE_SKELETON(ddc->iface_ui_info));
> +
>      return ddc;
>  }
> diff --git a/ui/dbus-display1.xml b/ui/dbus-display1.xml
> index d96bae2ed6..26483edc37 100644
> --- a/ui/dbus-display1.xml
> +++ b/ui/dbus-display1.xml
> @@ -1159,4 +1159,54 @@
>      -->
>      <property name=3D"Encoding" type=3D"s" access=3D"read"/>
>    </interface>
> +
> +  <!--
> +      org.qemu.Display1.UIInfo:
> +
> +      This interface is implemented on
> +      ``/org/qemu/Display1/Console_$id`` (see
> +      :dbus:iface:`~org.qemu.Display1.Console`).
> +  -->
> +  <interface name=3D"org.qemu.Display1.UIInfo">
> +    <!--
> +        Supported:
> +
> +        Whether console UI info is supported.
> +    -->
> +    <property name=3D"Supported" type=3D"b" access=3D"read"/>
> +
> +    <!--
> +        Get:
> +        @ui_info: a dictionary of current UI info properties.
> +
> +        Return the properties of the current console display.
> +
> +        - ``width_mm`` (q): the physical display width in millimeters.
> +        - ``height_mm`` (q): the physical display height in millimeters.
> +        - ``xoff`` (i): the horizontal offset in pixels.
> +        - ``yoff`` (i): the vertical offset in pixels.
> +        - ``width`` (u): the console width in pixels.
> +        - ``height`` (u): the console height in pixels.
> +        - ``refresh_rate`` (u): the display refresh rate in millihertz.
> +    -->
> +    <method name=3D"Get">
> +      <arg name=3D"ui_info" type=3D"a{sv}" direction=3D"out"/>
> +    </method>
> +
> +    <!--
> +        Apply:
> +        @ui_info: a dictionary of new UI info properties.
> +
> +        Apply the properties to the console display.
> +        The dictionary schema of ``Apply`` is a subset of that of ``Get`=
`.
> +
> +        The properties will be merged with existing values.
> +        Extra keys will be ignored.
> +        The invocation will fail if any key has the wrong type,
> +        leaving the UI info unchanged.
> +    -->
> +    <method name=3D"Apply">
> +      <arg name=3D"ui_info" type=3D"a{sv}" direction=3D"in"/>
> +    </method>
> +  </interface>
>  </node>
> --
> 2.55.0
>
>

lgtm, I can pick this patch unless you want to send a non-rfc version befor=
e


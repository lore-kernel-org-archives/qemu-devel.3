Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E32C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 15:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwLK6-0002v6-KM; Tue, 18 Aug 2026 11:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wwLK5-0002ue-7V
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 11:01:53 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wwLK2-0002BJ-Rx
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 11:01:52 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7e9ecd7216cso2523964a34.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 08:01:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787065309; cv=none;
 d=google.com; s=arc-20260327;
 b=iJJKQjkcFc7+XtJhDink0HAwoUP0lEBm3HqUFJngD3r4y+bAymLLiIgvA+2WiEt1x9
 J9EI/2Imemu9ScmjGJXxVwQSiGB0M0MISVTrU0xi1+zYW7k//PohcQ5ypotiN/ppYpDB
 LLme1s0FS9RY9kVUShWJ+4uyv0ieGsAJMZRelYBuB++/fDzJEeL/qmqM9PRKUenIVQ3r
 /PAYpimCnHlPPN+NEiwDhgFW6weQ4N5BkQSVBrskC4gtdI00MLPKfQx3Zh/cZR8Qozaa
 bZQB8ortV3957u3YMvEo4pY1/k/6yg7tvHNbliESTd5kwDFHovrorTVsJxW/3JpMvoi4
 eF2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=u0iFyLg/f2qfEW1OZuhgpWgS+LX/MQF3ouvkcHht7fI=;
 fh=UwLFTHUG6OUSVMCnHpQ6jSrjhEzE/9mRt62giHtuJfw=;
 b=dBmY3H/KbUM9rgnccmYX+6oBtcpa80wZHNNp85AfVKu0wTp/0cYJewKAZB5TpjpRG8
 cb+sALSKrDHDsddG4XYgBUIjkPIf5o/i2I+BzJ2nQwlTtLD62Bt1Z/R4hY7VgZ512LY4
 JmbZQy8lBaDlbuwkIbD6HZPo8gUK/oBHxYr3/a69VGRmo/xvzOhS7PuW770n6ObukAyS
 Mfb/kuMNAehgorhdORG9XVXZkMg8mG1OEPgl/Pd3azNvZLsZxVllf65RyGGwfv0/Mvf1
 ED0lKyfd/tYNVjyoV+U5ADXu6V2VYbWM1iNlQUm8PiD0QeFQNGVKS8RZVTCOus0R24hL
 1jsg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787065309; x=1787670109; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=u0iFyLg/f2qfEW1OZuhgpWgS+LX/MQF3ouvkcHht7fI=;
 b=kk9unu1o4+A8TRkG//RyBBfZcBVeF5EWyUEPFhX7GgQyIyBvjNai14pqz8EgvLNlXK
 bdhWIpNyJbm2Nw1HqtWIdm9aMVKKalwquFo5jgFFR31WQ6cCxNAooh9NpWUFL0rVIetA
 WTdpd3PpI50CkLGhnb/S4Izwo8Qnzf+cBFrHAYISWpNVXR4JDMJ9sGj+4Tm5p2PFote5
 1ACu/HZALp4uwoliN1lM4errsvX91igfw28cARchfIgrsD9j0QUxNUo4bukdmyUsMfrn
 I84jZpRzxyRh/hwW6h9cyzXmfdor1eVrOU6+FTHfjOzBybV5cJWsV8+ro6x0WGYaJhK+
 fvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787065309; x=1787670109;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u0iFyLg/f2qfEW1OZuhgpWgS+LX/MQF3ouvkcHht7fI=;
 b=YugIW6TwpnglMDF2dMSbMw2+eVotZzREM+/A/t2LubRiNkJU9gjTtGRM2+NOry8u3v
 Wo5O/BrfTMvcyOmgHy6rmeyB5HNWEc5KYPFMDfMqIvC0Mo8IvL+cWOT/EPazN1JwCb5x
 HKR2E/kJOgiv67lbKlJ+SBMKZFxxW9LfgRhAJOjZI+00zXDPqw0YKR1O+XQGc6FfEVn0
 bMyo6nHmeoAePJZd3Cnq2PqmuzyD763dKppvEPN1LZclfkCSO5WNorDfIaocFyt9ypWt
 K1/P4xA7WTTNs559ae2PEgLg7LixM3ftBN/6LBkP6Wcok8cIWzmLECy93vVlgcipzBFe
 sHPg==
X-Gm-Message-State: AOJu0YzDYmgRq4WO9JzBMY8Ng7G6Ufwgnq9b3BNqExv5Pcy3z7pHBugE
 hZ7RR3/ct06R77X8J7HDhYx2/maIn7/aXFiYI8dtUD6s4DBw5BJduyZTv8V6ySgwUlP7p0xQ2tR
 msAlNTPs8HBhr+1jFJDV5LfamU5Lnwvw=
X-Gm-Gg: AR+sD11fsEnF8SK6WJEmHBZ6RsXHrdkaUsEEuUH0CeXFyNfcpfgSFQsOKq4Z9CMvSX0
 eWFzgCrb/jS3kxC3DCm9er2FGe0ACXoEX3LsrWgParZlNeExIW4u4tfggW+mWKkeBv+bUKxR4le
 6hJKeSeYSkCfYokrqGPIb8jZZky1Iv6EuaAWVLpJOoXNx6GUV1Ux/xYqbNErQswuDPMyCGfv952
 CDj3Li8NS9ldBB90tARSreBfj31CKWS7PZtJAS+g+14qrFkcL/2YEIUvjeSc0lswVrgq1WI5wxO
 uH2zLR9GhbkRMu6REqkxI142aGewZUpfathG4Jw4PeSrMrxAO2oFt83fGTHk2TxRpY8p2osF9uK
 w
X-Received: by 2002:a05:6820:188c:b0:6b0:ab1f:ec11 with SMTP id
 006d021491bc7-6b0d690ae32mr28831069eaf.29.1787065309218; Tue, 18 Aug 2026
 08:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260818134543.654949-1-colazcyg@gmail.com>
 <20260818134543.654949-2-colazcyg@gmail.com>
In-Reply-To: <20260818134543.654949-2-colazcyg@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 19:01:34 +0400
X-Gm-Features: AcwNN1WwiBvGq7ARjOqMePtEukesx7UUciE6dd43c4LyayhORgxsxAkxdNbNodw
Message-ID: <CAJ+F1C+-EhCgeM2cK9QfZrN9c9OezuRO4E7NGmHiTFN=cHQLKA@mail.gmail.com>
Subject: Re: [PATCH RFC v3 1/1] ui/dbus: add org.qemu.Display1.UIInfo interface
To: Chengyang Zhu <colazcyg@gmail.com>, christian@sourceandstack.com
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ot1-x32a.google.com
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

On Tue, Aug 18, 2026 at 5:48=E2=80=AFPM Chengyang Zhu <colazcyg@gmail.com> =
wrote:
>
> Currently, the SetUIInfo method cannot set a refresh rate.
> Simply adding a refresh_rate argument would break the method signature.
>
> This patch adds the UIInfo interface containing
>   * properties as staged display settings.
>   * property `Supported` indicating whether console UI info is supported.
>   * the method `Apply` applying staged settings.
>   * the method `Reload` reloading settings from the console.
>
> Signed-off-by: Chengyang Zhu <colazcyg@gmail.com>

That looks good to me. I am aware of concerns about refresh_rate unit
(https://gitlab.gnome.org/GNOME/libmks/-/merge_requests/53#note_2834466),
but I guess we will address this in due course

Christian, does this new interface look right to you?

thanks

> ---
>  ui/dbus-console.c    | 71 ++++++++++++++++++++++++++++++++++++++
>  ui/dbus-display1.xml | 81 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 152 insertions(+)
>
> diff --git a/ui/dbus-console.c b/ui/dbus-console.c
> index e1ac06814b..2c71272a1c 100644
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
> @@ -528,6 +531,63 @@ dbus_mouse_mode_change(Notifier *notify, void *data)
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
> +    qemu_dbus_display1_uiinfo_set_width_mm(ddc->iface_ui_info,
> +                                           ui_info.width_mm);
> +    qemu_dbus_display1_uiinfo_set_height_mm(ddc->iface_ui_info,
> +                                            ui_info.height_mm);
> +    qemu_dbus_display1_uiinfo_set_xoff(ddc->iface_ui_info, ui_info.xoff)=
;
> +    qemu_dbus_display1_uiinfo_set_yoff(ddc->iface_ui_info, ui_info.yoff)=
;
> +    qemu_dbus_display1_uiinfo_set_width(ddc->iface_ui_info, ui_info.widt=
h);
> +    qemu_dbus_display1_uiinfo_set_height(ddc->iface_ui_info, ui_info.hei=
ght);
> +    qemu_dbus_display1_uiinfo_set_refresh_rate(ddc->iface_ui_info,
> +                                               ui_info.refresh_rate);
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
> +
> +    QemuUIInfo ui_info =3D {
> +        .width_mm =3D qemu_dbus_display1_uiinfo_get_width_mm(ddc->iface_=
ui_info),
> +        .height_mm =3D qemu_dbus_display1_uiinfo_get_height_mm(ddc->ifac=
e_ui_info),
> +        .xoff =3D qemu_dbus_display1_uiinfo_get_xoff(ddc->iface_ui_info)=
,
> +        .yoff =3D qemu_dbus_display1_uiinfo_get_yoff(ddc->iface_ui_info)=
,
> +        .width =3D qemu_dbus_display1_uiinfo_get_width(ddc->iface_ui_inf=
o),
> +        .height =3D qemu_dbus_display1_uiinfo_get_height(ddc->iface_ui_i=
nfo),
> +        .refresh_rate =3D qemu_dbus_display1_uiinfo_get_refresh_rate(ddc=
->iface_ui_info)
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
> @@ -550,6 +610,7 @@ dbus_display_console_new(DBusDisplay *display, QemuCo=
nsole *con)
>          "org.qemu.Display1.Keyboard",
>          "org.qemu.Display1.Mouse",
>          "org.qemu.Display1.MultiTouch",
> +        "org.qemu.Display1.UIInfo",
>          NULL
>      };
>
> @@ -626,5 +687,15 @@ dbus_display_console_new(DBusDisplay *display, QemuC=
onsole *con)
>      qemu_add_mouse_mode_change_notifier(&ddc->mouse_mode_notifier);
>      dbus_mouse_update_is_absolute(ddc);
>
> +    ddc->iface_ui_info =3D qemu_dbus_display1_uiinfo_skeleton_new();
> +    qemu_dbus_display1_uiinfo_set_supported(ddc->iface_ui_info,
> +        qemu_console_ui_info_supported(ddc->dcl.con));
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
> index d96bae2ed6..2a8a8563ee 100644
> --- a/ui/dbus-display1.xml
> +++ b/ui/dbus-display1.xml
> @@ -1159,4 +1159,85 @@
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
> +        WidthMm:
> +
> +        The physical display width in millimeters.
> +    -->
> +    <property name=3D"WidthMm" type=3D"q" access=3D"readwrite"/>
> +
> +    <!--
> +        HeightMm:
> +
> +        The physical display height in millimeters.
> +    -->
> +    <property name=3D"HeightMm" type=3D"q" access=3D"readwrite"/>
> +
> +    <!--
> +        XOff:
> +
> +        The horizontal offset in pixels.
> +    -->
> +    <property name=3D"XOff" type=3D"i" access=3D"readwrite"/>
> +
> +    <!--
> +        YOff:
> +
> +        The vertical offset in pixels.
> +    -->
> +    <property name=3D"YOff" type=3D"i" access=3D"readwrite"/>
> +
> +    <!--
> +        Width:
> +
> +        The console width in pixels.
> +    -->
> +    <property name=3D"Width" type=3D"u" access=3D"readwrite"/>
> +
> +    <!--
> +        Height:
> +
> +        The console height in pixels.
> +    -->
> +    <property name=3D"Height" type=3D"u" access=3D"readwrite"/>
> +
> +    <!--
> +        RefreshRate:
> +
> +        The display refresh rate in millihertz.
> +    -->
> +    <property name=3D"RefreshRate" type=3D"u" access=3D"readwrite"/>
> +
> +    <!--
> +        Reload:
> +
> +        Set the staged properties to the state of the console display.
> +    -->
> +    <method name=3D"Reload">
> +    </method>
> +
> +    <!--
> +        Apply:
> +
> +        Apply the staged properties to the console display.
> +    -->
> +    <method name=3D"Apply">
> +    </method>
> +  </interface>
>  </node>
> --
> 2.55.0
>
>


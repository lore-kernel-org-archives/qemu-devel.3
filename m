Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70383C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 12:50:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyU7c-0004zM-1h; Mon, 24 Aug 2026 08:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wyU7a-0004z1-2e
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 08:49:50 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wyU7Y-00043x-5n
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 08:49:49 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-84830c774a0so3801791b3a.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 05:49:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787575787; cv=none;
 d=google.com; s=arc-20260327;
 b=GubkkZv8vz87Lo2BsiiZp/DanHzgD5GMUKaHgHcViwGoLaTklMFQD0ozMbd3AZLBCv
 j7pIenymU/tlGPlP85Z+GbNEoAOl1MPHmFNoJa71htoS3W+rKnSft+af3aEXkYmK4lcE
 k3px356xwFs4axSpHLD5iGhQ6qpw+HGsfLG/jxdDGLxWV4PkktmAHO0vujOPmT+YeJ3B
 MwYc7RFn4g0vzTqNbcICCFfTC0cqfKLT1Iyw/drUz7rVn3iO2464EuDLfeth+LQTDxr3
 bupQzfUJmcmmeOOM/yosnlC/Cg9GLoq0vVSFRwjiAq649Eawvf5n44M1VtmU8nNvtZ4g
 Z+LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uuCFvVO59hNBXjUOxVf/JWQCtMf1ijmbBv8e8/SQQTk=;
 fh=wNIBB09whFX4aqH2z8BcDR9CesbTcDsK1XevePNeRLw=;
 b=PTYR22Lzm1dL4gpR0tl/ku9oFORqpGacqUoDuAnD+8nMcpxqa9uEXnTexc3TOefJHe
 2yqDbA6ZfcE999x8P9NC51HvwGi0poGuZ0zsnXocS+g066vSxjDiragp9bt7EP6QpzEL
 3yP+1KryAw7x+ZIK1tJmhaP4/dKfGDX2+V5GlNIhgsUKbxLE7DG/RYEgUP5jdddnVXX2
 tZVYn0D4LmiAFPr6oJRwYwtBcgWWPSJZ6j0r2VpauuWFiJ8Hutdd9suITsJUsKb8TXz8
 HyI8Wl4xIGgUxY3MXQm0xc4IQiGhBRmLMGD5E+9LQzajHlK1NflNyZAv6+hbUsv/KRCb
 InHQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787575787; x=1788180587; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uuCFvVO59hNBXjUOxVf/JWQCtMf1ijmbBv8e8/SQQTk=;
 b=JqS3XSleVJbNxqo017LCloPvy2PbRfGmIQ448OeVWm9XjHEdGrdL8AWt/k6P3uC3BX
 YqjIzIqwepc4zdb6OB44QlnkiVHjws1HRshTkON5ucESoAmScgQwan/WLOU/kZ6Sz1W8
 hoLZzgOxE6u5PKWazWAloSP+gtwv2S6U5uFfIyQgN83+8VAKC0JiIlzMb30qofwBNsdT
 gSSjz4nj67sLFR73dwrCtpQ7B/Ry03sK3C/m6uP1+jkxr9RXLuccF0EFpJvqg3BD3lO3
 Pnwm9gojezF68udQCgORVZAp2V2/Lrrzav6G3nrgpmStlM/BtC07OugueM163eYLIGSI
 6LNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787575787; x=1788180587;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uuCFvVO59hNBXjUOxVf/JWQCtMf1ijmbBv8e8/SQQTk=;
 b=pIdQYymEy4PcINUKVLaqNUbM8NXzWHOaYGbc2LMqUAd3aYWaSepnOTkPYyTSGHZ6ip
 X0UcvggeyIT2q8ELHPlsIAp1WoU4+OgfBA8P4u0bVbfdMhEobp9UnknWt1MWeBSmodX6
 nxJ5uc/CVHpXwtvSU06A0bPl9X0D3pwYjkrDWj+L1ykcTir2O2mUSCJ7rZubDL2wP62v
 rYjLKrTKi+7lSqGMjAOTEofJBR2RiL963pRY7k/q79XNzLLaig6rXp2ySS45caJK3Kcy
 cDqrd6GkNJxOEvPLnGYSNr3xkS2B4Rd/SBCB1yhTXy3kEPXBP/TosJx7wWXcdms4WO4V
 aZtg==
X-Gm-Message-State: AFuF++mJ31bi/hT9XeDC5P7e+9s2SX2E2pkvdJj28rwjdsmmgi/trsoG
 47p+RkksrlyTmItxsoODZgxvuzXneZRpSkRNt7WkIFgFiKfZYgSvImUX5Md9bSYczl4gwthK9ba
 MkVtD8mld5kPEFWteKeJoArljwGFgZXA=
X-Gm-Gg: AR+sD12Sc2NJ9d0PohI+Wmz4eMudbazxMKtNM+LQPRCnVF4kp162b4OSrWzm9vXwpGd
 uVhzV2OcT8WB01OvFFzXSzCV70/LeFtGSfmaTCHEv+xKBJgE1kXtS3efO1KdlKTN8k3LK9iJe6/
 X7xmO6co8T6uarlJ4eop9x/n8XXxWbRrwJCaRlOe0ZP3iCY3bDuHGeVw0eKavWugBHyQKJEntEQ
 Jv4lCa6rAaCV+3/c/w/M3d3PetU1Z/mt7AjkrtzKJJTRaatRNKx3I7cwdVO3v3TnEvNxc/f0Yu4
 VSmhtUDs+rCmAF5EZXG341/iDl4GO/c754OUA1HmZR2yVA==
X-Received: by 2002:a05:6a20:450c:b0:3bf:6d96:ac40 with SMTP id
 adf61e73a8af0-3cd3007ce9bmr50756547637.12.1787575786739; Mon, 24 Aug 2026
 05:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260818134543.654949-1-colazcyg@gmail.com>
 <20260818134543.654949-2-colazcyg@gmail.com>
In-Reply-To: <20260818134543.654949-2-colazcyg@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 24 Aug 2026 16:49:34 +0400
X-Gm-Features: AcwNN1UVQqWW0DxNHy5r61XlBeOJs3nL1SVsucsJaT10bySNwncQPtiSiTA6Ezk
Message-ID: <CAJ+F1CJA_rL2mCn5yjenvJtxKav7A1jXxwTdoQzNHPFinVsHXg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 1/1] ui/dbus: add org.qemu.Display1.UIInfo interface
To: Chengyang Zhu <colazcyg@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pf1-x431.google.com
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

Hi Chengyang Zhu

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

Sorry for the back and forth, based on discussion with Christian, we
should go back to a dictionary approach.

Let's keep the extra interface, keep "supported" property and add
Get() & Apply() with extensible dictionaries. Sounds good?

Apply() should merge with existing values, I suppose.

Later on, we may want to also have a Updated/Changed signal with the
new values..

thanks

>
> Signed-off-by: Chengyang Zhu <colazcyg@gmail.com>
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


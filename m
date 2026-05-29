Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA4DCD6E43
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 12:18:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSwAC-000240-FE; Fri, 29 May 2026 08:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wSwAA-00023W-Pm
 for qemu-devel@nongnu.org; Fri, 29 May 2026 08:18:06 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wSwA7-0006PG-Ji
 for qemu-devel@nongnu.org; Fri, 29 May 2026 08:18:06 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 64TCHflk027301
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 29 May 2026 21:17:41 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=5ESyO+DPwWsyMSkGK4BKdY2kpmZyxiw0Qet/iNBk+ro=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1780057061; v=1;
 b=rB+lFusAScBXS0R42HGDWPf7Sted6MF5Na1QT+VUNj7w/Bf+dI3dFA35NfRvoGmB
 aFvq/IZB3r5u847Pu1vaXMBF6gZcLAFJ0XDhkNFgUGYSrB+DdXe/YsG8rfoHWsJ0
 eRRcfAnswYoW/n/6fyQynADQkIW+7h6oJu+wSTd0p1Nm25Y3Trla4KLurEVXi5XK
 tx5tf3n6lrTFBCO0rrv1eV2XApJv96laWxUUrDak3UVlwPbkP/Y2vmVLnCbjjVg/
 BTh1U5Viuh2mJLnCdnBuWJ2qcoa9XkD2hqTFoXaKbtr9L9C969BYHb0I4nTBzYAh
 JbGM6Y+vC2hZGWjynfBLog==
Message-ID: <6f72533e-3ebb-4a16-b18f-e89b2cbf5385@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 29 May 2026 21:17:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/32] ui/dbus: implement display cleanup
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20260529-b4-ui-v1-0-8db3068421ef@redhat.com>
 <20260529-b4-ui-v1-19-8db3068421ef@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260529-b4-ui-v1-19-8db3068421ef@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
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

On 2026/05/29 20:16, Marc-André Lureau wrote:
> Add dbus_cleanup() to unparent the D-Bus display object, ensuring
> proper teardown before user_creatable_cleanup() runs.

"[PATCH 07/32] ui/dbus: remove mouse handler on dispose" removes the 
mouse handler, but the LED event handler still remains.

Regards,
Akihiko Odaki

> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/dbus-console.c |  3 +++
>   ui/dbus.c         | 13 +++++++++++++
>   2 files changed, 16 insertions(+)
> 
> diff --git a/ui/dbus-console.c b/ui/dbus-console.c
> index 0813a08f85e..0048951a7ab 100644
> --- a/ui/dbus-console.c
> +++ b/ui/dbus-console.c
> @@ -151,6 +151,9 @@ dbus_display_console_dispose(GObject *object)
>       DBusDisplayConsole *ddc = DBUS_DISPLAY_CONSOLE(object);
>   
>       qemu_console_unregister_listener(&ddc->dcl);
> +    if (ddc->dcl.con) {
> +        qemu_console_set_display_gl_ctx(ddc->dcl.con, NULL);
> +    }
>       qemu_remove_mouse_mode_change_notifier(&ddc->mouse_mode_notifier);
>       g_clear_object(&ddc->iface_touch);
>       g_clear_object(&ddc->iface_mouse);
> diff --git a/ui/dbus.c b/ui/dbus.c
> index e02a94df2f3..b23cb44c535 100644
> --- a/ui/dbus.c
> +++ b/ui/dbus.c
> @@ -615,10 +615,23 @@ static const TypeInfo dbus_display_info = {
>       }
>   };
>   
> +static void
> +dbus_cleanup(void)
> +{
> +    Object *o;
> +
> +    o = object_resolve_path_component(object_get_objects_root(),
> +                                      "dbus-display");
> +    if (o) {
> +        object_unparent(o);
> +    }
> +}
> +
>   static QemuDisplay qemu_display_dbus = {
>       .type       = DISPLAY_TYPE_DBUS,
>       .early_init = early_dbus_init,
>       .init       = dbus_init,
> +    .cleanup    = dbus_cleanup,
>       .vc         = "vc",
>   };
>   
> 



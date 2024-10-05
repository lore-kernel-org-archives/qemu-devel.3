Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFB6CF8877
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 08:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sx0Ot-0003Bf-DY; Sat, 05 Oct 2024 04:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sx0Oq-0003BM-Un
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 04:44:29 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sx0Oo-0000AF-Lo
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 04:44:28 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-71b00a97734so2694785b3a.1
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 01:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728117865; x=1728722665;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ysNTvCelpQWD9HZ2Nyr1pj9RbuuFmoLfG55ycJGGIRU=;
 b=LRSNcDRFPhi2NstXeOKQGSIGnBLv/RUubFl3MailS+sSeWFFTtqav0nSZiltJOOne4
 C5ec/bBRAHlg/qlVWy9ItW3y5aPKShL0pDVaLZSrBN+f3ja+AaAzj2xslyv8dTOf5TjB
 SRzAHp21NpNGcn2MJLmG4bgV9unbTI+na28mQz5qZqz/14z8MenonjR+vK3j4ysdMIbz
 M65ou+RcEhBGKk1wdpcrGaGEQk2cEfXdiT96xXx8IrFQxj8umEAsvG+S0NUGY1OHcOEW
 zW+nOxiM++O//qPcm1CbPEKUW+W6/d4/+MqBSvxCapnw2D91IWr7za/HfzDGZnUEHl73
 OQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728117865; x=1728722665;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ysNTvCelpQWD9HZ2Nyr1pj9RbuuFmoLfG55ycJGGIRU=;
 b=NEr1yP8DhjXAyxoIcy0Sx+m2TW69YjgXtuuya0JQKjegmfZWcYNm4/ahV6x24jfwlN
 QczJtuPsidjsPpncm97pLR8mjv9ETwXhzmK0nhPNG41lJU6MAa5EXU9SVfKZmJJ0g4FA
 pUhW1CxT8wZo51y4rYyBMdwEgzgwWI+UNGcQEfkgARXqoom0cxLX4zLTHRmsEiZd2CH/
 n/BkCnNJPHQT4kBJyPDf07NAmjfkb3+s6nxlicNw6dQtVrpb9/uDSn1GZgcU0bA0sXPu
 n6a55lK5sxjGN/GnYTlm40MHq8NzxZxRXQc0TBmhH5icYfOWVv78f+0EwsjwaQ0b0xJl
 Yo2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXY176mjhHrXXDfO4UhgeKQ2UK5/ov/UEcQvwsUM59shllqRnqhTsyVxETotzU1Nww95uE4o3zfnwg@nongnu.org
X-Gm-Message-State: AOJu0Yy51a7lR8Qu0OOVThiU8dl22RtdiIGXbHIw5oDYnPpWykKJoYG2
 j5PhpUjA4fJmIOyyUjL2JEryZYuqs+l50+lYPclvzb3YEYf7lhVgOyHknhje1UE=
X-Google-Smtp-Source: AGHT+IFHuqsUruxXJwcpr5HGBuyu1tZlL61aKZlUCZLMLV8PTkSI3HLLudtaSBRnmn7LBLlmouVAGg==
X-Received: by 2002:a05:6a21:1519:b0:1d2:ba7c:c6e7 with SMTP id
 adf61e73a8af0-1d6dfa5a199mr8046286637.30.1728117864889; 
 Sat, 05 Oct 2024 01:44:24 -0700 (PDT)
Received: from [157.82.202.230] ([157.82.202.230])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0ccd156sm1079919b3a.57.2024.10.05.01.44.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Oct 2024 01:44:24 -0700 (PDT)
Message-ID: <26319860-7118-4cc8-b1f5-cbdf4df69245@daynix.com>
Date: Sat, 5 Oct 2024 17:44:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/16] ui/dbus: fix filtering all update messages
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 belmouss@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20241003112244.3340697-1-marcandre.lureau@redhat.com>
 <20241003112244.3340697-6-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241003112244.3340697-6-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::434;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/10/03 20:22, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Filtering pending messages when a new scanout is given shouldn't discard
> pending cursor changes, for example.
> 
> Since filtering happens in a different thread, use atomic set/get.
> 
> Fixes: fa88b85dea ("ui/dbus: filter out pending messages when scanout")
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/dbus-listener.c | 44 ++++++++++++++++++++++++++++++++------------
>   1 file changed, 32 insertions(+), 12 deletions(-)
> 
> diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
> index 434bd608f2..a70cad3a90 100644
> --- a/ui/dbus-listener.c
> +++ b/ui/dbus-listener.c
> @@ -26,6 +26,7 @@
>   #include "qapi/error.h"
>   #include "sysemu/sysemu.h"
>   #include "dbus.h"
> +#include "glib.h"
>   #ifdef G_OS_UNIX
>   #include <gio/gunixfdlist.h>
>   #endif
> @@ -85,7 +86,7 @@ struct _DBusDisplayListener {
>   #endif
>   
>       guint dbus_filter;
> -    guint32 out_serial_to_discard;
> +    guint32 display_serial_to_discard;
>   };
>   
>   G_DEFINE_TYPE(DBusDisplayListener, dbus_display_listener, G_TYPE_OBJECT)
> @@ -93,10 +94,12 @@ G_DEFINE_TYPE(DBusDisplayListener, dbus_display_listener, G_TYPE_OBJECT)
>   static void dbus_gfx_update(DisplayChangeListener *dcl,
>                               int x, int y, int w, int h);
>   
> -static void ddl_discard_pending_messages(DBusDisplayListener *ddl)
> +static void ddl_discard_display_messages(DBusDisplayListener *ddl)
>   {
> -    ddl->out_serial_to_discard = g_dbus_connection_get_last_serial(
> +    guint32 serial = g_dbus_connection_get_last_serial(
>           g_dbus_proxy_get_connection(G_DBUS_PROXY(ddl->proxy)));
> +
> +    g_atomic_int_set(&ddl->display_serial_to_discard, serial);
>   }
>   
>   #ifdef CONFIG_OPENGL
> @@ -290,7 +293,7 @@ static void dbus_scanout_dmabuf(DisplayChangeListener *dcl,
>           return;
>       }
>   
> -    ddl_discard_pending_messages(ddl);
> +    ddl_discard_display_messages(ddl);
>   
>       width = qemu_dmabuf_get_width(dmabuf);
>       height = qemu_dmabuf_get_height(dmabuf);
> @@ -338,7 +341,7 @@ static bool dbus_scanout_map(DBusDisplayListener *ddl)
>           return false;
>       }
>   
> -    ddl_discard_pending_messages(ddl);
> +    ddl_discard_display_messages(ddl);
>   
>       if (!qemu_dbus_display1_listener_win32_map_call_scanout_map_sync(
>               ddl->map_proxy,
> @@ -401,7 +404,7 @@ dbus_scanout_share_d3d_texture(
>           return false;
>       }
>   
> -    ddl_discard_pending_messages(ddl);
> +    ddl_discard_display_messages(ddl);
>   
>       qemu_dbus_display1_listener_win32_d3d11_call_scanout_texture2d(
>           ddl->d3d11_proxy,
> @@ -659,7 +662,7 @@ static void ddl_scanout(DBusDisplayListener *ddl)
>           surface_stride(ddl->ds) * surface_height(ddl->ds), TRUE,
>           (GDestroyNotify)pixman_image_unref, pixman_image_ref(ddl->ds->image));
>   
> -    ddl_discard_pending_messages(ddl);
> +    ddl_discard_display_messages(ddl);
>   
>       qemu_dbus_display1_listener_call_scanout(
>           ddl->proxy, surface_width(ddl->ds), surface_height(ddl->ds),
> @@ -992,17 +995,34 @@ dbus_filter(GDBusConnection *connection,
>               gpointer         user_data)
>   {
>       DBusDisplayListener *ddl = DBUS_DISPLAY_LISTENER(user_data);
> -    guint32 serial;
> +    const gchar *member = NULL;

I suggest removing the initialization will NULL as it may suppress 
uninitialized variable warning.

> +    guint32 serial, discard_serial;
>   
>       if (incoming) {
>           return message;
>       }
>   
>       serial = g_dbus_message_get_serial(message);
> -    if (serial <= ddl->out_serial_to_discard) {
> -        trace_dbus_filter(serial, ddl->out_serial_to_discard);
> -        g_object_unref(message);
> -        return NULL;
> +
> +    discard_serial = g_atomic_int_get(&ddl->display_serial_to_discard);
> +    if (serial <= discard_serial) {
> +        member = g_dbus_message_get_member(message);
> +        if (g_strv_contains((const gchar *[]) {
> +                "Scanout",
> +                "Update",
> +#ifdef CONFIG_GBM
> +                "ScanoutDMABUF",
> +                "UpdateDMABUF",
> +#endif
> +                "ScanoutMap",
> +                "UpdateMap",
> +                "Disable",
> +                NULL,
> +            }, member)) {

I prefer to have a static variable for the array. It makes the object 
code simpler and also avoids to have a multi-line condition in the if 
statement.

> +            trace_dbus_filter(serial, discard_serial);
> +            g_object_unref(message);
> +            return NULL;
> +        }
>       }
>   
>       return message;



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F27CF8877
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 08:32:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sx0Cv-00010z-GU; Sat, 05 Oct 2024 04:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sx0Ct-0000ve-3K
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 04:32:07 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sx0Cq-0007bh-RW
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 04:32:06 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-20b4a0940e3so27222555ad.0
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 01:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728117123; x=1728721923;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PA2HR1jY+d2Hiw251EWnzTxEX72JY1FxAHhOf1ZNqUs=;
 b=KveLo1iTY1rIh29hz08quu8XDXN4l3VrsNSBBoo7Fa/V6VthV3miaMMmMXqAQMwVtZ
 lg072KsA5ZFVQRnKC/+4Tc7zk1niTs1EXJinukD94RRQBlfy8ZAuxm+GsXe7x/1mmy9X
 RsePwc/al/JpnYmvORFNMcNn2RvXGWI1VYrKyGzkKsg1SNVVfjs1GNyvzVOR/TB1dS55
 DVr60plBDcg/AcbOPU0SFdDMmtWXbIEfIq30K6dXhhS0qwlsggopAdL8j7vsWUlFAO/V
 qWa5uuJyVRnkfxIYIxM2NbMm411wTe35Xh+Q0LLnEdnG4scCa82i4icTw9bSu7kmZ+Mr
 tXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728117123; x=1728721923;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PA2HR1jY+d2Hiw251EWnzTxEX72JY1FxAHhOf1ZNqUs=;
 b=arQMNRakn1CQIkBTRSvMEW8RxGt+x9EYkQmwiTtorfdKEiT+RCNKmfz2rnACPCCJio
 ybxnqdcXLMf7ypxiI0CSSIgRo8s+hMorclAtnpiRrH5PA5kmlwNXQ/EmjG4zMqoP7Vt6
 4/izq5EZ2Gtc693rP6NjrEXimsqbciqdQqCr+QA7WEDv2phzK3X14s0uzuWsXOCtZe1i
 KJE3zRagh77lxp+3itpJH1+J0lAkgn2j88ADIIIzTzbUIE/O2bgxIFkznOz07S9ak9yC
 LLdm0mcsqwJR5uRMaZm0zzv3DB/jhDwIOQClAM0GGxB8WUxyFYLn7hjVrvtRNVBdwgEx
 H6tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhCrElCsyM1AJbm6LtsSZq0eyVRFjT8ltYfDUa8a1AwxFQoKbHMlCTSiI+ohu19rDdXsW5i/RLEaDu@nongnu.org
X-Gm-Message-State: AOJu0Yz5aw+dHYIGGrI17/Kua+3nUA0vePmng4BO0+Tx3eoxS8wDS6tD
 +ApFbI9+xuMCKJAoU9+zW/tl2BOY0T9emgmYrNoraGszIRo9emhdYqh8lNA31gA=
X-Google-Smtp-Source: AGHT+IHPO7kGVokiIoDSEco2abuf/EUQCAYqvdu7O7Y7agIkREdvMlD8E6ne+OZGKFPcVBQnqYvYjA==
X-Received: by 2002:a17:902:ea0a:b0:20b:8bd0:7395 with SMTP id
 d9443c01a7336-20bff037061mr92381415ad.46.1728117123102; 
 Sat, 05 Oct 2024 01:32:03 -0700 (PDT)
Received: from [157.82.202.230] ([157.82.202.230])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c138c9934sm9371855ad.63.2024.10.05.01.32.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Oct 2024 01:32:02 -0700 (PDT)
Message-ID: <f0c03b18-387f-450c-b1c5-33cf51b83445@daynix.com>
Date: Sat, 5 Oct 2024 17:31:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/16] tests: add basic -display dbus Map.Unix test
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 belmouss@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20241003112244.3340697-1-marcandre.lureau@redhat.com>
 <20241003112244.3340697-17-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241003112244.3340697-17-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
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
> Only check we eventually get a shared memory scanout.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   tests/qtest/dbus-display-test.c | 64 ++++++++++++++++++++++++++++++---
>   1 file changed, 59 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/qtest/dbus-display-test.c b/tests/qtest/dbus-display-test.c
> index 0390bdcb41..ac92cb00d4 100644
> --- a/tests/qtest/dbus-display-test.c
> +++ b/tests/qtest/dbus-display-test.c
> @@ -2,9 +2,12 @@
>   #include "qemu/sockets.h"
>   #include "qemu/dbus.h"
>   #include "qemu/sockets.h"
> +#include "glib.h"
> +#include "glibconfig.h"
>   #include <gio/gio.h>
>   #include <gio/gunixfdlist.h>
>   #include "libqtest.h"
> +#include <sys/mman.h>
>   #include "ui/dbus-display1.h"
>   
>   static GDBusConnection*
> @@ -82,6 +85,7 @@ typedef struct TestDBusConsoleRegister {
>       GThread *thread;
>       GDBusConnection *listener_conn;
>       GDBusObjectManagerServer *server;
> +    bool with_map;
>   } TestDBusConsoleRegister;
>   
>   static gboolean listener_handle_scanout(
> @@ -94,13 +98,48 @@ static gboolean listener_handle_scanout(
>       GVariant *arg_data,
>       TestDBusConsoleRegister *test)
>   {
> +    if (!test->with_map) {
> +        g_main_loop_quit(test->loop);
> +    }
> +
> +    return DBUS_METHOD_INVOCATION_HANDLED;
> +}
> +
> +static gboolean listener_handle_scanout_map(
> +    QemuDBusDisplay1ListenerUnixMap *object,
> +    GDBusMethodInvocation *invocation,
> +    GUnixFDList *fd_list,
> +    GVariant *arg_handle,
> +    guint arg_offset,
> +    guint arg_width,
> +    guint arg_height,
> +    guint arg_stride,
> +    guint arg_pixman_format,
> +    TestDBusConsoleRegister *test)
> +{
> +    int fd = -1;
> +    gint32 handle = g_variant_get_handle(arg_handle);
> +    g_autoptr(GError) error = NULL;
> +    void *addr = NULL;
> +    size_t len = arg_height * arg_stride;
> +
> +    g_assert_cmpuint(g_unix_fd_list_get_length(fd_list), ==, 1);
> +    fd = g_unix_fd_list_get(fd_list, handle, &error);
> +    g_assert_no_error(error);
> +
> +    addr = mmap(NULL, len, PROT_READ, MAP_PRIVATE, fd, arg_offset);
> +    g_assert_no_errno(GPOINTER_TO_INT(addr));

Strictly speaking, this construct is not safe. When void * is 64-bit and 
int is 32-bit, this assetion will fail if the lower 32 bits of addr are 
in [0x80000000, 0xffffffff] though addr may still be a valid address. 
This is because GPOINTER_TO_INT() results in a negative value for such 
an address, and g_assert_no_errno() asserts that the given value is 
non-negative.

Using g_mapped_file_new_from_fd() and will simplify this function as whole.

> +    g_assert_nonnull(addr);
> +    g_assert_no_errno(munmap(addr, len));
> +
>       g_main_loop_quit(test->loop);
>   
> +    close(fd);
>       return DBUS_METHOD_INVOCATION_HANDLED;
>   }
>   
>   static void
> -test_dbus_console_setup_listener(TestDBusConsoleRegister *test)
> +test_dbus_console_setup_listener(TestDBusConsoleRegister *test, bool with_map)
>   {
>       g_autoptr(GDBusObjectSkeleton) listener = NULL;
>       g_autoptr(QemuDBusDisplay1ListenerSkeleton) iface = NULL;
> @@ -114,6 +153,20 @@ test_dbus_console_setup_listener(TestDBusConsoleRegister *test)
>                        NULL);
>       g_dbus_object_skeleton_add_interface(listener,
>                                            G_DBUS_INTERFACE_SKELETON(iface));
> +    if (with_map) {
> +        g_autoptr(QemuDBusDisplay1ListenerUnixMapSkeleton) iface_map =
> +            QEMU_DBUS_DISPLAY1_LISTENER_UNIX_MAP_SKELETON(
> +                qemu_dbus_display1_listener_unix_map_skeleton_new());
> +
> +        g_object_connect(iface_map,
> +                         "signal::handle-scanout-map", listener_handle_scanout_map, test,
> +                         NULL);
> +        g_dbus_object_skeleton_add_interface(listener,
> +                                             G_DBUS_INTERFACE_SKELETON(iface_map));
> +        g_object_set(iface, "interfaces",
> +            (const gchar *[]) { "org.qemu.Display1.Listener.Unix.Map", NULL },
> +            NULL);
> +    }
>       g_dbus_object_manager_server_export(test->server, listener);
>       g_dbus_object_manager_server_set_connection(test->server,
>                                                   test->listener_conn);
> @@ -145,7 +198,7 @@ test_dbus_console_registered(GObject *source_object,
>       g_assert_no_error(err);
>   
>       test->listener_conn = g_thread_join(test->thread);
> -    test_dbus_console_setup_listener(test);
> +    test_dbus_console_setup_listener(test, test->with_map);
>   }
>   
>   static gpointer
> @@ -155,7 +208,7 @@ test_dbus_p2p_server_setup_thread(gpointer data)
>   }
>   
>   static void
> -test_dbus_display_console(void)
> +test_dbus_display_console(const void* data)
>   {
>       g_autoptr(GError) err = NULL;
>       g_autoptr(GDBusConnection) conn = NULL;
> @@ -163,7 +216,7 @@ test_dbus_display_console(void)
>       g_autoptr(GMainLoop) loop = NULL;
>       QTestState *qts = NULL;
>       int pair[2];
> -    TestDBusConsoleRegister test = { 0, };
> +    TestDBusConsoleRegister test = { 0, .with_map = GPOINTER_TO_INT(data) };
>   #ifdef WIN32
>       WSAPROTOCOL_INFOW info;
>       g_autoptr(GVariant) listener = NULL;
> @@ -299,7 +352,8 @@ main(int argc, char **argv)
>       g_test_init(&argc, &argv, NULL);
>   
>       qtest_add_func("/dbus-display/vm", test_dbus_display_vm);
> -    qtest_add_func("/dbus-display/console", test_dbus_display_console);
> +    qtest_add_data_func("/dbus-display/console", GINT_TO_POINTER(false), test_dbus_display_console);
> +    qtest_add_data_func("/dbus-display/console/map", GINT_TO_POINTER(true), test_dbus_display_console);
>       qtest_add_func("/dbus-display/keyboard", test_dbus_display_keyboard);
>   
>       return g_test_run();



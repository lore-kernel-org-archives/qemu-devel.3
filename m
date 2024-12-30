Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2875E77188
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 21:01:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSMri-0006Af-Ds; Mon, 30 Dec 2024 15:59:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSMrf-00069b-6F
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 15:59:52 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSMrd-0002s8-4D
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 15:59:50 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43675b1155bso80522195e9.2
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 12:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735592386; x=1736197186; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hMI7yEv1jSQhAu/0mSmlk2CoBBAXGicDSufwS04UZO4=;
 b=APCF8EPC1DBp6L5Iwic0rvM19C7M0lgZamzq1YChg/zpREHdSmrdgC1OdqCQe9wpV7
 T/w1GEhEVahnvB/tAFgAbdK+yy/Oe/uIQtTXOtl2o2iHSehcTyIDh1+fgNUOnl9TOUQk
 Z+3OZs+PZdjmZpoboCmtOYAiZNqyNdsbGTh4o3iA6gddue4j0CG1aC9RsnZ+6FPfcmz9
 nPyrO/9KEyL8AatPTbIASVIFRaCV9n8SKgKrpii/ITmnIr0x7OBppgXiIgQ8qfntDw6w
 ZYhkIOsVqocmdX3jJ5Uwzsu9159yEqotCB2rt/EavHMEZhSn296t2e7qXBZhN7VFHps/
 Tueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735592386; x=1736197186;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hMI7yEv1jSQhAu/0mSmlk2CoBBAXGicDSufwS04UZO4=;
 b=No9NbeKCyWswqDLlPWVQf/WEL1Ua62zVBg4LTNZCx+dAH779VnNm2L+bb6aEMww0Pq
 H79ElUJOCxsezpE0IzT/YGwcS1HLtWUFXG3syqt9riFxnC2GLvTs4WXzDNQgS+3Wmldh
 3lnmS45dIqlHn5kjF8UjLC7ywr7L81LiLwO+PGGN78Tc1HolfB6aMLM+NiFhcFG7iuZN
 d3bb/inDyCjsKF78/lmFVqJrVlwnQvqoqW1ZqVKZ05xji/ExIU2zbiiUY72GH/rnp5lP
 +q/DHKtR1kvbKk6PLs6vAcnwU3pHHy9BXgVZ9y46fnw85RQQZagC5DBJxrQwABHdkNXw
 RZyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBneWczg4AVTLtDMd2Q2zncwbs5BjwN4PM1078AsOJXLlI1q/H0NBIVfBf2Zg7bI3WSpPNc6tHLXe/@nongnu.org
X-Gm-Message-State: AOJu0YzLjJuzAsoPLU4arr1VfWFnASLZxTCP9AfuyO0LNET8pIrT/N55
 RMnKu4phOIIBVhov0qebwiugscPTAQ5U8GHRJQLWgW+Rw2ezpNaRlUzB9F+CD4c=
X-Gm-Gg: ASbGncut47nHXWmuptk1z3ccBJdRrkufkWkNX0YRL6EaFpRcivO82sY84sJA6EM7Zpu
 1o89yk/qBe1SxKDdpB8kiuppvI0OmUxMXl/pZFzfHndZBeSs+JOcASRC+Vk6t2dXwCas2N0ymeX
 oykgHrJVPs5e4x2t8Qj6SGqTMd6xYb+yKVffFUUvdBqUjp09UBUlOeKlL0WpRZouIrqBnzc6B3+
 yjOJpr43wFh3RxWGHcMmvWiGqJicqThDCStnmNNC3KYd0ewxaciLKf+KZGEUbWNB4aF4anSYpGS
 2Ga2WINzyvN1WN6S7jjnf9qx
X-Google-Smtp-Source: AGHT+IH6KMbKyETy6n5HX2aHsvKhBiq6a5p+3VJIT48Y6CxZ/gxfcrh2v1oxFofvGPerAYZaX3OGxg==
X-Received: by 2002:a05:600c:1c1a:b0:436:1b81:b65c with SMTP id
 5b1f17b1804b1-43668646aebmr342767945e9.15.1735592385747; 
 Mon, 30 Dec 2024 12:59:45 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b0145csm401961895e9.15.2024.12.30.12.59.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Dec 2024 12:59:45 -0800 (PST)
Message-ID: <b394e626-b896-4ece-b6d3-bcb48e19d0f7@linaro.org>
Date: Mon, 30 Dec 2024 21:59:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 01/14] ui & main loop: Redesign of system-specific
 main thread event handling
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: agraf@csgraf.de, peter.maydell@linaro.org, pbonzini@redhat.com,
 rad@semihalf.com, quic_llindhol@quicinc.com, stefanha@redhat.com,
 mst@redhat.com, slp@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, gaosong@loongson.cn,
 jiaxun.yang@flygoat.com, chenhuacai@kernel.org, kwolf@redhat.com,
 hreitz@redhat.com, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, akihiko.odaki@daynix.com,
 qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 balaton@eik.bme.hu
References: <20241223221645.29911-1-phil@philjordan.eu>
 <20241223221645.29911-2-phil@philjordan.eu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241223221645.29911-2-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 23/12/24 23:16, Phil Dennis-Jordan wrote:
> macOS's Cocoa event handling must be done on the initial (main) thread
> of the process. Furthermore, if library or application code uses
> libdispatch, the main dispatch queue must be handling events on the main
> thread as well.
> 
> So far, this has affected Qemu in both the Cocoa and SDL UIs, although
> in different ways: the Cocoa UI replaces the default qemu_main function
> with one that spins Qemu's internal main event loop off onto a
> background thread. SDL (which uses Cocoa internally) on the other hand
> uses a polling approach within Qemu's main event loop. Events are
> polled during the SDL UI's dpy_refresh callback, which happens to run
> on the main thread by default.
> 
> As UIs are mutually exclusive, this works OK as long as nothing else
> needs platform-native event handling. In the next patch, a new device is
> introduced based on the ParavirtualizedGraphics.framework in macOS.
> This uses libdispatch internally, and only works when events are being
> handled on the main runloop. With the current system, it works when
> using either the Cocoa or the SDL UI. However, it does not when running
> headless. Moreover, any attempt to install a similar scheme to the
> Cocoa UI's main thread replacement fails when combined with the SDL
> UI.
> 
> This change tidies up main thread management to be more flexible.
> 
>   * The qemu_main global function pointer is a custom function for the
>     main thread, and it may now be NULL. When it is, the main thread
>     runs the main Qemu loop. This represents the traditional setup.
>   * When non-null, spawning the main Qemu event loop on a separate
>     thread is now done centrally rather than inside the Cocoa UI code.
>   * For most platforms, qemu_main is indeed NULL by default, but on
>     Darwin, it defaults to a function that runs the CFRunLoop.
>   * The Cocoa UI sets qemu_main to a function which runs the
>     NSApplication event handling runloop, as is usual for a Cocoa app.
>   * The SDL UI overrides the qemu_main function to NULL, thus
>     specifying that Qemu's main loop must run on the main
>     thread.
>   * The GTK UI also overrides the qemu_main function to NULL.
>   * For other UIs, or in the absence of UIs, the platform's default
>     behaviour is followed.
> 
> This means that on macOS, the platform's runloop events are always
> handled, regardless of chosen UI. The new PV graphics device will
> thus work in all configurations. There is no functional change on other
> operating systems.
> 
> Implementing this via a global function pointer variable is a bit
> ugly, but it's probably worth investigating the existing UI thread rule
> violations in the SDL (e.g. #2537) and GTK+ back-ends. Fixing those
> issues might precipitate requirements similar but not identical to those
> of the Cocoa UI; hopefully we'll see some kind of pattern emerge, which
> can then be used as a basis for an overhaul. (In fact, it may turn
> out to be simplest to split the UI/native platform event thread from the
> QEMU main event loop on all platforms, with any UI or even none at all.)
> 
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---


>   include/qemu-main.h | 14 +++++++++++-
>   system/main.c       | 37 +++++++++++++++++++++++++++----
>   ui/cocoa.m          | 54 +++++++++++----------------------------------
>   ui/gtk.c            |  4 ++++
>   ui/sdl2.c           |  4 ++++
>   5 files changed, 67 insertions(+), 46 deletions(-)
> 
> diff --git a/include/qemu-main.h b/include/qemu-main.h
> index 940960a7db..2ee83bedff 100644
> --- a/include/qemu-main.h
> +++ b/include/qemu-main.h
> @@ -5,7 +5,19 @@
>   #ifndef QEMU_MAIN_H
>   #define QEMU_MAIN_H
>   
> -int qemu_default_main(void);
> +/*
> + * The function to run on the main (initial) thread of the process.
> + * NULL means QEMU's main event loop.
> + * When non-NULL, QEMU's main event loop will run on a purposely created
> + * thread, after which the provided function pointer will be invoked on
> + * the initial thread.
> + * This is useful on platforms which treat the main thread as special
> + * (macOS/Darwin) and/or require all UI API calls to occur from the main
> + * thread. Those platforms can initialise it to a specific function,
> + * while UI implementations may reset it to NULL during their init if they
> + * will handle system and UI events on the main thread via QEMU's own main
> + * event loop.
> + */
>   extern int (*qemu_main)(void);
>   
>   #endif /* QEMU_MAIN_H */
> diff --git a/system/main.c b/system/main.c
> index 4923520741..9c9a1adc20 100644
> --- a/system/main.c
> +++ b/system/main.c
> @@ -24,26 +24,55 @@
>   
>   #include "qemu/osdep.h"
>   #include "qemu-main.h"
> +#include "qemu/main-loop.h"
>   #include "system/system.h"
>   
>   #ifdef CONFIG_SDL
> +/*
> + * SDL insists on wrapping the main() function with its own implementation on
> + * some platforms; it does so via a macro that renames our main function, so
> + * <SDL.h> must be #included here even with no SDL code called from this file.
> + */
>   #include <SDL.h>
>   #endif
>   
> -int qemu_default_main(void)
> +#ifdef CONFIG_DARWIN
> +#include <CoreFoundation/CoreFoundation.h>
> +#endif
> +
> +static void *qemu_default_main(void *opaque)
>   {
>       int status;
>   
> +    bql_lock();
>       status = qemu_main_loop();
>       qemu_cleanup(status);
> +    bql_unlock();
>   
> -    return status;
> +    exit(status);
>   }
>   
> -int (*qemu_main)(void) = qemu_default_main;
> +int (*qemu_main)(void);
> +
> +#ifdef CONFIG_DARWIN
> +static int os_darwin_cfrunloop_main(void)
> +{
> +    CFRunLoopRun();
> +    g_assert_not_reached();
> +}
> +int (*qemu_main)(void) = os_darwin_cfrunloop_main;
> +#endif
>   
>   int main(int argc, char **argv)
>   {
>       qemu_init(argc, argv);
> -    return qemu_main();
> +    bql_unlock();
> +    if (qemu_main) {
> +        QemuThread main_loop_thread;
> +        qemu_thread_create(&main_loop_thread, "qemu_main",
> +                           qemu_default_main, NULL, QEMU_THREAD_DETACHED);
> +        return qemu_main();
> +    } else {
> +        qemu_default_main(NULL);
> +    }
>   }

Build failure on Windows:

../system/main.c: In function 'SDL_main':
../system/main.c:78:1: error: control reaches end of non-void function 
[-Werror=return-type]
    78 | }
       | ^
cc1: all warnings being treated as errors
ninja: build stopped: subcommand failed.
make: *** [Makefile:168: run-ninja] Error 1

I'm squashing:

-- >8 --
diff --git a/system/main.c b/system/main.c
index 9c9a1adc20c..ecb12fd397c 100644
--- a/system/main.c
+++ b/system/main.c
@@ -74,5 +74,6 @@ int main(int argc, char **argv)
          return qemu_main();
      } else {
          qemu_default_main(NULL);
+        g_assert_not_reached();
      }
  }
---


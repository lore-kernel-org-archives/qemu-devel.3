Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05663D68B18
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 13:38:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBa2O-0004mu-RU; Thu, 14 Nov 2024 08:37:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tBa2M-0004lO-4Z; Thu, 14 Nov 2024 08:37:30 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tBa2J-00035u-6d; Thu, 14 Nov 2024 08:37:29 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5B9CF4E6036;
 Thu, 14 Nov 2024 14:37:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id Y1f4-Zkh-2Hp; Thu, 14 Nov 2024 14:37:20 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 410274E6030; Thu, 14 Nov 2024 14:37:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3E4F5746F60;
 Thu, 14 Nov 2024 14:37:20 +0100 (CET)
Date: Thu, 14 Nov 2024 14:37:20 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Phil Dennis-Jordan <phil@philjordan.eu>
cc: qemu-devel@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org, 
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com, 
 stefanha@redhat.com, mst@redhat.com, slp@redhat.com, 
 richard.henderson@linaro.org, eduardo@habkost.net, 
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com, 
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com, 
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com, 
 akihiko.odaki@daynix.com, qemu-arm@nongnu.org, qemu-block@nongnu.org, 
 qemu-riscv@nongnu.org
Subject: Re: [PATCH v10 01/15] ui & main loop: Redesign of system-specific
 main thread event handling
In-Reply-To: <CAAibmn2PJ0Q0E3KEGZqu9ogbMt+qiBLRuXa6C74ud=2S4G8DSA@mail.gmail.com>
Message-ID: <fa7ecd3a-d156-b64b-a16b-8593f24c1731@eik.bme.hu>
References: <20241113142343.40832-1-phil@philjordan.eu>
 <20241113142343.40832-2-phil@philjordan.eu>
 <9dd5c736-e1b8-a025-745a-52e9aacb4b9b@eik.bme.hu>
 <CAAibmn2PJ0Q0E3KEGZqu9ogbMt+qiBLRuXa6C74ud=2S4G8DSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Thu, 14 Nov 2024, Phil Dennis-Jordan wrote:
> On Wed, 13 Nov 2024 at 19:16, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>> On Wed, 13 Nov 2024, Phil Dennis-Jordan wrote:
>>> macOS's Cocoa event handling must be done on the initial (main) thread
>>> of the process. Furthermore, if library or application code uses
>>> libdispatch, the main dispatch queue must be handling events on the main
>>> thread as well.
>>>
>>> So far, this has affected Qemu in both the Cocoa and SDL UIs, although
>>> in different ways: the Cocoa UI replaces the default qemu_main function
>>> with one that spins Qemu's internal main event loop off onto a
>>> background thread. SDL (which uses Cocoa internally) on the other hand
>>> uses a polling approach within Qemu's main event loop. Events are
>>> polled during the SDL UI's dpy_refresh callback, which happens to run
>>> on the main thread by default.
>>>
>>> As UIs are mutually exclusive, this works OK as long as nothing else
>>> needs platform-native event handling. In the next patch, a new device is
>>> introduced based on the ParavirtualizedGraphics.framework in macOS.
>>> This uses libdispatch internally, and only works when events are being
>>> handled on the main runloop. With the current system, it works when
>>> using either the Cocoa or the SDL UI. However, it does not when running
>>> headless. Moreover, any attempt to install a similar scheme to the
>>> Cocoa UI's main thread replacement fails when combined with the SDL
>>> UI.
>>>
>>> This change tidies up main thread management to be more flexible.
>>>
>>> * The qemu_main global function pointer is a custom function for the
>>>   main thread, and it may now be NULL. When it is, the main thread
>>>   runs the main Qemu loop. This represents the traditional setup.
>>> * When non-null, spawning the main Qemu event loop on a separate
>>>   thread is now done centrally rather than inside the Cocoa UI code.
>>> * For most platforms, qemu_main is indeed NULL by default, but on
>>>   Darwin, it defaults to a function that runs the CFRunLoop.
>>> * The Cocoa UI sets qemu_main to a function which runs the
>>>   NSApplication event handling runloop, as is usual for a Cocoa app.
>>> * The SDL UI overrides the qemu_main function to NULL, thus
>>>   specifying that Qemu's main loop must run on the main
>>>   thread.
>>> * The GTK UI also overrides the qemu_main function to NULL.
>>> * For other UIs, or in the absence of UIs, the platform's default
>>>   behaviour is followed.
>>>
>>> This means that on macOS, the platform's runloop events are always
>>> handled, regardless of chosen UI. The new PV graphics device will
>>> thus work in all configurations. There is no functional change on other
>>> operating systems.
>>>
>>> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
>>> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> ---
>>>
>>> v5:
>>>
>>> * Simplified the way of setting/clearing the main loop by going back
>>>   to setting qemu_main directly, but narrowing the scope of what it
>>>   needs to do, and it can now be NULL.
>>>
>>> v6:
>>>
>>> * Folded function qemu_run_default_main_on_new_thread's code into
>>>   main()
>>> * Removed whitespace changes left over on lines near code removed
>>>   between v4 and v5
>>>
>>> v9:
>>>
>>> * Set qemu_main to NULL for GTK UI as well.
>>>
>>> v10:
>>>
>>> * Added comments clarifying the functionality and purpose of qemu_main.
>>>
>>> include/qemu-main.h     | 21 ++++++++++++++--
>>> include/qemu/typedefs.h |  1 +
>>> system/main.c           | 50 ++++++++++++++++++++++++++++++++++----
>>> ui/cocoa.m              | 54 ++++++++++-------------------------------
>>> ui/gtk.c                |  8 ++++++
>>> ui/sdl2.c               |  4 +++
>>> 6 files changed, 90 insertions(+), 48 deletions(-)
>>>
>>> diff --git a/include/qemu-main.h b/include/qemu-main.h
>>> index 940960a7dbc..fc70681c8b5 100644
>>> --- a/include/qemu-main.h
>>> +++ b/include/qemu-main.h
>>> @@ -5,7 +5,24 @@
>>> #ifndef QEMU_MAIN_H
>>> #define QEMU_MAIN_H
>>>
>>> -int qemu_default_main(void);
>>> -extern int (*qemu_main)(void);
>>> +/*
>>> + * The function to run on the main (initial) thread of the process.
>>> + * NULL means QEMU's main event loop.
>>> + * When non-NULL, QEMU's main event loop will run on a purposely created
>>> + * thread, after which the provided function pointer will be invoked on
>>> + * the initial thread.
>>> + * This is useful on platforms which treat the main thread as special
>>> + * (macOS/Darwin) and/or require all UI API calls to occur from a
>>> + * specific thread.
>>> + * Implementing this via a global function pointer variable is a bit
>>> + * ugly, but it's probably worth investigating the existing UI thread
>> rule
>>> + * violations in the SDL (e.g. #2537) and GTK+ back-ends. Fixing those
>>> + * issues might precipitate requirements similar but not identical to
>> those
>>> + * of the Cocoa UI; hopefully we'll see some kind of pattern emerge,
>> which
>>> + * can then be used as a basis for an overhaul. (In fact, it may turn
>>> + * out to be simplest to split the UI/native platform event thread from
>> the
>>> + * QEMU main event loop on all platforms, with any UI or even none at
>> all.)
>>> + */
>>> +extern qemu_main_fn qemu_main;
>>
>> qemu_main_fn is defined in typdefefs.h but not included here. Also coding
>> style says typedefs should be CamelCase but maybe it's just not worth to
>> define a type for this and you can just leave the existing line here only
>> removing the qemu_default_main declaration and adding the comment.
>>
>>> #endif /* QEMU_MAIN_H */
>>> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
>>> index 3d84efcac47..b02cfe1f328 100644
>>> --- a/include/qemu/typedefs.h
>>> +++ b/include/qemu/typedefs.h
>>> @@ -131,5 +131,6 @@ typedef struct IRQState *qemu_irq;
>>>  * Function types
>>>  */
>>> typedef void (*qemu_irq_handler)(void *opaque, int n, int level);
>>> +typedef int (*qemu_main_fn)(void);
>>
>> Then drop this change...
>>
>>> #endif /* QEMU_TYPEDEFS_H */
>>> diff --git a/system/main.c b/system/main.c
>>> index 9b91d21ea8c..d9397a6d5d0 100644
>>> --- a/system/main.c
>>> +++ b/system/main.c
>>> @@ -24,13 +24,14 @@
>>>
>>> #include "qemu/osdep.h"
>>> #include "qemu-main.h"
>>> +#include "qemu/main-loop.h"
>>> #include "sysemu/sysemu.h"
>>>
>>> -#ifdef CONFIG_SDL
>>> -#include <SDL.h>
>>> +#ifdef CONFIG_DARWIN
>>> +#include <CoreFoundation/CoreFoundation.h>
>>> #endif
>>>
>>> -int qemu_default_main(void)
>>> +static int qemu_default_main(void)
>>> {
>>>     int status;
>>>
>>> @@ -40,10 +41,49 @@ int qemu_default_main(void)
>>>     return status;
>>> }
>>>
>>> -int (*qemu_main)(void) = qemu_default_main;
>>
>> ...and leave this line here without init to define the global variable and
>> only put assigning the init value in the #ifdef if you don't want to
>> repeat the function pointer definition twice (but that wouldn't be a
>> problem either in my opinion to do it in the #ifdef this way).
>>
>>> +/*
>>> + * Various macOS system libraries, including the Cocoa UI and anything
>> using
>>> + * libdispatch, such as ParavirtualizedGraphics.framework, requires
>> that the
>>> + * main runloop, on the main (initial) thread be running or at least
>> regularly
>>> + * polled for events. A special mode is therefore supported, where the
>> QEMU
>>> + * main loop runs on a separate thread and the main thread handles the
>>> + * CF/Cocoa runloop.
>>> + */
>>> +
>>> +static void *call_qemu_default_main(void *opaque)
>>> +{
>>> +    int status;
>>> +
>>> +    bql_lock();
>>> +    status = qemu_default_main();
>>> +    bql_unlock();
>>> +
>>> +    exit(status);
>>> +}
>>> +
>>> +#ifdef CONFIG_DARWIN
>>> +static int os_darwin_cfrunloop_main(void)
>>> +{
>>> +    CFRunLoopRun();
>>> +    abort();
>>
>> Is it better to use g_assert_not_reached() here?
>>
>>> +}
>>> +
>>> +qemu_main_fn qemu_main = os_darwin_cfrunloop_main;
>>> +#else
>>> +qemu_main_fn qemu_main;
>>> +#endif
>>>
>>> int main(int argc, char **argv)
>>> {
>>> +    QemuThread main_loop_thread;
>>> +
>>>     qemu_init(argc, argv);
>>> -    return qemu_main();
>>> +    if (qemu_main) {
>>> +        qemu_thread_create(&main_loop_thread, "qemu_main",
>>> +                           call_qemu_default_main, NULL,
>> QEMU_THREAD_DETACHED);
>>> +        bql_unlock();
>>> +        return qemu_main();
>>> +    } else {
>>> +        qemu_default_main();
>>
>> I think you need 'return qemu_default_main()' here but I'm a bit confused
>> by all this wrapping of qemu_default_main in call_qemu_default_main. I see
>> that may be needed because qemu_thread_create takes a different function
>> but now that qemu_default main is static and not replaced externally could
>> that be changed to the right type and avoid this confusion and simplify
>> this a bit?
>>
>> Regards,
>> BALATON Zoltan
>>
>>
> Alright, I've gone ahead and worked through that, and it does indeed make
> things simpler. This is what I have for include/qemu-main.h and
> system/main.c now:

I think it looks better (can't tell if it will work so leave review to 
others who know this better). Maybe just a couple of more nits below.

> diff --git a/include/qemu-main.h b/include/qemu-main.h
> index 940960a7dbc..e1041fe99b4 100644
> --- a/include/qemu-main.h
> +++ b/include/qemu-main.h
> @@ -5,7 +5,29 @@
> #ifndef QEMU_MAIN_H
> #define QEMU_MAIN_H
>
> -int qemu_default_main(void);
> +/*
> + * The function to run on the main (initial) thread of the process.
> + * NULL means QEMU's main event loop.
> + * When non-NULL, QEMU's main event loop will run on a purposely created
> + * thread, after which the provided function pointer will be invoked on
> + * the initial thread.
> + * This is useful on platforms which treat the main thread as special
> + * (macOS/Darwin) and/or require all UI API calls to occur from a
> + * specific thread.
> + * In practice, this means that on macOS, it is initialised to a function
> + * that runs the Core Foundation runloop. The Cocoa UI "upgrades" this
> + * to the NSApplication-specific event processing variant. Other platforms
> + * currently leave it at NULL; the SDL and GTK UIs reset it to NULL even
> + * on macOS as they directly poll the runloop.

I'm not sure this last paragraph below belongs here or maybe better put it 
somewhere else (but if nobody else objects it can be left here for 
reminder and later clean up). I know I suggested to add a comment to note 
this but this comment is a bit long and with a lot of uncertainity so 
maybe it's enough to put this paragraph in the commit message, but it 
could be it will be burried there and nobody will see it later so a 
comment is more prominent place. I'm OK with it either way.

> + * Implementing this via a global function pointer variable is a bit
> + * ugly, but it's probably worth investigating the existing UI thread rule
> + * violations in the SDL (e.g. #2537) and GTK+ back-ends. Fixing those
> + * issues might precipitate requirements similar but not identical to those
> + * of the Cocoa UI; hopefully we'll see some kind of pattern emerge, which
> + * can then be used as a basis for an overhaul. (In fact, it may turn
> + * out to be simplest to split the UI/native platform event thread from the
> + * QEMU main event loop on all platforms, with any UI or even none at all.)
> + */
> extern int (*qemu_main)(void);
>
> #endif /* QEMU_MAIN_H */
> diff --git a/system/main.c b/system/main.c
> index 9b91d21ea8c..2d9d144ed46 100644
> --- a/system/main.c
> +++ b/system/main.c
> @@ -24,26 +24,48 @@
>
> #include "qemu/osdep.h"
> #include "qemu-main.h"
> +#include "qemu/main-loop.h"
> #include "sysemu/sysemu.h"
>
> -#ifdef CONFIG_SDL
> -#include <SDL.h>
> +#ifdef CONFIG_DARWIN
> +#include <CoreFoundation/CoreFoundation.h>
> #endif
>
> -int qemu_default_main(void)
> +static void *qemu_default_main(void *opaque)
> {
>     int status;
>
> +    bql_lock();
>     status = qemu_main_loop();
>     qemu_cleanup(status);
> +    bql_unlock();
>
> -    return status;
> +    exit(status);
> }
>
> -int (*qemu_main)(void) = qemu_default_main;

You could leave the definition without value here (what's now in the 
#else) and then only assign it in the #if so this line would become

-int (*qemu_main)(void) = qemu_default_main;
+int (*qemu_main)(void);

> +#ifdef CONFIG_DARWIN
> +static int os_darwin_cfrunloop_main(void)
> +{
> +    CFRunLoopRun();
> +    g_assert_not_reached();
> +}
> +
> +int (*qemu_main)(void) = os_darwin_cfrunloop_main;

and this would be

qemu_main = os_darwin_cfrunloop_main;

and no need for #else. Also the name of this darwin main is a bit long, 
maybe qemu_darwin_main or qemu_default_main_darwin could be better?

> +#else
> +int (*qemu_main)(void);
> +#endif
>
> int main(int argc, char **argv)
> {
> +    QemuThread main_loop_thread;

This could be moved within the if (qemu_main) below as it's not needed 
outside.

> +
>     qemu_init(argc, argv);
> -    return qemu_main();
> +    bql_unlock();

What locks the bql at this point? I could not find the part in qemu_init 
that makes it necessary to unlock it here. If nothing else is called 
before this, is it needed to take the lock and then unlock it here or can 
it be assumed to be unlocked yet?

Regards,
BALATON Zoltan

> +    if (qemu_main) {
> +        qemu_thread_create(&main_loop_thread, "qemu_main",
> +                           qemu_default_main, NULL, QEMU_THREAD_DETACHED);
> +        return qemu_main();
> +    } else {
> +        qemu_default_main(NULL);
> +    }
> }
>


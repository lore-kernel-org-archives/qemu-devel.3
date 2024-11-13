Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F88D637A4
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 18:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBIDg-0000jb-97; Wed, 13 Nov 2024 13:36:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBIDb-0000hu-Fh
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 13:35:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBIDY-0003wt-CA
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 13:35:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731522949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/WgSuKX4v9WfD7FmJnCYXS9iXgeyMrCEHivEC2L2OK8=;
 b=cjThAEb/aFNH9+VMruio658xXFIky8wyUYUEgZ/iQmNE9pNEJd9trZSMQSMCOR11LcqdEZ
 dj+HNxDnTCNhsogg7y9zamLid0YZkuK9Qnub+/CPi5XCSDemO/zvAne1+tywDPf2pPwW1E
 /Tjsc1FlZx04JQdgz+nVGiXfFHK58Is=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-zKRDKtTQNV2v346c8-xNkg-1; Wed, 13 Nov 2024 13:35:48 -0500
X-MC-Unique: zKRDKtTQNV2v346c8-xNkg-1
X-Mimecast-MFC-AGG-ID: zKRDKtTQNV2v346c8-xNkg
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d5ca192b8so719420f8f.1
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 10:35:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731522947; x=1732127747;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/WgSuKX4v9WfD7FmJnCYXS9iXgeyMrCEHivEC2L2OK8=;
 b=YXY5q6LnrkkThXYfvbSMzyHd+6aEYFRC1Le8nJRXVgQAPKwH7k9704y65IC2Mj5EuI
 wyx12TXtnnvfnWCzhivujffyIgyloysvjvmEiGjhWoFH0Ce14Ra+yuw8Am8dhiVaMlSu
 HyXsTsP3Rsea1CY+YgKITqt3fdA5ClgXb6XMkCANJhhsmTh8SrUkns6KQS32jqL6Pwzh
 B8jUdv6JMTUUgwUUGgp03OtlwQ18GgkV9EaP7RRDH3za0b/hkRqEtujTXKT+Pqg7BjZ1
 6Jcasl/LpPxm/xot3k9swHI4FMuMx30WG3dm2V2YkwOfPlIKo3wc+qZfnbvIfYkNIEj2
 UvEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUv42rsw8K0PuYHOEid+GaHOa5xdgFHBo2AQH9Udw6lSrEZu/OoEvLVcq/bPTlM4ngYRSJ1nEyZ+oCO@nongnu.org
X-Gm-Message-State: AOJu0YzwhhrLq67eekMHHfulHjteurRlRWCPs8m0tXjBdO6l2Xw7i6St
 Fa5fzPYeMwMWoMyWGL3+ippTKl1rk/C8bQNEfeOoR5UOjEppWX3a7nSkhocU4cYP1+1vfQZYA6j
 YqoioE9E5Q1MzKqKUFPZp0LmIh8AcT53zNvv0j9jLy2OMpwJ0m8YVZnBAD+Mlebqvi0ytawb/eI
 1MXAUc7MS/SMeGM0wszwRAeSzUFYI=
X-Received: by 2002:a5d:6c66:0:b0:37d:3baa:9f34 with SMTP id
 ffacd0b85a97d-38213ff9784mr326068f8f.1.1731522947178; 
 Wed, 13 Nov 2024 10:35:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDmIPbp/TjpajsKWS+t5rYVSHd9kCJROLJMoI9tsENHo/garBB1UjpQ76+/OlJWDoswHcyJRm9zaN2AJoGAKA=
X-Received: by 2002:a5d:6c66:0:b0:37d:3baa:9f34 with SMTP id
 ffacd0b85a97d-38213ff9784mr326028f8f.1.1731522946735; Wed, 13 Nov 2024
 10:35:46 -0800 (PST)
MIME-Version: 1.0
References: <20241113142343.40832-1-phil@philjordan.eu>
 <20241113142343.40832-2-phil@philjordan.eu>
 <9dd5c736-e1b8-a025-745a-52e9aacb4b9b@eik.bme.hu>
In-Reply-To: <9dd5c736-e1b8-a025-745a-52e9aacb4b9b@eik.bme.hu>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 13 Nov 2024 19:35:35 +0100
Message-ID: <CABgObfbCF7q_ATWmWw2yCmYhTQK7tKmgGKR73s4u3W5Kvqj2Cw@mail.gmail.com>
Subject: Re: [PATCH v10 01/15] ui & main loop: Redesign of system-specific
 main thread event handling
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 agraf@csgraf.de, 
 peter.maydell@linaro.org, rad@semihalf.com, quic_llindhol@quicinc.com, 
 stefanha@redhat.com, mst@redhat.com, slp@redhat.com, 
 richard.henderson@linaro.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com, 
 gaosong@loongson.cn, jiaxun.yang@flygoat.com, chenhuacai@kernel.org, 
 kwolf@redhat.com, hreitz@redhat.com, philmd@linaro.org, shorne@gmail.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com, 
 akihiko.odaki@daynix.com, qemu-arm@nongnu.org, qemu-block@nongnu.org, 
 qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.738,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Nov 13, 2024 at 7:16=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:
> > int main(int argc, char **argv)
> > {
> > +    QemuThread main_loop_thread;
> > +
> >     qemu_init(argc, argv);
> > -    return qemu_main();
> > +    if (qemu_main) {
> > +        qemu_thread_create(&main_loop_thread, "qemu_main",
> > +                           call_qemu_default_main, NULL, QEMU_THREAD_D=
ETACHED);
> > +        bql_unlock();
> > +        return qemu_main();
> > +    } else {
> > +        qemu_default_main();
>
> I think you need 'return qemu_default_main()' here but I'm a bit confused
> by all this wrapping of qemu_default_main in call_qemu_default_main. I se=
e
> that may be needed because qemu_thread_create takes a different function
> but now that qemu_default main is static and not replaced externally coul=
d
> that be changed to the right type and avoid this confusion and simplify
> this a bit?

Note that qemu_default_main() expects the BQL to be locked, whereas
qemu_main() and call_qemu_default_main() do not (because they run in a
separate thread).

But you're right, we could push bql_lock()/bql_unlock() into
qemu_default_main(), and do

     bql_unlock();
     if (qemu_main) {
        qemu_thread_create(&main_loop_thread, "qemu_main",
                           call_qemu_default_main, NULL, QEMU_THREAD_DETACH=
ED);
        return qemu_main();
    } else {
        return qemu_default_main();
    }

Paolo

> Regards,
> BALATON Zoltan
>
> > +    }
> > }
> > diff --git a/ui/cocoa.m b/ui/cocoa.m
> > index 4c2dd335323..30b8920d929 100644
> > --- a/ui/cocoa.m
> > +++ b/ui/cocoa.m
> > @@ -73,6 +73,8 @@
> >     int height;
> > } QEMUScreen;
> >
> > +@class QemuCocoaPasteboardTypeOwner;
> > +
> > static void cocoa_update(DisplayChangeListener *dcl,
> >                          int x, int y, int w, int h);
> >
> > @@ -107,6 +109,7 @@ static void cocoa_switch(DisplayChangeListener *dcl=
,
> > static NSInteger cbchangecount =3D -1;
> > static QemuClipboardInfo *cbinfo;
> > static QemuEvent cbevent;
> > +static QemuCocoaPasteboardTypeOwner *cbowner;
> >
> > // Utility functions to run specified code block with the BQL held
> > typedef void (^CodeBlock)(void);
> > @@ -1321,8 +1324,10 @@ - (void) dealloc
> > {
> >     COCOA_DEBUG("QemuCocoaAppController: dealloc\n");
> >
> > -    if (cocoaView)
> > -        [cocoaView release];
> > +    [cocoaView release];
> > +    [cbowner release];
> > +    cbowner =3D nil;
> > +
> >     [super dealloc];
> > }
> >
> > @@ -1938,8 +1943,6 @@ - (void)pasteboard:(NSPasteboard *)sender provide=
DataForType:(NSPasteboardType)t
> >
> > @end
> >
> > -static QemuCocoaPasteboardTypeOwner *cbowner;
> > -
> > static void cocoa_clipboard_notify(Notifier *notifier, void *data);
> > static void cocoa_clipboard_request(QemuClipboardInfo *info,
> >                                     QemuClipboardType type);
> > @@ -2002,43 +2005,8 @@ static void cocoa_clipboard_request(QemuClipboar=
dInfo *info,
> >     }
> > }
> >
> > -/*
> > - * The startup process for the OSX/Cocoa UI is complicated, because
> > - * OSX insists that the UI runs on the initial main thread, and so we
> > - * need to start a second thread which runs the qemu_default_main():
> > - * in main():
> > - *  in cocoa_display_init():
> > - *   assign cocoa_main to qemu_main
> > - *   create application, menus, etc
> > - *  in cocoa_main():
> > - *   create qemu-main thread
> > - *   enter OSX run loop
> > - */
> > -
> > -static void *call_qemu_main(void *opaque)
> > -{
> > -    int status;
> > -
> > -    COCOA_DEBUG("Second thread: calling qemu_default_main()\n");
> > -    bql_lock();
> > -    status =3D qemu_default_main();
> > -    bql_unlock();
> > -    COCOA_DEBUG("Second thread: qemu_default_main() returned, exiting\=
n");
> > -    [cbowner release];
> > -    exit(status);
> > -}
> > -
> > static int cocoa_main(void)
> > {
> > -    QemuThread thread;
> > -
> > -    COCOA_DEBUG("Entered %s()\n", __func__);
> > -
> > -    bql_unlock();
> > -    qemu_thread_create(&thread, "qemu_main", call_qemu_main,
> > -                       NULL, QEMU_THREAD_DETACHED);
> > -
> > -    // Start the main event loop
> >     COCOA_DEBUG("Main thread: entering OSX run loop\n");
> >     [NSApp run];
> >     COCOA_DEBUG("Main thread: left OSX run loop, which should never hap=
pen\n");
> > @@ -2120,8 +2088,6 @@ static void cocoa_display_init(DisplayState *ds, =
DisplayOptions *opts)
> >
> >     COCOA_DEBUG("qemu_cocoa: cocoa_display_init\n");
> >
> > -    qemu_main =3D cocoa_main;
> > -
> >     // Pull this console process up to being a fully-fledged graphical
> >     // app with a menubar and Dock icon
> >     ProcessSerialNumber psn =3D { 0, kCurrentProcess };
> > @@ -2185,6 +2151,12 @@ static void cocoa_display_init(DisplayState *ds,=
 DisplayOptions *opts)
> >     qemu_clipboard_peer_register(&cbpeer);
> >
> >     [pool release];
> > +
> > +    /*
> > +     * The Cocoa UI will run the NSApplication runloop on the main thr=
ead
> > +     * rather than the default Core Foundation one.
> > +     */
> > +    qemu_main =3D cocoa_main;
> > }
> >
> > static QemuDisplay qemu_display_cocoa =3D {
> > diff --git a/ui/gtk.c b/ui/gtk.c
> > index bf9d3dd679a..fbf20161f36 100644
> > --- a/ui/gtk.c
> > +++ b/ui/gtk.c
> > @@ -38,6 +38,7 @@
> > #include "qemu/cutils.h"
> > #include "qemu/error-report.h"
> > #include "qemu/main-loop.h"
> > +#include "qemu-main.h"
> >
> > #include "ui/console.h"
> > #include "ui/gtk.h"
> > @@ -2485,6 +2486,13 @@ static void gtk_display_init(DisplayState *ds, D=
isplayOptions *opts)
> > #ifdef CONFIG_GTK_CLIPBOARD
> >     gd_clipboard_init(s);
> > #endif /* CONFIG_GTK_CLIPBOARD */
> > +
> > +    /*
> > +     * GTK+ calls must happen on the main thread at least on some plat=
forms,
> > +     * and on macOS the main runloop is polled via GTK+'s event handli=
ng.
> > +     * Don't allow QEMU's event loop to be moved off the main thread.
> > +     */
> > +    qemu_main =3D NULL;
> > }
> >
> > static void early_gtk_display_init(DisplayOptions *opts)
> > diff --git a/ui/sdl2.c b/ui/sdl2.c
> > index bd4f5a9da14..44ab2762262 100644
> > --- a/ui/sdl2.c
> > +++ b/ui/sdl2.c
> > @@ -34,6 +34,7 @@
> > #include "sysemu/sysemu.h"
> > #include "ui/win32-kbd-hook.h"
> > #include "qemu/log.h"
> > +#include "qemu-main.h"
> >
> > static int sdl2_num_outputs;
> > static struct sdl2_console *sdl2_console;
> > @@ -965,6 +966,9 @@ static void sdl2_display_init(DisplayState *ds, Dis=
playOptions *o)
> >     }
> >
> >     atexit(sdl_cleanup);
> > +
> > +    /* SDL's event polling (in dpy_refresh) must happen on the main th=
read. */
> > +    qemu_main =3D NULL;
> > }
> >
> > static QemuDisplay qemu_display_sdl2 =3D {
> >
>



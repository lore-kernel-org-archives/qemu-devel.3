Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4291D68B12
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 13:27:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBZsL-0001kf-4Z; Thu, 14 Nov 2024 08:27:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBZsJ-0001jm-3p
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 08:27:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBZsH-0007Os-Eh
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 08:27:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731590824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vKmNwUQm6N8OZ4WFnBjPn/L9WzpJEfMJhrvQsiWkang=;
 b=DyP1OOypu80o3fUOok7pJ1U1webhGUKJj72n4jsopHbl5aQrTA4dQbVQ+B0v4LANZF+lR0
 rUNCHHc9KNxW1Ke+9GE0v4vjaCfMMGhRNSN6gyv21xkg8rOWVyl5QefJGYACWwup70ViGZ
 QJDX4Pdj1kbT6FCd9HZzKT/J0pl5tNQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-qc1s1znXPAehGj2tP5E44g-1; Thu, 14 Nov 2024 08:27:03 -0500
X-MC-Unique: qc1s1znXPAehGj2tP5E44g-1
X-Mimecast-MFC-AGG-ID: qc1s1znXPAehGj2tP5E44g
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d56061a4cso370888f8f.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 05:27:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731590822; x=1732195622;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vKmNwUQm6N8OZ4WFnBjPn/L9WzpJEfMJhrvQsiWkang=;
 b=Y+M6ckj9x9sWg9m3Ezy2ifTfL3W6p42tqKnSgS+j93gUdfdUPW0MsIymu5zjzSe5FQ
 IEFv58Nis9u+OcQV/5QaKeDK/v9inuCKDJ/P9Sb+tA6uYDSPhKw1EABSLSOIBeSw6QlB
 AySjE1IQEM7G7ijtcu7dXzWSr4DVXuHqUfkULaoouycA7vJS4yPcnouwFZh38zwhMYZ+
 pn8BS3Lsg7zjTlXQaDQ0RH5HI3kth+3xGapEf54MnIkEaeBtlySOPl/YYu4WNqewZvaQ
 km0gzgzGcAx6BYUzXdhaGexnrnY3G3zfb5CELws5OCDoUQzNGUhdTo9MLXEQVX8JoKXh
 hVNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7yFvSxp69rT81fPVj8RamCgt3OxLuwTPhVuEXJ8AEnMHhSKyibkP9B4fsfXrbiqqh3ttgtFENH7lA@nongnu.org
X-Gm-Message-State: AOJu0YyRPZxS2cXBHDMeQoBGGuhbM7uqfb1WKd9zy/v9k4xwjSjhKTLj
 c9imymgnyQ25idRGyxUKhxOEhO1Vj2d7LR6GKXhe/ZQQ37W60JGj/gZ78yRhbj0tM0Q0m0p9uzu
 OchiEsySTVkLc1OygH59hwVbpiO426KdoIFHTiO+FJ1c2loVawMnfNTI9NeX8p051MPMk9AzW+7
 /BruO34d3QzPz8U0R5Ehg5bcIEfDs=
X-Received: by 2002:a05:6000:1567:b0:374:c17a:55b5 with SMTP id
 ffacd0b85a97d-3820810fdb5mr9327343f8f.14.1731590822096; 
 Thu, 14 Nov 2024 05:27:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1tO9NFPBCq8KEX3IMOfL0txo+saZQ64eLCfz1SWhqaRTqA46/k/L5IMs1FYU3ex4uzBfEZoNnm4Q0DhdLEng=
X-Received: by 2002:a05:6000:1567:b0:374:c17a:55b5 with SMTP id
 ffacd0b85a97d-3820810fdb5mr9327293f8f.14.1731590821354; Thu, 14 Nov 2024
 05:27:01 -0800 (PST)
MIME-Version: 1.0
References: <20241113142343.40832-1-phil@philjordan.eu>
 <20241113142343.40832-2-phil@philjordan.eu>
 <c0983059-ab11-4bc5-ab60-c5b23d1c290e@redhat.com>
 <CAGCz3vv+5y=YGqZaXnGkVj0zA9fX-n3BOZyuPQC+dRMKN8VJZw@mail.gmail.com>
In-Reply-To: <CAGCz3vv+5y=YGqZaXnGkVj0zA9fX-n3BOZyuPQC+dRMKN8VJZw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 14 Nov 2024 14:26:48 +0100
Message-ID: <CABgObfat1JwiBFNKHK6wwMkW5kgaqZfKJa=rW_9VvEdMWJR75A@mail.gmail.com>
Subject: Re: [PATCH v10 01/15] ui & main loop: Redesign of system-specific
 main thread event handling
To: Phil Dennis-Jordan <lists@philjordan.eu>
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
 qemu-riscv@nongnu.org, balaton@eik.bme.hu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.69,
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

On Thu, Nov 14, 2024 at 11:32=E2=80=AFAM Phil Dennis-Jordan <lists@philjord=
an.eu> wrote:
>> I checked what GTK+ does and, either way, you have to create another
>> thread: timers are handled with a CFRunLoopTimer, but file descriptors
>> are polled in a separate thread and sent to the main thread with a
>> single CFRunLoopSource.  It's a bit nicer that the main thread is in
>> charge, but it's more complex and probably slower too.
>
>
> Just to clarify: is this supposed to be happening inside the GTK+ library=
 itself? i.e. GTK should spawn its own thread to poll file descriptors that=
 are owned by GTK? (As opposed to the file descriptors used by QEMU's own e=
vent loop - what on Linux are eventfds, but on macOS I think are just pipes=
*.)

It's what I saw in the GTK+ source code.

https://gitlab.gnome.org/GNOME/gtk/-/blob/main/gdk/macos/gdkmacoseventsourc=
e.c?ref_type=3Dheads

> This doesn't describe what I'm seeing when I run with -display gtk on mac=
OS. There's no extra thread created. There's a dock icon, but it's non-inte=
ractive ("Application not responding"), there aren't any menus, and there's=
 no window. QEMU's own simulation is running in the background - I can reac=
h a guest via the network. So I guess there's some function in GTK we're su=
pposed to be calling that will make it crank the native event loop on macOS=
, but this isn't being done?

In theory it should work, with the event source added as soon as GTK+
is started... aha!

We do not use the GMainContext's poll_func, we use qemu_poll_ns.
That's the missing part: GDK replaces the poll_func with one that
calls nextEventMatchingMask:

https://gitlab.gnome.org/GNOME/gtk/-/blame/main/gdk/macos/gdkmacoseventsour=
ce.c?ref_type=3Dheads#L767

There could be more issues, but I think for now it's better to block
the GTK+ UI under macOS.

[...]

>> As long as it's clear that any handlers that go through the CFRunLoop
>> run outside the BQL, as is already the case for the Cocoa UI, I see no
>> problem with this approach.
>
> I'm not entirely sure what you're getting at here, to be honest. The UI t=
hread can definitely not assume to be holding the BQL all the time; we'd ha=
ve to treat it more like an AIOContext. It could pave the way towards putti=
ng the display and UI subsystems on their own AIOContext or AIOContext-like=
-thing, rather than hogging the BQL for expensive image operations.

Don't worry, I was mostly talking to myself... The UI thread, and more
specifically any handlers that are called from CFRunLoop instead of
QEMU's main loop, will have to use mutexes or bql_lock()/bql_unlock(),
like ui/cocoa.m already does.

In other words, code that interacts with Apple's paravirtualized
graphics needs to know if it runs from the CFRunLoop or from
qemu_main().

> (*By the sound of it, Win32 has an all-UI-calls-on-one-thread requirement=
 as well which we may be violating to some degree via the GTK and/or SDL ba=
ckends as well; my adventures with Win32 are almost 20 years back now so I'=
m a bit out of the loop there.)

Hmm, no I don't remember anything like that for Windows but it's also
been many years for me.

Paolo



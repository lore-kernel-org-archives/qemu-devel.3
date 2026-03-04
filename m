Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F266AEF8FE5
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 13:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxmgN-0007PD-33; Wed, 04 Mar 2026 08:54:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxmgB-0007Np-8b
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:54:23 -0500
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxmg9-0007qQ-FY
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:54:23 -0500
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-64ca1ba0089so5972406d50.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 05:54:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772632459; cv=none;
 d=google.com; s=arc-20240605;
 b=UU8/0Au2rMBxgpZ32gvsn/PiPyR42pfqIci22/QA5TTYbXGT+Upb1BKY2EpUUYPwJ4
 YS6HVKsf95FpbnwqSmr7S2403bT5Bd+W9F5WFW+Rf5JqRfOtvxT1kPAVDSgS1zMZWSj9
 n+SMdzA345jybxXPdcmkaJGQVILfK0is8IFkWrELEMTDFKg4mgbuNJzjC0lvkPqAdfPG
 h/iUjdOpQzqYy1UuNTMR0OwBi85XZOhF+5q4CXDa+wiT1lq+sevNdL7vyhHFiuQXp3kd
 LwjzoZ/Yfryp9W3lMibM5Mg72cipzGCGIIV9wxAVzZXr0MHLw72vPZKIjgLoYeXFDXaC
 i9pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lJWA8F8Fxnn1rli1uylq1S8dOlBhWu2ZtTc/9dJQ5M4=;
 fh=3PqfOa9uK16u2Qa4uM4K361/yknu0rs7kGjCoDZdQVE=;
 b=Xef2tZWW4P8NGORIAR7WnueEwveaNdAXsFClTsGAl0yiFX4tget6kBm+0i8ix9DYsA
 KXH7PcHxI9ah2K/Qjq7ySnwwyxz5xQduznpZFjd1psD2uNJ2gKf72cOZL0bezAfFrjvb
 uQRySV+IB5Ru8iLY8mp64K3P1Wt2A/PXcnmaaXRjddnaIMOYRk56TS4uJrPEqX3fyHSX
 4zr95dV8bjYah9ooqv3fgvelb7rpnv44z9TSf0fOT53CAUpnI4RU+VVh1EZro2QO0T0k
 VGmRQ143tVRuyWgtFv6/9XgEkrvVqOecRwTww36ytVrX88znnWZBveQPEZ1J19gQy+7v
 5KXw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772632459; x=1773237259; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lJWA8F8Fxnn1rli1uylq1S8dOlBhWu2ZtTc/9dJQ5M4=;
 b=XmgfOXpI0jxSkws262DcDtxukmGNjacp+0B0cs9gZxiqH9occuLp+iS0ZF8uO7HCmm
 44Woxi8JuLjdQd/uiYgmZYx0oKb9E2LZtFVegyr9szVpz9xLMPOmjb6RqHSU45Sk5cTX
 CRPTPWOshu9IJnhkfJ2lx8bR+uv3hvpRjuBO6ed3FDpqjRsZh9MOgJ6XVt17vhzQMmkf
 UP0Z55wO9hw6WCWZJlAxTGzBHXpulTezPgTOH82hY1OtZqoj1/h8TQhk4nKpwjiim/yG
 vyuSzTCPFQ77cmXiUaqbTvcfVrXH7/KOPgIACl0yF1vVhS2GZ24YLbjRue4LS+AU6/3V
 FpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772632459; x=1773237259;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lJWA8F8Fxnn1rli1uylq1S8dOlBhWu2ZtTc/9dJQ5M4=;
 b=xPemgpcA8NMDDQNJUkcbCMF8uYLNnEZZMDnN6iCgrvmHehwIwlOd7DIWlfGIsowO2l
 04I0j8lRIZgG35DXBkTe9ZvqgLDj1gPM6dJVzKNzp0tgMUctAc0r/GNCKjv//qNyJ9R8
 qtO23l6kyytUHLM026gtUX5/6KrzB+JkB2VPLLH8kquiX03L8759LMxJlPN7QlE83IAU
 NOYJcfAKnoePlA3kKQtdzXkmfW+Tv7Kjkrt0twIWMiuMtquffM6pyUkZW51cv10O0I6U
 fXvLWzTsqJXyDea1bLdbGSzHT9+w288yrVJ1G5ALpye0s39TlhOLZuXnthmdRMwBihHl
 6BmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmBn+fPQ85pIBn2dXzuByLX9GjfmJKlPssqKWPzUSSyqq3sUcOGW9347otLiDfskH/BSxjY/uAHjQ/@nongnu.org
X-Gm-Message-State: AOJu0Yw2ndcPBdz5u9/THMxEWTHDrONwXDGvYf8Mf2KMF78xJUg9wNP6
 y0gWnOY96GoZQ7UtFVNKsjUNCUyRXf3q6WaXFPRUFQhjLGs6Ko+kJRxFZzMxqCgGPcesHq/2WXb
 g37zupepxIGV2QgJ/OaSqiJ2+ppfahrN5iYUFEZPjSw==
X-Gm-Gg: ATEYQzxEeXMjaSDvcV3QbMq65Fl3GfQYRTV8LBnXtn0oEPWFEe6iA7Hj8qHj21iYxF4
 Ld2mflqUtE7/i/ArcNr/WRwMpyDbyVWggrT9+psuxC8V5BRdXCtNWzcpzHGlpD/BjEp5JDgqHGr
 c0TJ0vUY4g3qqryjoPwf7YPgH1KiZjJPGwhBULPPcKHx60qmeGuz2MSXPQamyGLhozGmCORjSlp
 n9ivtd39rxfG8okNzjvfjcybikbhQ6BdrBJDVR3vICGj6BcglJUHLWifYMKDu9CnXgJAdpoVRyi
 vAxjPSCzoxbnVW3qOjhHk1dxQ8MgoluOa+z5pIcy14M0l2bmLH0dxdnDIfwmUZckyNA=
X-Received: by 2002:a05:690e:12c6:b0:64a:d1a9:a64 with SMTP id
 956f58d0204a3-64cf9ba2e55mr1438935d50.55.1772632458775; Wed, 04 Mar 2026
 05:54:18 -0800 (PST)
MIME-Version: 1.0
References: <20260303222143.142741-1-shentey@gmail.com>
 <20260303222143.142741-13-shentey@gmail.com>
 <87ikbbixy5.fsf_-_@pond.sub.org>
In-Reply-To: <87ikbbixy5.fsf_-_@pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Mar 2026 13:54:07 +0000
X-Gm-Features: AaiRm53KWbc1dj0-NO-OsLLEnoU2Kn0i_aSJhEbsYzmgUg0kxK1ZM-7lwhHO624
Message-ID: <CAFEAcA_WYkAYccog-BiA6MJAvoFVwa6niKvFZ7UpLjzkRyd6aA@mail.gmail.com>
Subject: Re: QOM parent type "sys-bus-device" vs. "device" (was: [PATCH v2
 12/13] hw/char/serial: Inherit from SysBusDevice)
To: Markus Armbruster <armbru@redhat.com>
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org,
 Helge Deller <deller@gmx.de>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Steven Lee <steven_lee@aspeedtech.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Troy Lee <leetroy@gmail.com>, Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-arm@nongnu.org, 
 Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Wed, 4 Mar 2026 at 12:25, Markus Armbruster <armbru@redhat.com> wrote:
> We might be at a crossroads here.
>
> Paul Brook designed qdev around "a device plugs into some bus, and may
> provide buses".  To make this work, he added a main system bus to serve
> as root of a single tree.
>
> The parent of a device in that tree is the bus it plugs into, and the
> parent of a bus is the device that provides it, except for the main
> system bus, which has no parent.  "info qtree" shows this tree.
>
> Note a machine had just this one system bus back then.
>
> The system bus isn't something hardware people would call a bus.
>
> The qtree is a qdev thing.  It is *not* the QOM composition tree ("info
> qom-tree /").
>
> We actually abandoned "a device plugs into some bus" a long time ago.
> Moe on that below.
>
> Qdev was later rebased onto QOM, as follows.
>
> A bus QOM type is a subtype of "bus".
>
> A device QOM type is a subtype of "device".
>
> If a device type has a @bus_type, then it plugs into a bus of that QOM
> type.  Such a concrete device is commonly[*] not a direct subtype of
> "device".  Instead, it's a subtype of the abstract device that plugs
> into that bus type.  Example: "isa-serial" is a direct subtype of
> "isa-device", and it inherits its bus type "ISA" from there.
>
> If a device has no @bus_type, it doesn't plug into any bus.  It doesn't
> show up in "info qtree" (it does in "info qom-tree", of course).
> Example: "serial" is a direct subtype of "device".
>
> This lets us build devices from components without having to make up
> buses to connect them.  Example: "isa-serial" has a direct QOM child of
> type "serial".  Good!
>
> Except infrastructure useful to such bus-less devices lives in sysbus,
> where bus-less devices can't access it.  This tempts us to make devices
> sysbus devices just to be able to use the infrastructure, and to create
> additional sysbuses.

There is only one sysbus -- it is impossible to create more than one,
and there wouldn't be much point in creating a second one anyway.

> We can elect to go down this path further: make more sysbus devices.
> Create more sysbuses.  If this is the right path, then bus-less devices
> were a mistake, and we should consider eliminating them.
>
> Or we can pick the other branch: put the infrastructure where bus-less
> devices can use it.  If this is the right path, then sysbus is
> obsolescent.

I do think that at some point it would be good to move all that
stuff into the base "device" class, and drop sysbus. The real
problem, though, is reset. Currently reset propagates along the
qtree (the tree of buses). So something (like TYPE_SERIAL, and
also like CPU objects) that is a direct child of TYPE_DEVICE does
not get automatically reset. The major overriding reason why
(as it currently stands) I favour making things sysbus devices
and not plain devices is that devices that don't get reset are
either broken or need all their users to take extra steps that
most don't take, or do in a weird way. We can't just push the
reset handling into TYPE_DEVICE because by definition it is tied
to "being a thing on a bus, i.e. the sysbus".

Disentangling reset is extremely painful -- I don't even know
what it ought to be doing. Maybe propagating along the QOM tree?
So for now, we muddle along.

-- PMM


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D555C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 14:45:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tabxw-0005eI-JK; Wed, 22 Jan 2025 09:44:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tabxt-0005dv-OL
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 09:44:21 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tabxr-00043n-T2
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 09:44:21 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-436202dd730so51387165e9.2
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 06:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737557057; x=1738161857; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zqv4Qd6dT1zrxeh0XCQ19j4sNFX8EjY/Vg1k9cFn6OM=;
 b=dOxsl6kQ3RONLMZhq5RybUwYeDlGqVjuPVFpDAGjbmuiOPqQvlQyqX0Tm/mYu1JuV3
 iNO+9Me4qS780Yo+VslhmppJz0mb9R+uyYzxpGf8jUG6pesu/zZ7FpqUT7lL24ZT6sTY
 WALD5+hk6HnKDa7kMeWW9sTCJoHPa8mJIsBCV7NLr3zyjl49pCsW1T9ei1JhWsiaayNv
 PGFV8QYvBgx0ZKXGeqeXSlzbJJwip5N9HuSLZNrK85rbxBhn81nlWPBAKCICmNRKZSwW
 hWoQykWdYB4Krw4Jhrcu9BvBP0CZRxbZFd0+UOwPQMY7cqh2hfimwC5QUD4ZoGGiRhxF
 lzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737557057; x=1738161857;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zqv4Qd6dT1zrxeh0XCQ19j4sNFX8EjY/Vg1k9cFn6OM=;
 b=SqMCBIg/FGZr1iojPd1Ehb+8J8FYXHSTmJWDzNFHQYZBgkaJ8Ql/KSXwTTUdM0bN7H
 1kjYLZ4EsAkQ4S+j98QD5qSUq8FRFJlf1UsQ+kksHJKyiWS+yYI5aQ8mpTCYdG4Et+5G
 b55lOdR1wFjatLqtzkVGNObxlHjLooCSMIuuHv6oHj7UCrNx2CyHaDdchnFgcHNPO+lu
 jYiKd2X5IAZYjHG3gpqkppaqf0lctH6f48cXY48qpaPjU09w3MQWfDX1R4mqCtS90Onw
 zdRt5uUII66vh55TvnLp1rA+EZt8/iBY8X7O1WR/CS3MefvKOhOmxqWXXPV38gPdJmD8
 OZkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/huh9sIyVwPDOCv0+05JD8jqWwJlep2FNL44OyuV0KoWDGMcShW8jQmGVTNR27KWqB4sNsvXm1wFx@nongnu.org
X-Gm-Message-State: AOJu0YxxZOHjaeVgkxykS6qtgzYMrSuH7n3iAhR5xo7UsskvkhsqcDo0
 x1N14e57ldjwWHI7iMeFOnWX1ty0seo29T0b5fh78+kSHqK4lqhU+Jigd3tuEE3uxk0EFfDmlod
 f4v8=
X-Gm-Gg: ASbGncvFdd09UMi64Wp2YH+KMvk2CKMm5K2TJC/kuXTcsv6/2VJ8yXkFY5TiA7DGYa/
 7X9RsWA5ZCqDsWnN94YqGa9sUUUHE/gbuuAIFsYD+tDuzFf07277gWKwHzJz2nvXc1l9gco1BT5
 ow62tFe+6B7VR1iWkECxpRg1iSjhYaQIRgZ9NGs5zwSXlDRNy+Q6dBhaJUDKaBufUE83yYuOL/E
 zWPBpZN0UW9fchWTasm2jjjJMNIZ8ToL/ohZ1KnuY9aTysL4fDtFW/FNmflt6Tcqtrb
X-Google-Smtp-Source: AGHT+IFG0sP49UPuES5kPS0Jx5xQoV5wGyuh93Ktj8FGCxTBWgH801qccSs/TlTqbhsIhxgsaaO7Og==
X-Received: by 2002:a05:600c:524c:b0:435:306:e5dd with SMTP id
 5b1f17b1804b1-4389143a66dmr189137985e9.22.1737557056134; 
 Wed, 22 Jan 2025 06:44:16 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b318c325sm28507545e9.1.2025.01.22.06.44.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 06:44:15 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B3CB25F7AC;
 Wed, 22 Jan 2025 14:44:14 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Roman Penyaev <r.peniaev@gmail.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v7 2/4] chardev/char-hub: implement backend chardev
 aggregator
In-Reply-To: <20250118164056.830721-3-r.peniaev@gmail.com> (Roman Penyaev's
 message of "Sat, 18 Jan 2025 17:40:50 +0100")
References: <20250118164056.830721-1-r.peniaev@gmail.com>
 <20250118164056.830721-3-r.peniaev@gmail.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Wed, 22 Jan 2025 14:44:14 +0000
Message-ID: <871pwuoqm9.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Roman Penyaev <r.peniaev@gmail.com> writes:

> This patch implements a new chardev backend `hub` device, which
> aggregates input from multiple backend devices and forwards it to a
> single frontend device. Additionally, `hub` device takes the output
> from the frontend device and sends it back to all the connected
> backend devices. This allows for seamless interaction between
> different backend devices and a single frontend interface.
>
> The idea of the change is trivial: keep list of backend devices
> (up to 4), init them on demand and forward data buffer back and
> forth.
>
> The following is QEMU command line example:
>
>    -chardev pty,path=3D/tmp/pty,id=3Dpty0 \
>    -chardev vc,id=3Dvc0 \
>    -chardev hub,id=3Dhub0,chardevs.0=3Dpty0,chardevs.1=3Dvc0 \
>    -device virtconsole,chardev=3Dhub0 \
>    -vnc 0.0.0.0:0
>
> Which creates 2 backend devices: text virtual console (`vc0`) and a
> pseudo TTY (`pty0`) connected to the single virtio hvc console with
> the backend aggregator (`hub0`) help. `vc0` renders text to an image,
> which can be shared over the VNC protocol.  `pty0` is a pseudo TTY
> backend which provides biderectional communication to the virtio hvc
> console.
>
<snip>
> +static void qemu_chr_open_hub(Chardev *chr,
> +                                 ChardevBackend *backend,
> +                                 bool *be_opened,
> +                                 Error **errp)
> +{
> +    ChardevHub *hub =3D backend->u.hub.data;
> +    HubChardev *d =3D HUB_CHARDEV(chr);
> +    strList *list =3D hub->chardevs;
> +
> +    d->be_eagain_ind =3D -1;
> +
> +    if (list =3D=3D NULL) {
> +        error_setg(errp, "hub: 'chardevs' list is not defined");
> +        return;
> +    }
> +
> +    while (list) {
> +        Chardev *s;
> +
> +        s =3D qemu_chr_find(list->value);
> +        if (s =3D=3D NULL) {
> +            error_setg(errp, "hub: chardev can't be found by id '%s'",
> +                       list->value);
> +            return;
> +        }
> +        if (CHARDEV_IS_HUB(s) || CHARDEV_IS_MUX(s)) {
> +            error_setg(errp, "hub: multiplexers and hub devices can't be=
 "
> +                       "stacked, check chardev '%s', chardev should not "
> +                       "be a hub device or have 'mux=3Don' enabled",
> +                       list->value);
> +            return;

So I was looking at this to see if I could implement what I wanted which
was a tee-like copy of a serial port output while maintaining the C-a
support of the mux.

Normally I just use the shortcut -serial mon:stdio

However that form is a special case so I tried the following and ran
into the above:

          -chardev stdio,mux=3Don,id=3Dchar0 \
          -chardev file,path=3Dconsole.log,id=3Dclog  \
          -mon chardev=3Dchar0,mode=3Dreadline \
          -chardev hub,id=3Dhub0,chardevs.0=3Dchar0,chardevs.1=3Dclog

Giving:
  qemu-system-aarch64: -chardev -hub,id=3Dhub0,chardevs.0=3Dchar0,chardevs.=
1=3Dclog: hub: -multiplexers and hub devices can't be stacked, check chardev
            -'char0', chardev should not be a hub device or have 'mux=3Don'=
 -enabled
=20=20=20=20=20=20=20=20=20=20
So what stops this sort of chain?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


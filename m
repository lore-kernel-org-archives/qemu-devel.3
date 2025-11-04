Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E047CCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 11:36:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGFK7-0005xj-HW; Tue, 04 Nov 2025 06:35:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vGFK5-0005xW-IH
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 06:35:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vGFK3-0001pr-Ho
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 06:35:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762256132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8s83MSfV0Su4f5IXr+31Ohf2SJY9Or71BWqG10OoDQU=;
 b=Dj1tO6GQhsM64821u9gDiYx06Qspe69vocBy8xjoLgfK4FIWiIZGNK4W1MxIqRMfA4nGYF
 y6SjYoJ6IwvaU6V71kMKOXxsIvanZ4J6qwUtAYw4NSsr/CQVwZoDC3dfHsYnaoYJvCbyir
 yTE1j3WuuZ1BAfRKX46UGlq18+0KTXE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-7w1X8TTMPIagfAfwcMFR6A-1; Tue, 04 Nov 2025 06:35:30 -0500
X-MC-Unique: 7w1X8TTMPIagfAfwcMFR6A-1
X-Mimecast-MFC-AGG-ID: 7w1X8TTMPIagfAfwcMFR6A_1762256130
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-294df925293so57192785ad.2
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 03:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762256129; x=1762860929; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8s83MSfV0Su4f5IXr+31Ohf2SJY9Or71BWqG10OoDQU=;
 b=BAsUu2aJBZb6zyT8uINYMoyQFajismUe4uBXiNzdjEzRNK52eBXJB1BEB+4k9dCzgU
 Se8D6UerwRXB51o+6/ajJPKXkB52oZpWuyousd0NFbFWLqcARrIhlC21WE/WwReO548f
 NvhWtdp8vKKrshPqgb4WWUwgVrFEFlk2N8Pq/M0A8jLa8TS/Ad0qKxx3mjjV3KHWh6Ju
 xc/xz0dgsQD68dvvu7hIQA2V+g328MZV6U8e6HtVQGzah+WFHs3Xr6W5eBC87EqCyUj8
 4G7cYZ3lxnHidMZgFn8BMeN/CrRkVM+RvYDCtFVS+lVYc6tPsQZ+wTpdIpDPgs4L5OXg
 pyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762256129; x=1762860929;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8s83MSfV0Su4f5IXr+31Ohf2SJY9Or71BWqG10OoDQU=;
 b=q/wpPpwH6PPwWEKNwjpflZC33EhDYPug08CF4rsdl1IZ+dun3hUcsBENVJ+dDwQZX6
 bSbB+mII2CMVn/Wf8lw1VPZorh+enAlC+4kx9KvEVZplmbeC7Gpq9xeTa9EmWsnX+T22
 eNhYtpIYuiQ0Fm9Rq43qS4BhAwwzJL+A5Wvit66Z1d3Pl+V1sX2rthWBedM3wzBDUex7
 Onl84ioRTX7Baq2HzXBSvrMz8MfR4vjhxngKYFzyeYzgCEI/ut2nOafEIu1jWmm3+780
 RuFpDUD8BHu5OTtJDSUmiPnxICPjItENflE1OtA0jtJobbCWV9+BbMyDIWsPOGn+5qP6
 NXNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0+QIhZekUUh2CTkoyGkOJMn7C1NdrWK0cP4Hg8qRWyTapErgCfilMHarQlIu91yHwgUz9SU+pvovv@nongnu.org
X-Gm-Message-State: AOJu0YymHn/IrlyCXjRbmrPl/IvBHhmjW6pfbEWs2cXYQsfTW/CpUAQw
 qHWWbjVObksnReVHXUExGKWui2QuxJWbgmxPR6RR8AO8r0xNVaxr7GDuj3AMh0i+elE9RjssUjp
 k3pmCe6mqRd+aMXfTayTcX7A9Hb9+QEkvCGcKOaaG5VE+erYMY4WLeYxzKL3ICaI8BbKojvayt5
 cqS10Qd6F9ACVCyNMKzndIRVSukW5N3N4=
X-Gm-Gg: ASbGncuka8ksaPIjuv1mRJqNfcTXtm1ycaXWv+3Gs9i2ThLgXRoHiKu5Oz6W8/ts2QY
 GvKm97JS7HfTz5F8SWuJhLdJXD6tTMd0kSyNoFbHHPODBQzVgNxOCoI88Ov/Hx5Sj5fpm73prsM
 QxAzkS2yqIo5YDqw8KhDtShiXrd7EFW8H8X4nMV7cAaut5DfGg+LFgFAOfb53oGBW9SrTbXuFIQ
 oQ/WRxXBw9D8i0=
X-Received: by 2002:a17:903:2c7:b0:26c:e270:6dad with SMTP id
 d9443c01a7336-2951a4fcb51mr176190525ad.60.1762256129689; 
 Tue, 04 Nov 2025 03:35:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEj8Tnpn7KkH1PLf0B25c7hBt/u6henGBV02WC/ixONPgzFybLwcXNLRzvQZTbVfKabnjsgM8ggX8PS2TNa2hg=
X-Received: by 2002:a17:903:2c7:b0:26c:e270:6dad with SMTP id
 d9443c01a7336-2951a4fcb51mr176190215ad.60.1762256129341; Tue, 04 Nov 2025
 03:35:29 -0800 (PST)
MIME-Version: 1.0
References: <20251104101715.76691-1-vsementsov@yandex-team.ru>
In-Reply-To: <20251104101715.76691-1-vsementsov@yandex-team.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 4 Nov 2025 15:35:17 +0400
X-Gm-Features: AWmQ_bkBgaV5x6bBbQfZqP2MEPwv0qGlPkhN3okQv1Bhk5Zg8Kfw1tqwe367W58
Message-ID: <CAMxuvazmJ+0fUDae-W4ZFFKAgtZLBFrxtZCrTT8sgBCmNirW2g@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] chardev: postpone connect
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net, 
 qemu-devel@nongnu.org, raphael@enfabrica.net, armbru@redhat.com, 
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Content-Type: multipart/alternative; boundary="00000000000097c7640642c33acf"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--00000000000097c7640642c33acf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vladimir

On Tue, Nov 4, 2025 at 2:17=E2=80=AFPM Vladimir Sementsov-Ogievskiy <
vsementsov@yandex-team.ru> wrote:

> Hi all!
>
> That's a preparation for backend-transfer migration of
> vhost-user-blk, and introduced DEFINE_PROP_CHR_NO_CONNECT()
> is unused now.
>
> v3 of "vhost-user-blk: live-backend local migration" is coming
> soon, and will be based on this series (and will use
> DEFINE_PROP_CHR_NO_CONNECT of course).
>
> changes in v6:
> 05: move connect() call into "if (s)"
> 07: - drop assertion
>     - improve doc comment, to cover @s=3D=3DNULL relations with @connect
>     - add r-b by Marc-Andr=C3=A9
>
> Vladimir Sementsov-Ogievskiy (7):
>   chardev/char-socket: simplify reconnect-ms handling
>   chardev/char: split chardev_init_common() out of qemu_char_open()
>   chardev/char: qemu_char_open(): add return value
>   chardev/char: move filename and be_opened handling to qemu_char_open()
>   chardev/char: introduce .init() + .connect() initialization interface
>   chardev/char-socket: move to .init + .connect api
>   chardev: introduce DEFINE_PROP_CHR_NO_CONNECT
>

Do you need this series in 10.2? We are at soft-freeze today, this is
closer to a feature than a simple refactoring, we may just wait for the
next dev phase.



>
>  chardev/char-fe.c                   |  22 +++++-
>  chardev/char-socket.c               |  64 ++++++++-------
>  chardev/char.c                      | 118 ++++++++++++++++++++--------
>  hw/core/qdev-properties-system.c    |  26 +++++-
>  include/chardev/char-fe.h           |   9 ++-
>  include/chardev/char-socket.h       |   1 +
>  include/chardev/char.h              |  30 ++++++-
>  include/hw/qdev-properties-system.h |   3 +
>  tests/unit/test-char.c              |  14 ++--
>  ui/dbus-chardev.c                   |  12 ++-
>  10 files changed, 223 insertions(+), 76 deletions(-)
>
> --
> 2.48.1
>
>

--00000000000097c7640642c33acf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Vladimir</div><br><div class=3D"gmail_=
quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, =
Nov 4, 2025 at 2:17=E2=80=AFPM Vladimir Sementsov-Ogievskiy &lt;<a href=3D"=
mailto:vsementsov@yandex-team.ru">vsementsov@yandex-team.ru</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi all!<br>
<br>
That&#39;s a preparation for backend-transfer migration of<br>
vhost-user-blk, and introduced DEFINE_PROP_CHR_NO_CONNECT()<br>
is unused now.<br>
<br>
v3 of &quot;vhost-user-blk: live-backend local migration&quot; is coming<br=
>
soon, and will be based on this series (and will use<br>
DEFINE_PROP_CHR_NO_CONNECT of course).<br>
<br>
changes in v6:<br>
05: move connect() call into &quot;if (s)&quot;<br>
07: - drop assertion<br>
=C2=A0 =C2=A0 - improve doc comment, to cover @s=3D=3DNULL relations with @=
connect<br>
=C2=A0 =C2=A0 - add r-b by Marc-Andr=C3=A9<br>
<br>
Vladimir Sementsov-Ogievskiy (7):<br>
=C2=A0 chardev/char-socket: simplify reconnect-ms handling<br>
=C2=A0 chardev/char: split chardev_init_common() out of qemu_char_open()<br=
>
=C2=A0 chardev/char: qemu_char_open(): add return value<br>
=C2=A0 chardev/char: move filename and be_opened handling to qemu_char_open=
()<br>
=C2=A0 chardev/char: introduce .init() + .connect() initialization interfac=
e<br>
=C2=A0 chardev/char-socket: move to .init + .connect api<br>
=C2=A0 chardev: introduce DEFINE_PROP_CHR_NO_CONNECT<br></blockquote><div><=
br></div><div>Do you need this series in 10.2? We are at soft-freeze today,=
 this is closer to a feature than a simple refactoring, we may just wait fo=
r the next dev phase.</div><div><br></div><div>=C2=A0=C2=A0</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0chardev/char-fe.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 22 +++++-<br>
=C2=A0chardev/char-socket.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 64 ++++++++-------<br>
=C2=A0chardev/char.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 | 118 ++++++++++++++++++++--------<br>
=C2=A0hw/core/qdev-properties-system.c=C2=A0 =C2=A0 |=C2=A0 26 +++++-<br>
=C2=A0include/chardev/char-fe.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A09 ++-<br>
=C2=A0include/chardev/char-socket.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A01 +<br>
=C2=A0include/chardev/char.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 30 ++++++-<br>
=C2=A0include/hw/qdev-properties-system.h |=C2=A0 =C2=A03 +<br>
=C2=A0tests/unit/test-char.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 14 ++--<br>
=C2=A0ui/dbus-chardev.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 12 ++-<br>
=C2=A010 files changed, 223 insertions(+), 76 deletions(-)<br>
<br>
-- <br>
2.48.1<br>
<br>
</blockquote></div></div>

--00000000000097c7640642c33acf--



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0131D116F5
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 13:01:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ3Wi-0000kY-It; Mon, 01 Dec 2025 08:01:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vQ3WK-0000gk-Ox
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 08:00:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vQ3WI-000592-OZ
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 08:00:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764594045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h6vWgu7DzEpUN+5z8NnPxG7JQ7i1Kevp48aLJTg72yw=;
 b=RYarqSybJYBipAduXn9udGdHHUQyZGFblDw0i+3qybwDnjQZE1ct80UBfZcQbvDLyuQjYI
 0iRRQoOdQsIYIusUxuhBn1nbDgDAQAkRmVThafJpbgtXAXVdnJZUjqTcbvSBE4lj9S68MQ
 O5J7p3c6y1USiJKDYNQ5LRJZsB7GbeI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-icOK_d7sOzy3SQ_oVOhtoQ-1; Mon, 01 Dec 2025 08:00:43 -0500
X-MC-Unique: icOK_d7sOzy3SQ_oVOhtoQ-1
X-Mimecast-MFC-AGG-ID: icOK_d7sOzy3SQ_oVOhtoQ_1764594042
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-343d73e159aso8058136a91.3
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 05:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764594042; x=1765198842; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h6vWgu7DzEpUN+5z8NnPxG7JQ7i1Kevp48aLJTg72yw=;
 b=bFrfiXjjfjWscNKYk9Lcp6BtG5TscqQ0lt7lS1eHrTkx96LRqHSDyfysWH0mq4M+Cc
 Z59txGmZbUp9nGZm2CvVgUq9pVuoZ0/TFOe9fdoYt3nBYTbQKDaVasYiTNS5xdo6016u
 i5Lrqn+Zl+8z/XKnJYEQr2WGbwWQ0MUpK1vZZGG8KYa3i76pzwBXRkdK11vwtZ0vp/cI
 pIP+4UJ8SLyDD1H0DmZ6pqWuOWpK/aoJcbDqvHdZ61+Rpfh9z30NurF4LANrAWADSZgv
 Y5x3axJg1pjnDWeeRgjL2r+NwSWA5e35tVviaVfRrgi63S0pgtO9ZBF7Jx5cHGcyJfB9
 XP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764594042; x=1765198842;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h6vWgu7DzEpUN+5z8NnPxG7JQ7i1Kevp48aLJTg72yw=;
 b=hrhZ2pcpUYVTe1g/brtgFDzm9KaC2EiCuGyLq8Gz3cgzxcPWGiM8D9iZBga/vkzdB1
 ojveHRD7y83gZ/vzCmT9YsmLOX+x53DSTCR57xty3h8xzj4MlMbDRvf1QTxyjO3Zj0k4
 K0UStBYaICjAVulTkxJCm/nWi9KA7za0RUttTNwTZoCW+tDByuoq2mXlPnDksYTjPR/Q
 i9VNGPanPXK4Tsg3sqyPRF2LRASRulH0E0Et5F7F/KCFA/dJGn7wmp5kowGfK6bXkyx5
 yZseCBRhZUHDh0N4keUZkpfVx1VzYEwckOanAtF1gQB7CIqNpuwS6vgrPOCUS7t4K5p2
 fqqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVcPHTABpJPGXM8PLGBzk6q6bAmCn1oPEwRSYzDLT18XhCMztjUvYXsoSWcmETA6OjRSc5NpPPw0CN@nongnu.org
X-Gm-Message-State: AOJu0YxdVPy0DJ9X2pVxO+HfbamEVgp44CEDgWbgoktta+W2UslqeUm3
 3IQvh+pmqgdaJecUtFH8IZYAte/TvyMIvj+3IpH96WXLmU73LaV36dAO9tEgS6Bqkf8d9dfde72
 DJiT4yZaMeSq2WjgSAEf9l/oZ9SfVzf/SBoaIz80T6QGiwba/OjSqK2LwTL8KBZHPbyjFmYrX5P
 Pow9maayvxbuGtBJl2BRrqfNQmEUgoHcs=
X-Gm-Gg: ASbGncvxZicJPawNKnGT55Y+ksTP7ZnAtATP9zPXcmXKeOxsLdsI/DgenRL+RQSE8CR
 FN0OPS5Zg3pGiZNYKyDhgT+4/K/53okqBzPZ5kqOXdpa5XV5XlHxY/FIXqbAJPg7s2X7B6dQRw9
 cAXqwkodsztWaKGYvY1pa5mwHp7rdX5fjq3LYAR2Aixb3qZAcMkz6te21SLHbGfEaqCwTw77Xka
 etva3HpNO53nG/nkAtY0WPdBQ==
X-Received: by 2002:a17:90b:53c3:b0:33f:ebc2:634 with SMTP id
 98e67ed59e1d1-3475ebe8173mr22321226a91.9.1764594040398; 
 Mon, 01 Dec 2025 05:00:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3LSWmQnY8SLoOSa7C7W9i9usN5UP9SjD91v8ZDBuXX5p1LY4aIf3PHFgvvKEOGXLOMmxqXIyUECplxEMfW8I=
X-Received: by 2002:a17:90b:53c3:b0:33f:ebc2:634 with SMTP id
 98e67ed59e1d1-3475ebe8173mr22321198a91.9.1764594039803; Mon, 01 Dec 2025
 05:00:39 -0800 (PST)
MIME-Version: 1.0
References: <20251129134350.487839-1-vsementsov@yandex-team.ru>
In-Reply-To: <20251129134350.487839-1-vsementsov@yandex-team.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 1 Dec 2025 17:00:27 +0400
X-Gm-Features: AWmQ_bme_sBEs8fx043anzN-nqpTCHuwLXJzSB6Ct_25vE4zf2JU-gi1ADHPX3I
Message-ID: <CAMxuvayCqRwWJyni5KuG_J_DO0PVA3uNqKWsu2vFqm_R61UoWw@mail.gmail.com>
Subject: Re: [PATCH for-11.0 0/8] chardev: cleanup
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, d-tatianin@yandex-team.ru
Content-Type: multipart/alternative; boundary="000000000000ea67690644e39047"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000ea67690644e39047
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Sat, Nov 29, 2025 at 5:44=E2=80=AFPM Vladimir Sementsov-Ogievskiy <
vsementsov@yandex-team.ru> wrote:

> Hi all.
>
> Here is a cleanup for chardev code:
>
>  - improve naming
>  - add boolean return for some errp-functions
>  - simplify open() API
>
> Vladimir Sementsov-Ogievskiy (8):
>   chardev: ChardevClass: consistent naming for handlers
>   chardev: consistent naming for ChardevClass handlers implementations
>   chardev: .chr_open(): drop be_opened parameter
>   chardev: .chr_open(): add boolean return value
>   chardev/char-pty: store pty_name into PtyChardev state
>   chardev: introduce .chr_get_pty_name() handler
>   chardev: rework filename handling
>   chardev/char: qemu_char_open(): add return value
>

Except 3rd patch, lgtm. (it conflicts a bit with "[PATCH v3 00/10] chardev:
Improve @docstring and clarify qemu_chr_write() uses
<https://patchew.org/QEMU/20251112134143.27194-1-philmd@linaro.org/>"
though, I guess I will handle that)


>
>  chardev/baum.c                                | 12 ++--
>  chardev/char-console.c                        | 10 ++--
>  chardev/char-fe.c                             |  8 +--
>  chardev/char-file.c                           | 26 ++++----
>  chardev/char-hub.c                            | 27 ++++-----
>  chardev/char-mux.c                            | 30 ++++++----
>  chardev/char-null.c                           |  9 +--
>  chardev/char-parallel.c                       | 41 ++++++-------
>  chardev/char-pipe.c                           | 30 +++++-----
>  chardev/char-pty.c                            | 52 ++++++++--------
>  chardev/char-ringbuf.c                        | 20 ++++---
>  chardev/char-serial.c                         | 39 ++++++------
>  chardev/char-socket.c                         | 59 +++++++++----------
>  chardev/char-stdio.c                          | 30 +++++-----
>  chardev/char-udp.c                            | 16 ++---
>  chardev/char-win-stdio.c                      | 25 ++++----
>  chardev/char.c                                | 51 ++++++++--------
>  chardev/msmouse.c                             | 13 ++--
>  chardev/spice.c                               | 50 ++++++++--------
>  chardev/wctablet.c                            | 10 ++--
>  gdbstub/system.c                              | 12 ++--
>  hw/char/xen_console.c                         |  7 ++-
>  hw/misc/ivshmem-pci.c                         |  4 +-
>  include/chardev/char.h                        | 37 +++++++++---
>  .../codeconverter/test_regexps.py             |  2 +-
>  ui/console-vc.c                               | 12 ++--
>  ui/dbus-chardev.c                             | 16 +++--
>  ui/dbus.c                                     |  4 +-
>  ui/gtk.c                                      | 14 ++---
>  ui/spice-app.c                                | 18 +++---
>  ui/vdagent.c                                  | 17 +++---
>  31 files changed, 354 insertions(+), 347 deletions(-)
>
> --
> 2.48.1
>
>

--000000000000ea67690644e39047
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+SGk8L2Rpdj48YnI+
PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRy
Ij5PbiBTYXQsIE5vdiAyOSwgMjAyNSBhdCA1OjQ04oCvUE0gVmxhZGltaXIgU2VtZW50c292LU9n
aWV2c2tpeSAmbHQ7PGEgaHJlZj0ibWFpbHRvOnZzZW1lbnRzb3ZAeWFuZGV4LXRlYW0ucnUiIHRh
cmdldD0iX2JsYW5rIj52c2VtZW50c292QHlhbmRleC10ZWFtLnJ1PC9hPiZndDsgd3JvdGU6PGJy
PjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHgg
MHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRk
aW5nLWxlZnQ6MWV4Ij5IaSBhbGwuPGJyPg0KPGJyPg0KSGVyZSBpcyBhIGNsZWFudXAgZm9yIGNo
YXJkZXYgY29kZTo8YnI+DQo8YnI+DQrCoC0gaW1wcm92ZSBuYW1pbmc8YnI+DQrCoC0gYWRkIGJv
b2xlYW4gcmV0dXJuIGZvciBzb21lIGVycnAtZnVuY3Rpb25zPGJyPg0KwqAtIHNpbXBsaWZ5IG9w
ZW4oKSBBUEk8YnI+DQo8YnI+DQpWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5ICg4KTo8YnI+
DQrCoCBjaGFyZGV2OiBDaGFyZGV2Q2xhc3M6IGNvbnNpc3RlbnQgbmFtaW5nIGZvciBoYW5kbGVy
czxicj4NCsKgIGNoYXJkZXY6IGNvbnNpc3RlbnQgbmFtaW5nIGZvciBDaGFyZGV2Q2xhc3MgaGFu
ZGxlcnMgaW1wbGVtZW50YXRpb25zPGJyPg0KwqAgY2hhcmRldjogLmNocl9vcGVuKCk6IGRyb3Ag
YmVfb3BlbmVkIHBhcmFtZXRlcjxicj4NCsKgIGNoYXJkZXY6IC5jaHJfb3BlbigpOiBhZGQgYm9v
bGVhbiByZXR1cm4gdmFsdWU8YnI+DQrCoCBjaGFyZGV2L2NoYXItcHR5OiBzdG9yZSBwdHlfbmFt
ZSBpbnRvIFB0eUNoYXJkZXYgc3RhdGU8YnI+DQrCoCBjaGFyZGV2OiBpbnRyb2R1Y2UgLmNocl9n
ZXRfcHR5X25hbWUoKSBoYW5kbGVyPGJyPg0KwqAgY2hhcmRldjogcmV3b3JrIGZpbGVuYW1lIGhh
bmRsaW5nPGJyPg0KwqAgY2hhcmRldi9jaGFyOiBxZW11X2NoYXJfb3BlbigpOiBhZGQgcmV0dXJu
IHZhbHVlPGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PkV4Y2VwdCAzcmQgcGF0
Y2gsIGxndG0uIChpdCBjb25mbGljdHMgYSBiaXQgd2l0aCAmcXVvdDs8YSBpZD0iZ21haWwtMjAy
NTExMTIxMzQxNDMuMjcxOTQtMS1waGlsbWRAbGluYXJvLm9yZyIgaHJlZj0iaHR0cHM6Ly9wYXRj
aGV3Lm9yZy9RRU1VLzIwMjUxMTEyMTM0MTQzLjI3MTk0LTEtcGhpbG1kQGxpbmFyby5vcmcvIiBj
bGFzcz0iZ21haWwtc2VyaWVzLXN1YmplY3QiPltQQVRDSCB2MyAwMC8xMF0gY2hhcmRldjogSW1w
cm92ZSBAZG9jc3RyaW5nIGFuZCBjbGFyaWZ5IHFlbXVfY2hyX3dyaXRlKCkgdXNlczwvYT4mcXVv
dDsgdGhvdWdoLCBJIGd1ZXNzIEkgd2lsbCBoYW5kbGUgdGhhdCk8L2Rpdj48ZGl2PsKgPC9kaXY+
PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4
IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVm
dDoxZXgiPg0KPGJyPg0KwqBjaGFyZGV2L2JhdW0uY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIHwgMTIgKystLTxicj4NCsKgY2hhcmRldi9jaGFyLWNvbnNv
bGUuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHwgMTAgKystLTxicj4NCsKg
Y2hhcmRldi9jaGFyLWZlLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoHzCoCA4ICstLTxicj4NCsKgY2hhcmRldi9jaGFyLWZpbGUuY8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfCAyNiArKysrLS0tLTxicj4NCsKgY2hhcmRldi9jaGFy
LWh1Yi5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfCAyNyArKysr
LS0tLS08YnI+DQrCoGNoYXJkZXYvY2hhci1tdXguY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIHwgMzAgKysrKysrLS0tLTxicj4NCsKgY2hhcmRldi9jaGFyLW51bGwu
Y8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIDkgKy0tPGJyPg0K
wqBjaGFyZGV2L2NoYXItcGFyYWxsZWwuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgfCA0MSArKysrKystLS0tLS0tPGJyPg0KwqBjaGFyZGV2L2NoYXItcGlwZS5jwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8IDMwICsrKysrLS0tLS08YnI+DQrCoGNo
YXJkZXYvY2hhci1wdHkuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IHwgNTIgKysrKysrKystLS0tLS0tLTxicj4NCsKgY2hhcmRldi9jaGFyLXJpbmdidWYuY8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHwgMjAgKysrKy0tLTxicj4NCsKgY2hhcmRl
di9jaGFyLXNlcmlhbC5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8IDM5
ICsrKysrKy0tLS0tLTxicj4NCsKgY2hhcmRldi9jaGFyLXNvY2tldC5jwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8IDU5ICsrKysrKysrKy0tLS0tLS0tLS08YnI+DQrCoGNo
YXJkZXYvY2hhci1zdGRpby5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
fCAzMCArKysrKy0tLS0tPGJyPg0KwqBjaGFyZGV2L2NoYXItdWRwLmPCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8IDE2ICsrLS0tPGJyPg0KwqBjaGFyZGV2L2NoYXIt
d2luLXN0ZGlvLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8IDI1ICsrKystLS0t
PGJyPg0KwqBjaGFyZGV2L2NoYXIuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIHwgNTEgKysrKysrKystLS0tLS0tLTxicj4NCsKgY2hhcmRldi9tc21vdXNl
LmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHwgMTMgKystLTxi
cj4NCsKgY2hhcmRldi9zcGljZS5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqB8IDUwICsrKysrKysrLS0tLS0tLS08YnI+DQrCoGNoYXJkZXYvd2N0YWJsZXQu
Y8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHwgMTAgKystLTxicj4N
CsKgZ2Ric3R1Yi9zeXN0ZW0uY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIHwgMTIgKystLTxicj4NCsKgaHcvY2hhci94ZW5fY29uc29sZS5jwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgNyArKy08YnI+DQrCoGh3L21pc2MvaXZzaG1l
bS1wY2kuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIDQgKy08YnI+
DQrCoGluY2x1ZGUvY2hhcmRldi9jaGFyLmjCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCB8IDM3ICsrKysrKysrKy0tLTxicj4NCsKgLi4uL2NvZGVjb252ZXJ0ZXIvdGVzdF9yZWdl
eHBzLnB5wqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgMiArLTxicj4NCsKgdWkvY29uc29sZS12Yy5j
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8IDEyICsrLS08
YnI+DQrCoHVpL2RidXMtY2hhcmRldi5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqB8IDE2ICsrKy0tPGJyPg0KwqB1aS9kYnVzLmPCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCA0ICstPGJyPg0KwqB1aS9n
dGsuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIHwgMTQgKystLS08YnI+DQrCoHVpL3NwaWNlLWFwcC5jwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfCAxOCArKystLS08YnI+DQrCoHVpL3ZkYWdlbnQu
Y8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHwgMTcg
KysrLS0tPGJyPg0KwqAzMSBmaWxlcyBjaGFuZ2VkLCAzNTQgaW5zZXJ0aW9ucygrKSwgMzQ3IGRl
bGV0aW9ucygtKTxicj4NCjxicj4NCi0tIDxicj4NCjIuNDguMTxicj4NCjxicj4NCjwvYmxvY2tx
dW90ZT48L2Rpdj48L2Rpdj4NCjwvZGl2Pg0K
--000000000000ea67690644e39047--



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDAFE9E305
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 13:38:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqAPC-0002n9-EL; Wed, 11 Feb 2026 08:37:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vqAPA-0002mm-G3
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 08:37:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vqAP7-0008Rc-2i
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 08:37:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770817035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qd7nm8qxOkE+F9KPOP3qjaaC0X9mVSTZ4G3T8UhCNAU=;
 b=Uv5ljQWk/oRk7Vj4NxZ4ORhDbf6i7XD8ZFCYUDbotMR3rTJB+EyPW3Z1lFYc5icisrhJgS
 emIIsqeAqrIQzNFu8SW784reX6HGN5V3b+bLGjkkmax7jF6JH104gfcxqAnAhsl1NUlVLd
 4R3N/JXxkmA0UrKHGfHPJQPiigchJ/0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-SwUEfFTJMFGJejoL7kDD6A-1; Wed, 11 Feb 2026 08:37:12 -0500
X-MC-Unique: SwUEfFTJMFGJejoL7kDD6A-1
X-Mimecast-MFC-AGG-ID: SwUEfFTJMFGJejoL7kDD6A_1770817032
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-352e195f662so1819684a91.2
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 05:37:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770817026; cv=none;
 d=google.com; s=arc-20240605;
 b=V6WNewh/vf6XNurQ3qc9nzvvYa0B9pKc3G7k2vHFaD8S7Xq3FYQQ3k20si2AkqelRQ
 tueG5QyPWbhoPicL+oQKI6YDDVA3al8goCEoNuJjBLeW7juBISpFpnUTJWETtCPQA9PX
 WGqaUaJMbVUXcOBp4k+GfWlQbco92CR80GTO60XcUs8Wiv5+u+Nt0PnayQ63AkAPaAnN
 rmQbsX+3Q2ZLu6sccoPUbfhRPzN5gPrq00vGal16fOcY7JRHdaNkgTGXeDdaN7Sf3OO5
 ykj3IB8Yurpsrtbdx6WmwT4v52V6Q+XtUuXCtFCHyppQlnsFKyYv/NXJ98VxqHlTPOlR
 +RLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Qd7nm8qxOkE+F9KPOP3qjaaC0X9mVSTZ4G3T8UhCNAU=;
 fh=z0j5MyrxVSGV965D58u+Eukz9LbcdxT3IRRT5ZoRgaI=;
 b=kRtWUkW4o/vh+B901w/IFSXWy4nQCGr56sL3vNBum0+N//USUHAgZf89UzbdtYYdCh
 HEgdukcyQhdXEzRW3ab7bsCF7AnHXwJUlW9vmZqFjCxH72ZqcChWryRiMzH9v/ar9PdS
 8P0HYiRqbKrfVejxajqtMezlZjydMzYxgYqgCtDOnw2NSF/KRba3sx/uf29OpOflkooS
 crfhoWU+YV7xiYrovoGOfbxauqBmWXrs7jSuRvAiavTyScRfVM1BMaT/IhB2UC3zl29y
 1S9ZvRceOa5uj2piOCkmuStrowX+THUVy3A2LDgfmwE3F4H7lrVSshD1gLKDAEC7KFAj
 1BHQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770817026; x=1771421826; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qd7nm8qxOkE+F9KPOP3qjaaC0X9mVSTZ4G3T8UhCNAU=;
 b=bGFJl6l3nyBFKwtfY/vQwz6jXmLnyN1CXYr8Xmwp/uQFIdkCkMDFhxifWUPFvKRH8W
 yrvMg7nFGbL95uIC7hvpbBDGauD0UoaHJbff6NAdZ9gjBdb1PfExSeDPxQAD5DciFX+8
 PbxRsrUyeJmCy9WyZDDYipMs+uHa37qBoZr++/f4eHrbmYVxkKDp7ZV3kBpU4DdVjo7k
 Fe8mIII21BFjtMJ9qs18hGunYahUAlbP1XXJzRYhUFSylVCO9hN7MpwRuWCA0uij4d//
 9+wvP2W1nuzCy8xfwYRbJ+9PwHATQeq93HC2ux5DiszD+RUgGk1foZl/LWIqyScyuMct
 6CPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770817026; x=1771421826;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Qd7nm8qxOkE+F9KPOP3qjaaC0X9mVSTZ4G3T8UhCNAU=;
 b=pmN5AIfAwqTib5UCyr589HGxYL99X1Z2iZLIqV+hAX0rTOI5zxdXOQ7jrj8N3ErMYC
 2dit38DOZ110YmNmiGe2STe+53z0fcsWotwyfeFkp7yytECf68Ek8h9cfFjF1/sbvHLn
 h6KjcFUe26lep6cSPRp3NSxyZVGZuX1ANreewfDO0PKmBcdCgb+YIzUD4jtmBGlkwaoa
 rVElkxykBe4FxDEEc3Y6UaYJK6b6a6ABUs6lRFyPTiAKVvfpcgW/HDAbHZoOKIJpYLrW
 iQ/tBjP6onIwhebm5pBCixC18MQVqYFTluJ0O0rSaDhuRD427J4gkrEfjliXh8eyJwGM
 NAaQ==
X-Gm-Message-State: AOJu0YwKzbboquL8jCBSsq+rvKD7IFWilKIUuKpcIlmn/WsCraKTmHnd
 EhgJsFa1NhqMAWmAF9rV8wmPM2nN2qF5wMaPIzSCY7zcNuXN6zfvyffGy88vOQiAeqIAToIiRGM
 KMVu/UNCpu06Xdt6qovcdVGH67jll95tvrVzBIkToOpoZQV1WWk9RFa4astx2rWgoTRRrtnCW/Y
 pisiLz3UrGA4Vu2gpXgIAUGq8Hku4ygNM0os35BW+OvByg
X-Gm-Gg: AZuq6aIGM9EZne8NchJPOU7w8chxGkClDtOc6SwKQaBk7j7qdPSP9weopNCzkEOtYXu
 CNmfzjKIeTfQvuK664AAwfvnGS67PgIB8riHJghW2b5Fyw1wFPTjunlW8FV9n3eyyAGk+iB10Wl
 s2+SUiMAiWSW6MdPJa8mPMNJaNoWJjUcv+RZas1OehKiv2aK/yUz3yhYzru7sKrBnVvQUzbQocK
 fY1sssdSMczqx/hVhe2d2FUfb9PfDjXSUdNmA==
X-Received: by 2002:a17:90b:4a08:b0:354:b2f6:b4e4 with SMTP id
 98e67ed59e1d1-354b39da597mr13879217a91.0.1770817025654; 
 Wed, 11 Feb 2026 05:37:05 -0800 (PST)
X-Received: by 2002:a17:90b:4a08:b0:354:b2f6:b4e4 with SMTP id
 98e67ed59e1d1-354b39da597mr13879193a91.0.1770817025223; Wed, 11 Feb 2026
 05:37:05 -0800 (PST)
MIME-Version: 1.0
References: <20260211123007.3569932-1-marcandre.lureau@redhat.com>
In-Reply-To: <20260211123007.3569932-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 11 Feb 2026 17:36:52 +0400
X-Gm-Features: AZwV_Qir2RaHBkpvZhNqpXRKdUvNAJhrkTkAMwaplDprCUWzZblhGrIatsOqekc
Message-ID: <CAMxuvay6yd0434Bv3id3gsKezxaX8C=s-RBHLR306hoE5B=SFw@mail.gmail.com>
Subject: Re: [PULL 00/14] Char patches
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, xen-devel@lists.xenproject.org, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Anthony PERARD <anthony@xenproject.org>, 
 Eric Blake <eblake@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi

On Wed, Feb 11, 2026 at 4:30=E2=80=AFPM <marcandre.lureau@redhat.com> wrote=
:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> The following changes since commit 0b91040d23dc8820724a60c811223b777f3bc6=
b7:
>
>   Merge tag 'pull-loongarch-20260210' of https://github.com/gaosong715/qe=
mu into staging (2026-02-10 09:12:38 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/marcandre.lureau/qemu.git tags/char-pull-request
>
> for you to fetch changes up to 72913e8b8ef10071965d43349516d0e7f19a959d:
>
>   chardev: add logtimestamp option (2026-02-11 16:27:18 +0400)
>
> ----------------------------------------------------------------
> chardev patches
>
> ----------------------------------------------------------------
>

self-nack, it failed win32 compilation:
https://gitlab.com/marcandre.lureau/qemu/-/jobs/13073244313

> Eric K (1):
>   char-udp: Fix initial backend open status
>
> Vladimir Sementsov-Ogievskiy (13):
>   ui/spice: Require spice-server >=3D 0.15.0
>   ui/spice: drop SPICE_HAS_ATTACHED_WORKER macro
>   chardev: ChardevClass: consistent naming for handlers
>   chardev: consistent naming for ChardevClass handlers implementations
>   chardev: .chr_open(): drop be_opened parameter
>   chardev: .chr_open(): add boolean return value
>   chardev/char-pty: store pty_name into PtyChardev state
>   chardev: introduce .chr_get_pty_name() handler
>   chardev: rework filename handling
>   chardev/char: qemu_char_open(): add return value
>   char: qemu_chr_write_log() use qemu_write_full()
>   error-report: make real_time_iso8601() public
>   chardev: add logtimestamp option
>
>  meson.build                                   |   2 +-
>  qapi/char.json                                |   6 +-
>  include/chardev/char.h                        |  23 ++-
>  include/qemu/error-report.h                   |   6 +
>  include/ui/qemu-spice.h                       |   6 -
>  chardev/baum.c                                |  12 +-
>  chardev/char-console.c                        |  10 +-
>  chardev/char-fe.c                             |   8 +-
>  chardev/char-file.c                           |  26 ++--
>  chardev/char-hub.c                            |  27 ++--
>  chardev/char-mux.c                            |  30 ++--
>  chardev/char-null.c                           |   9 +-
>  chardev/char-parallel.c                       |  41 +++---
>  chardev/char-pipe.c                           |  30 ++--
>  chardev/char-pty.c                            |  56 ++++---
>  chardev/char-ringbuf.c                        |  20 +--
>  chardev/char-serial.c                         |  39 ++---
>  chardev/char-socket.c                         |  73 ++++------
>  chardev/char-stdio.c                          |  30 ++--
>  chardev/char-udp.c                            |  18 +--
>  chardev/char-win-stdio.c                      |  25 ++--
>  chardev/char.c                                | 137 ++++++++++++------
>  chardev/msmouse.c                             |  13 +-
>  chardev/spice.c                               |  52 +++----
>  chardev/wctablet.c                            |  10 +-
>  gdbstub/system.c                              |  12 +-
>  hw/char/xen_console.c                         |   7 +-
>  hw/display/qxl.c                              |  23 +--
>  hw/misc/ivshmem-pci.c                         |   7 +-
>  tests/unit/test-char.c                        |   2 +
>  ui/console-vc.c                               |  12 +-
>  ui/dbus-chardev.c                             |  16 +-
>  ui/dbus.c                                     |   4 +-
>  ui/gtk.c                                      |  14 +-
>  ui/spice-app.c                                |  18 +--
>  ui/spice-display.c                            |  19 +--
>  ui/vdagent.c                                  |  17 +--
>  util/error-report.c                           |   3 +-
>  .../codeconverter/test_regexps.py             |   2 +-
>  39 files changed, 437 insertions(+), 428 deletions(-)
>
> --
> 2.52.0
>



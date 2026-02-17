Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4DEE68159
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 09:59:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsHrH-0000ag-2q; Tue, 17 Feb 2026 04:59:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vsHr0-0000Wv-RK
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 04:58:52 -0500
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vsHqx-0001Ke-9o
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 04:58:49 -0500
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-50336cffef9so35736661cf.0
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 01:58:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771322325; cv=none;
 d=google.com; s=arc-20240605;
 b=M+xh+v5PoNo7ncBNbq4cave1hE6upTG3s2snhbEK6W7c5IYWJchRssv31tvtJGOmBH
 pSmKBHzewIHr8mdSPFTxytUqHuBv+dK2ObrZZBQLZGORmfSrhuSGP4tcPENiEFszCQzy
 4bL4ykTQcJoiTGOKgZG/ES+JrgeEaK9vdr+kU87X0/dl4wAkA7FSY8sxnObU1oXPmvf3
 diRKJCJycWV4+qqC7hqA/5Fts6n98dT/ZRjZ/z7kKLpiENxQSzFeJh0yS38//Teezw1W
 CvsMqQQ+K3ggr7eE2SCeN7ZOpO8VsL4I6Ub3tBGHVFZuCnf7Iw+LMy0X3Ju5jZt80zPG
 kexw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iYMu7tv6gTB+om556T/2z3xYcm/ZazW3bs7SOqSiJJw=;
 fh=rWAlG7a1BiEttu50XauJMXD+5ngzyLxdqQmsIIKWUkI=;
 b=GdU0MCdvJ0YjR4kfY+FqfUT53IKkBfLR09jVuv/vS2p7KDDWYzmP+6Z1SXS/wjDvTL
 4wrKS524sc/VMOU9uXU4zV9m6OIZLhKA1oQr+KK440J+MD5Tq5KbYEJoCGe1TTcWVenR
 Iqa7GiAcM6joPmr47Z/VFQB8O0FcH+FqfjOsqYEAWoPZzva4Z1yyD7+odUgaDR8QS9me
 aD97+JszGu6KZ579MRGHfktEj8voJ+stIrX1+M+yPJKr6Grku8CpxzYp7JVQXygR7JoY
 bupjvEEOU243xbuyMGx2eu9rnogRlGJDi5RXsgFiDOWHnouY1/BknGsxhCBurGQXT8L+
 nf+A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771322325; x=1771927125; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iYMu7tv6gTB+om556T/2z3xYcm/ZazW3bs7SOqSiJJw=;
 b=e2Qn6Uqa/BBSQkQxRZOCcTquuDGdEG+zhYNejMlD/XFikmXW+gbc57AHu78wfEYbjM
 UIuxGHF70vB8BedaGgPqH2w/3EdA12pqMOlngXkIaV/oogGIuqv/fj3PeHnsEaVQGf0z
 aW+DQJCiWjrQWslyHWdD6WKtnOhqkmRFDgpkNfk9MUUe2pKmI5YIDswxKhHlBvIjpQod
 KvvLHtR5/e67Tcboequ4oLs0npRdp8TcFsnUir0dI/tLO1SVFQgFO60+TtqMiPh2h20z
 eEyXpGU5O6nu/6k4QOi+bYqv5Qu/Qf8Y0RSAlMUz0AmnMZ6wLFthoU51SKFMq0iQ+TYf
 4hyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771322325; x=1771927125;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iYMu7tv6gTB+om556T/2z3xYcm/ZazW3bs7SOqSiJJw=;
 b=hImjFKkrECI79ZWZH7kCiwZwzf7N4zrrqMhEoWUeONJGOf6lGKrgqHRWGQKcAoFTxb
 BnB1jw5WCIja5P5shq3H42bWXKduVRrPX+nIRQTLpeQhRIUMaz/NXVgI+hYYEdYqid/l
 A0MrWeUPZVb5y3c1eamIPnRXC1Gcyd+eEsfsed6e0W9yOfsnyyiw3pl7z0qoKu4r4T8E
 1LAqiqgkIh1S+icACUFgQ/VgfeZGzJZgcaJOxOqOthdaOsTRxkzU1327ToBuELsLLxN/
 fr+zTEVYY+hJ3pLRs0UhVpX54b4CE6mPH6eSKxHtIma2XZnhmSoiZTseI+xu7vSThpE7
 jYVw==
X-Gm-Message-State: AOJu0YxL6vYwbgHtNBLhsBt6lck5Zn7W+HJjzvmHLHBwSfOWCg4ElztV
 E/mSuJQjJvYvnEPKAuk2hizVOOfjSg+0VPsLC5ydVDmvS7fhGZz777si9aVUMXgb1GFL03lMqcT
 jbB+CC85mD7puQRJQiRB4iR9ZCDSSgjiSKkzCD/0JTZIN
X-Gm-Gg: AZuq6aLzbx0wzJ9Wn7oAmXpa82qRqRRY3vPO2/k6rEk/WejwekEL/dH+Uzaau0/wQxV
 TceV0Mc//4oBxetGRFCdE2dIoirr2ZIj7cWTaF9cysIfTiykLesJZjsrTKVetJbZ+bMsSc5GzkQ
 S98hWO+UVYm1HTHJgHRgxz/mOnTBg/B15V5146XLER0F+yROZiaXSyFJzDlzs8Vq1M5GmGEc6ng
 yEWF6UcoO+HEOM5Ty7XaCrEezk0bofVkbmmTIowfloXjsDLIuYc2qtxZJUPI79RRkm6z6IMbsMg
 RGCbGtN7E2tKXkdFCjVrwAbnjmdmRXooGsp0eSXc
X-Received: by 2002:a05:622a:44:b0:506:20bc:f66a with SMTP id
 d75a77b69052e-506a6a4ca91mr187340291cf.34.1771322325186; Tue, 17 Feb 2026
 01:58:45 -0800 (PST)
MIME-Version: 1.0
References: <20260217052740.114117-1-heifetz@yandex-team.com>
In-Reply-To: <20260217052740.114117-1-heifetz@yandex-team.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 17 Feb 2026 10:58:33 +0100
X-Gm-Features: AaiRm51apQjPkMhiR-vKkiH2Kw6Y6rOyDpbof5vZVe3XpL_Z2oER89P4mo7bkO8
Message-ID: <CAJ+F1CJRG5yReEGmCvrvJ-P07U2T0p9YNXHx=iq+WdMPZBZ=mA@mail.gmail.com>
Subject: Re: [PATCH 0/8] add build option to disable audio subsystem
To: Sergei Heifetz <heifetz@yandex-team.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x835.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Sergei

On Tue, Feb 17, 2026 at 6:28=E2=80=AFAM Sergei Heifetz <heifetz@yandex-team=
.com> wrote:
>
> This patch series adds a compile-time option to disable building
> audio-related sources (mostly, files under `audio/` and `hw/audio/`).
> It adds `--disable-audio` and `--enable-audio` options to the
> `configure` script. Audio remains enabled by default, and the changes are
> harmless in that case.
>
> When audio is disabled, it may not be possible to build a number of
> devices and machines. This is expected, and can be addressed on a
> case-by-case basis if needed.
>
> This feature may be useful in production environments which only use a
> specific subset of QEMU=E2=80=99s functionality and, in particular, do no=
t need
> the audio subsystem. In such environments it is generally beneficial to
> avoid building unused code, for both security and maintenance reasons.


I am planning to send a PR for "[PATCH 00/85] audio: cleanups & add a
manual test" soon, could you rebase your series on top?

thanks




>
> Sergei Heifetz (8):
>   audio: add `audio` build option for meson and Kconfig
>   ui/vnc: disable audio feature when configured with --disable-audio
>   tests/qtest: remove -audio none when configured with --disable-audio
>   hw/audio/pcspk: change PCSPK behaviour with --disable-audio
>   Kconfig: add AUDIO dependency to audio-related devices
>   system/vl: remove audio and audiodev options when audio is disabled
>   audio: do not build audio-related sources with --disable-audio
>   meson.build: ignore audio drivers when configured with --disable-audio
>
>  Kconfig.host                |  3 ++
>  audio/audio-hmp-cmds-stub.c | 28 +++++++++++++
>  audio/audio-stub.c          | 35 ++++++++++++++++
>  audio/meson.build           |  5 +++
>  configure                   |  4 ++
>  hw/audio/Kconfig            | 21 ++++++----
>  hw/audio/pcspk.c            | 14 +++++++
>  hw/usb/Kconfig              |  2 +-
>  meson.build                 | 83 +++++++++++++++++++++----------------
>  meson_options.txt           |  3 ++
>  qapi/audio.json             |  3 +-
>  replay/meson.build          |  9 +++-
>  replay/replay-audio-stub.c  | 16 +++++++
>  replay/stubs-system.c       |  6 ---
>  system/vl.c                 |  6 +++
>  tests/qtest/libqtest.c      |  2 +
>  ui/vnc.c                    | 31 ++++++++++++--
>  17 files changed, 215 insertions(+), 56 deletions(-)
>  create mode 100644 audio/audio-hmp-cmds-stub.c
>  create mode 100644 audio/audio-stub.c
>  create mode 100644 replay/replay-audio-stub.c
>
> --
> 2.34.1
>
>


--=20
Marc-Andr=C3=A9 Lureau


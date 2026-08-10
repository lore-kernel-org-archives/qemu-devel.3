Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCAF2C5AD55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 23:54:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtZpD-0006n1-U0; Mon, 10 Aug 2026 19:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wtZpC-0006mi-6r
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 19:54:34 -0400
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wtZpA-0006nl-SX
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 19:54:33 -0400
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-51c0ecfaee7so16188761cf.0
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 16:54:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786406072; cv=none;
 d=google.com; s=arc-20260327;
 b=Cs4GjLrvZvHPV00JqHhz1G4gCdDAcvJpAf2Bn1m1/u1M9Ry4jgQ/VVNUWmMBg2ApGg
 lLKX2JWquTRRM47YTZsiDyB2prrwBk+rOuSgMQEatzhR1EnKFDj9eOvC+wpzV7o/Ufa6
 170CHQtQYAuLigoZQQlmJitzA5tS9UrrLsQ0ko1fDt4XCS/1+IpJbxninmpXdKtLyHS6
 cW8P2a+HwdoTVsWfOMBayBFnQcbU9HSO7awmvUW7Mv/M5U9bCSRYsZyVbmlrx9fAcaPI
 t0UgMh358B6y/+FEyATYLRLe/ZFDT4/DzmindA4av7eG+syyKDrtzgZ86fVrGrgiZZlP
 ubYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nq9yccxUs/kr8RrWpDcEE5cMK15U5ZnX0pXbLqC7Eqo=;
 fh=zAf9Wul48xkTrIs6bAeEfpaQhknOU2iSq1CvwgfZtyM=;
 b=LpN6+Wa72jdn7semLwutAn2QsOKf/7Y2upir7aEyitwNazbl49v0UJv7f8X2LdeCpW
 fQvapTLL8C7wt08KTbbVwuEvt5Q9ktK2tbmiEzpktUj0XqX6D2u7flFOitVLeFYwb7x3
 Wv8pyfYMCI8rb0sAvuPEkfzL0j79NvYWEKZp0l6K3U2U7yakEihr6r1EnLU1e0EpWZ0e
 NsTz6bzz/5sIMn1eAD8B2s/ZRqiO8FYrt5lK/B2qrsTfzxkBy9t9lpV6UWczViUNaMlC
 s5yWEe8uABjvnSdvgL+kW5F7nyWmS7TmUVcufHnIaQ63KH/XRKx/A6XAS6jmNMb4vDHn
 mrcQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786406072; x=1787010872; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nq9yccxUs/kr8RrWpDcEE5cMK15U5ZnX0pXbLqC7Eqo=;
 b=Xmuvr46U6xIL0+qpJGV1j1IZeaZITrCLHUKsZcwZW/XTH3n7Z6HIZbb7cksjU0Mf4K
 tWzsn5VUr9cb/2CqKoOxM1h7u6w1jlvoNiXmXISs/gkUWEmtraSdx0Gp1NVOhIxHBJnH
 +TOn57yu8bXUcESNgAvcfOt9dqsGaEv2Yhk7iDKZyhfFOzfBRXawWAt+Oxv2QhUc/6CG
 hE7M5HD9BkwVYahCWoFTcdD2x2fgtP75EahsTGFkOSJK6zQutqKuHnuOX20Se29VqiVF
 PHUp1pz+njxQpeaRhcvJxdlDBcfllQtkMFqZY2PK0qSndiHeMdnUCIYPGwCBl4dg9F+S
 u8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786406072; x=1787010872;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nq9yccxUs/kr8RrWpDcEE5cMK15U5ZnX0pXbLqC7Eqo=;
 b=BABnQJJJ1xjiHYjsK+onvpjmGM5AvJfTCWATdnBfomvLyV1UZWYylygAt7PxP8rrU2
 Cr4JkY1/0LfLhmC+UexJsTQ+AsdHPW5s0Vb+VkPuYULbQiplp9i3PWiuRDqfPA+ocn9n
 ZMwOQhOMdCTXLaTUbcT57AYr5kcJNZk1+uF2hWVdvB+GqBPQb7NKBOPV/i8NtzTN5iNt
 r7SS8w0qRe0mhWPEnhxsbci1pJwt57kcW3VtK3XbTngVHy3m0r+8n0n0TJMgvds15jx3
 EHuV1LApx8QOYrwYqBYwlwC5tVkBQn7qFr1mhKtrOwNHB/hQ1389pqJDwNHKMkW+SQmz
 ogqA==
X-Gm-Message-State: AOJu0YxLQ9cNgeaRvlZcB3/lsNRCPpvkYXcj+/EMnCnDy2+yDxMlnuyW
 oi6+orN4trpJVMKLTXypNdl7iQcQEdPSm8JTaRacBwQAELMGoKHqOurwawpEewnpInvp5QQa6iE
 1Uf5kb20QiCpvMlwYm9Z8klnM+tESrLw=
X-Gm-Gg: AR+sD10ifLgL5/GqXkhkEDM1BS0RoC06Ax1BX9uuK2JJNb8xfkSakutNNUtxVimWmd6
 nqtGk6CcLUAuX2RFcftHY6RedRj7EVGAtSGxPvSYAC8cYOpund/IKeTwY4saR+3OiAkmyEsSJ8n
 rmx1NlQzORRTtJQrsixFZ0YsTT/tJ8BxlCAegjzFmmBtjF6uRvHGJE3RV+ypyR4/DaRpvpAIx4N
 mbjVninVfPiydCYD7ZsZQnStZfQ1sgrIkfrVocitMjbvXbuedsYdttm2hCQo1FoNb9qxMLTFKrK
 HJHmjb491++DBZZ78GG47FAee0gAyhqMJnTtM8mWgSVihaGeO5RRe68BEp18sUSOMQ4Cx1ospgd
 DGUQ=
X-Received: by 2002:ac8:7fd6:0:b0:51c:1bb9:137f with SMTP id
 d75a77b69052e-52d4c0e990fmr62676311cf.24.1786406071606; Mon, 10 Aug 2026
 16:54:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-13-6b97c439eb28@gmail.com>
 <82cd1e6f-85f8-409d-9214-00c696fbdcae@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <82cd1e6f-85f8-409d-9214-00c696fbdcae@rsg.ci.i.u-tokyo.ac.jp>
From: Connor Kite <connorkite@gmail.com>
Date: Mon, 10 Aug 2026 16:54:20 -0700
X-Gm-Features: AUfX_mxGOP5dGxvbLn4sLop8Z_8XlVgjEM0ILnF5bv1b-7DqCdw9mdRSoiuqfm4
Message-ID: <CA+spn3pBnL4BokUKcp2uQCH3vfW4v3mYAuzwx3Ppnv4vutuHmw@mail.gmail.com>
Subject: Re: [PATCH RFC 13/15] hw/virtio/vhost-user: add shadow virtqueues and
 eventfd intercepts
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Raphael Norwitz <rnorwitz@nvidia.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org, 
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=connorkite@gmail.com; helo=mail-qt1-x82b.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Jul 24, 2026 at 6:45=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
>
> This is not undone in case of errors.
>

I've added event_notifier_cleanup calls to the errors here.  As Hanna menti=
oned,
I have svq_cleanup added in a later patch but should probably pull it
forward.  I
believe that currently doesn't clean up notifiers, so I will be sure
to do that as well.

> > +
> > +        if (svq->hdev_kick.initialized =3D=3D false) {
>
> Simpler: if (!svq->hdev_kick.initialized)
>
> Regards,
> Akihiko Odaki
>

This is now simplified.

Thanks!
Connor


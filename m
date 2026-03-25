Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC1DFFEA830
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 08:49:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Juv-0006cu-BX; Wed, 25 Mar 2026 04:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1w5Jut-0006cb-H2
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 04:48:43 -0400
Received: from mail-dy1-x1334.google.com ([2607:f8b0:4864:20::1334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1w5Jus-000618-2q
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 04:48:43 -0400
Received: by mail-dy1-x1334.google.com with SMTP id
 5a478bee46e88-2bdd40d3c61so4196304eec.1
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 01:48:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774428520; cv=none;
 d=google.com; s=arc-20240605;
 b=SFyVcabq8DcskmR8XL3DIncoIY8wW7sj+40MYqqf5ymt8kO1j/dWL8RaXxs7R+vomS
 rX1VQgkgYCKWu9uas2gBwvqIJorbP+4lmwrC1x6mv5MNKSrbMwBg4Ds/+2oC/FL4JYDY
 ZCeig5mTz4KGccYRv0m1qy767tNR+yeokjkmlmTr/WmAWLxNOzkHOOsL+fZ8dMeWaNEf
 SiTcJcq7u6BfmVM86iPrGzwPQzPSohIIbjb1CQgu6EGWbGVHrIJDWd7fdlCpMjaMNpae
 LVo+HAqxpeCSw5ZAAeXzyKNdsjmqcviwB2M1QqfyBxGm7/JC1u4IkVavD4upHLk7myqW
 IinQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DOM7A/cowGxFaZpzuxHUL2ncHjNI21h5zBoxUZ6IMbI=;
 fh=cYxV0GB8duKZjiCyJgY5KAoFLN3x0Ja4a6uRmwJ0LWs=;
 b=Yrj49idfToEVDHQfhXsdhIa29DGG1IhxSVboj/l72gr0qVNOUJpvPRVtbnptEUafob
 fmn9rh1/aobagwvJFePAE9XzXv+KMb4SUGJlKJpB52Yw4kuquFlJydlpVzRd7RkkVEqB
 lg42G8PGjl1E6glXuMVkrJeMnycOCVOI3+5W6sw2jtp1hwqLh9N5HM9226ygk5vYJZAJ
 kof3WYz5QE+hI6jGUXAxOwOWt3TTWj7PgzhXwgDbPTzcD0t3O4TS8NgQNqvQj/Rg3E6U
 7oDOhCn4W03qnckaeU5bNnL82JEtvX43rdXrXqyM68QDjhHT/9f69A0eFi6I7/cyGPFF
 AUNA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774428520; x=1775033320; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DOM7A/cowGxFaZpzuxHUL2ncHjNI21h5zBoxUZ6IMbI=;
 b=ON3zM89Ds9fJjbxECb8laTOqQ/yiuKLXg7U4BQgR7SGXpDABZ8nGwmG1LniEitmIeo
 BA38BjkivOgNQ4kCKgSwz+OmaCkmEKYj++MiQuWR5DKx3UrODocR3QHLjKchn5h9L1SY
 c1qCpPqO0WhjaBSGFo9iAhNCZIKKSxnrDEl06kyTFlbKiRTuQ1AlrmAKqHJKVb7SRYdI
 OTzrX0OLwpqs+IPAjsRQBMtV6KnGSIaL4MKfpOCNW2m7z5t1U6eYJd2QqhynKbSXFJM6
 YelDIdQOpDGHL/pLSg8KNDhAwg3WHrhp8x7fWw3szQUG7E3Ja5diTRPjwfrXFPYRNAbv
 zy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774428520; x=1775033320;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DOM7A/cowGxFaZpzuxHUL2ncHjNI21h5zBoxUZ6IMbI=;
 b=SmxajkgWXQGs4JuBjzz9+B9WAdw9TQp4SrRCcR/+M3J853do+JiPK3MzoTVosVQUR6
 xe1x/eblmSSxBBNYQ+2hrlelKWGkxZtcw/90EZfGI0yWV4OFSJBtcfIZ42zi2P4Uztbx
 mm3xnrSJEx8HVflDPMVDGrEuWwXuYtvmIi/8gs/Nfp855cA74Y26HbqVojh/4avIc5Ep
 uAKmjuxPmunjbzL+kFVfAg7SS7ZcBGCAj4dwDtGkHmao9J1qrLM9fj1csObRs1xHpQ6a
 AZaufG8xV5FtUTT6UV4WPhHxG4AGnNKO2c2QY4PG6fKSvd2SC6iTqUvIGMYiIVfQPLi4
 WxIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDUxserOWz7kUTM4NGM/Py9dbfzxk694uQs1RUuHDrW3iJDuIUb1O2KuFs/kQP6laMBatnbd0WAUsw@nongnu.org
X-Gm-Message-State: AOJu0YzPbOCj23x+TO1cmvFUtm1tAiZUDtIK/4CiihIiL3PogrWzHoRO
 8H28NasOkItW4gJ/PZAwICjBr75mK0bwE//zRYK7bfaxdhYVb5TOCULtsbom5tT1VZ2NJisxyaK
 SQfP9/FA8V0NmeQ7Suu/PbEJwfdxDFdQ=
X-Gm-Gg: ATEYQzzhWywfT6OWBp2ssno5Xwgm9UyCRTebKC967NQxyZ+kbVGCgYbtwZ8j4qQiySn
 u5v0D88AKh4VFP62rwsccxxXCAD5HN+uwziKw8ZU5Ol8P9tZc+/GKnWYZqt/aZimuL7VsYuI57K
 FzMUcWlSNPmSHW5T81hWE9I+P2rEr4j/ZeDz2SObF+96zaOQEFY1NmZOGQ6Uc7NN9hlaQ/ri1B4
 7rX08GPui5f6Ctel054yMtf6n/e2m10+DUG/qt5bMGfvTZC4rT3igBpSWLoPu805uDT8v12gohX
 2cuOt8JWxp2RqAOGZE5dYHuwoXHpTDfCNAD/qOexsUZ1kCsqfA==
X-Received: by 2002:a05:7300:fb87:b0:2ba:6c38:c79e with SMTP id
 5a478bee46e88-2c15d3c9361mr1528340eec.28.1774428520410; Wed, 25 Mar 2026
 01:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260310235632.3987668-1-rkir@google.com>
In-Reply-To: <20260310235632.3987668-1-rkir@google.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 25 Mar 2026 12:48:28 +0400
X-Gm-Features: AQROBzD0Ggz3BRUKPm73W7EZWzjTsOrX6xowsBg6-17Z0hJV95hpsI8TguYUqxE
Message-ID: <CAJ+F1C+RpfArHJBi_KdGjuUro=+GVn-=AnKjTJj07s3ocg1cPA@mail.gmail.com>
Subject: Re: [PATCH 0/3] virtio-snd: snapshot prep cleanups
To: Roman Kiryanov <rkir@google.com>
Cc: philmd@linaro.org, manos.pitsidianakis@linaro.org, qemu-devel@nongnu.org, 
 whollins@google.com, jansene@google.com, jpcottin@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1334;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1334.google.com
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

Hi

On Wed, Mar 11, 2026 at 3:57=E2=80=AFAM Roman Kiryanov <rkir@google.com> wr=
ote:
>
> I am currently working on adding snapshot support for the virtio-snd
> device. While implementing the VMStateDescription, I noticed that the
> device currently retains more internal state than is strictly necessary,
> including unused fields and full transport-specific layouts.
>
> This patch series cleans up the internal PCM state to reduce the overall
> allocation footprint and simplify the upcoming snapshotting and migration
> handling code.
>
> Roman Kiryanov (3):
>   virtio-snd: remove the unused field
>   virtio-snd: remove virtio_snd_pcm_set_params from VirtIOSoundPCMStream
>   virtio-snd: introduce VirtIOPcmParams
>
>  hw/audio/virtio-snd.c         | 21 +++++++++------------
>  include/hw/audio/virtio-snd.h | 17 +++++++++++++----
>  2 files changed, 22 insertions(+), 16 deletions(-)

For the series:
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

--=20
Marc-Andr=C3=A9 Lureau


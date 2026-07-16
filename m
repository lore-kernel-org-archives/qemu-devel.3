Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25691C44515
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkHKc-0006H4-2j; Thu, 16 Jul 2026 04:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wkHKW-0006GD-6E
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 04:20:28 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wkHKU-0007IR-Nn
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 04:20:27 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-38e07ebd263so2264298a91.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 01:20:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784190025; cv=none;
 d=google.com; s=arc-20260327;
 b=EBYWAexfGYsjW5SkBUZXKYENw7/1NVGAb2y7qT5qGkGAUgwoF04X0s7h254ovxLCfw
 +ockxY42Kht8WX4UdzHI9conhAbfN+UznTVbPk/5MVmYYPP/Wkgann9z2yPUS7hz59N+
 fe+eeUVkGhm9bl1prk8bD6NFTGW96FoG7o4VNQzdAIpEwziyYol/J/anRhcKrUYXTkZ7
 lKvglhU9BLcoFa7KAY7i9JYNhNDkaz/aBbdqbmaQI8GgF5tE1oNL9a+0dqwzJh5JK/TA
 tMp9QmZ5etNdeWjHBuPfQVY2o018dh6s+4j0l+hHUCyAHbUwmVaDO/2vhF86aXX6wvTe
 cPPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QabQvq/l16JIP1F6Te1Ej1KxSZdpT4dBYEjWumWNQ4M=;
 fh=KnxVq+/dNMGR5XtbHr3cm7WMCtMcRbEU6z8PkW8LG2I=;
 b=WdbFaEgAM8PlF0rSngJgIm7DLDZ3cjNif4M9FE+ZGt+D4bM3qJ0UBLCsnJ3kEbUnct
 rEIAypF0bLQqS9Cg1PzfEwd8Fw7gKipTFYMSDeWuX1kaUjdvjyO7Ur7rRfTGJ2pCIAJL
 bCsVQsDtUarJoBWvJFwoMNDgU2CGUtG/b7D5Qv7GpDE1jWkmrspxswkpaL22g/GFzxLe
 ZdFSBjTIBlrRSX8nLHCRdAOFjf1DsvhFnTIfd2LTed6cwHcqxi6S6RVVxJ36UZ5AsHJ8
 g5Xsr5KRIiTcMbjf7CJAGXXPHqwknCIrMqeRa1YLpno9hVC8Vy3/T1jR0lk9y/CJk5ww
 POFQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784190025; x=1784794825; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QabQvq/l16JIP1F6Te1Ej1KxSZdpT4dBYEjWumWNQ4M=;
 b=sah5DGZrAaDjV6dQuBj39v4CGOwjm6+4GWrCv88Rtan/AyU4idVjda3ISF5YuRfGd6
 uWIl5jeGSteCz3/bTb3Kq9D6JnkYrgD8ecjKvuRD0mflB3GOtIuP/BxYL/uV/yaWRnse
 mCsKsHaHm8aodbj/mU8sKQfnZq+ZcSdvgRDn4PiwrlH8Me8890Zyw8XrdtkwIgaCjuc0
 8hjsutslucprH9eBZ9IoaaOE0MC50NS5efziNOGkpNuWhrmKFtNjb/mXcYbF9KTrHOYH
 doe3xPRkgy3CQI0PZ2B+jrAJUA/KJjuvgKptKMIXM6RguKBrXGtFN9QvfWFmfPfGtd8P
 c63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784190025; x=1784794825;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QabQvq/l16JIP1F6Te1Ej1KxSZdpT4dBYEjWumWNQ4M=;
 b=ipCDZO+E78ZZo3p9G9MoAU6IaaP6IJUJvWCqVDVddM5PnKClB30ZUTbCdlg8kFqBLL
 WyjTBtF7hgJR1/UeZJcrD4CCRP9HQ5deKn0hRh9zEjcpDYe9f3+IQ91rgIC5d4vgd8HQ
 v98kBt40qf8Goa8yB6oTpuXWSIT22b8HZSoCi5RftnS/yD4WvHZRHjfQhqCbtYb69Tun
 I/UlmrDI9GkQlJZPO+Glpps0CLYuJ3r4exWtfKLEjP0jwou5IYacIfQbnW6lKfOx+Xqt
 qBOf7+OY8gX3eOX7bgLLXUo0ZoeLn30Ad6LkAtTpNKbrmdb78Ag5GQspGnUfv81+tvtX
 +v+A==
X-Gm-Message-State: AOJu0YwVGizMemBPdBMSk3ledKXWfaiOn/0vHQU4nwyEzyeZiDP1CoLo
 5rl3LmRy+Ydhxh8yWDgMheRnBbGa1osRbQ2csrPmr+/U0HbRTJXnWYBkHAv8bQFNVPaJTxTDGiL
 xLyTxhbIlacoVBHOWVdPUD161PUpxTxc=
X-Gm-Gg: AfdE7ckTllUN5ghA7nlrv9+vT7h6KZHaYkqxCMeNzrusCHUmGvSH02XHCyjaHJVMR+1
 +YgfBzbP2QrXkZK4tX0xMgDkhIF7yIz5bAQI582j7Unxc8kzV0lskmoW8+YTnH+nvtHF3mZz0mb
 yBco7JWEzNJmlGAblpycH1RQr9mgHAdvTEMgAKkupfZ3Pjek7VIunhlLk1ymKOqBkrsli04mXrf
 0g20xGV0ssSTtZrchxkiiAIKDWalffZVXQrbwM4A9bfQ4KWeUqFznI/1ljqe2Cu7+1YlUmvJ4Vp
 4OBDxlc6JYRDibbRJIz1G8sPAVQr
X-Received: by 2002:a17:90b:4f42:b0:37f:c28a:de61 with SMTP id
 98e67ed59e1d1-38dc75fa2d0mr21404997a91.17.1784190024723; Thu, 16 Jul 2026
 01:20:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260715201055.2465320-1-marcandre.lureau@redhat.com>
 <25541fac-4e55-477c-8599-7e503bff31c6@rsg.ci.i.u-tokyo.ac.jp>
 <c625e54a-b7f5-41d8-8f2c-93bd31f662e4@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <c625e54a-b7f5-41d8-8f2c-93bd31f662e4@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 16 Jul 2026 12:20:11 +0400
X-Gm-Features: AUfX_myB8scKhGWEScU_z6GXkimOK5acn8YRtL8ae7Aq1D2n7O3JfaJB1nyNoYk
Message-ID: <CAJ+F1CKxAiu4+ckfmtN0OGRuX58MFoERDiMVJiRx+_WGG-WraQ@mail.gmail.com>
Subject: Re: [PATCH] hw/display/virtio-gpu: validate stride against width on
 scanout
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi

On Thu, Jul 16, 2026 at 12:04=E2=80=AFPM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2026/07/16 16:37, Akihiko Odaki wrote:
> > On 2026/07/16 5:10, marcandre.lureau@redhat.com wrote:
> >> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>
> >> Validate that the framebuffer stride is at least width * bytes_per_pix=
el
> >> in both virtio_gpu_scanout_blob_to_fb() and virtio_gpu_do_set_scanout(=
).
> >>
> >> A guest can set a very small stride while using a large width. The tot=
al
> >> size check (offset + stride * height <=3D blob_size) passes because
> >> stride * height is small, but pixman reads width * bytes_per_pixel per
> >> row, causing heap OOB reads. The leaked data is rendered to the host
> >> display.
> >>
> >> The check is added in virtio_gpu_do_set_scanout() to cover all paths:
> >> blob scanout, non-blob scanout and migration post_load. The additional
> >> early check in virtio_gpu_scanout_blob_to_fb() rejects invalid blob
> >> configurations early.
> >>
> >> Fixes: CVE-2026-63109
> >> Fixes: 144bd171c837 ("virtio-gpu: Support blob scanout using dmabuf fd=
")
>
> I cannot resolve commit 144bd171c837. Apparently the bug was introduced
> by commit 7b5574225429 ("hw/display: check frame buffer can hold blob").
>

oh yes, that was an earlier version from a development branch, thanks..


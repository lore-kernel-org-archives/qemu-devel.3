Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C7BC44501
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkHVh-00005r-VE; Thu, 16 Jul 2026 04:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wkHVd-00005b-3a
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 04:31:58 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wkHVb-0000Kb-Lz
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 04:31:56 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c96b08cdd1cso4316675a12.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 01:31:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784190714; cv=none;
 d=google.com; s=arc-20260327;
 b=ZFM+MvX/z63q8Y4SwI3fVD4Fga/ILH1ozU7goTV9HtBdAK7tjVULQL6VncWJgskL2B
 MxDnkoyY7S74PNl8GEI6A2F09jH1InPkvWiO/vpYqnZdlAe/u411Xq3Ts4ud7OK/4mWM
 fWhauHNHfPJNZLDDUSFoGydpifxUxlYJnX38RxJBZMKFq+FgRuBwJ54obVHe5PLxW+cV
 l+lzn3OiDfsCACRDN0H1BOva/Qyg80WWHlEp98c9vOr5Jxp1VYCXzJEzopsPar95vvbB
 vXEgr/iqy8SDI6lKtCeSqp0xwxkcxgYaYLe7Dp0TC0xASvXFdJohyCTZRg0Md+ci3DHi
 P/kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yROQRcmsDh+lQyyYwu/CwkohZirvBeHYMVBnxhiac1w=;
 fh=KnxVq+/dNMGR5XtbHr3cm7WMCtMcRbEU6z8PkW8LG2I=;
 b=RhS76/7Apl+5Rw5n4Ds3gjE4gZem82FkQ7k9MWqG/1FkdZJ4NGaB7UWXiWXMddtjtl
 RfgNiVcYryECy4d9tzptVL31gwQJ2zpX9aUooYzGPgpXrv7D44ZgeabhvV9GWCmE+KEA
 ssa5OVBMXXA8oGTvT0K/tONnA8PF9upU72UqR9R4m/dXoEUAtPGZOciE051u+BJ8oA/3
 RQktGZ1lHZZPCEoueGKN8FB+AYpHATCcCPNYdHNu6MKFXoxZ0Z9qteNHqdZ7yw0WpS4+
 h7PM5B3vZwmH3v+LKHrtQ+0kAlZEN5b9k19FBEVKkY/A6md+SF63Aw/la/tQ2ABleIiP
 pIcQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784190714; x=1784795514; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yROQRcmsDh+lQyyYwu/CwkohZirvBeHYMVBnxhiac1w=;
 b=k32wc+Ha55G86dIncvxDwYo8z+bUdsCUwMFKTSkB52mgmPKK0yD2achfhyFD8WJxCc
 RFA7MCAdvBNuOMn+rCXmms0/pkRZyVqdFu06ChqpYPl4A+sOOi3uJICqumkESat4Bpwy
 1gkKSLIbkbav8t5urndCwqmotenfxkm0Dvqrjd/ot+4MheRLEA2KGoTm62twm7NoOy/s
 t2pt3sBCn51GApHMlaX9QHeZN8IaMWGbRwfgZqClPUHPAjCHH56EGA9Q3qLkKcO4su4H
 2i90gNuyqVFfG9rBJ6BuYfnOql+iGk3Z2fCwUYHbga6d8NC4ptL/0O6ZuPdFtNPmrIXY
 4i0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784190714; x=1784795514;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yROQRcmsDh+lQyyYwu/CwkohZirvBeHYMVBnxhiac1w=;
 b=bBMERcAIDvVxdmzCjWJXIJh3MoUVddc3Fia2ZxAco2lRD0eOi0Qavg9IER9d+YSOAb
 pZ1dOyD57J4nG39JjCgQ5hOYutqqaUkPMWK8JLrjuLDEw72WyExfFYlkbx12bEDmaRcS
 g4cAbo4po3oA1G9gzHyWVBPXSm8x6eINqH5bWqcuNabT1Qh8mB0dPF70i1Y2umPyj6HP
 qMea1VblxitqQIsfr3l3mHprzJpG6Zjhp69tR1vXdIFvANtRsMqKXqn0PIsrKNaHtKdC
 gKPXA83T9dTYGYLiTQ5TGqBw6sU9DOC+8PlF0KLCYuecrXhmkoXRnGI5pGLVbZ+sdwqg
 ag/g==
X-Gm-Message-State: AOJu0YwKarwRGIVhrccz5zhVzwsG/Z3b8shE3QajK92ExBoMGpibxiEY
 T0y9xIsxTE/FweqJM4Cpy2u3kdKuKwb1pRVaUU8J3RZ+0kuxc58U74MfRQnJDVB9qDh0xrlnThK
 hgvC6FS0Yle9M5XqxxVJ3+QFnyveCL9I=
X-Gm-Gg: AfdE7ckPNoDrv8pBTdIOfAlG1gfJCNS1l+g19MM9yAdi7L+mdiurLCgBv29YGBl5VAz
 ecpjpG/Q4227F+wddXOB0HVabDqqMZROhH+iYje37M9zOYueYTot/4IrERKI3TxDAvsJa3hugSA
 ggO/nIqtQKoJIPe1CYkbyd1PrdkJNElQyDLZGnSJT+T7elHA+NY+ntifdZv2i8RJy4eMJyyWc2V
 UAouVpYokuhlkuVZiv8DhikNahfBhEAIXm2WatV69nxhwijzk/MdQxkGJreLG5XqDULtfdnY2yf
 JnCm1Nfm5UW+IVoV0w==
X-Received: by 2002:a05:6a21:6d9b:b0:3b4:71a9:cd8f with SMTP id
 adf61e73a8af0-3c36c365548mr7182581637.41.1784190714185; Thu, 16 Jul 2026
 01:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260715201055.2465320-1-marcandre.lureau@redhat.com>
 <25541fac-4e55-477c-8599-7e503bff31c6@rsg.ci.i.u-tokyo.ac.jp>
 <c625e54a-b7f5-41d8-8f2c-93bd31f662e4@rsg.ci.i.u-tokyo.ac.jp>
 <CAJ+F1CKxAiu4+ckfmtN0OGRuX58MFoERDiMVJiRx+_WGG-WraQ@mail.gmail.com>
In-Reply-To: <CAJ+F1CKxAiu4+ckfmtN0OGRuX58MFoERDiMVJiRx+_WGG-WraQ@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 16 Jul 2026 12:31:40 +0400
X-Gm-Features: AUfX_mxpJcq_P0lPEo3tzUHkqIWmsCwZYoqPr_XidgYGCw4RbuEBDwKtvSTcko8
Message-ID: <CAJ+F1CJWnBcvGHYGPNRzCfKssHrxcKN2h30bhTVP=1gubMUy_w@mail.gmail.com>
Subject: Re: [PATCH] hw/display/virtio-gpu: validate stride against width on
 scanout
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pg1-x52d.google.com
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

On Thu, Jul 16, 2026 at 12:20=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi
>
> On Thu, Jul 16, 2026 at 12:04=E2=80=AFPM Akihiko Odaki
> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> >
> > On 2026/07/16 16:37, Akihiko Odaki wrote:
> > > On 2026/07/16 5:10, marcandre.lureau@redhat.com wrote:
> > >> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > >>
> > >> Validate that the framebuffer stride is at least width * bytes_per_p=
ixel
> > >> in both virtio_gpu_scanout_blob_to_fb() and virtio_gpu_do_set_scanou=
t().
> > >>
> > >> A guest can set a very small stride while using a large width. The t=
otal
> > >> size check (offset + stride * height <=3D blob_size) passes because
> > >> stride * height is small, but pixman reads width * bytes_per_pixel p=
er
> > >> row, causing heap OOB reads. The leaked data is rendered to the host
> > >> display.
> > >>
> > >> The check is added in virtio_gpu_do_set_scanout() to cover all paths=
:
> > >> blob scanout, non-blob scanout and migration post_load. The addition=
al
> > >> early check in virtio_gpu_scanout_blob_to_fb() rejects invalid blob
> > >> configurations early.
> > >>
> > >> Fixes: CVE-2026-63109
> > >> Fixes: 144bd171c837 ("virtio-gpu: Support blob scanout using dmabuf =
fd")
> >
> > I cannot resolve commit 144bd171c837. Apparently the bug was introduced
> > by commit 7b5574225429 ("hw/display: check frame buffer can hold blob")=
.
> >
>
> oh yes, that was an earlier version from a development branch, thanks..

I'd rather reference 32db3c63ae11 ("virtio-gpu: Add
virtio_gpu_set_scanout_blob") that introduced the issue


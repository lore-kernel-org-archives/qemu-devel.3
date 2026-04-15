Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD174F419A4
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 13:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD00l-0002hM-64; Wed, 15 Apr 2026 09:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wD00i-0002g2-IR
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 09:10:28 -0400
Received: from mail-dy1-x132d.google.com ([2607:f8b0:4864:20::132d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wD00g-0000Ne-NA
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 09:10:28 -0400
Received: by mail-dy1-x132d.google.com with SMTP id
 5a478bee46e88-2d52c7f92b1so5985244eec.0
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 06:10:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776258625; cv=none;
 d=google.com; s=arc-20240605;
 b=RuXGcOgMfPpMjpRPYYp6LKxkXzxyELGHS/w9kx6FsWTQj0gRTD9Lo5hE+WBPpsmrUN
 qXiBy+h6ZsEwFDYRKSqyIgXn/Wmz4Ms3XsoyWQUiM16mIVsnF5xJPuCAAoTmSvmV1g1D
 4eKiAS3lW/206sZ1A6wbtox21jTwmMnpwVnKsrwK7Lc5J9pmE1RegA5VNVDT7b/cPFcC
 6hATabRPu1M/8UvTZpOcA5r/EPq5uxXdjjJTJt1W0MmbiRzwK25xViKdIpDlqOaoH7Lm
 6cRaUQB+2BTlBlFusfgsHGGq3uPfd1KS1NJM/kEeUKjF/sYLrezFXLW7+aqVRZ74sghf
 fqpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BZIuC+Ka19PenuknxSmp6m/LwXW1y/APu3C1ALcXZaM=;
 fh=Rq361VBSSCpVwgpDpWmtmoS1gCbjr/aepb+Zsf4+S80=;
 b=Q3X0luOf4ZCt+9EgqmELk1GBKSC0hv6G8htJSLp/PbfBQGVjYzJ1h5tYDSEcR4/pEQ
 9cm/I3/VjLAWpPvsUJL7T+JQ+01OYUOL8mFTpfbdmrEY6IrptsoRnlI9w6doTLZjJJ+g
 YOV1UP11QoI1uvaWYSWlrVUvmbk21fNNZUCAuh1gERtTvoZz1KxG93ClEMLF/u1W20mA
 wQx3gbU2Z8AZeEUwF5I+yvpBaG7J/ALKSx+dJecN6l4RqZvfNF4jOAhm7DNxKy0xf1lp
 akiGQ6V0V9JliITJaSG7QqmANr+NTvcCfSg9s1UMziBaH5RORRQlHhlW4F6KB44JCX6O
 jOpw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776258625; x=1776863425; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BZIuC+Ka19PenuknxSmp6m/LwXW1y/APu3C1ALcXZaM=;
 b=eYy7e3j3uoeVGcnmufUceDxh/HWaa0+B5N0qAXl2E+YBYZmTmDT+P2dFG/tRv3Z21I
 ZS1Ij/PNX5+D60O+Tj3QgPuN2TA/57H/8L8K3bjorXEqq5Ky0cbofA73rpasHLlJzdRo
 kebpXbsRskDVKN5CCQ/6y8h4uB6w6vtHQJ+Pm87sLt+cr6QRVa2hFdXuQzf7Dr+p44uN
 Tjbf+iifq2KqrSr32176R7MtRFTKmD3+jkl1QglmZk7frMF7qLEr5v8B8RPRR7HQc0uE
 znZISbdlVHgA2tnmSHqh4wXW8I0cG6gw7frige8JfRoK2Om9u/kb+KyYtsVIrEUeiEat
 VKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776258625; x=1776863425;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BZIuC+Ka19PenuknxSmp6m/LwXW1y/APu3C1ALcXZaM=;
 b=hqdx1gKoSXC9ltg+AQRHWZvgHbOug7/ltllrvrTRL1E2BBCZD18OzmURD95OMWZD2K
 s+XS1vnc7eRIpTGcyqgB/havxT6/yi5RQpVTmwXMyrpRlFLSwpVZehRKu1pIy953CYo7
 eZpc/gkcjkT51IeFRyKhUzLFh/fQyKxP0Yie+4qeM3kodWnRjfyiEtjHpSni5YiOFNFj
 lUS9j1FAp9zmMNwItcfykNSZ3n00fWfOkr+sw4jutXKjte4hikrGS0g6fIrZtyc3fZeb
 YZCifUzAfw0lmFaVmGbn5y3FMP3jt4L7FiuTmFlZ9gE2kZV5tCxQ8BsARBZ1gKDhLCYa
 V6Xw==
X-Gm-Message-State: AOJu0YxGJr9/Z41nWthGWC1PiLYsTJSzms6xLOrSSgK6ZStugvB/9CVm
 jEnBpa4GN0CTVt+ysnbC58/KyS5Z6Gh7vTAaYISNlnZk4fGGY9V3Jp69Oq1+d3IANUZa08+OACp
 KJ9R+qb216KhdfnuhnOlpGnAXxhoPxJk=
X-Gm-Gg: AeBDietZLL8dJVJvV1YblhbWxrEc60qX+JhEzvKk0YeS1BppFr77ef5t84AyoMCXg2x
 J0VZJLyLf+wFT0DcHm9sithP0o6I1EOb31QjFIDcPEFC06yCePZZQhkKU9d+ibajhFwgHITKJ9s
 Qna5ipRx0iXw5cXe5CU07Y0jJ0OL3SVgnY2oEpfmCqnmGXnLSxHP0OBLHSljAB5/uG60Wloh/q0
 NxbT8d7LAFzFfnVBsAFnfH57zeaOQIid9sx1QuOz/FsuAjl7/1NP8DW0u4Re84PTeNYKVFLe010
 MXPU1MkLnty86QLaxACnNfIthI9QJDfVWgguAIJy
X-Received: by 2002:a05:7301:6788:b0:2c1:67e1:61c7 with SMTP id
 5a478bee46e88-2d587b83f71mr11081333eec.11.1776258624814; Wed, 15 Apr 2026
 06:10:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260409144639.3610-1-benno.fuenfstueck@neodyme.io>
 <CAJ+F1CKYu4UfJyFJxPYLe9gjQhOD9QA7BrTmBXSCPuCDFgPf1A@mail.gmail.com>
 <CAP-XHHCuVyP=21LyME1KmNB0heRDXAdq7QdCsoVomAK38ZRi7A@mail.gmail.com>
In-Reply-To: <CAP-XHHCuVyP=21LyME1KmNB0heRDXAdq7QdCsoVomAK38ZRi7A@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 15 Apr 2026 17:10:12 +0400
X-Gm-Features: AQROBzCnlqbLYQOQZW_jbtprnu39zJzjZpszUBENPZWrr1TvhztjU2P6KLK-XUg
Message-ID: <CAJ+F1CJPiXH2Sf2Tqz4QoHeP23bUpMdfi=cPsYYnGoGwWeKJ8w@mail.gmail.com>
Subject: Re: [PATCH] virtio-gpu: fix inverted mouse cursor
To: =?UTF-8?B?QmVubm8gRsO8bmZzdMO8Y2s=?= <benno.fuenfstueck@neodyme.io>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::132d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x132d.google.com
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

On Wed, Apr 15, 2026 at 5:01=E2=80=AFPM Benno F=C3=BCnfst=C3=BCck
<benno.fuenfstueck@neodyme.io> wrote:
>
> Hi Marc-Andr=C3=A9,
>
> On Mon, 13 Apr 2026 at 15:23, Marc-Andr=C3=A9 Lureau <marcandre.lureau@gm=
ail.com> wrote:
>>
>> Arguably, this is a bug in virgl vrend_renderer_get_cursor_content(),
>> since the function doesn't return y0_top it should always return the
>> data in the correct orientation.
>>
>> We may have a temporary workaround in qemu though for older virgl, but
>> I think it should be solved there too.
>
>
> Thanks, I didn't know about this. I submitted a MR to virglrenderer now a=
s well to fix it there: https://gitlab.freedesktop.org/virgl/virglrenderer/=
-/merge_requests/1611
>

great

> How should I change the patch to make it a temporary fix? Some kind of ve=
rsion gate (but not sure yet in which version of virglrenderer the fix will=
 end up being release)?

Since it is not released yet, it's acceptable to not have a
VIRGL_CHECK_VERSION yet. Just leave TODO comment so we can later add
it when virgl has the fix.

thanks

>
>>
>>
>> > ---
>> >  hw/display/virtio-gpu-gl.c | 20 +++++++++++++++++++-
>> >  1 file changed, 19 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
>> > index 2b7a41c466..4562d3405e 100644
>> > --- a/hw/display/virtio-gpu-gl.c
>> > +++ b/hw/display/virtio-gpu-gl.c
>> > @@ -33,6 +33,9 @@ static void virtio_gpu_gl_update_cursor_data(VirtIOG=
PU *g,
>> >      VirtIOGPUGL *gl =3D VIRTIO_GPU_GL(g);
>> >      uint32_t width, height;
>> >      uint32_t pixels, *data;
>> > +    bool y_0_top =3D true;
>> > +    int ret;
>> > +    struct virgl_renderer_resource_info info;
>> >
>> >      if (gl->renderer_state !=3D RS_INITED) {
>> >          return;
>> > @@ -49,8 +52,23 @@ static void virtio_gpu_gl_update_cursor_data(VirtIO=
GPU *g,
>> >          return;
>> >      }
>> >
>> > +    memset(&info, 0, sizeof(info));
>> > +    ret =3D virgl_renderer_resource_get_info(resource_id, &info);
>> > +    if (ret =3D=3D 0) {
>> > +        y_0_top =3D info.flags & VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP;
>> > +    }
>> > +
>> >      pixels =3D s->current_cursor->width * s->current_cursor->height;
>> > -    memcpy(s->current_cursor->data, data, pixels * sizeof(uint32_t));
>> > +    if (y_0_top) {
>> > +        memcpy(s->current_cursor->data, data, pixels * sizeof(uint32_=
t));
>> > +    } else {
>> > +        uint32_t *dst =3D s->current_cursor->data;
>> > +        for (uint32_t y =3D 0; y < height; y++) {
>> > +            memcpy(dst + y * width,
>> > +                   data + (height - 1 - y) * width,
>> > +                   width * sizeof(uint32_t));
>> > +        }
>> > +    }
>> >      free(data);
>> >  }
>> >
>> > --
>> > 2.50.1 (Apple Git-155)
>> >
>> >
>> > --
>> > Neodyme AG
>> > Sitz der Gesellschaft / Address: Dirnismaning 55 | Halle 13 |
>> > 85748 Garching b.M=C3=BCnchen
>> > Postanschrift: Rosenthaler Stra=C3=9Fe 72a | 10119
>> > Berlin
>> >
>> > Registergericht / Registry court: M=C3=BCnchen, HRB 269168
>> > Vorstand /
>> > Management Board: Thomas Lambertz | Tobias Madl
>> > Aufsichtsratsvorsitzender /
>> > Chairman of the Supervisory Board: Hendrik Hofstadt
>> >
>> >
>> >
>> >
>> >
>>
>>
>> --
>> Marc-Andr=C3=A9 Lureau
>
>
> Neodyme AG
>
> Sitz der Gesellschaft / Address: Dirnismaning 55 | Halle 13 | 85748 Garch=
ing b.M=C3=BCnchen
> Postanschrift: Rosenthaler Stra=C3=9Fe 72a | 10119 Berlin
> Registergericht / Registry court: M=C3=BCnchen, HRB 269168
> Vorstand / Management Board: Thomas Lambertz | Tobias Madl
> Aufsichtsratsvorsitzender / Chairman of the Supervisory Board: Hendrik Ho=
fstadt



--=20
Marc-Andr=C3=A9 Lureau


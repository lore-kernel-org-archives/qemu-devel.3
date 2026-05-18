Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE3CCD343F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 19:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP3YG-0003ln-QF; Mon, 18 May 2026 15:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wP3YE-0003le-2q
 for qemu-devel@nongnu.org; Mon, 18 May 2026 15:22:54 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wP3YC-00051z-2i
 for qemu-devel@nongnu.org; Mon, 18 May 2026 15:22:53 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48ff4f8ef0dso30790435e9.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 12:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779132170; x=1779736970; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/n3sQumJ8vdM5IdLJAScj3dFK9Tm1tDHXqW/ZQfwMrs=;
 b=n6OZtMxpTnoOjjQoJIINNZD/41Hh/COGV+muvOklwkrDal2cQiwCr083ygsvS1H8tp
 JXUL/M35b/xkHxVEQYdM/r2B0zpqmBh6ZqzgsrWceXrXvZPdKuZQ5PApn73DXykIhCem
 W4f6tikxNoq20sBPKY9C8rMoY1Z5rEeHBeiizFRSXH6OftyBvMU7XhJyRSFg6iM5Ykjd
 3Ik102DjF0O0xwOMQHFHxXwyeSoex+nuOuK5dlmXMaT6gX6mCgwx8bwqJeP97TVyjl9a
 buXgZKb40wnZzm6rMcu1+l9uVpeq96x8wvfzfrQ4Iqc0r3XR54yol5sty/ZdFcthj5Z5
 wDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779132170; x=1779736970;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/n3sQumJ8vdM5IdLJAScj3dFK9Tm1tDHXqW/ZQfwMrs=;
 b=ah06zadlSpLGCCb24K/mC8X6MOPr2gNYVtO+zLzaJrSlTp73xNidMED67oaHhBWgFj
 xCZIByWYCRKaszDvVUTGFqAVUG8Pq9JHxDELoqKGz1kBeRAjGCs6Fxr3Xgms08WIli/m
 NtHnnBgiC2YU47cmp0ZpUf0ZJrN6MIoKEBvckkX3uNlrR6EnzXjGbXLeeO0acapoDP9Y
 EZcgoogijt22ML68QRXMYaFfnqYIv6Cbnjv1etbMH3NrIyCcFR0ftIWRxJmr7uzTVFo9
 EVyAZsHB1l2YJNKdfWIrLkegzvZMlklhxqSNqITK+ypJ7eQ79ZdxYX+z/ytk19vySklj
 wN/A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+MZXmfCC+M/fa8ugCHGk6zpN6MVHon4GwQmZrXTfAWcLzMSP3ufragxsVgF+WJMES0xm6/vyNVxuIu@nongnu.org
X-Gm-Message-State: AOJu0YyYcDoAaS4mJ8wS4/0NwJejeZKO8gP/lqbuP16NecD3bOFhNAvk
 pI6sz2+sQPYVNWtmX8V1JZ1aAkSBDC3ynNUZUBi68Z1oRk4NwmLsGmd9qdpeyiXFAUk=
X-Gm-Gg: Acq92OHT2qx2TSTUK6ffIjU/DpzPCVazpMoTujHlvoO2xdpqY5IGB/rldo5FfZ9XFKX
 qfZdLuVEqscUthb+SEHHNxZSt4U+lHqjki+/oVSpS877iDaeOAjVrOyseu6++Nm3fT9YisylwUp
 pc6IRr/4lcHqnzCLODWGCmgmSZdhzj9y/ds8uXKlRrCW5zDfU4pxcYwCVJxN751PovsOEmYxxCp
 uL6bGQSbeFZlq1C4kTPDbfTcVf8vNCjYsJOZFmQF+2X7jTtcXU64nomBOM/WH4bfpqTuiBk4UqT
 RlNFXmlKw6ffc52nbsMewL5x9B/L58blgJbOqEs6ZmHwS4JkDVufY6vyp+3ZW0rO4CwP27YSdPn
 3klRvFNI7GtLdaAqhIeOe9AO0AKQ9oCzVIXKFNjKzaN1mgt70RxgPmR6Uqa5Sn8Fux73keBVQwg
 KDG6skYsWtmXT2hIVNKihGurs=
X-Received: by 2002:a05:600c:13ca:b0:48f:eb8b:9988 with SMTP id
 5b1f17b1804b1-48feb8b9a84mr144472485e9.23.1779132170304; 
 Mon, 18 May 2026 12:22:50 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe53ab6aasm294696695e9.2.2026.05.18.12.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 12:22:49 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 932345F7B1;
 Mon, 18 May 2026 20:22:48 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Benno =?utf-8?B?RsO8bmZzdMO8Y2s=?= <benno.fuenfstueck@neodyme.io>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,  Akihiko Odaki
 <odaki@rsg.ci.i.u-tokyo.ac.jp>,  Dmitry Osipenko
 <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH] virtio-gpu: fix inverted mouse cursor
In-Reply-To: <CAP-XHHCuVyP=21LyME1KmNB0heRDXAdq7QdCsoVomAK38ZRi7A@mail.gmail.com>
 ("Benno =?utf-8?B?RsO8bmZzdMO8Y2siJ3M=?= message of "Wed, 15 Apr 2026
 15:01:20 +0200")
References: <20260409144639.3610-1-benno.fuenfstueck@neodyme.io>
 <CAJ+F1CKYu4UfJyFJxPYLe9gjQhOD9QA7BrTmBXSCPuCDFgPf1A@mail.gmail.com>
 <CAP-XHHCuVyP=21LyME1KmNB0heRDXAdq7QdCsoVomAK38ZRi7A@mail.gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Mon, 18 May 2026 20:22:48 +0100
Message-ID: <87se7ocyk7.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

Benno F=C3=BCnfst=C3=BCck <benno.fuenfstueck@neodyme.io> writes:

> Hi Marc-Andr=C3=A9,
>
> On Mon, 13 Apr 2026 at 15:23, Marc-Andr=C3=A9 Lureau <marcandre.lureau@gm=
ail.com> wrote:
>
>  Arguably, this is a bug in virgl vrend_renderer_get_cursor_content(),
>  since the function doesn't return y0_top it should always return the
>  data in the correct orientation.
>
>  We may have a temporary workaround in qemu though for older virgl, but
>  I think it should be solved there too.
>
> Thanks, I didn't know about this. I submitted a MR to virglrenderer now a=
s well to fix it there:
> https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1611

I see this is merged now. Do we want to version gate the fix or just
drop it and wait for things to be backported?

>
> How should I change the patch to make it a temporary fix? Some kind of ve=
rsion gate (but not sure yet in which version of
> virglrenderer the fix will end up being release)?
>=20=20
>=20=20
>  > ---
>  >  hw/display/virtio-gpu-gl.c | 20 +++++++++++++++++++-
>  >  1 file changed, 19 insertions(+), 1 deletion(-)
>  >
>  > diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
>  > index 2b7a41c466..4562d3405e 100644
>  > --- a/hw/display/virtio-gpu-gl.c
>  > +++ b/hw/display/virtio-gpu-gl.c
>  > @@ -33,6 +33,9 @@ static void virtio_gpu_gl_update_cursor_data(VirtIOG=
PU *g,
>  >      VirtIOGPUGL *gl =3D VIRTIO_GPU_GL(g);
>  >      uint32_t width, height;
>  >      uint32_t pixels, *data;
>  > +    bool y_0_top =3D true;
>  > +    int ret;
>  > +    struct virgl_renderer_resource_info info;
>  >
>  >      if (gl->renderer_state !=3D RS_INITED) {
>  >          return;
>  > @@ -49,8 +52,23 @@ static void virtio_gpu_gl_update_cursor_data(VirtIO=
GPU *g,
>  >          return;
>  >      }
>  >
>  > +    memset(&info, 0, sizeof(info));
>  > +    ret =3D virgl_renderer_resource_get_info(resource_id, &info);
>  > +    if (ret =3D=3D 0) {
>  > +        y_0_top =3D info.flags & VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP;
>  > +    }
>  > +
>  >      pixels =3D s->current_cursor->width * s->current_cursor->height;
>  > -    memcpy(s->current_cursor->data, data, pixels * sizeof(uint32_t));
>  > +    if (y_0_top) {
>  > +        memcpy(s->current_cursor->data, data, pixels * sizeof(uint32_=
t));
>  > +    } else {
>  > +        uint32_t *dst =3D s->current_cursor->data;
>  > +        for (uint32_t y =3D 0; y < height; y++) {
>  > +            memcpy(dst + y * width,
>  > +                   data + (height - 1 - y) * width,
>  > +                   width * sizeof(uint32_t));
>  > +        }
>  > +    }
>  >      free(data);
>  >  }
>  >
>  > --
>  > 2.50.1 (Apple Git-155)
>  >
>  >
>  > --
>  > Neodyme AG
>  > Sitz der Gesellschaft / Address: Dirnismaning 55 | Halle 13 |
>  > 85748 Garching b.M=C3=BCnchen
>  > Postanschrift: Rosenthaler Stra=C3=9Fe 72a | 10119
>  > Berlin
>  >
>  > Registergericht / Registry court: M=C3=BCnchen, HRB 269168
>  > Vorstand /
>  > Management Board: Thomas Lambertz | Tobias Madl
>  > Aufsichtsratsvorsitzender /
>  > Chairman of the Supervisory Board: Hendrik Hofstadt
>  >
>  >
>  >
>  >
>  >
>
>  --=20
>  Marc-Andr=C3=A9 Lureau
>
> Neodyme AG
>
> Sitz der Gesellschaft / Address: Dirnismaning 55 | Halle 13 | 85748 Garch=
ing b.M=C3=BCnchen
> Postanschrift: =E2=80=8BRosenthaler Stra=C3=9Fe 72a | =E2=80=8B10119 Berl=
in
> Registergericht / Registry court: M=C3=BCnchen, HRB 269168
> Vorstand / Management Board: Thomas Lambertz | Tobias Madl
> Aufsichtsratsvorsitzender / Chairman of the Supervisory Board: Hendrik Ho=
fstadt

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


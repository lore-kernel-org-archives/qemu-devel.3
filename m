Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BD1C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 11:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5Osr-0001HR-SK; Fri, 10 May 2024 07:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1s5Osn-0001Gy-Oq
 for qemu-devel@nongnu.org; Fri, 10 May 2024 07:57:50 -0400
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1s5Osj-00034V-9L
 for qemu-devel@nongnu.org; Fri, 10 May 2024 07:57:47 -0400
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-43df23e034cso16333911cf.0
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 04:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715342263; x=1715947063; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fn4Pf9ecUA7ubOppugIw2zV+f8eXujTzwhZrdELeslA=;
 b=kqmNBGFunIjEf8uKgn7UFSOA17L28A+a7xONDzc4p1SY191EbPFlXpj25gST6VnyKT
 psxEc/mrzLL8pLlhyLz2g6CLx2wynT69j/TcIFQ3I+5W8ZKEj/Ib3d+6GWj2GL9ufOff
 2qk5p6kzJd+owYNJgibK6AuK0XpPdQDGgFaI1bw5O5UoJEXr7c6JsL2h82wb/qV4AL8B
 gy/JigglAlMWXDh/VFpP+ZMpCejAMrOqR07u5x3OlX5TzUeu55u6mvfB7kQ923d9H6Qn
 OMQ0jlVazQr9nnMZys2Bspt2XCuo87in4y1WEZekt7cA3NEegi1vFICOnjBMOHHuzMxq
 jVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715342263; x=1715947063;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fn4Pf9ecUA7ubOppugIw2zV+f8eXujTzwhZrdELeslA=;
 b=tHHREdIJHdPDSJLcAygONwGg5H2BdcWmNrMcj2B/o/eG6ZBBB7PSAJQFNjuF+pvsiL
 r30UOWdPFZtn778DgIj3ri5SIePs9TclnTZtbCpT91C9oKq62Q1B64kn23cRUZM18OXH
 5BMOayzX0XdkIVcrngIxJYysSUpKZBkc/TFz1rKiOp9WElrVVqSuKp4E1TMKIwb5Relt
 XNd5R2GiMWZ0npmBkYEUMmuMRuw7an/P0SXFE3fR+F+cxQUv/SFmV4S2GlFkdYzpha1v
 9NNECGzS445QXKjlDaCl3RHAvM1D1BHnHV6d7wnW8REgFMQIqeuZSu9+XJjdNzJGaOa9
 XtcA==
X-Gm-Message-State: AOJu0YynlSMOt/yXO6eHGtX0XqCHKNRgqUTf9iFGOHk08z39/BzOMOET
 I9v2FrsWOu1lVlfR0Ueteq7gDLzDgJd5JongyrEk1Ufno0xg2Yl6yUixvf+yaE7g5QZkq62ivLo
 7osN2tKoCYpHYw/sFgoDagWq5zWQ=
X-Google-Smtp-Source: AGHT+IHmn/iApU/TlGAlG5lEZS8zDBaZ/tzIFjNAJVlPPfiEOuaWWhhk22rl4gTV4Kju8W2ImFxKwr/5Rj1+Zfglrdk=
X-Received: by 2002:ac8:580c:0:b0:43a:b66d:1a67 with SMTP id
 d75a77b69052e-43dfce3d0camr48513291cf.29.1715342262872; Fri, 10 May 2024
 04:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240507111920.1594897-1-marcandre.lureau@redhat.com>
 <20240507111920.1594897-4-marcandre.lureau@redhat.com>
 <20240510062414-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240510062414-mutt-send-email-mst@kernel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 10 May 2024 15:57:31 +0400
Message-ID: <CAJ+F1CLG3MgaEp6-okcRcAW9Mx5qu5bGXdPdPNxgOYfnLpKdMA@mail.gmail.com>
Subject: Re: [PATCH 3/4] virtio-gpu: use a VMState variant for the scanout
 field
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Sebastian Ott <sebott@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Eduardo Habkost <eduardo@habkost.net>, Fiona Ebner <f.ebner@proxmox.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, peter.maydell@linaro.org, 
 Yanan Wang <wangyanan55@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82b.google.com
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

Hi Michael

On Fri, May 10, 2024 at 2:26=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, May 07, 2024 at 03:19:19PM +0400, marcandre.lureau@redhat.com wro=
te:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Depending on the version, use v1 or v2 of the scanout VM state.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  hw/display/virtio-gpu.c | 22 +++++++++++++++++-----
> >  1 file changed, 17 insertions(+), 5 deletions(-)
> >
> > diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> > index ae831b6b3e..4fd72caf3f 100644
> > --- a/hw/display/virtio-gpu.c
> > +++ b/hw/display/virtio-gpu.c
> > @@ -1191,17 +1191,29 @@ static const VMStateDescription vmstate_virtio_=
gpu_scanout =3D {
> >      },
> >  };
> >
> > +static bool vmstate_before_v2(void *opaque, int version)
> > +{
> > +    return version <=3D 1;
> > +}
> > +
> >  static const VMStateDescription vmstate_virtio_gpu_scanouts =3D {
> >      .name =3D "virtio-gpu-scanouts",
> > -    .version_id =3D 1,
> > +    .version_id =3D 2,
> > +    .minimum_version_id =3D 1,
> >      .fields =3D (const VMStateField[]) {
> >          VMSTATE_INT32(parent_obj.enable, struct VirtIOGPU),
> >          VMSTATE_UINT32_EQUAL(parent_obj.conf.max_outputs,
> >                               struct VirtIOGPU, NULL),
> > -        VMSTATE_STRUCT_VARRAY_UINT32(parent_obj.scanout, struct VirtIO=
GPU,
> > -                                     parent_obj.conf.max_outputs, 1,
> > -                                     vmstate_virtio_gpu_scanout,
> > -                                     struct virtio_gpu_scanout),
> > +        VMSTATE_VSTRUCT_TEST_VARRAY_UINT32(parent_obj.scanout, struct =
VirtIOGPU,
> > +                                           vmstate_before_v2,
> > +                                           parent_obj.conf.max_outputs=
, 1,
> > +                                           vmstate_virtio_gpu_scanout,
> > +                                           struct virtio_gpu_scanout, =
1),
> > +        VMSTATE_VSTRUCT_TEST_VARRAY_UINT32(parent_obj.scanout, struct =
VirtIOGPU,
> > +                                           NULL,
> > +                                           parent_obj.conf.max_outputs=
, 2,
> > +                                           vmstate_virtio_gpu_scanout,
> > +                                           struct virtio_gpu_scanout, =
2),
> >          VMSTATE_END_OF_LIST()
> >      },
>
>
> Just don't, please.
> Add a property and add a conditional field based on property, set
> from the compat machinery.
>

The version isn't propagated through the nested VMSDs, so
vmstate_virtio_gpu_scanout would only have v1, whether we have a field
test or not.

Can you be more explicit what alternative solution you propose?

thanks


--=20
Marc-Andr=C3=A9 Lureau


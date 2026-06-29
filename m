Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80756C43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 11:14:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we9wd-0002DN-3D; Mon, 29 Jun 2026 07:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1we9wY-0002CY-Rg
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 07:14:26 -0400
Received: from mail-dy1-x132b.google.com ([2607:f8b0:4864:20::132b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1we9wW-0006ql-Vr
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 07:14:26 -0400
Received: by mail-dy1-x132b.google.com with SMTP id
 5a478bee46e88-30c591fb1cbso4955595eec.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:14:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782731663; cv=none;
 d=google.com; s=arc-20260327;
 b=R4BDy2EiaTH2iWli+YxLzhsl94Pl9cgIIdeYZAVMffgl0YNGLrRY7kVdmUoOwfYjuN
 GNRH8pG0qkkprFixKPL2vs2f53ac1uYpEGS1zz49ReVmCJovf0u9ntxAcsFSd/y0XDiv
 zV+QPP5oElnIryFPB3LuFQtjFYAqs8t86TxDFa8VstcmvWXDWI9RYXUZzF5SEAfDqOJV
 OGCR2khGzifxqeKBLKKJo1m2bf6yxbCDMANiI3LULNcSkL1/1NGqYopGtdhOWIzV+WVj
 MlKLX2HsV7f7r0qmj+LaT1ZU03uQJAQnUVhCaBigbAcj0oEku4OXptbfWE3iQUx/johE
 25sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=28OafHWhkcVoDdhSxnSDE0Tb6FvE+2lqUwv3dE8HeAY=;
 fh=zhHjLYnurIDnMjpseq7QRpClOI8CbAfJtQfQwD2rBqM=;
 b=lUEw8YgfDR+L3MGtjDSx7V4Ag+Uq6PrEIfC+Xf5koSb6oWuRoPq6vDxqQ38Txd7VaM
 wSdVq71S7h0xqYXXzIZhtTf/Wq8meV/LyazsLyXIRQ/YCG80ej4/tajDFkfuASUzn3nf
 F/zurXCqqFZLeOaEoqR0D/70Tja2K8TxNxrekuzj1LJpC0YtxRMRavvzhKOomTTswuqL
 sEfjWmsK+WYEWsXaYiJr4rm92JCiO0AuvSyZCuofff2NKjf5A+t6SEIUQqxBg3BHg8WO
 wFItMHEJ5FCvtxzwIInx0aupdrzA1syKUANrfL8ODIlgexy+BCN3jVFf6VO41dlif/Hl
 o4QQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782731663; x=1783336463; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=28OafHWhkcVoDdhSxnSDE0Tb6FvE+2lqUwv3dE8HeAY=;
 b=GoqOK5F2a2MSmYmTJgqcxs7x90IP2nSYBN7sdH31YotCyv8ivUbd65+IqaHofNYRuN
 TQV+KbcZ5KRDiUQbHZi6zxRCfYvtisBDANPoYoxAJdtekLwHIY5kl4M12FoAByrfnNeA
 32/SIlz97in4Iq6YNLVTZ0CrkSc+2rDQrhcBWmVJRfifcFlmFqaKGIFSLu+PfsNcWlxM
 G8g5MinW+A/wbeD7ZzF3z7KjGm1JD40/Ed7SezzWPVTezjh3jyPtlQYpA47EDnXL4OiO
 jd3FLHxH3x+M3kVKWkdstVWKZ68QtwVySR7v30QOMWkGDDVqrxBOullVnCH2jIQqY7o9
 G0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782731663; x=1783336463;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=28OafHWhkcVoDdhSxnSDE0Tb6FvE+2lqUwv3dE8HeAY=;
 b=ZQRdPRBtjd21kAPB+SoYQRU+/x9Au7rROB35zioWjXlDYwg7kDh1fyEvn8it1kptXW
 yB4TzRiTKOmkEFrx0TIqJ3GzonWgI0R5+5M1rDTnlEVkHImOkB5UgE81SynXuMD/9C2B
 iAlDpd6VmXdnc0OKoKaZjpT1KLIX9ZW5iI/prYtkmcP7e8VTeMui5gz5BpJqPXpp/1vv
 5e7ykyN4LW2DqZPHrW8CGdNbk1cMQM0KEUnMCGUhRgacqY/Gw2Cy+NGtO2n3Nspc9RGe
 yBm0io1RHSUVinHs7Xc4j/jyEaAbOm+4jkm7XadjO4XKWJH/tGq0BgQM/utH5J+NHbex
 aGCQ==
X-Gm-Message-State: AOJu0YxscthL52yA20YF+aPCEGZvXySDmxWgnB8oEcWajMnPS27RwUVT
 GFyjDriYn5eq/VW5XPABA0Bk0lGmrbvHQtEmSarza7MrEGkCw2Ze3ROe3PM/Ne/61QlGUYJQUE4
 bX3Ua4cP+cNMzsJjHh0Si72ItnqhiFXEje8Tbzko=
X-Gm-Gg: AfdE7cn7FzlWjPEo0Ec0ch44y3na/lNZJAavkqdkTQB8c8NPGeGC4V5r6fnS1T71aMu
 YkE6+4kcjKrfMvXRkBaovGrxOcIFghk4uEQBbfde2+h6e75CiVLzQ/CfGhEkKoDZYQgNIe0Zo2Z
 6N+d3ES6aHvjQjEAlHZW9ILEqnbAiv4ZMH+gJyNyp+YQwK1mRsph254/ghrqCNJVLJuUFN5ElEt
 nMSebkDxl0d1QDbR73cmfL+l1DlAkpMex5JeY2y9tUjzaMptyn7JxaNU7uYgQiL72Vzva6o7U1y
 IKjUuIQQ2KCdCer0LQv2P79LX5hp
X-Received: by 2002:a05:7300:e410:b0:30c:25fb:d28f with SMTP id
 5a478bee46e88-30c84d81ba5mr14463116eec.25.1782731662869; Mon, 29 Jun 2026
 04:14:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260623163535.366104-2-rclobus@rclobus.nl>
In-Reply-To: <20260623163535.366104-2-rclobus@rclobus.nl>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 29 Jun 2026 15:14:09 +0400
X-Gm-Features: AVVi8CcDkJv7Md3zPxrJeLSACljvjXnc9t4hiOH5quU-hWHpxBKSMvFfaUWZWSs
Message-ID: <CAJ+F1C+3RF9q3HMntDFeNj+WPv0whPi8-6Uj-_mwKEfDriBq+A@mail.gmail.com>
Subject: Re: [PATCH] virtio-gpu: Support the configurable EDID fields
To: Roland Clobus <rclobus@rclobus.nl>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::132b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x132b.google.com
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

On Tue, Jun 23, 2026 at 8:38=E2=80=AFPM Roland Clobus <rclobus@rclobus.nl> =
wrote:
>
> This patch adds support for the fields that are currently configurable
> in the function qemu_edid_generate.
>
> Signed-off-by: Roland Clobus <rclobus@rclobus.nl>
> ---
>  hw/display/virtio-gpu-base.c | 41 +++++++++++++++++++++++++++++++--
>  qapi/virtio.json             | 44 ++++++++++++++++++++++++++++++------
>  2 files changed, 76 insertions(+), 9 deletions(-)
>
> diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
> index a68b184829..5391189add 100644
> --- a/hw/display/virtio-gpu-base.c
> +++ b/hw/display/virtio-gpu-base.c
> @@ -69,9 +69,39 @@ virtio_gpu_base_generate_edid(VirtIOGPUBase *g, int sc=
anout,
>
>      for (output_idx =3D 0, node =3D g->conf.outputs;
>           output_idx <=3D scanout && node; output_idx++, node =3D node->n=
ext) {
> -        if (output_idx =3D=3D scanout && node->value && node->value->nam=
e) {
> +        if (output_idx !=3D scanout || !node->value) {
> +            continue;
> +        }
> +
> +        if (node->value->vendor) {
> +            info.vendor =3D node->value->vendor;
> +        }
> +        if (node->value->name) {
>              info.name =3D node->value->name;
> -            break;
> +        }
> +        if (node->value->serial) {
> +            info.serial =3D node->value->serial;
> +        }
> +        if (node->value->has_widthmm) {
> +            info.width_mm =3D node->value->widthmm;
> +        }
> +        if (node->value->has_heightmm) {
> +            info.height_mm =3D node->value->heightmm;
> +        }
> +        if (node->value->has_xres) {
> +            info.prefx =3D node->value->xres;
> +        }
> +        if (node->value->has_yres) {
> +            info.prefy =3D node->value->yres;
> +        }
> +        if (node->value->has_xmax) {
> +            info.maxx =3D node->value->xmax;
> +        }
> +        if (node->value->has_ymax) {
> +            info.maxy =3D node->value->ymax;
> +        }
> +        if (node->value->has_refreshrate) {
> +            info.refresh_rate =3D node->value->refreshrate;
>          }
>      }
>
> @@ -237,6 +267,10 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
>      for (output_idx =3D 0, node =3D g->conf.outputs;
>           node && output_idx < g->conf.max_outputs;
>           output_idx++, node =3D node->next) {
> +        if (node->value->has_widthmm && node->value->has_heightmm) {
> +            g->req_state[output_idx].width_mm =3D node->value->widthmm;
> +            g->req_state[output_idx].height_mm =3D node->value->heightmm=
;
> +        }
>          if (node->value->has_xres !=3D node->value->has_yres) {
>              error_setg(errp,
>                         "must set both outputs[%zd].xres and outputs[%zd]=
.yres",
> @@ -248,6 +282,9 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
>              g->req_state[output_idx].width =3D node->value->xres;
>              g->req_state[output_idx].height =3D node->value->yres;
>          }
> +        if (node->value->has_refreshrate) {
> +            g->req_state[output_idx].refresh_rate =3D node->value->refre=
shrate;
> +        }
>      }
>
>      g->hw_ops =3D &virtio_gpu_ops;
> diff --git a/qapi/virtio.json b/qapi/virtio.json
> index 1fc4e38a44..e1cd5864fe 100644
> --- a/qapi/virtio.json
> +++ b/qapi/virtio.json
> @@ -952,24 +952,54 @@
>  ##
>  # @VirtIOGPUOutput:
>  #
> -# Describes configuration of a VirtIO GPU output.  If both @xres and
> -# @yres are set, they take precedence over root virtio-gpu resolution
> -# configuration and enable the corresponding output.  If none of @xres
> -# and @yres are set, root virtio-gpu resolution configuration takes
> -# precedence and only the first output is enabled.  Only setting one
> -# of @xres or @yres is an error.
> +# Describes configuration of a VirtIO GPU output.  Matches the fields
> +# of struct @qemu_edid_info.
> +# If both @xres and @yres are set, they take precedence over root
> +# virtio-gpu resolution configuration and enable the corresponding
> +# output.  If none of @xres and @yres are set, root
> +# virtio-gpu resolution configuration takes precedence and only the
> +# first output is enabled.  Only setting one of @xres or @yres is
> +# an error.
> +#
> +# @vendor: a 3 letter code for the vendor (since xx.x TODO)
>  #

It should be uppercase. Validation is missing in qemu_edid_generate() too

We should also document the default values

>  # @name: the name of the output
>  #
> +# @serial: the serial number (since xx.x TODO)
> +#          must be numerical

Then why do we accept a string? We should also fix qemu_edid_info then

> +#
> +# @widthmm: width of the display in mm (since xx.x TODO)
> +#           If @widthmm is set, @heightmm must be set too
> +#
> +# @heightmm: height of the display in mm (since xx.x TODO)
> +#           If @heightmm is set, @widthmm must be set too

Setting one without the other would be weird. Maybe we should have a
struct with both fields mandatory?

> +#
>  # @xres: horizontal resolution of the output in pixels (since 11.0)
>  #
>  # @yres: vertical resolution of the output in pixels (since 11.0)

Same, but pre-existing.

>  #
> +# @xmax: maximum horizontal resolution of the output in pixels
> +#        (since xx.x TODO)
> +#
> +# @ymax: maximum vertical resolution of the output in pixels
> +#        (since xx.x TODO)

Same

> +#
> +# @refreshrate: refreshrate in mHz (since xx.x TODO)
> +#
>  # Since: 10.1
>  ##
>
>  { 'struct': 'VirtIOGPUOutput',
> -  'data': { 'name': 'str', '*xres': 'uint16', '*yres': 'uint16' } }
> +  'data': { '*vendor': 'str',
> +            'name': 'str',
> +            '*serial': 'str',
> +            '*widthmm': 'uint16',
> +            '*heightmm': 'uint16',
> +            '*xres': 'uint32',
> +            '*yres': 'uint32',
> +            '*xmax': 'uint32',
> +            '*ymax': 'uint32'

It changes the existing xres/yres fields type.
Is it necessary to accept uint32?

> +            '*refreshrate': 'uint32' } }
>
>  ##
>  # @DummyVirtioForceArrays:
> --
> 2.53.0
>
>


--=20
Marc-Andr=C3=A9 Lureau


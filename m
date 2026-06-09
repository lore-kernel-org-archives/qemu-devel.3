Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4326BCD8C92
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 12:27:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWvXM-0000Ap-R5; Tue, 09 Jun 2026 08:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wWvXH-000093-6W
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 08:26:27 -0400
Received: from mail-dl1-x122e.google.com ([2607:f8b0:4864:20::122e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wWvXE-0007dX-DZ
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 08:26:26 -0400
Received: by mail-dl1-x122e.google.com with SMTP id
 a92af1059eb24-13810b63a1aso3173752c88.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 05:26:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781007980; cv=none;
 d=google.com; s=arc-20240605;
 b=AN5uHfelmr2JycW7GvBO4Ie8hT9nh40u6be4nn8wyV6NNyQWCwrQE9prPH1HtcYN/n
 1VyuuJypL3PayR67Oc+RwipVA5Y7kXlsf0LIz70leeeMk7C9aMAG+sP4r0yazdCvWKjW
 OaqlgvZVYmFuBG2c4W460bNu+WimcZuH75SqTucfyJN+vkgpptE8mIQEQbhHaHPM8Wv6
 pGi4lG+wzAdz4d4cZMsaNuckrBLykxoEzw46YEp3ZjJNPIhKPtACP2qVJciS0T7PVU2X
 yVDQCAV67Q2r7ZQtZ29v5PIIoLHTnU+m4Y1BEV/xPyT/L6UlB8/Dz2183wZEpb/2M2ge
 JLVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pT7U2PiQzUP7OYX/SqTmmlEKF6TLCTJEwolEGtgVcqo=;
 fh=/I1gSr7aVPS0xsTkFZ6v2ERtrmTjbPJzIY7Fn7S0DvU=;
 b=hMyIT9RTc6PaFW+TcumnCgFbeUtw/CS2DEliOBYxNvFKaIzSNW3Ez9IO253xGVmXCq
 lrufGJifLUsRKdAj3ZcJFrEhJDbFSxl7K5iwz5Ui6/8jBYSKStFrZsDWksyITwd5y6EX
 TBiJqXuEDowluCUePhIT/+GM79uQa+LQlki7ceRmYc0x8ckCIiijxsEmmYXJRArzLBih
 kwWt8yrIDfaY/GNu262/8e2cUKKxP0Fy1Ko0/8j7ZIlAf+aPIKax72R5XZ5f1uLpmSuC
 Gah6W359h1rIOJyiFvPIcmm8eRYNFsZOaJo+7T+EMA2Kp34ITHFQCJxVzKpg1okYxTCH
 vePQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781007980; x=1781612780; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pT7U2PiQzUP7OYX/SqTmmlEKF6TLCTJEwolEGtgVcqo=;
 b=prITitajbezXDSirUlzV2DcYil7qklfQV06VI1xp2BjSVa8u6h8w8nKYkXnfG+mp1Z
 f9aXTQfOFphwubRGg9TiAk+fcoiqZ4ruV1rka+ZZTZzWsLmFuG7WuMiA9/9YcFdHWRtW
 8CDKBG5XEZl/HclzFJtrTHaoQrSX1+HQwE0unGLtIwSq2H5DTVU50x+bzJLfEq85qwI/
 u8nsEFOztTRKC1hX6qumWPrHzQ1vxJCkN/TZ/YzlweoFzxr58g3lHK4fEx1Q2e1KDCZA
 ueFhLvsKG/NLdvSfRiWqhitzogSc0Vl18ojjH6hSYy51ubz/adktagqauwEQHGF/0kQe
 FBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781007980; x=1781612780;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pT7U2PiQzUP7OYX/SqTmmlEKF6TLCTJEwolEGtgVcqo=;
 b=oNrwm8o2XGm/qMyhofYy84ULB3/zasob18a9ZVJ519I6FhuXEgFtIePXyuDdXorptX
 1pc9igs9TaXSKppcDTV2aM6PsImBdUd/tzhyITdkL2aLjQzCDNTVx50sIutlK8p1QiaO
 fxCCiDzCM+2XHkubyBHYhfWmhF4eSmmPbPEI5iVAlinQ8DwM3OYD/j67P9hT5c1cnuG9
 AgrmKZKaQUbJ/QvmzzaoWbo39ZPoSSLm5s9EkdeChlLw7Q/qYE0mgGqXmdEarQJIB1G8
 0SK3fn0AARKaFssuh9DKuh8RpIzNiI7eO7/JcI/mFjYY9j2vcnOmuNAgVoaDrWWX5Jq1
 HEfg==
X-Gm-Message-State: AOJu0YzMOOGv3VjBNnY6aNCIPS6upRcqcLXdxSVeQv1cPIXDFMB6Mbrg
 /v+MngfayRnmKMRaA2ErpnpuqMDNp3yDpzJqgxpUkt/XpXzzIFN9jHArMozaGWcpsmsCMuOTcwd
 LxLRo+KmYj61x0IYnDSI+fx7pb3UI3UU=
X-Gm-Gg: Acq92OHo495VRYTLXXWzxKxcCnLb13JHkIG3ZnVl1EcYZuxKC0SWwy3b2W9XL4mg2/S
 n1yBjsHcHho0806nRDzy6lCVr8U1yyQMnSjysyFhtTLj9oHHNLG+BJPdBYnpNTr1MTthpEX5/Bu
 A/DpPhxwaQ1m2admMV3qct5fNNUkf7n6S+1UlZ2B8tyuFVxgop4mTDepXOkPW1uVkvr4juQHHv3
 bbdsr/t6ZJsy+kt3lQ0v/084bUvWS2tkpQMez/zwpZcAFuhQ2DKAPawhixj/ToyE6tfhILSsIP1
 QMoVR6ai1VyxeUfC8i/TbL68d992JWDb+ZSB3hwGgFfnvGkyHF6E4Jokz6dC
X-Received: by 2002:a05:7300:6917:b0:2c1:6676:5ebd with SMTP id
 5a478bee46e88-307d5fed672mr2093385eec.10.1781007980281; Tue, 09 Jun 2026
 05:26:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260608-b4-ui-v2-0-9ea6355ea08f@redhat.com>
 <20260608-b4-ui-v2-5-9ea6355ea08f@redhat.com>
 <62b98e0c-011a-4f9e-a913-4fc24aa8450d@redhat.com>
In-Reply-To: <62b98e0c-011a-4f9e-a913-4fc24aa8450d@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 9 Jun 2026 16:26:08 +0400
X-Gm-Features: AVVi8Cf2afEbucPYMWaBfcltR2CUuhn_-aybzEGc17ClhHVTjP2a3y8J62evTkU
Message-ID: <CAJ+F1CJX0Y74f32ajUiziQRgFnkT=hysvVY6zO3aG56rr--Kjw@mail.gmail.com>
Subject: Re: [PATCH v2 05/33] vfio/pci: close display console during
 unrealize, not finalize
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Alex Williamson <alex@shazbot.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::122e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dl1-x122e.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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



On Mon, Jun 8, 2026 at 4:51=E2=80=AFPM C=C3=A9dric Le Goater <clg@redhat.co=
m> wrote:
>
> Hello Marc-Andr=C3=A9,
>
> On 6/8/26 09:16, Marc-Andr=C3=A9 Lureau wrote:
> > The QemuGraphicConsole holds a strong QOM link back to the device via
> > its "device" property (OBJ_PROP_LINK_STRONG). When graphic_console_clos=
e()
> > is only called from vfio_display_finalize() during object finalize, thi=
s
> > creates a ref-cycle deadlock: the device can't reach refcount 0 because
> > the console holds a strong ref, but the console's ref is only dropped b=
y
> > graphic_console_close() which runs inside finalize.
> >
> > Split the display teardown into two phases:
> > - vfio_display_exit(): called during unrealize (vfio_exitfn), closes
> >    the graphic console to break the ref cycle, and removes display
> >    region subregions while the parent memory regions are still alive.
> > - vfio_display_finalize(): remains in finalize (vfio_pci_put_device),
> >    frees display region memory, dmabuf, and edid resources. The region
> >    memory contains QOM child objects (MemoryRegions) that must stay
> >    alive until QOM finalization has processed them.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   hw/vfio/pci.h     |  1 +
> >   hw/vfio/display.c | 30 +++++++++++++++++++-----------
> >   hw/vfio/pci.c     |  1 +
> >   3 files changed, 21 insertions(+), 11 deletions(-)
> >
> > diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> > index c3a1f53d350..cf567115870 100644
> > --- a/hw/vfio/pci.h
> > +++ b/hw/vfio/pci.h
> > @@ -270,6 +270,7 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error *=
*errp);
> >
> >   void vfio_display_reset(VFIOPCIDevice *vdev);
> >   bool vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
> > +void vfio_display_exit(VFIOPCIDevice *vdev);
> >   void vfio_display_finalize(VFIOPCIDevice *vdev);
> >
> >   extern const VMStateDescription vfio_display_vmstate;
> > diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> > index 8f91e83da88..34cc25ee0e0 100644
> > --- a/hw/vfio/display.c
> > +++ b/hw/vfio/display.c
> > @@ -505,15 +505,6 @@ static bool vfio_display_region_init(VFIOPCIDevice=
 *vdev, Error **errp)
> >       return true;
> >   }
> >
> > -static void vfio_display_region_exit(VFIODisplay *dpy)
> > -{
> > -    if (!dpy->region.buffer.size) {
> > -        return;
> > -    }
> > -
> > -    vfio_region_exit(&dpy->region.buffer);
> > -    vfio_region_finalize(&dpy->region.buffer);
> > -}
> >
> >   /* ------------------------------------------------------------------=
---- */
> >
> > @@ -547,17 +538,34 @@ bool vfio_display_probe(VFIOPCIDevice *vdev, Erro=
r **errp)
> >       return false;
> >   }
> >
> > -void vfio_display_finalize(VFIOPCIDevice *vdev)
> > +void vfio_display_exit(VFIOPCIDevice *vdev)
> >   {
> >       if (!vdev->dpy) {
> >           return;
> >       }
> >
> > +    if (display_opengl) {
> > +        qemu_console_set_display_gl_ctx(vdev->dpy->con, NULL);
> > +    }
> >       qemu_graphic_console_close(vdev->dpy->con);
> > +    if (vdev->dpy->region.buffer.size) {
> > +        vfio_region_exit(&vdev->dpy->region.buffer);
> > +    }
> > +}
> > +
> > +void vfio_display_finalize(VFIOPCIDevice *vdev)
> > +{
> > +    if (!vdev->dpy) {
> > +        return;
> > +    }
> > +
> >       vfio_display_dmabuf_exit(vdev->dpy);
>
> vfio_display_dmabuf_exit() will use dpy->con after it's closed :
>
>    qemu_console_gl_release_dmabuf(dpy->con, dmabuf->buf);
>
> It is OK ?

No, we should free the dmabufs during vfio_display_exit() before the
console is closed.

thanks

> if so,
>
>
> Acked-by: C=C3=A9dric Le Goater <clg@redhat.com>
>
> Thanks,
>
> C.
>
>
>
> > -    vfio_display_region_exit(vdev->dpy);
> > +    if (vdev->dpy->region.buffer.size) {
> > +        vfio_region_finalize(&vdev->dpy->region.buffer);
> > +    }
> >       vfio_display_edid_exit(vdev->dpy);
> >       g_free(vdev->dpy);
> > +    vdev->dpy =3D NULL;
> >   }
> >
> >   static bool migrate_needed(void *opaque)
> > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > index 9c06b25e637..78beacd24e1 100644
> > --- a/hw/vfio/pci.c
> > +++ b/hw/vfio/pci.c
> > @@ -3624,6 +3624,7 @@ static void vfio_exitfn(PCIDevice *pdev)
> >       VFIOPCIDevice *vdev =3D VFIO_PCI_DEVICE(pdev);
> >       VFIODevice *vbasedev =3D &vdev->vbasedev;
> >
> > +    vfio_display_exit(vdev);
> >       vfio_unregister_req_notifier(vdev);
> >       vfio_unregister_err_notifier(vdev);
> >       pci_device_set_intx_routing_notifier(pdev, NULL);
> >
>
>


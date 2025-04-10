Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A81C369A2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 15:29:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2tpT-0006bQ-3H; Thu, 10 Apr 2025 11:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u2tpP-0006aX-Rv
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 11:28:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u2tpO-0006Pu-8j
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 11:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744298909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vN80KB4QMP/b0Q604vYpZ/Z2c8YeQisV8jjwNFpnGkg=;
 b=Xw2SHdvFI2Ghb1XfycQIt2rc2yR3jEWgg72igDpRdyshe/PbZKzh8caD8Zrj17LArwHZJz
 Dzb0IdL7ckittnhMTsHxEJOX9KYOY86AY9HUJfo3KQQd5sY8gc7gIVfaNvwssWV44rBAon
 xVPAAaPOyRqmNRxcZC20JJd0XYdDR+o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-csTWFaqKMoyyETy4O4Ob7w-1; Thu, 10 Apr 2025 11:28:25 -0400
X-MC-Unique: csTWFaqKMoyyETy4O4Ob7w-1
X-Mimecast-MFC-AGG-ID: csTWFaqKMoyyETy4O4Ob7w_1744298905
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43d209dc2d3so6187045e9.3
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 08:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744298904; x=1744903704;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vN80KB4QMP/b0Q604vYpZ/Z2c8YeQisV8jjwNFpnGkg=;
 b=V8NqfmdJJUBClgvrDJTrlIwdsfHwgNba+mEMgOKXXZ5zwLBWBnoc+xH7ydPmX3djn+
 szYjl+uvFk3FHpHSCTJX/8Ft2yJUR3uTRPeedaU2KSBne3YVnoRnFs//MOs8kxLJOdEd
 TC8J19IiNuFhTS258dwgwTSwx/IRfmHoC2J/BhSk9Zg5AKI0vql/eBY+pVbutt63S4pC
 IDOZeZK7behN6FtmIkhF+B1nbN8Qt6PK6jnlQaK3TiPw+O0XpPowWQQeohj1efHdba4D
 OZgGlSsJ19hgQ54nOUpbXfsI+IX3MW3SDUq/g5V/Xr0cKf9InrlI7FlqqKsEkiRce3uv
 8WXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsE1Fvjoebl1zYQNYh7UKq5onI49Fli6240ItcGF2BTEAqoNAFEz9rWlRXV/WYRngZ1GQkSzmQIn+k@nongnu.org
X-Gm-Message-State: AOJu0YwXDPFR/S0kSVLZ3tZgGTyRrd5zw62t/qcRas5alg0qL8N77bHP
 rxvVmpdkMXmhMTdt3B+C8GTOlSp3A+HYqvEzgEtnYublfuwihuKsTl9wVzoh2YlZ0WbVk75A2OM
 SEjFBWH3gfm8lxjCG9494YSinN/ASyIwZjsG13T24SyGzDuFB1Ayest4k7JIr/o+AjpIh3DOR5d
 I2iQ6NcmtKL/PhAHA+66HE3TgiH+c=
X-Gm-Gg: ASbGncvzqg128VrgrX97xXgqD6gTsXIm68KTXMkDDsO+Q+xquo636NTVTYdSYiKMYNw
 VGGl2wZ7zWvGDnBFw0Nzshb83lwx9eH4WexY2MPiLc5LNv7vf/o2MaNIHpv5fhWDF718=
X-Received: by 2002:a5d:5846:0:b0:391:481a:5e75 with SMTP id
 ffacd0b85a97d-39d8f469b3dmr2953325f8f.22.1744298904635; 
 Thu, 10 Apr 2025 08:28:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVpzWrVBbWuGfyFMbfkfZrGAYp+EhcAHLU86qChdY0uE2PR1pDT/3GM+gQGS+XlxMBBv1ZX2eOGmr9QJWEivE=
X-Received: by 2002:a5d:5846:0:b0:391:481a:5e75 with SMTP id
 ffacd0b85a97d-39d8f469b3dmr2953297f8f.22.1744298904248; Thu, 10 Apr 2025
 08:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250407155949.44736-1-kwolf@redhat.com>
 <bf72ef35-289c-4ec7-962b-414e3487c176@redhat.com>
In-Reply-To: <bf72ef35-289c-4ec7-962b-414e3487c176@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 10 Apr 2025 17:28:11 +0200
X-Gm-Features: ATxdqUEF5pqEqbJ2ZGBPoeac1gr0yKXDFb2i6alB3o2hoYKGKpruSJpzak608_4
Message-ID: <CABgObfaJw1VSE6pbs2o1oTTGi6nXLtFQG90RG3J9DY1sukZpMA@mail.gmail.com>
Subject: Re: [PATCH for-10.0] scsi-disk: Apply error policy for host_status
 errors again
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: hreitz@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org, 
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.593,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Thu, Apr 10, 2025 at 4:25=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
> You should set ret =3D 0 here to avoid going down the
> scsi_sense_from_errno() path.
>
> Otherwise,
>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Okay, going down the scsi_sense_from_errno() path is more or less
harmless because status and sense end up unused; even though ENODEV is
not something that the function handles, that can be added as a
cleanup in 10.1.

Paolo

> > +    }
> > +
> >       if (ret < 0) {
> >           status =3D scsi_sense_from_errno(-ret, &sense);
> >           error =3D -ret;
> > @@ -289,6 +303,10 @@ static bool scsi_handle_rw_error(SCSIDiskReq *r, i=
nt ret, bool acct_failed)
> >           if (acct_failed) {
> >               block_acct_failed(blk_get_stats(s->qdev.conf.blk), &r->ac=
ct);
> >           }
> > +        if (host_status !=3D -1) {
> > +            scsi_req_complete_failed(&r->req, host_status);
> > +            return true;
> > +        }
> >           if (req_has_sense) {
> >               sdc->update_sense(&r->req);
> >           } else if (status =3D=3D CHECK_CONDITION) {
> > @@ -409,7 +427,6 @@ done:
> >       scsi_req_unref(&r->req);
> >   }
> >
> > -/* May not be called in all error cases, don't rely on cleanup here */
> >   static void scsi_dma_complete(void *opaque, int ret)
> >   {
> >       SCSIDiskReq *r =3D (SCSIDiskReq *)opaque;
> > @@ -448,7 +465,6 @@ done:
> >       scsi_req_unref(&r->req);
> >   }
> >
> > -/* May not be called in all error cases, don't rely on cleanup here */
> >   static void scsi_read_complete(void *opaque, int ret)
> >   {
> >       SCSIDiskReq *r =3D (SCSIDiskReq *)opaque;
> > @@ -585,7 +601,6 @@ done:
> >       scsi_req_unref(&r->req);
> >   }
> >
> > -/* May not be called in all error cases, don't rely on cleanup here */
> >   static void scsi_write_complete(void * opaque, int ret)
> >   {
> >       SCSIDiskReq *r =3D (SCSIDiskReq *)opaque;
> > @@ -2846,14 +2861,10 @@ static void scsi_block_sgio_complete(void *opaq=
ue, int ret)
> >       sg_io_hdr_t *io_hdr =3D &req->io_header;
> >
> >       if (ret =3D=3D 0) {
> > -        /* FIXME This skips calling req->cb() and any cleanup in it */
> >           if (io_hdr->host_status !=3D SCSI_HOST_OK) {
> > -            scsi_req_complete_failed(&r->req, io_hdr->host_status);
> > -            scsi_req_unref(&r->req);
> > -            return;
> > -        }
> > -
> > -        if (io_hdr->driver_status & SG_ERR_DRIVER_TIMEOUT) {
> > +            r->req.host_status =3D io_hdr->host_status;
> > +            ret =3D -ENODEV;
> > +        } else if (io_hdr->driver_status & SG_ERR_DRIVER_TIMEOUT) {
> >               ret =3D BUSY;
> >           } else {
> >               ret =3D io_hdr->status;
>



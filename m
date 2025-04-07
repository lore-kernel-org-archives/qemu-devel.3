Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3833BC36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 18:23:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1r6m-00040i-CS; Mon, 07 Apr 2025 14:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shajnocz@redhat.com>)
 id 1u1r6j-000406-Qi
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 14:22:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shajnocz@redhat.com>)
 id 1u1r6g-0002JM-Uy
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 14:22:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744050121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FQn2cg+wkPiuBPMuD9aeXnjB550KiH7vtya18Bb7d7o=;
 b=ZhF1Ox6hAvvYlDSPIpLmd/bbd2fJ6hlfH7lSo6SHqJ65nMIVtQO49g8wW9zo1E2ZQJZme+
 LHbTptHXVMj5r3RROZRcp+J8Vj1KP7KAY1nEJdvky648hjNP3caT8TjXaTcZ8cRTuemhQU
 577Wlce5iZRtALJ2zyDScgHTittjzBQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-mufa8mKBMyed75ke6aLFUQ-1; Mon, 07 Apr 2025 14:20:10 -0400
X-MC-Unique: mufa8mKBMyed75ke6aLFUQ-1
X-Mimecast-MFC-AGG-ID: mufa8mKBMyed75ke6aLFUQ_1744050010
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ac737973d03so370826766b.1
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 11:20:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744050009; x=1744654809;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FQn2cg+wkPiuBPMuD9aeXnjB550KiH7vtya18Bb7d7o=;
 b=KOBAh6O5RM8ct1EonZ2FjTlIE4Tj/IJcoTrZ64tF8Dv/c+Y03sJTvFvk4pQR4Lzi5t
 yM5EoKBsSSxIPFLHRrMPJCbRp8BtpogzY3kVKUL5XLKX9927XWx9jOgDEeVBu8/JqBza
 HOAIhVOnrEKa4VXmofObU2WF1/Y44wKE27lIZDhASrDbsQFpUTTZeNCgHc6qVj0/IBBZ
 RRQmJCoKYuH7MxQXLb2hJV92jIFRGcGiKpLT7UCIIIlBQi4a1AWLlhnILwJXwsZzFZ/e
 CfmGhovYVVTN+VDvzeT0qcWX6UVrb33dVj6xsW0wO6u586nh83SZmmJP5uwLKPDrZfKv
 ktig==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdamrYOLz35gAJ9xVOCzroA+SDKcm2//R96j4SjZYy00oR33ElHibZPG7pEWgGcf+XnoEsprw/n944@nongnu.org
X-Gm-Message-State: AOJu0Yzc85bB9CDv8W7xV0VMbgLuwjghiqMu5/0k8Yjg6kKdRWGMFX1W
 Dr2m7ZeSS4wRiBQVKDzGl4d2IQwdzreYAUimAw6fTBjVrHwxzXClnSOBsiwnyO4rGJVRdGeeBV1
 /DKJtGP/bqGR3ROR9zeCpA4S7epASRc1DXfQxnUhwanugS16m7Ln84KNkpDFBPhnBKUWqLbEboe
 mOfY9KAtAu3iF+gYrySiGTZe4ewrs=
X-Gm-Gg: ASbGncty98W1L+LV4rcigQFI4oTqE5o/tOfptbVXz0gyL3Pkkq1I4ujZ1Kj/ZCutzS+
 RwNKvKP1bsxc9pOIKHPQb5akb5aRVZw/wRHcwCHbGaGPOleOofdwrzftq5BZlu/Kx/cljw6k=
X-Received: by 2002:a17:907:7e98:b0:ac2:622f:39c1 with SMTP id
 a640c23a62f3a-ac7d6d06cd9mr1090536566b.22.1744050009566; 
 Mon, 07 Apr 2025 11:20:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyEodSUNmA7FQk4l63ZEqqA5Cx0NksMkuCsfh/dzFz9LcW5FZvY8dw1WJHGoqHNnXrWbeIggb1ZQmD7690NPw=
X-Received: by 2002:a17:907:7e98:b0:ac2:622f:39c1 with SMTP id
 a640c23a62f3a-ac7d6d06cd9mr1090534766b.22.1744050009147; Mon, 07 Apr 2025
 11:20:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250407155949.44736-1-kwolf@redhat.com>
In-Reply-To: <20250407155949.44736-1-kwolf@redhat.com>
From: Stefan Hajnoczi <shajnocz@redhat.com>
Date: Mon, 7 Apr 2025 14:19:57 -0400
X-Gm-Features: ATxdqUHkyPZbe70xz2TNIE7vKyDslJj7gNtT_ItpyhIXq1ofUrOHJnRq8dX0kbc
Message-ID: <CAD60JZPnNRLCLwc71SCX5tfddHrW3WvdXJ9TmQ8T_Q-dz3xODA@mail.gmail.com>
Subject: Re: [PATCH for-10.0] scsi-disk: Apply error policy for host_status
 errors again
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, pbonzini@redhat.com, 
 stefanha@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=shajnocz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Apr 7, 2025 at 12:00=E2=80=AFPM Kevin Wolf <kwolf@redhat.com> wrote=
:
>
> Originally, all failed SG_IO requests called scsi_handle_rw_error() to
> apply the configured error policy. However, commit f3126d65, which was
> supposed to be a mere refactoring for scsi-disk.c, broke this and
> accidentally completed the SCSI request without considering the error
> policy any more if the error was signalled in the host_status field.
>
> Apart from the commit message not describing the chance as intended,
> errors indicated in host_status are also obviously backend errors and
> not something the guest must deal with indepdently of the error policy.
>
> This behaviour means that some recoverable errors (such as a path error
> in multipath configurations) were reported to the guest anyway, which
> might not expect it and might consider its disk broken.
>
> Make sure that we apply the error policy again for host_status errors,
> too. This addresses an existing FIXME comment and allows us to remove
> some comments warning that callbacks weren't always called. With this
> fix, they are called in all cases again.
>
> The return value passed to the request callback doesn't have more free
> values that could be used to indicate host_status errors as well as SAM
> status codes and negative errno. Store the value in the host_status
> field of the SCSIRequest instead and use -ENODEV as the return value (if
> a path hasn't been reachable for a while, blk_aio_ioctl() will return
> -ENODEV instead of just setting host_status, so just reuse it here -
> it's not necessarily entirely accurate, but it's as good as any errno).
>
> Cc: qemu-stable@nongnu.org
> Fixes: f3126d65b393 ('scsi: move host_status handling into SCSI drivers')
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  hw/scsi/scsi-disk.c | 39 +++++++++++++++++++++++++--------------
>  1 file changed, 25 insertions(+), 14 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

>
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index 8da1d5a77c..e59632e9b1 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -68,10 +68,9 @@ struct SCSIDiskClass {
>      SCSIDeviceClass parent_class;
>      /*
>       * Callbacks receive ret =3D=3D 0 for success. Errors are represente=
d either as
> -     * negative errno values, or as positive SAM status codes.
> -     *
> -     * Beware: For errors returned in host_status, the function may dire=
ctly
> -     * complete the request and never call the callback.
> +     * negative errno values, or as positive SAM status codes. For host_=
status
> +     * errors, the function passes ret =3D=3D -ENODEV and sets the host_=
status field
> +     * of the SCSIRequest.
>       */
>      DMAIOFunc       *dma_readv;
>      DMAIOFunc       *dma_writev;
> @@ -225,11 +224,26 @@ static bool scsi_handle_rw_error(SCSIDiskReq *r, in=
t ret, bool acct_failed)
>      SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
>      SCSIDiskClass *sdc =3D (SCSIDiskClass *) object_get_class(OBJECT(s))=
;
>      SCSISense sense =3D SENSE_CODE(NO_SENSE);
> +    int16_t host_status;
>      int error;
>      bool req_has_sense =3D false;
>      BlockErrorAction action;
>      int status;
>
> +    /*
> +     * host_status should only be set for SG_IO requests that came back =
with a
> +     * host_status error in scsi_block_sgio_complete(). This error path =
passes
> +     * -ENODEV as the return value.
> +     *
> +     * Reset host_status in the request because we may still want to com=
plete
> +     * the request successfully with the 'stop' or 'ignore' error policy=
.
> +     */
> +    host_status =3D r->req.host_status;
> +    if (host_status !=3D -1) {
> +        assert(ret =3D=3D -ENODEV);
> +        r->req.host_status =3D -1;
> +    }
> +
>      if (ret < 0) {
>          status =3D scsi_sense_from_errno(-ret, &sense);
>          error =3D -ret;
> @@ -289,6 +303,10 @@ static bool scsi_handle_rw_error(SCSIDiskReq *r, int=
 ret, bool acct_failed)
>          if (acct_failed) {
>              block_acct_failed(blk_get_stats(s->qdev.conf.blk), &r->acct)=
;
>          }
> +        if (host_status !=3D -1) {
> +            scsi_req_complete_failed(&r->req, host_status);
> +            return true;
> +        }
>          if (req_has_sense) {
>              sdc->update_sense(&r->req);
>          } else if (status =3D=3D CHECK_CONDITION) {
> @@ -409,7 +427,6 @@ done:
>      scsi_req_unref(&r->req);
>  }
>
> -/* May not be called in all error cases, don't rely on cleanup here */
>  static void scsi_dma_complete(void *opaque, int ret)
>  {
>      SCSIDiskReq *r =3D (SCSIDiskReq *)opaque;
> @@ -448,7 +465,6 @@ done:
>      scsi_req_unref(&r->req);
>  }
>
> -/* May not be called in all error cases, don't rely on cleanup here */
>  static void scsi_read_complete(void *opaque, int ret)
>  {
>      SCSIDiskReq *r =3D (SCSIDiskReq *)opaque;
> @@ -585,7 +601,6 @@ done:
>      scsi_req_unref(&r->req);
>  }
>
> -/* May not be called in all error cases, don't rely on cleanup here */
>  static void scsi_write_complete(void * opaque, int ret)
>  {
>      SCSIDiskReq *r =3D (SCSIDiskReq *)opaque;
> @@ -2846,14 +2861,10 @@ static void scsi_block_sgio_complete(void *opaque=
, int ret)
>      sg_io_hdr_t *io_hdr =3D &req->io_header;
>
>      if (ret =3D=3D 0) {
> -        /* FIXME This skips calling req->cb() and any cleanup in it */
>          if (io_hdr->host_status !=3D SCSI_HOST_OK) {
> -            scsi_req_complete_failed(&r->req, io_hdr->host_status);
> -            scsi_req_unref(&r->req);
> -            return;
> -        }
> -
> -        if (io_hdr->driver_status & SG_ERR_DRIVER_TIMEOUT) {
> +            r->req.host_status =3D io_hdr->host_status;
> +            ret =3D -ENODEV;
> +        } else if (io_hdr->driver_status & SG_ERR_DRIVER_TIMEOUT) {
>              ret =3D BUSY;
>          } else {
>              ret =3D io_hdr->status;
> --
> 2.48.1
>



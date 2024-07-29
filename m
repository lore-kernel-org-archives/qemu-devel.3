Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FFE6C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 12:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYOz7-0001w6-Kj; Mon, 29 Jul 2024 07:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sYOz5-0001na-Bg
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 07:56:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sYOz3-0003Hb-MC
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 07:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722254169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eCSVOq9LhPfLBfy6HuRWZRfXiaQynAMj8sqpSrqVBG8=;
 b=dmLBNMxTKr2LFMPoo9qaB4v/ZQtnQmeKdOqqbhyAJI26vPGCSUlTDq4i8v5Er6ghSClSGc
 LL+poRRFYHjHHadQkawAStAOyGneRCrFg9hF0BDbBiqQiOZcH3mOcksCSiB8X3EAP35f/8
 OnIT3u++KFX4k1WWQVZcOLgeiPHFdvE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-MQa-ej4gOAmR0cZuUG4eQQ-1; Mon, 29 Jul 2024 07:56:05 -0400
X-MC-Unique: MQa-ej4gOAmR0cZuUG4eQQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-36831948d94so1452847f8f.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 04:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722254164; x=1722858964;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eCSVOq9LhPfLBfy6HuRWZRfXiaQynAMj8sqpSrqVBG8=;
 b=wnUvKdqttVGTxs47fvX20/a3UGwJ7LuxhWfFVCJh/cQ8AodUus8+azj0KXdvDJU7DR
 VTR7GzexR1nhYN2BAwbVAa58IGSvitlFNg06iEgXVsXc2D7mSCnQB4i1Ezv9fpCm73xk
 5KkEs1Xm/oeAKOpCPqrtlA74X8tlZYmTICtcM/aN3lSub5mqAdxuLNqs/ARhhBy0o6lB
 d5CG2PrgobCHbpX/D4o9r+WAztcULMhpSYr+H7+P8VwvMfW4tbG6lZh9GI3pLoMnfojI
 2YxW3qBLa6iFz7rk2kVpo3OZ6m7ILdADRZVzKRLvlVn6b9GXKJqOMsFE1b3fdN7cAsv2
 JF6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpHLym2Ns8crQIowfh0bYXe64wo/wiMY+keJiltlgxvbUlLPyKlVgN9+/Zt9cxEjAwtTw+p9cKfNE85PML5sFZB0g47qQ=
X-Gm-Message-State: AOJu0Yx5Dfwh83DJYfUsZICjAJYJp8y6bSpu5h8bnj4xC/cb/Kbunf6v
 RdvCfyLVdWr1GBSPtshvA7PVpbyMc3o8u+1elHMfJU6mrEZRw+C/Q+80bNyNkR6AKbEFLmc0Ray
 C5AZmrCrrifJFAUwV8HJKzSOv3euyQEcWX24QBHENQM9G/MN4gPrEYvv/yOZPJOVEVMQpIXd6cD
 78QclgicL9EIW/U84riqksfievSoYOrm0oInq3sA==
X-Received: by 2002:a05:6000:186c:b0:368:4e28:47f7 with SMTP id
 ffacd0b85a97d-36b5cefd51dmr6220284f8f.6.1722254163946; 
 Mon, 29 Jul 2024 04:56:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFz54WjA+vo2ttOC9KhPgthpaRhina1Z5WxtiW6vBspEPgUIuZEIprU6hUXbd9ObE7Vzh8jnieFv/3c6rehNFY=
X-Received: by 2002:a05:6000:186c:b0:368:4e28:47f7 with SMTP id
 ffacd0b85a97d-36b5cefd51dmr6220258f8f.6.1722254163473; Mon, 29 Jul 2024
 04:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240729094702.50282-1-kwolf@redhat.com>
 <20240729094702.50282-5-kwolf@redhat.com>
In-Reply-To: <20240729094702.50282-5-kwolf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 29 Jul 2024 13:55:51 +0200
Message-ID: <CABgObfYbpZ3JV5i_TKjobd6DrzYiy567YAfQbX+x5X7mj1=GKw@mail.gmail.com>
Subject: Re: [PATCH 4/4] scsi-disk: Always report RESERVATION_CONFLICT to guest
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, fam@euphon.net, stefanha@redhat.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Jul 29, 2024 at 11:47=E2=80=AFAM Kevin Wolf <kwolf@redhat.com> wrot=
e:
> RESERVATION_CONFLICT is not a backend error, but indicates that the
> guest tried to make a request that it isn't allowed to execute. Pass the
> error to the guest so that it can decide what to do with it.

This is only true of scsi-block (though your patch is okay here -
scsi-disk would see an EBADE and go down the ret < 0 path).

In general, for scsi-block I'd expect people to use report instead of
stop. I agree that this is the best behavior for the case where you
have a pr-manager, but it may also be better to stop the VM if a
pr-manager has not been set up.  That's probably a bit hackish, so I
guess it's okay to add a FIXME or TODO comment instead?

> -        if (status =3D=3D CHECK_CONDITION) {
> +        switch (status) {
> +        case CHECK_CONDITION:
>              req_has_sense =3D true;
>              error =3D scsi_sense_buf_to_errno(r->req.sense, sizeof(r->re=
q.sense));
> -        } else {
> +            break;
> +        case RESERVATION_CONFLICT:
> +            /* Don't apply the error policy, always report to the guest =
*/

This is the only case where you get error =3D=3D 0. Maybe remove it from
the initializer, and set it here?

Paolo

On Mon, Jul 29, 2024 at 11:47=E2=80=AFAM Kevin Wolf <kwolf@redhat.com> wrot=
e:
>
> RESERVATION_CONFLICT is not a backend error, but indicates that the
> guest tried to make a request that it isn't allowed to execute. Pass the
> error to the guest so that it can decide what to do with it.
>
> Without this, if we stop the VM in response to a RESERVATION_CONFLICT,
> it can happen that the VM cannot be resumed any more because every
> attempt to resume it immediately runs into the same error and stops the
> VM again.
>
> One case that expects RESERVATION_CONFLICT errors to be visible in the
> guest is running the validation tests in Windows 2019's Failover Cluster
> Manager, which intentionally tries to execute invalid requests to see if
> they are properly rejected.
>
> Buglink: https://issues.redhat.com/browse/RHEL-50000
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  hw/scsi/scsi-disk.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index 69a195177e..e173b238de 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -235,11 +235,17 @@ static bool scsi_handle_rw_error(SCSIDiskReq *r, in=
t ret, bool acct_failed)
>      } else {
>          /* A passthrough command has completed with nonzero status.  */
>          status =3D ret;
> -        if (status =3D=3D CHECK_CONDITION) {
> +        switch (status) {
> +        case CHECK_CONDITION:
>              req_has_sense =3D true;
>              error =3D scsi_sense_buf_to_errno(r->req.sense, sizeof(r->re=
q.sense));
> -        } else {
> +            break;
> +        case RESERVATION_CONFLICT:
> +            /* Don't apply the error policy, always report to the guest =
*/
> +            break;
> +        default:
>              error =3D EINVAL;
> +            break;
>          }
>      }
>
> @@ -249,8 +255,9 @@ static bool scsi_handle_rw_error(SCSIDiskReq *r, int =
ret, bool acct_failed)
>       * are usually retried immediately, so do not post them to QMP and
>       * do not account them as failed I/O.
>       */
> -    if (req_has_sense &&
> -        scsi_sense_buf_is_guest_recoverable(r->req.sense, sizeof(r->req.=
sense))) {
> +    if (!error || (req_has_sense &&
> +                   scsi_sense_buf_is_guest_recoverable(r->req.sense,
> +                                                       sizeof(r->req.sen=
se)))) {
>          action =3D BLOCK_ERROR_ACTION_REPORT;
>          acct_failed =3D false;
>      } else {
> --
> 2.45.2
>



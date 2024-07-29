Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D568C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 12:21:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYPMa-0004Ep-CR; Mon, 29 Jul 2024 08:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sYPMT-00041Z-F2
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 08:20:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sYPMP-000846-Al
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 08:20:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722255614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/+/sUiOZG1KN1lVZX61t28X3bC4jLJVrlISgRD3D3Bk=;
 b=eU4IrjICa0RCG/7dCzzcYz025PlgWl3fNfyNr9SKJvGY4yt2dGbQjeOjgvpnCxH2l/LrB4
 TBP7WVcSAnuT759P6akexMKAnWzJWFbvcsjG29/ynyL0/RHTT7hZYBl3xpmcJvy28o1GVF
 hPN0LZHMnQReSPYazfA1Rz7hmlauSm4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-5kx_zJ01PBqrfyikC3eFyA-1; Mon,
 29 Jul 2024 08:20:10 -0400
X-MC-Unique: 5kx_zJ01PBqrfyikC3eFyA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B9E61955D50; Mon, 29 Jul 2024 12:20:06 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.89])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C98E5195605F; Mon, 29 Jul 2024 12:20:03 +0000 (UTC)
Date: Mon, 29 Jul 2024 14:20:01 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-block@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 4/4] scsi-disk: Always report RESERVATION_CONFLICT to guest
Message-ID: <ZqeI8TiHg8caawXr@redhat.com>
References: <20240729094702.50282-1-kwolf@redhat.com>
 <20240729094702.50282-5-kwolf@redhat.com>
 <CABgObfYbpZ3JV5i_TKjobd6DrzYiy567YAfQbX+x5X7mj1=GKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfYbpZ3JV5i_TKjobd6DrzYiy567YAfQbX+x5X7mj1=GKw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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

Am 29.07.2024 um 13:55 hat Paolo Bonzini geschrieben:
> On Mon, Jul 29, 2024 at 11:47 AM Kevin Wolf <kwolf@redhat.com> wrote:
> > RESERVATION_CONFLICT is not a backend error, but indicates that the
> > guest tried to make a request that it isn't allowed to execute. Pass the
> > error to the guest so that it can decide what to do with it.
> 
> This is only true of scsi-block (though your patch is okay here -
> scsi-disk would see an EBADE and go down the ret < 0 path).

Right, in the scsi-disk case, we probably do want to consider it a
host-side error because the guest can't see or influence what happens on
the backend.

I can change the commit message accordingly.

> In general, for scsi-block I'd expect people to use report instead of
> stop. I agree that this is the best behavior for the case where you
> have a pr-manager, but it may also be better to stop the VM if a
> pr-manager has not been set up.  That's probably a bit hackish, so I
> guess it's okay to add a FIXME or TODO comment instead?

Apparently both oVirt and Kubevirt unconditionally use the stop policy,
so I'm afraid in this case we must acknowledge that our expectations
don't match reality.

If I understand correctly, not having a pr-manager could mean that QEMU
itself is sufficiently privileged and then the same logic would apply.

But even if it means that we can't change any persistent reservations
from the VM, what use would stopping the VM be? You would run into the
exact case I'm describing in the commit message: You try to resume the
VM and it immediately stops again because the request still doesn't get
through. Or do you expect the host admin to take some manual action
then?

And what would you do about the Windows cluster validation case that
intentionally sends a request which reservations don't and shouldn't
allow? There is nothing on the host side to fix there. The guest is only
happy when it gets an error back.

> > -        if (status == CHECK_CONDITION) {
> > +        switch (status) {
> > +        case CHECK_CONDITION:
> >              req_has_sense = true;
> >              error = scsi_sense_buf_to_errno(r->req.sense, sizeof(r->req.sense));
> > -        } else {
> > +            break;
> > +        case RESERVATION_CONFLICT:
> > +            /* Don't apply the error policy, always report to the guest */
> 
> This is the only case where you get error == 0. Maybe remove it from
> the initializer, and set it here?

Not sure why the initialiser was added in the first place, but yes, I
can do that.

Kevin

> On Mon, Jul 29, 2024 at 11:47 AM Kevin Wolf <kwolf@redhat.com> wrote:
> >
> > RESERVATION_CONFLICT is not a backend error, but indicates that the
> > guest tried to make a request that it isn't allowed to execute. Pass the
> > error to the guest so that it can decide what to do with it.
> >
> > Without this, if we stop the VM in response to a RESERVATION_CONFLICT,
> > it can happen that the VM cannot be resumed any more because every
> > attempt to resume it immediately runs into the same error and stops the
> > VM again.
> >
> > One case that expects RESERVATION_CONFLICT errors to be visible in the
> > guest is running the validation tests in Windows 2019's Failover Cluster
> > Manager, which intentionally tries to execute invalid requests to see if
> > they are properly rejected.
> >
> > Buglink: https://issues.redhat.com/browse/RHEL-50000
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  hw/scsi/scsi-disk.c | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> > index 69a195177e..e173b238de 100644
> > --- a/hw/scsi/scsi-disk.c
> > +++ b/hw/scsi/scsi-disk.c
> > @@ -235,11 +235,17 @@ static bool scsi_handle_rw_error(SCSIDiskReq *r, int ret, bool acct_failed)
> >      } else {
> >          /* A passthrough command has completed with nonzero status.  */
> >          status = ret;
> > -        if (status == CHECK_CONDITION) {
> > +        switch (status) {
> > +        case CHECK_CONDITION:
> >              req_has_sense = true;
> >              error = scsi_sense_buf_to_errno(r->req.sense, sizeof(r->req.sense));
> > -        } else {
> > +            break;
> > +        case RESERVATION_CONFLICT:
> > +            /* Don't apply the error policy, always report to the guest */
> > +            break;
> > +        default:
> >              error = EINVAL;
> > +            break;
> >          }
> >      }
> >
> > @@ -249,8 +255,9 @@ static bool scsi_handle_rw_error(SCSIDiskReq *r, int ret, bool acct_failed)
> >       * are usually retried immediately, so do not post them to QMP and
> >       * do not account them as failed I/O.
> >       */
> > -    if (req_has_sense &&
> > -        scsi_sense_buf_is_guest_recoverable(r->req.sense, sizeof(r->req.sense))) {
> > +    if (!error || (req_has_sense &&
> > +                   scsi_sense_buf_is_guest_recoverable(r->req.sense,
> > +                                                       sizeof(r->req.sense)))) {
> >          action = BLOCK_ERROR_ACTION_REPORT;
> >          acct_failed = false;
> >      } else {
> > --
> > 2.45.2
> >
> 



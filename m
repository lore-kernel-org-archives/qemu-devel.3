Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 988B9CC6B12
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 17:59:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGglP-0002xl-P8; Tue, 13 Oct 2026 13:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xGglO-0002xR-Ce
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 13:58:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xGglM-0007KD-OB
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 13:58:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791914286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FfLRZKUJT+Wn4v+T7bNYwJxwXT+oJMCSbMkEw+nFQM4=;
 b=FXUsexReHplEfz1gL786ardVBtLDAiOCm05NnFfQYVtw9xKYgnlDiBMAuzjsPMh1FoqAnd
 5OidWs/Wke5OEGD/u5Wi2fTB6mcbodDcLVYM5adZLhXn0wtPnSxv0RJFv2ubwAv24ctZ52
 i80AzpfrrCxvv8rfx2Isao8ktmw3Rko=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171--a51HU1dPYWHD1fsXJjlTg-1; Tue,
 13 Oct 2026 17:58:03 +0000
X-MC-Unique: -a51HU1dPYWHD1fsXJjlTg-1
X-Mimecast-MFC-AGG-ID: -a51HU1dPYWHD1fsXJjlTg_1791914282
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B9C5183035E; Tue, 13 Oct 2026 17:58:01 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D3A523004D31; Tue, 13 Oct 2026 17:57:58 +0000 (UTC)
Date: Tue, 13 Oct 2026 13:57:16 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, akalenyu@redhat.com, qemu-block@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH 5/8] pr-manager-helper: add PR_HELPER_CLEANUP command
 support
Message-ID: <20261013175716.GB1193846@shajnocz.csb>
References: <20261009153058.1089786-1-stefanha@redhat.com>
 <20261009153058.1089786-6-stefanha@redhat.com>
 <75739957-f97d-41e7-8439-cd73cd12be25@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75739957-f97d-41e7-8439-cd73cd12be25@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On Tue, Oct 13, 2026 at 06:25:28PM +0200, Paolo Bonzini wrote:
> On 10/9/26 17:30, Stefan Hajnoczi wrote:
> > qemu-pr-helper now supports the vendor-specific PR_HELPER_CLEANUP SCSI
> > command. Add support to the client side.
> 
> Hi Stefan, up to this point it's all good; qemu-pr-helper works in SCSI
> commands so a vendor-specific command is the obvious way to add the
> functionality---and I'm glad the feature negotiation worked out.
> 
> For the next steps, however, I'm not sure about using blk_ioctl to send the
> migration done command from SCSIDevice to BlockBackend, which (if I
> understand correctly) implicitly exposes the command to the guest as well.
> 
> In particular, perhaps it makes sense to add a migration_done callback to
> BlockDriverState and BlockBackend?  They can be called either only from
> SCSIGeneric, or from a new block layer migration notifier that walks the
> BlockBackend list.
> 
> If instead the command is not exposed to the guest, please just add a
> comment explaining why.

I looked into this: hw/scsi/scsi-bus.c:scsi_req_new() does not support
vendor-specific commands since scsi_cdb_length() returns -1. So
PR_HELPER_CLEANUP (0xff) from the guest will be rejected immediately
by any emulated SCSI HBA.

However, I will send a v2 patch series that goes further: let's
explicitly reject PR_HELPER_CLEANUP in scsi_req_new() so that even if
scsi_cdb_length() or related code changes in the future, it will never
be possible to submit the command from a guest.

> 
> Thanks,
> 
> Paolo
> 
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >   scsi/pr-manager-helper.c | 20 ++++++++++++++++----
> >   scsi/utils.c             |  3 +++
> >   2 files changed, 19 insertions(+), 4 deletions(-)
> > 
> > diff --git a/scsi/pr-manager-helper.c b/scsi/pr-manager-helper.c
> > index 26ef3876f0e..fa6611ed676 100644
> > --- a/scsi/pr-manager-helper.c
> > +++ b/scsi/pr-manager-helper.c
> > @@ -38,6 +38,8 @@ struct PRManagerHelper {
> >       QemuMutex lock;
> >       QIOChannel *ioc;
> > +
> > +    uint32_t proto_flags; /* flags negotiated with pr-helper */
> >   };
> >   static void pr_manager_send_status_changed_event(PRManagerHelper *pr_mgr)
> > @@ -129,8 +131,9 @@ static int pr_manager_helper_initialize(PRManagerHelper *pr_mgr,
> >           goto out_close;
> >       }
> > -    flags = 0;
> > -    r = pr_manager_helper_write(pr_mgr, -1, &flags, sizeof(flags), errp);
> > +    pr_mgr->proto_flags = flags & PR_HELPER_FEATURE_CLEANUP;
> > +    r = pr_manager_helper_write(pr_mgr, -1, &pr_mgr->proto_flags,
> > +                                sizeof(pr_mgr->proto_flags), errp);
> >       if (r < 0) {
> >           goto out_close;
> >       }
> > @@ -160,10 +163,19 @@ static int pr_manager_helper_run(PRManager *p,
> >           return -EINVAL;
> >       }
> > +    /* The command is only available when pr-helper supports it */
> > +    if (cdb[0] == PR_HELPER_CLEANUP &&
> > +        !(pr_mgr->proto_flags & PR_HELPER_FEATURE_CLEANUP)) {
> > +        return -ENOTSUP;
> > +    }
> > +
> >       memcpy(cdb, io_hdr->cmdp, io_hdr->cmd_len);
> > -    assert(cdb[0] == PERSISTENT_RESERVE_OUT || cdb[0] == PERSISTENT_RESERVE_IN);
> > +    assert(cdb[0] == PERSISTENT_RESERVE_OUT ||
> > +           cdb[0] == PERSISTENT_RESERVE_IN ||
> > +           cdb[0] == PR_HELPER_CLEANUP);
> >       expected_dir =
> > -        (cdb[0] == PERSISTENT_RESERVE_OUT ? SG_DXFER_TO_DEV : SG_DXFER_FROM_DEV);
> > +        (cdb[0] == PERSISTENT_RESERVE_IN ?
> > +         SG_DXFER_FROM_DEV : SG_DXFER_TO_DEV);
> >       if (io_hdr->dxfer_direction != expected_dir) {
> >           return -EINVAL;
> >       }
> > diff --git a/scsi/utils.c b/scsi/utils.c
> > index daee90ecf0e..1ee68e68221 100644
> > --- a/scsi/utils.c
> > +++ b/scsi/utils.c
> > @@ -29,6 +29,9 @@ uint32_t scsi_data_cdb_xfer(uint8_t *buf)
> >   uint32_t scsi_cdb_xfer(uint8_t *buf)
> >   {
> > +    if (buf[0] == PR_HELPER_CLEANUP) {
> > +        return 0;
> > +    }
> >       switch (buf[0] >> 5) {
> >       case 0:
> >           return buf[4];
> 



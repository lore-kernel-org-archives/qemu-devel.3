Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FCB1C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:00:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wojIJ-0000mu-Kp; Tue, 28 Jul 2026 11:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wojIH-0000hM-Ob
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:00:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wojIF-0004SH-Kf
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:00:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785250830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4EcuQOsqMONcXpwy7D0AIyfKT7atM4Z0McKDikKPtVg=;
 b=L8jm1PMeBbPmfPSvIkrPJXLxwnitaKBAf0IWsTyLexts0oXQF8sOZ4yV1GGEyyWHG/KXA2
 KovWP6sToPKnimLfZFg3oYJRbNpO9BXlAB8FuPlAS6lmc+q1V1WNVT6OjuLBZSskvUKouj
 fMJSZbfyiqzSQ+5E+/Bhtf9AbpyOlPI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-c-_lYILWOXS88iFPLek-pg-1; Tue,
 28 Jul 2026 11:00:25 -0400
X-MC-Unique: c-_lYILWOXS88iFPLek-pg-1
X-Mimecast-MFC-AGG-ID: c-_lYILWOXS88iFPLek-pg_1785250823
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F1A8919560AE; Tue, 28 Jul 2026 15:00:22 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.201])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E8F830001A4; Tue, 28 Jul 2026 15:00:18 +0000 (UTC)
Date: Tue, 28 Jul 2026 17:00:16 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Amit Shah <amit@kernel.org>
Subject: Re: [PATCH 0/3] Harden virtio migration load paths against crafted
 streams
Message-ID: <amjEALq8-unXNAZS@redhat.com>
References: <20260710102859.1967551-1-lvivier@redhat.com>
 <20260725113324-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260725113324-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

Am 25.07.2026 um 17:34 hat Michael S. Tsirkin geschrieben:
> On Fri, Jul 10, 2026 at 12:28:56PM +0200, Laurent Vivier wrote:
> > A crafted migration stream can crash the destination QEMU process
> > through unvalidated fields in the virtio device state: an unbounded
> > allocation in virtio-serial, reachable assertions in the shared
> > virtqueue element deserializer, and assert()/exit(1) calls in
> > virtio-scsi request loading.
> > 
> > These are hardening fixes: the destination QEMU is in a paused
> > pre-start state and the source VM is unaffected by a failed migration.
> > 
> > Patch 1 validates the virtio-serial nr_active_ports count against the
> > configured maximum before allocating the post-load array.
> > 
> > Patch 2 replaces the assertions in qemu_get_virtqueue_element() with
> > a bounds check returning NULL, and updates all callers (virtio-serial,
> > virtio-blk, virtio-scsi, scsi-bus) to handle the failure gracefully.
> > 
> > Patch 3 replaces the remaining assert() and exit(1) calls in
> > virtio_scsi_load_request() with proper error returns.
> > 
> > Tested with migration round-trips for virtio-serial (0 to 511 ports),
> > virtio-blk (1-2 disks), and virtio-scsi (1-2 disks), plus the
> > original PoC reproducers for issues #3801 and #3802.
> > 
> > Laurent Vivier (3):
> >   hw/char/virtio-serial-bus: validate nr_active_ports from migration
> >     stream
> >   hw/virtio: return NULL from qemu_get_virtqueue_element() on invalid
> >     state
> >   hw/scsi/virtio-scsi: harden virtio_scsi_load_request() against invalid
> >     stream
> 
> Kevin objected to my version of this, I guess same will apply?

Objecting is a big word. I suggested some improvements around passing
errors to the caller instead of trying to handle everything locally. But
yes, at the first sight I think they would apply here, too.

Kevin



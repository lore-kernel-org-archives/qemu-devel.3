Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A78C44532
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 01:18:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmi4E-0004cT-1W; Wed, 22 Jul 2026 21:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1wmi44-0004Zz-Hx; Wed, 22 Jul 2026 21:17:32 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1wmi41-0002xb-UF; Wed, 22 Jul 2026 21:17:31 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BAE86600AB;
 Thu, 23 Jul 2026 01:17:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 341781F00A3A;
 Thu, 23 Jul 2026 01:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784769439;
 bh=7OoojlQ7zf5LlLfLK095v9w5Vh9e3y6NwiF/hoQhbY8=;
 h=Date:From:To:cc:Subject:In-Reply-To:References;
 b=mlw79mHXD7nOAaHOQgTrqOQ/7DtQ7jT1TENmwqKIyMUfgmM7P96irTgtufuWRHt+q
 4oCNUjAyuaHi7I1xnQoFSlh28lEs4Nrg7ud/sy0MistmnUAMQxFViPbRb/Zv10Mt6X
 sF5kvoS7oGm4AvkaDRSKQZ1gLM+WoX3LrX9q0G2KqllpdKgOTAA1K2BZbGtrTCmEk4
 1zwnsmUN1hJg9bW4az2+DH9wT2EDnCTSrQDGEXFC/Wz9oAnULN68V0wAd3fsTm9epv
 sjyqa44xsiMGzbkbZ9rSNjqjzicCRy4l7u7bBMDgc2wQhgHQqmzmto4zHu7eS4iEE4
 Hbsz7hm3FeiDw==
Date: Wed, 22 Jul 2026 18:17:12 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
cc: Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org, 
 qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>, 
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH v2 2/2] hw/9pfs/xen: drain in-flight PDUs before xen-9p
 disconnect
In-Reply-To: <6012362.DvuYhMxLoT@weasel>
Message-ID: <alpine.DEB.2.22.394.2607221815520.5295@ubuntu-linux-20-04-desktop>
References: <cover.1784392605.git.qemu_oss@crudebyte.com>
 <afbe101f9fef3110d79023c604be0b28006cfb60.1784392605.git.qemu_oss@crudebyte.com>
 <6012362.DvuYhMxLoT@weasel>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=172.105.4.254;
 envelope-from=sstabellini@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 22 Jul 2026, Christian Schoenebeck wrote:
> Hi Stefano,
> 
> chance that you might be looking at this v2 Xen patch soon? If not, just let 
> me know, then I'll send out a PR with other fixes piled up on my side in the 
> meantime, as QEMU release window narrows.

This is better but I think there is still an issue

 
> On Saturday, 18 July 2026 18:50:06 CEST Christian Schoenebeck wrote:
> > The xen-9p disconnect path has two issues:
> > 
> > 1. It frees the Xen9pfsRing structures while in-flight PDUs may still
> >    reference them via pdu->tag to index rings[]. This causes a UAF
> >    in xen_9pfs_push_and_notify() when worker threads resume after
> >    completing filesystem operations.
> > 
> > 2. It never calls v9fs_device_unrealize_common(), which means server
> >    state (struct LocalData, mountfd, FIDs) is never cleaned up on
> >    disconnect, causing a resource leak on every guest-initiated
> >    disconnect.
> > 
> > Fix both by draining in-flight PDUs via v9fs_reset() before tearing
> > down rings, and calling v9fs_device_unrealize_common() to clean up
> > server state.
> > 
> > Additionally, explicit calls of xen_9pfs_disconnect() in the error
> > paths of xen_9pfs_pdu_vmarshal() and xen_9pfs_pdu_vunmarshal() must
> > be deferred (via aio_bh_schedule_oneshot()), because
> > xen_9pfs_pdu_v(un)marshal() are running within a coroutine context
> > which makes them unsafe [1] for calling v9fs_reset() directly, as
> > the latter e.g. has a loop like:
> > 
> >     while (!QLIST_EMPTY(&s->active_list)) {
> >         aio_poll(qemu_get_aio_context(), true);
> >     }
> > 
> > which would a) never terminate (as the coroutine is on the
> > active_list) and b) aio_poll() is marked as no_coroutine_fn.
> > 
> > [1] https://lore.kernel.org/qemu-devel/3351181.5fSG56mABF@weasel/
> > 
> > And finally, add an idempotent guard to xen_9pfs_disconnect(),
> > just for the case.
> > 
> > Fixes: b37eeb0201 ("xen/9pfs: introduce Xen 9pfs backend")
> > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > ---
> >  hw/9pfs/xen-9p-backend.c | 19 +++++++++++++++++--
> >  1 file changed, 17 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
> > index 24c90d97ec..edb65a7afc 100644
> > --- a/hw/9pfs/xen-9p-backend.c
> > +++ b/hw/9pfs/xen-9p-backend.c
> > @@ -68,6 +68,11 @@ typedef struct Xen9pfsDev {
> > 
> >  static void xen_9pfs_disconnect(struct XenLegacyDevice *xendev);
> > 
> > +static void xen_9pfs_disconnect_bh(void *opaque)
> > +{
> > +    xen_9pfs_disconnect(opaque);
> > +}
> > +
> >  static void xen_9pfs_in_sg(Xen9pfsRing *ring,
> >                             struct iovec *in_sg,
> >                             int *num,
> > @@ -150,7 +155,8 @@ static ssize_t xen_9pfs_pdu_vmarshal(V9fsPDU *pdu,
> >                        "Failed to encode VirtFS reply type %d\n",
> >                        pdu->id + 1);
> >          xen_be_set_state(&xen_9pfs->xendev, XenbusStateClosing);
> > -        xen_9pfs_disconnect(&xen_9pfs->xendev);
> > +        aio_bh_schedule_oneshot(qemu_get_aio_context(),
> > +                                xen_9pfs_disconnect_bh, &xen_9pfs->xendev);
> > }
> >      return ret;
> >  }
> > @@ -173,7 +179,8 @@ static ssize_t xen_9pfs_pdu_vunmarshal(V9fsPDU *pdu,
> >          xen_pv_printf(&xen_9pfs->xendev, 0,
> >                        "Failed to decode VirtFS request type %d\n",
> > pdu->id); xen_be_set_state(&xen_9pfs->xendev, XenbusStateClosing);
> > -        xen_9pfs_disconnect(&xen_9pfs->xendev);
> > +        aio_bh_schedule_oneshot(qemu_get_aio_context(),
> > +                                xen_9pfs_disconnect_bh, &xen_9pfs->xendev);
> > }
> >      return ret;
> >  }
> > @@ -368,10 +375,18 @@ static void xen_9pfs_evtchn_event(void *opaque)
> >  static void xen_9pfs_disconnect(struct XenLegacyDevice *xendev)
> >  {
> >      Xen9pfsDev *xen_9pdev = container_of(xendev, Xen9pfsDev, xendev);
> > +    V9fsState *s = &xen_9pdev->state;
> >      int i;
> > 
> > +    if (!xen_9pdev->rings) {

specifically this check is not sufficient are there can be cases where
rings != NULL but transport is not set and v9fs_reset should not be
called. For instance xen_be_map_grant_ref() returns NULL,
xen_9pfs_connect() go out without calling v9fs_device_realize_common().
s->transport == NULL and also s->fids == NULL but rings != NULL. Later
v9fs_reset calls g_hash_table_get_values(s->fids)



> > +        return;
> > +    }
> > +
> >      trace_xen_9pfs_disconnect(xendev->name);
> > 
> > +    v9fs_reset(s);
> > +    v9fs_device_unrealize_common(s);
> > +
> >      for (i = 0; i < xen_9pdev->num_rings; i++) {
> >          if (xen_9pdev->rings[i].evtchndev != NULL) {
> >             
> > qemu_set_fd_handler(qemu_xen_evtchn_fd(xen_9pdev->rings[i].evtchndev),

See this below. If you agree and add the below to this patch you can add
my Reviewed-by.


diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 3119f01117..fc01791830 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -4530,6 +4530,7 @@ void v9fs_device_unrealize_common(V9fsState *s)
     qp_table_destroy(&s->qpp_table);
     qp_table_destroy(&s->qpf_table);
     g_free(s->ctx.fs_root);
+    s->transport = NULL;
 }
 
 typedef struct VirtfsCoResetData {
diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index edb65a7afc..f0791f9e97 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -384,8 +384,10 @@ static void xen_9pfs_disconnect(struct XenLegacyDevice *xendev)
 
     trace_xen_9pfs_disconnect(xendev->name);
 
-    v9fs_reset(s);
-    v9fs_device_unrealize_common(s);
+    if (s->transport) {
+        v9fs_reset(s);
+        v9fs_device_unrealize_common(s);
+    }
 
     for (i = 0; i < xen_9pdev->num_rings; i++) {
         if (xen_9pdev->rings[i].evtchndev != NULL) {


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C2FC4452B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 11:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmrU0-0007K6-77; Thu, 23 Jul 2026 07:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wmrTy-0007Jl-Qt; Thu, 23 Jul 2026 07:20:54 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wmrTx-0005CQ-7Y; Thu, 23 Jul 2026 07:20:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=ObMjv2Z3q3+LlLbs1qOTkr5WBbCMzCozqfb4eg5lmV0=; b=lE/OBqHrpKgq/jZTk0iMERQOlx
 Q9ZL/9lmhv8c3vC+zV6V7ZjB0TPEqSoEURUnlaXZu6shji/bU4SmPx6wBvAtohswzSRc5iTm8PF4D
 MvwTeLGOh0Fp/qEK9UqWMbPBkEO53YlteCQgTxjs2WKbw/YtmwDaOn0bHvc59se6C/hNGROmnzmMp
 LPIS7ZGoBSxai54my+xNJv8mRh32KQyzkco6sfEV8a+qGZdNQZaLP2bICz1/+76g1yWP0mj7P0K1e
 d+WPiLYmkS3k7JKEu0Rc4ZznUdMYcHWG/WQaz+1lAOS5m8txZlGTwVqWAUZkNBH2Y9tMR33eSGWtn
 duOCmk4WrT86Pt1vYvsDa7Lm5os3CwWUgV0mJjSyzOxoWkHXPewQfn1IEnfYQ5ovJ5bUVA7zYNp1u
 ObDSvOq/b3pYRWG9aNZEZs+zGeuBPj9Oa9WubUes7j4gmrDFpK8zVrI+9vMHA8b5itUXf9NdAtZSg
 5hN9FfYKuZKQCn3yvl6/qyXl5QTXIA9BRFxtZcBj7N4Xrxyh5TcOpVluRsGe4gAEmIvu+hKpBBuT5
 CUYayMRuS1vi0lG20ZY013Rowlwtq/0dR0jeqZ9s79D/4JO0gq9b6zoshkC5PD2XMvs9rLSTrLN1Y
 oKseWWXgBCanzq7Wm1V4omXzdV6DZwYOO7zwy+Gxg=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>, 
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH v2 2/2] hw/9pfs/xen: drain in-flight PDUs before xen-9p
 disconnect
Date: Thu, 23 Jul 2026 13:20:46 +0200
Message-ID: <6287622.lOV4Wx5bFT@weasel>
In-Reply-To: <alpine.DEB.2.22.394.2607221815520.5295@ubuntu-linux-20-04-desktop>
References: <cover.1784392605.git.qemu_oss@crudebyte.com>
 <6012362.DvuYhMxLoT@weasel>
 <alpine.DEB.2.22.394.2607221815520.5295@ubuntu-linux-20-04-desktop>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On Thursday, 23 July 2026 03:17:12 CEST Stefano Stabellini wrote:
> On Wed, 22 Jul 2026, Christian Schoenebeck wrote:
[...]
> > > @@ -368,10 +375,18 @@ static void xen_9pfs_evtchn_event(void *opaque)
> > > 
> > >  static void xen_9pfs_disconnect(struct XenLegacyDevice *xendev)
> > >  {
> > >  
> > >      Xen9pfsDev *xen_9pdev = container_of(xendev, Xen9pfsDev, xendev);
> > > 
> > > +    V9fsState *s = &xen_9pdev->state;
> > > 
> > >      int i;
> > > 
> > > +    if (!xen_9pdev->rings) {
> 
> specifically this check is not sufficient are there can be cases where
> rings != NULL but transport is not set and v9fs_reset should not be
> called. For instance xen_be_map_grant_ref() returns NULL,
> xen_9pfs_connect() go out without calling v9fs_device_realize_common().
> s->transport == NULL and also s->fids == NULL but rings != NULL. Later
> v9fs_reset calls g_hash_table_get_values(s->fids)
> 
> > > +        return;
> > > +    }
> > > +
> > > 
> > >      trace_xen_9pfs_disconnect(xendev->name);
> > > 
> > > +    v9fs_reset(s);
> > > +    v9fs_device_unrealize_common(s);
> > > +
> > > 
> > >      for (i = 0; i < xen_9pdev->num_rings; i++) {
> > >      
> > >          if (xen_9pdev->rings[i].evtchndev != NULL) {
> > > 
> > > qemu_set_fd_handler(qemu_xen_evtchn_fd(xen_9pdev->rings[i].evtchndev),
> 
> See this below. If you agree and add the below to this patch you can add
> my Reviewed-by.
> 
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 3119f01117..fc01791830 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -4530,6 +4530,7 @@ void v9fs_device_unrealize_common(V9fsState *s)
>      qp_table_destroy(&s->qpp_table);
>      qp_table_destroy(&s->qpf_table);
>      g_free(s->ctx.fs_root);
> +    s->transport = NULL;
>  }
> 
>  typedef struct VirtfsCoResetData {
> diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
> index edb65a7afc..f0791f9e97 100644
> --- a/hw/9pfs/xen-9p-backend.c
> +++ b/hw/9pfs/xen-9p-backend.c
> @@ -384,8 +384,10 @@ static void xen_9pfs_disconnect(struct XenLegacyDevice
> *xendev)
> 
>      trace_xen_9pfs_disconnect(xendev->name);
> 
> -    v9fs_reset(s);
> -    v9fs_device_unrealize_common(s);
> +    if (s->transport) {
> +        v9fs_reset(s);
> +        v9fs_device_unrealize_common(s);
> +    }
> 
>      for (i = 0; i < xen_9pdev->num_rings; i++) {
>          if (xen_9pdev->rings[i].evtchndev != NULL) {

Agreed, these two changes makes sense. I'll formally send a v3 with these two 
changes added now.

My plan is to send a PR with this and other fixes tomorrow already, as we're 
getting very close to release.

Thanks Stefano!

/Christian




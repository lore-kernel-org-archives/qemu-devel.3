Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F54C44539
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 09:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmTER-0006wi-MZ; Wed, 22 Jul 2026 05:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wmTEQ-0006v4-Ov; Wed, 22 Jul 2026 05:27:14 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wmTEO-00054y-Rl; Wed, 22 Jul 2026 05:27:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=JV+6R3Z+uApSS66FpMIjveS11Gn6G09dxlql/5NK+qU=; b=mieZ9XUeuUFykIfBZdy1HX8mIy
 nLVbfEKN37uV1TRpimjAd/UHAVSz6ol98cz5L9eBjWUTpi9IgSsfr1Tr9+IUlcS5iXKgqCUly61LN
 0T4hu2jo5fqc8ePA3ATMlYAnE//i7xa+tZ8R9u/t9cGKkrbLfATellY+2uXwdvFpGJKSURRDK4bUy
 Nq4bhnfyTu1g801yGb7A/TcSvmusfE2OMZQw5SIq4LOvtwpi3yrfihPQenwG0YR2ifR4Jk/1VC2+5
 aDoi9nNdGvQHCPJTPPgiK2FHKuhtg03WPSiDPBZunhYa5g8IeueGUxtfz9WKa0p9mdQmbFdwgVu9x
 jkVYfgAGqKuRw1U4yaIlTtP06hJhhOeHzRxov88KlBrE73sf+eO0koQiZu2EYZeyY5ZSdqttKL9WV
 pQtF97ypsopiuY3CRBRjwMnen6WNJk6MhVCwbHGP6wJtdto2zUDNDQOZYJakiS3tWxU4z73oXhipr
 obdI1Wqkabm8BWMXbtvk6vdEgpHhtgmVRrW60XpSmh4CPr1k9c7TQAXBsz2sUGZgkhMAii2uxlG7i
 C0q8U+CPHsqES13eZgnzUbSQDVfh3JMiQuarKBpaQXvj/w14hVTFbktnLRMEpxSv2rdi/dJNyMp5q
 nDn8cF3knFQE0bzZV0i3eUnUBCKYN2rFiGX//YrL0=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>, 
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH v2 2/2] hw/9pfs/xen: drain in-flight PDUs before xen-9p
 disconnect
Date: Wed, 22 Jul 2026 11:27:08 +0200
Message-ID: <6012362.DvuYhMxLoT@weasel>
In-Reply-To: <afbe101f9fef3110d79023c604be0b28006cfb60.1784392605.git.qemu_oss@crudebyte.com>
References: <cover.1784392605.git.qemu_oss@crudebyte.com>
 <afbe101f9fef3110d79023c604be0b28006cfb60.1784392605.git.qemu_oss@crudebyte.com>
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

Hi Stefano,

chance that you might be looking at this v2 Xen patch soon? If not, just let 
me know, then I'll send out a PR with other fixes piled up on my side in the 
meantime, as QEMU release window narrows.

/Christian 

On Saturday, 18 July 2026 18:50:06 CEST Christian Schoenebeck wrote:
> The xen-9p disconnect path has two issues:
> 
> 1. It frees the Xen9pfsRing structures while in-flight PDUs may still
>    reference them via pdu->tag to index rings[]. This causes a UAF
>    in xen_9pfs_push_and_notify() when worker threads resume after
>    completing filesystem operations.
> 
> 2. It never calls v9fs_device_unrealize_common(), which means server
>    state (struct LocalData, mountfd, FIDs) is never cleaned up on
>    disconnect, causing a resource leak on every guest-initiated
>    disconnect.
> 
> Fix both by draining in-flight PDUs via v9fs_reset() before tearing
> down rings, and calling v9fs_device_unrealize_common() to clean up
> server state.
> 
> Additionally, explicit calls of xen_9pfs_disconnect() in the error
> paths of xen_9pfs_pdu_vmarshal() and xen_9pfs_pdu_vunmarshal() must
> be deferred (via aio_bh_schedule_oneshot()), because
> xen_9pfs_pdu_v(un)marshal() are running within a coroutine context
> which makes them unsafe [1] for calling v9fs_reset() directly, as
> the latter e.g. has a loop like:
> 
>     while (!QLIST_EMPTY(&s->active_list)) {
>         aio_poll(qemu_get_aio_context(), true);
>     }
> 
> which would a) never terminate (as the coroutine is on the
> active_list) and b) aio_poll() is marked as no_coroutine_fn.
> 
> [1] https://lore.kernel.org/qemu-devel/3351181.5fSG56mABF@weasel/
> 
> And finally, add an idempotent guard to xen_9pfs_disconnect(),
> just for the case.
> 
> Fixes: b37eeb0201 ("xen/9pfs: introduce Xen 9pfs backend")
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  hw/9pfs/xen-9p-backend.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
> index 24c90d97ec..edb65a7afc 100644
> --- a/hw/9pfs/xen-9p-backend.c
> +++ b/hw/9pfs/xen-9p-backend.c
> @@ -68,6 +68,11 @@ typedef struct Xen9pfsDev {
> 
>  static void xen_9pfs_disconnect(struct XenLegacyDevice *xendev);
> 
> +static void xen_9pfs_disconnect_bh(void *opaque)
> +{
> +    xen_9pfs_disconnect(opaque);
> +}
> +
>  static void xen_9pfs_in_sg(Xen9pfsRing *ring,
>                             struct iovec *in_sg,
>                             int *num,
> @@ -150,7 +155,8 @@ static ssize_t xen_9pfs_pdu_vmarshal(V9fsPDU *pdu,
>                        "Failed to encode VirtFS reply type %d\n",
>                        pdu->id + 1);
>          xen_be_set_state(&xen_9pfs->xendev, XenbusStateClosing);
> -        xen_9pfs_disconnect(&xen_9pfs->xendev);
> +        aio_bh_schedule_oneshot(qemu_get_aio_context(),
> +                                xen_9pfs_disconnect_bh, &xen_9pfs->xendev);
> }
>      return ret;
>  }
> @@ -173,7 +179,8 @@ static ssize_t xen_9pfs_pdu_vunmarshal(V9fsPDU *pdu,
>          xen_pv_printf(&xen_9pfs->xendev, 0,
>                        "Failed to decode VirtFS request type %d\n",
> pdu->id); xen_be_set_state(&xen_9pfs->xendev, XenbusStateClosing);
> -        xen_9pfs_disconnect(&xen_9pfs->xendev);
> +        aio_bh_schedule_oneshot(qemu_get_aio_context(),
> +                                xen_9pfs_disconnect_bh, &xen_9pfs->xendev);
> }
>      return ret;
>  }
> @@ -368,10 +375,18 @@ static void xen_9pfs_evtchn_event(void *opaque)
>  static void xen_9pfs_disconnect(struct XenLegacyDevice *xendev)
>  {
>      Xen9pfsDev *xen_9pdev = container_of(xendev, Xen9pfsDev, xendev);
> +    V9fsState *s = &xen_9pdev->state;
>      int i;
> 
> +    if (!xen_9pdev->rings) {
> +        return;
> +    }
> +
>      trace_xen_9pfs_disconnect(xendev->name);
> 
> +    v9fs_reset(s);
> +    v9fs_device_unrealize_common(s);
> +
>      for (i = 0; i < xen_9pdev->num_rings; i++) {
>          if (xen_9pdev->rings[i].evtchndev != NULL) {
>             
> qemu_set_fd_handler(qemu_xen_evtchn_fd(xen_9pdev->rings[i].evtchndev),






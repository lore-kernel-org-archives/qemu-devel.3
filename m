Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12BE6CD8C8E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:44:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWUdg-0005nr-4d; Mon, 08 Jun 2026 03:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wWUdf-0005nI-1u; Mon, 08 Jun 2026 03:43:15 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wWUdd-00020d-LC; Mon, 08 Jun 2026 03:43:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=Kn35hDnaSLjae/Yd0ULCdnsIN2Ar34hDYqCT3UNMT0g=; b=nhd+3Kq9ytPBvqxRwi24BaVF7D
 KrHeIw3WW1qAiIc7cfh0+g4xK2X+kwVESE3ejglA74ZiNEXd/2d7Djo6isSeXNCXKW+J96sUzhs71
 a2istru4I4sXtoFtb0bXNMcdySa51Dg9dgEbyMRfdcexyvZsaglnhGjAOaYaSQUK16gDmmfm0bmfq
 AF42WO75ggflNpe5bRP+TDltsvwsjiOcnUdEayyXPpbjax90Hu338wu2/G3YFS82SI7ZHNC6WA11f
 1ZntE4y1hPM2QU1uzzMLCe38qCh8cgI22+tgbvTfGGkIFGrd8VZDaBNdVMfyRwbTn/qSwvct4LdZY
 dfc2Ek6uruNA16+2ll/vkfXmlxcm3NzsInnzjtGbFVcAuXAZq6B/k6EP6q+PFrUnQV0Lnz3P0lBSP
 OLDX/f6Y90bOYjyd5XReO0b5f79Mo6jr+2xRTcGbotQ4uSK0qgZB4DqUyp0nCdObX9gXdpSErGx7x
 ytp5XjTU+fsFkcyaAKxPKAWf/Yc0ZQcjpzCX8XHxOTWY+H5NJR/yJp5v1oIKqdAK4hWmVunhk2obw
 bRS3/gQ7QRKRjm26NT2qg8L1wysDVAOemRbTZApb1iSnRXfdzutrrlrhdWr2kq4kJ3i/bjLdlPQ6q
 /ChbQ84WjGbQAnB+9HkAqmxye7QIlNeJaRF2rrw2A=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>, 
 Feifan Qian <bea1e@proton.me>, Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH 3/8] 9pfs/xen: implement msize_limit callback
Date: Mon, 08 Jun 2026 09:43:07 +0200
Message-ID: <5999446.DvuYhMxLoT@weasel>
In-Reply-To: <7f592f8cdeeea8b91998363ad9599dfb1f2b3108.1779916560.git.qemu_oss@crudebyte.com>
References: <cover.1779916560.git.qemu_oss@crudebyte.com>
 <7f592f8cdeeea8b91998363ad9599dfb1f2b3108.1779916560.git.qemu_oss@crudebyte.com>
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

would you have a chance to look at this Xen patch 3 and patch 7 whether I am 
doing it right for Xen?

/Christian

On Wednesday, 27 May 2026 23:15:25 CEST Christian Schoenebeck wrote:
> Add and implement the msize_limit callback for the Xen transport.
> 
> The limit is calculated using XEN_FLEX_RING_SIZE() based on the
> negotiated ring_order. For the theoretical maximum ring_order of 9,
> this results in a maximum 'msize' of 1048576 bytes (1 MiB).
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  hw/9pfs/xen-9p-backend.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
> index ca0fff5fa9..94654022fe 100644
> --- a/hw/9pfs/xen-9p-backend.c
> +++ b/hw/9pfs/xen-9p-backend.c
> @@ -250,12 +250,19 @@ static void xen_9pfs_push_and_notify(V9fsPDU *pdu)
>      qemu_bh_schedule(ring->bh);
>  }
> 
> +static size_t xen_9p_msize_limit(V9fsState *s)
> +{
> +    Xen9pfsDev *xen_9pfs = container_of(s, Xen9pfsDev, state);
> +    return XEN_FLEX_RING_SIZE(xen_9pfs->rings[0].ring_order);
> +}
> +
>  static const V9fsTransport xen_9p_transport = {
>      .pdu_vmarshal = xen_9pfs_pdu_vmarshal,
>      .pdu_vunmarshal = xen_9pfs_pdu_vunmarshal,
>      .init_in_iov_from_pdu = xen_9pfs_init_in_iov_from_pdu,
>      .init_out_iov_from_pdu = xen_9pfs_init_out_iov_from_pdu,
>      .push_and_notify = xen_9pfs_push_and_notify,
> +    .msize_limit = xen_9p_msize_limit,
>  };
> 
>  static int xen_9pfs_init(struct XenLegacyDevice *xendev)






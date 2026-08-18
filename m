Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8566C5DF70
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 08:12:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwEvU-0006J5-3T; Tue, 18 Aug 2026 04:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wwEvR-0006It-U9
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 04:12:02 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wwEvP-0005Wb-GR
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 04:12:01 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 67I8Bm6M088594
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 18 Aug 2026 17:11:48 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=L/YLXaumlBAZuWGTLxJCs5yIbeBZ/gjDX6JvcNsLNhI=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1787040709; v=1;
 b=CoarY2J6CJXj9/8hDRMITiN2do1lSBWSOquxFjk23WsNaurNurTTtebqcv6Hmvrh
 F3cSp6AN3NFEH58lP+PK9WRUaN4hwlsUnpyteO6MVw2EA+ociC1XG/AVWCFmY4UP
 Cjfj9CdpHYcuyXqRWwxitjYppxl4uZ1iMBaauRZLEsVp1LsI34I9OYy4YCmSaSea
 EJCY9gvGlloOfn0uyVCZeSEcWpJoGgLf8z0Wozycv0LG9SHS1owt2yNbKbvEQswn
 HBU3WpbXrpBWObC7usp4YOi52Rx4sR6cVg2iQ6ZG5Ii0k64twjIBDCDNmc4p7k4q
 9RpxHP4aLKTXyJgrk7lcgA==
Message-ID: <986f5be3-8022-439b-b6bb-d5d73b01389d@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 18 Aug 2026 17:11:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/virtio/vhost-shadow-virtqueue: range boundary in
 translation
To: Connor Kite <connorkite@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20260817233147.2867623-1-connorkite@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260817233147.2867623-1-connorkite@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 2026/08/18 8:31, Connor Kite wrote:
> iova-tree expects inclusive range sizing when maps are allocated or searched.
> Currently, svqs use exclusive sizing when searching their
> vhost-iova-tree for a match to the region to be translated.  This could
> lead to errors if the region to be translated is at the edge of an iova
> region.
> 
> Fix this by reducing `needle.size` by 1 in
> vhost_svq_translate_addr to bring it in line with DMAMap and iova-tree
> convention.
> 
> The only current user of svq->iova_tree is hw/virtio/vhost-vdpa.c, which
> also treats size as inclusive when using the tree API.  In progress work
> on vhost-user isolation mode in hw/virtio.vhost-vdpa.c also uses
> inclusive sizing when interacting with the tree.

Please correct hw/virtio.vhost-vdpa.c to hw/virtio/vhost-user.c. The 
former does not exist and misidentifies where the vhost-user isolation 
work lives.

> 
> This patch is an updated version of one from the patch series "vhost-user:
> isolated memory".  The patch has been isolated from the series as it
> is not tightly coupled with the rest of the series.
> 
> Signed-off-by: Connor Kite <connorkite@gmail.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Please add the required trailer:

     Fixes: 34e3c94edaef ("vdpa: Add custom IOTLB translations to SVQ").

That commit introduced the oversized needle, and QEMU policy requests a
Fixes: trailer for in-tree regressions.

Regards,
Akihiko Odaki

> ---
> V2 Differences:
> - Context added about users of svq->iova_tree and their adoption of
>    inclusive sizing
> 
>   hw/virtio/vhost-shadow-virtqueue.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
> index bcb7f2ffc7..c8831d52be 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -99,19 +99,25 @@ static bool vhost_svq_translate_addr(const VhostShadowVirtqueue *svq,
>           const DMAMap *map;
>           DMAMap needle;
>   
> +        if (unlikely(iovec[i].iov_len == 0)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "Zero-sized buffer made available by guest");
> +            return false;
> +        }
> +
>           /* Check if the descriptor is backed by guest memory  */
>           if (gpas) {
>               /* Search the GPA->IOVA tree */
>               needle = (DMAMap) {
>                   .translated_addr = gpas[i],
> -                .size = iovec[i].iov_len,
> +                .size = iovec[i].iov_len - 1,  /* Inclusive */
>               };
>               map = vhost_iova_tree_find_gpa(svq->iova_tree, &needle);
>           } else {
>               /* Search the IOVA->HVA tree */
>               needle = (DMAMap) {
>                   .translated_addr = (hwaddr)(uintptr_t)iovec[i].iov_base,
> -                .size = iovec[i].iov_len,
> +                .size = iovec[i].iov_len - 1, /* Inclusive */
>               };
>               map = vhost_iova_tree_find_iova(svq->iova_tree, &needle);
>           }



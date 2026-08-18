Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3901DC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 14:02:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwKO0-0000qq-0k; Tue, 18 Aug 2026 10:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wwKNy-0000qd-73
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 10:01:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wwKNw-0005Ws-JX
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 10:01:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787061706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8P6rlRc0IotFwUiZqkjJ1qTxK983nNc9+cVkAsxmQog=;
 b=WJfKMaecqBd0FRII45kGxzNjlEijXv6H3DVnXohJSD/+zL5e5e+RxiPBBdlTeAZouGcsiy
 0HvV6eqvcFePC8d/WalSzpwgh7Ip24ZJV8XUTB7NW/S+5SiT+3FIGXW+jFEEKctWRVf7mT
 9tbjCuki8cUTDvUR7hxONwHvOR8kYEQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-8ycA2BFRPnK4sej72RKu5Q-1; Tue, 18 Aug 2026 10:01:42 -0400
X-MC-Unique: 8ycA2BFRPnK4sej72RKu5Q-1
X-Mimecast-MFC-AGG-ID: 8ycA2BFRPnK4sej72RKu5Q_1787061701
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-47f6db77430so2536331f8f.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 07:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787061701; x=1787666501; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8P6rlRc0IotFwUiZqkjJ1qTxK983nNc9+cVkAsxmQog=;
 b=TzPi546T4V3Kdwqa+8VQB6AWYa9IPvpGBJsmHBzEMh0qWaWEbu8W8iStOWDKhIJ0LG
 Cj+o8ahXVSe5LsbxcWemoBDq2y8BNKgM/GfW+I8f6zaQMzZCz+L8Gox4ESdfrBNFdrXn
 NE5MsQXz2O67Aac3HoL/C0qIYouJtj6rbOi/wWJkrMlqEHXTCIaezeA/SsKuvhSwjpjY
 IyLWJgJmxLEZCmvZxNPihEGyZFQxmCmSv9oZMakB0CSBnQhLFYOyZu+mxJ9TFgK8LgcT
 vfrt5Bk56+/Ey7LAC8W+GFG2+SBEOkzOpiSASPxbF6Ut/QqdXzvflhxpEn4+rfWTYL15
 a1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787061701; x=1787666501;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8P6rlRc0IotFwUiZqkjJ1qTxK983nNc9+cVkAsxmQog=;
 b=QCiaiiS7zLS+ajGR0Q71DMXocYw2T9gvfWXN5bynF1YJznlrTLZeASXBNUOhREs4So
 DJBAM0IbFRZFhoXA2g40UBGrDUhVCBX4q7kg0RCHXbcnMOIk8Jl2X6ccPwSG7cqrx/7p
 beE2Woqow7BlSgxaofqivmWiU1LWPMhqfTKFsR7EHp60hHuyemN9FcAKy7kfjd+AMIx5
 uYRuh85nnUHZN1/Sf0rhVN97pGGv7g49B+AimKdWk5LvljBNz87K0oXJp0bURy0kDBvU
 Wbeo7mfMRpTliNPIrKq5ba5VD/BEiQ+vTPNlWBMarrQRP2E8iM7Mvy/IRL71rgN2agIv
 tffg==
X-Gm-Message-State: AOJu0YxAnc9e+MSBNO+7czstNEWMLgEpsm19iJ/DkGA0GXPs5giEq6OY
 z9sQfbScZjHmXa5HEe+D3SpW9CgD0i4UlAdnxFdKHFWDdaiz+cXbSdPAFJAIQbrdpVpjg31vb67
 HzsrbBAyrPigQkfdUBXqRd7AD82T1CwFIP8Y2oAQLQeGumnCFQCJke5aW
X-Gm-Gg: AR+sD11Iqfb0tsDp9dsGcu69xR1JSAWhiyjSdzRAZxnN8uL/dPnYWD9xLdnluUbtyg4
 opxWiQlaJGQypXUD/lQuXScvJ9b9/xlSM42GbKXepYFJsz9mOCKMVQhpNydJXSQlGpI9zDsZGsC
 4I+lTsQspOLAryOIZYzk9D8Uf81931vuAubyKVWdZFhG3c8Ni7xpJcyMHcMbmtSmP73WS64/rGc
 1xnK1kpQmFGyHMABP5zVyvC2HOcvOGZzByVdP59xXl1gpBlEgph65HAf644cEHyl5KEfqviT3bf
 sZmLPKnoLRz82MSsqQrBVotCGhx3S/WNHPAXKMlDJPy79chAzbo0gUMNYfkhyFRlqHR/2NBT4wG
 rhuELH3Kc9jJIOi0LLS4IkS9ODKLkPHti6KxxsaG4uEt59m/gVluU
X-Received: by 2002:a05:6000:4a01:b0:47f:7b75:9dfe with SMTP id
 ffacd0b85a97d-482a9109c9bmr15558348f8f.8.1787061701397; 
 Tue, 18 Aug 2026 07:01:41 -0700 (PDT)
X-Received: by 2002:a05:6000:4a01:b0:47f:7b75:9dfe with SMTP id
 ffacd0b85a97d-482a9109c9bmr15558143f8f.8.1787061700773; 
 Tue, 18 Aug 2026 07:01:40 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it.
 [82.53.135.154]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a3b51asm12372495f8f.11.2026.08.18.07.01.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 07:01:40 -0700 (PDT)
Date: Tue, 18 Aug 2026 16:01:28 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Connor Kite <connorkite@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Czenczek <hreitz@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PATCH v2] hw/virtio/vhost-shadow-virtqueue: range boundary in
 translation
Message-ID: <aoRk1B1XzjXZQCCJ@sgarzare-redhat>
References: <20260817233147.2867623-1-connorkite@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260817233147.2867623-1-connorkite@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Mon, Aug 17, 2026 at 04:31:47PM -0700, Connor Kite wrote:
>iova-tree expects inclusive range sizing when maps are allocated or searched.
>Currently, svqs use exclusive sizing when searching their
>vhost-iova-tree for a match to the region to be translated.  This could
>lead to errors if the region to be translated is at the edge of an iova
>region.
>
>Fix this by reducing `needle.size` by 1 in
>vhost_svq_translate_addr to bring it in line with DMAMap and iova-tree
>convention.
>
>The only current user of svq->iova_tree is hw/virtio/vhost-vdpa.c, which
>also treats size as inclusive when using the tree API.  In progress work
>on vhost-user isolation mode in hw/virtio.vhost-vdpa.c also uses
>inclusive sizing when interacting with the tree.
>
>This patch is an updated version of one from the patch series "vhost-user:
>isolated memory".  The patch has been isolated from the series as it
>is not tightly coupled with the rest of the series.
>
>Signed-off-by: Connor Kite <connorkite@gmail.com>
>Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>---
>V2 Differences:
>- Context added about users of svq->iova_tree and their adoption of
>  inclusive sizing
>
> hw/virtio/vhost-shadow-virtqueue.c | 10 ++++++++--
> 1 file changed, 8 insertions(+), 2 deletions(-)
>
>diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
>index bcb7f2ffc7..c8831d52be 100644
>--- a/hw/virtio/vhost-shadow-virtqueue.c
>+++ b/hw/virtio/vhost-shadow-virtqueue.c
>@@ -99,19 +99,25 @@ static bool vhost_svq_translate_addr(const VhostShadowVirtqueue *svq,
>         const DMAMap *map;
>         DMAMap needle;
>
>+        if (unlikely(iovec[i].iov_len == 0)) {
>+            qemu_log_mask(LOG_GUEST_ERROR,
>+                          "Zero-sized buffer made available by guest");
>+            return false;
>+        }
>+
>         /* Check if the descriptor is backed by guest memory  */
>         if (gpas) {
>             /* Search the GPA->IOVA tree */
>             needle = (DMAMap) {
>                 .translated_addr = gpas[i],
>-                .size = iovec[i].iov_len,
>+                .size = iovec[i].iov_len - 1,  /* Inclusive */
                                                ^
nit: double spaces here...

>             };
>             map = vhost_iova_tree_find_gpa(svq->iova_tree, &needle);
>         } else {
>             /* Search the IOVA->HVA tree */
>             needle = (DMAMap) {
>                 .translated_addr = (hwaddr)(uintptr_t)iovec[i].iov_base,
>-                .size = iovec[i].iov_len,
>+                .size = iovec[i].iov_len - 1, /* Inclusive */
                                                ^
... single here.
If you need to respin, maybe we can be consistent and fix it.

Anyway with Akihiko's comments fixed:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks for the fix!
Stefano



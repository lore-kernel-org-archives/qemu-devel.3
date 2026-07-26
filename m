Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83F0C53209
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 21:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo6PN-0007Nc-22; Sun, 26 Jul 2026 17:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6PL-0007My-AI
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:29:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6PJ-0004Dq-Pr
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785101353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xnGxe0jkG1lNShK18kxOqzqH8UEJGkWTyew4MAy9aKU=;
 b=Av6EeHCYOvr8M5LKGUcIH1wwaw1jEF3LFtnj3aXYoltTcPiJUrUWeD7qCa7wWIWM5qen+9
 WksnpKl7cXBLCgsn4wi8e+W9eLep2+x9jdJ2eRwdW88/1YnUooxCduL1+CEiRzZmdOhnMM
 /PVJfL9FYpVJLwVG2rvmd/B2K/G/RgA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-2qRKdKmcO9y1UEt61NT9UQ-1; Sun, 26 Jul 2026 17:29:11 -0400
X-MC-Unique: 2qRKdKmcO9y1UEt61NT9UQ-1
X-Mimecast-MFC-AGG-ID: 2qRKdKmcO9y1UEt61NT9UQ_1785101350
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-472a798fc7cso1344596f8f.1
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 14:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785101350; x=1785706150; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xnGxe0jkG1lNShK18kxOqzqH8UEJGkWTyew4MAy9aKU=;
 b=alIdRRakaq+43FFuCnAkgxtS4quolIf6wsymqF/OwstZQwq9BxAOdwqSoJhL18hkZE
 pfZCM+RMjgNDQyDNa8Y+jN6aEKRiqIJLHbqcXBIrUj1CmsPTF41Yftatz+ImPG7ByQnv
 1fiRYnWZYp+9Phzs0MlE5W6fgF2g67xV0Ql2SSO6Kn7mcJX1MoH9TyQHUUV1b6foX5fb
 +uHsTyEzA0QKiq063jEgIh5oAkb/faLGm4rocRbd+UVQ0LCDU2TwDxFCk504YO+XyHEK
 SQ7d8GPhKEMBzLwMBgdosXP99MtcQ2iGx0TUBx5tHWAVndgqNHPqhJd9IdFqQyFH1tZX
 P3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785101350; x=1785706150;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xnGxe0jkG1lNShK18kxOqzqH8UEJGkWTyew4MAy9aKU=;
 b=hNOvpaZEI5Zztt2ah/tlCN1DPO4ZDGd0XFLzCJWzY60DrtiX0eD9IF3O/znTt5NV0o
 gycls0rjFD8HXhuXOD1HwzibxbAjQweITdGuBmhFCs9aRCEdsQswjlV65jF+AEy2JOHU
 FI+OLxqb5hkUzp25+nLVOD8reXl8pzqKq4rWFq2ewObzh08/gbeseFhhNCnDtXxXsaJT
 4yWe5jrVkPko+cbVTxBLLsRyyVq7srJ6uIdft87dMBEa+/FxPdZ79z3nunEYSMAd9xbg
 jIhV5uric80FPZw1dxKLKllqmVAW+lxvvBJxVMot858Epj+NV8sxpGBMoeg0Hn1ls7hm
 9sBA==
X-Gm-Message-State: AOJu0YzdDgO7+GMH6IcDoCBQB1zWFDgWHZfJWO/OYEmzAS5wSyvFu+uR
 1fQGXF6yES8E554RZIJgEfq+1VGR5sXp+nCIKfEELQmsfftgmnbFK9ik/4KR7yNjl5PYX43CmNo
 KW4uRLnJOPOG0Gcqf+Dnlm1AakwfShUsugU1wJRbApSokfereNMCJpQp0hGivFubAF4FGkpakKQ
 cJms+pNnbUmpDeD+sNoBNWGUGEFzUCgnd4IA==
X-Gm-Gg: AR+sD11HT/ruTymxp8t+ZHJSnWYRoTLZ7yG8xxqnt+unkPfFm09YOE+EtN7x/HROfcX
 /kvCKQW5S7xdnGtT2C/YIM1KK7v17CyT1LLTAMBu9D+QnN44KvjuyudszVlFvHSgIhmzDvAmVUz
 NW0aJXAoY7QNqcdHi4UOedhjWGnHyT6MN3xK4/5GVxIoUDqQuPyjNWDHd2AyR2tiGTDargYrnBw
 aUbtBNc/lyBo4l0Ws1DaAOiM/moPlikQM4nNiCLDzcYs/ZnTXI7RNMUldnhCd9cwJEl15efIXjZ
 Hw1mnah45S+K3R1O2k4b/6kcHahY6NgfGF0L9JbO/NjrkoXpRV2fT7fnM+hAu4AV1cKKEOnRbsB
 ZIMl9v6Nj6fXLY51h0ghRIA==
X-Received: by 2002:a05:6000:41ec:b0:47f:97e9:fe54 with SMTP id
 ffacd0b85a97d-47f9feb7c17mr7635376f8f.58.1785101350350; 
 Sun, 26 Jul 2026 14:29:10 -0700 (PDT)
X-Received: by 2002:a05:6000:41ec:b0:47f:97e9:fe54 with SMTP id
 ffacd0b85a97d-47f9feb7c17mr7635364f8f.58.1785101349785; 
 Sun, 26 Jul 2026 14:29:09 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6dc25sm42026184f8f.33.2026.07.26.14.29.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 14:29:09 -0700 (PDT)
Date: Sun, 26 Jul 2026 17:29:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>
Subject: [PULL 03/30] virtio-net: fix short frame OOB read in receive_filter()
Message-ID: <9cb58c11d505ebfbc32a71b84578f617c0c1947f.1785101237.git.mst@redhat.com>
References: <cover.1785101237.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785101237.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

Within virtio-net, receive_filter() reads Ethernet header fields without
any length checks.

But virtio-net sets do_not_pad in NetClientState, so backends such as
socket forward frames at the size supplied by the peer without padding
to the Ethernet minimum. A short frame thus causes an out-of-bounds
read.

Add size checks in receive_filter() and drop the truncated frames.

Fixes: CVE-2026-63320
Fixes: 3831ab2094 ("qemu:virtio-net: Enable filtering based on MAC, promisc, broadcast and allmulti (Alex Williamson)")
Cc: Jason Wang <jasowangio@gmail.com>
Cc: Alex Williamson <alex@shazbot.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3626
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <ee5c77b96ab66b2dd518f146def8727216a5c495.1784895727.git.mst@redhat.com>
---
 hw/net/virtio-net.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 2761644dfd..7e0c984ec6 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1744,10 +1744,21 @@ static int receive_filter(VirtIONet *n, const uint8_t *buf, int size)
     if (n->promisc)
         return 1;
 
+    if (size < n->host_hdr_len + 14) {
+        /* Truncated ethernet packet */
+        return 0;
+    }
+
     ptr += n->host_hdr_len;
 
     if (!memcmp(&ptr[12], vlan, sizeof(vlan))) {
-        int vid = lduw_be_p(ptr + 14) & 0xfff;
+        int vid;
+
+        /* Truncated vlan packet */
+        if (size < n->host_hdr_len + 16) {
+            return 0;
+        }
+        vid = lduw_be_p(ptr + 14) & 0xfff;
         if (!(n->vlans[vid >> 5] & (1U << (vid & 0x1f))))
             return 0;
     }
-- 
MST



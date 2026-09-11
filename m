Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D80AC88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4xAm-0004pw-6o; Fri, 11 Sep 2026 05:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x9v-0003iE-3T
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x9t-0008Fd-Lf
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:02:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6dS2LV10xW58XQBK2n8n0ndzTRRlQmRu7LpDRVGCeMs=;
 b=JQLi8KVrBeNHgtBfiZHLN4CQPHIODFFDKuCnxIYevlCMrLyz/DH/bGGaRMgDsLWnwqPK1O
 sP6jm19ksWU9eJfMRefTp5KtHPaOlqiYZQ0UP/f6IKAJxNgGUWtBAh9r4Ce/uZoSu/cXhB
 890xu1wp7YCZgoZoEIoTIVWCZM44vRM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-8g2x9CxTO0GjkVq5xWcNcg-1; Fri, 11 Sep 2026 05:02:55 -0400
X-MC-Unique: 8g2x9CxTO0GjkVq5xWcNcg-1
X-Mimecast-MFC-AGG-ID: 8g2x9CxTO0GjkVq5xWcNcg_1789117375
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49e6683d48fso1172785e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117374; x=1789722174; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6dS2LV10xW58XQBK2n8n0ndzTRRlQmRu7LpDRVGCeMs=;
 b=p+kbw6yt5db1fEbuIkLr8ExXpBnhXKfmeJr2QmHmmJNXbZ+y0k7ffrMY7Nalm2iCrY
 NnasXi/NBr1rWIJWMdyv7+qOWeWjXPxq8qQtZgvZ6IBOaovEgfN04kPpnFv0FuZmhjt7
 44AbttfFVCEg5xEhsSvu1Mm+AR0Fr8Hpv+hE38vsLY4skeuQ/myAZkDvc7oFWry+oxZf
 8uYRyzpE9K0NfWuxAEaOQRrQmZFe1kK880ZmzsgIdDnn/ERspQlLL3oPkkho2VvB252D
 o6Y76ITgwfQCdpNTkDwsSneURHo4uIbi8LVs2U2pWHDMH5w2S8xDsV8pFLLBBHmh6CCl
 7NmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117374; x=1789722174;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6dS2LV10xW58XQBK2n8n0ndzTRRlQmRu7LpDRVGCeMs=;
 b=KuE64pypipL+lSGe/GOvH2LPtDV9SkA9cQrv40zBoTf/MxCMeIJlN6TWkp0TX7BmCh
 VDZRZniIgSQ/dloDm5YSuXCKFqGmOtwpkFkrG0b8QK6D+kBk0CaoKjKs5bbAHgdyHhN9
 b2MT+PO0KaMZVPrAUC+/djBbsjmQ1vw3HtaGy1g6CpARc2nrymrKyIujM/JxbsDsqLh3
 VMqEKEaGI66YL6JGwG7AolIZA++dh+HibTrnb2rP3joE7CSpWb0QYEDZOWlvVNg2Lj6K
 DwuDMh0UaucqYsVbbXnJlN6tUJJkao1kTZwqN7U4NLdRxc+X+oSeiOwe4xkOAtf3qx2p
 W1uA==
X-Gm-Message-State: AFuF++l8iWFZnDDZBDKtRaMKZA1eLMjr/1eD5u0tSLjETR1y7/7Bo/2x
 +UlctWTbFknLZw11SAYAOm8PX4x3WKyEtvoJEI/UJ9jZXZBTGA10NJD+TB/j6Im6id/cQ3XCm9t
 3t0jCp/vKImMfQfTClanpGCWWdHw6Je5kbU3fNdxn/dMcLw1fIJ8P6NYUWozOSZ6mArMYG3gVlw
 GyVE4yXtrKMZ/OfQedI5xivOUWFSSiBxX4Xg==
X-Gm-Gg: AYBFou28TjPZsxOq0PPLwTCrKnXrmlDzW1jzsPA/7KDXQV+L+ZP+ucudw8cKjn1W5SS
 L6VWn+S76po1GTZ8VYMrr3eKz0sulmgHq62ZOMIu8+5v9Fe0fmFSzqRZCt7Gi+vxOqY2it6ijA/
 /rkWXysAocM3hJ1CWuJd9B9R+p9ymT/W2FP6yUsaDjS9VFOvhOBc90I70V22umNy08Yp09XCdE+
 XSa9dGYRgK5RkK2DrNuG+qPx9CGNpBUF/Nk6cQ3iXPdafhPAAk5xjIKpDQsi2uxEw/M3eDF+LAQ
 zMTF6Hj8FYvbtQ10XXtyecLgA5SwgUIhvhNzvLOR0wAzIMIF4Uy3y602+bhzVs2K1cYB7oMlzio
 kKWmMu/lseZZX61O9WGuKlLQ=
X-Received: by 2002:a05:600c:46d3:b0:49c:cfbe:5a76 with SMTP id
 5b1f17b1804b1-49e6197fd2bmr34460945e9.2.1789117374332; 
 Fri, 11 Sep 2026 02:02:54 -0700 (PDT)
X-Received: by 2002:a05:600c:46d3:b0:49c:cfbe:5a76 with SMTP id
 5b1f17b1804b1-49e6197fd2bmr34460175e9.2.1789117373731; 
 Fri, 11 Sep 2026 02:02:53 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c2985dsm239121435e9.6.2026.09.11.02.02.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:02:53 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:02:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 GuoHan Zhao <zhaoguohan@kylinos.cn>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: [PULL v2 39/75] virtio-crypto: clean up every data queue
Message-ID: <6bc7c19eca673e99feb01d431e4c5c4959d4ebc2.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

realize() creates max_queues data queues and one BH for each of them.
unrealize() decides how many to tear down from multiqueue, but nothing ever
sets that field, so it only deletes the first queue and BH.

It does not matter how many queues the guest used here.  unrealize() must
undo all the allocations made by realize(), so loop over max_queues.

Fixes: 20cb2ffd5ff3 ("virtio-crypto: using bh to handle dataq's requests")
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260728111217.573046-1-zhaoguohan@kylinos.cn>
---
 hw/virtio/virtio-crypto.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 79e2acb56c..85c7279aae 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -1114,10 +1114,9 @@ static void virtio_crypto_device_unrealize(DeviceState *dev)
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOCrypto *vcrypto = VIRTIO_CRYPTO(dev);
     VirtIOCryptoQueue *q;
-    int i, max_queues;
+    int i;
 
-    max_queues = vcrypto->multiqueue ? vcrypto->max_queues : 1;
-    for (i = 0; i < max_queues; i++) {
+    for (i = 0; i < vcrypto->max_queues; i++) {
         virtio_delete_queue(vcrypto->vqs[i].dataq);
         q = &vcrypto->vqs[i];
         qemu_bh_delete(q->dataq_bh);
-- 
MST



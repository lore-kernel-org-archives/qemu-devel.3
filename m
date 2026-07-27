Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41847C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 19:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woQrk-00006Y-LR; Mon, 27 Jul 2026 15:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQrf-0008W9-0r
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:19:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQrd-0000LG-Bl
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785179987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gn3znuVi/1agHf4H7bEz33XDAIBlLdDR7MKVnZpeaqY=;
 b=EdKutbJo4P7BT2/ECJ2kOwb4wKchITxIwi4XzaapgijAy2WvKT8i7/GAbIDoIU3BvWuAkZ
 5Nd8kQHhRWw8fvawM+b9gRGpVnz0P1MVALFwdUFTvnHYDRKMILkv/9e1oV0qh9+YrAJGzq
 dV6RFJpHnMBepywBoIlzCzbLy9/mhiE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-uYBMuVAgMCikQUC6_xh3cA-1; Mon, 27 Jul 2026 15:19:44 -0400
X-MC-Unique: uYBMuVAgMCikQUC6_xh3cA-1
X-Mimecast-MFC-AGG-ID: uYBMuVAgMCikQUC6_xh3cA_1785179983
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47f6e8b5996so3132680f8f.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 12:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785179983; x=1785784783; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gn3znuVi/1agHf4H7bEz33XDAIBlLdDR7MKVnZpeaqY=;
 b=Yhos/fbhapPbIKgePgeTZGoG3vALYZiITGJlu0AWoAwhmq9Ia2hWH0wq0mUhtcs7Qf
 gZ77wj9eAkcOpQN0qjFMHx+EKwAImImscGeOzF1SyZ5zlEDK/Sd96cr0X8kJpkrflsEN
 wqF2Jbu+YAEkSiRDmJt7joxDMmjDgDKJcrpJ9zWpxYFTotEts09W4viTc0w/L3LvWoJF
 DDzx8Nqqao9cQHue+ZDSSrU7rRmc8UbkUGzNJTT0CSdqJUCxkBnjG3xiteyeUCyGE8vc
 FjqE3VfbDYBnyYq+qIB2Ny8KItGuJVM0LDosbv/gslRrV0EdbVuk3fbjmSUGjAFo7SA2
 r+5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785179983; x=1785784783;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gn3znuVi/1agHf4H7bEz33XDAIBlLdDR7MKVnZpeaqY=;
 b=P12YngFOE9LP4JSDAQqHOSLJQYlcm96r0N6JTuWclDGp7rXoBxlqos6KaiAauyPJEZ
 04gftZjluPFZ8JZ4zdF+ka+naX3eM4LfH/6ZD3JodnrL1uz1YiQlgYrUxjoNZVg3oIrt
 VvHEv63vHvGYAesaxNBikzKT7PL8dAxQItT738jx1Vo816c6Kd48NCO05455d+VB8sdl
 ako6HQzXXOaw2sLwT1ozupB0NQlF/hb+AiR+7jpVWrV9KIp4tWasQS0dtMo5VG6QqV0S
 4NH1YnMNoH4dbITIt7OPRkKlspYLr43lu8sPkgFKK1zp7Z2rGXGi7iN1h3VqEB2EF9FX
 4ZNw==
X-Gm-Message-State: AOJu0YxXwB1jZ/mKrwkjWF38FaDukdgAGRaJtrOp+Vk89c7Giq6nzv9f
 gsFlaxJFbhZGWFTw4Q6y7j1kZLhwH4wZQeff574T6qprJkTMq1bMp0fS2VKP171D3ueNTVTrnt3
 XOaZ5u6aKIvWHPbcl55fcdBYXy/6L5JaQMIekCW0L+KOFE1nD5eGJlZO4ZRJ+D/bd5VRGAAYqJB
 8E3s+ZL3m/sm90ia7k490FM5kgnTbIzToQ6w==
X-Gm-Gg: AR+sD104MsMA4y4L9My+HEpS5mRct3+UihZ0ppId1boWTia8DTXnJmgTrUmiJfS24pX
 h6j575MzVP1LKV4hLyxy4/8iokcE0lD9brPY8VrmccvynOWrkUlickKBng5UxAE8ln4cEiwY8oF
 y0BeFSjzeRwivd5qWnXWIkjVGUNwQaDhIxOxuO8QBdY2U6EbydhiSKzs3gpV+vIMmr8tLa5ZiEl
 6+Mc9ipoHEJsHzdeXjnY3cnnnme5oDiFbSxvIeOPwMtBQX5SdAqjqc2Dd7TDpF6AF/FMggL+JDN
 BY1l/abCuzkKB2L6QK3m7WxBjW5dczIqI6RhJWwD+52Yjn725jXgs0Bf+QsbDN1OsjsAtxwgzEp
 cKvdWCxWsKH4NwnVWoPsPlw==
X-Received: by 2002:a05:6000:2311:b0:47f:81c4:36b4 with SMTP id
 ffacd0b85a97d-47f9fc8871dmr14046156f8f.14.1785179982792; 
 Mon, 27 Jul 2026 12:19:42 -0700 (PDT)
X-Received: by 2002:a05:6000:2311:b0:47f:81c4:36b4 with SMTP id
 ffacd0b85a97d-47f9fc8871dmr14046114f8f.14.1785179982175; 
 Mon, 27 Jul 2026 12:19:42 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f96d4656bsm34527728f8f.21.2026.07.27.12.19.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 12:19:41 -0700 (PDT)
Date: Mon, 27 Jul 2026 15:19:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowangio@gmail.com>,
 Yuri Benditovich <ybendito@redhat.com>, Wei Xu <wexu@redhat.com>,
 huntr bubble <bubblehuntr@gmail.com>
Subject: [PULL v2 02/30] virtio-net: fix OOB read in RSC receive path
Message-ID: <52c7bb369b23dfcafb6e6d90665c777797b55e88.1785179875.git.mst@redhat.com>
References: <cover.1785179875.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785179875.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

The RSC receive path parses incoming frames at guest_hdr_len byte
offsets, but the backend buffer contains only host_hdr_len bytes of vnet
header. If the lengths differ, RSC would read at the wrong offset and
cause an OOB read.

This is no longer possible after the previous patch, but the assumption
seem fragile. Along the defense in depth lines, let's validate.  To
ensure we are not breaking any valid setups by mistake, warn and fall
back to the normal receive path when host_hdr_len != guest_hdr_len.

Fixes: CVE-2026-63321
Fixes: 2974e916df ("virtio-net: support RSC v4/v6 tcp traffic for Windows HCK")
Cc: Jason Wang <jasowangio@gmail.com>
Cc: Yuri Benditovich <ybendito@redhat.com>
Cc: Wei Xu <wexu@redhat.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3623
Reported-by: huntr bubble <bubblehuntr@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <f261dcd535edc890f8636d8ae5ac1007bc32b8b4.1784891251.git.mst@redhat.com>
---
 hw/net/virtio-net.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index f0e3beb290..2761644dfd 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2674,6 +2674,13 @@ static ssize_t virtio_net_receive(NetClientState *nc, const uint8_t *buf,
 {
     VirtIONet *n = qemu_get_nic_opaque(nc);
     if ((n->rsc4_enabled || n->rsc6_enabled)) {
+        /* this never happens with existing backends, but just in case. */
+        if (n->host_hdr_len != n->guest_hdr_len) {
+            warn_report_once("virtio-net: host_hdr_len %zu != guest_hdr_len %zu, "
+                             "skipping RSC",
+                             n->host_hdr_len, n->guest_hdr_len);
+            return virtio_net_do_receive(nc, buf, size);
+        }
         return virtio_net_rsc_receive(nc, buf, size);
     } else {
         return virtio_net_do_receive(nc, buf, size);
-- 
MST



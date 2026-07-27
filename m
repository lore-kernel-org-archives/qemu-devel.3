Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9340C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 19:22:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woQrh-0008WT-2S; Mon, 27 Jul 2026 15:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQrf-0008W8-02
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:19:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQrd-0000LI-Aq
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785179987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RTWKwepcbjdvvt957sT6DX6W7SqARwm9zXL6of/Nhm0=;
 b=PjEpoGcsT4ibhfcJWtPc4kUDs05DAuDsZEeTd2Uej2YWxcfl8oc8rX0xU42i7zjJx+bXBg
 Tdi8VH9O1pZNIKhD6OkOJJEXuoJiGeEXD3R2Nm8psY0Z4Umz5/824nYZElwFYUKitQ22i9
 XOhwVjan5mUqn6oRMi/QI2HjqbMffSY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-FSvOhKQAP76g0MVkvvrRnw-1; Mon, 27 Jul 2026 15:19:46 -0400
X-MC-Unique: FSvOhKQAP76g0MVkvvrRnw-1
X-Mimecast-MFC-AGG-ID: FSvOhKQAP76g0MVkvvrRnw_1785179985
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-495474a5fbcso27835775e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 12:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785179985; x=1785784785; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RTWKwepcbjdvvt957sT6DX6W7SqARwm9zXL6of/Nhm0=;
 b=l0O5wjW9Y1IYUh97oy1K9VWSAfldUAJLwjroCF9BWiiDlcf/RtLxuwdYuxTs1mUFO+
 8++CWw/bDHgNHE+XCM9Zsz6lZahqvSBsAGKdgNqzExHnyyvL13JxZWUEjPDTavc8X056
 LOMAQkQ4qFvwC1mZiqCfz1Q6Mx7xsK+c5Ph3XBaY31yJhyVpW59PkCE989mvNt8HBl98
 LcBkFyhBx05mYGQb/B727kgWpohdaHG42oGkpzcDXuwyVAw/2rhrwjYJhNJczMMnZPnJ
 X48i+m39GcG+Hl2zQ+dD9WraNy+t1zIBtfBC5izZkKU99KwUVArLRkBRagXoDRQWxIbp
 5odg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785179985; x=1785784785;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RTWKwepcbjdvvt957sT6DX6W7SqARwm9zXL6of/Nhm0=;
 b=eExaOy+z0WsLdWYWms8Ntu48WGh050wj/Kjq39vOdnfBYK4HghdesRyur/YrQpPVC0
 G2hlV7Lk1ZT0n7ritrjy3Eu2aay+oY4HHRUdGjTGjZvnKzz4KchSFYLKff6v3di5LQMc
 UVnunmzLThvgaYiZFYP839LAzdq2fLoT/8FhyaA+Uu+kU8fuxckCfHagkwepZTGE2fcC
 jMF1nLSl1coPoHr64IpGOQGRpcbnEhq8y+RS6nHcjDCnbx0WED5TAWrizqy4bR3t5OZH
 sYUrWk+/pj+xkaXTDCnI+15G47bHRnLTMFgF+G4Vm2RjiDMks9fMT4NnRxEodNSykwvW
 4VxQ==
X-Gm-Message-State: AOJu0YzsCYsLN8DHMVXl2P/RHF7Hjkz0+8Lk1G1C8KP+t7gV1DPC5qhA
 JNp3B3knhdwfP7XW398H9rjtWnfXXR9A+l35Z4JDjjz+2j+3veb1Xt1mKmLKDlMJO8RO/mgkxbO
 W1l+lR9TgclPOO+YP3mB7ZQg1/zp8GJQBZByFtRbTq+RsP9fnqwDpj1j+ySH5YYO3J/YnuKdeWd
 TQycd5b3O0rDnuu8JoZSfYArqnbjj2AEqdmQ==
X-Gm-Gg: AR+sD13cJ4Aiz6b6UPsQ85pKHriNTai7s7qwyLEcrsmB5IEtDApPK/GtDVl9lV4WEeV
 HcACHBVuPCs5cZ2f9Ny97EHtUKbJoMF/iR3THqwpiMddJQftG9gS7xYJYzg/UWmzY7CeIKp2PHY
 ovX1fDAiyIdUOUV7YHIiFrKO9RYV4UZO9o8nmHbmsGdOOC3z5U20IZkNFOLV+1d3o3kyoccN4eb
 eveiLpkX9+KPWpKPlKBQhPGRo76OXfgGMA59z7L7anoMtrcT7YbZ0zFurmGBkhF743/23WCjJ4j
 b4YskphVGCDQl7okaHvOFRiVThCOWC3wQsY8sveUyYr9BF/GwWS9+IVfbmhiJ9u0rvtkUQzkJH7
 OHYS4FoOYQO/AGHg6FQ1VgQ==
X-Received: by 2002:a05:600c:1387:b0:495:5b4a:53b7 with SMTP id
 5b1f17b1804b1-496bd695ff4mr79303905e9.19.1785179984933; 
 Mon, 27 Jul 2026 12:19:44 -0700 (PDT)
X-Received: by 2002:a05:600c:1387:b0:495:5b4a:53b7 with SMTP id
 5b1f17b1804b1-496bd695ff4mr79303645e9.19.1785179984446; 
 Mon, 27 Jul 2026 12:19:44 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957e334f63sm205542965e9.1.2026.07.27.12.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 12:19:44 -0700 (PDT)
Date: Mon, 27 Jul 2026 15:19:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 huntr bubble <bubblehuntr@gmail.com>
Subject: [PULL v2 03/30] virtio-net: fix short frame OOB read in
 receive_filter()
Message-ID: <772488562053c1299fc3667a49b3ff1858f83979.1785179875.git.mst@redhat.com>
References: <cover.1785179875.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785179875.git.mst@redhat.com>
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
Reported-by: huntr bubble <bubblehuntr@gmail.com>
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



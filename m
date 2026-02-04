Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5CABEA7943
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:09:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vniCL-0004ll-8v; Wed, 04 Feb 2026 14:05:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniBP-000396-EO
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:05:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniBE-0008FV-1L
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:04:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f25Nke9lbXBse1DcsUR1BuSwyhsX+SCykZqse82vnPI=;
 b=Hrl7bqpRaGDSiW7vaRyxzNWXt3bLd8qcN3UM8i9h+8uziqVw76//nV9B0hxVAAPqJAba5Z
 hWrW5t5GUKtNYXD0XPDOIAZbmVtKIm/cBro6o6q6oXp8qwJJNn/JNHt8WHTh+SklKbdjrI
 kfrgVIuyESuGDD4XcERdr5tLCebtrNU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-HD4hRnrdP5CZeRE5WhYz5Q-1; Wed, 04 Feb 2026 14:04:42 -0500
X-MC-Unique: HD4hRnrdP5CZeRE5WhYz5Q-1
X-Mimecast-MFC-AGG-ID: HD4hRnrdP5CZeRE5WhYz5Q_1770231881
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-436164e7f42so188993f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231881; x=1770836681; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=f25Nke9lbXBse1DcsUR1BuSwyhsX+SCykZqse82vnPI=;
 b=HHYK/J3fULyJKeVSpXUT2nKlLHTzLylLdItxggzoLPGnj3LDGU7fHFGBA0AaLkz5tm
 KE+rxuYyjKtNSV/aVzqxfCeksWZ4A4kghMMplStvWawIDBCW20HLztTJtCgfj2HbiHl+
 5U2VM/Ko/LKLxkYiyFCIswC5aYhtrtU35nLzqbSlydBSBvGE9EpHVynWxWcBtGDkpegJ
 x+bCDfkNchAWlSJo2oAFSF0EbonnnYfnXJEmeRCqgYm0w77aKAhFacNM//3QB3DttR7O
 KrdJ8og/9JpBuc0PyJF0pSK/dc+fK78vABNAqG89mqixf6Xhiu+hva5r7z+CeYeC+8Fq
 CR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231881; x=1770836681;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f25Nke9lbXBse1DcsUR1BuSwyhsX+SCykZqse82vnPI=;
 b=iEHR5EM/BLAmQYad6WGoeNfbZPuHV58L4ZNkXgk3gxLzNnCINIJF45zvFwiAi4XjH/
 XalSbn/mTyUyKT6HLW0xAg2E6Ly1grk4N4Z6utQUFVgsr1PLu6xZOIN186DGjV//Cr2U
 CWmbdMY466imv8QqbLflAnM9b4EMBlljKAzVXvsMRedJhu3TozuN/CLl8ro1N8G1jLdd
 ycCMOJKo4sgiJY0FxcB3Lq0HVmmF6dt0/itA35l62aY6iHhdU4/dO4uXk0PyPOXJOpDs
 B665CVmk1R4BhwBkMqCw8c2yDPNmArsVZa841KZZFd7LCw2zZwi1KV8lwlV8+V7f2uVS
 JWog==
X-Gm-Message-State: AOJu0YxcVKa6RwFhAsKUbTMXwgXA31qPH1uyuOpthRVy/BHOAjtvUpkW
 ifcj99HWHUVuXI75TOyGldT4d2/4vpGqN0yzPvRTLOXMKuzBSn0CfYSOGz2qamkvsquDSn93rRl
 6c5Dtgs0UbIPDvwaOOZ8bps3UIYu49ZMYFYf7Y79jPzpNURklkNJ80hMVJ6ZgnAO5TQy5p+Iv3a
 Q1n2ORa9Ol4SUQYcSiLnqhBGXf6hLnLG6lgw==
X-Gm-Gg: AZuq6aJrJK30M7/Rm4xFbuWbeyvH+CHGsZ/Xs5PzjuSgnT21zroPSerArkuNmUJM2li
 fbk6qDbACFA9chQXKOPoPPjOfsuFOFwk9cGSfpsb2Z+UZWWC6P0VrWL6UWRMXNoyUG1wgAEPnV4
 bf2Tk7GR2subZHTUIaDUlG3j53UjMYrnt2gb6hpSp/YxVHMdix6vjPN5vAmdrk5RJKOPAYok0dE
 sfBJI7n1EL9WJ4uCll5r3vA6imS5gZqnO0ur3ip/a4Zg8QjjzDi17g6p4G0k50baHDtEs930bpy
 6qaMD/jjV8ztsOjsqY7rSK431N1dN4vD8DoPtfLdVuAOknYK4eSK8N/3fe1zx2TaNL6fyvEnxcM
 2lSAW8qCHQ6AMpzHLuqCZlHB5uw5HD0feRw==
X-Received: by 2002:a5d:64e6:0:b0:42f:b707:56dd with SMTP id
 ffacd0b85a97d-436180551e9mr6176041f8f.33.1770231881021; 
 Wed, 04 Feb 2026 11:04:41 -0800 (PST)
X-Received: by 2002:a5d:64e6:0:b0:42f:b707:56dd with SMTP id
 ffacd0b85a97d-436180551e9mr6175981f8f.33.1770231880462; 
 Wed, 04 Feb 2026 11:04:40 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436180640e5sm7542944f8f.40.2026.02.04.11.04.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:04:40 -0800 (PST)
Date: Wed, 4 Feb 2026 14:04:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 48/51] vhost: add vmstate for inflight region with inner buffer
Message-ID: <41ccfe54e16060219a0ef5ee106bbf63ed8abb24.1770231744.git.mst@redhat.com>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770231744.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>

Prepare for future inflight region migration for vhost-user-blk.
We need to migrate size, queue_size, and inner buffer.

So firstly it migrate size and queue_size fields, then allocate memory
for buffer with
migrated size, then migrate inner buffer itself.

Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260115081103.655749-5-dtalexundeer@yandex-team.ru>
---
 hw/virtio/vhost.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index c6a5928cb1..52801c1796 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1918,6 +1918,62 @@ void vhost_get_features_ex(struct vhost_dev *hdev,
     }
 }
 
+static bool vhost_inflight_buffer_pre_load(void *opaque, Error **errp)
+{
+    struct vhost_inflight *inflight = opaque;
+
+    int fd = -1;
+    void *addr = qemu_memfd_alloc("vhost-inflight", inflight->size,
+                                  F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
+                                  &fd, errp);
+    if (*errp) {
+        return -ENOMEM;
+    }
+
+    inflight->offset = 0;
+    inflight->addr = addr;
+    inflight->fd = fd;
+
+    return true;
+}
+
+const VMStateDescription vmstate_vhost_inflight_region_buffer = {
+    .name = "vhost-inflight-region/buffer",
+    .pre_load_errp = vhost_inflight_buffer_pre_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_VBUFFER_UINT64(addr, struct vhost_inflight, 0, NULL, size),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static bool vhost_inflight_region_post_load(void *opaque,
+                                           int version_id,
+                                           Error **errp)
+{
+    struct vhost_inflight *inflight = opaque;
+
+    if (inflight->addr == NULL) {
+        error_setg(errp, "inflight buffer subsection has not been loaded");
+        return false;
+    }
+
+    return true;
+}
+
+const VMStateDescription vmstate_vhost_inflight_region = {
+    .name = "vhost-inflight-region",
+    .post_load_errp = vhost_inflight_region_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(size, struct vhost_inflight),
+        VMSTATE_UINT16(queue_size, struct vhost_inflight),
+        VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_vhost_inflight_region_buffer,
+        NULL
+    }
+};
+
 void vhost_ack_features_ex(struct vhost_dev *hdev, const int *feature_bits,
                            const uint64_t *features)
 {
-- 
MST



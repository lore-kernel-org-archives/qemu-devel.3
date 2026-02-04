Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 559BDEA7942
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:04:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vniAg-0001N4-WD; Wed, 04 Feb 2026 14:04:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniAe-0000wT-PI
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:04:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniAd-00083T-25
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:04:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j3U+rCZB23JOTCshf+slsXWzZHrPIED/RSpRMRmSPAA=;
 b=H7P4r2obgpL2MFvpedRhDoA7oZhSMKT62u4yrteWBPb88XtMlLyQ79gdKi+js3pfLBYRu0
 AcPj8pitpf2ZAKwjKNzO7ObXhiPGSGETXKy2MwtpLKncoVf9Z6GrpRwSAjp8q0Tqj948mx
 fOG8lf0hr1XySOui3Rf0SYqDHpYg+oE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-RkFFxHJEMMuGUpIaWUEnPA-1; Wed, 04 Feb 2026 14:04:07 -0500
X-MC-Unique: RkFFxHJEMMuGUpIaWUEnPA-1
X-Mimecast-MFC-AGG-ID: RkFFxHJEMMuGUpIaWUEnPA_1770231846
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48079ae1001so986265e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231845; x=1770836645; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=j3U+rCZB23JOTCshf+slsXWzZHrPIED/RSpRMRmSPAA=;
 b=Pxepu8P6BQgwP15dWA41BcKu4r77ZWDwLWbz7ocfrZfVwUDSsrS7ik8CgTREPM5aOE
 3IX9uqL8s2FF7LDKOhl1lZYgxUa/l0/92lwzkoSycWo1IiqgaO5CRGUVrEFag/gj2YXr
 pu3/WYsp2KEk6bf8c+Y2uV8hmgtIZ/P8uE1lF9Cq5NJoyTEId/h8tTROigJ1Mo0uGvrf
 RGYmrcX5P3bbTV6Xvz2NaSzoZnkDw9f4IETwca6RZItdg27B+lPXk//X2RdmOgkYMLNd
 EkdVr3Lnaq7s+L7SQLm8NjqTQMpAowGm75LMbIHH22X9BsIzpPRhf+2p7xqWBK9roaK8
 wHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231845; x=1770836645;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j3U+rCZB23JOTCshf+slsXWzZHrPIED/RSpRMRmSPAA=;
 b=VN/DaOp25eNDBAVzRIMf87aEHc85sMfK5z5YpycbAxg+y86ZzbY8r+pZV/l0ZK53N5
 28Pszry4+Av/1JVkyzQgpBWgSApkTHPC7YBAJSQT71eBcdVrUHeRY6NX9ldre6oSNs5p
 1roF1OvNf3WgJaE/Zp4Sz2CCOsaZiixtEgJCYNvWZUUqEgYcIYHw9Dcmh7zctHLPl+e5
 rVmCWcxjX1pk9BMpF8cNZnT8yzcecDfy1Ec8ngBJY1gqxpqwrNTD3t8YKWDLfcrPrVyw
 xeJa9sJIpx2GBlPvGjIoTbOvBMmgP8zy6gsCe8uEsz//pNGnZnvriLAGX8NMTUDLZniO
 Kj7g==
X-Gm-Message-State: AOJu0Yw/xpyb3sU9ZpHDG2claXSrvatrc2VBGlH9YpKFllbRm3Gt1hKu
 JoNB1iSIRor1rdukHiRvBA4lc5SHKgZ+CCUnkEILnRC9QPavG2tPcQTg4d8TFjWQ+NV8VhNLTNo
 CFGVozg4vnfhNBr5CVNGr9mVTf0UxSQv32Z6Tku7gbNF39TkkLyXG+gXzLt0RqZBGT3G2k0I/LF
 ogtoWt7QybNbyQbhwgzshV1nz2exHs/xAxjg==
X-Gm-Gg: AZuq6aK/kwVhUporRvUktq27ozt/hYXtQchHHuxlJQT3WJ0E/p6kdJ4+107if2SzVTm
 wu0gFC2wuFx8AYmz0LwqRU170QqEpMmTlIV1i7LjCWG+lYK9y31oJk1b58DCzPa1JX5HJclfEuo
 DFME8fL/Wyp5RaWaatTLCOpj91+Hmf5x0Af3b9plcaJG+EW9Yg463n5nIary5i/N0icjoaT/b+2
 1wY1BZ5sFL1RRbBXPJmWAViQiH+dgxd0NuovZwgFUF2sbLmwHC+S3dlrsYlMDLf4h6yaj9i9+wP
 Vyuv+N1GIcuDS8WH0kf8Ie1HBH3yQonUhiR8dgNap5IzPodoPeKeUQjA00Mg1mkKocjgARgUvUJ
 HUJZU/9DAVHFAbCQOWuPK7QWYoRurPT3xrQ==
X-Received: by 2002:a05:600c:a03:b0:47d:885d:d2ff with SMTP id
 5b1f17b1804b1-4830e991bf6mr50528645e9.29.1770231845573; 
 Wed, 04 Feb 2026 11:04:05 -0800 (PST)
X-Received: by 2002:a05:600c:a03:b0:47d:885d:d2ff with SMTP id
 5b1f17b1804b1-4830e991bf6mr50527955e9.29.1770231844891; 
 Wed, 04 Feb 2026 11:04:04 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d8341csm3511625e9.13.2026.02.04.11.04.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:04:04 -0800 (PST)
Date: Wed, 4 Feb 2026 14:04:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Dorinda Bassey <dbassey@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Albert Esteve <aesteve@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PULL 32/51] virtio-dmabuf: Ensure UUID persistence for hash table
 insertion
Message-ID: <730274b225e4a4b9346e2cd5a8d38858d65e2bb5.1770231744.git.mst@redhat.com>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

From: Dorinda Bassey <dbassey@redhat.com>

In `virtio_add_resource` function, the UUID used as a key for
`g_hash_table_insert` was temporary, which could lead to
invalid lookups when accessed later. This patch ensures that
the UUID remains valid by duplicating it into a newly allocated
memory space. The value is then inserted into the hash table
with this persistent UUID key to ensure that the key stored in
the hash table remains valid as long as the hash table entry
exists.

Fixes: faefdba847 ("hw/display: introduce virtio-dmabuf")
Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Albert Esteve <aesteve@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251204162129.262745-1-dbassey@redhat.com>
---
 hw/display/virtio-dmabuf.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c
index 3dba4577ca..5e0395be77 100644
--- a/hw/display/virtio-dmabuf.c
+++ b/hw/display/virtio-dmabuf.c
@@ -35,11 +35,13 @@ static bool virtio_add_resource(QemuUUID *uuid, VirtioSharedObject *value)
     if (resource_uuids == NULL) {
         resource_uuids = g_hash_table_new_full(qemu_uuid_hash,
                                                uuid_equal_func,
-                                               NULL,
+                                               g_free,
                                                g_free);
     }
     if (g_hash_table_lookup(resource_uuids, uuid) == NULL) {
-        g_hash_table_insert(resource_uuids, uuid, value);
+        g_hash_table_insert(resource_uuids,
+                            g_memdup2(uuid, sizeof(*uuid)),
+                            value);
     } else {
         result = false;
     }
-- 
MST



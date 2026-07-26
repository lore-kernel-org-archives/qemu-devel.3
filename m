Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A5AC531C9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 21:33:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo6Pn-0007XG-MT; Sun, 26 Jul 2026 17:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6Ph-0007W7-3s
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:29:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6Pf-0004HU-KQ
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785101375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fg8BZFP7bTHoLtlaI8nWkzIx9BkmGgJuYaup0Yedmwg=;
 b=LfZ63z5r16lZUAJKGiQ44Av0zgQJDQXGKSqKhKg06VkvZnNC20bnnIbhdbs8Rvk6cNUwV0
 FRbmlUYAfIGkdJQ07CylXUd3kYlZ5qczCU/megPlT+JgxRqX1K87+U/5/sMgYJAcmoG+Y1
 AQ6Z/gLyNZ+F/d6pL01P648hWAFV/2E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-pMH06LIWPFS_0wM8N6jIqg-1; Sun, 26 Jul 2026 17:29:33 -0400
X-MC-Unique: pMH06LIWPFS_0wM8N6jIqg-1
X-Mimecast-MFC-AGG-ID: pMH06LIWPFS_0wM8N6jIqg_1785101372
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47f81362fb1so1358597f8f.1
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 14:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785101372; x=1785706172; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fg8BZFP7bTHoLtlaI8nWkzIx9BkmGgJuYaup0Yedmwg=;
 b=HSCZmDLPYT39q78/GGiBsdXhPYXqVNEHlCI8krxNxkpwLXw3hJqLbzVpq0QSRRVkDx
 p3SPFMLrb0IcDoF4DtQQjnhgj+RfyFsJtuDxOcyAygMe5CRjaf+j0a9hkB9/nSpmQAhT
 Am1qqo2B3sthQ6/1PrUJB8RC6GO0bhREApD9DiV06wOyFmXZCy+eA+X3arUQcLZVrBgW
 UUcM5b/jAE1R+vYVEyWYY4Cs8glo3L6961pCv4Es6RR0Fe3aXLrwXgTI1m13M+uKugUq
 UlkJ/K/+CCRXyI46Guf0fEIflT3WDRwq/1GKFG8i/g2A3QLeleY3tsU169quhDu47Mrl
 Zajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785101372; x=1785706172;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fg8BZFP7bTHoLtlaI8nWkzIx9BkmGgJuYaup0Yedmwg=;
 b=BKu8gTTFj/VkgQzLAAU56k1PgZBWWacHJD4VKsTqu709VR8w6Pz6XH/Pdtfkm7e6qQ
 1oAE06aWU/Wb0bUYe4sO0h8BLx+/nVI+kZUoEVpDk1UZYga3Ehnkf0QpsGrUzE29Secg
 SubcPH+m8o2lEgxB8YPyI3UuJ+bbR9Lq7PsYIhusDVbceRJ3D/gUShoWpSbMhIBTGJDO
 tpWeIhlytlP2mvqLpxGOOSDSsxqqjBCnIskzj3+GYDjynkZy55REJ9/0kpk5XkCboIZL
 QkId0/W1grpY65gCnHv+7sK9+aAPn2I9LVsnRw6ZJ0h36s7Kl5ZPNtzwZHmalhH7+KwI
 u8EQ==
X-Gm-Message-State: AOJu0YzGc+JzSY+n0bnQU/ucveXaURb58AksO95z+ZNuG67j95BSFM2p
 VAs53AnQ+mNINm7MBKwT+ciiUz7Yti4zqbsVFxBcVmOKOTYtFdNjWUw246vqQGKyMVNbdTqm5nU
 3eJtC4mAltRlGxe8dBQSCLNjfqahRfsJb8NzbP4S60hVCRFzQ78K5ISFTejpTDyCct5hmuTFeY5
 bkTZssjX3NzTK2aYTF5NQuy5fBf5e84Z8ayA==
X-Gm-Gg: AR+sD12niyaJAJ5MKf+C3cHcO2SNYfYIvO7phQ5sMUJxAzw3FOfILUpz/f7TyYWrWQv
 i7Snbv6O4lLd+QpXrByNIJOrHemUK3j60YjaXWVf2QLj0+Knh+s4NDa9IRLzzsHbVeFITeHpLlk
 CTlvz5y+QcV8F3pU86GOOuUBu+y7mxJcYHZOk73GXzbQDcELMugo8YUVcy8i1EnwgEsRtvALk2i
 Qhfzfcjz7x6KKfHK/IXTTE9PoUZBrVPK22gK/nt86riyS49BUyUSQjVHYsRVxlNxNsUqzQ8d6qD
 S753nJwV7DMmlJULkGjKsdWS+J7EJvDgO6xZT+hQWHaQXAhkR/bb+C11C0vUctERnvNs0jSFnfy
 9S+Gx6qCV/rtN+ytJj0UJRQ==
X-Received: by 2002:a05:6000:178e:b0:47f:97d1:4fea with SMTP id
 ffacd0b85a97d-47f9fea53acmr7786846f8f.38.1785101372285; 
 Sun, 26 Jul 2026 14:29:32 -0700 (PDT)
X-Received: by 2002:a05:6000:178e:b0:47f:97d1:4fea with SMTP id
 ffacd0b85a97d-47f9fea53acmr7786833f8f.38.1785101371671; 
 Sun, 26 Jul 2026 14:29:31 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a5c4sm43206628f8f.8.2026.07.26.14.29.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 14:29:31 -0700 (PDT)
Date: Sun, 26 Jul 2026 17:29:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PULL 12/30] virtio: fail early on bad config_len in migration
Message-ID: <b7fa4bcd589284aaa24222ba6065a3af4ba39a02.1785101237.git.mst@redhat.com>
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

virtio_load() attempts to load config_len bytes from the migration
stream. If that's huge (e.g. 4g) this will uselessly spin
beyond the end of the stream for seconds. Not nice.
Check qemu_file_get_error() and bail out early, instead.

Also note that config_len is int32_t but is coerced to unsigned when
used. Switch it to uint32_t to make this clearer.

Fixes: 2f5732e964 ("Allow mismatched virtio config-len")
Cc: Dr. David Alan Gilbert <dave@treblig.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3891
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <cfbefa358af5885eb386637216552bfeba5e7bbc.1784898922.git.mst@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 2766217ddd..979c4065b7 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3505,7 +3505,7 @@ int coroutine_mixed_fn
 virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
 {
     int i, ret;
-    int32_t config_len;
+    uint32_t config_len;
     uint32_t num;
     uint32_t features;
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
@@ -3553,6 +3553,9 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
     qemu_get_buffer(f, vdev->config, MIN(config_len, vdev->config_len));
 
     while (config_len > vdev->config_len) {
+        if (qemu_file_get_error(f)) {
+            return -1;
+        }
         qemu_get_byte(f);
         config_len--;
     }
-- 
MST



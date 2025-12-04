Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C212D21696
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 15:28:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRBF4-0000eA-3x; Thu, 04 Dec 2025 10:27:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1vRBF2-0000d2-HP
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 10:27:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1vRBF0-00088j-Qj
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 10:27:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764862053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JkUgo9uAp9Eo8VSAb/9+cQNOt6PVwZ07ZxNP6+aCrIM=;
 b=TNGdcmGfgJAQCSR7QZ6bvfnvbEGXU/cWZhVil/gxsK1TcfQboHuWKRnBlLQGz1d20pRMLX
 h9/JODEhXxTy+mhWQC40gxxTsQKkerjp2b/vIK3gp0oAeTwWuxESCZRcDOk2HPrn77pQlB
 To6gJMqMMT+TFBnpDyuNOmYDlwN3Sf4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-DZbLaaytM2q2x6hgcXTccw-1; Thu, 04 Dec 2025 10:26:25 -0500
X-MC-Unique: DZbLaaytM2q2x6hgcXTccw-1
X-Mimecast-MFC-AGG-ID: DZbLaaytM2q2x6hgcXTccw_1764861983
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42b487cda00so629013f8f.3
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 07:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764861983; x=1765466783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JkUgo9uAp9Eo8VSAb/9+cQNOt6PVwZ07ZxNP6+aCrIM=;
 b=pVpb94pgE3wCQBegr2LU85dOVeo1H/ZRxeBmUrYYEFZy9ZI/0bW0DRGqn1NQhPSqzf
 f9qEX8G2ysxBmeKwO9CHRyAZYjnBS7gJ3iwDkuWQtjKr9t0tQl57sCnoWvEqJeppQBPd
 Z6ibiqrCdRWoBNDu4EcCc4Hnz7Rn9aQ3gpzBc/fkTQQg/y07SjsR5fh0reNTD0PrqScd
 8mhHtK3HzKplsUMwhtSHyJ93kmrxKAFys0dLx0kocFNYFJ6kA5HXuQRkFOwQN0z/DpOZ
 tQo6iiFoZUFE3NWVkaehIyQ00zIOdL4DCRCoahRWGM3f6hMcTI9kVC8yyLouiVQuq83r
 mdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764861983; x=1765466783;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JkUgo9uAp9Eo8VSAb/9+cQNOt6PVwZ07ZxNP6+aCrIM=;
 b=XEqQOmPE96eMPt1gdWSCs40SYdnjSTsIIL56HJ/jKYOzzf4sLJ2t5aAGyyB9WB+pV3
 WHYESDacyL1GTxwWLCfcxbxafNL8q0bM1lpADJqHV7sQd4IMC4GflJTEIsgUr3WHPP82
 F1JvdOeNKTK3xhRH+MntTfyW+TVlL9SKnZB7TDcZIJQ6iR6l+LW6Uy0tWW7E7HywYKya
 2SK/D7xuefx87npAUUIczPv7zuh16DzDgVLX7fqD7+DOXfkQtdkw5WsitlJqEnSCSNG7
 f5Pzq7woCnEk9W6iXGmNubYgozn7bBkcP8g2XsC3g2gCwfzn+7KnlKRRroJLT2547uO+
 q2+g==
X-Gm-Message-State: AOJu0Ywl/Ur70JGyUWfh/wrmmelIjkRQWFSHnFUFQ9RHPBJ3SwjZox5P
 Y/xx173sekMgP2KZxzI8uHV2s5ZFu1G8WufSt1xmvuQCEpdzsAOHi9Nkg9XvBcP4Q0joF1wKHGd
 fxmAW3pWZEXL8flzUFAlM52p5nuO7+miPUanxNmtbuSWyn1fjxMXkvGEjdAE67niJh5XZnYWXqV
 MmMVlEa4O7JJWJS1VnpXLEWniJDgD+ddQhWUukZbyNnw==
X-Gm-Gg: ASbGnct5P7dRVaeMWGWLSlBQMSGejS+pLjQmqgjb6bbd99+AReKH31mprih393zvDfQ
 70BZzryTDemYpYwQwJeoG8RMRbovVAXiYVRQqEGwmj/3XruZa9qY2Od8Ammrav8AEpTv7cW0aMm
 0EWbhojrzqlbHHsGt7w2+hIxsDFJlVyqjs7BhrXD1MhaGECCXtTc/sT12y9D3b1x/+bAZKt970S
 hprnwLGkouSW3qXqajDfPCgr8BkIfMgP6dHPayjXpJtKQaK3DIqPkos1hefIcjBNvQ7Tmu8jRcn
 F+P01XXEgVw73WcqX8Z8FzZ70aM/ADR9OdF3QS0lO+wjW995Z7NoZfDfrMDcL3OuSZ9YZCir0qk
 3LJhkb0zGq2IRRvaeE/6TB5sFru7wrqLFVWo=
X-Received: by 2002:a05:6000:2401:b0:42b:3023:66a6 with SMTP id
 ffacd0b85a97d-42f731c2a06mr6291494f8f.40.1764861983076; 
 Thu, 04 Dec 2025 07:26:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETC6uDHIsS/5KKKZb5mswbkm3T/Cfs1wJ2uK/otbttofpF4ss9YAOlQbsxiE2yYtwaV41Xjg==
X-Received: by 2002:a05:6000:2401:b0:42b:3023:66a6 with SMTP id
 ffacd0b85a97d-42f731c2a06mr6291451f8f.40.1764861982493; 
 Thu, 04 Dec 2025 07:26:22 -0800 (PST)
Received: from fedora (185-219-167-200-static.vivo.cz. [185.219.167.200])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d2226c5sm3832674f8f.23.2025.12.04.07.26.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 07:26:21 -0800 (PST)
From: Dorinda Bassey <dbassey@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, aesteve@redhat.com,
 marcandre.lureau@redhat.com, Dorinda Bassey <dbassey@redhat.com>
Subject: [PATCH v2] virtio-dmabuf: Ensure UUID persistence for hash table
 insertion
Date: Thu,  4 Dec 2025 16:26:07 +0100
Message-ID: <20251204152607.259387-1-dbassey@redhat.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=dbassey@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

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
2.51.0



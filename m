Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 769C6D216AD
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 16:22:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRC5e-0000nx-Ge; Thu, 04 Dec 2025 11:21:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1vRC5W-0000l8-Dw
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 11:21:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1vRC5U-0005XS-Md
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 11:21:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764865307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=76KuYTJo349nfpuFmw9KF/rr9QnSH9CoWLRtCKmNE9A=;
 b=VwKeZmeZasZT2irzgI3M3AgtIqrpW2REb4zFZIpHr3Qc2YJhMFi1CB0C7J63yIisadjsYi
 ke5FzFLlGMuSttHzU3XFlAjavm5pyr4rSSgoeniqVDHMC/LSyDo+oFpsGv+0Y3Ok8K+u4Q
 78s8NaGTad/pDmfDdor3ufZgqaEJua0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-P0M_KNBxNaW-bLf_sxpMYg-1; Thu, 04 Dec 2025 11:21:46 -0500
X-MC-Unique: P0M_KNBxNaW-bLf_sxpMYg-1
X-Mimecast-MFC-AGG-ID: P0M_KNBxNaW-bLf_sxpMYg_1764865305
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-477563a0c75so6510725e9.1
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 08:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764865304; x=1765470104; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=76KuYTJo349nfpuFmw9KF/rr9QnSH9CoWLRtCKmNE9A=;
 b=ttmr1sNP3iOoiQbieRLkwdY/q4ZLl1aB6kTZ4xRk92OnjAh88MMEoNLofSUMaxHDaB
 aRY/LNcITWBF+BcN8RW7nfX/jLvGGk52RXxHOPYR2WI4yTRUC/WF1OiEfG42n58KQyDY
 t0OQXUHJWbZERh1VR7VOg4VWnUQapMJhjlVd+Z3mrJWwKzkSNlDwkfLaEeavSqRspDla
 9ArQ3R2/hv8Di+EEfEC//lDpgWUnQkzRmuHtUbdQGsoO5luFFhAFGm1QLmAA0RFscQ1b
 Fhv8E2oD2sJs5MSkB4a1xXAwtCOMQNu6Ealx68G0uh6z2tHDT+ngppS+whaXm58LVOXr
 sX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764865304; x=1765470104;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=76KuYTJo349nfpuFmw9KF/rr9QnSH9CoWLRtCKmNE9A=;
 b=J/GOBjcEieBFNU4K5rktP4bkNDRoaaSX6wZxuY+6yaAcwc5xzo0jdb3yBt4Ff6JZX9
 Xrp8Vi+2d6fSrb96oS1nixEYF637E86AdscTDjVGcDg610usWWmTH3O9rT5fggKDU9uH
 UwqHoPRvZiqoLSgDE+vwpksRk4NDKgNOU6X9sYtzr93aQMvptWhcWKSMOgD9RaPh1Ehc
 Zpg85tl5kq6GAhV2aYfzVDNa6OVc/DMlPGMgk/aH+BLK1jp0Agz0bSTav86SsDO3EJv0
 xGlZMXVSWsZO7CHvw5RO5zqTRDda+ywE1PwK/Mo3wL7Mu4Qfl34cvhu65dO8W7z2VWoI
 x9NA==
X-Gm-Message-State: AOJu0YyEV+wqAOl3+EUJigb1wHOJ7MA0NadOUbowAoShkxH8xssfDf6z
 LUmFXUCbZ5XdkjHqHeAq5ECLUiO2YsiBCXlsHYgINl8BVqcTSUjGMxA5bZ9PnYg2/EncHmKRCwQ
 I4/Xfwp+xgZQWGYRxf2dMZeh38OoyEd07F6aDr+OzYy7465qxHdxRl5EPZny7V5Hbhe+RjNBskK
 TfgL1XD8ZXNZ1jCiMg1NMx6H8nkHRn1y3hV7ne/No=
X-Gm-Gg: ASbGncvsV5c+ja4WWz12x26PxOhgfqHyMrl4b1L0capH2INIq6rWw6zaezkBThENBqB
 3j4f0iTVMelVt+OqQAiFd1pt1++nlBusv0Bskvi/W/CL7owsPRVu81iJ7cGvVPxMH4bqU442jUn
 HUVC03MjAUJD+MfQJU0ttAIn/l8nluiFLgna5vvQrQPe3pBMJxRsqxxlQYN5GTaFQKx+/vqiQuS
 XaCVPMmLKXRiVkGY1NOt62T98gqnJ82mTy8xS/fvTv1q6bqwJKjtoc/lK6FEDG+qNd/WV5zUMFW
 AuDFmy32rDVdrESUaOnHX56pETAHiSXyGk4CyiUH9iinoiC8uu7GR2hxN4z4VbSU2eKhL8pBnh4
 W3FtDQ/STG2SBqsFA33RabWXbFKGUekkfdZI=
X-Received: by 2002:a05:600c:1e8f:b0:477:a9e:859a with SMTP id
 5b1f17b1804b1-4792f3861bdmr30616295e9.22.1764865304368; 
 Thu, 04 Dec 2025 08:21:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJm8aN1smlEXUIuz3Hpewpz6FWWtBNR3sEZKvpjeS0CGTPkVRk3OPJypzgz8Q4sKU2DJrqBA==
X-Received: by 2002:a05:600c:1e8f:b0:477:a9e:859a with SMTP id
 5b1f17b1804b1-4792f3861bdmr30615895e9.22.1764865303916; 
 Thu, 04 Dec 2025 08:21:43 -0800 (PST)
Received: from fedora (185-219-167-200-static.vivo.cz. [185.219.167.200])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47930c76edcsm38758895e9.11.2025.12.04.08.21.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 08:21:43 -0800 (PST)
From: Dorinda Bassey <dbassey@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, aesteve@redhat.com,
 marcandre.lureau@redhat.com, Dorinda Bassey <dbassey@redhat.com>
Subject: [PATCH v3] virtio-dmabuf: Ensure UUID persistence for hash table
 insertion
Date: Thu,  4 Dec 2025 17:20:13 +0100
Message-ID: <20251204162129.262745-1-dbassey@redhat.com>
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
v3: removed blank line between trailers

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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A4BC5DF60
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:18:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAgk-0008Ul-VW; Wed, 12 Aug 2026 11:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wuAgN-00086B-18
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:16:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wuAgK-0007DN-W9
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:15:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786547752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+OceRc3ZgDjagPSQ/pqT62JhQxrkVIS83abLwhmkN1c=;
 b=UKXgqXK3Xp+NTlpCJEQFZafqMdKeLbCC9gkRq4JCg+qr/KOtRz5Ke/wvLDippbr45HUNlB
 vcebf7GBkzwuX+1/a7U4JpnQtHPoHd7vvV668z5mFQpXpFHc7QxcWw7/yw7myx5Dv4k/Ak
 rv+PRVjMRFKbDDZ+8OY7OlzzSn76wsg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-ua-GYnnaNKmYfpjxj5QeKg-1; Wed, 12 Aug 2026 11:15:49 -0400
X-MC-Unique: ua-GYnnaNKmYfpjxj5QeKg-1
X-Mimecast-MFC-AGG-ID: ua-GYnnaNKmYfpjxj5QeKg_1786547749
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1b4d961dso10224871cf.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 08:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786547749; x=1787152549; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+OceRc3ZgDjagPSQ/pqT62JhQxrkVIS83abLwhmkN1c=;
 b=ckwXRrMHLxqWohqrRzr8yvpnvHR1Afy+uUsd7XYPFntaOmNEtaMDiIxcW8RGyZqrOX
 7eCqE+yx88s5BXHgxpCGB/IDdUTA7LfA8Cpa2wRWD+cfYa4HlVNV53V7XqjbA3ZugcPt
 qTfOVA1jIpUV4bqJJlT3PxguHITlrT5Z0AwKM7djsEa+R9cdj3tvqEyNqeMWoFiwTSVt
 TiKOzwVJJo3mSRM39/lZHYy8LjgJhO2vxerYhZzkhVeuhruj8LqVOZOx3aZqRi3d2eDU
 PUJ6ccs5WaIJimZiwAuNUOswQfugvTXLdt86TxKLAmUXA0RZJmG5i0qDOXiN9S3+j7An
 n8vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786547749; x=1787152549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+OceRc3ZgDjagPSQ/pqT62JhQxrkVIS83abLwhmkN1c=;
 b=b50gXO4K0cgn4XYYKuKyKj0kQIQj2uR8Jmvuh3LmZkv111BSRRV02imhOHrsYUy17c
 lwEB+5h6EbNWfQol4BC17kTopb6528BZ+EZhbQ4umgPzQxkXdemLin/ok3oSB9NrPJiv
 j5Fy3NVQ8rqrO7bMBYK6YSJWWKqGa7fWwGxK9groBicmyizL3MpHlizsDjGUJSOKIqeq
 L18VuZhiRh1bYyX4SRnj+v6h0OqMQe+nd74iy0jWtqpn47RY0LVSOq7887UIBvbRdfjd
 MGeiWYxUtNr5F7RPhz5pbaCFQw5XfpEEQ+I3AZ7sd17sZLOXV6pzgPXD/mVjjQyfCJww
 qISg==
X-Gm-Message-State: AOJu0YzBHF0e1xmjEAF1FmbNEOOYZlL/slGxIMQkjYz1TVuPJ1MnVrUs
 EuemAETY4u99pbJRp0+wBcdwA5NBo2VzRNyClgOJckdjpaLCD6+Up8pvgj30tkojqGzP+aP0LPv
 pqGcL1+SVuBM7i0USiho3Oo2e9LMSqi2jrRkKtgV2uxD3dALPKBzNzxB3HbG4iJgdmOGw6xExih
 LI6cVaVLqMjra5lln1MBUDjAnv3Uc+OUB6hlyyIg==
X-Gm-Gg: AR+sD11PrWTWaqdGSaQz5yV5qMsvT/4hbKuLlPoobFmPF9PkTBMIvJeUXEjZTiIwgXC
 7E8VMgZsGS/LfLR+cLdRiXmjJRk2TtJaL0I4rfCdzIlTctPHrow1DnXi37JqG7T3GdPYJlB5krQ
 P13R4e5rsgBf9xam3o/8wY9OY4iVoEZBWiImZCXOd2S0ERuBFoQYfdVzZfIhm68+0VXNT0PetKa
 2Oe6CQoU+RpupP473Rrrkkq1tkeXQGYWj3Cr/go+tJnIUTT9+ALXFJY/8HIFAsQfog73Sx+ntvp
 mYjD+DDcPNsXbWA1dhbod2Gcnk/Znc4dFwR9oLytJdCYru1qFZE6lMc7TxdmlLj3Wg==
X-Received: by 2002:a05:622a:248b:b0:521:103d:9f98 with SMTP id
 d75a77b69052e-52d659f7970mr41745531cf.19.1786547748639; 
 Wed, 12 Aug 2026 08:15:48 -0700 (PDT)
X-Received: by 2002:a05:622a:248b:b0:521:103d:9f98 with SMTP id
 d75a77b69052e-52d659f7970mr41744501cf.19.1786547747923; 
 Wed, 12 Aug 2026 08:15:47 -0700 (PDT)
Received: from x1.com ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52d61d948d6sm19552841cf.15.2026.08.12.08.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 08:15:42 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-stable <qemu-stable@nongnu.org>,
 Yuan Liu <yuan1.liu@intel.com>, Yichen Wang <yichen.wang@bytedance.com>
Subject: [PULL 08/10] migration/multifd: Replace assert() with error_setg() in
 recv paths
Date: Wed, 12 Aug 2026 11:14:41 -0400
Message-ID: <20260812151444.2611689-9-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260812151444.2611689-1-peterx@redhat.com>
References: <20260812151444.2611689-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

QPL and UADK multifd backends use assert() to validate wire-controlled
fields like per-page compressed lengths and packet size consistency.  These
asserts will stop working with -DNDEBUG builds, so may stop working.

Replace all assert() calls in the receive path with proper error_setg() so
validation failures are reported gracefully rather than crashing or
silently ignored.

While at it, touch up an assert() in qatzip recv path too.

Cc: qemu-stable <qemu-stable@nongnu.org>
Cc: Yuan Liu <yuan1.liu@intel.com>
Cc: Yichen Wang <yichen.wang@bytedance.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20260728210417.1925078-4-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd-qatzip.c |  5 ++++-
 migration/multifd-qpl.c    | 24 ++++++++++++++++++++----
 migration/multifd-uadk.c   | 24 ++++++++++++++++++++----
 3 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/migration/multifd-qatzip.c b/migration/multifd-qatzip.c
index 7419e5dc0d..0262e81eac 100644
--- a/migration/multifd-qatzip.c
+++ b/migration/multifd-qatzip.c
@@ -348,7 +348,10 @@ static int qatzip_recv(MultiFDRecvParams *p, Error **errp)
 
     multifd_recv_zero_page_process(p);
     if (!p->normal_num) {
-        assert(in_size == 0);
+        if (in_size != 0) {
+            error_setg(errp, "multifd %u: expected empty packet", p->id);
+            return -1;
+        }
         return 0;
     }
 
diff --git a/migration/multifd-qpl.c b/migration/multifd-qpl.c
index 52902eb00c..3826e7f340 100644
--- a/migration/multifd-qpl.c
+++ b/migration/multifd-qpl.c
@@ -664,26 +664,42 @@ static int multifd_qpl_recv(MultiFDRecvParams *p, Error **errp)
     }
     multifd_recv_zero_page_process(p);
     if (!p->normal_num) {
-        assert(in_size == 0);
+        if (in_size != 0) {
+            error_setg(errp, "multifd %u: expected empty packet", p->id);
+            return -1;
+        }
         return 0;
     }
 
     /* read compressed page lengths */
     len = p->normal_num * sizeof(uint32_t);
-    assert(len < in_size);
+    if (len >= in_size) {
+        error_setg(errp, "multifd %u: header len %"PRIu32
+                   " >= packet size %"PRIu32, p->id, len, in_size);
+        return -1;
+    }
     ret = qio_channel_read_all(p->c, (void *) qpl->zlen, len, errp);
     if (ret != 0) {
         return ret;
     }
     for (int i = 0; i < p->normal_num; i++) {
         qpl->zlen[i] = be32_to_cpu(qpl->zlen[i]);
-        assert(qpl->zlen[i] <= multifd_ram_page_size());
+        if (qpl->zlen[i] > multifd_ram_page_size()) {
+            error_setg(errp, "multifd %u: page %d compressed len %"
+                       PRIu32" too large", p->id, i, qpl->zlen[i]);
+            return -1;
+        }
         zbuf_len += qpl->zlen[i];
         ramblock_recv_bitmap_set_offset(p->block, p->normal[i]);
     }
 
     /* read compressed pages */
-    assert(in_size == len + zbuf_len);
+    if (in_size != len + zbuf_len) {
+        error_setg(errp, "multifd %u: packet size %"PRIu32
+                   " != header %"PRIu32" + data %"PRIu32,
+                   p->id, in_size, len, zbuf_len);
+        return -1;
+    }
     ret = qio_channel_read_all(p->c, (void *) qpl->zbuf, zbuf_len, errp);
     if (ret != 0) {
         return ret;
diff --git a/migration/multifd-uadk.c b/migration/multifd-uadk.c
index fd7cd9b5e8..d373615ba8 100644
--- a/migration/multifd-uadk.c
+++ b/migration/multifd-uadk.c
@@ -245,12 +245,19 @@ static int multifd_uadk_recv(MultiFDRecvParams *p, Error **errp)
 
     multifd_recv_zero_page_process(p);
     if (!p->normal_num) {
-        assert(in_size == 0);
+        if (in_size != 0) {
+            error_setg(errp, "multifd %u: expected empty packet", p->id);
+            return -1;
+        }
         return 0;
     }
 
     /* read compressed data lengths */
-    assert(hdr_len < in_size);
+    if (hdr_len >= in_size) {
+        error_setg(errp, "multifd %u: header len %"PRIu32
+                   " >= packet size %"PRIu32, p->id, hdr_len, in_size);
+        return -1;
+    }
     ret = qio_channel_read_all(p->c, (void *) uadk_data->buf_hdr,
                                hdr_len, errp);
     if (ret != 0) {
@@ -259,12 +266,21 @@ static int multifd_uadk_recv(MultiFDRecvParams *p, Error **errp)
 
     for (int i = 0; i < p->normal_num; i++) {
         uadk_data->buf_hdr[i] = be32_to_cpu(uadk_data->buf_hdr[i]);
+        if (uadk_data->buf_hdr[i] > page_size) {
+            error_setg(errp, "multifd %u: page %d compressed len %"PRIu32
+                       " too large", p->id, i, uadk_data->buf_hdr[i]);
+            return -1;
+        }
         data_len += uadk_data->buf_hdr[i];
-        assert(uadk_data->buf_hdr[i] <= page_size);
     }
 
     /* read compressed data */
-    assert(in_size == hdr_len + data_len);
+    if (in_size != hdr_len + data_len) {
+        error_setg(errp, "multifd %u: packet size %"PRIu32
+                   " != header %"PRIu32" + data %"PRIu32,
+                   p->id, in_size, hdr_len, data_len);
+        return -1;
+    }
     ret = qio_channel_read_all(p->c, (void *)buf, data_len, errp);
     if (ret != 0) {
         return ret;
-- 
2.54.0



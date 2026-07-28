Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3EE9C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 21:05:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wooyq-0004X6-E1; Tue, 28 Jul 2026 17:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wooyY-0004U3-Ul
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 17:04:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wooyW-0003i2-0E
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 17:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785272671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+pei3vmco7Kz5qqmpc9dFtZ8rmZ+J3fui21id4q3x4w=;
 b=TpvRiMA1m+hFDrbF6Ssgt6qYt2u/BUTXwVPQhkQal40r1z9Dt1z6c3l9ajMbGV9jeYkaIa
 zJBIPr1hkLJHszEIIGoHTfP5V6QnwYhyxXM1gTJ5HHfUH54pLoQC/shKJ+Jxtz3jWLLvRK
 s8HGGFsCvCj7oJLBNAvQ7KU6xwhrh5U=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-XGYYBp2dN7yEw31ASmN-VQ-1; Tue, 28 Jul 2026 17:04:29 -0400
X-MC-Unique: XGYYBp2dN7yEw31ASmN-VQ-1
X-Mimecast-MFC-AGG-ID: XGYYBp2dN7yEw31ASmN-VQ_1785272669
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e4f27f49bso36708685a.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 14:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785272669; x=1785877469; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+pei3vmco7Kz5qqmpc9dFtZ8rmZ+J3fui21id4q3x4w=;
 b=YeAepEiweQ5jHxk5PFeSTblRZjqfiHI7nXSO5yelQtfwXWR8v4jii54zLHpm+daCVG
 7jLErBKXJGFe18Pfe1QbuxNL57KIxGAm1B/0SnkFs/cgTlM6BV8yoKWDqbuGZNUaITzY
 Ntn+tWgigaRykAg/MDqgq/g9/0sa4p/rNau8qpR0jbRb378hm6qlCI/FJiS4C9StxOxm
 ExD57V9Emi+XEeiS5E5HKR8h9CZAKPeOijJlzMAyc6CTq7/c7H4RN2a/nSlgSaYQiRTD
 UTH2Ppo9daElaUOYSxWBOqgvZ4kIXTJbL0f96HoUXei88TWFRmb2tfbU0i5/b8mmyRsK
 WF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785272669; x=1785877469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+pei3vmco7Kz5qqmpc9dFtZ8rmZ+J3fui21id4q3x4w=;
 b=Ac0wmrwKmX//7f38WEkzFsoeZpQJOLpMF/K+d5KzjBJxNLCFFLFXKGaLqHkUly/S4B
 Bb4RhDAf3jEqHnaerK/NYnDR8lJV1Aekfv7/HtY6QQ10iZkdp/lfQFliFlvuJz1Q7UXk
 /KdHT9v/5ePviwu1x5gMWiht44MCNVQn2RgBAG7RXJkViasUjX0Qso/Gs+0Is2sXhGXw
 UWYWavFFmrMbE6jrA7MP7L6lMQ9P47TiRyaDI/wYwZo6gxynpOPOPlaYnVys/6SgbkEW
 3z9CEX6RyD33+6qorGrnMSF/f8nxgXja7RX8MIK5g0OgiNZrmFXdeUqFt1K3LNTvzINI
 ubVg==
X-Gm-Message-State: AOJu0Yzk6gsq45f7wDWTA9MxGaBBFhvGruFwRn6DF4bMMY5AWhc2Bdcf
 Q8XQRkiGfROpyPT+9BPIKUb47wedvLoL+w5kqJsCfxA3ycMopAhqgA1kalYT62+jQRibJ4W+Kks
 GBvilJ3eTiwIElHR8UCCZImEdlhpAtEWUKX7wpz7TZ4HP8pAZp+Rxd6tbu0BRRf1l+6m1E+5Vri
 IGG5E6PAsd/VIXGezUdyaZcfiNsi96EStFgjSKTA==
X-Gm-Gg: AR+sD136C8hGTUJy1vbzgUq9lFolA0DAQ9Gs9HldIfjvkbALlX7tSRAbeO6wz511gc2
 UalXo4dX66QoSWUvjsgbmpqCTVJ0TTvR7ymqyjdhRHeUNthZjq3LYsIHnFa+j7+r9SPnp4bu1dG
 eYlFvMVIcL7rCv5ISWwu88+XKNS6p5v7FzWyItxk3Cn/N5g09BIhZpT5SJ70JFIHyKSi6EDuuxx
 sui6jvavPOzvIW60Oev+RqAvoa+QelxuPPKt71FTzUW1ZPyBckh9n5wvVBfBFyAqq0Gd2ke1xZA
 D7xe08jU57ILEzj8OzeBmgNTaQQDDhHeEcwfGPoG4uYOOKtELi6X2T/GBzFrd9qDjdkpzRvwLQu
 aJwxWwGqLelejpMbZpjItxKpaGSnUN+xKoZktG+ll4tevF1N94/PuOdzX
X-Received: by 2002:a05:620a:1712:b0:930:9c0c:657 with SMTP id
 af79cd13be357-93302620f6cmr408754785a.60.1785272669086; 
 Tue, 28 Jul 2026 14:04:29 -0700 (PDT)
X-Received: by 2002:a05:620a:1712:b0:930:9c0c:657 with SMTP id
 af79cd13be357-93302620f6cmr408750385a.60.1785272668412; 
 Tue, 28 Jul 2026 14:04:28 -0700 (PDT)
Received: from x1.com
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-933d3227707sm21277985a.6.2026.07.28.14.04.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 14:04:27 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 peterx@redhat.com, qemu-stable <qemu-stable@nongnu.org>,
 Yuan Liu <yuan1.liu@intel.com>, Yichen Wang <yichen.wang@bytedance.com>
Subject: [PATCH v2 3/5] migration/multifd: Replace assert() with error_setg()
 in recv paths
Date: Tue, 28 Jul 2026 17:04:15 -0400
Message-ID: <20260728210417.1925078-4-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260728210417.1925078-1-peterx@redhat.com>
References: <20260728210417.1925078-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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



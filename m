Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8EC0C5DF9C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 20:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyawI-0000HB-4i; Mon, 24 Aug 2026 16:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wyawG-0000Ga-OY
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 16:06:36 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wyawE-0004YU-RB
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 16:06:36 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6a18840e2abso6814471a12.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 13:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787601993; x=1788206793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2GafQ1n/IVAdBYtDXKArCWh0nJ8a8I6SRHj3bLDtVWA=;
 b=Fy7j6d7C+coENQhqhqLbm7YBCbPq+ysykI0SnUM+DYyDQ0fKfS9W6BFAwL/sGb6WIF
 bt0UEDAYMvwM6vFdriG7a1zNV4fLGNH51zYkvhwgdp/ydLPIVFIDnSzKdDuInPvkN2/S
 U59S8Ir90HzvZGo+ZclbedxvG1xe1vbZip9hKaCAN4RJjeTh1d2nVfnMFyYk+JCRiH0J
 IAiLDWU8ZVuCTMLAKR+1lkBbVwbKXxazG0P8/cYiU5GyvsDLn6Ih2NkmY4WEwcOL7DzN
 CZI2quNm9cFMluKdBKhLaNp5oOhY2s2TQ/qdCsJk0B4xDww8QOUOtTzdzOZwBDmGy4YG
 DR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787601993; x=1788206793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2GafQ1n/IVAdBYtDXKArCWh0nJ8a8I6SRHj3bLDtVWA=;
 b=a1ZzCuqxCufPnGHhgIO4V66Bd9/LQTlfwP7B6Ik2D8WS+YY7yVGiD/6kywG+k72uI9
 sdzrMIYeNA/jEW0oqSl/XC2J6wwWKLOeWcOGzNDAXiCeNsDY+1AJrXk4zXL/Cj9EAaxA
 2EFMbvBw5qgtYqU6/NjHkhZRCMaX51cUnF2M6y0K3KsffBSSg5XtL3junWW6sow7iZYW
 mgD3j4UY2aGAufCn9kosGnsszliLBv+HicKSKwoHifgpAAHTdF6VB/yy/5lJ1kI4bRDd
 UKtzo8JV9i4u93WlU4wJ3PoMdFHRqba/+xB9eArkfQK9vHR5XQhgACjgawk8sW2Hkh4z
 HGyQ==
X-Gm-Message-State: AFuF++m0bzBgplrHoPmh2QYVzUBanLR1x6cT6szwvhG9dOT3ENqtviBY
 f21ou9PxMh5nzmYWe72AevXA+mUAdnODFyl47B8/D0s8zgCbPY1slDfQj9A+4uLdzKATn/AF6fR
 vS9lL
X-Gm-Gg: AR+sD123eeqB97Tn5Jkj/iszAE8g0Z8wSZc8Kqew8dF6p7hi7CJABvPQjN5Cq5jWLMS
 FnGlnki2esbsn+ruwJhvqgn9jM5C/jupiPGWbnns+ndXZtgeqmmtWPaRoQiqVxlPuaDM3bxYGjM
 hv6BoH54Ad3ixJtrxBrvVMro8G1Tg6UoF6M4+K1W+ZXM7Xu4Wm0LRKD45bk9jok/Hfz+3CCaR61
 HyzG3dWBAVbpX4CTdqkWRz/x5nnVpQVbOKlLiJxV5WxmAX0UzvGkJFkaMrfb5bQullslOQEoDvk
 kJdxiSqCqeQ+KLX1UaxSEpjoBUl5FSwyDzaly5UhcAOxiZ9CujITkckUuFJDSDZhpgoF8DcqvAw
 k4gb4TxsRmOsTElS2kuZ1h1Te6gM6Jg4jSGJBHHUUVLXfwN287Lje3KUtqWBPzAzusUxuvV4ku7
 oNc6v/tZzjgUVyU8JzuxjbcMzilwo8SZzWU4GynlLDtggHqZR0u+oFUUrKsQ==
X-Received: by 2002:a05:6402:241a:b0:698:b6c8:70db with SMTP id
 4fb4d7f45d1cf-6a582b3c303mr24487287a12.8.1787601993346; 
 Mon, 24 Aug 2026 13:06:33 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:9048:7bf0:d3e2:2b9e])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e0228f1sm6152245a12.10.2026.08.24.13.06.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 13:06:32 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 1/7] tests/qtest/libqos: let mkqcow2() report failure
Date: Mon, 24 Aug 2026 22:06:21 +0200
Message-ID: <20260824200627.2180635-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAFn=p-bCR4TvVvHwagXiK-c0wuY5dACwh92249Wv0C3odCtbOg@mail.gmail.com>
References: <CAFn=p-bCR4TvVvHwagXiK-c0wuY5dACwh92249Wv0C3odCtbOg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=den@openvz.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Denis V. Lunev <den@openvz.org>

mkqcow2() asserts that qemu-img succeeded, so a caller that has
qemu-img but cannot use it aborts the binary rather than skipping.
Return the result instead. virtio-scsi-test takes the skip path it
already has for a missing qemu-img; ahci-test grows one two patches
on.

Cc: John Snow <jsnow@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qtest/libqos/libqos.c    | 4 ++--
 tests/qtest/libqos/libqos.h    | 2 +-
 tests/qtest/virtio-scsi-test.c | 5 ++++-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/libqos/libqos.c b/tests/qtest/libqos/libqos.c
index 9b49d0d4dd..ff0d595346 100644
--- a/tests/qtest/libqos/libqos.c
+++ b/tests/qtest/libqos/libqos.c
@@ -138,9 +138,9 @@ void migrate(QOSState *from, QOSState *to, const char *uri)
     migrate_allocator(&from->alloc, &to->alloc);
 }
 
-void mkqcow2(const char *file, unsigned size_mb)
+bool mkqcow2(const char *file, unsigned size_mb)
 {
-    g_assert_true(mkimg(file, "qcow2", size_mb));
+    return mkimg(file, "qcow2", size_mb);
 }
 
 void prepare_blkdebug_script(const char *debug_fn, const char *event)
diff --git a/tests/qtest/libqos/libqos.h b/tests/qtest/libqos/libqos.h
index c04950e2b1..8390d4fa98 100644
--- a/tests/qtest/libqos/libqos.h
+++ b/tests/qtest/libqos/libqos.h
@@ -27,7 +27,7 @@ QOSState *qtest_boot(QOSOps *ops, const char *cmdline_fmt, ...)
     G_GNUC_PRINTF(2, 3);
 void qtest_common_shutdown(QOSState *qs);
 void qtest_shutdown(QOSState *qs);
-void mkqcow2(const char *file, unsigned size_mb);
+bool mkqcow2(const char *file, unsigned size_mb);
 void migrate(QOSState *from, QOSState *to, const char *uri);
 void prepare_blkdebug_script(const char *debug_fn, const char *event);
 void generate_pattern(void *buffer, size_t len, size_t cycle_len);
diff --git a/tests/qtest/virtio-scsi-test.c b/tests/qtest/virtio-scsi-test.c
index e2350c52f6..bce6c11813 100644
--- a/tests/qtest/virtio-scsi-test.c
+++ b/tests/qtest/virtio-scsi-test.c
@@ -292,7 +292,10 @@ static void test_iothread_attach_node(void *obj, void *data,
         goto fail;
     }
 
-    mkqcow2(tmp_path, 64);
+    if (!mkqcow2(tmp_path, 64)) {
+        g_test_message("Could not create the qcow2 overlay");
+        goto fail;
+    }
 
     /* Attach the overlay to the null0 node */
     qtest_qmp_assert_success(scsi_pci->pci_vdev.pdev->bus->qts,
-- 
2.53.0



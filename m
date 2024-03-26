Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F299FCD1280
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 13:26:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp6oy-0006ri-C1; Tue, 26 Mar 2024 09:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rp6ou-0006oB-1g
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:26:28 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rp6op-0002X5-Ou
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:26:27 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6e74bd85f26so4353580b3a.1
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 06:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1711459577; x=1712064377; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zU4PLNWr9Y5kmuUeI681/wzuHnnzvhor10cjhySqMEU=;
 b=dJN8Uk2SBHlskefWYNd92zTys0ht3YxKBlSNw5xL4FTs1/bGDlisf/uIgWSkTtdQP2
 usjx3oSX5K4FDkPM3iat29/DQzUHa89xLDJcTei1x8vrg8RTD6raet/Ryow6TBi2Tw/Q
 4kHXsBI2oj2rXZuT2LO+1kMVDCj/D3q8gr0bqZZsANbRk7PUeGD6sHGUJnvBb1z1yCQ2
 D3BV0yIvs4/V2G1NgWhOJXzGi9bxrLRU40UuaHf0PYtZDL65mMt4aN1iRmqbaEEQNOee
 e63Ltx9rvhJ3GEf2xyCaMdtKDlE1KTVLNJ7WQemKgW/nC0JUJMmOlvXI/LBR1fDCpxX0
 tBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711459577; x=1712064377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zU4PLNWr9Y5kmuUeI681/wzuHnnzvhor10cjhySqMEU=;
 b=luHUb8r98mn7wpLdodxviVHpP1rC7yYcmJswTSNzkP4Gl20so3WuH1QIUJ4kReh7N1
 ISJtFSvrhtZtI2UfgnoJjQrieZfzQdDdHRhctt6PPw10v6lBBe7kKafmcnBt9bogHuDJ
 FnS5L+yroaIUUXzAEZst7IuLoFk58f5Bcd1GcLTazkRXh0GmdtEkdkabeQ7rqGYCcTpH
 xozkEl7Shh+y/J7AMdOvKCJI5B8SMBt1Y3ofWJutp6XRuSghjVKYMCciiki5E7xfjGYW
 0v+j9l7M45gYOEgRJT3FNJPE1zldHss3ZTz1dmGtxLdGR9jZnUr69cF2YExoWMKMSf3H
 paQQ==
X-Gm-Message-State: AOJu0YycUV+kObhjImwzjrccyeZeXZXzfRbxdrQhlxGPcxjqsdBXlPoH
 IoyhNO51RH4xPfcQb89GbaVrWRT32EvHJLLiHQMtHDoOOYhC3hMrEQRFPqw2oeI+UAyEBNtuMOA
 t
X-Google-Smtp-Source: AGHT+IFWZg07qfccz89Fgv6W+C13Ck3eMW9Ms3d25xlda22VX0Sdy1SorRO5CgwDcgI/WQ+2S8Jtdg==
X-Received: by 2002:a05:6a20:aa83:b0:1a3:ac30:100b with SMTP id
 ck3-20020a056a20aa8300b001a3ac30100bmr7391677pzb.62.1711459577218; 
 Tue, 26 Mar 2024 06:26:17 -0700 (PDT)
Received: from grind.. ([177.45.186.241]) by smtp.gmail.com with ESMTPSA id
 v10-20020aa799ca000000b006e9afb31e4bsm6080236pfi.12.2024.03.26.06.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 06:26:16 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, alistair.francis@wdc.com, groug@kaod.org,
 peter.maydell@linaro.org, qemu_oss@crudebyte.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 2/3] qtest/virtio-9p-test.c: consolidate hardlink tests
Date: Tue, 26 Mar 2024 10:26:05 -0300
Message-ID: <20240326132606.686025-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326132606.686025-1-dbarboza@ventanamicro.com>
References: <20240326132606.686025-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x435.google.com
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

We need all virtio-9p-test.c tests to clean themselves up after being
executed to avoid an issue where multiple test runs of this same test
will find remains of the previous run. See [1] to see the side effects
of that.

Previous patch dealt with most tests in this file. We're now
consolidating the 'hardlink' tests:

- copy the asserts that checks if the created link is a hard link from
  fs_hardlink_file() to fs_unlinkat_hardlink(). This will make
  fs_unlinkat_hardlink() do exactly what fs_hardlink_file() is doing;

- remove fs_hardlink_file();

- fs_unlinkat_hardlink() is renamed to fs_create_unlinkat_hardlink().
  We'll also remove 'real_file' and the '08' dir it creates.

With this last change all local 9p tests of the file are not leaving
files or dirs behind in the temporary dir, allowing multiple runs in the
same session to succeed.

[1] https://mail.gnu.org/archive/html/qemu-devel/2024-03/msg05807.html

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 tests/qtest/virtio-9p-test.c | 55 +++++++++++++++---------------------
 1 file changed, 22 insertions(+), 33 deletions(-)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index cdbe3e78ea..9938516fe7 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -600,39 +600,13 @@ static void fs_create_unlinkat_symlink(void *obj, void *data,
     g_assert(stat(new_dir, &st) != 0);
 }
 
-static void fs_hardlink_file(void *obj, void *data, QGuestAllocator *t_alloc)
+static void fs_create_unlinkat_hardlink(void *obj, void *data,
+                                        QGuestAllocator *t_alloc)
 {
     QVirtio9P *v9p = obj;
     v9fs_set_allocator(t_alloc);
-    struct stat st_real, st_link;
-    g_autofree char *real_file = virtio_9p_test_path("07/real_file");
-    g_autofree char *hardlink_file = virtio_9p_test_path("07/hardlink_file");
-
-    tattach({ .client = v9p });
-    tmkdir({ .client = v9p, .atPath = "/", .name = "07" });
-    tlcreate({ .client = v9p, .atPath = "07", .name = "real_file" });
-    g_assert(stat(real_file, &st_real) == 0);
-    g_assert((st_real.st_mode & S_IFMT) == S_IFREG);
-
-    tlink({
-        .client = v9p, .atPath = "07", .name = "hardlink_file",
-        .toPath = "07/real_file"
-    });
-
-    /* check if link exists now ... */
-    g_assert(stat(hardlink_file, &st_link) == 0);
-    /* ... and it's a hard link, right? */
-    g_assert((st_link.st_mode & S_IFMT) == S_IFREG);
-    g_assert(st_link.st_dev == st_real.st_dev);
-    g_assert(st_link.st_ino == st_real.st_ino);
-}
-
-static void fs_unlinkat_hardlink(void *obj, void *data,
-                                 QGuestAllocator *t_alloc)
-{
-    QVirtio9P *v9p = obj;
-    v9fs_set_allocator(t_alloc);
-    struct stat st_real, st_link;
+    struct stat st_real, st_link, st;
+    g_autofree char *new_dir = virtio_9p_test_path("08");
     g_autofree char *real_file = virtio_9p_test_path("08/real_file");
     g_autofree char *hardlink_file = virtio_9p_test_path("08/hardlink_file");
 
@@ -646,13 +620,29 @@ static void fs_unlinkat_hardlink(void *obj, void *data,
         .client = v9p, .atPath = "08", .name = "hardlink_file",
         .toPath = "08/real_file"
     });
+
+    /* check if link exists now ... */
     g_assert(stat(hardlink_file, &st_link) == 0);
+    /* ... and it's a hard link, right? */
+    g_assert((st_link.st_mode & S_IFMT) == S_IFREG);
+    g_assert(st_link.st_dev == st_real.st_dev);
+    g_assert(st_link.st_ino == st_real.st_ino);
 
     tunlinkat({ .client = v9p, .atPath = "08", .name = "hardlink_file" });
     /* symlink should be gone now */
     g_assert(stat(hardlink_file, &st_link) != 0);
     /* and old file should still exist */
     g_assert(stat(real_file, &st_real) == 0);
+
+    /* cleanup: remove old file and dir */
+    tunlinkat({ .client = v9p, .atPath = "08", .name = "real_file" });
+    g_assert(stat(real_file, &st_real) != 0);
+
+    tunlinkat({
+        .client = v9p, .atPath = "/", .name = "08",
+        .flags = P9_DOTL_AT_REMOVEDIR
+    });
+    g_assert(stat(new_dir, &st) != 0);
 }
 
 static void *assign_9p_local_driver(GString *cmd_line, void *arg)
@@ -714,9 +704,8 @@ static void register_virtio_9p_test(void)
                  fs_create_unlinkat_file, &opts);
     qos_add_test("local/create_unlinkat_symlink", "virtio-9p",
                  fs_create_unlinkat_symlink, &opts);
-    qos_add_test("local/hardlink_file", "virtio-9p", fs_hardlink_file, &opts);
-    qos_add_test("local/unlinkat_hardlink", "virtio-9p", fs_unlinkat_hardlink,
-                 &opts);
+    qos_add_test("local/create_unlinkat_hardlink", "virtio-9p",
+                 fs_create_unlinkat_hardlink, &opts);
 }
 
 libqos_init(register_virtio_9p_test);
-- 
2.44.0



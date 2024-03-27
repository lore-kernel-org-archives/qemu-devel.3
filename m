Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A89CC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 09:34:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpPdo-0006Be-Ph; Wed, 27 Mar 2024 05:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rpPdl-0006AR-4W
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:32:14 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rpPdh-0007nT-T8
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:32:11 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6e6c0098328so4513206b3a.3
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 02:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1711531927; x=1712136727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7nMAeHd1FtL+QcrNG1cSxDeodNP8yzWlHRCdD7o0fyk=;
 b=IyXf0o6xFU3kS/zo+Di2mObD6iAtTuj99lJzyZyvPy9G6L3bvG48IbIh3FG6zSGyuy
 MLDhFkm62dyCFdK1Jlr6dpfjp2N6uGEm5+13E/MAeVIMznI7KjwM0PapXHgxn9WDshbz
 E2gqMZA6GABul4MTflNcVkBoCPikoGeYmozShgULNuC1U5kycnKnpvUCAfu5GrO73Hy/
 wthUsv/LjxFOYWCofAP1X0KKQlqc4JAyJ5oOHfMmk7bO9N2r5ea9ScA4p7NdEk+ModQC
 vKD86zigqJ/CHZZ/CjkMFx++eNSS/pCbvaoU5WBbA9pjfAP8ZAz8udQRX6bysBpd+ZZh
 eNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711531927; x=1712136727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7nMAeHd1FtL+QcrNG1cSxDeodNP8yzWlHRCdD7o0fyk=;
 b=qfgz1EIA6GWBoC1c8plZHyK7hL8oENNdJm5JxeG7NJS4Icp6x4zX04uPIbfPamSIMI
 rRxWjAhLICcR873H5yljpx4e22XyU1FZYpqez1nMKZTmwUpRxBie2BNavqJfzIjE6c7G
 r1r0lJeu91fG1eHOgoasURU7VzkGAT2Tb8IcZRF6ZDT4p/njngDiErVqbiHcrNIC+Anx
 HUqZc7fsHa5veiyy9HMCyF10fd6iQM1h0rROPNZoKXLv5S/Lpz2AxkwVcgHofsU8JLZR
 9GizE7nSOm9XNOgpLCvOcGX+TqM3CdKkpOmknLLdBuhwpW1b3QaUq9jrVoqHIHw4vFU5
 eTeg==
X-Gm-Message-State: AOJu0YyEhe1zuO2cof+WfVgaHuhxQSKpyqOF7puZM6pfqf6QfmLD+dvv
 LtS62Nl0fAN87f0CTWh4lVedidSclLjHyzzPC10razO/hnHAEq20r1467nMCrkD0neEaAvjSu+z
 b
X-Google-Smtp-Source: AGHT+IFkp44CPWb4Lx3V1/2p1zgSyGsW0tUNvsNHd0oFcI8Ws22xz6d643IRvRbLnaYleOXzmbWCYA==
X-Received: by 2002:a05:6a00:2d92:b0:6ea:8775:a66d with SMTP id
 fb18-20020a056a002d9200b006ea8775a66dmr732031pfb.1.1711531927017; 
 Wed, 27 Mar 2024 02:32:07 -0700 (PDT)
Received: from grind.. ([177.45.186.241]) by smtp.gmail.com with ESMTPSA id
 fm23-20020a056a002f9700b006e6b41511fdsm7628760pfb.94.2024.03.27.02.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 02:32:06 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, alistair.francis@wdc.com, groug@kaod.org,
 peter.maydell@linaro.org, qemu_oss@crudebyte.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 v2 6/7] qtest/virtio-9p-test.c: consolidate hardlink
 tests
Date: Wed, 27 Mar 2024 06:31:43 -0300
Message-ID: <20240327093144.781701-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327093144.781701-1-dbarboza@ventanamicro.com>
References: <20240327093144.781701-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x434.google.com
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

We've consolidated all local 9p tests but the hardlink ones. To make
fs_unlinkat_hardlink() to act exactly like fs_hardlink_file() we added
the g_assert(st_link...) checks in fs_unlinkat_hardlink() as well.

After that:

- remove fs_hardlink_file(). Rename fs_unlinkat_hardlink() to
  fs_create_unlinkat_hardlink();

- remove the created dir and 'real_file' at the end of
  fs_create_unlinkat_hardlink().

After this patch all local 9p tests are now cleaning themselves up after
execution and we shouldn't experience errors like the one reported in
[1].

[1] https://mail.gnu.org/archive/html/qemu-devel/2024-03/msg05807.html

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 tests/qtest/virtio-9p-test.c | 52 +++++++++++-------------------------
 1 file changed, 16 insertions(+), 36 deletions(-)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index 222d11037d..f85f4ef407 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -614,12 +614,14 @@ static void fs_create_unlinkat_symlink(void *obj, void *data,
     g_assert(stat(new_dir_path, &st) != 0);
 }
 
-static void fs_hardlink_file(void *obj, void *data, QGuestAllocator *t_alloc)
+static void fs_create_unlinkat_hardlink(void *obj, void *data,
+                                        QGuestAllocator *t_alloc)
 {
     QVirtio9P *v9p = obj;
     v9fs_set_allocator(t_alloc);
-    struct stat st_real, st_link;
+    struct stat st_real, st_link, st;
     const char *new_dir = "04";
+    g_autofree char *new_dir_path = virtio_9p_test_path(new_dir);
     g_autofree char *real_file = NULL;
     g_autofree char *real_file_path = NULL;
     g_autofree char *hardlink_file = NULL;
@@ -648,43 +650,22 @@ static void fs_hardlink_file(void *obj, void *data, QGuestAllocator *t_alloc)
     g_assert((st_link.st_mode & S_IFMT) == S_IFREG);
     g_assert(st_link.st_dev == st_real.st_dev);
     g_assert(st_link.st_ino == st_real.st_ino);
-}
-
-static void fs_unlinkat_hardlink(void *obj, void *data,
-                                 QGuestAllocator *t_alloc)
-{
-    QVirtio9P *v9p = obj;
-    v9fs_set_allocator(t_alloc);
-    struct stat st_real, st_link;
-    const char *new_dir = "05";
-    g_autofree char *real_file = NULL;
-    g_autofree char *real_file_path = NULL;
-    g_autofree char *hardlink_file = NULL;
-    g_autofree char *hardlink_file_path = NULL;
-
-    real_file = g_strdup_printf("%s/%s", new_dir, "real_file");
-    real_file_path = virtio_9p_test_path(real_file);
-
-    hardlink_file = g_strdup_printf("%s/%s", new_dir, "hardlink_file");
-    hardlink_file_path = virtio_9p_test_path(hardlink_file);
-
-    tattach({ .client = v9p });
-    tmkdir({ .client = v9p, .atPath = "/", .name = new_dir });
-    tlcreate({ .client = v9p, .atPath = new_dir, .name = "real_file" });
-    g_assert(stat(real_file_path, &st_real) == 0);
-    g_assert((st_real.st_mode & S_IFMT) == S_IFREG);
-
-    tlink({
-        .client = v9p, .atPath = new_dir, .name = "hardlink_file",
-        .toPath = real_file
-    });
-    g_assert(stat(hardlink_file_path, &st_link) == 0);
 
     tunlinkat({ .client = v9p, .atPath = new_dir, .name = "hardlink_file" });
     /* symlink should be gone now */
     g_assert(stat(hardlink_file_path, &st_link) != 0);
     /* and old file should still exist */
     g_assert(stat(real_file_path, &st_real) == 0);
+
+    /* cleanup: remove created file and dir */
+    tunlinkat({ .client = v9p, .atPath = new_dir, .name = "real_file" });
+    g_assert(stat(real_file_path, &st_real) != 0);
+
+    tunlinkat({
+        .client = v9p, .atPath = "/", .name = new_dir,
+        .flags = P9_DOTL_AT_REMOVEDIR
+    });
+    g_assert(stat(new_dir_path, &st) != 0);
 }
 
 static void *assign_9p_local_driver(GString *cmd_line, void *arg)
@@ -746,9 +727,8 @@ static void register_virtio_9p_test(void)
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD013C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 14:21:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpU8g-0004qS-Hn; Wed, 27 Mar 2024 10:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rpU8f-0004p8-4f
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 10:20:25 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rpU8c-00012D-Ne
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 10:20:24 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6e6b3dc3564so4839787b3a.2
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 07:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1711549220; x=1712154020; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dE8cz24Njw98k6nSsMHYnRI5+W71Jbus9gwpk8ecbyg=;
 b=Ka3FhcnyyZrJGWAWhqZ4r7pfJlNpAfTfoyyC29Euqyb4AV64Pja9VsSjn5iEuN80Iq
 txZ8qgt9vGWI2iMbiNIe0Va5ndxtm+TaG+J/fBcqtwTJvhpcWf0/tdolBlIbXtmG9Wj/
 x0QiBZl0ZpNq+p7dhxXbmC/dcgoWk+w5uXV4JRtFcsBc5Nkir2TG4hNc9oNYwdBNSzWQ
 zcyuKo7s8kp+1m1OCHG7T3jMte1bCGrj9SmQlmp6r7mAAOvSLT67r3qzS+lUw6d+2gOq
 87aIHPncTczNbGi8UGRlvSOS1bv+uy6RyxusayLIS27gFE7PlEsbGC81NOTT+N6phfAS
 SsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711549220; x=1712154020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dE8cz24Njw98k6nSsMHYnRI5+W71Jbus9gwpk8ecbyg=;
 b=e59bsAL93qme4/oKIGRkOeUH4w0roZWMy0a48ezPJKBDSq313od/WPXxhyRibN4f/f
 0fyqCGJjdoQ2UQA2Nf4tiEJ0Q2W5Chy4MUJYoUeg/1jdoqFlx69mkB+5wLWvNQMwiti8
 M7d3tStdbNNj89KroyAgOwZLEKNGT3gz72KnNnnlAjNU0Y028erx54YWT+dGoLCY2YA6
 LdKJxtKsoLa5io2ZwNBUDsCEOiuTEMoJqLi3Lh1bXQuMU807/575z7nbzsCjhwrw2k1z
 XBvRIXGpfzcIRiRRGSdoxWf7yPwmxF8p/xieI3fRBO3NnK/qKu/Kjt8DaQdtKVYjw4is
 hE6Q==
X-Gm-Message-State: AOJu0YxLUZQfxQfC20oMHxfhae1HP24ZkKqgBLeBGUIYPBKc5gXe243c
 FfWpgGiKIZYcgSTuEiv7F0FOulzAvJfX5RGraS9WMhcehmiFgJqt3nqRISOjZ4G1mfwhnouQPfG
 b
X-Google-Smtp-Source: AGHT+IGSaJ2hXhAAzvgJUns+rQTdoalsHgp2juzNC+Zt0VZp3qDeNV1IO9dNtBqmY+rvB0gIrXW+jQ==
X-Received: by 2002:a05:6a20:3ca7:b0:1a3:c266:e7bd with SMTP id
 b39-20020a056a203ca700b001a3c266e7bdmr98411pzj.38.1711549220360; 
 Wed, 27 Mar 2024 07:20:20 -0700 (PDT)
Received: from grind.. ([177.45.186.241]) by smtp.gmail.com with ESMTPSA id
 fa26-20020a056a002d1a00b006ea7b343877sm7891809pfb.9.2024.03.27.07.20.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 07:20:20 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, alistair.francis@wdc.com, groug@kaod.org,
 peter.maydell@linaro.org, qemu_oss@crudebyte.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 v3 1/2] qtest/virtio-9p-test.c: create/remove temp
 dirs after each test
Date: Wed, 27 Mar 2024 11:20:10 -0300
Message-ID: <20240327142011.805728-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327142011.805728-1-dbarboza@ventanamicro.com>
References: <20240327142011.805728-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42e.google.com
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

The local 9p driver in virtio-9p-test.c its temporary dir right at the
start of qos-test (via virtio_9p_create_local_test_dir()) and only
deletes it after qos-test is finished (via
virtio_9p_remove_local_test_dir()).

This means that any qos-test machine that ends up running virtio-9p-test
local tests more than once will end up re-using the same temp dir. This
is what's happening in [1] after we introduced the riscv machine nodes:
if we enable slow tests with the '-m slow' flag using
qemu-system-riscv64, this is what happens:

- a temp dir is created;

- virtio-9p-device tests will run virtio-9p-test successfully;

- virtio-9p-pci tests will run virtio-9p-test, and fail right at the
  first slow test at fs_create_dir() because the "01" file was already
created by fs_create_dir() test when running with the virtio-9p-device.

The root cause is that we're creating a single temporary dir, via the
construct/destruct callbacks, and this temp dir is kept for the entire
qos-test run.

We can change each test to clean after themselves. This approach would
make the 'create' tests obsolete since we would need to create and
delete dirs/files/symlinks for the cleanup, turning them into the
'unlinkat' tests that comes right after.

We chose a different approach that handles the root cause: do not use
constructor/destructor to create the temp dir. Create one temp dir for
each test, and remove it after the test is complete. This is the
approach taken for other qtests like vhost-user-test.c where each test
requires a setup() and a subsequent cleanup(), all of those instantiated
in the .before callback.

[1] https://mail.gnu.org/archive/html/qemu-devel/2024-03/msg05807.html

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 tests/qtest/virtio-9p-test.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index 65e69491e5..0179b3a394 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -693,9 +693,20 @@ static void fs_unlinkat_hardlink(void *obj, void *data,
     g_assert(stat(real_file, &st_real) == 0);
 }
 
+static void cleanup_9p_local_driver(void *data)
+{
+    /* remove previously created test dir when test is completed */
+    virtio_9p_remove_local_test_dir();
+}
+
 static void *assign_9p_local_driver(GString *cmd_line, void *arg)
 {
+    /* make sure test dir for the 'local' tests exists */
+    virtio_9p_create_local_test_dir();
+
     virtio_9p_assign_local_driver(cmd_line, "security_model=mapped-xattr");
+
+    g_test_queue_destroy(cleanup_9p_local_driver, NULL);
     return arg;
 }
 
@@ -759,15 +770,3 @@ static void register_virtio_9p_test(void)
 }
 
 libqos_init(register_virtio_9p_test);
-
-static void __attribute__((constructor)) construct_9p_test(void)
-{
-    /* make sure test dir for the 'local' tests exists */
-    virtio_9p_create_local_test_dir();
-}
-
-static void __attribute__((destructor)) destruct_9p_test(void)
-{
-    /* remove previously created test dir when test suite completed */
-    virtio_9p_remove_local_test_dir();
-}
-- 
2.44.0



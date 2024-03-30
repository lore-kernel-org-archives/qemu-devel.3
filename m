Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80938CD128E
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Mar 2024 14:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqZOM-0001qA-D5; Sat, 30 Mar 2024 10:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <981eb1060336ee0e371369088c55f81f5a577ce8@kylie.crudebyte.com>)
 id 1rqZOL-0001pw-9D
 for qemu-devel@nongnu.org; Sat, 30 Mar 2024 10:09:05 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <981eb1060336ee0e371369088c55f81f5a577ce8@kylie.crudebyte.com>)
 id 1rqZOJ-0000KS-OZ
 for qemu-devel@nongnu.org; Sat, 30 Mar 2024 10:09:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=p4yWR2jE1drMam6OIg84j1pNMI843XpHqUbHzG+tZj4=; b=VnOry
 nrYHe8uS9xo4QczFv29vZTdhlhgxOnTtQdcJQTlc0Ck9MGf3g16O0pi9G+v3hYM4C0LOzhXqukK7l
 aKS7XJ89rTGb0P4cuglh00izgpjFLENmWLlZNYJr3uwB+kZe0NVr93fJp5Tvx9JN3Ey1S4+9mTw9p
 I+RTXuHypkFd0CA6Vgxr+mNLS9sup5g98w+JccfP4p0nM+NLTn6JTUU9yUmhsvLT40E4DppyCeqT/
 Qw4ts6KOOHtBqlkGeA8WgsmqftUtA0v/AEyh8fPxQh+/4/dwy4sSWiM9qJcTLn5p0pTPgc8OGQ86c
 ppGAj6XgHuopqJNUnigmpb0mtHAIy1oGChx69F9LablJ09hjRxKAbYU7Rh0kMKmeJQb04qbYKE8i9
 Gs0Lr3LMm/JRfWJlhKLo48zF3yq5EKy5cfOWv4GG+LxmuseHWc2Ug/dyxNsI5Y1nRC4sV6akwcJKY
 s2GMUuImmtBdMtdxQ+F/4PxXGDE9rb+59B2wwXaAkAcPWuVnRs25I971tYJ8cRhiTotkis0clCl0G
 2Bz39nVNRj+Qz7TL8TLn5Rr0K7VLE9TkKr0HMh7NZ0lZGPhw7U3qehRBoOFzSKT42Y6V+K6AHvAtF
 9viH+V2sMTov6xX4HK2C4j0BoyMtU8VrtXdSCCOmIt+mAdM3pvnM2jnAr5S4pY=;
Message-Id: <981eb1060336ee0e371369088c55f81f5a577ce8.1711702001.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1711702001.git.qemu_oss@crudebyte.com>
References: <cover.1711702001.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sat, 30 Mar 2024 14:33:03 +0100
Subject: [PULL for-9.0 1/2] qtest/virtio-9p-test.c: create/remove temp dirs
 after each test
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Thomas Huth <thuth@redhat.com>
Received-SPF: none client-ip=5.189.157.229;
 envelope-from=981eb1060336ee0e371369088c55f81f5a577ce8@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

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
Message-Id: <20240327142011.805728-2-dbarboza@ventanamicro.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
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
2.30.2



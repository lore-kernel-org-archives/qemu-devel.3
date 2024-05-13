Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9EB7C25B75
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 12:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Usr-0004N6-St; Mon, 13 May 2024 08:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s6Usa-0004Lv-SD
 for qemu-devel@nongnu.org; Mon, 13 May 2024 08:34:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s6UsZ-0004RJ-0c
 for qemu-devel@nongnu.org; Mon, 13 May 2024 08:34:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715603645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OKqgQX8fmaPktxa4XwcC+dyC6thgGCkVRK4gnPBpMUE=;
 b=ebDXxlcjnX/0bSyUIQt453TZfeWzxzBEzXFDHR3nRWUDd7SfkoCXe4kQD3XhEst6NmEHZG
 fqG6ZCNQ9/84V3ib9l5oZbmi1sfI5+eqG0hTexSEb3fQ0qJVTvY4YWg61wd9524tlXTyrw
 I4cHGbHqFWMwFa12L20brNhHZD4q4tI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-OiADxjuAP6KTEO9ciwVKrg-1; Mon, 13 May 2024 08:34:02 -0400
X-MC-Unique: OiADxjuAP6KTEO9ciwVKrg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 219C6857A85;
 Mon, 13 May 2024 12:34:02 +0000 (UTC)
Received: from toolbox.default.com (unknown [10.42.28.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9977C51BF;
 Mon, 13 May 2024 12:34:00 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, devel@lists.libvirt.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Krempa <pkrempa@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 1/2] hw/core: allow parameter=1 for SMP topology on any machine
Date: Mon, 13 May 2024 13:33:57 +0100
Message-ID: <20240513123358.612355-2-berrange@redhat.com>
In-Reply-To: <20240513123358.612355-1-berrange@redhat.com>
References: <20240513123358.612355-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This effectively reverts

  commit 54c4ea8f3ae614054079395842128a856a73dbf9
  Author: Zhao Liu <zhao1.liu@intel.com>
  Date:   Sat Mar 9 00:01:37 2024 +0800

    hw/core/machine-smp: Deprecate unsupported "parameter=1" SMP configurations

but is not done as a 'git revert' since the part of the changes to the
file hw/core/machine-smp.c which add 'has_XXX' checks remain desirable.
Furthermore, we have to tweak the subsequently added unit test to
account for differing warning message.

The rationale for the original deprecation was:

  "Currently, it was allowed for users to specify the unsupported
   topology parameter as "1". For example, x86 PC machine doesn't
   support drawer/book/cluster topology levels, but user could specify
   "-smp drawers=1,books=1,clusters=1".

   This is meaningless and confusing, so that the support for this kind
   of configurations is marked deprecated since 9.0."

There are varying POVs on the topic of 'unsupported' topology levels.

It is common to say that on a system without hyperthreading, that there
is always 1 thread. Likewise when new CPUs introduced a concept of
multiple "dies', it was reasonable to say that all historical CPUs
before that implicitly had 1 'die'. Likewise for the more recently
introduced 'modules' and 'clusters' parameter'. From this POV, it is
valid to set 'parameter=1' on the -smp command line for any machine,
only a value > 1 is strictly an error condition.

It doesn't cause any functional difficulty for QEMU, because internally
the QEMU code is itself assuming that all "unsupported" parameters
implicitly have a value of '1'.

At the libvirt level, we've allowed applications to set 'parameter=1'
when configuring a guest, and pass that through to QEMU.

Deprecating this creates extra difficulty for because there's no info
exposed from QEMU about which machine types "support" which parameters.
Thus, libvirt can't know whether it is valid to pass 'parameter=1' for
a given machine type, or whether it will trigger deprecation messages.

Since there's no apparent functional benefit to deleting this deprecated
behaviour from QEMU, and it creates problems for consumers of QEMU,
remove this deprecation.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 docs/about/deprecated.rst   | 14 -------
 hw/core/machine-smp.c       | 82 ++++++++++++-------------------------
 tests/unit/test-smp-parse.c |  8 ++--
 3 files changed, 30 insertions(+), 74 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index e22acb17f2..5b551b12a6 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -47,20 +47,6 @@ as short-form boolean values, and passed to plugins as ``arg_name=on``.
 However, short-form booleans are deprecated and full explicit ``arg_name=on``
 form is preferred.
 
-``-smp`` (Unsupported "parameter=1" SMP configurations) (since 9.0)
-'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
-
-Specified CPU topology parameters must be supported by the machine.
-
-In the SMP configuration, users should provide the CPU topology parameters that
-are supported by the target machine.
-
-However, historically it was allowed for users to specify the unsupported
-topology parameter as "1", which is meaningless. So support for this kind of
-configurations (e.g. -smp drawers=1,books=1,clusters=1 for x86 PC machine) is
-marked deprecated since 9.0, users have to ensure that all the topology members
-described with -smp are supported by the target machine.
-
 User-mode emulator command line arguments
 -----------------------------------------
 
diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
index 2b93fa99c9..eb43caca9b 100644
--- a/hw/core/machine-smp.c
+++ b/hw/core/machine-smp.c
@@ -119,75 +119,45 @@ void machine_parse_smp_config(MachineState *ms,
 
     /*
      * If not supported by the machine, a topology parameter must be
-     * omitted.
+     * not be set to a value greater than 1.
      */
-    if (!mc->smp_props.modules_supported && config->has_modules) {
-        if (config->modules > 1) {
-            error_setg(errp, "modules not supported by this "
-                       "machine's CPU topology");
-            return;
-        } else {
-            /* Here modules only equals 1 since we've checked zero case. */
-            warn_report("Deprecated CPU topology (considered invalid): "
-                        "Unsupported modules parameter mustn't be "
-                        "specified as 1");
-        }
+    if (!mc->smp_props.modules_supported &&
+        config->has_modules && config->modules > 1) {
+        error_setg(errp,
+                   "modules > 1 not supported by this machine's CPU topology");
+        return;
     }
     modules = modules > 0 ? modules : 1;
 
-    if (!mc->smp_props.clusters_supported && config->has_clusters) {
-        if (config->clusters > 1) {
-            error_setg(errp, "clusters not supported by this "
-                       "machine's CPU topology");
-            return;
-        } else {
-            /* Here clusters only equals 1 since we've checked zero case. */
-            warn_report("Deprecated CPU topology (considered invalid): "
-                        "Unsupported clusters parameter mustn't be "
-                        "specified as 1");
-        }
+    if (!mc->smp_props.clusters_supported &&
+        config->has_clusters && config->clusters > 1) {
+        error_setg(errp,
+                   "clusters > 1 not supported by this machine's CPU topology");
+        return;
     }
     clusters = clusters > 0 ? clusters : 1;
 
-    if (!mc->smp_props.dies_supported && config->has_dies) {
-        if (config->dies > 1) {
-            error_setg(errp, "dies not supported by this "
-                       "machine's CPU topology");
-            return;
-        } else {
-            /* Here dies only equals 1 since we've checked zero case. */
-            warn_report("Deprecated CPU topology (considered invalid): "
-                        "Unsupported dies parameter mustn't be "
-                        "specified as 1");
-        }
+    if (!mc->smp_props.dies_supported &&
+        config->has_dies && config->dies > 1) {
+        error_setg(errp,
+                   "dies > 1 not supported by this machine's CPU topology");
+        return;
     }
     dies = dies > 0 ? dies : 1;
 
-    if (!mc->smp_props.books_supported && config->has_books) {
-        if (config->books > 1) {
-            error_setg(errp, "books not supported by this "
-                       "machine's CPU topology");
-            return;
-        } else {
-            /* Here books only equals 1 since we've checked zero case. */
-            warn_report("Deprecated CPU topology (considered invalid): "
-                        "Unsupported books parameter mustn't be "
-                        "specified as 1");
-        }
+    if (!mc->smp_props.books_supported &&
+        config->has_books && config->books > 1) {
+        error_setg(errp,
+                   "books > 1 not supported by this machine's CPU topology");
+        return;
     }
     books = books > 0 ? books : 1;
 
-    if (!mc->smp_props.drawers_supported && config->has_drawers) {
-        if (config->drawers > 1) {
-            error_setg(errp, "drawers not supported by this "
-                       "machine's CPU topology");
-            return;
-        } else {
-            /* Here drawers only equals 1 since we've checked zero case. */
-            warn_report("Deprecated CPU topology (considered invalid): "
-                        "Unsupported drawers parameter mustn't be "
-                        "specified as 1");
-        }
+    if (!mc->smp_props.drawers_supported &&
+        config->has_drawers && config->drawers > 1) {
+        error_setg(errp,
+                   "drawers > 1 not supported by this machine's CPU topology");
+        return;
     }
     drawers = drawers > 0 ? drawers : 1;
 
diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index 8994337e12..56165e6644 100644
--- a/tests/unit/test-smp-parse.c
+++ b/tests/unit/test-smp-parse.c
@@ -337,21 +337,21 @@ static const struct SMPTestData data_generic_invalid[] = {
     {
         /* config: -smp 2,dies=2 */
         .config = SMP_CONFIG_WITH_DIES(T, 2, F, 0, T, 2, F, 0, F, 0, F, 0),
-        .expect_error = "dies not supported by this machine's CPU topology",
+        .expect_error = "dies > 1 not supported by this machine's CPU topology",
     }, {
         /* config: -smp 2,clusters=2 */
         .config = SMP_CONFIG_WITH_CLUSTERS(T, 2, F, 0, T, 2, F, 0, F, 0, F, 0),
-        .expect_error = "clusters not supported by this machine's CPU topology",
+        .expect_error = "clusters > 1 not supported by this machine's CPU topology",
     }, {
         /* config: -smp 2,books=2 */
         .config = SMP_CONFIG_WITH_BOOKS_DRAWERS(T, 2, F, 0, T, 2, F,
                                                 0, F, 0, F, 0, F, 0),
-        .expect_error = "books not supported by this machine's CPU topology",
+        .expect_error = "books > 1 not supported by this machine's CPU topology",
     }, {
         /* config: -smp 2,drawers=2 */
         .config = SMP_CONFIG_WITH_BOOKS_DRAWERS(T, 2, T, 2, F, 0, F,
                                                 0, F, 0, F, 0, F, 0),
-        .expect_error = "drawers not supported by this machine's CPU topology",
+        .expect_error = "drawers > 1 not supported by this machine's CPU topology",
     }, {
         /* config: -smp 8,sockets=2,cores=4,threads=2,maxcpus=8 */
         .config = SMP_CONFIG_GENERIC(T, 8, T, 2, T, 4, T, 2, T, 8),
-- 
2.43.0



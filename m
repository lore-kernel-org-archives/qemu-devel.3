Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42288C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 21:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPTb2-0001ao-Eq; Thu, 04 Jul 2024 17:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sPTar-0001Os-3v; Thu, 04 Jul 2024 17:02:18 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sPTak-0004Q5-NT; Thu, 04 Jul 2024 17:02:16 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 65E8E7756E;
 Fri,  5 Jul 2024 00:00:51 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 7907AFECA7;
 Fri,  5 Jul 2024 00:00:56 +0300 (MSK)
Received: (nullmailer pid 1507762 invoked by uid 1000);
 Thu, 04 Jul 2024 21:00:55 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?J=C3=A1n=20Tomko?= <jtomko@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.2 16/22] hw/core: allow parameter=1 for SMP topology on
 any machine
Date: Fri,  5 Jul 2024 00:00:46 +0300
Message-Id: <20240704210055.1507652-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.2-20240704162154@cover.tls.msk.ru>
References: <qemu-stable-9.0.2-20240704162154@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Daniel P. Berrangé <berrange@redhat.com>

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
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Ján Tomko <jtomko@redhat.com>
Message-ID: <20240513123358.612355-2-berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 9d7950edb0cdf8f4e5746e220e6e8a9e713bad16)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: remove hunk about modules in hw/core/machine-smp.c introduced in
 v9.0.0-155-g8ec0a4634798 "hw/core/machine: Support modules in -smp")

diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
index 27864c9507..b5e3849d3d 100644
--- a/hw/core/machine-smp.c
+++ b/hw/core/machine-smp.c
@@ -112,62 +112,38 @@ void machine_parse_smp_config(MachineState *ms,
     }
 
     /*
-     * If not supported by the machine, a topology parameter must be
-     * omitted.
+     * If not supported by the machine, a topology parameter must
+     * not be set to a value greater than 1.
      */
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
2.39.2



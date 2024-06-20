Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19831C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 16:59:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKL7z-0006q6-To; Thu, 20 Jun 2024 12:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sKL7y-0006ow-Ef
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 12:59:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sKL7w-00013w-LS
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 12:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718902752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uaWjoLG2gOtVq/FVkDMOulCrYvJAR4cTwZqxuxD/9Cg=;
 b=RdJPQsEnNOIS9CaCSteYrZ48IzIau+Wefie+vypwBlD6Kb3TwC+PLbMMpoD5lIvH0pGhdZ
 /CaN/tAVXdrq4DJIyymStEwDFZoPi8zClI0saBOunCWVffrsm4PXn5uSY3PcmeL6fogi4b
 BNDAaP63FFQvRrKQ8/0UrZ7F6JOjrb0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-OtrZOsfxM6mQM7wv9XEZaw-1; Thu,
 20 Jun 2024 12:59:08 -0400
X-MC-Unique: OtrZOsfxM6mQM7wv9XEZaw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9764A19560B3; Thu, 20 Jun 2024 16:59:04 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.69])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0AC8A19560AF; Thu, 20 Jun 2024 16:58:55 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>, devel@lists.libvirt.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clegoate@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 08/14] include/hw: add macros for deprecation & removal of
 versioned machines
Date: Thu, 20 Jun 2024 17:57:36 +0100
Message-ID: <20240620165742.1711389-9-berrange@redhat.com>
In-Reply-To: <20240620165742.1711389-1-berrange@redhat.com>
References: <20240620165742.1711389-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Versioned machines live for a long time to provide back compat for
incoming migration and restore of saved images. To guide users away from
usage of old machines, however, we want to deprecate any older than 3
years (equiv of 9 releases), and delete any older than 6 years (equiva
of 18 releases).

To get a standardized deprecation message and avoid having to remember
to manually add it after three years, this introduces two macros to be
used by targets when defining versioned machines.

* MACHINE_VER_DEPRECATION(major, minor)

  Automates the task of setting the 'deprecation_reason' field on the
  machine, if-and-only-if the major/minor version is older than 3 years.

* MACHINE_VER_DELETION(major, minor)

  Simulates the deletion of by skipping registration of the QOM type
  for a versioned machine, if-and-only-if the major/minor version is
  older than 6 years.

By using these two macros there is no longer any manual work required
per-release to deprecate old machines. By preventing the use of machines
that have reached their deletion date, it is also not necessary to
manually delete machines per-release. Deletion can be batched up once a
year or whenever makes most sense.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/hw/boards.h | 96 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index d5ad712585..187ed76646 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -429,6 +429,7 @@ struct MachineState {
  *          MachineClass *mc = MACHINE_CLASS(oc); \
  *          MACHINE_VER_SYM(options, virt, __VA_ARGS__)(mc); \
  *          mc->desc = "QEMU " MACHINE_VER_STR(__VA_ARGS__) " Virtual Machine"; \
+ *          MACHINE_VER_DEPRECATION(__VA_ARGS__); \
  *          if (latest) { \
  *              mc->alias = "virt"; \
  *          } \
@@ -440,6 +441,7 @@ struct MachineState {
  *      }; \
  *      static void MACHINE_VER_SYM(register, virt, __VA_ARGS__)(void) \
  *      { \
+ *          MACHINE_VER_DELETION(__VA_ARGS__); \
  *          type_register_static(&MACHINE_VER_SYM(info, virt, __VA_ARGS__)); \
  *      } \
  *      type_init(MACHINE_VER_SYM(register, virt, __VA_ARGS__));
@@ -598,6 +600,100 @@ struct MachineState {
                       _MACHINE_VER_SYM2) (sym, prefix, __VA_ARGS__)
 
 
+/*
+ * How many years/major releases for each phase
+ * of the life cycle. Assumes use of versioning
+ * scheme where major is bumped each year
+ */
+#define MACHINE_VER_DELETION_MAJOR 6
+#define MACHINE_VER_DEPRECATION_MAJOR 3
+
+/*
+ * Expands to a static string containing a deprecation
+ * message for a versioned machine type
+ */
+#define MACHINE_VER_DEPRECATION_MSG \
+    "machines more than " stringify(MACHINE_VER_DEPRECATION_MAJOR) \
+    " years old are subject to deletion after " \
+    stringify(MACHINE_VER_DELETION_MAJOR) " years"
+
+#define _MACHINE_VER_IS_EXPIRED_IMPL(cutoff, major, minor) \
+    (((QEMU_VERSION_MAJOR - major) > cutoff) || \
+     (((QEMU_VERSION_MAJOR - major) == cutoff) && \
+      (QEMU_VERSION_MINOR - minor) >= 0))
+
+#define _MACHINE_VER_IS_EXPIRED2(cutoff, major, minor) \
+    _MACHINE_VER_IS_EXPIRED_IMPL(cutoff, major, minor)
+#define _MACHINE_VER_IS_EXPIRED3(cutoff, major, minor, micro) \
+    _MACHINE_VER_IS_EXPIRED_IMPL(cutoff, major, minor)
+#define _MACHINE_VER_IS_EXPIRED4(cutoff, major, minor, _unused, tag) \
+    _MACHINE_VER_IS_EXPIRED_IMPL(cutoff, major, minor)
+#define _MACHINE_VER_IS_EXPIRED5(cutoff, major, minor, micro, _unused, tag)   \
+    _MACHINE_VER_IS_EXPIRED_IMPL(cutoff, major, minor)
+
+#define _MACHINE_IS_EXPIRED(cutoff, ...) \
+    _MACHINE_VER_PICK(__VA_ARGS__, \
+                      _MACHINE_VER_IS_EXPIRED5, \
+                      _MACHINE_VER_IS_EXPIRED4, \
+                      _MACHINE_VER_IS_EXPIRED3, \
+                      _MACHINE_VER_IS_EXPIRED2) (cutoff, __VA_ARGS__)
+
+/*
+ * Evaluates true when a machine type with (major, minor)
+ * or (major, minor, micro) version should be considered
+ * deprecated based on the current versioned machine type
+ * lifecycle rules
+ */
+#define MACHINE_VER_IS_DEPRECATED(...) \
+    _MACHINE_IS_EXPIRED(MACHINE_VER_DEPRECATION_MAJOR, __VA_ARGS__)
+
+/*
+ * Evaluates true when a machine type with (major, minor)
+ * or (major, minor, micro) version should be considered
+ * for deletion based on the current versioned machine type
+ * lifecycle rules
+ */
+#define MACHINE_VER_SHOULD_DELETE(...) \
+    _MACHINE_IS_EXPIRED(MACHINE_VER_DELETION_MAJOR, __VA_ARGS__)
+
+/*
+ * Sets the deprecation reason for a versioned machine based
+ * on its age
+ *
+ * This must be unconditionally used in the _class_init
+ * function for all machine types which support versioning.
+ *
+ * Initially it will effectively be a no-op, but after a
+ * suitable period of time has passed, it will set the
+ * 'deprecation_reason' field on the machine, to warn users
+ * about forthcoming removal.
+ */
+#define MACHINE_VER_DEPRECATION(...) \
+    do { \
+        if (MACHINE_VER_IS_DEPRECATED(__VA_ARGS__)) { \
+            mc->deprecation_reason = MACHINE_VER_DEPRECATION_MSG; \
+        } \
+    } while (0)
+
+/*
+ * Prevents registration of a versioned machined based on
+ * its age
+ *
+ * This must be unconditionally used in the register
+ * method for all machine types which support versioning.
+ *
+ * Inijtially it will effectively be a no-op, but after a
+ * suitable period of time has passed, it will cause
+ * execution of the method to return, avoiding registration
+ * of the machine
+ */
+#define MACHINE_VER_DELETION(...) \
+    do { \
+        if (MACHINE_VER_SHOULD_DELETE(__VA_ARGS__)) { \
+            return; \
+        } \
+    } while (0)
+
 #define DEFINE_MACHINE(namestr, machine_initfn) \
     static void machine_initfn##_class_init(ObjectClass *oc, void *data) \
     { \
-- 
2.43.0



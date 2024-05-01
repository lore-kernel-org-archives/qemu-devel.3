Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBCD2C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 18:29:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Egz-00068T-Fj; Wed, 01 May 2024 14:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s2Egy-000681-4f
 for qemu-devel@nongnu.org; Wed, 01 May 2024 14:28:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s2Egw-0003HF-Ac
 for qemu-devel@nongnu.org; Wed, 01 May 2024 14:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714588109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vMfJHsYvmobgy61on1Rj2n79uU4DdyDjA58g4hgCPZk=;
 b=WNokclXkdD7V4ASF825n3+j3x5vn5zqAazKQq/yhUg8629hDXK/xzBs66YgUzW6SoCGEGR
 hWJ3RKxYP5qDtS0cKX27OfGSS9DlTnz3LbPFFQ7rdPmKIokfwP//Yqb/IBbK69cDS2kYgY
 rC56jM8x53TFct5/M3fQBUz9e8MZaLM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-ShCAsNVtMimk0zYHe1Sygg-1; Wed,
 01 May 2024 14:28:24 -0400
X-MC-Unique: ShCAsNVtMimk0zYHe1Sygg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 39577380390B;
 Wed,  1 May 2024 18:28:23 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.121])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8FABE6958;
 Wed,  1 May 2024 18:28:13 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clegoate@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-arm@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 01/14] include/hw: add helpers for defining versioned machine
 types
Date: Wed,  1 May 2024 19:27:46 +0100
Message-ID: <20240501182759.2934195-2-berrange@redhat.com>
In-Reply-To: <20240501182759.2934195-1-berrange@redhat.com>
References: <20240501182759.2934195-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The various targets which define versioned machine types have
a bunch of obfuscated macro code for defining unique function
and variable names using string concatenation.

This addes a couple of helpers to improve the clarity of such
code macro.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/hw/boards.h | 166 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 166 insertions(+)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 2fa800f11a..47ca450fca 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -414,6 +414,172 @@ struct MachineState {
     struct NumaState *numa_state;
 };
 
+/*
+ * The macros which follow are intended to facilitate the
+ * definition of versioned machine types, using a somewhat
+ * similar pattern across targets:
+ *
+ *  #define DEFINE_VIRT_MACHINE_IMPL(latest, ...) \
+ *      static void MACHINE_VER_SYM(class_init, virt, __VA_ARGS__)( \
+ *          ObjectClass *oc, \
+ *          void *data) \
+ *      { \
+ *          MachineClass *mc = MACHINE_CLASS(oc); \
+ *          MACHINE_VER_SYM(options, virt, __VA_ARGS__)(mc); \
+ *          mc->desc = "QEMU " MACHINE_VER_STR(__VA_ARGS__) " Virtual Machine"; \
+ *          if (latest) { \
+ *              mc->alias = "virt"; \
+ *          } \
+ *      } \
+ *      static const TypeInfo MACHINE_VER_SYM(info, virt, __VA_ARGS__) = { \
+ *          .name = MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
+ *          .parent = TYPE_VIRT_MACHINE, \
+ *          .class_init = MACHINE_VER_SYM(class_init, virt, __VA_ARGS__), \
+ *      }; \
+ *      static void MACHINE_VER_SYM(register, virt, __VA_ARGS__)(void) \
+ *      { \
+ *          type_register_static(&MACHINE_VER_SYM(info, virt, __VA_ARGS__)); \
+ *      } \
+ *      type_init(MACHINE_VER_SYM(register, virt, __VA_ARGS__));
+ *
+ * Following this, one (or more) helpers can be added for
+ * whichever scenarios need to be catered for with a machine:
+ *
+ *  // Normal 2 digit, marked as latest eg 'virt-9.0'
+ *  #define DEFINE_VIRT_MACHINE_LATEST(major, minor) \
+ *      DEFINE_VIRT_MACHINE_IMPL(true, major, minor)
+ *
+ *  // Normal 2 digit eg 'virt-9.0'
+ *  #define DEFINE_VIRT_MACHINE(major, minor) \
+ *      DEFINE_VIRT_MACHINE_IMPL(false, major, minor)
+ *
+ *  // Bugfix 3 digit  eg 'virt-9.0.1'
+ *  #define DEFINE_VIRT_MACHINE_BUGFIX(major, minor, micro) \
+ *      DEFINE_VIRT_MACHINE_IMPL(false, major, minor, micro)
+ *
+ *  // Tagged 2 digit  eg 'virt-9.0-extra'
+ *  #define DEFINE_VIRT_MACHINE_TAGGED(major, minor, tag) \
+ *      DEFINE_VIRT_MACHINE_IMPL(false, major, minor, _, tag)
+ *
+ *  // Tagged bugffix 2 digit  eg 'virt-9.0.1-extra'
+ *  #define DEFINE_VIRT_MACHINE_TAGGED(major, minor, micro, tag) \
+ *      DEFINE_VIRT_MACHINE_IMPL(false, major, minor, micro, _, tag)
+ */
+
+#define _MACHINE_VER_PICK(x1, x2, x3, x4, x5, x6, ...) x6
+
+/*
+ * Construct a human targetted machine version string.
+ *
+ * Can be invoked with various signatures
+ *
+ *  MACHINE_VER_STR(sym, prefix, major, minor)
+ *  MACHINE_VER_STR(sym, prefix, major, minor, micro)
+ *  MACHINE_VER_STR(sym, prefix, major, minor, _, tag)
+ *  MACHINE_VER_STR(sym, prefix, major, minor, micro, _, tag)
+ *
+ * Respectively emitting symbols with the format
+ *
+ *   "{major}.{minor}"
+ *   "{major}.{minor}-{tag}"
+ *   "{major}.{minor}.{micro}"
+ *   "{major}.{minor}.{micro}-{tag}"
+ */
+#define _MACHINE_VER_STR2(major, minor) \
+    #major "." #minor
+
+#define _MACHINE_VER_STR3(major, minor, micro) \
+    #major "." #minor "." #micro
+
+#define _MACHINE_VER_STR4(major, minor, _unused_, tag) \
+    #major "." #minor "-" #tag
+
+#define _MACHINE_VER_STR5(major, minor, micro, _unused_, tag) \
+    #major "." #minor "." #micro "-" #tag
+
+#define MACHINE_VER_STR(...) \
+    _MACHINE_VER_PICK(__VA_ARGS__, \
+                      _MACHINE_VER_STR5, \
+                      _MACHINE_VER_STR4, \
+                      _MACHINE_VER_STR3, \
+                      _MACHINE_VER_STR2) (__VA_ARGS__)
+
+
+/*
+ * Construct a QAPI type name for a versioned machine
+ * type
+ *
+ * Can be invoked with various signatures
+ *
+ *  MACHINE_VER_TYPE_NAME(prefix, major, minor)
+ *  MACHINE_VER_TYPE_NAME(prefix, major, minor, micro)
+ *  MACHINE_VER_TYPE_NAME(prefix, major, minor, _, tag)
+ *  MACHINE_VER_TYPE_NAME(prefix, major, minor, micro, _, tag)
+ *
+ * Respectively emitting symbols with the format
+ *
+ *   "{prefix}-{major}.{minor}"
+ *   "{prefix}-{major}.{minor}.{micro}"
+ *   "{prefix}-{major}.{minor}-{tag}"
+ *   "{prefix}-{major}.{minor}.{micro}-{tag}"
+ */
+#define _MACHINE_VER_TYPE_NAME2(prefix, major, minor)   \
+    prefix "-" #major "." #minor TYPE_MACHINE_SUFFIX
+
+#define _MACHINE_VER_TYPE_NAME3(prefix, major, minor, micro) \
+    prefix "-" #major "." #minor "." #micro TYPE_MACHINE_SUFFIX
+
+#define _MACHINE_VER_TYPE_NAME4(prefix, major, minor, _unused_, tag) \
+    prefix "-" #major "." #minor "-" #tag TYPE_MACHINE_SUFFIX
+
+#define _MACHINE_VER_TYPE_NAME5(prefix, major, minor, micro, _unused_, tag) \
+    prefix "-" #major "." #minor "." #micro "-" #tag TYPE_MACHINE_SUFFIX
+
+#define MACHINE_VER_TYPE_NAME(prefix, ...) \
+    _MACHINE_VER_PICK(__VA_ARGS__, \
+                      _MACHINE_VER_TYPE_NAME5, \
+                      _MACHINE_VER_TYPE_NAME4, \
+                      _MACHINE_VER_TYPE_NAME3, \
+                      _MACHINE_VER_TYPE_NAME2) (prefix, __VA_ARGS__)
+
+/*
+ * Construct a name for a versioned machine type that is
+ * suitable for use as a C symbol (function/variable/etc).
+ *
+ * Can be invoked with various signatures
+ *
+ *  MACHINE_VER_SYM(sym, prefix, major, minor)
+ *  MACHINE_VER_SYM(sym, prefix, major, minor, micro)
+ *  MACHINE_VER_SYM(sym, prefix, major, minor, _, tag)
+ *  MACHINE_VER_SYM(sym, prefix, major, minor, micro, _, tag)
+ *
+ * Respectively emitting symbols with the format
+ *
+ *   {prefix}_machine_{major}_{minor}_{sym}
+ *   {prefix}_machine_{major}_{minor}_{micro}_{sym}
+ *   {prefix}_machine_{major}_{minor}_{tag}_{sym}
+ *   {prefix}_machine_{major}_{minor}_{micro}_{tag}_{sym}
+ */
+#define _MACHINE_VER_SYM2(sym, prefix, major, minor) \
+    prefix ## _machine_ ## major ## _ ## minor ## _ ## sym
+
+#define _MACHINE_VER_SYM3(sym, prefix, major, minor, micro) \
+    prefix ## _machine_ ## major ## _ ## minor ## _ ## micro ## _ ## sym
+
+#define _MACHINE_VER_SYM4(sym, prefix, major, minor, _unused_, tag) \
+    prefix ## _machine_ ## major ## _ ## minor ## _ ## tag ## _ ## sym
+
+#define _MACHINE_VER_SYM5(sym, prefix, major, minor, micro, _unused_, tag) \
+    prefix ## _machine_ ## major ## _ ## minor ## _ ## micro ## _ ## tag ## _ ## sym
+
+#define MACHINE_VER_SYM(sym, prefix, ...) \
+    _MACHINE_VER_PICK(__VA_ARGS__, \
+                      _MACHINE_VER_SYM5, \
+                      _MACHINE_VER_SYM4, \
+                      _MACHINE_VER_SYM3, \
+                      _MACHINE_VER_SYM2) (sym, prefix, __VA_ARGS__)
+
+
 #define DEFINE_MACHINE(namestr, machine_initfn) \
     static void machine_initfn##_class_init(ObjectClass *oc, void *data) \
     { \
-- 
2.43.0



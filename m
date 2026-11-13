Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E1E606A323
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 01:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=G8ciQFcu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRgCB-0001q5-CU; Thu, 12 Nov 2026 20:35:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <enju.kohei@fujitsu.com>)
 id 1xRgC9-0001pZ-Pq; Thu, 12 Nov 2026 20:35:13 -0500
Received: from esa1.hc1455-7.c3s2.iphmx.com ([207.54.90.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <enju.kohei@fujitsu.com>)
 id 1xRgC7-0003Eq-U7; Thu, 12 Nov 2026 20:35:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1794533712; x=1826069712;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:to:cc;
 bh=zQ+i+BTPG4rogOOKQ86sjLDzrXBckQVkjEriQzYWGhM=;
 b=G8ciQFcuOnsW9P+2ZhT8BcN/KYGF0ognUnVnsa84NRF+1K5EbKi3r2Rs
 oXsrTjpLmGS1dGqg5wvsMisu1cTS20PFfq3siDlEVFEzahP7cFBztI4mJ
 Vc2YdLB1fwKPbm7Vd5lXKS/qbJtKNHHFRumNPsAjiYmDhGi/gGVEPIuMk
 5RiHfuc8x961OSd90TZikgPMWTVal73r88HOvKPeA6tpfM0KvLf44guOo
 ct/rKjT75b7TWvR7BW4guy2Eu8qARjPlV0IJTX0Cu5fIOhVMV4GedP54z
 Zn/6//oJGgg0BglbxmTWfHAjVO9inyE8+TXQuXcIEYtEHNBu8qhwAjkuf w==;
X-CSE-ConnectionGUID: RhkR+4FWQDeq9Y5EweC1aA==
X-CSE-MsgGUID: 6tz7e144TbuUXi1cM45uVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="261622019"
X-IronPort-AV: E=Sophos;i="6.27,210,1786978800"; d="scan'208";a="261622019"
Received: from gmgwnl01.global.fujitsu.com (HELO mgmgwnl01.global.fujitsu.com)
 ([52.143.17.124])
 by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 10:34:58 +0900
Received: from az2nlsmgm4.fujitsu.com (unknown [10.150.26.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mgmgwnl01.global.fujitsu.com (Postfix) with ESMTPS id 82E311443;
 Fri, 13 Nov 2026 01:34:58 +0000 (UTC)
Received: from az2nlsmom4.fujitsu.com (unknown [10.150.26.201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by az2nlsmgm4.fujitsu.com (Postfix) with ESMTPS id 37A79100046B;
 Fri, 13 Nov 2026 01:34:58 +0000 (UTC)
Received: from [127.0.1.1] (unknown [10.124.178.20])
 by az2nlsmom4.fujitsu.com (Postfix) with ESMTP id B23CE2000102;
 Fri, 13 Nov 2026 01:34:55 +0000 (UTC)
Date: Fri, 13 Nov 2026 10:34:47 +0900
Subject: [PATCH] vl: complete memory size from memdev before creating
 memmap
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-fix-complete-memdev-size-v1-1-58e8a16bdc61@fujitsu.com>
X-B4-Tracking: v=1; b=H4sIADZp9moC/yXMUQrCQAyE4auUPBvYtKLiVcSHmh014rZl0xax9
 O6u+vjBzL+QIxucjtVCGbO59V2BbCrSe9vdwBaLqQ71TkQavtqLtU/DEyM4IUXM7PYGb6MGPYR
 9Gxuhch8yyvaXPp3/9unygI7fHq3rB5A686x8AAAA
X-Change-ID: 20261113-fix-complete-memdev-size-4dc0c807ad31
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Kohei Enju <enju.kohei@fujitsu.com>
X-Mailer: b4 0.16.0
Received-SPF: pass client-ip=207.54.90.47; envelope-from=enju.kohei@fujitsu.com;
 helo=esa1.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Kohei Enju <enju.kohei@fujitsu.com>
From:  Kohei Enju via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When -machine memory-backend=ram0 is used and '-m' option is omitted
with a KVM virt machine as follows:

  qemu-system-aarch64 \
    -enable-kvm \
    -machine virt,memory-backend=ram0 \
    -object memory-backend-memfd,id=ram0,size=256G,share=on \
    ...

virt_set_memmap() creates memmap based on the default memory size
ignoring the specified size property of the memory-backend-* object.
This is because at this stage memory.size is not initialized by the size
property specified by the memory-backend-* object.

Since the memory size is not taken into account, when the memory size is
larger than about 255 GiB, this unexpectedly hides PCI ECAM space with
system RAM. Consequently guests could fail to find PCI devices, failing
to boot when they are dependent on those PCI devices.

When '-m' option is omitted, fix this by getting the size of the backend
identified by ram_memdev_id, and completing memory.size with this value
before creating the memmap. Afterwards, machine_set_mem() decides
ram_size and maxram_size based on the completed memory.size.

Fixes: d349f92f78d2 ("vl: allow not specifying size in -m when using -M memory-backend")
Signed-off-by: Kohei Enju <enju.kohei@fujitsu.com>
---
 system/vl.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/system/vl.c b/system/vl.c
index e7b759d54428..d2670b85f23b 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -34,6 +34,7 @@
 #include "hw/core/qdev-properties.h"
 #include "qapi/compat-policy.h"
 #include "qapi/error.h"
+#include "qapi/qobject-output-visitor.h"
 #include "qobject/qdict.h"
 #include "qobject/qstring.h"
 #include "qobject/qjson.h"
@@ -1810,6 +1811,47 @@ static void qemu_apply_legacy_machine_options(QDict *qdict)
     }
 }
 
+static void qemu_complete_machine_memdev_size(void)
+{
+    QDict *backend_prop, *memory_prop;
+    g_autofree char *size_str = NULL;
+    QObject *qobj = NULL;
+    ObjectOption *opt;
+    uint64_t size;
+    Visitor *v;
+
+    if (have_custom_ram_size || !ram_memdev_id) {
+        return;
+    }
+
+    QTAILQ_FOREACH(opt, &object_opts, next) {
+        ObjectOptions *options = opt->opts;
+        const char *type = ObjectType_str(options->qom_type);
+
+        if (g_str_equal(options->id, ram_memdev_id) &&
+            g_str_has_prefix(type, "memory-backend-")) {
+            v = qobject_output_visitor_new(&qobj);
+            visit_type_ObjectOptions(v, NULL, &options, &error_abort);
+            visit_complete(v, &qobj);
+            visit_free(v);
+
+            backend_prop = qobject_to(QDict, qobj);
+            size = qdict_get_uint(backend_prop, "size");
+            size_str = g_strdup_printf("%" PRIu64, size);
+
+            memory_prop = qdict_get_qdict(machine_opts_dict, "memory");
+            assert(memory_prop);
+            qdict_put_str(memory_prop, "size", size_str);
+
+            qobject_unref(qobj);
+            return;
+        }
+    }
+
+    error_report("Memory backend '%s' not found", ram_memdev_id);
+    exit(EXIT_FAILURE);
+}
+
 static void object_option_foreach_add(bool (*type_opt_predicate)(const char *))
 {
     ObjectOption *opt, *next;
@@ -3821,6 +3863,7 @@ void qemu_init(int argc, char **argv)
     qemu_create_early_backends();
 
     qemu_apply_legacy_machine_options(machine_opts_dict);
+    qemu_complete_machine_memdev_size();
     qemu_apply_machine_options(machine_opts_dict);
     qobject_unref(machine_opts_dict);
     phase_advance(PHASE_MACHINE_CREATED);

---
base-commit: 29760efaf96bbe5928f8111881eddbf5ac06439e
change-id: 20261113-fix-complete-memdev-size-4dc0c807ad31

Best regards,
--  
Kohei Enju <enju.kohei@fujitsu.com>



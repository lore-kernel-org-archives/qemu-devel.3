Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47519CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 11:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEQDc-0000MK-5Y; Wed, 07 Oct 2026 07:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEQDP-00007P-9S
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 07:53:45 -0400
Received: from mail-dl1-x122c.google.com ([2607:f8b0:4864:20::122c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEQDN-0007zP-Lm
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 07:53:43 -0400
Received: by mail-dl1-x122c.google.com with SMTP id
 a92af1059eb24-1419d3416ceso7175068c88.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 04:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791374020; x=1791978820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ntdKLHvhT8yapbMzYuxmD6mJa3euPqQFY8iz5oezuoU=;
 b=lLuSUmw25XfXeqWK9pggWUUalOko37IZESU25zQjtkD/JhWIuoMF7vywcwLgMG+NS2
 +SjjZFwpKUs6teoxLveikIw55a9U7ACTaULPRc4G2UD7oIUmnv0W7HXXQ+7/rl8zXYBm
 joA8CzV5teWnEMvVO9Br+Qv4sFs+YTmFwwrUxrYCtOlgWItect8SeyHjU/1H9xNrUnAu
 1yorlJpmIgn9aO90n5n0JIBOSZSIw87f7eJwVaZvrl8Ykw+5Sy5bGsKNDo8eM8zRYEh8
 2VN5yRRBv2j5v6mPHMt+VKUszZYETeYJN5qVZpmDj6RgXmZbDY/uBjyytZK/RgMObpTR
 elQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791374020; x=1791978820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ntdKLHvhT8yapbMzYuxmD6mJa3euPqQFY8iz5oezuoU=;
 b=09u/TRrcHHqJlvQuYcZBWvnWKFuZC/qTcd7h62ULSSR1gQPM3yQFfHn2hZ2lVJwhUE
 ve3Uoo/BLu6jbL5/zlNlE8D/o11zwEHk2jzT89lEhbrrSn7ioR6ifcDpZ6CW/tNQsnfT
 sqldgCDNAqGzPwRZm2PJDYaKWSVW1lVShHehtskLdm47SQQ8l34JLq5Mk4GTBoPkCiZw
 YPG3LCoyJaMz03b3rveIA6GeRhFCRKlbILltgN3N5NjeUKHj+Py7iNNjxctqk9BQxe7u
 +/GEo14tj2qfn9O5M/DBzxq2a6X7DOnZJ+fHYpCJsH+NY0mD1G85keCnWXjzRYF344me
 Z3bQ==
X-Gm-Message-State: AFuF++m0OZpUCU5qDCOpHetncZul9yJDlrdn8tXOQxryMvxgSMY6fT1g
 Byk6n12v971I7D5Vd/+rN/5NGxvYwBqKeww0KsFJGUHR1IpnAApfDZqTEPgY7Fzx
X-Gm-Gg: AYBFou0U1TEbcwGAtq9W73weYuCMsNOpCj5voHlrgtchWxVQitYNDIOw0iDwET7zOzC
 wnOoe1ONV1Os7eq2vn45Q2m4OVaEzZzcvgQs+iyh2/Xp0HEb7GL2GMlesGSC6Wch39/YItQe5Na
 qNImQKlqsdxjJXP+WZZejsnn/TNQsSyFKsfoIXU8e42z22JIX/A6EAWjo0SHfltBEDWEd53F7LU
 RlQD3JOxgxIVqWwmR340OGICkCnoRiabIFjgqUMjxIl5+M1VzY3PYFFuIuiHDB43CjtNItdza15
 wY9gIzlSS/lQcRt0U8XX/w2Dq05nZR6jhGay9jBcbep5GAfUVNraMg+Od7vmRloZTWBD1ZzPgvF
 bBXAGsBU4bW9+S0AKKzgVhf5XODUibXGJ9pwMhnSzVGWzjlFq2+y7+xUr5xL3ZcTTK8feik8e77
 lTxwl1z+0M9ynaYAez3vvYKJV3EjT9l6GyWpSv5LgIhofOz5EBTx5SfrrubsFe9VpWYpRnpRnB9
 kluPMvHsXYchHsPEJmy+QBVn8lg
X-Received: by 2002:a05:701b:2806:b0:144:eaa7:2765 with SMTP id
 a92af1059eb24-162045b85ffmr2247588c88.18.1791374019530; 
 Wed, 07 Oct 2026 04:53:39 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1616980c3b7sm6429520c88.16.2026.10.07.04.53.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 04:53:38 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Stafford Horne <shorne@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Alexander Bulekov <alxndr@bu.edu>,
 Darren Kenny <darren.kenny@oracle.com>
Subject: [PATCH 5/8] tests/unit: add target-info coverage for multi-target
 builds
Date: Wed,  7 Oct 2026 19:48:02 +0800
Message-ID: <20261007115253.328-6-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261007115253.328-1-luoyonggang@gmail.com>
References: <20261007115253.328-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122c;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x122c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Link target-info-def.c objects from supported multi-target libraries into
test-target-info. Verify target_info() is non-NULL and that
target_info_list() contains one entry for each linked target.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 MAINTAINERS                   |  1 +
 meson.build                   |  5 ++++-
 tests/unit/meson.build        |  4 ++++
 tests/unit/test-target-info.c | 38 +++++++++++++++++++++++++++++++++++
 4 files changed, 47 insertions(+), 1 deletion(-)
 create mode 100644 tests/unit/test-target-info.c

diff --git a/MAINTAINERS b/MAINTAINERS
index cfe39dc2883..418c4e472a9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2149,6 +2149,7 @@ S: Supported
 F: include/qemu/target-info*.h
 F: target-info*.c
 F: tests/unit/test-multi-targets.c
+F: tests/unit/test-target-info.c
 
 Xtensa Machines
 ---------------
diff --git a/meson.build b/meson.build
index 4097784e7a2..fd7a4f68389 100644
--- a/meson.build
+++ b/meson.build
@@ -4259,6 +4259,7 @@ endif
 traceable = []
 multi_target_libs = []
 multi_target_deps = []
+multi_target_target_info_objects = []
 multi_target_crates = []
 multi_target_supported_targets = [
   'aarch64-softmmu',
@@ -4274,6 +4275,7 @@ multi_target_supported_targets = [
 ]
 
 emulators = {}
+target_info_def = files('target-info-def.c')
 foreach target : target_dirs
   config_target = config_target_mak[target]
   target_name = config_target['TARGET_NAME']
@@ -4345,7 +4347,7 @@ foreach target : target_dirs
     endif
   endif
 
-  arch_srcs += files('target-info-def.c')
+  arch_srcs += target_info_def
 
   if target_base_arch in target_arch
     t = target_arch[target_base_arch].apply(config_target, strict: false)
@@ -4428,6 +4430,7 @@ foreach target : target_dirs
       multi_target_libs += lib
       multi_target_deps += arch_deps
       multi_target_deps += target_stubs
+      multi_target_target_info_objects += lib.extract_objects(target_info_def)
       multi_target_crates += main_rs
     endif
     execs = [{
diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index d17435c1877..b2e8be24b05 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -43,6 +43,10 @@ tests = {
   'test-qgraph': ['../qtest/libqos/qgraph.c'],
   'check-qom-interface': [qom],
   'check-qom-proplist': [qom],
+  'test-target-info': [qom, declare_dependency(
+    objects: multi_target_target_info_objects,
+    compile_args: ['-DTARGET_INFO_DEF_COUNT=@0@'.format(
+      multi_target_target_info_objects.length())])],
   'test-qemu-opts': [],
   'test-keyval': [testqapi],
   'test-logging': [],
diff --git a/tests/unit/test-target-info.c b/tests/unit/test-target-info.c
new file mode 100644
index 00000000000..e6de9b259e8
--- /dev/null
+++ b/tests/unit/test-target-info.c
@@ -0,0 +1,38 @@
+/*
+ * TargetInfo unit tests
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/target-info.h"
+#include "qemu/target-info-def.h"
+
+static int target_info_list_count(void)
+{
+    TargetInfoNode *node;
+    int n = 0;
+
+    QLIST_FOREACH(node, target_info_list(), next) {
+        n++;
+    }
+    return n;
+}
+
+static void test_target_info_not_null(void)
+{
+    g_assert_nonnull(target_info());
+}
+
+static void test_target_info_list_count(void)
+{
+    g_assert_cmpint(target_info_list_count(), ==, TARGET_INFO_DEF_COUNT);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    g_test_add_func("/target-info/not-null", test_target_info_not_null);
+    g_test_add_func("/target-info/list-count", test_target_info_list_count);
+    return g_test_run();
+}
-- 
2.55.0.windows.3



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A44A7C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 14:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRC9P-0004qR-Ar; Tue, 09 Jul 2024 10:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simon.hamelin@grenoble-inp.org>)
 id 1sRB5s-0000eq-42
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 09:41:20 -0400
Received: from smtpout02-ext4.partage.renater.fr ([194.254.241.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simon.hamelin@grenoble-inp.org>)
 id 1sRB5p-0001iH-MF
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 09:41:19 -0400
Received: from zmtaauth04.partage.renater.fr (zmtaauth04.partage.renater.fr
 [194.254.241.26])
 by smtpout20.partage.renater.fr (Postfix) with ESMTP id 8703ABFF98;
 Tue,  9 Jul 2024 15:41:03 +0200 (CEST)
Received: from zmtaauth04.partage.renater.fr (localhost [127.0.0.1])
 by zmtaauth04.partage.renater.fr (Postfix) with ESMTPS id 94F111C0080;
 Tue,  9 Jul 2024 15:41:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zmtaauth04.partage.renater.fr (Postfix) with ESMTP id 762D91C036F;
 Tue,  9 Jul 2024 15:41:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zmtaauth04.partage.renater.fr 762D91C036F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grenoble-inp.org;
 s=F42A61D9-9621-4693-8E8E-830FB5F1ED6E; t=1720532462;
 bh=zzqJqmIbyGxqw0N+PLsLoueGmR3j5CIeIIgAEVbnSxQ=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=cCqi9f1nEi4C+hIzYNYco9ysmh4CS1/UdjJq30VmPZamgM9x3PWimRbt6m2O0MUSW
 aKluSreKj9Z8GfEWJZIaF7EKJk723vXXniAHzb/PiSnttrYZ9rFHBrmek/amLMYVew
 gZoiMsohveTYxh8xouoibp+MThBmPyOilVTsbLnwNqmvQduNw3uU4OG3DJc72288bj
 DA5+JujcOgFrDTW3DqvAivJqh02Bq6uOqSblpqg7zQN3NuAHcN7Vsx3x0/+VNim1dB
 Acu1T19frk+v0g42TeHQAlO7LaU6x47DgmBg1WiUJTTtLy3dKWOGPgFOdRhVL85JZx
 OoeHDNMNXo8kg==
Received: from zmtaauth04.partage.renater.fr ([127.0.0.1])
 by localhost (zmtaauth04.partage.renater.fr [127.0.0.1]) (amavis, port 10026)
 with ESMTP id BXXfqDPXdX1w; Tue,  9 Jul 2024 15:41:02 +0200 (CEST)
Received: from 188.231.11.184 (unknown [194.254.241.251])
 by zmtaauth04.partage.renater.fr (Postfix) with ESMTPA id 1682F1C050B;
 Tue,  9 Jul 2024 15:41:02 +0200 (CEST)
From: Simon Hamelin <simon.hamelin@grenoble-inp.org>
To: qemu-devel@nongnu.org
Cc: Simon Hamelin <simon.hamelin@grenoble-inp.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] plugins/stoptrigger: TCG plugin to stop execution under
 conditions
Date: Tue,  9 Jul 2024 15:40:06 +0200
Message-ID: <20240709134031.85954-1-simon.hamelin@grenoble-inp.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.103.8 at clamav03
X-Virus-Status: Clean
X-Renater-Ptge-SpamState: clean
X-Renater-Ptge-SpamScore: -100
X-Renater-Ptge-SpamCause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdelgdeijecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucftgffptefvgfftnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuihhmohhnucfjrghmvghlihhnuceoshhimhhonhdrhhgrmhgvlhhinhesghhrvghnohgslhgvqdhinhhprdhorhhgqeenucggtffrrghtthgvrhhnpedttdduiefgtdelfeehuedtvdeuudekhffhffekudekhfdtudelffdvgeetleetfeenucfkphepudelgedrvdehgedrvdeguddrvdehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleegrddvheegrddvgedurddvhedupdhhvghlohepudekkedrvdefuddruddurddukeegpdhmrghilhhfrhhomhepshhimhhonhdrhhgrmhgvlhhinhesghhrvghnohgslhgvqdhinhhprdhorhhgpdhnsggprhgtphhtthhopeekpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehsihhmohhnrdhhrghmvghlihhnsehgrhgvnhhosghlvgdqihhnphdrohhrghdprhgtphhtthhopegvrhgunhgrgigvsegtrhgrnhhsrdhorhhgpdhrtghpthhtoheprghlvgigrdgsvghnnhgvvgeslhhinhgrrhhordhorhhgpdhrtghpthhtohepmhgrrdhmrghnughouhhrrhesghhm
 rghilhdrtghomhdprhgtphhtthhopehpihgvrhhrihgtkhdrsghouhhvihgvrheslhhinhgrrhhordhorhhg
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=194.254.241.31;
 envelope-from=simon.hamelin@grenoble-inp.org;
 helo=smtpout02-ext4.partage.renater.fr
X-Spam_score_int: 3
X-Spam_score: 0.3
X-Spam_bar: /
X-Spam_report: (0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_HELO_IP_MISMATCH=2.368,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_BL=0.001, RCVD_IN_MSPIKE_ZBI=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 09 Jul 2024 10:48:59 -0400
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

This new plugin allows to stop emulation using conditions on the
emulation state. By setting this plugin arguments, it is possible
to set an instruction count limit and/or trigger address(es) to stop at.
The code returned at emulation exit can be customized.

This plugin demonstrates how someone could stop QEMU execution.
It could be used for research purposes to launch some code and
deterministically stop it and understand where its execution flow went.

Co-authored-by: Alexandre Iooss <erdnaxe@crans.org>
Signed-off-by: Simon Hamelin <simon.hamelin@grenoble-inp.org>
Signed-off-by: Alexandre Iooss <erdnaxe@crans.org>
---
 contrib/plugins/Makefile      |   1 +
 contrib/plugins/stoptrigger.c | 125 ++++++++++++++++++++++++++++++++++
 docs/devel/tcg-plugins.rst    |  22 ++++++
 3 files changed, 148 insertions(+)
 create mode 100644 contrib/plugins/stoptrigger.c

diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
index 449ead1130..98a89d5c40 100644
--- a/contrib/plugins/Makefile
+++ b/contrib/plugins/Makefile
@@ -28,6 +28,7 @@ NAMES +=3D hwprofile
 NAMES +=3D cache
 NAMES +=3D drcov
 NAMES +=3D ips
+NAMES +=3D stoptrigger
=20
 ifeq ($(CONFIG_WIN32),y)
 SO_SUFFIX :=3D .dll
diff --git a/contrib/plugins/stoptrigger.c b/contrib/plugins/stoptrigger.=
c
new file mode 100644
index 0000000000..26b8a78f08
--- /dev/null
+++ b/contrib/plugins/stoptrigger.c
@@ -0,0 +1,125 @@
+/*
+ * Copyright (C) 2024, Simon Hamelin <simon.hamelin@grenoble-inp.org>
+ *
+ * Stop execution once a given address is reached or if the
+ * count of executed instructions reached a specified limit
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ */
+
+#include <assert.h>
+#include <inttypes.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#include <qemu-plugin.h>
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version =3D QEMU_PLUGIN_VERSION;
+
+static uint64_t icount;
+static int icount_exit_code;
+static uint64_t executed_instructions;
+
+static bool exit_on_icount;
+static bool exit_on_address;
+
+/* Map trigger addresses to exit code */
+static GHashTable *addrs_ht;
+static GMutex addrs_ht_lock;
+
+static void vcpu_insn_exec(unsigned int cpu_index, void *udata)
+{
+    executed_instructions++;
+
+    if (exit_on_icount && executed_instructions > icount) {
+        /* We shouldn't execute more instructions than specified */
+        g_assert(executed_instructions =3D=3D icount + 1);
+        qemu_plugin_outs("icount reached, exiting\n");
+        exit(icount_exit_code);
+    }
+
+    if (exit_on_address) {
+        uint64_t insn_vaddr =3D GPOINTER_TO_UINT(udata);
+        g_mutex_lock(&addrs_ht_lock);
+        if (g_hash_table_contains(addrs_ht, GUINT_TO_POINTER(insn_vaddr)=
)) {
+            /* Exit triggered by address */
+            int exit_code =3D GPOINTER_TO_INT(g_hash_table_lookup(addrs_=
ht,
+                                            GUINT_TO_POINTER(insn_vaddr)=
));
+            char *msg =3D g_strdup_printf("0x%" PRIx64 " reached, exitin=
g\n",
+                                        insn_vaddr);
+            qemu_plugin_outs(msg);
+            exit(exit_code);
+        }
+        g_mutex_unlock(&addrs_ht_lock);
+    }
+}
+
+static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb=
)
+{
+    /* Register vcpu_insn_exec callback on each instruction */
+    size_t tb_n =3D qemu_plugin_tb_n_insns(tb);
+    for (size_t i =3D 0; i < tb_n; i++) {
+        struct qemu_plugin_insn *insn =3D qemu_plugin_tb_get_insn(tb, i)=
;
+        uint64_t insn_vaddr =3D qemu_plugin_insn_vaddr(insn);
+        qemu_plugin_register_vcpu_insn_exec_cb(insn, vcpu_insn_exec,
+                                               QEMU_PLUGIN_CB_NO_REGS,
+                                               GUINT_TO_POINTER(insn_vad=
dr));
+    }
+}
+
+static void plugin_exit(qemu_plugin_id_t id, void *p)
+{
+    g_hash_table_destroy(addrs_ht);
+}
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info, int =
argc,
+                                           char **argv)
+{
+    addrs_ht =3D g_hash_table_new(NULL, g_direct_equal);
+
+    for (int i =3D 0; i < argc; i++) {
+        char *opt =3D argv[i];
+        g_auto(GStrv) tokens =3D g_strsplit(opt, "=3D", 2);
+        if (g_strcmp0(tokens[0], "icount") =3D=3D 0) {
+            g_auto(GStrv) icount_tokens =3D g_strsplit(tokens[1], ":", 2=
);
+            icount =3D g_ascii_strtoull(icount_tokens[0], NULL, 0);
+            if (icount < 1 || g_strrstr(icount_tokens[0], "-") !=3D NULL=
) {
+                fprintf(stderr, "icount parsing failed: '%s' must be a "
+                        "positive integer\n", icount_tokens[0]);
+                return -1;
+            }
+            if (icount_tokens[1]) {
+                icount_exit_code =3D g_ascii_strtoull(icount_tokens[1], =
NULL, 0);
+            }
+            exit_on_icount =3D true;
+        } else if (g_strcmp0(tokens[0], "addr") =3D=3D 0) {
+            g_auto(GStrv) addr_tokens =3D g_strsplit(tokens[1], ":", 2);
+            uint64_t exit_addr =3D g_ascii_strtoull(addr_tokens[0], NULL=
, 0);
+            int exit_code =3D 0;
+            if (addr_tokens[1]) {
+                exit_code =3D g_ascii_strtoull(addr_tokens[1], NULL, 0);
+            }
+            g_mutex_lock(&addrs_ht_lock);
+            g_hash_table_insert(addrs_ht, GUINT_TO_POINTER(exit_addr),
+                                GINT_TO_POINTER(exit_code));
+            g_mutex_unlock(&addrs_ht_lock);
+            exit_on_address =3D true;
+        } else {
+            fprintf(stderr, "option parsing failed: %s\n", opt);
+            return -1;
+        }
+    }
+
+    if (!exit_on_icount && !exit_on_address) {
+        fprintf(stderr, "'icount' or 'addr' argument missing\n");
+        return -1;
+    }
+
+    /* Register translation block and exit callbacks */
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
+
+    return 0;
+}
diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
index f7d7b9e3a4..954623f9bf 100644
--- a/docs/devel/tcg-plugins.rst
+++ b/docs/devel/tcg-plugins.rst
@@ -642,6 +642,28 @@ The plugin has a number of arguments, all of them ar=
e optional:
   configuration arguments implies ``l2=3Don``.
   (default: N =3D 2097152 (2MB), B =3D 64, A =3D 16)
=20
+- contrib/plugins/stoptrigger.c
+
+The stoptrigger plugin allows to setup triggers to stop emulation.
+It can be used for research purposes to launch some code and precisely s=
top it
+and understand where its execution flow went.
+
+Two types of triggers can be configured: a count of instructions to stop=
 at,
+or an address to stop at. Multiple triggers can be set at once.
+
+By default, QEMU will exit with return code 0. A custom return code can =
be
+configured for each trigger using ``:CODE`` syntax.
+
+For example, to stop at the 20-th instruction with return code 41, at ad=
dress
+0xd4 with return code 0 or at address 0xd8 with return code 42::
+
+  $ qemu-system-aarch64 $(QEMU_ARGS) \
+    -plugin ./contrib/plugins/libstoptrigger.so,icount=3D20:41,addr=3D0x=
d4,addr=3D0xd8:42 -d plugin
+
+The plugin will log the reason of exit, for example::
+
+  0xd4 reached, exiting
+
 Plugin API
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
--=20
2.43.0



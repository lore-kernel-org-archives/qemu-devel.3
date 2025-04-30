Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEDB1C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 13:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA771-0007dj-1W; Wed, 30 Apr 2025 09:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steffen_hirschmann@web.de>)
 id 1uA5AP-0005Y8-F4
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 06:59:54 -0400
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steffen_hirschmann@web.de>)
 id 1uA5AM-00065M-JY
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 06:59:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1746010779; x=1746615579;
 i=steffen_hirschmann@web.de;
 bh=4Yu7cGVZbLNXPcDVHmVCZ3CNZ2KzVoUEAcYaomjK7Hc=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=K0yzEJffqA2RDHX9aB8cjRBXtnUUn1oAwbmMjm9BgOfTt7XqeZDgcbQGVj8eF+1J
 extIGH0wSLNQ8ascDYml/ZZUdsAkOsVnd4EBRQPJOdzTgtk71hM7sIQ91bfE0LtWA
 s/FQEbrIj7tViMfxZ9I/EIgXRXCLFSxO+C2+KsNVjnrXvJkWxPyNOc9+S4ZouGSfl
 x76kt0S4bnfpodh2qbhsHhFfqLtuZwUwhacOV3cQG/WgnSGy9JJvnGzn82CG/hbyi
 +vvfmewrLF1ZGIzPgZNPDdlGfZmCBplGZNrAInywE8mpIY3btyOuskicez8y2gfSx
 lhmmA29ptQrkulVfgQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([87.123.246.30]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MovnY-1uqd3F0SHm-00itBY; Wed, 30
 Apr 2025 12:59:39 +0200
From: steffen_hirschmann@web.de
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Steffen Hirschmann <steffen_hirschmann@web.de>
Subject: [PATCH RFC 1/1] TCG insn.c: Implement counting specific addresses
Date: Wed, 30 Apr 2025 12:59:37 +0200
Message-Id: <20250430105937.191814-2-steffen_hirschmann@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250430105937.191814-1-steffen_hirschmann@web.de>
References: <20250430105937.191814-1-steffen_hirschmann@web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NkvjRRrxziJXGRJmuGwWOL997dJefegDr2DOwKPKD3uyylWtiLr
 OkgKOkkhwVkrHZW6lS6u8e/UvVvJIz2xuJK56LDmt4hvNcWPlR3PkSHPbMIEBLVjc/Q3F3l
 Fxc5IQrfQPTsu+VItrhqt/pBufHeVFc+n3mr3MF0nOxsc1M9kO4eWYQSBIhVRHLPKucaFsv
 sY7qSif911v7UH53DVOjQ==
UI-OutboundReport: notjunk:1;M01:P0:gOuXCL26os8=;PdQC35FYlFMu0gg+f3RnvF3Nyi1
 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
Received-SPF: pass client-ip=212.227.17.12;
 envelope-from=steffen_hirschmann@web.de; helo=mout.web.de
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 30 Apr 2025 09:04:27 -0400
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

From: Steffen Hirschmann <steffen_hirschmann@web.de>

This commit implements counting of executed instruction within certain
virtual address ranges via libinsn.so

Signed-off-by: Steffen Hirschmann <steffen_hirschmann@web.de>
=2D--
 docs/about/emulation.rst |  2 +
 tests/tcg/plugins/insn.c | 89 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index a72591ee4d..1fd122bc50 100644
=2D-- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -336,6 +336,8 @@ Behaviour can be tweaked with the following arguments:
     - Give a summary of the instruction sizes for the execution
   * - match=3D<string>
     - Only instrument instructions matching the string prefix
+  * - vaddr=3D<start>+<count>
+    - Counts executed instructions in this virtual address range. <start>=
 and <count> must be in base 16
=20
 The ``match`` option will show some basic stats including how many
 instructions have executed since the last execution. For
diff --git a/tests/tcg/plugins/insn.c b/tests/tcg/plugins/insn.c
index 0c723cb9ed..c6d5b07d05 100644
=2D-- a/tests/tcg/plugins/insn.c
+++ b/tests/tcg/plugins/insn.c
@@ -48,6 +48,14 @@ static GHashTable *match_insn_records;
 static GMutex match_hash_lock;
=20
=20
+typedef struct {
+    uint64_t start;
+    uint64_t end;
+    qemu_plugin_u64 hits; /* Number of insn executed in this range */
+} VaddrRange;
+
+static GArray *vaddr_ranges;
+
 static Instruction * get_insn_record(const char *disas, uint64_t vaddr, M=
atch *m)
 {
     g_autofree char *str_hash =3D g_strdup_printf("%"PRIx64" %s", vaddr, =
disas);
@@ -187,6 +195,15 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct=
 qemu_plugin_tb *tb)
             }
             g_free(insn_disas);
         }
+
+        for (int j =3D 0; j < vaddr_ranges->len; j++) {
+            VaddrRange *var =3D &g_array_index(vaddr_ranges, VaddrRange, =
j);
+            uint64_t vaddr =3D qemu_plugin_insn_vaddr(insn);
+            if (var->start <=3D vaddr && vaddr < var->end) {
+                qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
+                    insn, QEMU_PLUGIN_INLINE_ADD_U64, var->hits, 1);
+            }
+        }
     }
 }
=20
@@ -246,6 +263,19 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
=20
     g_array_free(matches, TRUE);
     g_array_free(sizes, TRUE);
+
+    for (i =3D 0; i < vaddr_ranges->len; ++i) {
+        VaddrRange *var =3D &g_array_index(vaddr_ranges, VaddrRange, i);
+        uint64_t hits =3D qemu_plugin_u64_sum(var->hits);
+
+        g_string_printf(out, "Vaddr range [0x%08lx, 0x%08lx): %"PRId64" h=
its\n",
+                        var->start, var->end, hits);
+        qemu_plugin_outs(out->str);
+        qemu_plugin_scoreboard_free(var->hits.score);
+    }
+
+
+    g_array_free(vaddr_ranges, TRUE);
 }
=20
=20
@@ -258,6 +288,48 @@ static void parse_match(char *match)
     g_array_append_val(matches, new_match);
 }
=20
+static void parse_vaddr(const char *arg)
+{
+    char *vaddr =3D g_strdup(arg);
+    char *saveptr, *token1, *token2;
+    uint64_t start, len, end;
+    token1 =3D strtok_r(vaddr, "+", &saveptr);
+    token2 =3D strtok_r(NULL, "+", &saveptr);
+    if (!token1 || !token2) {
+        fprintf(stderr, "vaddr usage: vaddr=3Dstart+count (both base 16!)=
\n");
+        exit(1);
+    }
+
+    start =3D g_ascii_strtoull(token1, NULL, 16);
+    len =3D g_ascii_strtoull(token2, NULL, 16);
+    end =3D start + len;
+
+    g_free(vaddr);
+
+    if (start =3D=3D 0 || end =3D=3D 0) {
+        fprintf(stderr, "vaddr usage: vaddr=3Dstart+count (both base 16!)=
\n");
+        exit(1);
+    }
+
+    if (UINT64_MAX - start < len) {
+        fprintf(stderr, "integer overflow in vaddr end address calculatio=
n."
+                        " Specified vaddr=3Dstart+count incorrect.\n");
+        exit(1);
+    }
+
+    g_autoptr(GString) out =3D g_string_new(NULL);
+    g_string_printf(out, "Registering new Vaddr range"
+                        " start=3D0x%08lx len=3D0x%08lx end=3D0x%08lx\n",=
 start, len, end);
+    qemu_plugin_outs(out->str);
+
+    VaddrRange new_vaddrrange =3D {
+        .start =3D start,
+        .end =3D end,
+        .hits =3D qemu_plugin_scoreboard_u64(
+            qemu_plugin_scoreboard_new(sizeof(uint64_t))) };
+    g_array_append_val(vaddr_ranges, new_vaddrrange);
+}
+
 QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                                            const qemu_info_t *info,
                                            int argc, char **argv)
@@ -265,6 +337,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin=
_id_t id,
     matches =3D g_array_new(false, true, sizeof(Match));
     /* null terminated so 0 is not a special case */
     sizes =3D g_array_new(true, true, sizeof(unsigned long));
+    vaddr_ranges =3D g_array_new(false, true, sizeof(VaddrRange));
=20
     for (int i =3D 0; i < argc; i++) {
         char *opt =3D argv[i];
@@ -281,6 +354,8 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin=
_id_t id,
             }
         } else if (g_strcmp0(tokens[0], "match") =3D=3D 0) {
             parse_match(tokens[1]);
+        } else if (g_strcmp0(tokens[0], "vaddr") =3D=3D 0) {
+            parse_vaddr(tokens[1]);
         } else if (g_strcmp0(tokens[0], "trace") =3D=3D 0) {
             if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &do_trace))=
 {
                 fprintf(stderr, "boolean argument parsing failed: %s\n", =
opt);
@@ -292,6 +367,20 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugi=
n_id_t id,
         }
     }
=20
+    /* Check for invalid parameter combinations */
+    if (vaddr_ranges->len > 0) {
+        if (matches->len > 0) {
+            fprintf(stderr, "match=3D... and vaddr=3D... are incompatible=
."
+                            " Use only one of them.\n");
+            return -1;
+        }
+
+        if (!do_inline) {
+            fprintf(stderr, "vaddr=3D... is only supported in conjunction=
 with inline.\n");
+            return -1;
+        }
+    }
+
     insn_count =3D qemu_plugin_scoreboard_u64(
         qemu_plugin_scoreboard_new(sizeof(uint64_t)));
=20
=2D-=20
2.39.5



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4CEC5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 14:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJYw0-0002w2-6o; Mon, 26 May 2025 10:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steffen_hirschmann@web.de>)
 id 1uJYvx-0002vX-9E
 for qemu-devel@nongnu.org; Mon, 26 May 2025 10:36:09 -0400
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steffen_hirschmann@web.de>)
 id 1uJYvu-0000fS-R6
 for qemu-devel@nongnu.org; Mon, 26 May 2025 10:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1748270153; x=1748874953;
 i=steffen_hirschmann@web.de;
 bh=J6qylt3a8aq06XbALlDEr1oyyh5CC935iAtT8V59h8I=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=tmmUZKzwaR0kFEi8+eHBFmFpKK3R1aEX5MhULTvRmxN8r/1jRxFiX8ote1yb7JeV
 5O7o/iXfMuSRfegMWGmxOD1VYTyvvherJeSA4aBlwq55omnoWkD0g0ViC90J6ZhY4
 sptvi5rx2g5fPJMJLfXeZzvz2g1MSluPU1X+R43wj5KcOB0d00SR4Su7x4uqPTJ6N
 yYDQuMP6xUI1FFKyH0y1e7msUwmqaD7TERMcxVLbRgJOztrCL3dwSZWaFnWR2jqbP
 vR966XfP+DVFYEeXxqiI2zJJCr2uLOBR1o3i4dxEXxEiZBiCJjSO/LLMCGqGg98Xr
 5MIajqdRdA9L3zxL2g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([89.246.96.127]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MDMvE-1uAB0o3YNa-00AFSH; Mon, 26
 May 2025 16:35:52 +0200
From: steffen_hirschmann@web.de
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Cc: Steffen Hirschmann <steffen_hirschmann@web.de>
Subject: [PATCH RFC v2 1/1] TCG insn.c: Implement counting specific addresses
Date: Mon, 26 May 2025 16:35:50 +0200
Message-ID: <20250526143550.29856-1-steffen_hirschmann@web.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250430105937.191814-2-steffen_hirschmann@web.de>
References: <20250430105937.191814-2-steffen_hirschmann@web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+5Xp3nIP4b5QII0sCA8+XCTjhc91Kos8LhGt4+sGmk54/tyPEHD
 yCPAH66GPztt0sOREan16v7eqFDIbjVz6Y6HkHzLgjCiTpN43ywELBz9Q4ZTFdnNzcni4X7
 aIPoJfwtDvQIso/9GXE7dYWksj85EhAyAZAJEILaBqCPOwgvdqtzW4KHDjmBulIt68+nacI
 N43QLcEvwx8p/B8ljYzxw==
UI-OutboundReport: notjunk:1;M01:P0:XU/ND4dTgyo=;hQLPuhNkNQ6YVvii95EIzcQBrBY
 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
 +x6x4TlAVEZ86dhnT3mG8Z0Cn8v2pzRCVE
Received-SPF: pass client-ip=212.227.17.11;
 envelope-from=steffen_hirschmann@web.de; helo=mout.web.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Steffen Hirschmann <steffen_hirschmann@web.de>

This commit implements counting of executed instruction within certain
virtual address ranges via libinsn.so

Signed-off-by: Steffen Hirschmann <steffen_hirschmann@web.de>
=2D--
 docs/about/emulation.rst |  2 +
 tests/tcg/plugins/insn.c | 91 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)

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
index 0c723cb9ed..41c2a2ae32 100644
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
+/* Returns true on success. If parsing is unsuccessful or vaddr bounds ar=
e incorrect, returns false. */
+static bool parse_vaddr(const char *arg)
+{
+    g_autofree char *vaddr =3D g_strdup(arg);
+    char *endptr;
+    uint64_t start =3D 0, len =3D 0;
+    g_auto(GStrv) tokens =3D g_strsplit(vaddr, "+", 2);
+
+    if (tokens && tokens[0] && tokens[1]) {
+        start =3D g_ascii_strtoull(tokens[0], &endptr, 16);
+        if (start =3D=3D G_MAXUINT64 /* uint64_t overflow */
+            || endptr =3D=3D tokens[0] /* conversion failed */
+            || endptr !=3D tokens[0] + strlen(tokens[0]) /* garbage data =
at the end */) {
+            fprintf(stderr, "vaddr usage: vaddr=3Dstart+count (both base =
16!). 'start' address invalid or overflow\n");
+            return false;
+        }
+        len =3D g_ascii_strtoull(tokens[1], &endptr, 16);
+        if (len =3D=3D G_MAXUINT64 || endptr =3D=3D tokens[1] || endptr !=
=3D tokens[1] + strlen(tokens[1])) {
+            fprintf(stderr, "vaddr usage: vaddr=3Dstart+count (both base =
16!). 'count' invalid or overflow\n");
+            return false;
+        }
+    } else {
+        fprintf(stderr, "vaddr usage: vaddr=3Dstart+count (both base 16!)=
\n");
+        return false;
+    }
+
+    if (UINT64_MAX - start < len) {
+        fprintf(stderr, "integer overflow in vaddr end address calculatio=
n."
+                        " Specified vaddr=3Dstart+count incorrect.\n");
+        return false;
+    }
+
+    VaddrRange new_vaddrrange =3D {
+        .start =3D start,
+        .end =3D start + len,
+        .hits =3D qemu_plugin_scoreboard_u64(
+            qemu_plugin_scoreboard_new(sizeof(uint64_t))) };
+    g_array_append_val(vaddr_ranges, new_vaddrrange);
+
+    return true;
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
@@ -281,6 +354,10 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugi=
n_id_t id,
             }
         } else if (g_strcmp0(tokens[0], "match") =3D=3D 0) {
             parse_match(tokens[1]);
+        } else if (g_strcmp0(tokens[0], "vaddr") =3D=3D 0) {
+            if (!parse_vaddr(tokens[1])) {
+                return -1;
+            }
         } else if (g_strcmp0(tokens[0], "trace") =3D=3D 0) {
             if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &do_trace))=
 {
                 fprintf(stderr, "boolean argument parsing failed: %s\n", =
opt);
@@ -292,6 +369,20 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugi=
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
2.47.2



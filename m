Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40FA7CA9EDE
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 20:36:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGMjj-0003Ki-0J; Mon, 12 Oct 2026 16:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGMjg-0003Ii-Nz
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 16:35:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGMje-00038g-N3
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 16:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791837301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pwhDweWwIp86pXKXd8JhMBsFd9pxD783qRNB8Qps1Z4=;
 b=TGyYW1Pmc0O0bD9oA3E5Gz7+UaZ3j9thwWNg4oui8VH6BKuiuNIE9pMIs9DHTcIuEM7EfN
 guT/n9SDhTPAB0ENP0XJy3QKJTsNFhBJxk1yO9zCjpvt/zM/V+MD8kjpzcTrFMfKcYrKWV
 cMUuu1m1s5M0hMrZzbBWK2CnfELM/fY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-7h4dH8b8MkSnzQzI0zzbXg-1; Mon,
 12 Oct 2026 20:34:58 +0000
X-MC-Unique: 7h4dH8b8MkSnzQzI0zzbXg-1
X-Mimecast-MFC-AGG-ID: 7h4dH8b8MkSnzQzI0zzbXg_1791837295
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BAFC61805A39; Mon, 12 Oct 2026 20:34:54 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BA34E1800586; Mon, 12 Oct 2026 20:34:53 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 00:34:07 +0400
Subject: [PATCH v2 04/10] gdbstub: add gdb_register_internal_coprocessor()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-query-reg-v2-4-6f95a2e139a9@redhat.com>
References: <20261013-query-reg-v2-0-6f95a2e139a9@redhat.com>
In-Reply-To: <20261013-query-reg-v2-0-6f95a2e139a9@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Glenn Miles <milesg@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, Max Filippov <jcmvbkbc@gmail.com>, 
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=9074;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=5FgGkEk5xNT3INWQJly/OMfG3f09wdkI3AL5ZJKeONQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzURB4I012Sq53uN4WEtBClvmuPYqJfhnPE6tK
 Cjjk1soMteJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas1EQQAKCRDa6OEJdZac
 5WCBD/975Ka979qeLaAKrPXtCQvDuzZr42+pEL7FI9Gncg6/yWAhltRmmYyPPGV2dG8xO4nCIXK
 0NvZp0N4HkiqCJyJDm8JoIvPnucxfXlzerr05OSoTFSOHcD+wowcwXjhySQ9OKpqMBGVnKZ9Wje
 s+04wf2fFaeaT0HnzhOdz4YsrCZkZasFHyRrR/nIHgeXVky7gGUd0c7GBzf+VwXQ4bEGlupXKQ7
 pJwVuyNC2yTLJB3H8TbPpqpCM9vm7lcpj6aF6+xFKg1L75iR3OWw1hN8+HUqRMO+ZHZyT1f9b/E
 jMEjMejFSL57mrktzCA4C11WimEMAeo2UGGSoUs2WhmjF+ZFx4WxPpcx8zRccqMhlqLuV6WmBrQ
 TsFpbsaelLJa1z0MitFU4g9obCCQtoCc6K7RSCmUsAuAdngl5oxf6yKv82SItb3t/s2xLECFxmb
 pF/E75/IFw2nVFSN+Vc9A/l/LJ3qRJIM5o8U1rcx1K0U+AsLf24iPLX6itueoEsJKbqysa/ihqv
 h4Y1XUHSLQTGGq1UmK0x2pRiZg/ttdsgEmKWJhU1G+7eXrfYp+oitlWSPHm5JrEa0yeUmZhAGHA
 1zDd9SQTSOwc34UlNdxDPR68CgOBgsCzwqhZ3oqsfdf7gGFyrUU6pS0CAZG/D8quQKMgjlmJOVQ
 HvolLEBCs4gjkGA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Add support for registering coprocessor features that are only visible
to QEMU's internal APIs (HMP monitor $register expressions, plugins) but
hidden from GDB's target description XML.

When a feature is registered as internal:
- It is excluded from the target.xml sent to GDB
- Its XML is not served via qXfer:features:read
- 'p'/'P' packets for internal register numbers return E14

This is useful for exposing system registers to the HMP monitor without
affecting GDB's register namespace. Exposing aliases or synthetic
registers through GDB's target description can cause problems: name
collisions with GDB's pseudo-registers, independent register caching,
and missing DWARF unwind rules.

Internal features must be registered after all GDB-visible features to
keep remote register numbering consistent. This ordering is enforced
with an assertion.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 gdbstub/gdbstub.c      | 71 ++++++++++++++++++++++++++++++++++++++++++++------
 include/exec/gdbstub.h | 21 +++++++++++++++
 2 files changed, 84 insertions(+), 8 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 912e31b66744..ac0f76d62333 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -54,6 +54,7 @@ typedef struct GDBRegisterState {
     gdb_get_reg_cb get_reg;
     gdb_set_reg_cb set_reg;
     const GDBFeature *feature;
+    bool internal; /* hidden from GDB, accessible via API/monitor */
 } GDBRegisterState;
 
 GDBState gdbserver_state;
@@ -385,6 +386,11 @@ static const char *get_feature_xml(const char *p, const char **newp,
             }
             for (guint i = 0; i < cpu->gdb_regs->len; i++) {
                 r = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
+                /* The core target.xml feature must never be internal. */
+                g_assert(i > 0 || !r->internal);
+                if (r->internal) {
+                    continue;
+                }
                 g_ptr_array_add(
                     xml,
                     g_markup_printf_escaped("<xi:include href=\"%s\"/>",
@@ -400,6 +406,9 @@ static const char *get_feature_xml(const char *p, const char **newp,
     /* Is it one of the features? */
     for (guint i = 0; i < cpu->gdb_regs->len; i++) {
         r = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
+        if (r->internal) {
+            continue;
+        }
         if (strncmp(p, r->feature->xmlname, len) == 0) {
             return r->feature->xml;
         }
@@ -563,13 +572,14 @@ int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
 
 static void gdb_register_feature(CPUState *cpu, int base_reg,
                                  gdb_get_reg_cb get_reg, gdb_set_reg_cb set_reg,
-                                 const GDBFeature *feature)
+                                 const GDBFeature *feature, bool internal)
 {
     GDBRegisterState s = {
         .base_reg = base_reg,
         .get_reg = get_reg,
         .set_reg = set_reg,
-        .feature = feature
+        .feature = feature,
+        .internal = internal
     };
 
     trace_gdbxml_register_feature(feature->name, feature->xmlname,
@@ -605,7 +615,7 @@ void gdb_init_cpu(CPUState *cpu)
         assert(feature->base_reg == 0);
         gdb_register_feature(cpu, 0,
                              cc->gdb_read_register, cc->gdb_write_register,
-                             feature);
+                             feature, false);
         cpu->gdb_next_base_reg = cpu->gdb_num_g_regs = feature->num_regs;
     } else {
         cpu->gdb_next_base_reg = cpu->gdb_num_g_regs = cc->gdb_num_core_regs;
@@ -616,20 +626,26 @@ void gdb_init_cpu(CPUState *cpu)
                           cc->gdb_num_core_regs);
 }
 
-void gdb_register_coprocessor(CPUState *cpu,
-                              gdb_get_reg_cb get_reg, gdb_set_reg_cb set_reg,
-                              const GDBFeature *feature)
+static void do_gdb_register_coprocessor(CPUState *cpu,
+                                        gdb_get_reg_cb get_reg,
+                                        gdb_set_reg_cb set_reg,
+                                        const GDBFeature *feature,
+                                        bool internal)
 {
     GDBRegisterState *s;
     guint i;
     int base_reg = cpu->gdb_next_base_reg;
 
     for (i = 0; i < cpu->gdb_regs->len; i++) {
-        /* Check for duplicates.  */
         s = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
+        /* Check for duplicates.  */
         if (s->feature == feature) {
             return;
         }
+        /* GDB-visible features must not follow internal ones.  */
+        if (!internal) {
+            g_assert(!s->internal);
+        }
     }
 
     if (base_reg < feature->base_reg) {
@@ -637,12 +653,27 @@ void gdb_register_coprocessor(CPUState *cpu,
                                               feature->base_reg);
         base_reg = feature->base_reg;
     }
-    gdb_register_feature(cpu, base_reg, get_reg, set_reg, feature);
+    gdb_register_feature(cpu, base_reg, get_reg, set_reg, feature, internal);
 
     /* Add to end of list.  */
     cpu->gdb_next_base_reg = base_reg + feature->num_regs;
 }
 
+void gdb_register_coprocessor(CPUState *cpu,
+                              gdb_get_reg_cb get_reg, gdb_set_reg_cb set_reg,
+                              const GDBFeature *feature)
+{
+    do_gdb_register_coprocessor(cpu, get_reg, set_reg, feature, false);
+}
+
+void gdb_register_internal_coprocessor(CPUState *cpu,
+                                       gdb_get_reg_cb get_reg,
+                                       gdb_set_reg_cb set_reg,
+                                       const GDBFeature *feature)
+{
+    do_gdb_register_coprocessor(cpu, get_reg, set_reg, feature, true);
+}
+
 void gdb_unregister_coprocessor_all(CPUState *cpu)
 {
     /*
@@ -1223,6 +1254,18 @@ static void handle_remove_bp(GArray *params, void *user_ctx)
  * the remote gdb to fallback to older methods.
  */
 
+static bool gdb_register_is_internal(CPUState *cpu, int reg)
+{
+    for (guint i = 0; i < cpu->gdb_regs->len; i++) {
+        GDBRegisterState *r = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
+
+        if (r->base_reg <= reg && reg < r->base_reg + r->feature->num_regs) {
+            return r->internal;
+        }
+    }
+    return false;
+}
+
 static void handle_set_reg(GArray *params, void *user_ctx)
 {
     int reg_size;
@@ -1232,6 +1275,12 @@ static void handle_set_reg(GArray *params, void *user_ctx)
         return;
     }
 
+    if (gdb_register_is_internal(gdbserver_state.g_cpu,
+                                 gdb_get_cmd_param(params, 0)->val_ull)) {
+        gdb_put_packet("E14");
+        return;
+    }
+
     reg_size = strlen(gdb_get_cmd_param(params, 1)->data) / 2;
     gdb_hextomem(gdbserver_state.mem_buf, gdb_get_cmd_param(params, 1)->data, reg_size);
     gdb_write_register(gdbserver_state.g_cpu, gdbserver_state.mem_buf->data,
@@ -1248,6 +1297,12 @@ static void handle_get_reg(GArray *params, void *user_ctx)
         return;
     }
 
+    if (gdb_register_is_internal(gdbserver_state.g_cpu,
+                                 gdb_get_cmd_param(params, 0)->val_ull)) {
+        gdb_put_packet("E14");
+        return;
+    }
+
     reg_size = gdb_read_register(gdbserver_state.g_cpu,
                                  gdbserver_state.mem_buf,
                                  gdb_get_cmd_param(params, 0)->val_ull);
diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 75eb4d9c365e..1bc778324758 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -40,6 +40,27 @@ void gdb_register_coprocessor(CPUState *cpu,
                               gdb_get_reg_cb get_reg, gdb_set_reg_cb set_reg,
                               const GDBFeature *feature);
 
+/**
+ * gdb_register_internal_coprocessor() - register internal registers
+ *
+ * Like gdb_register_coprocessor(), but the feature is NOT exposed to
+ * GDB via the target description XML. The registers are only
+ * accessible through QEMU's internal APIs (HMP monitor ``$register``
+ * expressions via gdb_get_register_list()).
+ *
+ * Internal features must be registered after all GDB-visible features
+ * to avoid register numbering mismatches with GDB.
+ *
+ * @cpu - the CPU associated with registers
+ * @get_reg - get function
+ * @set_reg - set function
+ * @feature - the GDBFeature describing the registers
+ */
+void gdb_register_internal_coprocessor(CPUState *cpu,
+                                       gdb_get_reg_cb get_reg,
+                                       gdb_set_reg_cb set_reg,
+                                       const GDBFeature *feature);
+
 /**
  * gdb_unregister_coprocessor_all() - unregisters supplemental set of registers
  * @cpu - the CPU associated with registers

-- 
2.56.0.116.g6de20f6092dc



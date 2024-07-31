Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6368FC49EA1
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 13:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ9jI-00053d-Qo; Wed, 31 Jul 2024 09:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junon@oro.sh>) id 1sZ9jH-000534-MQ
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 09:50:59 -0400
Received: from out-184.mta0.migadu.com ([91.218.175.184])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junon@oro.sh>) id 1sZ9jE-0000vl-Ac
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 09:50:59 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oro.sh; s=key1;
 t=1722433853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=nnYjsgXS9yAkNYBEnLsfdmYlBlGx037SDwa8IA0y9/I=;
 b=ZMx//O5lYCYDvEK7/bBRc3ds+Va7JCek3PZ+IIWUU43pPDhZvovBBGN3w4Io7NVwvt+X4t
 t1XBlqlmspmdXVOpIEJ6VWa8KalEMn0PwhOY6RoW4gIfBTemTyZVqJ65SOHu+kiazLVdxF
 BCrn4zdT5GCfhB2YHq5C7KZR9tHEoVw=
From: Josh Junon <junon@oro.sh>
To: qemu-devel@nongnu.org
Cc: Josh Junon <junon@oro.sh>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] qmp: Fix higher half vaddrs for [p]memsave
Date: Wed, 31 Jul 2024 15:50:31 +0200
Message-Id: <20240731135031.11260-1-junon@oro.sh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=91.218.175.184; envelope-from=junon@oro.sh;
 helo=out-184.mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Previously, int64_t's were used when parsing virtual / physical
addresses for the [p]memsave commands over QMP (HMP was unaffected).
This caused issues when the virtual addresses were in the higher
half of a 64-bit address space, as various portions of the parsing
code would consider them out of bounds.

This PR addresses that, creating uint64_t analogs for much of the
parsing/qdict implementations, as well as the expression parser,
to allow for higher-half virtual addresses (or any address with a
MSB=1).
---
 hmp-commands.hx            |   4 +-
 hw/core/machine-hmp-cmds.c |   8 +-
 include/qapi/qmp/qdict.h   |   4 +
 monitor/hmp-expr.inc       | 200 ++++++++++++++++++++++++++++++
 monitor/hmp.c              | 241 ++++++++-----------------------------
 qapi/machine.json          |   4 +-
 qobject/qdict.c            |  38 ++++++
 system/cpus.c              |   4 +-
 tests/unit/check-qdict.c   |  39 ++++++
 9 files changed, 343 insertions(+), 199 deletions(-)
 create mode 100644 monitor/hmp-expr.inc

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 06746f0afc..9e0fe980b1 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -801,7 +801,7 @@ ERST
 
     {
         .name       = "memsave",
-        .args_type  = "val:l,size:i,filename:s",
+        .args_type  = "val:u,size:u,filename:s",
         .params     = "addr size file",
         .help       = "save to disk virtual memory dump starting at 'addr' of size 'size'",
         .cmd        = hmp_memsave,
@@ -814,7 +814,7 @@ ERST
 
     {
         .name       = "pmemsave",
-        .args_type  = "val:l,size:i,filename:s",
+        .args_type  = "val:u,size:u,filename:s",
         .params     = "addr size file",
         .help       = "save to disk physical memory dump starting at 'addr' of size 'size'",
         .cmd        = hmp_pmemsave,
diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
index 8701f00cc7..10512a034b 100644
--- a/hw/core/machine-hmp-cmds.c
+++ b/hw/core/machine-hmp-cmds.c
@@ -196,9 +196,9 @@ void hmp_system_powerdown(Monitor *mon, const QDict *qdict)
 
 void hmp_memsave(Monitor *mon, const QDict *qdict)
 {
-    uint32_t size = qdict_get_int(qdict, "size");
+    uint64_t size = qdict_get_uint(qdict, "size");
     const char *filename = qdict_get_str(qdict, "filename");
-    uint64_t addr = qdict_get_int(qdict, "val");
+    uint64_t addr = qdict_get_uint(qdict, "val");
     Error *err = NULL;
     int cpu_index = monitor_get_cpu_index(mon);
 
@@ -213,9 +213,9 @@ void hmp_memsave(Monitor *mon, const QDict *qdict)
 
 void hmp_pmemsave(Monitor *mon, const QDict *qdict)
 {
-    uint32_t size = qdict_get_int(qdict, "size");
+    uint64_t size = qdict_get_uint(qdict, "size");
     const char *filename = qdict_get_str(qdict, "filename");
-    uint64_t addr = qdict_get_int(qdict, "val");
+    uint64_t addr = qdict_get_uint(qdict, "val");
     Error *err = NULL;
 
     qmp_pmemsave(addr, size, filename, &err);
diff --git a/include/qapi/qmp/qdict.h b/include/qapi/qmp/qdict.h
index 82e90fc072..38c310becb 100644
--- a/include/qapi/qmp/qdict.h
+++ b/include/qapi/qmp/qdict.h
@@ -52,17 +52,21 @@ const QDictEntry *qdict_next(const QDict *qdict, const QDictEntry *entry);
 
 void qdict_put_bool(QDict *qdict, const char *key, bool value);
 void qdict_put_int(QDict *qdict, const char *key, int64_t value);
+void qdict_put_uint(QDict *qdict, const char *key, uint64_t value);
 void qdict_put_null(QDict *qdict, const char *key);
 void qdict_put_str(QDict *qdict, const char *key, const char *value);
 
 double qdict_get_double(const QDict *qdict, const char *key);
 int64_t qdict_get_int(const QDict *qdict, const char *key);
+uint64_t qdict_get_uint(const QDict *qdict, const char *key);
 bool qdict_get_bool(const QDict *qdict, const char *key);
 QList *qdict_get_qlist(const QDict *qdict, const char *key);
 QDict *qdict_get_qdict(const QDict *qdict, const char *key);
 const char *qdict_get_str(const QDict *qdict, const char *key);
 int64_t qdict_get_try_int(const QDict *qdict, const char *key,
                           int64_t def_value);
+uint64_t qdict_get_try_uint(const QDict *qdict, const char *key,
+                          uint64_t def_value);
 bool qdict_get_try_bool(const QDict *qdict, const char *key, bool def_value);
 const char *qdict_get_try_str(const QDict *qdict, const char *key);
 
diff --git a/monitor/hmp-expr.inc b/monitor/hmp-expr.inc
new file mode 100644
index 0000000000..789a957ed2
--- /dev/null
+++ b/monitor/hmp-expr.inc
@@ -0,0 +1,200 @@
+#ifndef HMP_EXPR_INC_TY
+#error "missing HMP_EXPR_INC_TY"
+#endif
+
+#ifndef HMP_EXPR_INC_IDENT
+#error "missing HMP_EXPR_INC_IDENT"
+#endif
+
+static HMP_EXPR_INC_TY HMP_EXPR_INC_IDENT(expr_sum)(Monitor *mon);
+
+static HMP_EXPR_INC_TY HMP_EXPR_INC_IDENT(expr_unary)(Monitor *mon)
+{
+    HMP_EXPR_INC_TY n;
+    char *p;
+    int ret;
+
+    switch (*pch) {
+    case '+':
+        next();
+        n = HMP_EXPR_INC_IDENT(expr_unary)(mon);
+        break;
+    case '-':
+        next();
+        n = -HMP_EXPR_INC_IDENT(expr_unary)(mon);
+        break;
+    case '~':
+        next();
+        n = ~HMP_EXPR_INC_IDENT(expr_unary)(mon);
+        break;
+    case '(':
+        next();
+        n = HMP_EXPR_INC_IDENT(expr_sum)(mon);
+        if (*pch != ')') {
+            expr_error(mon, "')' expected");
+        }
+        next();
+        break;
+    case '\'':
+        pch++;
+        if (*pch == '\0') {
+            expr_error(mon, "character constant expected");
+        }
+        n = *pch;
+        pch++;
+        if (*pch != '\'') {
+            expr_error(mon, "missing terminating \' character");
+        }
+        next();
+        break;
+    case '$':
+        {
+            char buf[128], *q;
+            int64_t reg = 0;
+
+            pch++;
+            q = buf;
+            while ((*pch >= 'a' && *pch <= 'z') ||
+                   (*pch >= 'A' && *pch <= 'Z') ||
+                   (*pch >= '0' && *pch <= '9') ||
+                   *pch == '_' || *pch == '.') {
+                if ((q - buf) < sizeof(buf) - 1) {
+                    *q++ = *pch;
+                }
+                pch++;
+            }
+            while (qemu_isspace(*pch)) {
+                pch++;
+            }
+            *q = 0;
+            ret = get_monitor_def(mon, &reg, buf);
+            if (ret < 0) {
+                expr_error(mon, "unknown register");
+            }
+            n = (HMP_EXPR_INC_TY)reg;
+        }
+        break;
+    case '\0':
+        expr_error(mon, "unexpected end of expression");
+        n = 0;
+        break;
+    default:
+        errno = 0;
+        n = strtoull(pch, &p, 0);
+        if (errno == ERANGE) {
+            expr_error(mon, "number too large");
+        }
+        if (pch == p) {
+            expr_error(mon, "invalid char '%c' in expression", *p);
+        }
+        pch = p;
+        while (qemu_isspace(*pch)) {
+            pch++;
+        }
+        break;
+    }
+    return n;
+}
+
+static HMP_EXPR_INC_TY HMP_EXPR_INC_IDENT(expr_prod)(Monitor *mon)
+{
+    HMP_EXPR_INC_TY val, val2;
+    int op;
+
+    val = HMP_EXPR_INC_IDENT(expr_unary)(mon);
+    for (;;) {
+        op = *pch;
+        if (op != '*' && op != '/' && op != '%') {
+            break;
+        }
+        next();
+        val2 = HMP_EXPR_INC_IDENT(expr_unary)(mon);
+        switch (op) {
+        default:
+        case '*':
+            val *= val2;
+            break;
+        case '/':
+        case '%':
+            if (val2 == 0) {
+                expr_error(mon, "division by zero");
+            }
+            if (op == '/') {
+                val /= val2;
+            } else {
+                val %= val2;
+            }
+            break;
+        }
+    }
+    return val;
+}
+
+static HMP_EXPR_INC_TY HMP_EXPR_INC_IDENT(expr_logic)(Monitor *mon)
+{
+    HMP_EXPR_INC_TY val, val2;
+    int op;
+
+    val = HMP_EXPR_INC_IDENT(expr_prod)(mon);
+    for (;;) {
+        op = *pch;
+        if (op != '&' && op != '|' && op != '^') {
+            break;
+        }
+        next();
+        val2 = HMP_EXPR_INC_IDENT(expr_prod)(mon);
+        switch (op) {
+        default:
+        case '&':
+            val &= val2;
+            break;
+        case '|':
+            val |= val2;
+            break;
+        case '^':
+            val ^= val2;
+            break;
+        }
+    }
+    return val;
+}
+
+static HMP_EXPR_INC_TY HMP_EXPR_INC_IDENT(expr_sum)(Monitor *mon)
+{
+    HMP_EXPR_INC_TY val, val2;
+    int op;
+
+    val = HMP_EXPR_INC_IDENT(expr_logic)(mon);
+    for (;;) {
+        op = *pch;
+        if (op != '+' && op != '-') {
+            break;
+        }
+        next();
+        val2 = HMP_EXPR_INC_IDENT(expr_logic)(mon);
+        if (op == '+') {
+            val += val2;
+        } else {
+            val -= val2;
+        }
+    }
+    return val;
+}
+
+static int HMP_EXPR_INC_IDENT(get_expr)(Monitor *mon, HMP_EXPR_INC_TY *pval, const char **pp)
+{
+    pch = *pp;
+    if (sigsetjmp(expr_env, 0)) {
+        *pp = pch;
+        return -1;
+    }
+    while (qemu_isspace(*pch)) {
+        pch++;
+    }
+    *pval = HMP_EXPR_INC_IDENT(expr_sum)(mon);
+    *pp = pch;
+    return 0;
+}
+
+#undef HMP_EXPR_INC_TY
+#undef HMP_EXPR_INC_IDENT
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 460e8832f6..95d965a20a 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -332,195 +332,13 @@ static void next(void)
     }
 }
 
-static int64_t expr_sum(Monitor *mon);
+#define HMP_EXPR_INC_TY int64_t
+#define HMP_EXPR_INC_IDENT(name) name ## _int64
+#include "monitor/hmp-expr.inc"
 
-static int64_t expr_unary(Monitor *mon)
-{
-    int64_t n;
-    char *p;
-    int ret;
-
-    switch (*pch) {
-    case '+':
-        next();
-        n = expr_unary(mon);
-        break;
-    case '-':
-        next();
-        n = -expr_unary(mon);
-        break;
-    case '~':
-        next();
-        n = ~expr_unary(mon);
-        break;
-    case '(':
-        next();
-        n = expr_sum(mon);
-        if (*pch != ')') {
-            expr_error(mon, "')' expected");
-        }
-        next();
-        break;
-    case '\'':
-        pch++;
-        if (*pch == '\0') {
-            expr_error(mon, "character constant expected");
-        }
-        n = *pch;
-        pch++;
-        if (*pch != '\'') {
-            expr_error(mon, "missing terminating \' character");
-        }
-        next();
-        break;
-    case '$':
-        {
-            char buf[128], *q;
-            int64_t reg = 0;
-
-            pch++;
-            q = buf;
-            while ((*pch >= 'a' && *pch <= 'z') ||
-                   (*pch >= 'A' && *pch <= 'Z') ||
-                   (*pch >= '0' && *pch <= '9') ||
-                   *pch == '_' || *pch == '.') {
-                if ((q - buf) < sizeof(buf) - 1) {
-                    *q++ = *pch;
-                }
-                pch++;
-            }
-            while (qemu_isspace(*pch)) {
-                pch++;
-            }
-            *q = 0;
-            ret = get_monitor_def(mon, &reg, buf);
-            if (ret < 0) {
-                expr_error(mon, "unknown register");
-            }
-            n = reg;
-        }
-        break;
-    case '\0':
-        expr_error(mon, "unexpected end of expression");
-        n = 0;
-        break;
-    default:
-        errno = 0;
-        n = strtoull(pch, &p, 0);
-        if (errno == ERANGE) {
-            expr_error(mon, "number too large");
-        }
-        if (pch == p) {
-            expr_error(mon, "invalid char '%c' in expression", *p);
-        }
-        pch = p;
-        while (qemu_isspace(*pch)) {
-            pch++;
-        }
-        break;
-    }
-    return n;
-}
-
-static int64_t expr_prod(Monitor *mon)
-{
-    int64_t val, val2;
-    int op;
-
-    val = expr_unary(mon);
-    for (;;) {
-        op = *pch;
-        if (op != '*' && op != '/' && op != '%') {
-            break;
-        }
-        next();
-        val2 = expr_unary(mon);
-        switch (op) {
-        default:
-        case '*':
-            val *= val2;
-            break;
-        case '/':
-        case '%':
-            if (val2 == 0) {
-                expr_error(mon, "division by zero");
-            }
-            if (op == '/') {
-                val /= val2;
-            } else {
-                val %= val2;
-            }
-            break;
-        }
-    }
-    return val;
-}
-
-static int64_t expr_logic(Monitor *mon)
-{
-    int64_t val, val2;
-    int op;
-
-    val = expr_prod(mon);
-    for (;;) {
-        op = *pch;
-        if (op != '&' && op != '|' && op != '^') {
-            break;
-        }
-        next();
-        val2 = expr_prod(mon);
-        switch (op) {
-        default:
-        case '&':
-            val &= val2;
-            break;
-        case '|':
-            val |= val2;
-            break;
-        case '^':
-            val ^= val2;
-            break;
-        }
-    }
-    return val;
-}
-
-static int64_t expr_sum(Monitor *mon)
-{
-    int64_t val, val2;
-    int op;
-
-    val = expr_logic(mon);
-    for (;;) {
-        op = *pch;
-        if (op != '+' && op != '-') {
-            break;
-        }
-        next();
-        val2 = expr_logic(mon);
-        if (op == '+') {
-            val += val2;
-        } else {
-            val -= val2;
-        }
-    }
-    return val;
-}
-
-static int get_expr(Monitor *mon, int64_t *pval, const char **pp)
-{
-    pch = *pp;
-    if (sigsetjmp(expr_env, 0)) {
-        *pp = pch;
-        return -1;
-    }
-    while (qemu_isspace(*pch)) {
-        pch++;
-    }
-    *pval = expr_sum(mon);
-    *pp = pch;
-    return 0;
-}
+#define HMP_EXPR_INC_TY uint64_t
+#define HMP_EXPR_INC_IDENT(name) name ## _uint64
+#include "monitor/hmp-expr.inc"
 
 static int get_double(Monitor *mon, double *pval, const char **pp)
 {
@@ -882,7 +700,7 @@ static QDict *monitor_parse_arguments(Monitor *mon,
                     }
                     typestr++;
                 }
-                if (get_expr(mon, &val, &p)) {
+                if (get_expr_int64(mon, &val, &p)) {
                     goto fail;
                 }
                 /* Check if 'i' is greater than 32-bit */
@@ -900,6 +718,51 @@ static QDict *monitor_parse_arguments(Monitor *mon,
                 qdict_put_int(qdict, key, val);
             }
             break;
+        case 'd':
+        case 'u':
+        case 'm':
+            {
+                uint64_t val;
+
+                while (qemu_isspace(*p)) {
+                    p++;
+                }
+                if (*typestr == '?' || *typestr == '.') {
+                    if (*typestr == '?') {
+                        if (*p == '\0') {
+                            typestr++;
+                            break;
+                        }
+                    } else {
+                        if (*p == '.') {
+                            p++;
+                            while (qemu_isspace(*p)) {
+                                p++;
+                            }
+                        } else {
+                            typestr++;
+                            break;
+                        }
+                    }
+                    typestr++;
+                }
+
+                if (get_expr_uint64(mon, &val, &p)) {
+                    goto fail;
+                }
+
+                /* Check if 'd' is greater than 32-bit */
+                if ((c == 'd') && ((val >> 32) & 0xffffffff)) {
+                    monitor_printf(mon, "\'%s\' has failed: ", cmd->name);
+                    monitor_printf(mon, "integer is for 32-bit values\n");
+                    goto fail;
+                } else if (c == 'm') {
+                    val *= MiB;
+                }
+
+                qdict_put_uint(qdict, key, val);
+            }
+            break;
         case 'o':
             {
                 int ret;
diff --git a/qapi/machine.json b/qapi/machine.json
index fcfd249e2d..90f4ecbfd0 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -852,7 +852,7 @@
 #     <- { "return": {} }
 ##
 { 'command': 'memsave',
-  'data': {'val': 'int', 'size': 'int', 'filename': 'str', '*cpu-index': 'int'} }
+  'data': {'val': 'uint64', 'size': 'uint64', 'filename': 'str', '*cpu-index': 'int'} }
 
 ##
 # @pmemsave:
@@ -878,7 +878,7 @@
 #     <- { "return": {} }
 ##
 { 'command': 'pmemsave',
-  'data': {'val': 'int', 'size': 'int', 'filename': 'str'} }
+  'data': {'val': 'uint64', 'size': 'uint64', 'filename': 'str'} }
 
 ##
 # @Memdev:
diff --git a/qobject/qdict.c b/qobject/qdict.c
index 8faff230d3..9696eee57d 100644
--- a/qobject/qdict.c
+++ b/qobject/qdict.c
@@ -136,6 +136,11 @@ void qdict_put_int(QDict *qdict, const char *key, int64_t value)
     qdict_put(qdict, key, qnum_from_int(value));
 }
 
+void qdict_put_uint(QDict *qdict, const char *key, uint64_t value)
+{
+    qdict_put(qdict, key, qnum_from_uint(value));
+}
+
 void qdict_put_bool(QDict *qdict, const char *key, bool value)
 {
     qdict_put(qdict, key, qbool_from_bool(value));
@@ -209,6 +214,19 @@ int64_t qdict_get_int(const QDict *qdict, const char *key)
     return qnum_get_int(qobject_to(QNum, qdict_get(qdict, key)));
 }
 
+/**
+ * qdict_get_int(): Get an unsigned integer mapped by 'key'
+ *
+ * This function assumes that 'key' exists and it stores a
+ * QNum representable as uint.
+ *
+ * Return integer mapped by 'key'.
+ */
+uint64_t qdict_get_uint(const QDict *qdict, const char *key)
+{
+    return qnum_get_uint(qobject_to(QNum, qdict_get(qdict, key)));
+}
+
 /**
  * qdict_get_bool(): Get a bool mapped by 'key'
  *
@@ -272,6 +290,26 @@ int64_t qdict_get_try_int(const QDict *qdict, const char *key,
     return val;
 }
 
+/**
+ * qdict_get_try_uint(): Try to get unsigned integer mapped by 'key'
+ *
+ * Return integer mapped by 'key', if it is not present in the
+ * dictionary or if the stored object is not a QNum representing an
+ * unsigned integer, 'def_value' will be returned.
+ */
+uint64_t qdict_get_try_uint(const QDict *qdict, const char *key,
+                          uint64_t def_value)
+{
+    QNum *qnum = qobject_to(QNum, qdict_get(qdict, key));
+    uint64_t val;
+
+    if (!qnum || !qnum_get_try_uint(qnum, &val)) {
+        return def_value;
+    }
+
+    return val;
+}
+
 /**
  * qdict_get_try_bool(): Try to get a bool mapped by 'key'
  *
diff --git a/system/cpus.c b/system/cpus.c
index 5e3a988a0a..daad8852d1 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -792,7 +792,7 @@ int vm_stop_force_state(RunState state)
     }
 }
 
-void qmp_memsave(int64_t addr, int64_t size, const char *filename,
+void qmp_memsave(uint64_t addr, uint64_t size, const char *filename,
                  bool has_cpu, int64_t cpu_index, Error **errp)
 {
     FILE *f;
@@ -840,7 +840,7 @@ exit:
     fclose(f);
 }
 
-void qmp_pmemsave(int64_t addr, int64_t size, const char *filename,
+void qmp_pmemsave(uint64_t addr, uint64_t size, const char *filename,
                   Error **errp)
 {
     FILE *f;
diff --git a/tests/unit/check-qdict.c b/tests/unit/check-qdict.c
index b5efa859b0..09ebe08900 100644
--- a/tests/unit/check-qdict.c
+++ b/tests/unit/check-qdict.c
@@ -99,6 +99,21 @@ static void qdict_get_int_test(void)
     qobject_unref(tests_dict);
 }
 
+static void qdict_get_uint_test(void)
+{
+    int ret;
+    const unsigned int value = 100;
+    const char *key = "int";
+    QDict *tests_dict = qdict_new();
+
+    qdict_put_uint(tests_dict, key, value);
+
+    ret = qdict_get_uint(tests_dict, key);
+    g_assert(ret == value);
+
+    qobject_unref(tests_dict);
+}
+
 static void qdict_get_try_int_test(void)
 {
     int ret;
@@ -121,6 +136,28 @@ static void qdict_get_try_int_test(void)
     qobject_unref(tests_dict);
 }
 
+static void qdict_get_try_uint_test(void)
+{
+    int ret;
+    const unsigned int value = 100;
+    const char *key = "int";
+    QDict *tests_dict = qdict_new();
+
+    qdict_put_uint(tests_dict, key, value);
+    qdict_put_str(tests_dict, "string", "test");
+
+    ret = qdict_get_try_uint(tests_dict, key, 0);
+    g_assert(ret == value);
+
+    ret = qdict_get_try_uint(tests_dict, "missing", -42);
+    g_assert_cmpuint(ret, ==, -42);
+
+    ret = qdict_get_try_uint(tests_dict, "string", -42);
+    g_assert_cmpuint(ret, ==, -42);
+
+    qobject_unref(tests_dict);
+}
+
 static void qdict_get_str_test(void)
 {
     const char *p;
@@ -358,7 +395,9 @@ int main(int argc, char **argv)
     /* Continue, but now with fixtures */
     g_test_add_func("/public/get", qdict_get_test);
     g_test_add_func("/public/get_int", qdict_get_int_test);
+    g_test_add_func("/public/get_uint", qdict_get_uint_test);
     g_test_add_func("/public/get_try_int", qdict_get_try_int_test);
+    g_test_add_func("/public/get_try_uint", qdict_get_try_uint_test);
     g_test_add_func("/public/get_str", qdict_get_str_test);
     g_test_add_func("/public/get_try_str", qdict_get_try_str_test);
     g_test_add_func("/public/haskey_not", qdict_haskey_not_test);
-- 
2.34.1



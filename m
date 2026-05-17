Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 287ABCD4F3D
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 19:41:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOhLx-0005Mn-5x; Sun, 17 May 2026 15:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <khaled.saleh.req@gmail.com>)
 id 1wOhA7-0001mI-9a
 for qemu-devel@nongnu.org; Sun, 17 May 2026 15:28:31 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <khaled.saleh.req@gmail.com>)
 id 1wOhA5-0001dT-La
 for qemu-devel@nongnu.org; Sun, 17 May 2026 15:28:31 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-44a14580111so1103164f8f.0
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 12:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779046107; x=1779650907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XbVWFxGGUbwLtPR90L3gk9LViRmmT9V7vM/ENhdKCYw=;
 b=Jltj+8ThSbVJ0riCQF6gw2iWzDz8YSYXMaI1+v6fR82/CtXMfk+C/33IR5lbLIfexu
 yqmScQnVS+XW9uAq/lfsSTmjuEnmo1+0m0sPeP+3Oj2qGz1APOc0cwwI6tmMl5K+rTtT
 EFXWPc5bqD95Ph7Em9cUe5zkGaizhFKch8iatjH5SpYPJcjHtnvma8S8QT++LSJcluqn
 JzXHxf38WFzTjL2qJQIGxig9qdkh7H+VrlasK9Q8/lvTrukohjAR1dqjxap8y3+eQXg6
 0+zsuZPVSs6dvdn83v49riEp9LQBImXBlUXVHlMZJzzfWQG7wf1UnIx8lfe3Up/0XWJ4
 pIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779046107; x=1779650907;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XbVWFxGGUbwLtPR90L3gk9LViRmmT9V7vM/ENhdKCYw=;
 b=MOylfi9xp8UlC+OkZIEmRlyOM0+K5iGZu8kVYUN2JKDglUI6/ysl6vNtdjhGySB85J
 I+TZlrJIYe2KsnuR4FyZWfLS93jF7g+VvJwcuphLkEwgXrNINjeoOLc1AIWdGkdjNTM/
 Ty4q0d3sVqNHbWabTh+TeCKuzGgeTrZ7SjTstQTigctED0FoHqYepyQl0sow5cU3Gn8l
 13dmhu4wz5FdZY8l4nGYp6u8hkdsfA1zMa3uAejPVnZ6yN7Xw5bcyYVFhl9q0/6U3ksr
 uwyvqOBZMDr1MKyhFl2zwLX0bw5+b8XiIN9YDYk1bbf0yJE8wTzfEWK7G9To9+oQqhZQ
 9i/Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Z+urZVetLZd4ehkUQOtWJq5b8pA5GI4g9/VZWWCfpiSjXztfj18MqNw++cO5nt1d/O21aTOjzI69R@nongnu.org
X-Gm-Message-State: AOJu0YzCdXBfTEtgcVR0K9fhKRviqyJFwARcWtb5y4NuOhnaHDe+OO15
 9dS3vUV+nmMNRlTBcC8IQHvjUhclLbbBgNOfBwEwbTeNix/tw8Ed89JJ
X-Gm-Gg: Acq92OEDjIr8jCpRZAWVsnaDNe1/Wmy693Ct9Q4R+efdNouq+eVh/uhLWLFyyrbSntS
 iMYllh10yPCokKCZrRERz8fwQRLKcro5qDLAaN88qPPFyj/Fn5KHmslXLvg8/PdaE7U7wavnF2+
 amDnjg4TJ2tb+ah8+SAIHFOJZZcbTFk5aCN/gklDpmvOIbaThwOa6J3xwBQ7C8yR4OGLqlW9Mbf
 wnsWCIGdsUMiiUyJw3y7P5CuQjhJUV4Y/j4TUW9flvL9/BKgGfEgxQ5LjwKonq13cPz3rh4APsY
 xbL7oIFkFxnp0fozFe7v4gfJfnj/4onk6vEKSK9ENve40e1ebD7A+j4TcnRmNLxlH89EiqM0RRM
 /4sLNS9sXbsr+7FjKtkTAWEc/wTss3Vy/Cz0A/vGsZrvqtN5yN5ehmj/jjApSB+rCGtX9cPWTQk
 92G/3uilDnXEd1Lb/H7A9mh4lXdq/Lk7mzPMXUhGCiBjUoHCZXPuO3+xOIgX6/T1qGActyCVn4X
 JE2lJGYN5iDugRtVHA5MYkvtees
X-Received: by 2002:a05:6000:1883:b0:45e:7415:8c4c with SMTP id
 ffacd0b85a97d-45e74158c50mr5481256f8f.43.1779046107076; 
 Sun, 17 May 2026 12:28:27 -0700 (PDT)
Received: from localhost.localdomain ([105.39.115.17])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e768072sm31223828f8f.5.2026.05.17.12.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 12:28:26 -0700 (PDT)
From: khaled saleh <khaled.saleh.req@gmail.com>
To: palmer@dabbelt.com,
	alistair.francis@wdc.com
Cc: liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, khaled.saleh.req@gmail.com
Subject: [PATCH] target/riscv: Convert priv_spec property from string to enum
Date: Sun, 17 May 2026 21:28:00 +0200
Message-Id: <20260517192800.112905-1-khaled.saleh.req@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=khaled.saleh.req@gmail.com; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 17 May 2026 15:40:43 -0400
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

The priv_spec property accepts a fixed set of values (v1.10.0, v1.11.0, v1.12.0, v1.13.0) but was implemented as a string type with manual string-to-enum conversion in custom getter/setter functions.

Convert it to use QEnumLookup with visit_type_enum() for:
- Automatic input validation by the visitor framework
- QMP introspection support (valid values are discoverable)
- Reduced boilerplate (priv_spec_from_str/to_str removed)

This resolves the "FIXME enum?" comment in cpu.c.

Signed-off-by: khaled saleh <khaled.saleh.req@gmail.com>
---
 target/riscv/cpu.c         | 59 +++++++++++---------------------------
 target/riscv/cpu.h         |  1 +
 target/riscv/tcg/tcg-cpu.c |  3 +-
 3 files changed, 20 insertions(+), 43 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 506a018d52..8365471572 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -26,6 +26,7 @@
 #include "internals.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
+#include "qapi/util.h"
 #include "qemu/error-report.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-prop-internal.h"
@@ -1655,51 +1656,25 @@ static const PropertyInfo prop_pmp_granularity = {
     .set = prop_pmp_granularity_set,
 };
 
-static int priv_spec_from_str(const char *priv_spec_str)
-{
-    int priv_version = -1;
-
-    if (!g_strcmp0(priv_spec_str, PRIV_VER_1_13_0_STR)) {
-        priv_version = PRIV_VERSION_1_13_0;
-    } else if (!g_strcmp0(priv_spec_str, PRIV_VER_1_12_0_STR)) {
-        priv_version = PRIV_VERSION_1_12_0;
-    } else if (!g_strcmp0(priv_spec_str, PRIV_VER_1_11_0_STR)) {
-        priv_version = PRIV_VERSION_1_11_0;
-    } else if (!g_strcmp0(priv_spec_str, PRIV_VER_1_10_0_STR)) {
-        priv_version = PRIV_VERSION_1_10_0;
-    }
-
-    return priv_version;
-}
+static const char *const priv_spec_str[] = {
+    [PRIV_VERSION_1_10_0] = PRIV_VER_1_10_0_STR,
+    [PRIV_VERSION_1_11_0] = PRIV_VER_1_11_0_STR,
+    [PRIV_VERSION_1_12_0] = PRIV_VER_1_12_0_STR,
+    [PRIV_VERSION_1_13_0] = PRIV_VER_1_13_0_STR,
+};
 
-const char *priv_spec_to_str(int priv_version)
-{
-    switch (priv_version) {
-    case PRIV_VERSION_1_10_0:
-        return PRIV_VER_1_10_0_STR;
-    case PRIV_VERSION_1_11_0:
-        return PRIV_VER_1_11_0_STR;
-    case PRIV_VERSION_1_12_0:
-        return PRIV_VER_1_12_0_STR;
-    case PRIV_VERSION_1_13_0:
-        return PRIV_VER_1_13_0_STR;
-    default:
-        return NULL;
-    }
-}
+const QEnumLookup priv_spec_lookup = {
+    .array = priv_spec_str,
+    .size = ARRAY_SIZE(priv_spec_str),
+};
 
 static void prop_priv_spec_set(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
     RISCVCPU *cpu = RISCV_CPU(obj);
-    g_autofree char *value = NULL;
-    int priv_version = -1;
-
-    visit_type_str(v, name, &value, errp);
+    int priv_version;
 
-    priv_version = priv_spec_from_str(value);
-    if (priv_version < 0) {
-        error_setg(errp, "Unsupported privilege spec version '%s'", value);
+    if (!visit_type_enum(v, name, &priv_version, &priv_spec_lookup, errp)) {
         return;
     }
 
@@ -1718,15 +1693,15 @@ static void prop_priv_spec_get(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
     RISCVCPU *cpu = RISCV_CPU(obj);
-    const char *value = priv_spec_to_str(cpu->env.priv_ver);
+    int value = cpu->env.priv_ver;
 
-    visit_type_str(v, name, (char **)&value, errp);
+    visit_type_enum(v, name, &value, &priv_spec_lookup, errp);
 }
 
 static const PropertyInfo prop_priv_spec = {
-    .type = "str",
+    .type = "RISCVPrivSpec",
     .description = "priv_spec",
-    /* FIXME enum? */
+    .enum_table = &priv_spec_lookup,
     .get = prop_priv_spec_get,
     .set = prop_priv_spec_set,
 };
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index fae839cade..522b63016f 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -70,6 +70,7 @@ typedef struct CPUArchState CPURISCVState;
 #define RVG RV('G')
 #define RVB RV('B')
 
+extern const QEnumLookup priv_spec_lookup;
 extern const uint32_t misa_bits[];
 const char *riscv_get_misa_ext_name(uint32_t bit);
 const char *riscv_get_misa_ext_description(uint32_t bit);
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 02c98cc2db..2ec4b8e98e 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -27,6 +27,7 @@
 #include "time_helper.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
+#include "qapi/util.h"
 #include "qemu/accel.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
@@ -86,7 +87,7 @@ static void riscv_cpu_write_misa_bit(RISCVCPU *cpu, uint32_t bit,
 
 static const char *cpu_priv_ver_to_str(int priv_ver)
 {
-    const char *priv_spec_str = priv_spec_to_str(priv_ver);
+    const char *priv_spec_str = qapi_enum_lookup(&priv_spec_lookup, priv_ver);
 
     g_assert(priv_spec_str);
 
-- 
2.34.1



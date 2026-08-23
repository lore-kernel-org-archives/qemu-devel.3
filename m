Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDED2C5DF81
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2026 15:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wy9oy-0000Cp-Ew; Sun, 23 Aug 2026 11:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wy9ov-0008Us-Dr
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 11:09:13 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wy9ot-0000KR-IP
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 11:09:13 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2cacb8416a1so22066775ad.1
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 08:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787497749; x=1788102549; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3/7rt1r61WGXRcLix3Z+rEmEpuAmxgvwhtCQnB5f42s=;
 b=UfkktxsUmHgs7L/yhjdVis29mqIePkAZGeIWYMjX8MOx/lByXY9E+o8eCPAQAyMzgf
 L/Edex0MS8F/hQj7/Yt3BNMFWjhQg5lKgVRs3WtA8HaH+/gATOKMjRUiOAL6apY7Ngyz
 pKDw6zOzhmTzKuG2lPyTsNducuY9a+7kiBNTpmVwR+fIV93Vben2dEWWZruYgBPQx9Q/
 OuIMTovG2UEoGpLF+uYy9Wwf1WVlBfDDo/iyEZi+G9RlCJKrdRuPnjtydQbloaHh0VwK
 cb4NtPYl6lEeoDRpUfeREOHpwPLCE1RIMbmmcqQkFJBqM/9X00hk4TnIikX4Qb+Hn4nc
 Cmdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787497749; x=1788102549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3/7rt1r61WGXRcLix3Z+rEmEpuAmxgvwhtCQnB5f42s=;
 b=DlTvvyEEMWeqK7KXFNmWkhc+qoipvLkNKhsozBYjxrg4Yo+isdyveNvyuR9zMmlwX/
 FJUxdoD1mKaAMFw/Mzr0WRvSXmedHxF4Yd2wEIMpItbmejjUWAp+xvOmcLV1AtpV6ur9
 +fMfwRL1F4xDlI3YO3jNL3PqdEFOC5LaUlUHHSjnyMPpqvJtTH0MJNy77Lk1sWLqkLgr
 Z6fcfD5X05pebbkSprGE1M1SMB1GkFqlXIqEKRF6V1JjaQwmcueD2D78CS9wipFMTSNQ
 WM4uJMwJO1nALwKhkqaCDDADAX7Co/hafTGcwZC/ymIjQLBQ+783lqubla6rrLGmZMgY
 GL6A==
X-Gm-Message-State: AFuF++kq8dCh4R8Q/pV2BWC/v2E1nCZlGXNshjGLUVCptQ8Jyxyo4c8f
 It5kM6bWn08Ma1Bl5Q63Xa2KNroRlnIIMoia7sLdgtqfGAJTFbEzHn8WDMTBzl8t
X-Gm-Gg: AR+sD11LvYIS1OOL9L54aSACx1ij5zM3VKY8tkbXseIqBI4hOZgV9ZMXBSApqbkIaPO
 /KyfAzZeyJPdIU0BM5aCTQuqlH8R9BXXjD8R52YwcoegXG5MKDLeNo4Jx8SOkWU3df36myZ4A87
 emmuqpEWRx0MIFhTcXK+SpO25I2t4LeoWPxobFUePPiNKvfd/S0GKAQ240q4dtULWZgEUiFp7gE
 amAPT94E0LthJX1vUGjho2QB8Fwpqd67JP/Kul/6vr8bbKE1HlyKEBG1PWuvfqU0Wi27a0Ayc3P
 EeNIbDIm6IzMYVevD3TYY1FbCha0V/hUHGjlxcq1HX4za3OP5UV8p6+sgDdmOMFMjLgnmuy149r
 bPa1imKu4+gbcqCisVdD8C6tAyERXgquz5kIQxpYoa0235dXSE5pPfAZoEafI/Z+turPFbs1SfV
 V4dtdNlxQAnDNSoEKaTrf0OPlBXQ4jiuos8nKF9gOtaTmHfSVD71coejrjbgo1kuYYQcTaM0+if
 WspiKVqnI2fdyZ00NF+PA==
X-Received: by 2002:a17:90b:4acd:b0:38f:1a2e:6e56 with SMTP id
 98e67ed59e1d1-395c387407cmr32670087a91.9.1787497749243; 
 Sun, 23 Aug 2026 08:09:09 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1418619d6ecsm16024511c88.14.2026.08.23.08.09.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 08:09:08 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Sunil V L <sunilvl@ventanamicro.com>,
 qemu-riscv@nongnu.org, Alexander Bulekov <alxndr@bu.edu>,
 Zhao Liu <zhao1.liu@intel.com>, Eric Farman <farman@linux.ibm.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chao Liu <chao.liu@processmission.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <17746591750@163.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-s390x@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@kernel.org>, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>,
 Darren Kenny <darren.kenny@oracle.com>
Subject: [PATCH 09/12] target-info: register le and be TargetInfo variants
Date: Sun, 23 Aug 2026 23:07:27 +0800
Message-ID: <20260823150731.896-10-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260823150731.896-1-luoyonggang@gmail.com>
References: <20260823150731.896-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

- Register target-info-<name>-le and -be from one system
  target-info-def.c unit, sharing arch fields.
- Mark is_default from TARGET_BIG_ENDIAN so riscv/arm stay LE and
  ppc/s390x stay BE when -target is omitted.
- Pick the unique default in target_info_qom_set_target() when more
  than one TargetInfo is registered. Leave user-mode as a single
  target_info().

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/qemu/target-info-impl.h |  6 ++++
 include/qemu/target-info-init.h | 29 +++++++++++++---
 target-info-def.c               | 61 +++++++++++++++++++++++++--------
 target-info-qom.c               | 33 ++++++++++++++----
 4 files changed, 104 insertions(+), 25 deletions(-)

diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-impl.h
index de329ec2b86..b4222e4455e 100644
--- a/include/qemu/target-info-impl.h
+++ b/include/qemu/target-info-impl.h
@@ -23,6 +23,12 @@ typedef struct TargetInfo {
     const char *cpu_type;
     /* related to TARGET_BIG_ENDIAN definition */
     EndianMode endianness;
+    /*
+     * True on the endian variant that matches this translation unit's
+     * TARGET_BIG_ENDIAN. target_info_qom_set_target() uses this when
+     * more than one TargetInfo is registered and -target is omitted.
+     */
+    bool is_default;
     /*
      * runtime equivalent of
      *   TARGET_PAGE_BITS_VARY ? TARGET_PAGE_BITS_LEGACY : TARGET_PAGE_BITS
diff --git a/include/qemu/target-info-init.h b/include/qemu/target-info-init.h
index b7024c9faef..25d00adcc66 100644
--- a/include/qemu/target-info-init.h
+++ b/include/qemu/target-info-init.h
@@ -37,15 +37,34 @@ const TargetInfo *target_info(void)     \
 #include "qemu/target-info-qom.h"
 #include "qom/object.h"
 
-#define target_info_init(ti_var)                                            \
-static const TypeInfo target_info_qom_target_type_info = {                  \
-    .name =  TYPE_TARGET_INFO"-"TARGET_NAME,                                \
+/*
+ * QOM type names are target-info-<TARGET_NAME>-le and -be so both
+ * endian variants can be registered from one system translation unit.
+ */
+#define TARGET_INFO_QOM_SUFFIX_0 "-le"
+#define TARGET_INFO_QOM_SUFFIX_1 "-be"
+
+#define TARGET_INFO_QOM_NAME(sel)                                           \
+    TYPE_TARGET_INFO "-" TARGET_NAME glue(TARGET_INFO_QOM_SUFFIX_, sel)
+
+#define TARGET_INFO_QOM_TYPEINFO(ti_var, sel)                               \
+static const TypeInfo glue(target_info_qom_type_, sel) = {                  \
+    .name = TARGET_INFO_QOM_NAME(sel),                                      \
     .parent = TYPE_TARGET_INFO,                                             \
     .instance_size = sizeof(TargetInfoQom),                                 \
     .class_size = sizeof(TargetInfoQomClass),                               \
     .class_data = &ti_var,                                                  \
-};                                                                          \
-DEFINE_TARGET_INFO_TYPE(target_info_qom_target_type_info)
+}
+
+#define target_info_init_le_be(ti_le, ti_be)                                \
+TARGET_INFO_QOM_TYPEINFO(ti_le, 0);                                         \
+TARGET_INFO_QOM_TYPEINFO(ti_be, 1);                                         \
+static void do_qemu_init_target_info(void)                                  \
+{                                                                           \
+    type_register_static(&target_info_qom_type_0);                          \
+    type_register_static(&target_info_qom_type_1);                          \
+}                                                                           \
+module_init(do_qemu_init_target_info, MODULE_INIT_TARGET_INFO)
 
 #endif /* CONFIG_USER_ONLY */
 #endif /* COMPILING_PER_TARGET */
diff --git a/target-info-def.c b/target-info-def.c
index 5d38e405735..6722c43a08f 100644
--- a/target-info-def.c
+++ b/target-info-def.c
@@ -28,39 +28,72 @@ QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
 QEMU_BUILD_BUG_ON(TARGET_PAGE_BITS < TARGET_PAGE_BITS_MIN);
 #endif
 
-static const TargetInfo target_info_def = {
-    .target_name = TARGET_NAME,
-    .target_arch = glue(SYS_EMU_TARGET_, TARGET_ARCH),
-    .long_bits = TARGET_LONG_BITS,
-    .cpu_type = CPU_RESOLVING_TYPE,
-    .endianness = TARGET_BIG_ENDIAN ? ENDIAN_MODE_BIG : ENDIAN_MODE_LITTLE,
 #ifdef TARGET_PAGE_BITS_VARY
-    .page_bits_vary = true,
 # ifdef TARGET_PAGE_BITS_LEGACY
+#  define TARGET_INFO_PAGE_BITS \
+    .page_bits_vary = true, \
     .page_bits_init = TARGET_PAGE_BITS_LEGACY,
+# else
+#  define TARGET_INFO_PAGE_BITS \
+    .page_bits_vary = true,
 # endif
 #else
-    .page_bits_vary = false,
+# define TARGET_INFO_PAGE_BITS \
+    .page_bits_vary = false, \
     .page_bits_init = TARGET_PAGE_BITS,
 #endif
 
 #ifndef CONFIG_USER_ONLY
 # ifdef CONFIG_MULTIPROCESS
-    .config_multiprocess = true,
+#  define TARGET_INFO_CONFIG_MULTIPROCESS .config_multiprocess = true,
 # else
-    .config_multiprocess = false,
+#  define TARGET_INFO_CONFIG_MULTIPROCESS .config_multiprocess = false,
 # endif
 # ifdef CONFIG_NITRO
-    .config_nitro = true,
+#  define TARGET_INFO_CONFIG_NITRO .config_nitro = true,
 # else
-    .config_nitro = false,
+#  define TARGET_INFO_CONFIG_NITRO .config_nitro = false,
 # endif
 # ifdef CONFIG_XEN
-    .config_xen = true,
+#  define TARGET_INFO_CONFIG_XEN .config_xen = true,
 # else
-    .config_xen = false,
+#  define TARGET_INFO_CONFIG_XEN .config_xen = false,
 # endif
+# define TARGET_INFO_CONFIG \
+    TARGET_INFO_CONFIG_MULTIPROCESS \
+    TARGET_INFO_CONFIG_NITRO \
+    TARGET_INFO_CONFIG_XEN
+#else
+# define TARGET_INFO_CONFIG
 #endif
+
+#define TARGET_INFO_COMMON                                                  \
+    .target_name = TARGET_NAME,                                             \
+    .target_arch = glue(SYS_EMU_TARGET_, TARGET_ARCH),                      \
+    .long_bits = TARGET_LONG_BITS,                                          \
+    .cpu_type = CPU_RESOLVING_TYPE,                                         \
+    TARGET_INFO_PAGE_BITS                                                   \
+    TARGET_INFO_CONFIG
+
+#ifdef CONFIG_USER_ONLY
+static const TargetInfo target_info_def = {
+    TARGET_INFO_COMMON
+    .endianness = TARGET_BIG_ENDIAN ? ENDIAN_MODE_BIG : ENDIAN_MODE_LITTLE,
 };
 
 target_info_init(target_info_def)
+#else
+static const TargetInfo target_info_le = {
+    TARGET_INFO_COMMON
+    .endianness = ENDIAN_MODE_LITTLE,
+    .is_default = !TARGET_BIG_ENDIAN,
+};
+
+static const TargetInfo target_info_be = {
+    TARGET_INFO_COMMON
+    .endianness = ENDIAN_MODE_BIG,
+    .is_default = TARGET_BIG_ENDIAN,
+};
+
+target_info_init_le_be(target_info_le, target_info_be)
+#endif
diff --git a/target-info-qom.c b/target-info-qom.c
index 68ad734049c..2c1c57b05fd 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -90,13 +90,34 @@ const TargetInfo *target_info(void)
 void target_info_qom_set_target(void)
 {
     g_autoptr(GSList) targets = object_class_get_list(TYPE_TARGET_INFO, false);
-
+    const TargetInfo *chosen = NULL;
     size_t num_found = g_slist_length(targets);
-    if (num_found != 1) {
-        error_setg(&error_fatal, num_found == 0 ?
-                                 "no target-info is available" :
-                                 "more than one target-info is available");
+    size_t num_default = 0;
+
+    if (num_found == 0) {
+        error_setg(&error_fatal, "no target-info is available");
+    }
+
+    if (num_found == 1) {
+        target_info_ptr = TARGET_INFO_CLASS(targets->data)->target_info;
+        return;
+    }
+
+    for (GSList *l = targets; l; l = l->next) {
+        const TargetInfo *ti = TARGET_INFO_CLASS(l->data)->target_info;
+
+        if (ti->is_default) {
+            num_default++;
+            chosen = ti;
+        }
+    }
+
+    if (num_default != 1) {
+        error_setg(&error_fatal, num_default == 0 ?
+                                 "no default target-info is available" :
+                                 "more than one default target-info "
+                                 "is available");
     }
 
-    target_info_ptr = TARGET_INFO_CLASS(targets->data)->target_info;
+    target_info_ptr = chosen;
 }
-- 
2.52.0.windows.1



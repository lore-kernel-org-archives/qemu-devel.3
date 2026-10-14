Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1AFCC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 09:46:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGvZC-0000ND-0p; Wed, 14 Oct 2026 05:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvY2-00079M-3b
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:45:28 -0400
Received: from mail-dl1-x122a.google.com ([2607:f8b0:4864:20::122a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvXx-0002Uh-WA
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:45:20 -0400
Received: by mail-dl1-x122a.google.com with SMTP id
 a92af1059eb24-16079d54c17so4974392c88.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 02:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791971115; x=1792575915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3fUQiYjovRhBbOY9jZqr1EROLvDeVoIIJQ8l3JOg7Gk=;
 b=o/34U5nexp0IeGiAd6xIhWZn1RqnfgurT11nbZA+sNdlWRmCb9s9yUEQBAdUO4OSsM
 LcW5AVS4FTS5AROri3e4DBi1LkDouP3dvzXcB7mUCzB2RHXV/9lx4+Wtk3y8bJ3vxuYI
 O2rVItTdPTJIWqd7M6JsnNPrP33RsNr6rGZUtuuK6QMz6/VjE3NU70Q5kZHmQmkLheIe
 tZGBsV55VxcEWEDClTd/1tzohezaVpgbdltVxijJJWBXdtPHbR/Kc1kJetnGu5irLFOs
 dKmGNCsECjJUskOElpcEYDLi7Ky64LEJln9S8AmmLDs59X7s3jCjc9eDs/Oe/WYB6JIw
 rG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791971115; x=1792575915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3fUQiYjovRhBbOY9jZqr1EROLvDeVoIIJQ8l3JOg7Gk=;
 b=J5OZV5jWxQ0DHqNFpAw3MoB9tdUimUfdmZBqdlPIbz2nvbzPGF0n+9YBurZdnzIj0D
 aqvwoM3I+LJ0BGszbD1OrSVMT78nkrgjZz0d4QgulVC7/qs9S+kdb3qt8IkC2hI6usov
 z8dbwUlO1vZ9UtoZmhxu1dErCFuLVEMBajGpvc2XeS0m0T2DzCeJ8oHnmDerfyjAlymy
 Olz2yykHvG2ila7RrbsaceYJarttm2VVvlPSETnO9cokenl7F7cNnkTewh9eX0QCo7yJ
 d6Spmdg8qWwEo/X+f46Aq/IW0i08QMBAbYf+sAZXRXHh5EabGFjEr49/IMd+nM/VZOhb
 lsFg==
X-Gm-Message-State: AFq9FYITYCHNU9gyT0vsw2E3LHIynzFhWsO2LJWFFo1NGLQwowrCa7Ft
 rG9j7j+bPrEemchyNsF4Gk9w6pVVwHT4KCzb4rAAIvaW918LoINAkhz4mMQtDszX/y0=
X-Gm-Gg: AYBFou2CKnns5+wugVG23W5JzFgfzAUTAkVa5Yj9MSi/20khuKDiofQtKveTFId5jkG
 bS7cr6iSwvOHh9m0wWsNyrQdzf32WTVJ3V6xbyESX2CPtCKgitDktQYnow8a27ELqN8NBcjN4+m
 R7lTIbzRl4N5u6qqf3u7fhGt1qmMBBmvLWwyfqs22b4A0zqFnYHFjlu3pATyKYI3Yid44nXceg0
 y+TAK2U/inuel130K+oZcF8x+ke+jcXl5xeYOmsJooNkLsyKhLH+rUQ6gnQTZWXaK8gonfTI4NI
 /7kokLXnesrhMh2kpkq7pR+TsTDj2lLr0GSNoDtSzLjl3ZMbDPok3Y48J/ryCugLASY9dDwOAtd
 VFypf5ajqVqexYj0dFrk4HHgV+w1YGTvwC0KbnmDb7QRmEVcSxFRvpnWUeEEnnMO9lDeCUHiuAz
 12XsJoEIkxKn2Xi1DCTe6laKexDLrLGRynYm4h7K6f/luuSEz5KWIUD4Rb5SfH0w1TvTRSn84iU
 rZhIf6Julydgrm6DQ==
X-Received: by 2002:a05:701b:451c:20b0:14a:5d07:9b with SMTP id
 a92af1059eb24-16a5ea5d851mr19635817c88.28.1791971115165; 
 Wed, 14 Oct 2026 02:45:15 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-169a31f6f5csm44348380c88.11.2026.10.14.02.45.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 02:45:14 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Cornelia Huck <cohuck@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>, Eric Blake <eblake@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-s390x@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 David Hildenbrand <david@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alexander Bulekov <alxndr@bu.edu>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Fabiano Rosas <farosas@suse.de>,
 Song Gao <17746591750@163.com>, Fam Zheng <fam@euphon.net>,
 Markus Armbruster <armbru@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Chao Liu <chao.liu@processmission.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stafford Horne <shorne@gmail.com>
Subject: [PATCH 32/34] system/vl: select target from machine name in combined
 binaries
Date: Wed, 14 Oct 2026 17:41:47 +0800
Message-ID: <20261014094224.1976-17-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261014094224.1976-1-luoyonggang@gmail.com>
References: <20261014094224.1976-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122a;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x122a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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

Match -machine $target_arch-$machine_name against registered machine
names and aliases. Also accept -machine $machine_name when it uniquely
identifies a machine; report architecture-qualified choices when it is
ambiguous.

This do not change single-target behavior.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 system/vl.c | 133 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 124 insertions(+), 9 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index e2bd65ebd40..5d6ba08b591 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1205,6 +1205,77 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
     return 0;
 }
 
+static bool machine_target_matches(MachineClass *mc, const TargetInfo *ti,
+                                   const char *name)
+{
+    const char *names[] = { mc->name, mc->alias };
+
+    for (unsigned i = 0; i < ARRAY_SIZE(names); i++) {
+        if (names[i]) {
+            if (!strcmp(name, names[i])) {
+                return true;
+            }
+            g_autofree char *qualified =
+                g_strdup_printf("%s-%s", ti->target_name, names[i]);
+
+            if (!strcmp(name, qualified)) {
+                return true;
+            }
+        }
+    }
+    return false;
+}
+
+static MachineClass *machine_target_select(GSList *machines, GSList **targets,
+                                           const char *name, Error **errp)
+{
+    ERRP_GUARD();
+    MachineClass *machine = NULL;
+    const TargetInfo *target = NULL;
+    g_autoptr(GString) hints = g_string_new(NULL);
+    unsigned count = 0;
+    GSList *el;
+    GSList *tel;
+
+    *targets = object_class_get_list(TYPE_TARGET_INFO, false);
+    if (!name) {
+        return NULL;
+    }
+
+    for (el = machines; el; el = el->next) {
+        MachineClass *mc = el->data;
+
+        for (tel = *targets; tel; tel = tel->next) {
+            const TargetInfo *ti = TARGET_INFO_CLASS(tel->data)->target_info;
+
+            if ((mc->targets & QEMU_ARCH_BIT(ti->target_arch)) &&
+                machine_target_matches(mc, ti, name)) {
+                count++;
+                machine = mc;
+                target = ti;
+                g_string_append_printf(hints, "  -machine %s-%s\n",
+                                       ti->target_name, mc->name);
+            }
+        }
+    }
+    if (!count) {
+        error_setg(errp, "unsupported machine type: \"%s\"", name);
+        error_append_hint(errp, "Use -machine help to list supported names, "
+                          "then select <arch>-<machine-name> or an "
+                          "unambiguous <machine-name>\n");
+        return NULL;
+    }
+    if (count != 1) {
+        error_setg(errp, "machine name '%s' is ambiguous", name);
+        error_append_hint(errp, "Select an architecture-prefixed name:\n%s",
+                          hints->str);
+        return NULL;
+    }
+
+    target_info_qom_set_target_info(target);
+    return machine;
+}
+
 static int device_help_func(void *opaque, QemuOpts *opts, Error **errp)
 {
     return qdev_device_help(opts);
@@ -1565,16 +1636,23 @@ static gint machine_class_cmp(gconstpointer a, gconstpointer b, gpointer d)
 static void machine_help_func(const QDict *qdict)
 {
     g_autoptr(GSList) machines = NULL;
+    g_autoptr(GSList) targets = NULL;
     GSList *el;
+    GSList *tel;
     const char *type = qdict_get_try_str(qdict, "type");
+    MachineClass *machine_class = NULL;
 
     machines = object_class_get_list(TYPE_MACHINE, false);
-    if (type) {
-        ObjectClass *machine_class = OBJECT_CLASS(find_machine(type, machines));
-        if (machine_class) {
-            type_print_class_properties(object_class_get_name(machine_class));
-            return;
-        }
+    if (target_combined_binary()) {
+        machine_class = machine_target_select(machines, &targets, type,
+                                              &error_fatal);
+    } else if (type) {
+        machine_class = find_machine(type, machines);
+    }
+    if (machine_class) {
+        type_print_class_properties(
+            object_class_get_name(OBJECT_CLASS(machine_class)));
+        return;
     }
 
     printf("Supported machines are:\n");
@@ -1585,9 +1663,20 @@ static void machine_help_func(const QDict *qdict)
             printf("%-20s %s (alias of %s)\n", mc->alias, mc->desc, mc->name);
         }
         printf("%-20s %s%s%s%s\n", mc->name, mc->desc,
-               mc->is_default ? " (default)" : "",
+               mc->is_default && !target_combined_binary() ? " (default)" : "",
                mc->deprecation_reason ? " (deprecated)" : "",
                object_class_is_secure(OBJECT_CLASS(mc)) ? " (secure)" : "");
+        for (tel = targets; tel; tel = tel->next) {
+            const TargetInfo *ti = TARGET_INFO_CLASS(tel->data)->target_info;
+
+            if (mc->targets & QEMU_ARCH_BIT(ti->target_arch)) {
+                printf("  %s-%s\n", ti->target_name, mc->name);
+                if (mc->alias && strcmp(mc->name, mc->alias)) {
+                    printf("  %s-%s (alias)\n",
+                           ti->target_name, mc->alias);
+                }
+            }
+        }
     }
 }
 
@@ -1684,6 +1773,26 @@ static MachineClass *select_machine(QDict *qdict, Error **errp)
     g_autoptr(GSList) machines = object_class_get_list(TYPE_MACHINE, false);
     MachineClass *machine_class = NULL;
 
+    if (target_combined_binary()) {
+        g_autoptr(GSList) targets = NULL;
+
+        if (!machine_type) {
+            error_setg(errp, "No machine specified; combined binaries "
+                       "have no default machine");
+            error_append_hint(errp,
+                              "Use -machine help to list supported names, "
+                              "then select <arch>-<machine-name> or an "
+                              "unambiguous <machine-name>\n");
+            return NULL;
+        }
+        machine_class = machine_target_select(machines, &targets, machine_type,
+                                              errp);
+        if (machine_class) {
+            qdict_del(qdict, "type");
+        }
+        return machine_class;
+    }
+
     if (machine_type) {
         machine_class = find_machine(machine_type, machines);
         if (!machine_class) {
@@ -2913,10 +3022,16 @@ void qemu_init(int argc, char **argv)
     os_setup_limits();
 
     target_info_qom_init();
-    target_info_qom_set_target();
+    if (!target_combined_binary()) {
+        target_info_qom_set_target();
+    }
 
     module_init_info(qemu_modinfo);
-    module_allow_arch(target_name());
+    if (target_combined_binary()) {
+        module_allow_all_arch();
+    } else {
+        module_allow_arch(target_name());
+    }
 
     qemu_init_subsystems();
 
-- 
2.55.0.windows.3



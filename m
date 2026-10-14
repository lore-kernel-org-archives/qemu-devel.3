Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3162ECC6B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 09:43:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGvVx-0002rd-N9; Wed, 14 Oct 2026 05:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvVo-0002pH-10
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:43:04 -0400
Received: from mail-dl1-x122e.google.com ([2607:f8b0:4864:20::122e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvVk-0001jB-Qx
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:43:03 -0400
Received: by mail-dl1-x122e.google.com with SMTP id
 a92af1059eb24-14394530ec6so2727902c88.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 02:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791970977; x=1792575777; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zt4O6cH6itGslpdvLTM70yWl9Kh39depuXm/4+mt0R8=;
 b=NHrZtzHIs8RnobGPf0lzbyBkdd7kdrnqgT1MtydC/Wbk6pmYcc37R52uHJc1H+OGlx
 v7W1Q6GUuJxN+eGaGP5Jao8igP4HMZcyY+YiNzfklUlBGkO19PBhVbYaJud6EISAatuk
 zHkVmHcVJD/Mislf82d/UR7HnPjPDrvTRDc3ga0Uj8SNHT2jiB+S4J2MiQx5ICEF6mu5
 1Z7pc3ApiAElCoZzPCHEAMV++6WEcVm5VBY2i9PILhB/DN2h77a7dohRHc2EL7wp5DeW
 520wk1yDhmbnxMKiW73cCWrbwXaZJqc+Xqrrbb9DhF3zZ03VZzPu7qA2DsdIY96VfCTv
 QJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791970977; x=1792575777;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zt4O6cH6itGslpdvLTM70yWl9Kh39depuXm/4+mt0R8=;
 b=QxERrLK2EnN+n1KKxOqypl6r+SJ4Q8g05zV2xT2GXT5PxvWDcogzv4DPdh0JXQRW1D
 +C8MsuvbnpGtONatpfSLIIGZM3EORtwN7fkC5LLQ1TGXOlpllJAdKcM0hzHpvgMYDSQJ
 rvilut07PK7OU2NWf7rhQh0UpCaqYcV3PUfQo/DL+VBUcdjkQJ32e57k9i4hR6tPLImB
 ebGj7p2Voh+6wjl3QA0Vpsm2yXB2VlBRK3HY644B05RAyVXUUth9asN4oq0ArLjt3ONj
 bAArcpgysl1S+FVvvKZro0zhgfRjJyEcU4O4HVoEQCmxhyWUivTUwsdNglPnWxDQvdX9
 QmHg==
X-Gm-Message-State: AFq9FYLCW/EwvGy5Vn6qRbUhnsPQMNzL1k7UzYZMLuD8VjPbEu3QYlHs
 aABZn+PNI83JbOJqYV+Oz/6acKPh7JnLUHj5A+hg4Cd53kA0ZQwwnNgfAAlebSfJYe0=
X-Gm-Gg: AYBFou0JEP8ppBAmKFPOt3UzkFhvAkVpTryo0p/XvAIO9usr0Q92gh/ho3EikD2US4n
 gO8DxTxm8XoyZ9AGcaLj6rvk2zQE0ks/kURmJcPoyWwWbSo7XO9+dThL+NrIrL9TGaPSm9gmIUI
 YiUvcsKs3+QzQSBlNyQMuHCsWzKKcZdPuBT64mdbEvRZHkNmZQ5xOOalvXOfKosVMERt7LAmQi8
 1n9hmz2FvzCB7OAV6iB/8CjL9cDcK1nL2u4DxnjKJSRa5+f7hbngDT4z+6Q2RbEWxpQNHrcR5Xv
 8wkm9M3FK3ya1t7fkr6EI8Cr84kCuhaZley55HV882+iUBgSbIvfgiTu7HeTT4v+m5tNCbO3/pb
 kHprA6VNAT+tPKcFPTlQBFZWjRXHmgnUfR623lD1xXrmVm1TrJV5ipdeaXfi1DcHbZA4uESwxw4
 4P7+01NGdlSIY0HzjeYAeAiRJKbFPrijsDbZFwVbOpxedT7KasyakkXAFtVZi7kYCrSUqOW55Oe
 lfPs/cjRNMJbD+Gyw==
X-Received: by 2002:a05:701b:2705:b0:168:3243:c937 with SMTP id
 a92af1059eb24-16a5fc9167bmr20167003c88.16.1791970976589; 
 Wed, 14 Oct 2026 02:42:56 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-169a31f6f5csm44348380c88.11.2026.10.14.02.42.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 02:42:55 -0700 (PDT)
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
Subject: [PATCH 18/34] machine: allow -M name to differ from QOM type
Date: Wed, 14 Oct 2026 17:41:33 +0800
Message-ID: <20261014094224.1976-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261014094224.1976-1-luoyonggang@gmail.com>
References: <20261014094224.1976-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122e;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x122e.google.com
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

- Add machine_class_set_name() so boards can keep a stable -M name
  when the QOM type is uniquified. machine_class_base_init still
  defaults the name to the QOM type without -machine.
- Document that MachineClass::name is the -M name, not the QOM type.
- Sort -M help by MachineClass::name so order matches the printed names
  when QOM types are prefixed (arm-virt-11.1-machine vs virt-11.1).

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/core/machine.c        |  6 ++++++
 include/hw/core/boards.h | 12 +++++++++++-
 system/vl.c              |  8 +++-----
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 5c6f3cb0f68..bcf15079cb9 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1222,6 +1222,12 @@ static void machine_class_init(ObjectClass *oc, const void *data)
         "Memory size configuration");
 }
 
+void machine_class_set_name(MachineClass *mc, const char *name)
+{
+    g_free(mc->name);
+    mc->name = g_strdup(name);
+}
+
 static void machine_class_base_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index d7713c45836..6e5c8dac2d1 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -36,6 +36,16 @@ const char *machine_default_cpu_type(const MachineState *ms);
  * @mc: Machine class
  */
 const char *machine_class_default_cpu_type(MachineClass *mc);
+/**
+ * machine_class_set_name: Set the -M name when it differs from the QOM type
+ * @mc: Machine class
+ * @name: Name used by -M lookup, help, and migration
+ *
+ * machine_class_base_init sets MachineClass::name from the QOM type with
+ * the -machine suffix removed. Call this from board class_init when the
+ * CLI name must stay stable after the QOM type is uniquified.
+ */
+void machine_class_set_name(MachineClass *mc, const char *name);
 
 void machine_add_audiodev_property(MachineClass *mc);
 void machine_run_board_init(MachineState *machine, const char *mem_path, Error **errp);
@@ -274,7 +284,7 @@ struct MachineClass {
     /*< public >*/
 
     const char *family; /* NULL iff @name identifies a standalone machtype */
-    char *name;
+    char *name; /* -M name; default is QOM type without -machine */
     const char *alias;
     const char *desc;
     const char *deprecation_reason;
diff --git a/system/vl.c b/system/vl.c
index a7684abdd3a..e2bd65ebd40 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1538,10 +1538,9 @@ static gint machine_class_cmp(gconstpointer a, gconstpointer b, gpointer d)
     if (mc1->family == NULL) {
         if (mc2->family == NULL) {
             /* Compare standalone machine types against each other; they sort
-             * in increasing order.
+             * in increasing order by the name shown in -M help.
              */
-            return strcmp(object_class_get_name(OBJECT_CLASS(mc1)),
-                          object_class_get_name(OBJECT_CLASS(mc2)));
+            return strcmp(mc1->name, mc2->name);
         }
 
         /* Standalone machine types sort after families. */
@@ -1560,8 +1559,7 @@ static gint machine_class_cmp(gconstpointer a, gconstpointer b, gpointer d)
     }
 
     /* Within the same family, machine types sort in decreasing order. */
-    return strcmp(object_class_get_name(OBJECT_CLASS(mc2)),
-                  object_class_get_name(OBJECT_CLASS(mc1)));
+    return strcmp(mc2->name, mc1->name);
 }
 
 static void machine_help_func(const QDict *qdict)
-- 
2.55.0.windows.3



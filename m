Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B454C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 18:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzIav-00087i-PR; Wed, 26 Aug 2026 14:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wzIao-0007rH-W0
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:43:24 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wzIal-0002Lk-Ow
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:43:22 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-cc1cb472b76so745020a12.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 11:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787769798; x=1788374598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZjZZ5N5UC9MCFR7kDtXH3xc2F8y1ZsI5OCuFB7c1TUU=;
 b=A6JhOlkoOBXb64uMEyS4hKQMgZ4BJYp3RyRgrcZ63/OtYFvw3x3DflBEKTVYTpl7dd
 vgH7VHydn1C7aX/cS6+qVEseZKTt7hW0TUNYyLFbnvMclit2t/u4+lGswCjOf/Q1+Yxf
 To1Rag+Xow/MZNmD0FOhi0Hor3EjuMpUbJwKlDJ8P4ZGzaAywMNRn4MpPNrKlcpNprxf
 uxksRaO9Use/3TiCMXHLHtq+Su2OW1K5aUCCxKB+flu7VbQadFRFxJJxhopWo4ShTl4f
 Xy/yEfn4Hjr2KzfwycL55/PmnL/eGwlktMegyYDD8Ua60Iw0u1K9vb46HNNw6ULAxEtm
 1HeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787769798; x=1788374598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZjZZ5N5UC9MCFR7kDtXH3xc2F8y1ZsI5OCuFB7c1TUU=;
 b=Ik1xGXlyU02thvnL349Vngb1ZPvmo/HhFj36ai/JYrUnvNDoyPmvhfSuRCEAOAt8eC
 YFRUjx58FF8QcH+N2a8rZv+k8hnr0cuUCyjwhzAny5QLBrOgZ+AL5ZtKdY33Xzvod9Y4
 fnkh92Oyo2UPOnNQDHE+rNTsOfZzQb+i7jlFh179RdWAVZm7sEfUb/K8E9fMTZnIY8LB
 HD3XC5/wGhQ8LBiim5Jp2R8SqM/b+z9oWgSoRRYm1wE3n0aOkMBCiATZ9lmJAXGSq27s
 1FIkhsoXCH107M/qiLhU9bYZFA0im3nyZ+rDNywxP3qytRR9M8qE+29h5fAr11hQSIFX
 4bPw==
X-Gm-Message-State: AFuF++kfu8KabiEBIqkhMmJz6GzeXUc0bZ8OEQPq/uzvYTqFnNp6Ik1+
 6WTuIax2c5jEAt1zK9Skvgo+SEXII/5ycfVaktc+X+x0fQ8glm8D4RlfV/v1gNEWfuw=
X-Gm-Gg: AR+sD13auJ9RA0fb1tXjqEvvXKhEW34kDy7LFj49ZEP7v24ReXdBG9IDJ81VKqCW6VH
 z6fqRmmrURrO+vEYZyxbjNgO5a3sXdL6vvSGfNopzyeK7Oh9BfME99wsV55Te9Kvrb6wPIEbBMu
 zIPCEj3TwkBuqv+6NLpELo0jGVJ4KCBN9IcMFeMaHHbrdrC0yh3OFtEpBiG/wbF0Apq5PF2P86j
 mPTaxtBJPCookAZQf2ReLj8M0YQ/dw8PTYIq+AtdY0Iz4oCoiN/eeWGunP1LTVc3VDzCQVTGMpB
 5QhQa1VsfyPK7Vrxk3JGtNoBh0TM8FFsObMHkykRtRPYI+bpWoNgAE0r/SqDmx2f+z8LHgchGaZ
 eTkM9hC6hXXenIMhYpms9mU5ChRcABRod7QUNCYKIvL0NJB3vHH7Ss4f4s6ntYUEd/KCQSw3fgN
 oCw8ZktcXd5arLhGmj1Swgfip93e4yQ+HHQ89g+fJWvzCxUa+Ou/7VJZ4uGpmSqSBEZ8j8QrlRp
 FEpzzRR66OwJo1ttGZWZw==
X-Received: by 2002:a05:6a21:6191:b0:3cc:ad3e:bd7e with SMTP id
 adf61e73a8af0-3cf8465a5cemr19927922637.14.1787769798331; 
 Wed, 26 Aug 2026 11:43:18 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-3283d60c291sm17681846eec.6.2026.08.26.11.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 11:43:17 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-riscv@nongnu.org,
 Song Gao <17746591750@163.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-ppc@nongnu.org,
 Xianglai Li <lixianglai@loongson.cn>, David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Bibo Mao <maobibo@loongson.cn>,
 Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Alexander Bulekov <alxndr@bu.edu>, Chao Liu <chao.liu@processmission.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <lvivier@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-arm@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Ani Sinha <anisinha@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PATCH v2 04/13] machine: allow -M name to differ from QOM type
Date: Thu, 27 Aug 2026 02:42:18 +0800
Message-ID: <20260826184229.1145-5-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260826184229.1145-1-luoyonggang@gmail.com>
References: <20260826184229.1145-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x532.google.com
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
---
 hw/core/machine.c        |  6 ++++++
 include/hw/core/boards.h | 12 +++++++++++-
 system/vl.c              |  8 +++-----
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 73b4d82b4a1..082f95e4349 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1209,6 +1209,12 @@ static void machine_class_init(ObjectClass *oc, const void *data)
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
index c963e956157..cb6a37235a2 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -37,6 +37,16 @@ const char *machine_default_cpu_type(const MachineState *ms);
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
@@ -270,7 +280,7 @@ struct MachineClass {
     /*< public >*/
 
     const char *family; /* NULL iff @name identifies a standalone machtype */
-    char *name;
+    char *name; /* -M name; default is QOM type without -machine */
     const char *alias;
     const char *desc;
     const char *deprecation_reason;
diff --git a/system/vl.c b/system/vl.c
index 83b9425de9b..4b1fcd2031f 100644
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
2.52.0.windows.1



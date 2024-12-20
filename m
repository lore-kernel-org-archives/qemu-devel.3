Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE01BE7718C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfgA-0006Jo-5S; Fri, 20 Dec 2024 11:16:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfg5-0006F8-By
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:16:37 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfg3-0007E3-IH
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:16:37 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4362f61757fso20262045e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711394; x=1735316194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=55AKXx89HlzplcYp2oBjo0MnM9odtmQqSPwrBjg6+7I=;
 b=jJYYKhaTdx6ou52ilbFDy8KrLK1biBpUqt2swxgj9oyoyPkmYH3jEYtFDsql7E87Rh
 POP1nXfUd/mzOtwssQcJ9PP+U7qwFfRv5qutSacrstLeYKe+OCOS8KWlyKsus1kfCbaJ
 YzLacUweNZjNdOYtLFXEv+r95KeIIaq6nCfuai6GNTdYsZoJy4CYFg8wcZKxLayUFAWU
 pHluGwMzwsW4kb4UVs/cJTrUhOJDwvRVtwKok8L/1nCEqUvzAaBuRwXD0e90HHjHW12Y
 P7R6sia38HZJKF+yuhfsw32LbOE3bM+Y1ulxbV7ft/NGPqQQ9mmluhzKncM5ryQ27aBH
 U1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711394; x=1735316194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=55AKXx89HlzplcYp2oBjo0MnM9odtmQqSPwrBjg6+7I=;
 b=UyJYCMnMkJYJBg7eYFCFZ/tm1TQs0UO8YTDu0OjQO/0Bf2UfePdPc1keFv/nT7z1TA
 L+AtuYqNqL2fbk+L8eTHnv0RhZozgT11Ke8GvzSmhocT0sZt49wYiuNSLhxQrGUnMEXO
 do2Y1ODucTvW/xvYaaonjT+PZS9fsxk+VVjoYb2fh1fRdaKlN28Sywm1saZ0HUCyH70W
 V9wiktOHg7cTYwDFIW8wLk4fLrv3Li1N2O98ABlgWInYwg6LW4npulAqwI+DyJZcopA8
 fVJtHlQAABm2pRZ03Qn9KpyYAdGmBWKOzHe8uoFHfOgxK0PgxhMwI7PNGWxxi1J5FCF+
 ZczA==
X-Gm-Message-State: AOJu0Yz2NHpVQtZkWuakilJhzh4ZV75eCKfNBaDnqy+jm6eg7h7XpBSC
 OgLEa9I3trigaTg3Ey5WcjCXc3Qjd9oMbSvWXVxeAaWUxBV9taNABadI3cYBDoUXDq6eeicp4c+
 z
X-Gm-Gg: ASbGncspBCUCqc+kd4RttR4zKQeU/67d8s8OD0sImY4y89TTDS0Ni1cC37c5YE8bn+O
 jEevDF+nCtA2Bcz+BtFVMatE22qJvCHaRwom2obgsmalVQmZgRfXlOoBHk6qWtrKzRy26QceUk+
 7Y0sT8TtTKk+QwoYUhv9F9034RGE/4zoYY8cZ1v4YAS0ZmjwlLhagbcBh8rmU5bI/sK3xKedsNZ
 wYdtC7oBn50xLZPZTyossU8snmyde0hiq03jyqjRNjNiCuHc4Sd0C37wM/FEaC9vVR4VUC4NW0=
X-Google-Smtp-Source: AGHT+IHEPXLNfcnqbyjB7U2V8CIDP16ggmfGb8R1MuiJwUhSiQucR5vFObtdwEklpNlVW5x0L/n/hA==
X-Received: by 2002:a05:600c:3150:b0:436:17e4:ad4c with SMTP id
 5b1f17b1804b1-4366835ebefmr29582145e9.6.1734711393829; 
 Fri, 20 Dec 2024 08:16:33 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b013ecsm83764965e9.16.2024.12.20.08.16.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:16:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/59] qom: Create system containers explicitly
Date: Fri, 20 Dec 2024 17:15:00 +0100
Message-ID: <20241220161551.89317-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Peter Xu <peterx@redhat.com>

Always explicitly create QEMU system containers upfront.

Root containers will be created when trying to fetch the root object the
1st time.  They are:

  /objects
  /chardevs
  /backend

Machine sub-containers will be created only until machine is being
initialized.  They are:

  /machine/unattached
  /machine/peripheral
  /machine/peripheral-anon

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241121192202.4155849-8-peterx@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/machine.c |  3 ---
 qom/object.c      | 24 +++++++++++++++++++++++-
 system/vl.c       | 16 ++++++++++++++++
 3 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index d970f753e37..3d734f8c18d 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1229,9 +1229,6 @@ static void machine_initfn(Object *obj)
     MachineState *ms = MACHINE(obj);
     MachineClass *mc = MACHINE_GET_CLASS(obj);
 
-    container_get(obj, "/peripheral");
-    container_get(obj, "/peripheral-anon");
-
     ms->dump_guest_core = true;
     ms->mem_merge = (QEMU_MADV_MERGEABLE != QEMU_MADV_INVALID);
     ms->enable_graphics = true;
diff --git a/qom/object.c b/qom/object.c
index c9f8442b136..b4c52d055d9 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1729,12 +1729,34 @@ const char *object_property_get_type(Object *obj, const char *name, Error **errp
     return prop->type;
 }
 
+static const char *const root_containers[] = {
+    "chardevs",
+    "objects",
+    "backend"
+};
+
+static Object *object_root_initialize(void)
+{
+    Object *root = object_new(TYPE_CONTAINER);
+    int i;
+
+    /*
+     * Create all QEMU system containers.  "machine" and its sub-containers
+     * are only created when machine initializes (qemu_create_machine()).
+     */
+    for (i = 0; i < ARRAY_SIZE(root_containers); i++) {
+        object_property_add_new_container(root, root_containers[i]);
+    }
+
+    return root;
+}
+
 Object *object_get_root(void)
 {
     static Object *root;
 
     if (!root) {
-        root = object_new(TYPE_CONTAINER);
+        root = object_root_initialize();
     }
 
     return root;
diff --git a/system/vl.c b/system/vl.c
index 09202b57e73..85fcc8f96e6 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2113,6 +2113,21 @@ static void parse_memory_options(void)
     loc_pop(&loc);
 }
 
+static const char *const machine_containers[] = {
+    "unattached",
+    "peripheral",
+    "peripheral-anon"
+};
+
+static void qemu_create_machine_containers(Object *machine)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(machine_containers); i++) {
+        object_property_add_new_container(machine, machine_containers[i]);
+    }
+}
+
 static void qemu_create_machine(QDict *qdict)
 {
     MachineClass *machine_class = select_machine(qdict, &error_fatal);
@@ -2121,6 +2136,7 @@ static void qemu_create_machine(QDict *qdict)
     current_machine = MACHINE(object_new_with_class(OBJECT_CLASS(machine_class)));
     object_property_add_child(object_get_root(), "machine",
                               OBJECT(current_machine));
+    qemu_create_machine_containers(OBJECT(current_machine));
     object_property_add_child(container_get(OBJECT(current_machine),
                                             "/unattached"),
                               "sysbus", OBJECT(sysbus_get_default()));
-- 
2.47.1



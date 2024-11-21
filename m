Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12205E64007
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 19:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tECkw-0006Nl-C0; Thu, 21 Nov 2024 14:22:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tECku-0006N7-Td
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:22:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tECkt-0002XF-GE
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:22:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732216938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6wi3a24EwlWSm8KKlUNodK3qOGR7+qV5BdxljVXUq0A=;
 b=JXelRqa7qtpmbtKU6KcCNyh/EPz4TEf3akaZbtjAUZCOzgHk7F05IOR1isKNgQEEcMTGXE
 aWwh6gk0TU4N3Ac1XNtCmCt7KI6BhKAtbGRwiS8a+I9gTh9LyvV9ySet6WKMUI/c5hxxgN
 dAYFaY+WYG4MijHpeSiZOO14fYkKqbk=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-6G1CYKsPPYWa_qnNXqmg4A-1; Thu, 21 Nov 2024 14:22:17 -0500
X-MC-Unique: 6G1CYKsPPYWa_qnNXqmg4A-1
X-Mimecast-MFC-AGG-ID: 6G1CYKsPPYWa_qnNXqmg4A
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-83ab369a523so126960439f.3
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 11:22:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732216936; x=1732821736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6wi3a24EwlWSm8KKlUNodK3qOGR7+qV5BdxljVXUq0A=;
 b=ceAFLYe8dyoV4/MER1DXyN54BjNe1xdQqbrL/fL2P6kRJ6HUJxSDME8YbnLVozjQa0
 wDwF64uZak5zusRGjdx3Ad/8mUBVYYGza4ez6WIx8j8Lifiue3mR+wWqewO9rUSEhlUh
 sXZW1YiTxVwlVfgOqXIbNIwluysof7SbHCIiLSgk8kDHQDCQM0BJMlgoClyskDZZoyiu
 fhg/oN2R054lGtUpgrPBLVXazHj73ar/3oJdmMlzOGPc4mCEYvHHcrYkrRsNwg2uMn4t
 GptZt0tZmO2oXObpAcLDKJx8NauPHypSrmAzPyvfOYzwWjtw4QItt5Ay9mvnFTUipmas
 kCSw==
X-Gm-Message-State: AOJu0Yzhg+5ZdGaUnqbDt+GS+QaWMSAE9jA1Y8ClR96UackmWn8ptUpZ
 XXkHJ8uvWVytkJQgZ3TN43BvQUrOERI8VK621KC/lLk3iB9fnt/f73JuIR6eUtfNRQlCxD2zQMP
 BFu1s+fVIHAFuWnx2vTKbe1DkwIewRpF6Z4d0XKPkVyzHn4FyfGMtrAYxYFm2igwjXzmOF1OaHo
 RespSLtVcASOmItiq8LWW57KrA6o0YtHassQ==
X-Gm-Gg: ASbGncvwjgcAuiaCtXTj2tfZ4c6AAH698NZ+QHTLJLg3x/cZ9vAuopgLLrqUYzF9seF
 MytPxtFcNJ3cH6vstSpxvybkoR++KGLD8I/hlR1tlaoYVl/3l+v2728yZKZLa6gYnq2Ov97BAMn
 wLKzH/wAnSiiUydj1Sfxtekss3f5AN0jQ64Yszygj8IMW+YQkU0tqQHjBL0pP+qPbkMzYO8SqX2
 DtPVlN5XMEM35Dsc7j6HD6iznOu2Bsi9fxmtobgKr47e6XVGoLnK5N0YAzeDHYdcqan+WMs+I/q
 iLX4Rk+hvtj6B/ap1hoGs8ClMA==
X-Received: by 2002:a05:6602:164d:b0:83a:b98e:9240 with SMTP id
 ca18e2360f4ac-83ecdd0751bmr6807339f.10.1732216936482; 
 Thu, 21 Nov 2024 11:22:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJ2nr+VQz8EEpvGGMyts+ZkYQGr3pmeRUDUDSvsyNCf9o4CqS30t7FCPl8FyT1JWnu5ol00g==
X-Received: by 2002:a05:6602:164d:b0:83a:b98e:9240 with SMTP id
 ca18e2360f4ac-83ecdd0751bmr6804739f.10.1732216936148; 
 Thu, 21 Nov 2024 11:22:16 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e1cfe345f0sm102939173.45.2024.11.21.11.22.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 11:22:15 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 07/13] qom: Create system containers explicitly
Date: Thu, 21 Nov 2024 14:21:56 -0500
Message-ID: <20241121192202.4155849-8-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241121192202.4155849-1-peterx@redhat.com>
References: <20241121192202.4155849-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
---
 hw/core/machine.c |  3 ---
 qom/object.c      | 24 +++++++++++++++++++++++-
 system/vl.c       | 16 ++++++++++++++++
 3 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index a35c4a8fae..a72c001c3d 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1198,9 +1198,6 @@ static void machine_initfn(Object *obj)
     MachineState *ms = MACHINE(obj);
     MachineClass *mc = MACHINE_GET_CLASS(obj);
 
-    container_get(obj, "/peripheral");
-    container_get(obj, "/peripheral-anon");
-
     ms->dump_guest_core = true;
     ms->mem_merge = (QEMU_MADV_MERGEABLE != QEMU_MADV_INVALID);
     ms->enable_graphics = true;
diff --git a/qom/object.c b/qom/object.c
index 214d6eb4c1..2fb0b8418e 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1734,12 +1734,34 @@ const char *object_property_get_type(Object *obj, const char *name, Error **errp
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
index 3bb8f2db9a..15e35162c6 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2112,6 +2112,21 @@ static void parse_memory_options(void)
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
@@ -2120,6 +2135,7 @@ static void qemu_create_machine(QDict *qdict)
     current_machine = MACHINE(object_new_with_class(OBJECT_CLASS(machine_class)));
     object_property_add_child(object_get_root(), "machine",
                               OBJECT(current_machine));
+    qemu_create_machine_containers(OBJECT(current_machine));
     object_property_add_child(container_get(OBJECT(current_machine),
                                             "/unattached"),
                               "sysbus", OBJECT(sysbus_get_default()));
-- 
2.45.0



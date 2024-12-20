Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A2A2E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:18:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfg5-0006F3-Ew; Fri, 20 Dec 2024 11:16:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfg0-00065u-NE
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:16:35 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOffy-00078V-WB
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:16:32 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-434b3e32e9dso22642255e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711389; x=1735316189; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=39Stqqln0eIwK3ikIDeW6/zeaX2x6CtdpFdvigljE7Q=;
 b=riY5FcO0xnsqbS1MkSXZ8UCqkWO0HhG4RYj3zFKrd6qn6IEURf9aNAwUv4th8vD9GM
 MiJtCPY7PPFkJFtSt2u6KbWHk0uCxteA3x2jUQFZVXEZ6PEEfV3BU99a4BCm42jPZV+k
 3A7wpkvG8qBLGsxY/OoXRVADUn4f8yJDrHUT2FMYjd9dXJ4x6LOswn55V0a/uD1Be80E
 GPQBc3Nz9Xdj1R5VRAifQcvjIYfV7vrzi+cdd221HTruD4nzWqMuXRDZp/IX0SOs3iwl
 0ilg+KYtXp0oIvYFd3Y8/tLfGogLnVHp8rJn5/PUcsTpd0sBxXovt/1w8oIbYELMf/EY
 mr2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711389; x=1735316189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=39Stqqln0eIwK3ikIDeW6/zeaX2x6CtdpFdvigljE7Q=;
 b=n8OtqBxK5fCvotJ+CCzr+8R/lFyOOjyRhUY7sBmgyMyvLiM9e0ac6ei63pEMBUI0AW
 pSzdbTN3dnWrwf7q1TltDRIgTXE+FJixXPITuZD6SXr8R1Oq5Nhb04Nf6o902Cd3VBt7
 GDiRM+heC2+/8YT6UsZCpLJMgtLEWEwrPfZAeUJ8JKVdtpJDCdcrdIz4H9Eemg9LaBb1
 EInMEVrVVrCVULpHlxNcj+nj7+Ulpqh1f5namscBEu3UwAVH7xkt+r4aAG6NOQjQfZ1e
 rMsOmMbeZgfYcmXO6ZSrKlG//tryO7NfvfT/GWLOTiMbNLw7sN6uJqncmTNL3MZgtn8i
 kMug==
X-Gm-Message-State: AOJu0Yy022w37vpKBEhZ4x422uJeJn1s4hz0dlNM5WHwtMa4/WNBzvv9
 7qxtm9c1JdGZnkC3PNq+ms15UCRNaK6UqmDqpmgbzXmMq85OVpl2olm4HLCltzk6D+ip4O0JhQb
 b
X-Gm-Gg: ASbGncsWXXTkkwDBdHDsHK4/qBgPkDQ60aJe0CU2fG9LO40N+/ArjMt7ZXMedjHEYDw
 UJ6HkogaVPsD1sckjGYZ5ZzghzKjUL9/kMJTeLUazOcmmiSeXqWR4LFwHqs32LJDxGZn7VOtre/
 qD2Ibz8Zb2T+31v8gqJNldJ5acou8nBmAewKYLo+tkKI/zQHnmxwFUxvFw91g//R84SVwW1dFAB
 fHlXdrsvNMePC3lIj2smXznYbQIi3ZoGq1nHLZBMZ9K9RmroN0yt0TcbfXD3d3yRE1Psv6rMuI=
X-Google-Smtp-Source: AGHT+IFN1G4FyN2lt1cGDzEC4SkhvFF6A7kKTtEMgkJpvtIE2YkMfEp/dAZIv1OOcQZuIRKzzNWqqA==
X-Received: by 2002:a05:600c:5254:b0:436:18e5:6917 with SMTP id
 5b1f17b1804b1-4366790f200mr37219925e9.0.1734711389265; 
 Fri, 20 Dec 2024 08:16:29 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43661200abesm49504195e9.18.2024.12.20.08.16.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:16:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/59] hw/ppc: Explicitly create the drc container
Date: Fri, 20 Dec 2024 17:14:59 +0100
Message-ID: <20241220161551.89317-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

QEMU will start to not rely on implicit creations of containers soon.  Make
PPC drc devices follow by explicitly create the container whenever a drc
device is realized, dropping container_get() calls.

No functional change intended.

Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-ppc@nongnu.org
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241121192202.4155849-7-peterx@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/spapr_drc.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 1484e3209d9..7868048bb9d 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -27,7 +27,7 @@
 #include "sysemu/reset.h"
 #include "trace.h"
 
-#define DRC_CONTAINER_PATH "/dr-connector"
+#define DRC_CONTAINER_PATH "dr-connector"
 #define DRC_INDEX_TYPE_SHIFT 28
 #define DRC_INDEX_ID_MASK ((1ULL << DRC_INDEX_TYPE_SHIFT) - 1)
 
@@ -514,6 +514,16 @@ static const VMStateDescription vmstate_spapr_drc = {
     }
 };
 
+static void drc_container_create(void)
+{
+    object_property_add_new_container(object_get_root(), DRC_CONTAINER_PATH);
+}
+
+static Object *drc_container_get(void)
+{
+    return object_resolve_path_component(object_get_root(), DRC_CONTAINER_PATH);
+}
+
 static void drc_realize(DeviceState *d, Error **errp)
 {
     SpaprDrc *drc = SPAPR_DR_CONNECTOR(d);
@@ -529,7 +539,7 @@ static void drc_realize(DeviceState *d, Error **errp)
      * inaccessible by the guest, since lookups rely on this path
      * existing in the composition tree
      */
-    root_container = container_get(object_get_root(), DRC_CONTAINER_PATH);
+    root_container = drc_container_get();
     child_name = object_get_canonical_path_component(OBJECT(drc));
     trace_spapr_drc_realize_child(spapr_drc_index(drc), child_name);
     object_property_add_alias(root_container, link_name,
@@ -543,12 +553,10 @@ static void drc_unrealize(DeviceState *d)
 {
     SpaprDrc *drc = SPAPR_DR_CONNECTOR(d);
     g_autofree gchar *name = g_strdup_printf("%x", spapr_drc_index(drc));
-    Object *root_container;
 
     trace_spapr_drc_unrealize(spapr_drc_index(drc));
     vmstate_unregister(VMSTATE_IF(drc), &vmstate_spapr_drc, drc);
-    root_container = container_get(object_get_root(), DRC_CONTAINER_PATH);
-    object_property_del(root_container, name);
+    object_property_del(drc_container_get(), name);
 }
 
 SpaprDrc *spapr_dr_connector_new(Object *owner, const char *type,
@@ -585,6 +593,8 @@ static void spapr_dr_connector_class_init(ObjectClass *k, void *data)
 {
     DeviceClass *dk = DEVICE_CLASS(k);
 
+    drc_container_create();
+
     dk->realize = drc_realize;
     dk->unrealize = drc_unrealize;
     /*
@@ -796,9 +806,8 @@ static const TypeInfo spapr_drc_pmem_info = {
 SpaprDrc *spapr_drc_by_index(uint32_t index)
 {
     Object *obj;
-    g_autofree gchar *name = g_strdup_printf("%s/%x", DRC_CONTAINER_PATH,
-                                             index);
-    obj = object_resolve_path(name, NULL);
+    g_autofree gchar *name = g_strdup_printf("%x", index);
+    obj = object_resolve_path_component(drc_container_get(), name);
 
     return !obj ? NULL : SPAPR_DR_CONNECTOR(obj);
 }
@@ -860,7 +869,7 @@ int spapr_dt_drc(void *fdt, int offset, Object *owner, uint32_t drc_type_mask)
     /* aliases for all DRConnector objects will be rooted in QOM
      * composition tree at DRC_CONTAINER_PATH
      */
-    root_container = container_get(object_get_root(), DRC_CONTAINER_PATH);
+    root_container = drc_container_get();
 
     object_property_iter_init(&iter, root_container);
     while ((prop = object_property_iter_next(&iter))) {
@@ -953,7 +962,7 @@ void spapr_drc_reset_all(SpaprMachineState *spapr)
     ObjectProperty *prop;
     ObjectPropertyIterator iter;
 
-    drc_container = container_get(object_get_root(), DRC_CONTAINER_PATH);
+    drc_container = drc_container_get();
 restart:
     object_property_iter_init(&iter, drc_container);
     while ((prop = object_property_iter_next(&iter))) {
-- 
2.47.1



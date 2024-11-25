Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EACD9D59D67
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 20:06:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFfFH-00059g-1Y; Mon, 25 Nov 2024 14:59:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfFC-00054e-2M
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:38 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfF5-0004mi-Qh
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:37 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4349e4e252dso14143405e9.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 11:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732564770; x=1733169570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0m2/9HP5vLC3hqAB+yCWUJo/ObLxgmWN4DQPmhXmpqg=;
 b=IO8bh0b1Lg3AXHFPiZ6/vhc8JpJxzwzcq69+YD7LgchLqCEIieqhRLehBuMaVcQsB4
 nsaRitJjBLgw8oVq+B9W5AnGcBXzSJ2p1fKuI75sQ1+kAGOKhBpajXGgU4oEjjGqgkZG
 MfahVcLK3z79rfSKfIWk8TCkfDPyOaad9q8pUG+OnyMl+bGAe3TnuzsO7loVvOt7ztT9
 +4bveJ3pUDML1KiUS9PZfHA4qLjjxfJZIac9WtSel2VDo7DWxBzrj/U9yaPBMqLvanQE
 vgca284IxUu44O788y8jwEYd9MfXG5nhG0Z+mHBvyYw3xpmm34dSx6ne+m/A/R/2rhmL
 pzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732564770; x=1733169570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0m2/9HP5vLC3hqAB+yCWUJo/ObLxgmWN4DQPmhXmpqg=;
 b=I8BxnwzycCPrdj4X0sNVmFSHr6dWxsM5WgZTikzfVmx4uzXmxsMHUcoKdoQC86yQB+
 HBNdnoXjxaRA8aNy0dWLBacCSv51BKwSg4lZuwJv27KmNbcmE9j3++/R0Ct6fhho67UE
 mClAMlPI6RU7snAobsdZRnInE/+VIe3dfsRRPwqtnsJCT1Abg1wyuJQHfRxF9hsC10Gt
 zmXZcDJuuF8+GLtds3pjzVIydxf+/X/wvHNbrNmM0mavd8kC9KxOEe7lQ+sUipVeLlcf
 fESTwx9Ap6IJtwYV5suta09xdk1ghwpBL8xvHEDzlFKozdmQFCI9ZyNeN2/ZaqykgokO
 R/5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWbYW9r7dep4+4yKlhJhI4sPVOI4CIl23aNNJGxOirQcol2qL3ETZIIFVGbTBc/0OG7GNUJDKRWyyF@nongnu.org
X-Gm-Message-State: AOJu0YzWTIemlvN/zW6M9Kqlv4Ja6T4tAeHk/m7TRsTfGJuT8nYOC8Fa
 ol7ioXWt3O+ICBP5gaavtLd0WyN/E2ACuSrFp7QK7kcQwxpjafkQtJfkONf1cLw=
X-Gm-Gg: ASbGnctEikYbZSMMVeSycRtKD2/Z0mgsHGzHDNOF9BFOtpQlT9TiND1kWuF5fAoVOEU
 0rtzBZhfHtzFiPVTQOIBPPS9eGSWq3PuwTSI6i6dT60pSoiPaxLQz6CoMmZfYg9R9ZZk0QKKFLS
 sinO8heOTXdIYlWHETr4hivJOMI+ODRgZUHKAi4Q4/Li8nO+osSvr9AEMvXNEbxVen+lq5D72T7
 vyCCWnHe6GMXXygWjEEfy41txLZOw1D8Ji4kFjaYYFxFpgt5aaZtgUAE0cINzqe4cNL
X-Google-Smtp-Source: AGHT+IHIgHFWvVyyJCi5WA7qSU1TvSslIX+EBQ+ux7JHA9WcmEKKX7xGvPmRb34R9SzN6GO/cTMdzA==
X-Received: by 2002:a05:6000:2d08:b0:382:50d9:bc7c with SMTP id
 ffacd0b85a97d-38260be6bfamr7331722f8f.58.1732564770312; 
 Mon, 25 Nov 2024 11:59:30 -0800 (PST)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fd0fbdcsm11237971f8f.109.2024.11.25.11.59.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 11:59:30 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v3 10/26] target/arm/kvm-rme: Add Realm Personalization Value
 parameter
Date: Mon, 25 Nov 2024 19:56:09 +0000
Message-ID: <20241125195626.856992-12-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125195626.856992-2-jean-philippe@linaro.org>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x32c.google.com
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

The Realm Personalization Value (RPV) is provided by the user to
distinguish Realms that have the same initial measurement.

The user provides up to 64 hexadecimal bytes. They are stored into the
RPV in the same order, zero-padded on the right.

Cc: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Eduardo Habkost <eduardo@habkost.net>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v2->v3: Fix documentation
---
 qapi/qom.json        |  15 ++++++
 target/arm/kvm-rme.c | 111 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 126 insertions(+)

diff --git a/qapi/qom.json b/qapi/qom.json
index a8beeabf1f..f982850bca 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1068,6 +1068,19 @@
   'data': { '*cpu-affinity': ['uint16'],
             '*node-affinity': ['uint16'] } }
 
+##
+# @RmeGuestProperties:
+#
+# Properties for rme-guest objects.
+#
+# @personalization-value: Realm personalization value, as a 64-byte
+#     hex string. This optional parameter allows to uniquely identify
+#     the VM instance during attestation. (default: 0)
+#
+# Since: 9.3
+##
+{ 'struct': 'RmeGuestProperties',
+  'data': { '*personalization-value': 'str' } }
 
 ##
 # @ObjectType:
@@ -1121,6 +1134,7 @@
     { 'name': 'pr-manager-helper',
       'if': 'CONFIG_LINUX' },
     'qtest',
+    'rme-guest',
     'rng-builtin',
     'rng-egd',
     { 'name': 'rng-random',
@@ -1195,6 +1209,7 @@
       'pr-manager-helper':          { 'type': 'PrManagerHelperProperties',
                                       'if': 'CONFIG_LINUX' },
       'qtest':                      'QtestProperties',
+      'rme-guest':                  'RmeGuestProperties',
       'rng-builtin':                'RngProperties',
       'rng-egd':                    'RngEgdProperties',
       'rng-random':                 { 'type': 'RngRandomProperties',
diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index 83a29421df..0be55867ee 100644
--- a/target/arm/kvm-rme.c
+++ b/target/arm/kvm-rme.c
@@ -23,11 +23,15 @@ OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
 
 #define RME_PAGE_SIZE qemu_real_host_page_size()
 
+#define RME_MAX_CFG         1
+
 struct RmeGuest {
     ConfidentialGuestSupport parent_obj;
     Notifier rom_load_notifier;
     GSList *ram_regions;
 
+    uint8_t *personalization_value;
+
     hwaddr ram_base;
     size_t ram_size;
 };
@@ -43,6 +47,48 @@ typedef struct {
 
 static RmeGuest *rme_guest;
 
+static int rme_configure_one(RmeGuest *guest, uint32_t cfg, Error **errp)
+{
+    int ret;
+    const char *cfg_str;
+    struct kvm_cap_arm_rme_config_item args = {
+        .cfg = cfg,
+    };
+
+    switch (cfg) {
+    case KVM_CAP_ARM_RME_CFG_RPV:
+        if (!guest->personalization_value) {
+            return 0;
+        }
+        memcpy(args.rpv, guest->personalization_value, KVM_CAP_ARM_RME_RPV_SIZE);
+        cfg_str = "personalization value";
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    ret = kvm_vm_enable_cap(kvm_state, KVM_CAP_ARM_RME, 0,
+                            KVM_CAP_ARM_RME_CONFIG_REALM, (intptr_t)&args);
+    if (ret) {
+        error_setg_errno(errp, -ret, "failed to configure %s", cfg_str);
+    }
+    return ret;
+}
+
+static int rme_configure(Error **errp)
+{
+    int ret;
+    int cfg;
+
+    for (cfg = 0; cfg < RME_MAX_CFG; cfg++) {
+        ret = rme_configure_one(rme_guest, cfg, errp);
+        if (ret) {
+            return ret;
+        }
+    }
+    return 0;
+}
+
 static int rme_init_ram(hwaddr base, size_t size, Error **errp)
 {
     int ret;
@@ -123,6 +169,10 @@ static int rme_create_realm(Error **errp)
 {
     int ret;
 
+    if (rme_configure(errp)) {
+        return -1;
+    }
+
     ret = kvm_vm_enable_cap(kvm_state, KVM_CAP_ARM_RME, 0,
                             KVM_CAP_ARM_RME_CREATE_RD);
     if (ret) {
@@ -168,8 +218,69 @@ static void rme_vm_state_change(void *opaque, bool running, RunState state)
     }
 }
 
+static char *rme_get_rpv(Object *obj, Error **errp)
+{
+    RmeGuest *guest = RME_GUEST(obj);
+    GString *s;
+    int i;
+
+    if (!guest->personalization_value) {
+        return NULL;
+    }
+
+    s = g_string_sized_new(KVM_CAP_ARM_RME_RPV_SIZE * 2 + 1);
+
+    for (i = 0; i < KVM_CAP_ARM_RME_RPV_SIZE; i++) {
+        g_string_append_printf(s, "%02x", guest->personalization_value[i]);
+    }
+
+    return g_string_free(s, /* free_segment */ false);
+}
+
+static void rme_set_rpv(Object *obj, const char *value, Error **errp)
+{
+    RmeGuest *guest = RME_GUEST(obj);
+    size_t len = strlen(value);
+    uint8_t *out;
+    int i = 1;
+    int ret;
+
+    g_free(guest->personalization_value);
+    guest->personalization_value = out = g_malloc0(KVM_CAP_ARM_RME_RPV_SIZE);
+
+    /* Two chars per byte */
+    if (len > KVM_CAP_ARM_RME_RPV_SIZE * 2) {
+        error_setg(errp, "Realm Personalization Value is too large");
+        return;
+    }
+
+    /* First byte may have a single char */
+    if (len % 2) {
+        ret = sscanf(value, "%1hhx", out++);
+    } else {
+        ret = sscanf(value, "%2hhx", out++);
+        i++;
+    }
+    if (ret != 1) {
+        error_setg(errp, "Invalid Realm Personalization Value");
+        return;
+    }
+
+    for (; i < len; i += 2) {
+        ret = sscanf(value + i, "%2hhx", out++);
+        if (ret != 1) {
+            error_setg(errp, "Invalid Realm Personalization Value");
+            return;
+        }
+    }
+}
+
 static void rme_guest_class_init(ObjectClass *oc, void *data)
 {
+    object_class_property_add_str(oc, "personalization-value", rme_get_rpv,
+                                  rme_set_rpv);
+    object_class_property_set_description(oc, "personalization-value",
+            "Realm personalization value (512-bit hexadecimal number)");
 }
 
 static void rme_guest_init(Object *obj)
-- 
2.47.0



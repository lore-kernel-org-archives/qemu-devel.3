Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7302DD59D67
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 19:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFfFG-00058i-HM; Mon, 25 Nov 2024 14:59:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfFD-00056L-CK
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:39 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfF6-0004nV-Di
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:39 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-434a2033562so6798755e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 11:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732564771; x=1733169571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DFJSI53cHJ1N3Z+oLQAsbnNAF3KjE8o1K+yxUpabOQA=;
 b=EJy89L2tzAcoZnpAoYqpUW1MJEREfmJaTYG7P6j+GshhBsDZ9tnIPEqa1glCO0SzOc
 QtyEw/vcch53UsKDT4UBuB6zzEsji4ULKS2yjRUYa80aNcV7BScHvi57qd8v+198UTBQ
 Q9M67xAkUXehAcxIIZ2ZXuEolZTurw0kW4HMGsY0AO2EcbZbe9+qaYhrCFbsP9SMzu32
 VdkBn/Nu7FmDV35eiotqNCZZUhLAIttrSJrXMyaIkdKvc3UirQN+L25LDdUhvdhqo42V
 hwOm0yC7FHHKc4eUUFnJGZcuihbPhLyubmfmAarZLmfYbIhnuLsipxgTI3s6YFuBhfFT
 3BgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732564771; x=1733169571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DFJSI53cHJ1N3Z+oLQAsbnNAF3KjE8o1K+yxUpabOQA=;
 b=RKrC+TqUllAw4n//KCkqNxMB1I0LxPOat6BOJ572phfoXSKtXdnBaDzFE4r/TYmAAE
 Ht9J7VILa4kuVpSNZYgTBdFP4da6fgmGMplTTkynfRZDCNHk2TByW+aOoBuvF/9vWKpv
 1TRxJ5qd/wFCBN+5H/NxMbyWc11E9H/knJh2dYZzBuoD0VlsYdChpv77FwVTNl0SH3Bz
 BvOFFIpYQtBlAjeD4SM6HFLg/VAh54AdRyELX2NXVE/6XzGsBuIFwPL1jTkmew3ImWaD
 zUnnqMu0B2fOt/QFIeCc8zmH92aeXAEyj/N5SrHLngtSZJQLAlby6zyjU39sIt2aT043
 XKhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWixMgVltqW1rJ7Qg0QvUC4IXDlCdJNTMVvhOHhF4cshKc//dCCBrB/5Qd2bw7BEE/ZGx9tW8BpjSkB@nongnu.org
X-Gm-Message-State: AOJu0YzQK9Hd/AMQZyxgTXO+pQnUP4mQdPtU44CsQmDhJxSpQz0REVuI
 cW2jJBPHtFR63ZS8nUMPXqLIsKRyB4izNkCeQiffC46kvBmEzuGhDuCvo829B/VNZ/5Jf+Py+yx
 H
X-Gm-Gg: ASbGncuN0zQXFOq01aYzzohXeso3swhKgKyN6EOoplSiW9efAkEaRFrJyNR/XhJSi3V
 RHqCGpVPsGdCb+I5psu/6coq6aIs3YdWpVMfjJXzStI5bZk4aHxKXK5urDDspzcwOTmtU5dyWX/
 X7IcvXJoNvCWWQOj9xbInAWh0mVVrDVeVrLcMu6SLI1dHgL5EV0siRQKpIUPAkpu6umCAo7TsM0
 3TYY/tIj17POStMNqY5ZbefgBBDBpbpaKq8CoR5RymjACLMoQxWREdbpTR78wlGbl88
X-Google-Smtp-Source: AGHT+IFReC0jAoBg3T5lkRnllyjlOiG9tzJlifErfsEXB7qfxFxhKbbca1oQPz7uQOdlOYwByoQPlw==
X-Received: by 2002:a05:600c:1990:b0:434:a555:d0d with SMTP id
 5b1f17b1804b1-434a5551bbamr2381835e9.29.1732564770965; 
 Mon, 25 Nov 2024 11:59:30 -0800 (PST)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fd0fbdcsm11237971f8f.109.2024.11.25.11.59.30
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
Subject: [PATCH v3 11/26] target/arm/kvm-rme: Add measurement algorithm
 property
Date: Mon, 25 Nov 2024 19:56:10 +0000
Message-ID: <20241125195626.856992-13-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125195626.856992-2-jean-philippe@linaro.org>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x334.google.com
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

This option selects which measurement algorithm to use for attestation.
Supported values are SHA256 and SHA512. Default to SHA512 arbitrarily.

SHA512 is generally faster on 64-bit architectures. On a few arm64 CPUs
I tested SHA256 is much faster, but that's most likely because they only
support acceleration via FEAT_SHA256 (Armv8.0) and not FEAT_SHA512
(Armv8.2). Future CPUs supporting RME are likely to also support
FEAT_SHA512.

Cc: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Eduardo Habkost <eduardo@habkost.net>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v2->v3: Rename measurement-algorithm
---
 qapi/qom.json        | 20 +++++++++++++++++++-
 target/arm/kvm-rme.c | 39 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index f982850bca..901ba67634 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1068,6 +1068,20 @@
   'data': { '*cpu-affinity': ['uint16'],
             '*node-affinity': ['uint16'] } }
 
+##
+# @RmeGuestMeasurementAlgorithm:
+#
+# @sha256: Use the SHA256 algorithm
+#
+# @sha512: Use the SHA512 algorithm
+#
+# Algorithm to use for realm measurements
+#
+# Since: 9.3
+##
+{ 'enum': 'RmeGuestMeasurementAlgorithm',
+  'data': ['sha256', 'sha512'] }
+
 ##
 # @RmeGuestProperties:
 #
@@ -1077,10 +1091,14 @@
 #     hex string. This optional parameter allows to uniquely identify
 #     the VM instance during attestation. (default: 0)
 #
+# @measurement-algorithm: Realm measurement algorithm
+#     (default: sha512)
+#
 # Since: 9.3
 ##
 { 'struct': 'RmeGuestProperties',
-  'data': { '*personalization-value': 'str' } }
+  'data': { '*personalization-value': 'str',
+            '*measurement-algorithm': 'RmeGuestMeasurementAlgorithm' } }
 
 ##
 # @ObjectType:
diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index 0be55867ee..bf0bcf9a38 100644
--- a/target/arm/kvm-rme.c
+++ b/target/arm/kvm-rme.c
@@ -23,7 +23,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
 
 #define RME_PAGE_SIZE qemu_real_host_page_size()
 
-#define RME_MAX_CFG         1
+#define RME_MAX_CFG         2
 
 struct RmeGuest {
     ConfidentialGuestSupport parent_obj;
@@ -31,6 +31,7 @@ struct RmeGuest {
     GSList *ram_regions;
 
     uint8_t *personalization_value;
+    RmeGuestMeasurementAlgorithm measurement_algo;
 
     hwaddr ram_base;
     size_t ram_size;
@@ -63,6 +64,19 @@ static int rme_configure_one(RmeGuest *guest, uint32_t cfg, Error **errp)
         memcpy(args.rpv, guest->personalization_value, KVM_CAP_ARM_RME_RPV_SIZE);
         cfg_str = "personalization value";
         break;
+    case KVM_CAP_ARM_RME_CFG_HASH_ALGO:
+        switch (guest->measurement_algo) {
+        case RME_GUEST_MEASUREMENT_ALGORITHM_SHA256:
+            args.hash_algo = KVM_CAP_ARM_RME_MEASUREMENT_ALGO_SHA256;
+            break;
+        case RME_GUEST_MEASUREMENT_ALGORITHM_SHA512:
+            args.hash_algo = KVM_CAP_ARM_RME_MEASUREMENT_ALGO_SHA512;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        cfg_str = "hash algorithm";
+        break;
     default:
         g_assert_not_reached();
     }
@@ -275,12 +289,34 @@ static void rme_set_rpv(Object *obj, const char *value, Error **errp)
     }
 }
 
+static int rme_get_measurement_algo(Object *obj, Error **errp)
+{
+    RmeGuest *guest = RME_GUEST(obj);
+
+    return guest->measurement_algo;
+}
+
+static void rme_set_measurement_algo(Object *obj, int algo, Error **errp)
+{
+    RmeGuest *guest = RME_GUEST(obj);
+
+    guest->measurement_algo = algo;
+}
+
 static void rme_guest_class_init(ObjectClass *oc, void *data)
 {
     object_class_property_add_str(oc, "personalization-value", rme_get_rpv,
                                   rme_set_rpv);
     object_class_property_set_description(oc, "personalization-value",
             "Realm personalization value (512-bit hexadecimal number)");
+
+    object_class_property_add_enum(oc, "measurement-algorithm",
+                                   "RmeGuestMeasurementAlgorithm",
+                                   &RmeGuestMeasurementAlgorithm_lookup,
+                                   rme_get_measurement_algo,
+                                   rme_set_measurement_algo);
+    object_class_property_set_description(oc, "measurement-algorithm",
+            "Realm measurement algorithm ('sha256', 'sha512')");
 }
 
 static void rme_guest_init(Object *obj)
@@ -290,6 +326,7 @@ static void rme_guest_init(Object *obj)
         exit(1);
     }
     rme_guest = RME_GUEST(obj);
+    rme_guest->measurement_algo = RME_GUEST_MEASUREMENT_ALGORITHM_SHA512;
 }
 
 static void rme_guest_finalize(Object *obj)
-- 
2.47.0



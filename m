Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE6ECD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:09:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZ9F-0005AG-Hq; Tue, 16 Jun 2026 15:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ7e-0004U5-DS
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:15 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ7b-0000tc-5r
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:06:53 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-490b7866869so50203145e9.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636809; x=1782241609; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+7Eo4SU78o6Ns7AfCRCkuFEyF7iTIz+MbUN5Y5O64T0=;
 b=lDTLZoAGVf+tcd960jsnBQXHKOeLsZH5x/w19H/HGsfqelmnqhFQr5i0o3eZZ/pxpB
 0T2qaD9Io6J6dVwoME3aLfW9PHTAjAls6HrFjCnI1Pl/Gb+5mBahl1/miBkWvuCeMGCK
 EC45nhm4w697GbLuKHH6h9hxgsHT056LcLBB4sOinSY4qBf8/kQoYcifcv09Ft+JdXIa
 aFG86R/eAkOg5xT556mKvnnxJwpBPLkZswVeuBllO1XT1XwBM52kI40JrVbEFjZcs5sQ
 P8ZmYi7n8aiGDZY+F6Tj3Pw6Mav3qRZ2uejDe63FsyLjIb1b7TMESv5nK4v8EOTavkc+
 izpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636809; x=1782241609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+7Eo4SU78o6Ns7AfCRCkuFEyF7iTIz+MbUN5Y5O64T0=;
 b=sSZP9nGzOpWz0ywL3o0S0FlT+UHsoWyPp/Q1GEGQmKNIXEw0+Zqb8+uaFAS1NY35DO
 6jHiWT6867pt6VAvGahX7bNfYXE6eGfbrlfE6YSI4ZWKaoOhbRvU35smGqUi4HF2LRI/
 ntrezJqVhHda0TbdgPDJ5UT+5pdSSUubRA2F5xxwESf/P54NBUpEhu3NGd39t8KraEMP
 NK3VCxxM+BP/oShY8IabAazrMQ8LwYAhXhVPgOIYu+pGgTGNZZBCcZn3GVz8ml41q6pz
 lJoWASP5ncUGMe6Eel7Izgy+VojeyghJ9xE1jVUnFdRN4xJGVW9xZ9GJ3Wquid0PEC/9
 etTw==
X-Gm-Message-State: AOJu0YxBP32Q8HziQEdsrWL3cAbTebYeSZj5xWWLvp7WSh8tdxgWsFOE
 n/gOeQ4FdinhogngXFGA7VH7+J25qnt5/Snsz6kuEjOR2H8Avp5kgZUk8MDM+S7jfuDhEOg/ry5
 GjhfD
X-Gm-Gg: Acq92OEMn9zaEDpW1oanC1ck8eTUA3b9ibzDzOCq72WLlX0qUxv6fZmfxctETY6H4bi
 XXPdoEuU6CVO3ooG1YfMivqeRs3yfYK0z3rXC8gXC5a94HE9Aou91QP5tEHLuWBt4Gdb75m158R
 JKQc2jlSgEqSHZ+nbYLQiw2YN6tkJwSCE6XMla+u2sCGNvFoN8sMvDAUc0PlG64kMCgu3OdhlPY
 boSivTRj5QAudVWRD+yZCoNCSIL6DyiyA0Zlx4bsi7SCaiO5KKnV25dD/QU/vmpIqTQrD7fiEMw
 0LbKXImY6xWoccL8+TJmgIobZmI8X49yNGWv0cs6AixNQ4oJe6/PUei0kSVi24rzT4rKoQjhHS0
 Pi0ydgFUT8ooN9xBZ+zsetssopcL+qAx/qGKgEPSr0wXqhRqkIf+F8XwpCXrwMV2iDKdpmBNioA
 UWjEVcBlcx9YSGCLjPk+ibLN916ZS0D9gqBsrKNdhf3SeNs9se1WCi1p4LAXQEDeIZtui86Vu3l
 KpIhHVXnGl30UVuyZMvzug8rbM+HUYb
X-Received: by 2002:a05:600c:8184:b0:490:625e:bb68 with SMTP id
 5b1f17b1804b1-4923339f885mr14992975e9.3.1781636809250; 
 Tue, 16 Jun 2026 12:06:49 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.06.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:06:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/61] hw/arm/smmuv3-accel: Implement "auto" value for "oas"
Date: Tue, 16 Jun 2026 20:05:44 +0100
Message-ID: <20260616190639.3462006-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

From: Nathan Chen <nathanc@nvidia.com>

Allow accelerated SMMUv3 OAS property to be derived from host IOMMU
capabilities. Derive host values using IOMMU_GET_HW_INFO, retrieving
OAS from IDR5.

This keeps the OAS value advertised by the virtual SMMU compatible with
the capabilities of the host SMMUv3, so that the intermediate physical
addresses (IPA) consumed by host SMMU for stage-2 translation do not
exceed the host's max supported IPA size.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20260608174900.2227340-8-nathanc@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-accel.c |  8 +++++++-
 hw/arm/smmuv3.c       | 17 ++++++++++-------
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 3f141991eb..06dadf9cc7 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -68,6 +68,11 @@ static void smmuv3_accel_auto_finalise(SMMUv3State *s,
                                FIELD_EX32(info->idr[1], IDR1, SSIDSIZE));
     }
 
+    if (s->oas == OAS_MODE_AUTO) {
+        s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS,
+                               FIELD_EX32(info->idr[5], IDR5, OAS));
+    }
+
     accel->auto_finalised = true;
 }
 
@@ -985,7 +990,8 @@ bool smmuv3_accel_init(SMMUv3State *s, Error **errp)
 
     if (s->ats == ON_OFF_AUTO_AUTO ||
         s->ril == ON_OFF_AUTO_AUTO ||
-        s->ssidsize == SSID_SIZE_MODE_AUTO) {
+        s->ssidsize == SSID_SIZE_MODE_AUTO ||
+        s->oas == OAS_MODE_AUTO) {
         s->s_accel->auto_mode = true;
     }
 
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index d59931d1a7..89289ab6d2 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1968,9 +1968,11 @@ static void smmu_reset_exit(Object *obj, ResetType type)
 
 static bool smmu_validate_property(SMMUv3State *s, Error **errp)
 {
-    if (s->oas != OAS_MODE_44 && s->oas != OAS_MODE_48) {
-        error_setg(errp, "QEMU SMMUv3 model only implements 44 and 48 bit"
-                   "OAS; other OasMode values are not supported");
+    if (s->oas != OAS_MODE_44 && s->oas != OAS_MODE_48 &&
+        s->oas != OAS_MODE_AUTO) {
+        error_setg(errp, "QEMU SMMUv3 model only implements auto, "
+                   "44 bit, or 48 bit OAS. Other OasMode values are "
+                   "not supported.");
         return false;
     }
 
@@ -1984,7 +1986,7 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
             return false;
         }
         if (s->oas > OAS_MODE_44) {
-            error_setg(errp, "OAS must be 44 bits when accel=off");
+            error_setg(errp, "oas must be 44 bits when accel=off");
             return false;
         }
         if (s->ssidsize > SSID_SIZE_MODE_0) {
@@ -2171,9 +2173,10 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "Please ensure host platform supports ATS before setting it "
         "to on.");
     object_class_property_set_description(klass, "oas",
-        "Specify Output Address Size (for accel=on). Supported values "
-        "are 44 or 48 bits. Defaults to 44 bits. oas=auto is not "
-        "supported.");
+        "Set Output Address Size in bits (for accel=on). "
+        "Valid values are 44, 48, and auto. Defaults to 44 bits."
+        "Please ensure the value does not exceed the maximum "
+        "Output Address Size supported by the host platform.");
     object_class_property_set_description(klass, "ssidsize",
         "Set number of bits used to represent SubstreamIDs (SSIDs). "
         "Valid values are 0-20 and auto. Defaults to 0. "
-- 
2.43.0



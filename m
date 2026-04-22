Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF109FA1FEC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:06:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdme-0005HN-VV; Wed, 22 Apr 2026 16:02:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdlr-0004Jl-2w
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:02:07 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdlp-00039N-DO
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:02:02 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso61296605e9.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 13:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776888119; x=1777492919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FGWUqnekPtGd8GYqKaTYj2Uvkrw/01LXnqQh3k67lwg=;
 b=Cfr+p2cS/vZSzv6Swp5wFyMyxeJfTq3/S3A8YzD/CXcRthpgj8S9P6eqTC5aREM0v4
 HmaiGH5E5d8yDp7p3uPZuwmtbaE1GrgSdniu3/7SoetDw5eKvTDkM6m2/do0O2dJStsl
 YmdxO1gkcPSknHPh/lRLCX2fGYKOBXw/6SuIpZQL3UuSXPVrKpe9fSWiQJ+7quK1xa3V
 neL4rpXc3ipB8vWmu0kLM6pAW9F9FMNT8egm2GP/ARQ7WtVA8cBzbEyexGXYAXbClOpp
 Aq1Ay0zMYdCv2htxsqgMmMVYP8ye2zyTpae4ChNyIPBT2MYkiDUdekzN58oPeFVGOJzh
 TUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776888119; x=1777492919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FGWUqnekPtGd8GYqKaTYj2Uvkrw/01LXnqQh3k67lwg=;
 b=pp8IGR8W/kwsTRCI/ITQwm7U19kygI3ohqHZupFd5dl81e39l4BJDnJzTCuRzYqNjG
 V9Iv+l72X3cDcgP9OA4nrzF81x9Aigr4nMMaPzLDcnEyuHGWpKMCEeKCPz3qIpTXjIdd
 KAs4edIiE1N7iW2JwEe3awHQdEEBJoVeElnqEnu9lzY8YJG9qHwyHo5MDmQHYtz4W5kH
 0zsXhiJyMaHwxhYud6LXl717f3n2QzRReAFWsjPiWzxBue+MBRKIHGV639cIk8JCLj4M
 wFi0dh4/OsH2QzLV0yqnlL2U9R5YclF6qT9zrfwiUYkH5Q73CxjjlMo2KHrC2woWTmBr
 l1pg==
X-Gm-Message-State: AOJu0YwcEdx4KGgHSsreEj05bMBcSKD4qOSUD6iZqw4xTa0mxEwd04P7
 WYLfuxD7kZyhmUEukt+gE3sNUtsOsSy9DqAc54HGKgJbFDIvXU8CZdOb6o8l6eL8LWq/+Uvo7F8
 oG4pmTms=
X-Gm-Gg: AeBDievG2CiD3bCeUwsHMuV0uo0eh5GeeDDRyyRKVH0jCsz5buXMmQfeVe1HcUt6Rfp
 Ce/vofIkDsF0GZW3dPr76vxfhXKsuc2UYZWEajUJ95XXGJQY0vZXecAIIp+tz830fXu/H6BzrkO
 6aRao1xzqNBgUAUnWEqNgO5EnBZOEZ3Nw8s3u1ldyWq+xE8VPpT8CUhV86Z6B/XQ6uNhAkMwiGj
 jQ4LQDCjPjFUpmdi3qqQovjKrJH5nYLLUYQ0ipuE5z2k3N+ygafZo+dxiGarvpBcJoal1cIf1LP
 m8icpsuDuiltYAatF0AFs5IkW/Cz0TAlTOIY36GhiGzoSaA156Cp5ULzQ1RxagNIMKnBdoGNsYt
 rduGW1r8B0yWcM/xK4TPajhC1eBESfhU9SRXjywtTNi5hVZAdSEBlnsVJLbYd/nE3Y4kZTc1gBJ
 OPjo+OhcsbcaeOmfOSi4JCfeepOr9s4aJm2qbxFUkWeGbI/vSzDJGcL9Kad4J+VmdNB2ANE4Mfe
 +wK2/ZfXTc=
X-Received: by 2002:a05:600c:4f0c:b0:489:1c1f:35e6 with SMTP id
 5b1f17b1804b1-4891c1f38c8mr225565695e9.6.1776888118871; 
 Wed, 22 Apr 2026 13:01:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc1c0354sm439039655e9.11.2026.04.22.13.01.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 13:01:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/48] hw/arm/smmuv3: Have smmuv3_accel_init() take an Error*
 parameter
Date: Wed, 22 Apr 2026 21:57:33 +0200
Message-ID: <20260422195746.88865-36-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

By giving smmuv3_accel_init() the ability to populate an error,
we can fail early in smmu_realize() when CONFIG_ARM_SMMUV3_ACCEL
is not available, simplifying smmu_validate_property().

Suggested-by: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
Co-developed-by: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Message-Id: <20260410200031.18572-2-philmd@linaro.org>
---
 hw/arm/smmuv3-accel.h |  7 +++++--
 hw/arm/smmuv3-accel.c |  3 ++-
 hw/arm/smmuv3.c       | 11 +++--------
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index dba6c71de52..1ca2c80a933 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -42,7 +42,7 @@ typedef struct SMMUv3AccelDevice {
 } SMMUv3AccelDevice;
 
 #ifdef CONFIG_ARM_SMMUV3_ACCEL
-void smmuv3_accel_init(SMMUv3State *s);
+bool smmuv3_accel_init(SMMUv3State *s, Error **errp);
 bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
                               Error **errp);
 bool smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
@@ -54,8 +54,11 @@ void smmuv3_accel_idr_override(SMMUv3State *s);
 bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp);
 void smmuv3_accel_reset(SMMUv3State *s);
 #else
-static inline void smmuv3_accel_init(SMMUv3State *s)
+#include "qapi/error.h"
+static inline bool smmuv3_accel_init(SMMUv3State *s, Error **errp)
 {
+    error_setg(errp, "accel=on support not compiled in");
+    return false;
 }
 static inline bool
 smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 65c2f44880a..ae031f1eccf 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -917,11 +917,12 @@ static void smmuv3_accel_as_init(SMMUv3State *s)
     address_space_init(shared_as_sysmem, &root, "smmuv3-accel-as-sysmem");
 }
 
-void smmuv3_accel_init(SMMUv3State *s)
+bool smmuv3_accel_init(SMMUv3State *s, Error **errp)
 {
     SMMUState *bs = ARM_SMMU(s);
 
     s->s_accel = g_new0(SMMUv3AccelState, 1);
     bs->iommu_ops = &smmuv3_accel_ops;
     smmuv3_accel_as_init(s);
+    return true;
 }
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 5570a13c8a6..5c2855c3770 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1965,13 +1965,6 @@ static void smmu_reset_exit(Object *obj, ResetType type)
 
 static bool smmu_validate_property(SMMUv3State *s, Error **errp)
 {
-#ifndef CONFIG_ARM_SMMUV3_ACCEL
-    if (s->accel) {
-        error_setg(errp, "accel=on support not compiled in");
-        return false;
-    }
-#endif
-
     if (s->ats == ON_OFF_AUTO_AUTO) {
         error_setg(errp, "ats auto mode is not supported");
         return false;
@@ -2033,7 +2026,9 @@ static void smmu_realize(DeviceState *d, Error **errp)
     }
 
     if (s->accel) {
-        smmuv3_accel_init(s);
+        if (!smmuv3_accel_init(s, errp)) {
+            return;
+        }
         error_setg(&s->migration_blocker, "Migration not supported with SMMUv3 "
                    "accelerator mode enabled");
         if (migrate_add_blocker(&s->migration_blocker, errp) < 0) {
-- 
2.53.0



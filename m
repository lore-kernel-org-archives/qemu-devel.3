Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30435CD98F1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:15:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZAU-0006t5-I3; Tue, 16 Jun 2026 15:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8S-0004iE-Mz
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:49 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8L-00014J-59
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:41 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-46066e640easo3025122f8f.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636847; x=1782241647; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9wCLOkdT45lh5ipdi99zooqwQLCwa4nSMaUr+Wnmkc0=;
 b=E6Gjt4EHh7nBWAJmuvABI0o6XBM6rckFr2Q1OKsKqD7lK4UCSxgxF4YqTu33hUwKmk
 4bbcTxmmIhzzqLaqLYNijeYp+O39WTzSjtS+Yeq2PXP+Mf2e9/jf+AUJc9/EyNFtcMt6
 QXUMNZWlAwt64Fyi242We86LrKboG32/MQM5aC1dGFdUnId7RBtfqUTqSSkKqKWLiYXM
 UmBlyO5jlaw4k3EAEq/750MdVNW3p0cVWGgszgX/QOS+AjCuOgA+TwXt+P3MtAPHMZd6
 wBACC4ryzHBeK1DeJwnpuVGWSQ6bIDq597PAaVxHUBNvAP4nzbrG2dvmbUOJuP4oEWeG
 t1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636847; x=1782241647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9wCLOkdT45lh5ipdi99zooqwQLCwa4nSMaUr+Wnmkc0=;
 b=LIEl0HNKN2TKKEb96qTx7nOziRGL6PaacDjMlPAk1/3z888dvo51UIDVLMFKW9EmvC
 I7DooBxRrrfW5IC9ZHjncFKNpqm4ADR/eZFLtlSxA7V4Nah43jWiTUdYLXtFXQIU4M08
 OeRYe7MqzOT9QAETqWdi/HPxCXMPtiALE3QoiZsrB4z9jBb1OiY1ToUBhfX7AmV81USM
 EmG84VRZ8Hka71nwLdW3xfm9jRj32Isd52IBsA5l5YNj6/JzzuDqpUim/QjXhlCbYna/
 FkO/rh44IUbu0nzmKyBuoUhHYg1clQ3ngF3aZ7w0LWS0AsOI3dXkGtXDZAy/DTF4PGNn
 jGTg==
X-Gm-Message-State: AOJu0YxdmLoxCy6lYuNxoLvBUfym9It6YgZdI+T801+kB9XE8zn5APKP
 MlWW58ntQfT6NMemtd5MmCKecgaDm99IMMjBKuxxXwkjr/nkOrXRR46/33iSEJbGaFt+VHIDdUV
 1Tzdo
X-Gm-Gg: Acq92OF1uAltI8k65Po6U+jWfQRvGMAxGuoHkhKUDSVdx6n55n5p7YnYfvehO/5OZoD
 38MNB7VF8+HIQgNsYzbLMQfidrf+SLUT7+KtjGBdNfKuAeo9X9QSNk9uomUFBsXCCgn0OfdSUvD
 UKBvOeOTgtAK7uH4JUZxEpGLDrxCmKfnNcB4cSKhwqvbkkSMUD4eef9EfzhmqOYL9DzB0vuaKqQ
 oiftC9MOaub9xFNKVGD5NNkQwTVl/jbLFdFQYGt1AP2pttf7rBMZUimHbphH+Z27uPRZEOnW0MX
 qGefM+UV6koGPv5C/w6G1+LVwR25U+dUzFSFnQTe0YTyq+zk/EPBf0/CFXJXq9GCLyQQQxaMOOg
 zjQBIW37EQfNVwcSao7aEdJfHs76VA/ipvzW/W91BLwBtGIx8dg7A82ebaQIuWJF0/32o//Y24s
 GMpi2hdFPeFthUNfc/NwIag4WuKctqbq++LB1kxTdZbi+mIOcsEiElW8wPHRlWAgCWDJWk2KyF9
 J5DNiDgxki9LUcSwRM3gnqNWvRa3hlP
X-Received: by 2002:a05:6000:18a3:b0:45e:f271:5019 with SMTP id
 ffacd0b85a97d-46236276630mr1427244f8f.14.1781636847245; 
 Tue, 16 Jun 2026 12:07:27 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.07.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:07:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/61] hw/arm/smmuv3: Add cmdqv property for SMMUv3 device
Date: Tue, 16 Jun 2026 20:06:18 +0100
Message-ID: <20260616190639.3462006-42-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

From: Shameer Kolothum <skolothumtho@nvidia.com>

Introduce a "cmdqv" property to enable Tegra241 CMDQV support.
This is only enabled for accelerated SMMUv3 devices.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20260609112552.378999-32-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3.c | 8 ++++++++
 qemu-options.hx | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index a8fb10e531..5e5a6a960c 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1994,6 +1994,10 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
                        "bits if accel=on");
             return false;
         }
+        if (s->cmdqv == ON_OFF_AUTO_ON) {
+            error_setg(errp, "cmdqv can only be enabled if accel=on");
+            return false;
+        }
         return true;
     }
 
@@ -2144,6 +2148,7 @@ static const Property smmuv3_properties[] = {
     DEFINE_PROP_OAS_MODE("oas", SMMUv3State, oas, OAS_MODE_AUTO),
     DEFINE_PROP_SSIDSIZE_MODE("ssidsize", SMMUv3State, ssidsize,
                               SSID_SIZE_MODE_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO("cmdqv", SMMUv3State, cmdqv, ON_OFF_AUTO_AUTO),
 };
 
 static void smmuv3_instance_init(Object *obj)
@@ -2194,6 +2199,9 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "than 0 is required to enable PASID support."
         "Please ensure the value does not exceed the maximum "
         "SubstreamID size supported by the host platform.");
+    object_class_property_set_description(klass, "cmdqv",
+        "Enable/disable CMDQV support (for accel=on). "
+        "Valid values are on, off, and auto. Defaults to auto.");
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
diff --git a/qemu-options.hx b/qemu-options.hx
index a5979d0a5b..c799286153 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1329,6 +1329,14 @@ SRST
 
         - With accel=off, auto is resolved to 0.
 
+    ``cmdqv=on|off|auto`` (default: auto)
+        Enable hardware Command Queue Virtualization (CMDQV) for the
+        SMMUv3 command queue. Currently only the NVIDIA Tegra241 CMDQV
+        implementation is supported.
+
+        - With accel=on, auto means the value is automatically derived from the host SMMU.
+        - With accel=off, auto is resolved to 'off'.
+
 ``-device amd-iommu[,option=...]``
     Enables emulation of an AMD-Vi I/O Memory Management Unit (IOMMU).
     Only available with ``-machine q35``, it supports the following options:
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14426E77188
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2025 07:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTyJE-0003Cj-32; Sat, 04 Jan 2025 02:10:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyJC-0003CK-3D
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:10:54 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyJA-0002sd-0A
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:10:53 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21661be2c2dso164952695ad.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 23:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735974650; x=1736579450;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ABNYI9qAA9SBf9uo6S4BLgQmvQh4QX0lH8r8/G8LADw=;
 b=1VGCkcSKarQ7jXNSJ13tnIm7hXNnavRU+SVzy34C7kXIRGsS4ZfZW4RKwvoxFiufpw
 KAksJqyzxF+NmC9sHrxlyBkKYwrgQT4ys9f8rtquKdvmEz95xs9JTAkjzVjgOfllfPig
 8e+iGwbDt4RYlkFqLeqBsJUzuzWlP+hlo/ZXVgiFbLuXFDqnFtxf0d2d06qFmqjbjhJE
 to3SFKy1TBfqpqnpft68Aw6sSE45bYuWCgAxAwW/chPFPanoWGV3hpkrnyPE2BKl/cNK
 G/OlgNvlIzUR7frZoubgBoL/OBBs9KA+MZBvZeRD82DvodSRcF5k45ygZ6xxlpYg6uqA
 1UGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735974650; x=1736579450;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ABNYI9qAA9SBf9uo6S4BLgQmvQh4QX0lH8r8/G8LADw=;
 b=XWY7uwbiV/D1eXqRTXJityMJ866va2NMeURCHCOe4VYJ4f2xhsiDVcoDaba0CoUyqA
 49hMZm/UU/qYLuQUo7vSfzGprXy9ZfS+nEtXBUBxp7CiapwkzJ9B26RugQgcgeV7YcPB
 yQAIuhkM2fdWND7VIcFh202KY8JSv5S1Kady2c8aOwlfp30jAob6egEYZ/3eGDXkmJzO
 N1lNQvgYRjzDmvDV855FkxooGnbBNTasRxiZ9eLuSZfjBVROPdqLmcKsWNOCP3JRCA2f
 3gVRHz/t6XhQl35oIrMbzQK2S6ThGLxdArvK3tyYOW8vIjrCWdaq12sgWA50xSkUvFTU
 ULfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXd/gwX3H5FbsZE3UUsrKclcVsNNtMkKH450uRVvHUojAmme7JGVXs6/7F9uxOXfgWvQbr1pLHuU9Va@nongnu.org
X-Gm-Message-State: AOJu0YyzRwGd0eFz6O3ACeOj2nf3C/6aAAzBsckkPJheoFzQyFT3HXDw
 Y815sj3/1TleXJoDJEMm25c0dpTpBlRe+zyXEAQgBVuraFsJtrXXbnBTJH58Od8xcULlFyX1azG
 3nso=
X-Gm-Gg: ASbGnctQwpcgfs29E4lbbipTq4/ldfpCRk8oTId5EtLRiMsNYgthC3BL0feOHmWNrzC
 mDfvUJFW6mn221+wX4re8jWuy2yt9ppKehXYoke7OUYbicuTKGOtvYAX5shzm/cf4a14ETRXehs
 x62d8EWhKCR+5TEquhYXsmNpXtKtV1TpqVCP8hTd8XhsOxVzMtTDLaTYORFitzE5Dl1+KyIFSlm
 7PVeOJ/6zSHVIJBtMYnJy8LsYWkkYox155yllimAeQMQCP9LUZwzQcnyiHx
X-Google-Smtp-Source: AGHT+IH9cIovBdI7apBi49hnHAx268iqJjPX7q/SQxTwSH78rcby56/Ns0yD/ValOQ1tHuWl1FxSLA==
X-Received: by 2002:a17:902:cf12:b0:215:a2e2:53ff with SMTP id
 d9443c01a7336-219e6e85cc3mr769414135ad.11.1735974650031; 
 Fri, 03 Jan 2025 23:10:50 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-219dc962933sm256517005ad.56.2025.01.03.23.10.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 23:10:49 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 04 Jan 2025 16:10:42 +0900
Subject: [PATCH v5] target/arm: Always add pmu property for Armv7-A/R+
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-pmu-v5-1-be9c8777c786@daynix.com>
X-B4-Tracking: v=1; b=H4sIAPHeeGcC/23MyQ6CMBSF4VchXVvT3o668j2Mi9JBumAIKIEQ3
 t0CCyW4PDf3+yfU+Tb6Dl2zCbW+j12sqzTEKUO2MNXT4+jSRkCAEwkX3JRvbJwIUnmwwhGUPpv
 Whzislfsj7SJ2r7od12hPl+ve9xQTrEBeKLBca8NvzoxVHM62LtES6OGLFJUbgoQC88zzHBxz4
 oDYH8QS0lZZqoU2AOqA+A8CsiGeEBjIQQeZEx12aJ7nDyAZT6I2AQAA
To: Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, 
 devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

kvm-steal-time and sve properties are added for KVM even if the
corresponding features are not available. Always add pmu property for
Armv7+. Note that the property is added only for Armv7-A/R+ as QEMU
currently emulates PMU only for such versions, and a different
version may have a different definition of PMU or may not have one at
all.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
The "pmu" property is added only when the PMU is available. This makes
tests/qtest/arm-cpu-features.c fail as it reads the property to check
the availability. Always add the property when the architecture defines
the PMU even if it's not available to fix this.
---
Changes in v5:
- Rebased.
- Link to v4: https://lore.kernel.org/r/20240720-pmu-v4-0-2a2b28f6b08f@daynix.com

Changes in v4:
- Split patch "target/arm/kvm: Fix PMU feature bit early" into
  "target/arm/kvm: Set PMU for host only when available" and
  "target/arm/kvm: Do not silently remove PMU".
- Changed to define PMU also for Armv7.
- Changed not to define PMU for M.
- Extracted patch "hvf: arm: Raise an exception for sysreg by default"
  from "hvf: arm: Properly disable PMU".
- Rebased.
- Link to v3: https://lore.kernel.org/r/20240716-pmu-v3-0-8c7c1858a227@daynix.com

Changes in v3:
- Dropped patch "target/arm: Do not allow setting 'pmu' for hvf".
- Dropped patch "target/arm: Allow setting 'pmu' only for host and max".
- Dropped patch "target/arm/kvm: Report PMU unavailability".
- Added patch "target/arm/kvm: Fix PMU feature bit early".
- Added patch "hvf: arm: Do not advance PC when raising an exception".
- Added patch "hvf: arm: Properly disable PMU".
- Changed to check for Armv8 before adding PMU property.
- Link to v2: https://lore.kernel.org/r/20240716-pmu-v2-0-f3e3e4b2d3d5@daynix.com

Changes in v2:
- Restricted writes to 'pmu' to host and max.
- Prohibited writes to 'pmu' for hvf.
- Link to v1: https://lore.kernel.org/r/20240629-pmu-v1-0-7269123b88a4@daynix.com
---
 target/arm/cpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index dcedadc89eaf..e76d42398eb2 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1761,6 +1761,10 @@ void arm_cpu_post_init(Object *obj)
 
     if (!arm_feature(&cpu->env, ARM_FEATURE_M)) {
         qdev_property_add_static(DEVICE(obj), &arm_cpu_reset_hivecs_property);
+
+        if (arm_feature(&cpu->env, ARM_FEATURE_V7)) {
+            object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu);
+        }
     }
 
     if (arm_feature(&cpu->env, ARM_FEATURE_V8)) {
@@ -1790,7 +1794,6 @@ void arm_cpu_post_init(Object *obj)
 
     if (arm_feature(&cpu->env, ARM_FEATURE_PMU)) {
         cpu->has_pmu = true;
-        object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu);
     }
 
     /*

---
base-commit: 38d0939b86e2eef6f6a622c6f1f7befda0146595
change-id: 20240629-pmu-ad5f67e2c5d0

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>



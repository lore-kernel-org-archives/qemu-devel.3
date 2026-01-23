Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F4DD74EDB
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 15:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjIor-0000sH-8p; Fri, 23 Jan 2026 10:11:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjInS-00077y-31
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:10:09 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjInQ-00036H-2Y
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:10:01 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47edd9024b1so19556895e9.3
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 07:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769180998; x=1769785798; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pO2f6DBNywpKXf5TNbSH8YRsyqs1ZqsJjw5WvM1u2rE=;
 b=N/tfKVopmCYmShLSsfxOaPwVo9S/W1f6MlY90Q7bxPkTdgb/DJ02Uo830yY/VW1709
 5xp3l9vo6da5tzLqL0gxD46zOJUKktWP1qkQwk2nV5WJBA+78O2gqQFa66yMywoXGcgI
 5btoHvrsceFOO215pYGx95STV1GPF1j5iekXaFDB3vEjJJOsK5HZqzWtyA26b+vFxdjw
 ob/rS0kbQK3d11pKTNAzTPn+2Df8NcXnIwj5KjbLdYN4q4Sk5imMnC9hG2rYi53rGXlZ
 mQ24rK3GTNAnA28f+F20rjZ1GxJIAD3Gh20KbSqmnpIfxrMEVKOk6c63tk8kY69shm1W
 palg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769180998; x=1769785798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pO2f6DBNywpKXf5TNbSH8YRsyqs1ZqsJjw5WvM1u2rE=;
 b=oojKsECy1fwjk11QCoNeKfqxYX3M9x5kvVcKGUmlY3YVd2azpzf3wh4OLWFEGs9UqK
 NxU8h7iZPUFCwocDOhnwroguXdAK6kpCQwdykl+uGks9fWmKVgYMBrgRVW77jae7LcEE
 cD1maUYg6lPcBHv7M1BrP/7RBpHVHW2Wkp+aSX6iHI+qTWVFTC80Se+zAoymHbnbf6xf
 5duFW/Q+2e5QJG1bXKesHmL65U50Ok7fIXTyn0GikKIaaZ3KLW789UytGI5yP8fGjgdQ
 dh9ueGJmf23rjbEWcOc2V692lpNzNFJY7YYfqpr4YilstMNkc8mWNmMzP5NIbCb91H7o
 i9jA==
X-Gm-Message-State: AOJu0Yz6ideGjTdykafOKI7Hckr13Y+LsViXGKGQtvG2WyMhMlotklu3
 Rklh1cn3fMhBeZ7Y7+RwxNHinjsyUKoEgonnE0khVd/ok0xVljuyB7/A5z2OAutZ9PRD7rvIl9A
 VwB3Z1M0=
X-Gm-Gg: AZuq6aJ/ILvJsK+t2LoTwIfe5+ZqUyQrpS1gfpX1ZoLB9uYkKTyyKBZel+mWhoLHppD
 m5slt+r9b8FWaQrcdCCEa4foTD8dbzsrN6GfyqokfL3HG7D47oVoXmwjCl3h8lo2EtGCfqwVSQv
 4oOJajJzqmmt8GEhFrnz4BKq5gSzM+lc5OWEU85XMfIOK3DsHik2M1+UEOgQ07CEaluAV6FwAqd
 G+Ty75KMR0oSZcYzLGumM8eisycKH2sMTZbBMRbOPmDmHzA8mLfVvgl4Njon7bQmyg/UOVsHrv1
 ZXKiaAcAhA2ZJ+BUMEaly+TS9tNSVlFely1xxWIRGSsyb4A1CNUIgYJOf+8RVjiERatG+4+SPBo
 j1EKZWKtuQ7fd4ZYDxWq8rjZpkiVGgucDMmp7DZ4aDo0LBKLEtKIbQ6YMUdfMDgDGxJ7qnw3H/l
 EhP6vvMW2M3K7Eq/yuE0YrGNrhTAmr1WMAWSC1BwqPxdgWjSpCmuQI
X-Received: by 2002:a05:600c:1d2a:b0:477:2f7c:314f with SMTP id
 5b1f17b1804b1-4804c959823mr54621575e9.10.1769180998265; 
 Fri, 23 Jan 2026 07:09:58 -0800 (PST)
Received: from mnementh.archaic.org.uk (mnementh.archaic.org.uk.
 [81.2.115.146]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71503sm8255641f8f.25.2026.01.23.07.09.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 07:09:57 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/22] hw/intc: declare GICv3 regions as little endian
Date: Fri, 23 Jan 2026 15:09:35 +0000
Message-ID: <20260123150941.1877768-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123150941.1877768-1-peter.maydell@linaro.org>
References: <20260123150941.1877768-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

The GIC should always be a little-endian device as big-endian
behaviour is a function of the current CPU configuration not the
system as a whole. This should have no functional effect as the GIC
cannot be instantiated on a BE system but will help the single binary
efforts.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260121105932.135676-4-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv3.c            | 4 ++--
 hw/intc/arm_gicv3_its.c        | 4 ++--
 hw/intc/arm_gicv3_its_common.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/intc/arm_gicv3.c b/hw/intc/arm_gicv3.c
index 6059ce926a..542f81ea49 100644
--- a/hw/intc/arm_gicv3.c
+++ b/hw/intc/arm_gicv3.c
@@ -417,7 +417,7 @@ static const MemoryRegionOps gic_ops[] = {
     {
         .read_with_attrs = gicv3_dist_read,
         .write_with_attrs = gicv3_dist_write,
-        .endianness = DEVICE_NATIVE_ENDIAN,
+        .endianness = DEVICE_LITTLE_ENDIAN,
         .valid.min_access_size = 1,
         .valid.max_access_size = 8,
         .impl.min_access_size = 1,
@@ -426,7 +426,7 @@ static const MemoryRegionOps gic_ops[] = {
     {
         .read_with_attrs = gicv3_redist_read,
         .write_with_attrs = gicv3_redist_write,
-        .endianness = DEVICE_NATIVE_ENDIAN,
+        .endianness = DEVICE_LITTLE_ENDIAN,
         .valid.min_access_size = 1,
         .valid.max_access_size = 8,
         .impl.min_access_size = 1,
diff --git a/hw/intc/arm_gicv3_its.c b/hw/intc/arm_gicv3_its.c
index cce3486d74..b639c03b67 100644
--- a/hw/intc/arm_gicv3_its.c
+++ b/hw/intc/arm_gicv3_its.c
@@ -1906,7 +1906,7 @@ static const MemoryRegionOps gicv3_its_control_ops = {
     .valid.max_access_size = 8,
     .impl.min_access_size = 4,
     .impl.max_access_size = 8,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static const MemoryRegionOps gicv3_its_translation_ops = {
@@ -1916,7 +1916,7 @@ static const MemoryRegionOps gicv3_its_translation_ops = {
     .valid.max_access_size = 4,
     .impl.min_access_size = 2,
     .impl.max_access_size = 4,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void gicv3_arm_its_realize(DeviceState *dev, Error **errp)
diff --git a/hw/intc/arm_gicv3_its_common.c b/hw/intc/arm_gicv3_its_common.c
index e946e3fb87..9fc51ad1e0 100644
--- a/hw/intc/arm_gicv3_its_common.c
+++ b/hw/intc/arm_gicv3_its_common.c
@@ -97,7 +97,7 @@ static MemTxResult gicv3_its_trans_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps gicv3_its_trans_ops = {
     .read_with_attrs = gicv3_its_trans_read,
     .write_with_attrs = gicv3_its_trans_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 void gicv3_its_init_mmio(GICv3ITSState *s, const MemoryRegionOps *ops,
-- 
2.47.3



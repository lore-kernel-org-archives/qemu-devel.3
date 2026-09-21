Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5873C982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 21:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8lsM-0006yk-2i; Mon, 21 Sep 2026 17:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lsE-0006lJ-IW
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:48:30 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lsC-0000QV-QO
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:48:30 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49ccfd61ecaso30464225e9.3
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 14:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790027297; x=1790632097; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o1D/HluJZPHeRPMLZsNwYm2EuOpzIFXWfzpO+SSWt4I=;
 b=PNXoTqzXxaKgNqlii1vSxRypjp3naqMpLOaaK0XFYovzWOVC1yFmqGtrl3UQJC83zh
 f2SRBbI/utYKpRMcLlgMdTZsGHVH2QWHf24N2ooSJgJE7EmgJEH4EDXlSR8dD7U7m2g8
 xpI86VJWpPX+tlfK5yBkDjNLC3RbB4RaAg7Z2Ek6TPR+qtbqYtqRQHEDjCMe2UlNfuMT
 tWexMagwxYElaJzMVCXdELpcNYUrB28+HwbsPhp+l1kXM0SpsmGoOmfwAGRXKK7N4+Xr
 AgjrjEm7yTriKD+xLxiDOFzHlsuHFVhQCVaUx7dpgHJbQIkjUMBiCA4FPs36U8jmRZbS
 mB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790027297; x=1790632097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=o1D/HluJZPHeRPMLZsNwYm2EuOpzIFXWfzpO+SSWt4I=;
 b=vihypVCcIYlhs1wbqPP77rEjxVSaZv0ZQwCBxImO7THJOJWw0au5GaBLKux8asg3UR
 RPglAGJ0XMp9nPs+dG4ySCz2q0vbS4aHVhAUKViuwldYFTcox6tjUehfRzb20PJPl+sJ
 gaQFxBEpz1UQHUgVX/+UDO68LiZSQcL3oiGY9T9U88uDCuBfxZhgihmSRiPCwj0aDPBj
 kWEJyC5dniMhjj+Uvgkc3SOgKsbd3dpCSlUNR+7K/2iMCE27CGFqFKBru6foPPF2PCp2
 z3G2RMyB1pprZ2NliK5D3O8WW9mCSM1CS16oiivFG5GvXONMlfwQzCvlK3hW1aXitE7r
 PVbg==
X-Gm-Message-State: AFuF++kbHNjxhZGZLpLfdD0VT0eYY0ERMo3X3lvOcl2s2YSzh0lSyHP2
 nMvhfsZhRWkV759g2BtbFQbqTMo+9DG5/FPgeTfLnnroIBV7hTFcVBgepqIm8Q==
X-Gm-Gg: AYBFou3uu6S63jRn7WkyGKYhT7Qzk3suvpx/CIKQjjcE0M2/SgO3eWQ01W4RdAcpGci
 tv0nGtWjlG12m0dIpj7ClkTD5JMSEFc15UY8XHvTW+9kX7tCmDwswu5M5qPAphYIshu+ANhAr/S
 Xh0sh95NgLvTCxJOZlfRYwTZlTOUob0XNsZ+9EhEYl/y5tALaF4kOYqQ4A8kpWlLFmXe8KfTgDx
 R+rLu7jASCDIj8XQEqhOmY7uCUf4zn8PgyVVCDXl5CRvUEelXR20Vbjo8N23GjXzTmKsA7nBchg
 isLzgPhOORBkv+KJ7ZHwgQUwbMLFgnsHx1QBq99dTHuEa9parvEVSrkM86a1XjGhagxuZ0O0MD8
 +DKytrYvjpwqRsBN8V1NRoqLoo/WYzb6DUzQfTpkVcC33O+5XtCycnLDZlwGPmF+wef2uQv2Snk
 czQ4XFw5wFqqN0DDFfnW9mSNO/s+oLYAVXiFtWGeAjKCA1jvzAEc+GrjlPV0Pl0uC/odtleKoSH
 LSLTDN6W73ma7eNlKUO+5FxmcSPEKLuUwq5EjGWald276LDVfcRGXy34sDvHAdCn5jHO2mNuzxz
 amQ=
X-Received: by 2002:a05:600c:3b05:b0:49c:fa21:e746 with SMTP id
 5b1f17b1804b1-49fc57570c8mr155097395e9.28.1790027297418; 
 Mon, 21 Sep 2026 14:48:17 -0700 (PDT)
Received: from Provence
 (dynamic-2a02-3100-1c91-bf00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1c91:bf00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fda0ce29fsm4986905e9.6.2026.09.21.14.48.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 14:48:16 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Jason Wang <jasowangio@gmail.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCH 38/42] hw/misc/imx*_ccm: Avoid casting from void *
Date: Mon, 21 Sep 2026 23:47:06 +0200
Message-ID: <20260921214710.29422-39-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921214710.29422-1-shentey@gmail.com>
References: <20260921214710.29422-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=shentey@gmail.com; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/misc/imx25_ccm.c  | 4 ++--
 hw/misc/imx31_ccm.c  | 4 ++--
 hw/misc/imx6_ccm.c   | 8 ++++----
 hw/misc/imx6ul_ccm.c | 8 ++++----
 hw/misc/imx7_src.c   | 4 ++--
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/hw/misc/imx25_ccm.c b/hw/misc/imx25_ccm.c
index a91b0be682..8fd2a329dd 100644
--- a/hw/misc/imx25_ccm.c
+++ b/hw/misc/imx25_ccm.c
@@ -217,7 +217,7 @@ static void imx25_ccm_reset(DeviceState *dev)
 static uint64_t imx25_ccm_read(void *opaque, hwaddr offset, unsigned size)
 {
     uint32_t value = 0;
-    IMX25CCMState *s = (IMX25CCMState *)opaque;
+    IMX25CCMState *s = opaque;
 
     if (offset < 0x70) {
         value = s->reg[offset >> 2];
@@ -234,7 +234,7 @@ static uint64_t imx25_ccm_read(void *opaque, hwaddr offset, unsigned size)
 static void imx25_ccm_write(void *opaque, hwaddr offset, uint64_t value,
                             unsigned size)
 {
-    IMX25CCMState *s = (IMX25CCMState *)opaque;
+    IMX25CCMState *s = opaque;
 
     trace_imx25_ccm_write(imx25_ccm_reg_name(offset >> 2), value);
 
diff --git a/hw/misc/imx31_ccm.c b/hw/misc/imx31_ccm.c
index 8d620711dd..3cb9f44fab 100644
--- a/hw/misc/imx31_ccm.c
+++ b/hw/misc/imx31_ccm.c
@@ -222,7 +222,7 @@ static void imx31_ccm_reset(DeviceState *dev)
 static uint64_t imx31_ccm_read(void *opaque, hwaddr offset, unsigned size)
 {
     uint32_t value = 0;
-    IMX31CCMState *s = (IMX31CCMState *)opaque;
+    IMX31CCMState *s = opaque;
 
     if ((offset >> 2) < IMX31_CCM_MAX_REG) {
         value = s->reg[offset >> 2];
@@ -239,7 +239,7 @@ static uint64_t imx31_ccm_read(void *opaque, hwaddr offset, unsigned size)
 static void imx31_ccm_write(void *opaque, hwaddr offset, uint64_t value,
                             unsigned size)
 {
-    IMX31CCMState *s = (IMX31CCMState *)opaque;
+    IMX31CCMState *s = opaque;
 
     trace_imx31_ccm_write(imx31_ccm_reg_name(offset >> 2), value);
 
diff --git a/hw/misc/imx6_ccm.c b/hw/misc/imx6_ccm.c
index 45fdd0d5a8..4a40fe08ea 100644
--- a/hw/misc/imx6_ccm.c
+++ b/hw/misc/imx6_ccm.c
@@ -491,7 +491,7 @@ static uint64_t imx6_ccm_read(void *opaque, hwaddr offset, unsigned size)
 {
     uint32_t value = 0;
     uint32_t index = offset >> 2;
-    IMX6CCMState *s = (IMX6CCMState *)opaque;
+    IMX6CCMState *s = opaque;
 
     value = s->ccm[index];
 
@@ -504,7 +504,7 @@ static void imx6_ccm_write(void *opaque, hwaddr offset, uint64_t value,
                            unsigned size)
 {
     uint32_t index = offset >> 2;
-    IMX6CCMState *s = (IMX6CCMState *)opaque;
+    IMX6CCMState *s = opaque;
 
     trace_imx6_ccm_write(imx6_ccm_reg_name(index), (uint32_t)value);
 
@@ -519,7 +519,7 @@ static uint64_t imx6_analog_read(void *opaque, hwaddr offset, unsigned size)
 {
     uint32_t value;
     uint32_t index = offset >> 2;
-    IMX6CCMState *s = (IMX6CCMState *)opaque;
+    IMX6CCMState *s = opaque;
 
     switch (index) {
     case CCM_ANALOG_PLL_ARM_SET:
@@ -611,7 +611,7 @@ static void imx6_analog_write(void *opaque, hwaddr offset, uint64_t value,
                               unsigned size)
 {
     uint32_t index = offset >> 2;
-    IMX6CCMState *s = (IMX6CCMState *)opaque;
+    IMX6CCMState *s = opaque;
 
     trace_imx6_analog_write(imx6_analog_reg_name(index), (uint32_t)value);
 
diff --git a/hw/misc/imx6ul_ccm.c b/hw/misc/imx6ul_ccm.c
index c4f6e372fe..f12ba6ebe2 100644
--- a/hw/misc/imx6ul_ccm.c
+++ b/hw/misc/imx6ul_ccm.c
@@ -625,7 +625,7 @@ static uint64_t imx6ul_ccm_read(void *opaque, hwaddr offset, unsigned size)
 {
     uint32_t value = 0;
     uint32_t index = offset >> 2;
-    IMX6ULCCMState *s = (IMX6ULCCMState *)opaque;
+    IMX6ULCCMState *s = opaque;
 
     assert(index < CCM_MAX);
 
@@ -640,7 +640,7 @@ static void imx6ul_ccm_write(void *opaque, hwaddr offset, uint64_t value,
                            unsigned size)
 {
     uint32_t index = offset >> 2;
-    IMX6ULCCMState *s = (IMX6ULCCMState *)opaque;
+    IMX6ULCCMState *s = opaque;
 
     assert(index < CCM_MAX);
 
@@ -654,7 +654,7 @@ static uint64_t imx6ul_analog_read(void *opaque, hwaddr offset, unsigned size)
 {
     uint32_t value;
     uint32_t index = offset >> 2;
-    IMX6ULCCMState *s = (IMX6ULCCMState *)opaque;
+    IMX6ULCCMState *s = opaque;
 
     assert(index < CCM_ANALOG_MAX);
 
@@ -754,7 +754,7 @@ static void imx6ul_analog_write(void *opaque, hwaddr offset, uint64_t value,
                               unsigned size)
 {
     uint32_t index = offset >> 2;
-    IMX6ULCCMState *s = (IMX6ULCCMState *)opaque;
+    IMX6ULCCMState *s = opaque;
 
     assert(index < CCM_ANALOG_MAX);
 
diff --git a/hw/misc/imx7_src.c b/hw/misc/imx7_src.c
index 77f13bd020..4a59e347c5 100644
--- a/hw/misc/imx7_src.c
+++ b/hw/misc/imx7_src.c
@@ -105,7 +105,7 @@ static void imx7_src_reset(DeviceState *dev)
 static uint64_t imx7_src_read(void *opaque, hwaddr offset, unsigned size)
 {
     uint32_t value = 0;
-    IMX7SRCState *s = (IMX7SRCState *)opaque;
+    IMX7SRCState *s = opaque;
     uint32_t index = offset >> 2;
 
     if (index < SRC_MAX) {
@@ -167,7 +167,7 @@ static void imx7_defer_clear_reset_bit(uint32_t cpuid,
 static void imx7_src_write(void *opaque, hwaddr offset, uint64_t value,
                            unsigned size)
 {
-    IMX7SRCState *s = (IMX7SRCState *)opaque;
+    IMX7SRCState *s = opaque;
     uint32_t index = offset >> 2;
     long unsigned int change_mask;
     uint32_t current_value = value;
-- 
2.55.0



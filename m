Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85763FA0C30
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 05:57:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCtEa-0007Fy-6Y; Wed, 15 Apr 2026 01:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <fm-294854-2026041505460989a3cfb7970002079b-q97qC2@rts-flowmailer.siemens.com>)
 id 1wCtEY-0007FP-9X
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 01:56:18 -0400
Received: from mta-65-226.siemens.flowmailer.net ([185.136.65.226])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <fm-294854-2026041505460989a3cfb7970002079b-q97qC2@rts-flowmailer.siemens.com>)
 id 1wCtEV-000506-VM
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 01:56:18 -0400
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 2026041505460989a3cfb7970002079b for <qemu-devel@nongnu.org>;
 Wed, 15 Apr 2026 07:46:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=VIy4BuoOYDrOsEWURNMpXvgUEQxseoHsEGpeQhJpWqM=;
 b=ZXE2Q9H1I7/by0OxV5ZD8mUpyk0qUpyaxyIru6L3T+ebOG9rB5lIlcUqzXE4dVq2v5DoG8
 zQ8WmFQNvSf+XvGBCC2tRpMjaAV8FSRHWz449y3xpMscjWJXC8gVoE7M3yMzfWRy5mBnykA5
 ejX5YXIlJVkMtywSoTGD8yFPEpv3jjd/Wtw++K9KM6OeAQXy9nzV76YtBdw3v+Hb8qelotsp
 eiXA4I354IfXgYOdXvGZbAmjNIa0uBsN4YXhw8wh56IBKmzmw4bz8Q4oDuCS/+W7NVCibv3h
 i/gzoU3mjreodoIzIuMj5xSsMTaD335rY1s1WdAawBNZ4q8flcxMgMsg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Jan=20L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH 2/2] hw/sd/sdcard: Add support for pre-setting the
 authentication key
Date: Wed, 15 Apr 2026 07:46:07 +0200
Message-ID: <9fab19ee4c755f9cb2abf55494541fcadff46cbd.1776231967.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1776231967.git.jan.kiszka@siemens.com>
References: <cover.1776231967.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Received-SPF: pass client-ip=185.136.65.226;
 envelope-from=fm-294854-2026041505460989a3cfb7970002079b-q97qC2@rts-flowmailer.siemens.com;
 helo=mta-65-226.siemens.flowmailer.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jan Kiszka <jan.kiszka@siemens.com>

In contrast to real eMMCs, we are not (yet) persisting the full state
of the device. This particularly includes the authentication key used
for RPMB access, complicating testing of firmware images which do not
support initial provisioning of the key.

One way to address this would be, e.g., extending the eMMC disk image
with a special sector to store further state. A simpler approach is used
here: Add another device property that allows to specify the
authentication key, bringing up the eMMC as if the key has already been
provisioned before.

This is how to tell qemu to use the OP-TEE test key:

-device emmc,[...],auth-key=D3EB3EC36E334C9F988CE2C0B85954610D2BCF8664844DF2AB56E6C61BB701E4

Or use this for machine-configured eMMCs:

-global emmc.auth-key=D3EB3EC36E334C9F988CE2C0B85954610D2BCF8664844DF2AB56E6C61BB701E4

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 hw/sd/sd.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 37f6e0702b..13ea54df38 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -205,6 +205,7 @@ struct SDState {
     QEMUTimer *ocr_power_timer;
     uint8_t dat_lines;
     bool cmd_line;
+    char *preset_auth_key;
 };
 
 static void sd_realize(DeviceState *dev, Error **errp);
@@ -3132,6 +3133,27 @@ static void sd_realize(DeviceState *dev, Error **errp)
                           "The RPMB partition size must be multiples of 128K"
                           "and not larger than 16384K.\n");
     }
+    if (sd_is_emmc(sd) && sd->preset_auth_key) {
+        if (strlen(sd->preset_auth_key) != 64) {
+            error_setg(errp,
+                       "Authentication key must be 32 bytes long, "
+                       "encoded hexadecimally");
+            return;
+        }
+
+        char *pos = sd->preset_auth_key;
+        unsigned int n;
+        for (n = 0; n < RPMB_KEY_MAC_LEN; n++, pos += 2) {
+            int chrs;
+            if (sscanf(pos, "%02hhx%n", &sd->rpmb.key[n], &chrs) != 1 ||
+                chrs != 2) {
+                error_setg(errp,
+                           "Authentication key contains invalid characters");
+                return;
+            }
+        }
+        sd->rpmb.key_set = 1;
+    }
 }
 
 static void emmc_realize(DeviceState *dev, Error **errp)
@@ -3156,6 +3178,7 @@ static const Property emmc_properties[] = {
     DEFINE_PROP_UINT64("boot-partition-size", SDState, boot_part_size, 0),
     DEFINE_PROP_UINT8("boot-config", SDState, boot_config, 0x0),
     DEFINE_PROP_UINT64("rpmb-partition-size", SDState, rpmb_part_size, 0),
+    DEFINE_PROP_STRING("auth-key", SDState, preset_auth_key),
 };
 
 static void sdmmc_common_class_init(ObjectClass *klass, const void *data)
-- 
2.47.3



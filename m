Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D04CD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:22:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMgVx-0000pN-BF; Tue, 12 May 2026 02:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgVW-0000eg-GF
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:22:25 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgVU-00047o-Or
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:22:18 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-488a14c31eeso34988125e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 23:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778566933; x=1779171733; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4+O/G90CzsbTg/n65ZUZn83pml2yX70Uu8nT+gwXYMs=;
 b=rC+Tv+xWzrBoXrWAe3v6zeEBhPJNp9RAW2YbaYei+HnYyPhnm38EuVURUIMyQjmpxQ
 BDk/zQ5BjdkMbcEFSo9kJcbQhJRPaFZGc88rCUN5khw8rKlHRVvk6kOe4PoOT9/PoyZY
 zOz6UZSs8teMxyajg9g6S6zzjKXR1nRLaYmT3l1xyTlicpL/bW9SIqSsWyCYtkcYfsE5
 t/q5+vajTxaCWQYQi/msBwtbehrbx65EUk1EWVSP1piN4OnnmRlZ89qd4DGnXWyH9Rwk
 v1qAMSaSumld3ybVPObgsiytnLOl3ZUcXua7pV7Otzr42m+D2yJ618ov1JO4gk7EdZ+X
 tNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778566933; x=1779171733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4+O/G90CzsbTg/n65ZUZn83pml2yX70Uu8nT+gwXYMs=;
 b=qfK6DEUyoN0e38lr0fTfLwui+BOADu1eQoS43cBBLuaIOsU/SJNwSMSu/ze9303ARg
 jNdoRN5LyHf0+ZiG55ofUtMNYNR3CwneP8nN4jimceCHd4SCD7zpeVhbU+MOdFlwwIri
 6JYMoANSSHYzYo3Sexj6nY6tL3D8tjHiJHZ4JelS9jjZNT3Zz3cMXN3Xw3KhIc1tz2L6
 JgOxfGTVTy8ueoA6pOecR/HcJjqPZOJJiflaeazWGEksJExMGR5F4eR42cXUAt3qU/Ja
 cJpnFB+29S32vWB+6QQGwnFZ3X9itb7R2mlll7nN/sNiO2HwfPZBDRWrvqsVrb8NluHO
 RqGg==
X-Gm-Message-State: AOJu0YwBk+Fq0SDClQnKrCj9RnfoZD/inOUqt5RojZxIkX4rj2hMHhWh
 NUl0ASkQy5zKSbQ+DUrkA+op/l0RiPj74Y9WzUrSiu+QxnXLUfQTUuC8rKbjFXw9yK2zd2wITac
 Gs0UY+8k=
X-Gm-Gg: Acq92OGRXDy85wRotmbMhmaqxgv49vyn661e3J3XGS3j2/5idOlXNcFv96/51QrqBOU
 lhtYl65ffZmdxTWOyyRjRkaDfsdLsVT1o9vIVzXjPT1Itd5WlhtqDb4FvKlczvLnVk4v3iCLF1B
 6wqqB2dfL5sL5hAXmd4fPdiuQZbk8V9H5Z6EwqSYpj2ywmsqd6hS4I/IbiaThv3qPs4h1YtkwpF
 mD/FpPdXPhWRqA+gPH0GV6jcGhB+qWxr19bQRzwPq0W1METgGFVX4w8vs1ZaPAQvfQJgygzWfAp
 U/MtuPZEcoJCIst6lkMF9DDjduwVf4+FJF5Ni4LmKfET3R404sNmbjGWP42u5KTDW334jj8ueT4
 B7iN7t/gP/IoHcK9qhMVlrPP+xHANYDbhuOiyNxx6idO/BZxjFucbm5N86Z+F8mbqm3phrGiCYY
 NdrQbw99JrVNIyV2HlNs5Y7Jh4a5jOZX1nlujtIei5oqtBaop/S59G+Q6vtLDdOijGC3gdLyJ1
X-Received: by 2002:a05:600c:350a:b0:489:2005:b36e with SMTP id
 5b1f17b1804b1-48e676ac333mr255592705e9.19.1778566933022; 
 Mon, 11 May 2026 23:22:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8f3cf0cdsm15897265e9.2.2026.05.11.23.22.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 23:22:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/41] hw/sd/sdcard: Add support for pre-setting the
 authentication key
Date: Tue, 12 May 2026 08:21:05 +0200
Message-ID: <20260512062142.67998-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512062142.67998-1-philmd@linaro.org>
References: <20260512062142.67998-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>
Message-ID: <9fab19ee4c755f9cb2abf55494541fcadff46cbd.1776231967.git.jan.kiszka@siemens.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/system/devices/emmc.rst | 23 +++++++++++++++++++++++
 hw/sd/sd.c                   | 23 +++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/docs/system/devices/emmc.rst b/docs/system/devices/emmc.rst
index e62adfd68ed..e7d67c809d5 100644
--- a/docs/system/devices/emmc.rst
+++ b/docs/system/devices/emmc.rst
@@ -53,3 +53,26 @@ SDHCI controllers while assuming that the firmware needs a boot partitions of
     -drive file=emmc.img,if=none,format=raw,id=emmc-img
     -device sdhci-pci
     -device emmc,drive=emmc-img,boot-partition-size=1048576,rpmb-partition-size=2097152
+
+RPMB Authentication Key
+=======================
+
+A private shared key is used for authenticating requests of the host to the
+RPMB. A real eMMC stores this persistently and permits no reprogramming once it
+is set. QEMU emulates key programming but does not persist the key state
+across restarts. To emulate the state "key is set", the eMMC can be created
+with a user-provided key via the ``auth-key`` property:
+
+.. code-block:: console
+
+    -device emmc,[...],auth-key=D3EB3EC36E334C9F988CE2C0B85954610D2BCF8664844DF2AB56E6C61BB701E4
+
+This sets the well-known test key of OP-TEE on emmc device creation. In case an
+eMMC is instantiated by the machine model already:
+
+.. code-block:: console
+
+    -global emmc.auth-key=D3EB3EC36E334C9F988CE2C0B85954610D2BCF8664844DF2AB56E6C61BB701E4
+
+A key always consists of 32 bytes that have to be encoded as hex numbers,
+left-padding with zeros as needed.
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 58275e7fa19..ebe6e35b15e 100644
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
2.53.0



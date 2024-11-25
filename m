Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8640AD59D67
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 20:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFfFL-0005FX-Bc; Mon, 25 Nov 2024 14:59:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfFF-00058c-Sr
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:41 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfF8-0004px-NE
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:41 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-382442b7d9aso3702352f8f.1
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 11:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732564773; x=1733169573; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AM9CmiES+peuGOYCBRYh0Z2NclowtBsfFXloH3BjlTc=;
 b=dRHjC29qNV+eJt2DmKU5jbWE15eyykMPIar8TDdP2GfBR7jO/6YP8lVAPC7+MneffB
 Xpbc9eIT+onE8l0IRMiyGcB5TleQt6CdOF2uWbMK43oSB6BI7flTT9vvm8wnXxKhjew8
 MNEIN2f0/eiSmbEem6wt8tiwH3stoQcRMSmEM8+bV1Inh6GDe6hUfvZhjARqoMI62MxD
 YuWkMEbbwQJ9GoDheI1ErjxcFyrnH4b/qQKJXA/bNRf0O99K6WxzbJGOpTNY9rO8gvZQ
 C2HPsFr+nNeyWMBFiN9qEDJbqgOLyEFPXeRXFb7w50xqVk/Xe5ZaTcTrbsPCBVG5rb4O
 5H/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732564773; x=1733169573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AM9CmiES+peuGOYCBRYh0Z2NclowtBsfFXloH3BjlTc=;
 b=cUIHsMDFMn1zza5gvgM78lWkMmk9m2mHLYeIx9HzM8W3/OC3GnnpWbqu2kBbJLPT/8
 MN0/E1NOYURwvaK2Brxn/ij8VKBcCMhrOU17dGVt9EHaMhhCG1OHs174UeafEsuwHedA
 BgqEuz9KFJHDGyVJhCJ4uPRPQekpOlojF8cblBaZ+YVGWMuCCtjGJxOvLk9uHIjp1Go9
 vy5Ta+PFRZ3vF2VboH6G95g9Zy1c4L8pSlikoulcwXrp5WfAzgxIS2KsMuBRC45X6Lxo
 t6dI+oCpzvPYv/ui68J+DITmz4cnCcAbTYdDhP4dQr3UL10kGAxLEIiY4c9ugBLkKvrF
 r23w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwtiZdRX6ycpg5zEFFhBRwQKmDc8uCg382W5ZIsiiOpd+uP0XSTYMtuzbzyaHqWDSAfut/A5kMtRSJ@nongnu.org
X-Gm-Message-State: AOJu0YzBTpPkLr+cUnJWeZZPGHS4/SDTVUDdu4ZQU2SU7Tzv5Cl6dVVn
 U75p+UX/H+Vf7sNuaAfh0+UFBlOAoG+vdmH8WSrsv2twOJdSrdglBgnqbLw5XSI=
X-Gm-Gg: ASbGncu0cDosYGSNC/l6uFGgizCUN2PDacUrzosggNOW3UksvcooEnFNklARxatfyFC
 jDZOcnoPxroz9e0k9B7YG7aTrwCTISox+7xn5aJ68YedY/hNIQZ70fQfnPv0wNzJUul/iYrUkwB
 7kmIemubhGqiFlSGKH94pKyc+Fj16vXRAwNaa1xZgYTW3vISBt8ROwwOgBXOUh28nG9XMfSvLwa
 K9/tEz6gu+offhPWyVBI+Eqc7U3Psam3OqQf9S7po2qH1iZvo0lt81rt20qx+NiAQXO
X-Google-Smtp-Source: AGHT+IG8nC95KgxPOV4gNNszZYNmR7epAcoJPgXz8ijIjcuMTQZVqQBxAAlIVhMM0m+tNLQY0PCvEQ==
X-Received: by 2002:a05:6000:2ae:b0:382:4378:4652 with SMTP id
 ffacd0b85a97d-38260bcb8b4mr11780186f8f.45.1732564773213; 
 Mon, 25 Nov 2024 11:59:33 -0800 (PST)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fd0fbdcsm11237971f8f.109.2024.11.25.11.59.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 11:59:32 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v3 15/26] hw/arm/virt: Add support for Arm RME
Date: Mon, 25 Nov 2024 19:56:14 +0000
Message-ID: <20241125195626.856992-17-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125195626.856992-2-jean-philippe@linaro.org>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When confidential-guest-support is enabled for the virt machine, add the
RME flag to the VM type.

The HVC conduit for PSCI is not supported for Realms.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 hw/arm/virt.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 1a381e9a2b..2d36640733 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -229,6 +229,11 @@ static const int a15irqmap[] = {
     [VIRT_PLATFORM_BUS] = 112, /* ...to 112 + PLATFORM_BUS_NUM_IRQS -1 */
 };
 
+static bool virt_machine_is_confidential(VirtMachineState *vms)
+{
+    return MACHINE(vms)->cgs;
+}
+
 static void create_randomness(MachineState *ms, const char *node)
 {
     struct {
@@ -2165,10 +2170,11 @@ static void machvirt_init(MachineState *machine)
      * if the guest has EL2 then we will use SMC as the conduit,
      * and otherwise we will use HVC (for backwards compatibility and
      * because if we're using KVM then we must use HVC).
+     * Realm guests must also use SMC.
      */
     if (vms->secure && firmware_loaded) {
         vms->psci_conduit = QEMU_PSCI_CONDUIT_DISABLED;
-    } else if (vms->virt) {
+    } else if (vms->virt || virt_machine_is_confidential(vms)) {
         vms->psci_conduit = QEMU_PSCI_CONDUIT_SMC;
     } else {
         vms->psci_conduit = QEMU_PSCI_CONDUIT_HVC;
@@ -3013,6 +3019,7 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
 static int virt_kvm_type(MachineState *ms, const char *type_str)
 {
     VirtMachineState *vms = VIRT_MACHINE(ms);
+    int rme_vm_type = kvm_arm_rme_vm_type(ms);
     int max_vm_pa_size, requested_pa_size;
     bool fixed_ipa;
 
@@ -3042,7 +3049,11 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
      * the implicit legacy 40b IPA setting, in which case the kvm_type
      * must be 0.
      */
-    return fixed_ipa ? 0 : requested_pa_size;
+    if (fixed_ipa) {
+        return 0;
+    }
+
+    return requested_pa_size | rme_vm_type;
 }
 
 static int virt_hvf_get_physical_address_range(MachineState *ms)
-- 
2.47.0



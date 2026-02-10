Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A7CEA811F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 13:55:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpoAM-0002Ep-1a; Tue, 10 Feb 2026 08:52:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpoAI-0002C6-Ap
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:52:30 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpoAG-0006NF-Rq
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:52:30 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4801eb2c0a5so53544655e9.3
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 05:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770731547; x=1771336347; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dCm7KHoJAqs8SA7JjFZDtnB2gN/PwqLJzcqLgMLX7XU=;
 b=uGa0vdTRmy9GClKQcSKqyMcOY/YWykTt3m+H0P65iALt/7A/FfAhS+gTrNC2eemWdL
 Pfpb4H1pnekdV7zYfm7ZozOyZHP9D5SXEjLRD/DtjnbbCU3bBD9niS3+fVz9yqtsLZxN
 gQdagfwVA3KHgWG5/a8shKzFGgnWaB3RzMT5SssEOQSqv+++CB/bQFY/FgTJlJt8w88K
 NoDcbE6V7lRGEPKoCVxxnkBggOEFYeyD9z7I4vr+pUkneSqmZRcpAhQysza2LDwZPV7k
 QHv8aRhlxwyMrJHhICSTF3cywnjp0Pl8X4b59Vz7wC3RG0Nui8T/OJBTQO06vAiwAQd6
 b78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770731547; x=1771336347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dCm7KHoJAqs8SA7JjFZDtnB2gN/PwqLJzcqLgMLX7XU=;
 b=Mv6QlMgECyPUywF2xLsXpNK89Q+qdmMSYkjd3zJsb5xYQvu9xE1PWm4G3QluAQCqIy
 7VObPOoGzFgDgti62JyjTr/R860gVrGm9hfOFvLoofOemRPi3lpoJmA3Rz/yyEBvbUHr
 nqW236blIA7b4lVxHzhh9SUJCZa0c5B5jdHykEuF/OcL1wezYD+hAnMzI2bdBUkmPBx6
 BXmT4RtRWmmJ4CMB+QawLBiLqdl4rCpAbQlbd7LO31zMdqAy7vzD4783/jKVJ7+X3mNZ
 FaNKXd5RpngMLFydsltyn1WmI80fJ6ZyAOJsFZJRqKc31RQd5phJX1DG5IE+aD3kn2zw
 5CwQ==
X-Gm-Message-State: AOJu0Yx9sqcDn6d1zjOcTMjSCijiyt4nR71VYqr7Slz2i+ljxSB6ObHP
 YTT73UigYIb/3Vy1vw4haIZjDTnbUerjSVA01121S45HPwOLfh9yH54hkcce0bmuaxH11dYeQ6y
 JRW7i
X-Gm-Gg: AZuq6aKAVgRVVXLfX3BUmjQDCprtC1xOmEkJ9k4N9EX4FoBHLd3e/JQqDRPQ/6nJb/H
 v+qzlKIcw96P0lv4OlRZwqyOjvaA006W+Bm/42kZUp6e0O7qazWYPdMloF2iAoBfkGb9s3Xhod+
 dQr+IK/6fT2IFeFlw6hPR6MnBiaZvUtwI1DiCEHFZDazIqp/16t437hcXaDGIcY/R9L+KwCmdCi
 ZEiS0HOEz0QZ7zM15Ov/isCws2W3OxQYljiodb+8epZQtT9KUwsLPV/MBDZv7VFSRqiPxh+MwEC
 Zcq8CvPZ9+Gchm8/ppqVaAYz3RMg1eOgcxMxogzgwUHj8hQsdD4r7WaoqncnlyWSy3X/MLKFqGQ
 rppqDV6Tss/VZvw48Bs+4sv2PpD1KXqRmn4Qe8bUAl7hrkuTxWEBrDl32wsPYCOiJMizhiSswoR
 AQQmdVnDf0YITC9jxOINjsx6b07ypzElHYnFfE5342rlGfJb9rKdxXo0mIH1WDvCIwOqZsjkzQx
 hF6c2KG2+Z3GTi/2t/Y+5H6rk3oBP+f9MJE9msCLA==
X-Received: by 2002:a05:600c:4e8b:b0:477:7bca:8b2b with SMTP id
 5b1f17b1804b1-483507f2bb3mr31237915e9.15.1770731547236; 
 Tue, 10 Feb 2026 05:52:27 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5d77f9sm64344875e9.3.2026.02.10.05.52.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 05:52:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/26] whpx: arm64: add partition-wide reset on the reboot path
Date: Tue, 10 Feb 2026 13:52:02 +0000
Message-ID: <20260210135206.229528-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210135206.229528-1-peter.maydell@linaro.org>
References: <20260210135206.229528-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

This resets non-architectural state to allow for reboots to succeed.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/system/whpx-internal.h | 2 ++
 target/arm/whpx/whpx-all.c     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index 8ded54a39b..ad6ade223e 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -86,6 +86,8 @@ void whpx_apic_get(APICCommonState *s);
   X(HRESULT, WHvSetVirtualProcessorInterruptControllerState2, \
         (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, PVOID State, \
          UINT32 StateSize)) \
+  X(HRESULT, WHvResetPartition, \
+        (WHV_PARTITION_HANDLE Partition)) \
 
 #define LIST_WINHVEMULATION_FUNCTIONS(X) \
   X(HRESULT, WHvEmulatorCreateEmulator, (const WHV_EMULATOR_CALLBACKS* Callbacks, WHV_EMULATOR_HANDLE* Emulator)) \
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 44ef42307b..36c5e30a03 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -497,6 +497,8 @@ int whpx_vcpu_run(CPUState *cpu)
             if (arm_cpu->power_state != PSCI_OFF) {
                 whpx_psci_cpu_off(arm_cpu);
             }
+            /* Partition-wide reset, to reset state for reboots to succeed. */
+            whp_dispatch.WHvResetPartition(whpx->partition);
             bql_unlock();
             break;
         case WHvRunVpExitReasonNone:
-- 
2.43.0



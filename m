Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5AACAC5AE
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 00:44:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1a5H-0005ab-87; Wed, 24 Sep 2025 20:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1a5F-0005aJ-JV
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 20:43:41 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1a59-0000qx-2s
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 20:43:41 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46e2e363118so3169245e9.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 17:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758761009; x=1759365809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KH/7NLPG4ikugNORXiJ0V6fPkIeSso9Z0lg64lLa/Pk=;
 b=DE4HVdkGN6WWkPePxOzppHDprjLP2ljRKlmgIlAO5HdtgQ1r8C08TZfEtEJErKqiVP
 FVSOEq4O/kfIx06S1QJv7bh22qDHq9H+NBhh8HJB0rMWDj1gItjSdh0xaXqqIGaEeVL0
 FV/anFY0AbWuAP2O5pFVyBpOqdBcpo3AL4NoGnnMvV1fobvxVoMbUqPQYorvE6ET5CUa
 wo8PmVJv+yYVHWzul/jVNaS/i2M7GIMi7qTBwWOR9OLzlQZ8QO22V3I2gicsTkA7gVaX
 8XGZEPyqSXfjEfSSZLN/u2BrKIpZm+S5MjbHo4lKidXch+8zykYDVs45AUuxCcEHvwUN
 jWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758761009; x=1759365809;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KH/7NLPG4ikugNORXiJ0V6fPkIeSso9Z0lg64lLa/Pk=;
 b=S65kYHlAZTnM3fA72DMb03gank4eek23DAqFUsAq/Vr8j78NzgUayEK4YvTBj2uoke
 i0McrN3+ykfH4VN+ir1j6kLohcOCZu+DpObD/7GzCtLM3BLQNM3JxusNdSZ63d8AsU3l
 eBKNR6egx06u6mg/0MlQNqtBoctaBfOnAGISVybxgwmHPBRgdPsg+o+lX5PRt6sBtHyX
 0yWzxoz8lCE5UgTxCSbCCx/PdujRZmhhmKz1K32ktY9F17VAMgWe253/6rf1omfJqX8c
 /LGEEoVPdAEvkvR1EnewT4V392T3qi9MAn2Od2hOg9P3Z873qfBJLljc8hrjdaqgnO8N
 qR1g==
X-Gm-Message-State: AOJu0YzodHH6oIgE7YmRDmcJsCZUgXJc5RzuzZfrFwzz9XJjWA679qKa
 gY40wdOCULubRM6PDM1nLOR3TEIqHbaWKAf0rYbcUXmIIwyaUAg8WlkLCsUccw+WnN2YXkH5oV4
 3WhQQHDtcRQ==
X-Gm-Gg: ASbGncsFSnKrGBGQi8RvWMEcGnqLdfUvHSSKJ+oAUW96+b9/UIsnRa9JiK5llGyndjr
 xLP6EW9zeSoZ1QD84dFGsTpYCPXP/mcCirw9dMvkwQ1S2LcpLEh0CPE9eY+QXN10haKTM/kir+J
 PkO+VXCvZtJRTOQOB8CX3jLN0fiNoq8hBj7/iLLgNIGbK013s9SV6QMXM4gRa35RuL8se8174Be
 OBtKhzOpghEnradlyYftBnYJMP/oeZsQ5THtVswVfcPyyrN4O/VWMMG3B8odPYETb4YUjmjAeNG
 olQYVKecJ7Co3HdqRFjfzAVSh+sIJyyYwVS6oYpCJanP25DnSK6BFXjJ3uhFvVO3Wkv9CrDZYk2
 Nx3erIFZQoY6WF2/149QqQUOf41ld6n0piAZKthTTwTIcgCfJgOBg6cLbDYA29QalhAf/NZPd
X-Google-Smtp-Source: AGHT+IEqXq9S6InkEjldnVxtQVzpGRYItEdMyVz3xV8Ozwv/Jc+bTKmD6MCnbm4B7TPv+jOSf0bj/Q==
X-Received: by 2002:a05:600c:4fd3:b0:45d:da45:50c8 with SMTP id
 5b1f17b1804b1-46e32a1336dmr12053995e9.29.1758761009221; 
 Wed, 24 Sep 2025 17:43:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2a9af27dsm54643875e9.8.2025.09.24.17.43.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Sep 2025 17:43:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] target/loongarch: Replace VMSTATE_UINTTL() -> VMSTATE_UINT64()
Date: Thu, 25 Sep 2025 02:43:27 +0200
Message-ID: <20250925004327.58764-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

All LoongArchCPU::pc and LoongArchCPU::gpr[] fields are of
uint64_t type. Use the appropriate VMSTATE_UINT64() macro.

There is no functional change (the migration stream is not
modified), because the LoongArch targets are only built as 64-bit:

  $ git grep TARGET_LONG_BITS configs/targets/loongarch64*
  configs/targets/loongarch64-linux-user.mak:7:TARGET_LONG_BITS=64
  configs/targets/loongarch64-softmmu.mak:7:TARGET_LONG_BITS=64

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/machine.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
index 4e70f5c8798..bead853efe8 100644
--- a/target/loongarch/machine.c
+++ b/target/loongarch/machine.c
@@ -171,8 +171,8 @@ const VMStateDescription vmstate_loongarch_cpu = {
     .version_id = 3,
     .minimum_version_id = 3,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINTTL_ARRAY(env.gpr, LoongArchCPU, 32),
-        VMSTATE_UINTTL(env.pc, LoongArchCPU),
+        VMSTATE_UINT64_ARRAY(env.gpr, LoongArchCPU, 32),
+        VMSTATE_UINT64(env.pc, LoongArchCPU),
 
         /* Remaining CSRs */
         VMSTATE_UINT64(env.CSR_CRMD, LoongArchCPU),
-- 
2.51.0



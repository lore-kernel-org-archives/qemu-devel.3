Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA943CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 12:43:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBuXp-0002Pe-4c; Thu, 23 Oct 2025 08:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBuUV-0005YW-BV
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:32:33 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBuUT-0008RU-4U
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:32:27 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4710665e7deso3818695e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 05:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761222742; x=1761827542; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Kvjs75qZYXzJtgjOCgCUdq6Pu4BO5ORL4SkTS1d+ok=;
 b=cZS76eJoTIiiJJNW8TTQmvmI+z9czLAYye6vBDkx4XRAHFOOlGatyZQ9DUNR98KUiY
 fHE4swXS64Mz2DXvpRyKIhA3LwHtI+7MoRl7sIw49/saWBZ1gYHz7atxWWgGZpLtV37a
 ts8aN0GXocIokV8PhnRKfX3a10//NA8fQkiR2Qcfen2xH3fvg4zihd+mImHzl5FUIgDO
 AdrAfnN13VjmZSTG7+SpAo96VOvE5FMrPBDu3WXZWJnjDzibi4WWOhOrOtwt8bVaFK21
 ntd1VdC8um0bcfr6yZ0qURgCGJUpGHUMo2SRE3ZvSnDZHMPIYbRdel3hKuNjNLBgHek6
 hKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761222742; x=1761827542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Kvjs75qZYXzJtgjOCgCUdq6Pu4BO5ORL4SkTS1d+ok=;
 b=QEfgr3YJUlTSElFgZLJ462EhV5BT23DFp7z9qn0buBCpAUPfMSAie3rnyJ5sZCwF4d
 G5INURnIKaVN2Y6ikoTVLwBzSMsSGlqgzMf7NH2HCNFoVaZSOeRq4TEvCgT0QcGAEsUv
 4ypvOuyfHlLZ0SsFPvic3TqoLwMypN2kUzm9Unj3qN7QQuNJIYjMfo0297CBrw2VY98l
 dqbGK3A5lW0KV3MBRCtgQZ2dQh50inZd40nvZq5Ypkl3FoNJYM6KIg1d2PqIJkCLOT4d
 VnA39G/BOW4cuwwifBY2MbNUqM+JfdwCOOs+ZDW/2gGQ5b2QrFDfwCOs/GZjA3avnj0J
 luuQ==
X-Gm-Message-State: AOJu0Yzc9Eg6242wWdYOo18XxG5Ji7yq4LfFjKdsm3H08WLJr9DluM0/
 J3B1itWj270aYtO9X7GwYEhqPVLCCmTMUjUdM7KYX1xDKaTtLBuf0Wvm908bnViGChl5uhuFL8b
 OINr882E=
X-Gm-Gg: ASbGncsf/JmbDE9Zl0RvFEClBQfw2yrMw9jTj/urEv7HlDvXXdY8N5cRyiiMlrJed2Q
 IzqrTNhmlZ/PJmkXROBHiACAtpDDa0cRf4r1G5E8T3KVlPD2eEtxCMsfYCzbGmQkPl+LinTE+vi
 017ZjQX1dejY9/Wu1TnCXxgqkjU4oY0yZs9rssp45sp/rZVmp0BvsATkYA8yS8jvmfsEfjfirlq
 UOAULkw0Hk0Z0tb/V7i4hsxeposqJEUi3lEHj9wWBDGGGJm5rtZeo+yaQp6pxhjsZPP5BnZjy41
 WpwSM44phO1rH1yGv9nxIVG2YFGSqVOHwhGCfxN2yFzRgQlV4oW9RJfSCHz1PMrEZtj6bY/Q0YL
 CTHZhD9P1oiMKSnZtgYXAYPnLuWXLEHhwnYEUL+RS+FbM3cikJeB+jlvAG0qLmAdQJjLNDXvaRS
 JgnTxoWykTyFprvNFj2vehkZ3hllHrMw1njJR72Gfo/eS2KieIzPw12AApIxWK
X-Google-Smtp-Source: AGHT+IEx8BFpjNXhusxQrpqpHoXCU7z+MXPRfMepaQ3/Co4IjjhB0iiMYA7kTEFc7OtLYixtJcW5wQ==
X-Received: by 2002:a05:600c:8714:b0:471:b5d:2db9 with SMTP id
 5b1f17b1804b1-475cb03016cmr15327865e9.21.1761222742547; 
 Thu, 23 Oct 2025 05:32:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c4281314sm95056335e9.4.2025.10.23.05.32.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Oct 2025 05:32:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Cameron Esfahani <dirty@apple.com>
Subject: [PATCH v2 57/58] hw/arm/virt: Warn when HVF doesn't report IPA bit
 length
Date: Thu, 23 Oct 2025 14:31:41 +0200
Message-ID: <20251023123142.8062-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023114638.5667-1-philmd@linaro.org>
References: <20251023114638.5667-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Emit a warning when HVF doesn't return the IPA bit length
and return -1 as "this accelerator is not usable", allowing
QEMU to try with the next one (when using '-accel hvf:tcg').

Reported-by: Ivan Krasilnikov
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2981
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 175023897a7..1d65fa471dc 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3225,8 +3225,12 @@ static int virt_hvf_get_physical_address_range(MachineState *ms)
 {
     VirtMachineState *vms = VIRT_MACHINE(ms);
 
-    int default_ipa_size = hvf_arm_get_default_ipa_bit_size();
-    int max_ipa_size = hvf_arm_get_max_ipa_bit_size();
+    uint32_t default_ipa_size = hvf_arm_get_default_ipa_bit_size();
+    uint32_t max_ipa_size = hvf_arm_get_max_ipa_bit_size();
+    if (!default_ipa_size || !max_ipa_size) {
+        warn_report("HVF didn't report IPA bit length");
+        return -1;
+    }
 
     /* We freeze the memory map to compute the highest gpa */
     virt_set_memmap(vms, max_ipa_size);
-- 
2.51.0



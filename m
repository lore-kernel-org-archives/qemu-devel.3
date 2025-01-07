Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFFECE77199
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 13:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVA5o-00062O-Mg; Tue, 07 Jan 2025 08:58:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVA5m-00061B-Aq
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 08:57:58 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVA5i-0007OU-Bg
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 08:57:56 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-385e2880606so11269652f8f.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 05:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736258271; x=1736863071; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=29ryXXeGEICQxSfvPRPbEUxvd1BKN02Nr/kroYSh1J4=;
 b=hAFHkKF2IHF9p8xL0mnpViHlwlKqzccS4EZQyvaI7uxCevueQNlvVJ/Iu8dqWjuuNk
 bvXlnW6a1BrtKooedR1Q1cZ9T+VHEZ6p3DHk2sG6kanJIVmF+cwU5TuhvcD7kxPKzdUs
 jQbs4g27q4YAKKur5hj9yyFrUaHvqB/+bNtIhpsOVwlO0gXMA72NT9kbkRNcBW+mBVAp
 Kaqv3aHZeW+dCIGp9fCdlOuyyhLZXKqBHNHPtYfd6laTfa9hSrsAXhLdLbZeVnfM/9Ek
 G6TSLf/u396+xUuBlr9+rb9yAkOMob/VbcJiF01o1DT42TdkbhRTcLTF985KpgB0lTgq
 WLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736258271; x=1736863071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=29ryXXeGEICQxSfvPRPbEUxvd1BKN02Nr/kroYSh1J4=;
 b=HHFYOZ4Mvvc1qlMf/5LF+0cA9fZ3zETN5Ksq7kN5QCA+g1lP9wsDJWZ+Vb6yaK173f
 rnPgMpmZsyl2KUtzDLuG/4qCjgIpMR3XwtlhwxNMZCtmr+J2Rglz5iq3jc2V4D5z7k3C
 17+nxLgDE1OkTKY2zZeHXa19a6J8VkEDB+INlHbD5FPwaBNtcgvSI5YnBlN7oIFcjPVm
 QL3psKifuDPLR5LjfcWjv058tkcgfzzcTmUqIcqwUVKkU5A+PmdUavQYmKcyUVlvQp79
 yofVND02Ctlv1wBl2EKEdJlfAsFHWF2Jy8t61i/971XmhNtqundBS4ferH3fNyOpp4MP
 auLw==
X-Gm-Message-State: AOJu0Yy7NdqlVZgOjJXhojr7ULEJHczOrwtX2vH9en9nfjPdsvUZUSQB
 nzb9LjkHUnGrdm9Tosxy2uSSjzQn9mh9VAYn8oE0upCUezUeKh4KUnXCBl9bptiNKptcqx2qNcS
 tKXY=
X-Gm-Gg: ASbGncvu5wIqI8PEki+zO4OmvICWr33wIKokQLBFQx3hx54FNb6A+D3GpD6DB6iL7EM
 n/Kf/N9cDCqYudXp4SugxuzGPueSYfbhnbHUE1+ePZ0r2X/pjtmh+9XOX2AQ23Bmk7TEHYYRA5e
 oaKmetFyqVrRWoLKbgyQy7Ua2D4sFJEM2BsHzPnIb5JyL+fY2OVGmh0HDx4/whup+6ThcoBM+1h
 0U9oVtv08vDe7/d8GeBgAjsvtCEHQEGiu0v5GofGzjGtSjl3ezCJwItLRNL5+zxSWYUTiDOph68
 lMOSQUraP4BUpgzY9bjA9qJ15NkMnPY=
X-Google-Smtp-Source: AGHT+IGStK6bi4yYWFh7qrDnC5BV/rEpLsNmZMB7fYWmrzIM2hJM8pfaS1IvUzniybBVji2LXlE5Eg==
X-Received: by 2002:adf:a445:0:b0:38a:2b39:9205 with SMTP id
 ffacd0b85a97d-38a2b3993dfmr41031960f8f.33.1736258271639; 
 Tue, 07 Jan 2025 05:57:51 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c847d7fsm50397069f8f.60.2025.01.07.05.57.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jan 2025 05:57:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Anton Johansson <anjo@rev.ng>, Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>, Thomas Huth <thuth@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 2/2] target/arm/arm-powerctl: Restrict to ARM cores
Date: Tue,  7 Jan 2025 14:57:39 +0100
Message-ID: <20250107135739.48324-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250107135739.48324-1-philmd@linaro.org>
References: <20250107135739.48324-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

When running on a heterogeneous setup, the CPU_FOREACH()
macro in arm_get_cpu_by_id() iterates on all vCPUs,
regardless they are ARM or not. Check the CPU class type
and skip the non-ARM instances.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/arm-powerctl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index 20c70c7d6bb..07529ab096e 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -36,9 +36,11 @@ CPUState *arm_get_cpu_by_id(uint64_t id)
     DPRINTF("cpu %" PRId64 "\n", id);
 
     CPU_FOREACH(cpu) {
-        ARMCPU *armcpu = ARM_CPU(cpu);
+        if (!cpu_is_of_type(cpu, TYPE_ARM_CPU)) {
+            continue;
+        }
 
-        if (arm_cpu_mp_affinity(armcpu) == id) {
+        if (arm_cpu_mp_affinity((ARMCPU *)cpu) == id) {
             return cpu;
         }
     }
-- 
2.47.1



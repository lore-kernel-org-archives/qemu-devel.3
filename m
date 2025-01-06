Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA0FEE77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 18:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUrlY-0002jC-Qa; Mon, 06 Jan 2025 13:23:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUrlV-0002iW-9a
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 13:23:49 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUrlT-0001nu-RK
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 13:23:49 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43621d27adeso101941645e9.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 10:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736187825; x=1736792625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Zc910N+AlVa8sNqkW1fDdSYDbUFhwPoB/5c2YYYivWo=;
 b=NwAnbMoS8EVZwgyU0zwQzcyGYGb+FL2nLGAXcydvmnBi16rLdAG3o8hnV3bjcxTxkP
 EHyFHTAgVI57zoWmk3r83H97MICZZqnlNvxw3KZrZb/6j6bzj8nZz6VhJRTWy+wG7MyB
 socDObxC0USZk6MxUdpVNftaTWb2SQradhnVZKWYkc7FPTrXlegvOhpl+XG/jMgRbVYa
 1y3ELcZH5RbChOwF/x5vGDQFHQLnjr+ODuDlZGQBVaabdC5SgcK3toiyW+u4PjtVjjrP
 9b5wyBL3VmTPyI6zWeundABw6bBjA47F2+Bvj4JaMPYuaIEkV+jBgnhQWww0XjXqI0lp
 lEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736187825; x=1736792625;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zc910N+AlVa8sNqkW1fDdSYDbUFhwPoB/5c2YYYivWo=;
 b=XKVpgvd3qdXCVhq6t5I8UcdkaW5G2hQtnfrOBVQFKaDPmJcOGOo44DU6vqRniWR4rz
 FttX6nZF/wTr2XlPogCrT570bjbFoPOXQbhHnJE3S+mHRbNsR5S7hIAF/ubfsqZpwtQ2
 2cImByo9PiBLKB1jFh8DV/ECrENCLI/RoKGLNcwxQzS795DEAw7yedYrx5/Vdfc/1ds5
 ARtPxW1Ia+kArQZkhdQE5LC1pu7ETtW0D85PO5dQSbsb40uGhYk4wRK5KvKLjFTSKTEu
 YHcf/y+qyt/TfiGHXw6Mzau1Kw+PxyLhHYFK9nkcRhMWm5fCN6e6rOOgXzozTYacFszM
 jZdA==
X-Gm-Message-State: AOJu0YwXt2rFDWavkGohZpoH03tBND/zAK7dgEviObdrRvB+8ivuQvGM
 sU9SehVqk+DIq684OSDPu92AqyaHvSel+42jONtmwm9GI6Dt1q0BT2bAosWA5gNLFCdpH/KeOaN
 zZ3Y=
X-Gm-Gg: ASbGnctRwbmLQ9eZBE4cA3nOFFOwJFGx1/7X9/23rOitQ44TrMXQ+VvlQKOgao3MWRq
 hFN2nGrb7pDDQ8srtbWR9c31wGcWuKp7Lfg8jxFa9xUeVLLXO17CRRIL1XGi/Dub6fBLnAS6y4s
 QYkXzl1x+tGYRVWw8z3PP/lRoX7uNnGIRHYYFwPz+NGw1ftun85RRLUjRABdbKETQTVUBn/A1Tz
 vjXgavyDrrm9gyKoKaZnRtH2HCN71i3ZSjtyUubQ2It87gDrf9CLP6AVcll1pVmRPzHQbtcysM4
 Wc4hnZyDUYygmFvJcQPv4GC1hf/ymtk=
X-Google-Smtp-Source: AGHT+IF+ESz+/vY59sRoPd0RlTJ+2CuZ6LSk/TRhsJqMtT2OhvM/KTICdjH/Q3xaZxi/9Jhrd17dNw==
X-Received: by 2002:a05:6000:144b:b0:385:fb2c:6021 with SMTP id
 ffacd0b85a97d-38a223ff339mr54211455f8f.39.1736187825609; 
 Mon, 06 Jan 2025 10:23:45 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8acc02sm47920579f8f.104.2025.01.06.10.23.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Jan 2025 10:23:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Eduardo Habkost <eduardo@habkost.net>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH] target/arm/arm-powerctl: Restrict to ARM cores
Date: Mon,  6 Jan 2025 19:23:43 +0100
Message-ID: <20250106182343.35859-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
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

When running on a heterogeneous setup, the CPU_FOREACH()
macro in arm_get_cpu_by_id() iterates on all vCPUs,
regardless they are ARM or not. Check the CPU class type
and skip the non-ARM instances.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/arm-powerctl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index 20c70c7d6bb..a080a6ab79f 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -36,9 +36,11 @@ CPUState *arm_get_cpu_by_id(uint64_t id)
     DPRINTF("cpu %" PRId64 "\n", id);
 
     CPU_FOREACH(cpu) {
-        ARMCPU *armcpu = ARM_CPU(cpu);
+        if (!object_class_dynamic_cast((ObjectClass *)cpu->cc, TYPE_ARM_CPU)) {
+            continue;
+        }
 
-        if (arm_cpu_mp_affinity(armcpu) == id) {
+        if (arm_cpu_mp_affinity((ARMCPU *)cpu) == id) {
             return cpu;
         }
     }
-- 
2.47.1



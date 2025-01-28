Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C1CEC0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 14:22:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcmUJ-0008KG-TO; Tue, 28 Jan 2025 09:22:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcmU5-00089B-FX
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 09:22:36 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcmU3-0002Mt-JZ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 09:22:33 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4361b6f9faeso36461625e9.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 06:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738074150; x=1738678950; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fwXtzSsp3Wrsq7TzutaYeT0jWiU8kps8I7b8yY/9nhU=;
 b=vR+5kYOuo5nLCtHiXUYmRklsOoNxvJ322cR1L7dRRdsUyiqqm457bwG3T4P/beoCK9
 vSQ2Z2jwwn4m9CHtLFVGrElEf+HCGiLxUgXVRx0Fva8qvklK8JllId2IVVUtgVOjKTc9
 bqxLNDTesKDfcFaSEd9mbgHytoaODMK18PNX3JRwYwvj6hYjsK/jYuwEbnUJriq4AMOz
 9YqLaJSkq8FekObaC1FvZqLKUcGPO4KnJ7Tm+oOCaWZ1KuEReV6BJ5Nfs7IYD36NxQlA
 rEQZhfTG67z/9BrhbKOx9UfX2bksJy04uxqb/YAmJ0nxNEaYzSLihVCWUmfWhbGt0mLs
 Lm0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738074150; x=1738678950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fwXtzSsp3Wrsq7TzutaYeT0jWiU8kps8I7b8yY/9nhU=;
 b=tW7SvLV2GTkV6Fk7QM6INe/vx5xj7/bFUbV97lRuuNzKCQFJ5Ka2sUOP6UL4xYK7RU
 qp6FOC3qtyJF7QS9nv6G19biqumSHifbJGBg5uikdqhgc3eHyEjCG5E/+FIky/sddh/x
 QPiFu7VXY9S9hA8v2eojQelfJPqtXXmBqMPu7fRm/75ikBcw/hTm7KaKPFS1CmQDRqW+
 xo41V/LPZBRSUoiWSxAcUas/zeyQ98YdXCY7x8Jk2Kp6riRTY4UiJWqdf0jpKLkwWBhv
 EahXfgBYIFziDQ1du7yOg0JMsBZkoyJaoHA4i+noRiqVND79KJtV35EMgNOlG40u9Ujy
 wyqg==
X-Gm-Message-State: AOJu0YyU4VLK9UelG+qWVKXhbtpnxGyqSjWtD+qb2ly5X4/rY2t2+xT1
 gZ4pA5JEO1tVH2706Ki/jaKGX9oDRrc152Jv0UKKBZIJnsG7qbMxZQMuSA+f77XDXTr4cDPs3Qd
 6reM=
X-Gm-Gg: ASbGncuRMa007jYHrANpXPvKv/8Nch7TelXd1lP+09+rjIslxJZFfc7X51Lm/lVDglQ
 DrikQDHKt3RuBle13j77jvw9VUevh5ZjcHU+NY69gAoWSfMr+YqElei+MqBFtC2tcomiFLLcXwk
 4kNhWbk2vasuwXwxbHOP+AB1ua7ztx1S5J1YGzLNbPb9nGuZ19f0FgdJc09rOavsh1O/M8Jtgje
 T23GXkT0CGU0HmXOEogDexBC8CCaTV2vdOrfoHmDX3SvKObYYj/s3MbyQn58LLFpvzznbukSl3l
 sgqOiOhAGbTftNTYSnG7p208eyA7CSe/t98nY1fuDAFBVBgI28ZD0uHWMl4b97755Q==
X-Google-Smtp-Source: AGHT+IGJgZU4Cp2hilxwmoMaixsHyforairgw/17QEoYqTReWbKeDv+qCHMAqmyxnXcqNHDKAhm1lA==
X-Received: by 2002:a05:600c:46d2:b0:434:f1bd:1e40 with SMTP id
 5b1f17b1804b1-438d596d1bamr27108845e9.6.1738074149822; 
 Tue, 28 Jan 2025 06:22:29 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a17d7bfsm14358242f8f.35.2025.01.28.06.22.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Jan 2025 06:22:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, kvm@vger.kernel.org,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH 7/9] cpus: Only expose REALIZED vCPUs to global &cpus_queue
Date: Tue, 28 Jan 2025 15:21:50 +0100
Message-ID: <20250128142152.9889-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250128142152.9889-1-philmd@linaro.org>
References: <20250128142152.9889-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

cpu_list_add() was doing 2 distinct things:
- assign some index to vCPU
- add unrealized (thus in inconsistent state) vcpu to &cpus_queue

Code using CPU_FOREACH() macro would iterate over possibly
unrealized vCPUs, often dealt with special casing.

In order to avoid that, we move the addition of vCPU to global queue
to the DeviceWire handler, which is called just before switching the
vCPU to REALIZED state. This ensure all &cpus_queue users (like via
&first_cpu or CPU_FOREACH) get a realized vCPU in consistent state.

Similarly we remove it from the global queue at DeviceUnwire phase,
just after marking the vCPU UNREALIZED.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 cpu-common.c         | 2 --
 hw/core/cpu-common.c | 5 +++++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/cpu-common.c b/cpu-common.c
index 4248b2d727e..72ee8dc414e 100644
--- a/cpu-common.c
+++ b/cpu-common.c
@@ -91,7 +91,6 @@ void cpu_list_add(CPUState *cpu)
     } else {
         assert(!cpu_index_auto_assigned);
     }
-    QTAILQ_INSERT_TAIL_RCU(&cpus_queue, cpu, node);
     cpu_list_generation_id++;
 }
 
@@ -103,7 +102,6 @@ void cpu_list_remove(CPUState *cpu)
         return;
     }
 
-    QTAILQ_REMOVE_RCU(&cpus_queue, cpu, node);
     cpu->cpu_index = UNASSIGNED_CPU_INDEX;
     cpu_list_generation_id++;
 }
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 8a02ac146f6..df7a6913603 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -218,6 +218,8 @@ static void cpu_common_wire(DeviceState *dev)
 {
     CPUState *cpu = CPU(dev);
 
+    QTAILQ_INSERT_TAIL_RCU(&cpus_queue, cpu, node);
+
     if (dev->hotplugged) {
         cpu_synchronize_post_init(cpu);
         cpu_resume(cpu);
@@ -226,6 +228,9 @@ static void cpu_common_wire(DeviceState *dev)
 
 static void cpu_common_unwire(DeviceState *dev)
 {
+    CPUState *cpu = CPU(dev);
+
+    QTAILQ_REMOVE_RCU(&cpus_queue, cpu, node);
 }
 
 static void cpu_common_unrealizefn(DeviceState *dev)
-- 
2.47.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CBCC282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 15:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDVQ-0004Tt-4E; Thu, 06 Mar 2025 10:51:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDU1-0002l3-S9
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:50:02 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDU0-0006R3-6M
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:50:01 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43bcfa6c57fso5151285e9.0
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276197; x=1741880997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0UFUf/+4qSNn3mLvNY6YFKF7Ib0WjHNATMofJQT7dhg=;
 b=QGcalyBpaU6o30J68Ud3hFKeaSuUxu5HTJYcbF2PJVSLiD8+EvnYbz9/149pwRiAXH
 T2mBXoQfvZrM36Uql/w4tCIyEbSQ4VZPheQ9nBG9oogCoVePCp3rqWk7XLcgRRFRq7Ac
 ikRx6R8/iyJH9fWy9hXRwWWrx5yT0gOd+2upBYBja/CfistMbs5pQb3fnkJ2kvAnNwGG
 u+sL+4+/4hohglyhl+Jq4BCYKEv2b9Xzje+nvXxxSEvPMwAZh7DsTwHbDWgrdYUUm/s9
 LH5bFVM0oJviIKlC5InbuziKNlOxl/EvseSRztNIyrxegxP78i9bMHaX/7JQK+l/5X8w
 0NPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276197; x=1741880997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0UFUf/+4qSNn3mLvNY6YFKF7Ib0WjHNATMofJQT7dhg=;
 b=TR4pcAcfMz87rqOi9Ctb/O2wwYJZOJF2E+E7SyzAD/K7oHmCPey0oRyrGRLoKPSYTx
 ZR7B+KDQ6QVoeqKaKkHELLTSyEt1tR5cv362XM4GR1ZrFSn0qi0JZrcVE2VkqlzrrIRd
 3UIqblk0t6Q9J8e4YMkSvIsaboGIaeDTaWRzarJMVHmpovBrQqxvBJVmSJiFZfBGa8Vj
 sfQeOXutbVA+FJwSYTJDODEydT6En5waJJKvb04VFeJCzVV+yBPbtWLteRjgyGVegQh/
 6rk92+CH6nlJmddGPeCjJfC/Q89/d8pIp56WU3qzIaymWZsOa1/eMxNPXYkOzA2LpwQ9
 KU/w==
X-Gm-Message-State: AOJu0YyYD9YL4BLmWhfJcuhOqmUIIcjhdi9HKBgq+Se8sFwHLqJm908j
 vTqJX7klX5DrsN9hMqYr50Ua1W6kOM8NT9xtBLhp4YabRULC4nuy+oIdAbaAIxzvcVpOSOUvPq9
 J7ag=
X-Gm-Gg: ASbGnctKvzGAYklN7e5tXnvqkdw6+G6J8Ei1Qwbds233XZWCaQsLP8YAqjbOJ2/6VT5
 HrIdpQnqsQ6N6DcWXTbuhudf5nfd8wQeZxQUahYBb5nlAkZnOx1eiOsYN9VWlF8EdqpO6hC6ZLX
 OPbN1QFmrk/c3dy1mhOu/rlDNAbhjZFexJtt8/1orS/geLCbLbz5ScFtFrJQKKKwRBsg98AlUQj
 prMcFbD3qYEI4jVdTO1NR3iwybhinI6ioOt8A/9xQNGdyplMHeJDPDLJGHGc9TlEaIcFxfJPVhn
 3rzIc+TScbh/5SD0MtrNzzq45S22XgSd1Rru4A2QosfdIDERHPefb0oeZPr+EfaVn7Xn5woFNIV
 YMpM//h7O2p1wfWhuGuA=
X-Google-Smtp-Source: AGHT+IHCO4D1La4oULtfgVO3iebov362SJt1qEPr1SunPSbW7jIrz3dUNlGW3OhP585oFJd+gpW/zg==
X-Received: by 2002:a05:600c:1988:b0:43b:c590:173c with SMTP id
 5b1f17b1804b1-43bd29c7904mr59604325e9.24.1741276197322; 
 Thu, 06 Mar 2025 07:49:57 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdfc96sm2444270f8f.31.2025.03.06.07.49.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:49:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/54] target/openrisc: Call cpu_openrisc_clock_init() in
 cpu_realize()
Date: Thu,  6 Mar 2025 16:47:13 +0100
Message-ID: <20250306154737.70886-32-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
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

OpenRISC timer is architecturally tied to the CPU.

It doesn't belong to the machine init() code to
instanciate it: move its creation when a vCPU is
realized (after being created).

Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250114231304.77150-1-philmd@linaro.org>
---
 hw/openrisc/openrisc_sim.c | 2 --
 hw/openrisc/virt.c         | 2 --
 target/openrisc/cpu.c      | 4 ++++
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index d9e0744922a..83d7c2a8afc 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -306,8 +306,6 @@ static void openrisc_sim_init(MachineState *machine)
             exit(1);
         }
 
-        cpu_openrisc_clock_init(cpus[n]);
-
         qemu_register_reset(main_cpu_reset, cpus[n]);
     }
 
diff --git a/hw/openrisc/virt.c b/hw/openrisc/virt.c
index 9afe407b00a..3055306783e 100644
--- a/hw/openrisc/virt.c
+++ b/hw/openrisc/virt.c
@@ -487,8 +487,6 @@ static void openrisc_virt_init(MachineState *machine)
             exit(1);
         }
 
-        cpu_openrisc_clock_init(cpus[n]);
-
         qemu_register_reset(main_cpu_reset, cpus[n]);
     }
 
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 0669ba2fd10..785b065b513 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -165,6 +165,10 @@ static void openrisc_cpu_realizefn(DeviceState *dev, Error **errp)
     qemu_init_vcpu(cs);
     cpu_reset(cs);
 
+#ifndef CONFIG_USER_ONLY
+    cpu_openrisc_clock_init(OPENRISC_CPU(dev));
+#endif
+
     occ->parent_realize(dev, errp);
 }
 
-- 
2.47.1



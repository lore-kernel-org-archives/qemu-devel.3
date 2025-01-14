Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15746E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 23:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXq5y-0004JZ-AX; Tue, 14 Jan 2025 18:13:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXq5v-0004Ix-Q2
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 18:13:11 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXq5u-0004tY-0b
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 18:13:11 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-38a8b17d7a7so3118456f8f.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 15:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736896387; x=1737501187; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6wzr+JsOJLlCTx19NK38EsdglqkJR+xQVzO0RmwoSsg=;
 b=lI9kBzOfvAe2ThncFag22/Oz0kTFtQY7reSyUnITu2u6H2zkwT6qGDsQQqrfVDyXzz
 EQ9VfJEJhxXj1p3h0i25M9pXH6fybAfQ8tD5lRMEgW4MrkiJFDRam8LS1QcyqRU1jWS9
 7UyQvdGibgLjCuRYljQqttmapOCIdXPAxhMYKgkUWQO+oFb+NSXDo8SR0q4VD8YRKkxu
 YAtqyjNWReD15yibB2E48TIZQbTcWqkMGatyKw44PpqdI8yKMdq4FMJxYS6ZK180Z6Hp
 VT0PlBGeZfhKFGP5S+Odp1u7IHqu3hrvObdUYbA1qsy4eKt28qah0ocI6oHBU1o2D94m
 8bJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736896387; x=1737501187;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6wzr+JsOJLlCTx19NK38EsdglqkJR+xQVzO0RmwoSsg=;
 b=uzCiHk/giIf3ALkniiIP0PhGOIBHWow1rMQvWtJQR5W+jrES5OgeFUHBuFcYOG5gc9
 i0bmzzhMiqrNRjZVA9YJqbz0qE4TMpiX6E5qqo5IuZ7bmUWxQaKiMnU9ggLTF30zqdv1
 W68uQf2gQSoFdzZLNGN9z/v1Jsrv1xxLIZFXV1pA6QKMRK9mK1TNnENYJucmvI+trdXz
 IIEwVBNJI12CDMTyFrb9IuId0q6ryKaAhpcR8x8JvXHZmqVGoQk8oLi1o0k5XeuVtgnb
 L/ljuz7N0hMmjxuPChb4cClMXzr0IQJPVGQh7VYfST3XGrtNRCzMSzTEQ5z4bSXm5aGx
 +mUA==
X-Gm-Message-State: AOJu0YwCw8HG5Ar/qPFtU9hOxzIWIcK7I57dMbY4j0Qv+kQFoG0NzQgP
 /0ci1+lX7I6v3Tu3aWqTkS2eEyDvydBJy/RSK1wKpDfmOefSAPt65dR5LWwEAAXfRIU9tJRiW8y
 un7Y=
X-Gm-Gg: ASbGncvDPD743jiHUwIApLunsVQfOUt4Cj7owppjBfM+viBF7MngUGbOOz+nUxfdEzw
 rliYYvS75wNyZr+boYYzQFpbRqS0XSfWwKhNvV+P5h8aiGhiOHRg8JZI7/aP9463hgoaCOWeHdp
 eWUSy5gWOysfIVUtzxLGs9cPG6zi8UpzUrGaTJgYXo0r7nXHuFhAzVbDQGRbJV72Gwn+g9YQXya
 9cMfzDpTAsh+da2OjUK13DagsK7z9gJYU9Q8eN7WtEhE9B9gYMgHApEAcuuGktR3OtOJ/nQ0d9J
 fVPa3w+tTKAcb3ZQbQlcSdszAFHoxfg=
X-Google-Smtp-Source: AGHT+IG8RhPIllmAFbSnEzPhchZx0kebPpuqg/Qoojag8Yn3SxDTsi8Tw14nmMmqJI514Op1tfBIAA==
X-Received: by 2002:a05:6000:712:b0:388:da10:ff13 with SMTP id
 ffacd0b85a97d-38a87306e8bmr25764377f8f.21.1736896387317; 
 Tue, 14 Jan 2025 15:13:07 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4c1d13sm16228289f8f.91.2025.01.14.15.13.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Jan 2025 15:13:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Jia Liu <proljc@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH] target/openrisc: Call cpu_openrisc_clock_init() in
 cpu_realize()
Date: Wed, 15 Jan 2025 00:13:04 +0100
Message-ID: <20250114231304.77150-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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
---
 hw/openrisc/openrisc_sim.c | 2 --
 hw/openrisc/virt.c         | 2 --
 target/openrisc/cpu.c      | 2 ++
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index e0da4067ba3..d7f97d19913 100644
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
index 7b60bf85094..676cf8d692d 100644
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
index b7bab0d7abf..291fec04fda 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -165,6 +165,8 @@ static void openrisc_cpu_realizefn(DeviceState *dev, Error **errp)
     qemu_init_vcpu(cs);
     cpu_reset(cs);
 
+    cpu_openrisc_clock_init(OPENRISC_CPU(dev));
+
     occ->parent_realize(dev, errp);
 }
 
-- 
2.47.1



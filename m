Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90093C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 14:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcmUK-0008Mw-RI; Tue, 28 Jan 2025 09:22:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcmU0-00085l-NA
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 09:22:32 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcmTz-0002MH-3H
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 09:22:28 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-386329da1d9so2946761f8f.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 06:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738074145; x=1738678945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tw046dW5+uhhYJLaed8H1nN+PEtNbdWPjJLIYS364MM=;
 b=YKno2KaP2dzwxTaB/PiXXuz+K/eXiPdccvmP5hSAxH1W5+BaYZckgTNiYgtREK3+QR
 CG2aRMqxBLjGcRAIcy/FM8e/+g+0knSti3rPq2CcKDiOokosZJ4H1bAOTvkPa1o8BQ+h
 27690LMDUIt1+hVVBgyCVNbQ9KSpmaQndpP2bZFDl0WbgemVMM5TUo05bShR1FoLnoB8
 n+/JILks46I06DWwF7VOfsEwSPUKHOynfWXWu9KR/B9lq49FxC5ao6pewTWKWhBCFzqU
 j6g1iu8V1V/ukBIS8fbHeQ3MbXuIiVu6KBDFjgAsDXBtvJsaHR81PepaAsIeMBBhktaB
 Ecug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738074145; x=1738678945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tw046dW5+uhhYJLaed8H1nN+PEtNbdWPjJLIYS364MM=;
 b=QN2Eb9T9pcbm1hoLnx3SSLcX7yQB71DVNN0ADFEyiFq6huy0Nf4DNJYOW2KKqAs3t1
 L/tz10/PazGkFezFCCQ7NkhfKerKwHxoOYjppF+6hGMLMqhr/DOR+gc4wr3Jn8urb4Ks
 gzK5vvm0qbgikcGePN8vK+2X5HBvRWj/TAJ7/lMoET/edbmC04RyZ9FXw1SN7qtTYfbS
 2CjKOqKdPoewvDZy7N7w8Jy/ZCZbzFU37wAvEAp1Vn7lIoWTqjFAIrJLE4doRZCFO8dq
 Gx4VxSn4iU3omUFHzp7XxhFI3pcmuYlDNjjkyDKlglvKssBoD0GZzeav5dYqdcHPyCFs
 MjwA==
X-Gm-Message-State: AOJu0YyxUpYyqb96W0q8JPh298n0KhMJChwv/c6Or70WAGpcJH0tXmUu
 yyzqruKBuBVYvosGxxRoax5gAnFwy8tsXwPiE4hFM1DsTi8s0c81Ro8uv5wdQgk7e9+r/eDEHyV
 JnxI=
X-Gm-Gg: ASbGncvWaq/Gv0fxPhXRkoX//UZKODyLs7CngiP/qrk+zbMDYuKHmEpl6gcO7hNIZnH
 k4f/RSc6V+3GhfP1CcCO5/UvFRw3SHvNqbCfaNJ48e0TYJRW0YnmCg4zRjjJ8iPLd65OmFMqR+h
 3WAZGpml3fzv9ILAueFfX+nW8Q0fBsDM/DQbLGOi0OuIpAkClz4bOsNhvJf+PHy4IGeOHqxSlME
 pJsep1APKE+dNVp8Zx0BTLQyDTCS2u+Q23Ia+Yi+i1Q/kGV4THsNOHGQNK3mTqGxiOLP9/pVyIP
 ihAm5eDPot0qqQznhC9IYnlKxGiYcmSe9L5w1KLxoJysf86uxKZXv3BfK94na/AeIg==
X-Google-Smtp-Source: AGHT+IEyyaAAlYQ5I3ppwUr7kelaVWlDzVIFlhZYrwH74VA7sdBpE5YrUhEnY7P3LEg7nQWsma+f4A==
X-Received: by 2002:a5d:47ac:0:b0:38b:e919:4053 with SMTP id
 ffacd0b85a97d-38bf57a993dmr44371093f8f.44.1738074144814; 
 Tue, 28 Jan 2025 06:22:24 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1bad92sm14282474f8f.61.2025.01.28.06.22.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Jan 2025 06:22:24 -0800 (PST)
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
Subject: [PATCH 6/9] cpus: Call hotplug handlers in DeviceWire()
Date: Tue, 28 Jan 2025 15:21:49 +0100
Message-ID: <20250128142152.9889-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250128142152.9889-1-philmd@linaro.org>
References: <20250128142152.9889-1-philmd@linaro.org>
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

To call the hotplug handlers with REALIZED vCPU, we can
use the DeviceWire handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/cpu-common.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 9ee44a00277..8a02ac146f6 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -211,16 +211,17 @@ static void cpu_common_realizefn(DeviceState *dev, Error **errp)
         }
     }
 
-    if (dev->hotplugged) {
-        cpu_synchronize_post_init(cpu);
-        cpu_resume(cpu);
-    }
-
     /* NOTE: latest generic point where the cpu is fully realized */
 }
 
 static void cpu_common_wire(DeviceState *dev)
 {
+    CPUState *cpu = CPU(dev);
+
+    if (dev->hotplugged) {
+        cpu_synchronize_post_init(cpu);
+        cpu_resume(cpu);
+    }
 }
 
 static void cpu_common_unwire(DeviceState *dev)
-- 
2.47.1



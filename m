Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F9CC3ABAB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 14:09:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9ldq-0000ol-VU; Tue, 29 Apr 2025 10:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9ldo-0000lL-Mq
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:08:56 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9ldm-0006IT-0y
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:08:56 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-39c30d9085aso4447634f8f.1
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 07:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745935732; x=1746540532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y41oplbkU9wFEHQN9IFbTeGkihP8bHFwwIYrwg5eFCU=;
 b=EYYe0DQ6Z2PJ3Wse7CLLsldjIbap0voSi6u6xk9zwq9jZmQ7kwN/Lqg+4dUq6JRvYN
 o7ueJ39lXmXbqtkchPrAan48Ont4A+rprmgnxF+rDfgHxezUIlk1ILmtxdTWavG9TSNS
 JfWT2WXdVfen4hTP/2uVTvXPP+eux4IXRPK8MqTg5W0X3evgZzBglOwPR4cSHH7m9DsR
 0/gTWn5NDz8qLb6z2KT7pOh+oiFE/EbkNXJNPw37M5OkGRbPS+d9OQPf6LklvDFMVcL0
 JmSIIFpGQSXQu40BbQhJk2Ohh0s6Z04DkOGcE6Dr4BpfFpZp3GCTyifIbgA0L7JC7owz
 xLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745935732; x=1746540532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y41oplbkU9wFEHQN9IFbTeGkihP8bHFwwIYrwg5eFCU=;
 b=ELOtlI/3UEfuUqqoc0Ogwbhuivo4MBPaY4SneLRDC7nWvSxDNOmjlgp+JVdCzujfKs
 woQbO0nGO3+SflmgIXi25Bgp46CdfLF2rnGzlW6oHWZOeks+adNQOVtF/VgjOIAWf8rs
 3i3AoLSCNYlEVEPjrYl5abS8a4DKbi7mVvYaJ93EP1MTx77uNbHDjLHYScaYjBHmAeO2
 2GAlxfchwIHmha3qA3rtBwzZnFIeHJ0jB7BuYWQsAoL00E7GART6WYLl+qEGHeBbma5E
 ri/jLInPfDYARV4v3Aw8mGE+g6lHLZyU0NFxKh+HcUrCFbd7+LsLnDv49gY+Ked4u1ew
 PYyg==
X-Gm-Message-State: AOJu0YzVtJ1tH7tT2z2Q+7WSk+QL5AqbccL5kcgNoF5hassAuPE1gAfA
 gLqOYXuRiMLbN944MxdQdgNk1P/Oh9H04rjTgoxhgYjAUe2tZ7ICoM/pC4KgYiOsXiymPBq8GwD
 T
X-Gm-Gg: ASbGncvLXOvqqaz/mITIL1JlPgooBjFfFc4SPeSAaPsARZJMMmuWnOZxtTgn/Wf4FBO
 1J+D3BnCyyxRc/nIdA2e+1vjNdbAo9F+F1z3i+XXPna2ylZWEufT9nUeKEdzBWHY1Xmd1mUMQWO
 tQKsY94gm4sgcyHfWPrtOuGBhWp3h+4aEi9Uuj9Bwsy9c304IxhGQYYieNPvY/p86bbeOrpQwoA
 J1flze/aMneZMeDWObp7h79B9ARwUFyDVAbM20/2YOhUpGGjJ9RSxAiDpiSOHPeeD+XNad7/jEr
 K8WI/xMgZ8ZXCeMsy1dgDLbCSNOUWOo5QL7u21JR26RrBrFY7PXd2h87b92fqpLIqHka2XvDbLS
 ksaxoI6RHWioXdSbAsBca
X-Google-Smtp-Source: AGHT+IEco0W5dgiz/k9F0w521n574zMOPJiaS2/f48WwzXtNScnfK9ipNQ6rnRYeDvAjM48e12A5RA==
X-Received: by 2002:a05:6000:1f03:b0:3a0:7a8f:db22 with SMTP id
 ffacd0b85a97d-3a07aa6b57emr7712782f8f.24.1745935732109; 
 Tue, 29 Apr 2025 07:08:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ca4742sm13810098f8f.23.2025.04.29.07.08.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 29 Apr 2025 07:08:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 05/19] hw/core/machine: Remove hw_compat_2_4[] array
Date: Tue, 29 Apr 2025 16:08:11 +0200
Message-ID: <20250429140825.25964-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250429140825.25964-1-philmd@linaro.org>
References: <20250429140825.25964-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

The hw_compat_2_4[] array was only used by the pc-q35-2.4 and
pc-i440fx-2.4 machines, which got removed. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/hw/boards.h | 3 ---
 hw/core/machine.c   | 9 ---------
 2 files changed, 12 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 765dc8dd35e..5c4e3d2a2cd 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -848,7 +848,4 @@ extern const size_t hw_compat_2_6_len;
 extern GlobalProperty hw_compat_2_5[];
 extern const size_t hw_compat_2_5_len;
 
-extern GlobalProperty hw_compat_2_4[];
-extern const size_t hw_compat_2_4_len;
-
 #endif
diff --git a/hw/core/machine.c b/hw/core/machine.c
index ed01798d37c..d66b02b564c 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -292,15 +292,6 @@ GlobalProperty hw_compat_2_5[] = {
 };
 const size_t hw_compat_2_5_len = G_N_ELEMENTS(hw_compat_2_5);
 
-GlobalProperty hw_compat_2_4[] = {
-    { "e1000", "extra_mac_registers", "off" },
-    { "virtio-pci", "x-disable-pcie", "on" },
-    { "virtio-pci", "migrate-extra", "off" },
-    { "fw_cfg_mem", "dma_enabled", "off" },
-    { "fw_cfg_io", "dma_enabled", "off" }
-};
-const size_t hw_compat_2_4_len = G_N_ELEMENTS(hw_compat_2_4);
-
 MachineState *current_machine;
 
 static char *machine_get_kernel(Object *obj, Error **errp)
-- 
2.47.1



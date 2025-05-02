Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC27C3ABB0
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 18:59:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAvaq-0007HS-UG; Fri, 02 May 2025 14:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAvaY-0006Bt-4j
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:58:22 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAvaV-0005e1-RD
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:58:21 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5efe8d9eb12so3680614a12.1
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 11:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746212297; x=1746817097; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gMLC32cD5rQa4ngqh9n69biVbtvyYihadQEH/qk7LQg=;
 b=bTj3zb4YYpplrpSJQdjGYcGtQM6woAhzXH9QWA7breTP2nUTldJL+fCj2tOkJtK5NR
 HXCs57b1nsWkSyuNhcPc6Kb7+cdRzAVxRI0hn7n0YRAe3uqDBxIL3TJ4H2sakRc0/lNc
 HOR2c56J+CHPHbj9JrTuXXnfOfxE8DDdlVYgtPqcUE0ozc2TFd8IhiLPrOiQdBe2cuzZ
 ewYyArOiqV30tZZIbTlDGmnFdZckm8OB2VKvOfcVYMZlr6xnQdcKINn6MO2O+uCALOAt
 2MPb0kW2DlqNP8fym1YXk5HdiHVClirZvWAu84z7I4R/OgAMKunPj4bjadEFhOoFWdjc
 KWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746212297; x=1746817097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gMLC32cD5rQa4ngqh9n69biVbtvyYihadQEH/qk7LQg=;
 b=AQh22v6Lp0NWdMTEw4ONe/UiVyUJ0+Vc15N0GBqulkdUFM14kKDwyA2x7jXxjs+nZX
 cz/svCAvLqs5B1rloMbJ/cz1fjL0O/tY+x2yasGCvFsPAu3r+Pmn44n3n1kz6PtOC5M6
 TTCj8BX9mYpck6AzqLa1TjObyzoAYNVKaeKIPs2313ZNP2olK5YofYhTFoVJqFtIEVZ3
 DPW1kv/sW4FZ4BU7EUS+B7MghFI3l2FB2AgYNYUcnNbsYoTmGJTvL85M2lonWDixvmgs
 BDn2YP4PepJUrbdd+Jw0VIL3W/fmYZ4QE6H90/cBitsL7rckdQPnws6CJCTj2Vbw5vP1
 /CZQ==
X-Gm-Message-State: AOJu0YyvkbhV23udjaY+Pc5PpMpsZaju+EseGvmZ46hQhSDSOjskJZxV
 KQzIr4CL0PxTbiWxClYWNhfiTtjIMW6n7/8aSPb5ccmvy4ijFtaneKXt39i1zpige1QJwBvfj7/
 K
X-Gm-Gg: ASbGnctC/ghpgj1ttKYrj7FH3U+ZuV1Van2mbYGNpBFXiRg4u9l5RCTuKpBKXpFgwpJ
 FbWaKvfQ5DsIO8MBdmjK5XZ8mZILu6a1ccmredJhko16v3G1kA8IANHB4j2PCGg+Ys5995xWjtC
 WInNNBNwCLt2UZ6Rci1bt9QlhZVgodbZZJsY3FszR++UemWNk83yCMVgzHv2eooNGEoiYLMUZOf
 TyDR7m8m+6rtwGabA2NWB04mEXrW4T2Sf5RCA9t50JgDN0IDqTYmz+mUEl/FtFt+SKTnaZnbk3z
 YRk+hQCYTJQaGCmGO9r9jCj5hDa+wziwK7EQRpCzBIH494PaiP4FrpyDhnUiBT1eOoNy7J7Uwhj
 jfyd30/9kYuDL7M1rN6Cn
X-Google-Smtp-Source: AGHT+IHWYgAirMkw+Dq3xx0iSGvqMPMFmcWjhl7CbtC88yc3oIDiXO7HaEczqqs1vMEo6ntIlHjN+g==
X-Received: by 2002:a05:6402:34c4:b0:5f8:36b2:dc07 with SMTP id
 4fb4d7f45d1cf-5fa78044b3cmr3338594a12.16.1746212296712; 
 Fri, 02 May 2025 11:58:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa7fd0705csm1083137a12.13.2025.05.02.11.58.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 May 2025 11:58:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Amit Shah <amit@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PATCH v3 14/19] hw/core/machine: Remove hw_compat_2_7[] array
Date: Fri,  2 May 2025 20:56:46 +0200
Message-ID: <20250502185652.67370-15-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502185652.67370-1-philmd@linaro.org>
References: <20250502185652.67370-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
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

The hw_compat_2_7[] array was only used by the pc-q35-2.7 and
pc-i440fx-2.7 machines, which got removed. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/hw/boards.h | 3 ---
 hw/core/machine.c   | 9 ---------
 2 files changed, 12 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index a881db8e7d6..77707c4376a 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -838,7 +838,4 @@ extern const size_t hw_compat_2_9_len;
 extern GlobalProperty hw_compat_2_8[];
 extern const size_t hw_compat_2_8_len;
 
-extern GlobalProperty hw_compat_2_7[];
-extern const size_t hw_compat_2_7_len;
-
 #endif
diff --git a/hw/core/machine.c b/hw/core/machine.c
index ce98820f277..bde19a2ff67 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -266,15 +266,6 @@ GlobalProperty hw_compat_2_8[] = {
 };
 const size_t hw_compat_2_8_len = G_N_ELEMENTS(hw_compat_2_8);
 
-GlobalProperty hw_compat_2_7[] = {
-    { "virtio-pci", "page-per-vq", "on" },
-    { "virtio-serial-device", "emergency-write", "off" },
-    { "ioapic", "version", "0x11" },
-    { "intel-iommu", "x-buggy-eim", "true" },
-    { "virtio-pci", "x-ignore-backend-features", "on" },
-};
-const size_t hw_compat_2_7_len = G_N_ELEMENTS(hw_compat_2_7);
-
 MachineState *current_machine;
 
 static char *machine_get_kernel(Object *obj, Error **errp)
-- 
2.47.1



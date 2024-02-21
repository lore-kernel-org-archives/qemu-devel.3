Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFC9C5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:23:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rctz6-0007tD-J1; Wed, 21 Feb 2024 16:18:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctz4-0007oV-NC
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:18:30 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctz2-00019d-6I
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:18:30 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-41275971886so8637945e9.3
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 13:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708550306; x=1709155106; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=el8jSU/WeUKeTdfPo2BhG3KsHF8nK1ocI6Kjqh4/a/E=;
 b=ThuE/8q9DfSfcpFLvOukCe4ulkoRZK3mM1OqWxQrdxnhqFcPx29NhOcdkYUO5oYdBE
 xc9dX4ZidNbyghsr+Q8BswaK2+P7Xa2RNxnY05wJSFGQP9hfPBTKrZDfYiy7WbuKqZyG
 LXO00XquRWqSYHkz90vPvbXuthFMdAXmzax72zhwRK3SegzPUVm/46bt17ilDkcn62wA
 Tl0T9EGZAm+Qw/jLxezKzMhjl2xh+Skc2nPwlQADriB2CCtlL5avdHonkQq7M0niQeH9
 jlWghRNxGwZTsTej5w9vhWaCVUmSaw8L4/+fTRYeF4MNppnCu0z3lf3SFZXTi9KvKjCe
 VWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708550306; x=1709155106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=el8jSU/WeUKeTdfPo2BhG3KsHF8nK1ocI6Kjqh4/a/E=;
 b=NB8zG9Z4Zdd7nqqC+xbfp6Kr+4jiThS50jAqQcauEgjZLKVQo8JJRJjKX2MuNc4VXi
 wbj5vrRdNiPEkEdx4szRfi8iCxr1GodrgC/ei0BYQl098r9p3VBogoXQVJNet4iNIERx
 IjB2mG6nf7lEwAfmOzSAPlCKeXFpnEgtwRwkheFphAfYuvg1HPgE/sZWRnLWOTlBDUSh
 1y8wfZx458RR586U4dS2MlNwQoG0tId25z6tpu2Qeg/23MwCyQ3FtLnDj0rcFcRCR95w
 1CdpjxJX3bkLvv3Aq+UT30zNbfvhueDgJ6I07AMs4cnNRFOWVZV/Tep7xVtB7q2+ny/n
 AvcA==
X-Gm-Message-State: AOJu0YzAZPVqskN4x2kQGATMT49aH9x+7NISZmFalJbZRfi0TP4nl8o1
 4HzxwT5FyC2JgTBen0J1h/By1/9zXhxMcEjxD1YXcB62YGEt5NzVaKf5MywydYMMHTGYRogRdNn
 /1pw=
X-Google-Smtp-Source: AGHT+IH3racoaH5Ihl5Puf//D7KmUV+Gbi8QkKzZg7KDODdcGekQd/PPZzySz+BahZ4e5K1/Gxg9kg==
X-Received: by 2002:a05:600c:a01a:b0:412:78da:8abe with SMTP id
 jg26-20020a05600ca01a00b0041278da8abemr1487738wmb.30.1708550306443; 
 Wed, 21 Feb 2024 13:18:26 -0800 (PST)
Received: from m1x-phil.lan ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 n3-20020a05600c4f8300b00410395dc7d1sm3817423wmq.7.2024.02.21.13.18.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 21 Feb 2024 13:18:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 15/25] hw/i386/pc_sysfw: Inline pc_system_flash_create() and
 remove it
Date: Wed, 21 Feb 2024 22:16:15 +0100
Message-ID: <20240221211626.48190-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240221211626.48190-1-philmd@linaro.org>
References: <20240221211626.48190-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Bernhard Beschow <shentey@gmail.com>

pc_system_flash_create() checked for pcmc->pci_enabled which is redundant since
its caller already checked it. The method can be turned into just two lines, so
inline and remove it.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240208220349.4948-8-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_sysfw.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index b4c3833352..2dcaa116ad 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -91,18 +91,6 @@ static PFlashCFI01 *pc_pflash_create(PCMachineState *pcms,
     return PFLASH_CFI01(dev);
 }
 
-static void pc_system_flash_create(PCMachineState *pcms)
-{
-    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
-
-    if (pcmc->pci_enabled) {
-        pcms->flash[0] = pc_pflash_create(pcms, "system.flash0",
-                                          "pflash0");
-        pcms->flash[1] = pc_pflash_create(pcms, "system.flash1",
-                                          "pflash1");
-    }
-}
-
 static void pc_system_flash_cleanup_unused(PCMachineState *pcms)
 {
     char *prop_name;
@@ -212,7 +200,8 @@ void pc_system_firmware_init(PCMachineState *pcms,
         return;
     }
 
-    pc_system_flash_create(pcms);
+    pcms->flash[0] = pc_pflash_create(pcms, "system.flash0", "pflash0");
+    pcms->flash[1] = pc_pflash_create(pcms, "system.flash1", "pflash1");
 
     /* Map legacy -drive if=pflash to machine properties */
     for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
-- 
2.41.0



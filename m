Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D702C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:43:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggig-0007EM-J8; Mon, 06 Jul 2026 06:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiZ-00078t-So
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:29 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiY-0003TQ-A6
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:27 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-493b1710405so17302795e9.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334305; x=1783939105; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MxxnuxiMIN2CqwfRQVl/lbTh/vRKSNzXhCWUSEAG5pc=;
 b=tr9xig357WYJBEDD9KxKEQ0S8RyyqWyft3n9Jex424ImoF7WLyChrZjEyd+mVhjeiP
 vNwijdt7UPamSCc6LAINyiFgXueORrDgXxl6wl7RnbxqByvHndwCh5MqD0d0oQ+59vBq
 xuAuMpoLK1kh88YdP2NaGq9C7XJ49i5DZ0NzEc5TeY4loGyFe7IlOHO5DsqZEjWCi9Bt
 QsdlavGhi+6Fers0CHsPy1chuDqg/1OyVNTMmEFG4NuB6T98z4ibECAp+7+JNGSfewN/
 sdURWIK2D/d1PrNNFGzHfOoH9p5/n0Ia27ryr8rvz9wBCMH9S6rsbV/Tn2R89JeKxAnZ
 u78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334305; x=1783939105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MxxnuxiMIN2CqwfRQVl/lbTh/vRKSNzXhCWUSEAG5pc=;
 b=Hg7wUlsUpZbxlPeK9LLokiCp6m4pAfxPaPfi5xUbca0tRqf86Fj6QTbh5USbwya9vn
 aCFVPFhAFzATZMAD8GqfTTF0JO0cmocI+rtTARWSg3htmtDgwAWJdat/xzA1kixUcCzv
 rZ14mz3qh9Pnx9r4aJUpMLZX+CW6zR+cP6f1x1MXewQ6e+MWZxbbMzDn67Yx+AS5/Kh0
 UW0C1n98zZcEqCPQbtOxpZmZGn8FHLMwCvwUeE+4IHLue6JYaPNHc86NyYKzi4ZMonVH
 TzVJa7SNI9cB6hPlHQJSZmQoG/71/6cs55XNMGKyNu0WzbyJGGLiQ8L1VgyiPQRxRK7D
 8cew==
X-Gm-Message-State: AOJu0YzF2jxaOWrg/J1lCV9hkPvp7VMn/t8RdPC/+YghpTUIzxW9A78Y
 y4d6LzFujK8qQyvLcA0T94AixxDHKOkl9OFVrzHJ2JmfBMK+v2kdBwTkKjigfQqtBxi1+vhLlxm
 0ZvvRRv8nsA==
X-Gm-Gg: AfdE7cmlFq0Zxq+rbD8jl4iWF/+6tpaBK39AjyElMT2zcEln3l0VtT1BuGz68qiGZ7F
 oeZF3LjjFZWhjBbcwI9DkWcLiLKpvkhxXFvoFNGOzn4MrIsR+DWjcv0Y/83STYYC0HCyx0ULFBo
 qkXgg5yJJqby+Wgf7BmYk9bkmv9mkW2OY5tOwSGrVTCrzSPXiz31fh+eqKb66Uk4qszR2uPt4AX
 rFE/tmTDh1TK0jVLzTyn1AGcWjC7Q9cKNvoZ/F/vtnrZeEszZmCyjxEReiNrjpL6CHjtoM5SWys
 8fd/RD9+aMbnOEad2yVk4pQrN4hUmjhAReXm67bdc7uQ4c3Iixh8gJzieNH/52ne9BzCAVicPgd
 5TWpCL1QT2UGUMXj3QGRxrwNvbVG7khKR88XTkDGJru0AW5MlWKr7dTewFO9UdUh4wHfDq/XNcG
 vHPzmbV1m+h4lSSJpR0SGYtJhDTUEbHOTh9g759p22WKFei6hAyLl3v24fcY83WB7mctbDRjDLT
 PVSuQ7GZ3KPlF5TFcnuAKnKOAWzFpUk
X-Received: by 2002:a05:600c:3b10:b0:492:3e44:214b with SMTP id
 5b1f17b1804b1-493d11d7373mr109022885e9.13.1783334304907; 
 Mon, 06 Jul 2026 03:38:24 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f1bsm329501805e9.10.2026.07.06.03.38.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:38:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/49] hw/i386: switch shim loading to load_image_to_fw_cfg_file
Date: Mon,  6 Jul 2026 11:37:31 +0100
Message-ID: <20260706103752.320511-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706103752.320511-1-peter.maydell@linaro.org>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Gerd Hoffmann <kraxel@redhat.com>

Use the new helper function instead of open-coding
the shim image load.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260521112806.504961-3-kraxel@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/i386/x86-common.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index fde05fa7d7..8f9419e7d3 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -980,19 +980,8 @@ void x86_load_linux(X86MachineState *x86ms,
     fw_cfg_add_file(fw_cfg, "etc/boot/kernel", kernel, kernel_size);
 
     if (machine->shim_filename) {
-        GMappedFile *mapped_file;
-        GError *gerr = NULL;
-
-        mapped_file = g_mapped_file_new(machine->shim_filename, false, &gerr);
-        if (!mapped_file) {
-            fprintf(stderr, "qemu: error reading shim %s: %s\n",
-                    machine->shim_filename, gerr->message);
-            exit(1);
-        }
-
-        fw_cfg_add_file(fw_cfg, "etc/boot/shim",
-                        g_mapped_file_get_contents(mapped_file),
-                        g_mapped_file_get_length(mapped_file));
+        load_image_to_fw_cfg_file(fw_cfg, "etc/boot/shim",
+                                  machine->shim_filename);
     }
 
     if (sev_enabled()) {
-- 
2.43.0



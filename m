Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF81EC83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:55:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublke-0002oi-0m; Tue, 15 Jul 2025 15:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublam-0001r1-9o
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:45:36 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublaj-0002fV-Sl
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:45:31 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a588da60dfso3934228f8f.1
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 12:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752608728; x=1753213528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FurVbd1eLbO1skSsA8qBStYsslRinQbnXVcbQqhp0RM=;
 b=QWrTxN11eSApbM/CODGrrK9EAJJ3R9UifVRr+CCXamYYzUFwAw5JEM6Db8vB4EIv7C
 FNbne3xB2+fFR2PAuxKEKAGs9NdKrbw7Dozw1IT1PL4dDPLVyDwKzWyBhf3A4XqsMJ7p
 A9tUH8xNO/dAL5BoRSFWhcGA9vp5jemj30nYB4opJQZDxFVyZoX0hsZ1LRIlVBikFpox
 i6jcJrxLuWBrfQxvsXLuNgg445mURCtzXYpxl5H/EasoKH4CiSZ5fJvSFUPSbsS1H9+/
 8uisZH6GVLQ5+HBLnor+1SqGXfExbFZGxUooo82ne52mTmgf6XqWMYbV+o5yH8umNVWA
 hwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752608728; x=1753213528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FurVbd1eLbO1skSsA8qBStYsslRinQbnXVcbQqhp0RM=;
 b=oaTJyhENqm41Udd4FKh5I1JrrwskszrSYiI3Ec8R9Eq1dqPeRg0G1ee+G9e/UFpT6c
 5MumjSciYPUeI3jhhh6XMJYOotZAFlsgq6MHADD4yQYd/ihA/DtdOgUCTtvWz1apSzgR
 OCe+84Tcr9QHirevLZk9hGycIWejMOu1AVWnFA5Ftq59HJqTYa9yDn6CRyhjLBzeX0rt
 gnLYH8qS0Br1nYRo9IMbzfTaOONGh64Jqu6tu7sfW4pfrTis8WPoy2X8fr/ZodC6aEN6
 XLxcKlTeaNvQWiDy2ynQDszE4K2GW4MGyz/6s7Bt4UIvbMHRTQGyCzipKT6eG4mDCj4L
 HR7Q==
X-Gm-Message-State: AOJu0Yw4rbc0oTmN6BJOO6HcxfCGfsQ1w8c+XRABJaVm+W2TggJHy0I9
 jdGjtP6XyGYIEzn+IEE/xoDvJA67VzY7aGAdIHcRra1b3ePGjRhGcEykgIcgE50IdFM1cTLvP+p
 +egu2
X-Gm-Gg: ASbGnctx8cRWRBaPFJK8KaPMuJDWo9PFabo3EQyNhfUKjGGKLN/2yIoiMXSZlOde1ZU
 N6RtQRfcsr/Sa+ciDie4lUDuWYkav/DAy7K1qcUesPa0i+fA8UL02B5xHUUYyA2hTBpBvwEWWyy
 Swc3TWmbuBSdAdoWIfvuuYjK9SnrDuoj8waMLTazEJwtlXqqfaqQvJuaznnF9Rk9zZdX64Nc8aX
 55XEvFc7AEGHwYotiGv1Lf0cC0tpROkoHVVKToSIn5K4CCF6sLJI7gd9P1ph5cLjxln7Nwn8xi0
 kjgAoBqfswIv3aoLzuKpmq/+AvLvacbPl6cIFvrtuYlE786bd6i0Twi2BOttBnao39YMIzPCcf/
 k1XS+WF09OulL66orX58B6WjH0X27mZ91iSmfa/Vr7WcOrxmsNoXFaoT8kIpjZw0PDFpoR061SU
 mD9g==
X-Google-Smtp-Source: AGHT+IEQYtnVSLRBKU5Sclkp9o8ExlijViyfXcFDm5GFUk6F9O6+VqJN2NXWJI6X18Pa7/r/4+9wWQ==
X-Received: by 2002:a05:6000:40ca:b0:3b6:938:86b7 with SMTP id
 ffacd0b85a97d-3b60dd780b9mr377900f8f.35.1752608727773; 
 Tue, 15 Jul 2025 12:45:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd1997sm16190703f8f.10.2025.07.15.12.45.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Jul 2025 12:45:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/17] hw/arm/xen-pvh: Remove unnecessary 'hw/xen/arch_hvm.h'
 header
Date: Tue, 15 Jul 2025 21:45:01 +0200
Message-ID: <20250715194516.91722-3-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715194516.91722-1-philmd@linaro.org>
References: <20250715194516.91722-1-philmd@linaro.org>
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

"hw/xen/arch_hvm.h" only declares the arch_handle_ioreq() and
arch_xen_set_memory() prototypes, which are not used by xen-pvh.c.
Remove the unnecessary header inclusion.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-Id: <20250715071528.46196-1-philmd@linaro.org>
---
 hw/arm/xen-pvh.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/arm/xen-pvh.c b/hw/arm/xen-pvh.c
index 4b26bcff7a5..1a9eeb01c8e 100644
--- a/hw/arm/xen-pvh.c
+++ b/hw/arm/xen-pvh.c
@@ -10,7 +10,6 @@
 #include "hw/boards.h"
 #include "system/system.h"
 #include "hw/xen/xen-pvh-common.h"
-#include "hw/xen/arch_hvm.h"
 
 #define TYPE_XEN_ARM  MACHINE_TYPE_NAME("xenpvh")
 
-- 
2.49.0



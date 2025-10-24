Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 373C3CCD1BF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 19:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCNWN-0000qD-UQ; Fri, 24 Oct 2025 15:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCNWJ-0000jU-0F
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 15:32:15 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCNWH-0001KR-6t
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 15:32:14 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-471191ac79dso24976385e9.3
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 12:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761334331; x=1761939131; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5PQvFv3KYt9affpbRt+SdFadtQ6SLXOOKaJGxhZMFw4=;
 b=ltc9ljk0XhRbxFnG6VvaG4Vh6EmkAH1iqLpMWLqiSqEx0GOPAcwFs6rE3ZPaWRl/lD
 iQFISzv2a413k2ZjHpzEI9hK33Nf1Z4l7oXSK8iIuU6QQ7ViQe+g1KKPBDflKI2FWrLW
 ReKl61948B4D4nzynlcOkB66qKDeIxl6bLsGs36fg0mGJlUbM18WSIga/f6BZCUdJkIx
 tOfJJFsFojTUzC2lEv4/LGc8EA737llDfU6x1TuQQkQT4Ne6m0UlaEU7bIIBDGjfxTHh
 ST/98SfZSdlVhAnMJUyXkrFilRiqR12Huj7lYR+aTXFQCRWQEqT8ov+/tMxqpWUjsjjy
 IP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761334331; x=1761939131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5PQvFv3KYt9affpbRt+SdFadtQ6SLXOOKaJGxhZMFw4=;
 b=ACv/b29BsHsDBRjAEBoRNsm+ntIaPM1T93K8uOIQui45t5OEwAneGdzXm/GAsGWyR1
 JQfWDDu1yI5LdyH+GhmOS2x4uDz3qO+I15WS3/x5A0JnaiovdiF2YaJJCyjMa7tN6khy
 3NnddnV9tUa9xx2vMuF1iUYoYy+CnojEu/KrDFDPGhzwlcKi1Bp0mc6powu25ezxUSNQ
 lSBsOu8/xyKSDVgQVEm4Dfv4S4j6F/g24rs/Y+0WKzCIB/b7Geddh2UCfDI0vrnuyTIB
 vHy19Rd4BBX1FG8LHKm5K/xeTHIx/1wb/38PM1LXYylH59ulsGRPsLQr3q02/7Q6lJ4f
 IZqw==
X-Gm-Message-State: AOJu0YwmSEq/6qCpjUB5wVEc+8JC+ghtkwCAa9EPIpekLIRKDdmduwmz
 g6PV02QUn22XIOfFF05S4bKvH7SSp2dywf6PKG8Gf76MTKmgrDlGFw0xNeVcoDezzkxAvrHcg8n
 7jA0KXzo=
X-Gm-Gg: ASbGncs/gCVkQJWE9cXJ6syh/odl4yxpQuOruvar9hEhjPZS2zMgok1ocJf5iUklRDx
 SKdBhDT+LNxYn4HjTALB3DI8CxIduBvuGeTBZFy+ZLr8YlBpxHth4Mnmz25pS0s/OtvCS2tVZhZ
 AgfSeqvS+djL1bWhvvojGYIQzHcbqZq4rfMWV0ecwmig5XVYosPyw1V895nERa7qgbpF9Re3fzm
 UJFCsFdQkP8BPNMiEOiSlo4NNV0BZgviF/HTpJ5jyAY7Fp3dbuDw0UN12/hLd1e+YqLvKvNIWJs
 oOhif8Hk5usaPiw/WFIKHRy14xygWrqYwiv+gk+DtEk1HbBBYm/0HtPSOwLsmpiI0GYkaYdc12O
 qdpgGU2pEJD1E59sCQaTPElFR6sC7VKTHtMJY6bxUMUZ49AoyCdQmjBMA3m8qC0Qs5scMw7YvBB
 FiREWHgQjNx+O+hfviKw7AhCXo2Tgbv7WXmmDZ+nCRHei8vpk/HQ==
X-Google-Smtp-Source: AGHT+IHzBFBxTwcnx5jxUEP6XJQmCf6wUV3hwfL9BoJ/otuH7ZCqfcBQTrLP8ONMEFAiO3sZ94W1hQ==
X-Received: by 2002:a05:600c:4510:b0:46e:1fb7:a1b3 with SMTP id
 5b1f17b1804b1-475d2ec5729mr30808125e9.23.1761334331350; 
 Fri, 24 Oct 2025 12:32:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952b79cbsm18173f8f.4.2025.10.24.12.32.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Oct 2025 12:32:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 18/27] hw/input/lassi: Include missing 'system/memory.h' header
Date: Fri, 24 Oct 2025 21:04:05 +0200
Message-ID: <20251024190416.8803-19-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024190416.8803-1-philmd@linaro.org>
References: <20251024190416.8803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

"system/memory.h" header is indirectly pulled by "hw/sysbus.h".
Include it explicitly to avoid when refactoring the latter:

  In file included from ../../hw/input/lasips2.c:29:
  include/hw/input/lasips2.h:41:18: error: field has incomplete type 'MemoryRegion' (aka 'struct MemoryRegion')
     41 |     MemoryRegion reg;
        |                  ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/input/lasips2.h | 1 +
 include/hw/misc/lasi.h     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/hw/input/lasips2.h b/include/hw/input/lasips2.h
index 01911c50f9b..3510216effd 100644
--- a/include/hw/input/lasips2.h
+++ b/include/hw/input/lasips2.h
@@ -22,6 +22,7 @@
 #include "exec/hwaddr.h"
 #include "hw/sysbus.h"
 #include "hw/input/ps2.h"
+#include "system/memory.h"
 
 #define TYPE_LASIPS2_PORT "lasips2-port"
 OBJECT_DECLARE_TYPE(LASIPS2Port, LASIPS2PortDeviceClass, LASIPS2_PORT)
diff --git a/include/hw/misc/lasi.h b/include/hw/misc/lasi.h
index 0bdfb11b501..70c99fc017e 100644
--- a/include/hw/misc/lasi.h
+++ b/include/hw/misc/lasi.h
@@ -15,6 +15,7 @@
 #include "system/address-spaces.h"
 #include "hw/pci/pci_host.h"
 #include "hw/boards.h"
+#include "system/memory.h"
 
 #define TYPE_LASI_CHIP "lasi-chip"
 OBJECT_DECLARE_SIMPLE_TYPE(LasiState, LASI_CHIP)
-- 
2.51.0



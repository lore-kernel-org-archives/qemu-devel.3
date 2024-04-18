Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5964C04FF8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 19:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxXSR-0008EI-1x; Thu, 18 Apr 2024 15:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxXQu-0002xV-4T
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:28:33 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxXQq-0007mD-Vh
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:28:31 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a5561b88bb3so130442966b.0
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 12:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713468507; x=1714073307; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1RS5jD62Ba4lXsw4t8DJy1DGdcN7GiTei/ES6lsX54Q=;
 b=QNPxqinriTRgMpcl66cpBmTca9NapujWI8A914HTs2AZytmXxDyZuyES/ThX5NTLGz
 B6SXVdgFp5QD4jTtap3xeFLzQuBh19+75iZQtcSAqYHzwS9nYhdkzYnZUSyKhTsc1wHN
 Y0kNz13zIdJB8ssHasoD+dmDjrqicVa0GL6wX+0CZcP0Ean2tPnFHzvdpfi/mq4oZkyy
 B0GLy53rlYamUBE45ODkynCmPSf8iyNMQiFxDqBTa56BLiLJyFQemsv9D458B7tnqyxJ
 rFOCueYVBbleHS99YwL5G1/wVZfl5ExEledz7VRu4zN2CE7DLG9pTQ48J+oNkjKCulDm
 Wjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713468507; x=1714073307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1RS5jD62Ba4lXsw4t8DJy1DGdcN7GiTei/ES6lsX54Q=;
 b=n9StB00xXX1+Vl9+CVvauIGVyx4/VpI/6B0kOmKydHp/OgpRnXn6S/okVgYLM8qeXd
 6jrDMeX7yEGX/oT1MRFE3zDJBWTah6m1Fo0UptvEuCmHDRy+1iR9OPY9IzHiTBU8wjTP
 yS9kI1kv6GYGDNdt2wlOtVKUcMUpEZBj2njNGYii9Dvb8u6oMRf1sJ7LNjk85MXmeDDP
 5H1NJWts7k+oEuVyazrAuusVbxy40+B/axIeSbGLwUWe4MGOr3MGuCkzzjoZ720u7oYs
 X8vrk4nA09eaCOckHO6bQlfQgmryJd5Hh47u/C2ervObRl0HiMB0w5rvmurJN1XigEnu
 kPNg==
X-Gm-Message-State: AOJu0Yxj66kRAp98H2jbobbPjD38jOpNLK3m/Yo1Iry+KIc7QGJ2zYDz
 s0X2tlxnQRiIgTaDvs6lpoR6rvBiuHT1iOuB0aEWwXnUkszlK3QOM7TexH3SjvS2P+Rr9NSsA5p
 9
X-Google-Smtp-Source: AGHT+IGnTKynFh1txoZ9rF9Vyl15tlc6kOiNOpj1xrRbtFLNtjZUfEfbPneu9vzj/dXaKDU0HdxgVA==
X-Received: by 2002:a17:906:f87:b0:a51:b463:6b41 with SMTP id
 q7-20020a1709060f8700b00a51b4636b41mr56034ejj.61.1713468507162; 
 Thu, 18 Apr 2024 12:28:27 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.151.213])
 by smtp.gmail.com with ESMTPSA id
 s17-20020a170906bc5100b00a4660b63502sm1277805ejv.12.2024.04.18.12.28.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Apr 2024 12:28:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH 24/24] exec: Remove unnecessary inclusions of 'hw/core/cpu.h'
Date: Thu, 18 Apr 2024 21:25:23 +0200
Message-ID: <20240418192525.97451-25-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240418192525.97451-1-philmd@linaro.org>
References: <20240418192525.97451-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

When "hw/core/cpu.h" is not required, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/cpu-all.h    | 1 -
 include/exec/cpu-defs.h   | 1 -
 include/hw/boards.h       | 1 -
 include/hw/ppc/openpic.h  | 1 -
 include/sysemu/hw_accel.h | 1 -
 5 files changed, 5 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index cfbf51822c..03963442a0 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -21,7 +21,6 @@
 
 #include "exec/cpu-common.h"
 #include "exec/memory.h"
-#include "hw/core/cpu.h"
 
 /* some important defines:
  *
diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index 0dbef3010c..2b88db71a8 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -29,7 +29,6 @@
 #include "exec/hwaddr.h"
 #endif
 #include "exec/memattrs.h"
-#include "hw/core/cpu.h"
 
 #include "cpu-param.h"
 
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 8b8f6d5c00..2daa23082f 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -9,7 +9,6 @@
 #include "qapi/qapi-types-machine.h"
 #include "qemu/module.h"
 #include "qom/object.h"
-#include "hw/core/cpu.h"
 
 #define TYPE_MACHINE_SUFFIX "-machine"
 
diff --git a/include/hw/ppc/openpic.h b/include/hw/ppc/openpic.h
index 9c6af8e207..8fe3a5902f 100644
--- a/include/hw/ppc/openpic.h
+++ b/include/hw/ppc/openpic.h
@@ -2,7 +2,6 @@
 #define OPENPIC_H
 
 #include "hw/sysbus.h"
-#include "hw/core/cpu.h"
 #include "qom/object.h"
 
 #define MAX_CPU     32
diff --git a/include/sysemu/hw_accel.h b/include/sysemu/hw_accel.h
index c71b77e71f..6aca3c6178 100644
--- a/include/sysemu/hw_accel.h
+++ b/include/sysemu/hw_accel.h
@@ -11,7 +11,6 @@
 #ifndef QEMU_HW_ACCEL_H
 #define QEMU_HW_ACCEL_H
 
-#include "hw/core/cpu.h"
 #include "sysemu/kvm.h"
 #include "sysemu/hvf.h"
 #include "sysemu/whpx.h"
-- 
2.41.0



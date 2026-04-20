Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECC3F588F9
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 16:39:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEreR-0006S4-Fh; Mon, 20 Apr 2026 12:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osama.abdelkader@gmail.com>)
 id 1wEreH-0006RU-Uu
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 12:39:02 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osama.abdelkader@gmail.com>)
 id 1wEreG-0007bi-A5
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 12:39:01 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43d74086e5bso3266903f8f.0
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 09:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776703139; x=1777307939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=199HqUxRQYqNbPW12xLd+dPLfMLWS3wn9SCE1juFonI=;
 b=ECDpiKu7xT/W/Nh9x3JL1M3PJrgU0vpOYfZp5PCCq0QHieQ5m08GdzMT1ASCxmeLMQ
 fnMuK/X+CHY+H/yydkH6Q1WVKOont/v8bMDMFXF5SW+IY1L3iHIV+Gj8eM2uS3iaGj/5
 kXINl5B0euifU5gmoKFWLVptfanKLPggyAMD/zKp79EHYhzr53YsbL9lPY2DZ4Mn/Z+g
 6VWXlVDCkEqOptWRobb3QFvoWmTm81TeHmPRZ9pl0xlfQ0vsVpY+MF06W9HtApt5Ylz3
 SENOTqy8uIdwmxlAywjRgCX4nckhB1tJEGFfEsEHP3AbbZiGg1ETf+7/tq4IyMD5wTyq
 WA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776703139; x=1777307939;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=199HqUxRQYqNbPW12xLd+dPLfMLWS3wn9SCE1juFonI=;
 b=pXL4oN41noZH14TRIH5vVq/7//PyrK2P4I0oggWzQJAbjKXUV3/T1jcEIkR3SNI7JY
 awn2Q0jO+sz7yIQN1VdU6HIq/x1ljaWpIXltbYg8iQtsgg1TA+lSR6BIwN54eNr+vecQ
 ybYowfWbsAC1gyDuZOugKuH9jakrK7Ls5J2pk50TBlGd+qa5sw7lWpeGTd9wasYdBuGy
 DCcIriTEsd5HwSAou0wg1Gk6sh1v2oYTF8pzZgh5+RmgxbNlDsKi6O5T12h4LCHwJRG6
 R0XIT0RsxK9+ZNgLrZSFguL6hbLNHSStW8+OWzF8iDkojMpUoQwH6fuguNrBd004FseF
 tRpg==
X-Forwarded-Encrypted: i=1;
 AFNElJ849FtOkKtKLhNqPR5Y/P+TDVx93IWFHgqT0kVkodYFsQ+IIgJncCjN9BADxe4gHLphyOIRHGq4EcCU@nongnu.org
X-Gm-Message-State: AOJu0YyHjwCPwypQ+qWgWED0+XW2b+uVJA9YRZFlDVC+z7WetBiTQzrv
 LGY1bnXgC8QoBb/abGTCelznBVpnC4i+fEx+vAL+UlTGGifV6ADRyw0O
X-Gm-Gg: AeBDieu78wxoO5n9S4xSQ0dyzM4sy9d+AFEaGXcxtK5sd6ub93wa0EOeq4tszCmGCf9
 il6KE9AY+9+6jiEQ/k4bZOaJDJjbi4XsPf0vsy4Atl/Q3IuSQsOJcbiZKCPwRMy8E6eJFuL3hhj
 g8IZoUtrOecXajrgxozI2SSAyffn5yBgNhNyJSPiV3waHvXgDPdSxFYCO0a8uaO9DyIIPkvRGko
 L6vAVkwk1QTaPxkXnaTfcci33pQy7QylWdDOQpEXBW5N6RCRQrCOuo9fLizxaYqFRfU6EhCmA9L
 gx5gm1noHfOduVc/bxPHFgYnDt2+amRof8LzwhjEREhIx4109w57h74fREPzbgZl5i6KF+DN8nw
 CzS4aQLAL2irEu3Qbil3F+0tgQj7z3ryUOy/UzBzkfaBzQkRMNh8yQa5yNA8GdD3BPyTTX8ycuL
 pq9drfycrk1UHcZQ8s9x/+jjQK0zIisL/gVWsGUn5Y/BE/+j+pvoDkvBA03h5GVo6GdxAEyBui9
 mz/en7IDQ==
X-Received: by 2002:a05:6000:2387:b0:43d:7c91:49c with SMTP id
 ffacd0b85a97d-43fe3e255ccmr22561372f8f.44.1776703138518; 
 Mon, 20 Apr 2026 09:38:58 -0700 (PDT)
Received: from osama.. ([2a02:908:1b6:8980:1552:6880:e516:62d2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a174sm34400123f8f.18.2026.04.20.09.38.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 09:38:58 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH] hw/hyperv/vmbus: remove duplicate include
Date: Mon, 20 Apr 2026 18:38:43 +0200
Message-ID: <20260420163844.332663-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=osama.abdelkader@gmail.com; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

exec/target_page.h is included twice

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 hw/hyperv/vmbus.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index 5388f4277f..dcfce70005 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -21,7 +21,6 @@
 #include "hw/core/sysbus.h"
 #include "exec/cpu-common.h"
 #include "system/kvm.h"
-#include "exec/target_page.h"
 #include "trace.h"
 
 enum {
-- 
2.43.0



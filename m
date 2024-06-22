Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA95EC27C78
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 12:08:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKzWJ-0007yR-0B; Sat, 22 Jun 2024 08:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKzW9-0007lv-Rp
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 08:06:54 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKzW7-0000KI-QA
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 08:06:53 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3650f2e540dso1784679f8f.0
 for <qemu-devel@nongnu.org>; Sat, 22 Jun 2024 05:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719058010; x=1719662810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=H5GU695wBqzPlnCl6LHUjaUC9nnJlhbb4hAcQcaW5AI=;
 b=TBeHo6WgviJWAIPm15E1oZf0XAMqc//2DkLk42dhLfMBckqACrcPGI3+zPDmx056c9
 UMYzH8+fktQ0DIj1i8YU5R/A9OgmgwIm8mT6D8pEpPen9dxvqhYwyViH4XPRj5BUddie
 h7d6reermiV5LytqdPge8KlGOoc4yjBAUPyQpCm5pMJMGLQsJ68W2dJOF2rlxcZtbEWW
 btfKtodlF22pfU9SXMyEMzQLfzvP/SFwASpcZi4XR4AMhxWtioSURccCwGn6aKqFINH5
 FYc8r/liifnbPz/dZZwxqCVjsS9AepykQwu5zeBNASh0CuQsZ/MF4x+FHWAXKJdIwnMk
 /Njg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719058010; x=1719662810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H5GU695wBqzPlnCl6LHUjaUC9nnJlhbb4hAcQcaW5AI=;
 b=O+ovcbWiWgonfq6RRGbv3lVrh1MrFkeVr+kiDcPPfWUc0foU6CQaYWqewbx2fUAh6a
 +4Z3QNohTvWcKpiUle+bUAMO7hmoWsCGQW4XfYYRXFHmOYR3rGixHDF4AbvSaUES5nwG
 4J/McwJ2uhYX5dIZvkTo+hEwOrfV6m4ICDStiQx2BfcvTmIAgvQq7hOp3IfAIoVocJjJ
 q7UXOK99MDej8QFHm8ieVCCOTHcH+cJYlm5A1vV6BepZej/a14618FVqDixtwoNhGwHM
 0xFUUF/JU1gPDolNVAjeGH56/s+EB6D1wOojBAyx20DsY4o57Md7WTSWCuOABbuJERk4
 PQgQ==
X-Gm-Message-State: AOJu0YzMWhZ9tBvBeb4JFHaBXK61frRDv8wIRU9nZ61WuIBLPI7hhLCl
 yjIs3LRAOpFI+WamGNetBoGpjPulkC5wbNhDyF5jcFZ0a2Vu/6Uouog/dEMr3GgwuIN+9zWWZGq
 0BmQ=
X-Google-Smtp-Source: AGHT+IHDCQdx19ltFCec4XM6j5axiyLYFm0QD87HSCNLJ2E1piNtv+/72zZLAyYbTFwVt0Y/Q66CKw==
X-Received: by 2002:adf:e441:0:b0:362:c237:5569 with SMTP id
 ffacd0b85a97d-363170eccc5mr7900219f8f.2.1719058010381; 
 Sat, 22 Jun 2024 05:06:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3663a2f698dsm4393006f8f.70.2024.06.22.05.06.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Jun 2024 05:06:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/18] hw/usb/hcd-dwc2: Handle invalid address access in read
 and write functions
Date: Sat, 22 Jun 2024 13:06:36 +0100
Message-Id: <20240622120643.3797539-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240622120643.3797539-1-peter.maydell@linaro.org>
References: <20240622120643.3797539-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

From: Zheyu Ma <zheyuma97@gmail.com>

This commit modifies the dwc2_hsotg_read() and dwc2_hsotg_write() functions
to handle invalid address access gracefully. Instead of using
g_assert_not_reached(), which causes the program to abort, the functions
now log an error message and return a default value for reads or do
nothing for writes.

This change prevents the program from aborting and provides clear log
messages indicating when an invalid memory address is accessed.

Reproducer:
cat << EOF | qemu-system-aarch64 -display none \
-machine accel=qtest, -m 512M -machine raspi2b -m 1G -nodefaults \
-usb -drive file=null-co://,if=none,format=raw,id=disk0 -device \
usb-storage,port=1,drive=disk0 -qtest stdio
readl 0x3f980dfb
EOF

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
Reviewed-by: Paul Zimmerman <pauldzim@gmail.com>
Message-id: 20240618135610.3109175-1-zheyuma97@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/usb/hcd-dwc2.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/usb/hcd-dwc2.c b/hw/usb/hcd-dwc2.c
index 8cac9c0a062..b4f0652c7d2 100644
--- a/hw/usb/hcd-dwc2.c
+++ b/hw/usb/hcd-dwc2.c
@@ -1128,7 +1128,10 @@ static uint64_t dwc2_hsotg_read(void *ptr, hwaddr addr, unsigned size)
         val = dwc2_pcgreg_read(ptr, addr, (addr - HSOTG_REG(0xe00)) >> 2, size);
         break;
     default:
-        g_assert_not_reached();
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
+        val = 0;
+        break;
     }
 
     return val;
@@ -1160,7 +1163,9 @@ static void dwc2_hsotg_write(void *ptr, hwaddr addr, uint64_t val,
         dwc2_pcgreg_write(ptr, addr, (addr - HSOTG_REG(0xe00)) >> 2, val, size);
         break;
     default:
-        g_assert_not_reached();
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
+        break;
     }
 }
 
-- 
2.34.1



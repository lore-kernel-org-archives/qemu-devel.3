Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8602FC44507
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 15:33:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjIef-0000Wr-Mb; Mon, 13 Jul 2026 11:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIeS-0008Ul-O3
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:33:06 -0400
Received: from mail-wm2-x01.google.com ([2a00:1450:4864:31::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIeO-0001CC-RR
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:32:59 -0400
Received: by mail-wm2-x01.google.com with SMTP id
 5b1f17b1804b1-493b567a019so29914175e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 08:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783956775; x=1784561575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QgPJk4BUyDewH+3y3PFKAK0sU7NiiLGvTpgnWeYce3Y=;
 b=Sc1sPpf4volGJXJGzHIlgF8/E8HV/5PrFPItqfBQe0umQlb8ZbYnanhs0ltNCTT8BF
 22ScZGSW2krxJpHilUllkcy/qZav2ZOW7q5zsnxvgMWXmYVXcFUuGv9EcS9R8hWsKXo8
 pvR4R3yYOOizSaiP3F5pgjtcX24S/ZSMXi8WKgAueQzcDf6KRm/x93NzJcvgSIEbYWlW
 4RS1qp6mIMBTjP9WfIwqS6jm/Yra5Ob15ypM50fOjA5p5CnnRiLkrL3xaCRL5PztRtkL
 dCRDKicgxIw38v6/lIISYXR9eH4IwtPvjcj6hMDTakPgjArjiyIqFNzT4A3ViEYVbU3K
 exNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783956775; x=1784561575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=QgPJk4BUyDewH+3y3PFKAK0sU7NiiLGvTpgnWeYce3Y=;
 b=GVs608kXnNcFFuwfr0TmeSEm6yDTh0Ul3FGFVu6aWg9wm8pyFbYYXwFUV255e3dEHL
 JrEjk4HTdcYqFD+9wC1pPdrSwCAk66dHZLmHySRoQtIwtMl5zAuAtGl6kLaROnIRzxc+
 ZCXjNMbdWD0qOPIRoP6UA17gQbS6jH9E7SltgKmrSTqBUe+o9+MEOY6/HA6/XtHaF8gb
 nnkGhm4iLlK24Xd9y7BMzhpl4sdhQ2GLyjoRR0eKM/xuOwOOEKgzxga6CVE+zdFjVhRW
 umK9RLZ5G2Aj4Ey+CYuwix8oyb0pFs7Clrf6Cq0mJJHvddki5pW0Ta1Xg+kbVxK5HWxT
 AXOg==
X-Gm-Message-State: AOJu0YwdPdMShOGcIDWDAMrZqMTn3kzOTf/SZKd9Fkvaa15VrnbpF8Hu
 h983VubWT1o8VFj3MuhAngY0Z8uy7ou49t3STV8QWKo/6Jof0bxQe+GyHx4sAnj7ityay8XYvHO
 yyZ8edYl3i3yt
X-Gm-Gg: AfdE7cl4blViZixwnqQI8vcrx87wOsAwAk1i5OHotz847WPSVRYY/5Mw22qSegJzlHd
 Z3/7iY/HNVtmsL7eajyCwW2PiE4IJHKSBFeXg29dUCuPl/JGFIsDPVMgEcAlqmWyyH6tbWGDfoi
 V4+79hANwQIe0ZYoqJxHgyt5WPSPJbUC2FstNfLPeyi7LkJfTROb8EGTe2y9sjAq9XZ+4GS8uYG
 MXWXGCd0igC7RX6T00FYumnyYtzcYjz27NHVXOaOrftQuL1RioV6+ZQPbd45HA7UhMeNVzrPfTa
 n9zsqfcgGE2Djf1alNf3/Hs92ZhUdX2U731avnxSazsMTWs4FeIjZpX2sFf8iDoGMQwW6fAjVcV
 BbTN91eEvQDhGI/8Lm3GM98r+mwW7YL6CbGj3HchogwUs5V0FnqYtJJLKR7Ptxciu3c3EFXq7rU
 Za/1PhxRYrzmp0Z4ZAxjSfLu8aYxPFFwLEiEYFb32k2cXpnbF22i90XB6re6HsHyGBG4n2CbyyE
 p5X3Yf8o1bni8NDsZKE6w==
X-Received: by 2002:a05:600c:6048:b0:493:e97d:97e3 with SMTP id
 5b1f17b1804b1-493f883e9aamr74956195e9.39.1783956775362; 
 Mon, 13 Jul 2026 08:32:55 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508727f7dsm3825985e9.4.2026.07.13.08.32.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 08:32:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/26] hw/display/sm501: Catch bad coordinates for RTL
 operations
Date: Mon, 13 Jul 2026 16:32:29 +0100
Message-ID: <20260713153233.3391818-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713153233.3391818-1-peter.maydell@linaro.org>
References: <20260713153233.3391818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::1;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm2-x01.google.com
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

The sm501 code doesn't check whether a right-to-left operation has
specified a width greater than the x-coordinate (which would make it
extend off the left edge of the screen), or similarly a height
greater than the y-coordinate.  This means the guest can misprogram
the device so that we underflow when calculating the address of the
top left pixel, which might result in accessing out of bounds
memory.  Catch this as a guest error and ignore the operation.

Reported-by: Yannick Wang
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260707150933.1410507-2-peter.maydell@linaro.org
Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3920
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/display/sm501.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index af870048372..0da25477bcc 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -723,6 +723,10 @@ static void sm501_2d_operation(SM501State *s)
     }
 
     if (rtl) {
+        if (dst_x < (width - 1) || dst_y < (height - 1)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "sm501: RTL op out of bounds\n");
+            return;
+        }
         dst_x -= width - 1;
         dst_y -= height - 1;
     }
@@ -748,6 +752,10 @@ static void sm501_2d_operation(SM501State *s)
         }
 
         if (rtl) {
+            if (src_x < (width - 1) || src_y < (height - 1)) {
+                qemu_log_mask(LOG_GUEST_ERROR, "sm501: RTL op out of bounds\n");
+                return;
+            }
             src_x -= width - 1;
             src_y -= height - 1;
         }
-- 
2.43.0



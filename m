Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37866CD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 10:51:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNq7O-0000iM-Pe; Fri, 15 May 2026 06:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNq7H-0000dP-Gl
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:50:04 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNq7F-0001JR-Ld
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:50:03 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48896199cbaso77823275e9.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 03:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778842200; x=1779447000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pRpRlYgzY5PaMz7MYuHPjzjxRVlI8PpTq6mbSsEg35o=;
 b=n2TamNHEAI+G1N8UNLCquU7X/WU6+b3KUM/jwOMeH1YaEwspzvXl5oxY7tL8UtDGOf
 +VjKioeBR8si2rqlnabucp5+fC0azL0TUaW8VaPDiVxh81OcWsY9lJuNpeaFwFzLKYSx
 nSOcPDbut2u08l6ZprnsiIg0fKWxrjMmhejkXz4qARY32emWeqYp/lHyieDrtlzFVSGg
 qnkNA924qsqb5OPRg3mNN7awsFYzG5QazH+1KCotl1GjTxJ8seuHhb1jYae6JtdPRTQw
 yfJx1pa/KzxyDgudfctppMeopjo4HqoMoMd8N8qaSifIbTnfCPSp7GJ1UWW8AxQB+WPA
 QBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778842200; x=1779447000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pRpRlYgzY5PaMz7MYuHPjzjxRVlI8PpTq6mbSsEg35o=;
 b=arh2WlnpQf/QZh9F/1uF0EfAORrimD6L3+knx5z6/DpwRn5qhxA5woEhzFmpTQVUnH
 2+olsPYD0n8XRrhMeVe4ZjKyBK8hjEqMfx+z5RyA/ULRMnpx8doJ5T2MAs3+0LpiOn+E
 aOlsykKuyB8l1vSP9KHGU1qv+iDyAdET67L7DTnpWW1eVkZKnJaSVjtTO/F/sqSVpkT0
 Ya5PciUdBPX1Yjm83HZvwTneYQ5sYiBjEgF3CMfayfcCIUH06QBiwuQpparONspkxxxE
 DE9jCHoVk5p9gyMlU28FbX4RewEpDZYhpKzFDuFMKEMAWPU+Ygund1Vo9PvTM9755z3I
 3VRQ==
X-Gm-Message-State: AOJu0Yyrcezb4yGaJjDqmlekjcPno7GOKdSjW7rbCgOnsSQuCowQBhqo
 yqftq4H0tTfQO87nWl9mzYhTERBe64qrrJVBO5C+AzdQCokXRKutpgyT0VGnclq2aSHl8f9QnZ6
 EZNwM
X-Gm-Gg: Acq92OGzRfVViUmkjsQzkjnQkzhW+LCTvW58I5XTdurJgZ34M8oCQNKZVam3eH0DK5T
 vqndYTPGHvcSg5J17Pl60eTnXEIdH4z0CLOeEE+rqGttCQnooDKSqxb8WPq3sb3nxTVlDGan9HO
 S6/soIJalgeX076mEhlhRq1ZgcK1WjZB5tm9ZiXm67jcrShxE0XYxBs9too8oHtw1TYLNillchi
 n2arj4ASprhCK9NOHSDc4d3yeU7wdCLNFdUOT4ROQZwRcJtwhsVdGnNUkOAQeD0jI96tdK49ExZ
 BsUYmtTB/ETlCv7pr4YNBUnWUiQwl9DqUyX5YAvTzDJ3Zrs9IUzVzofahMJ6zVh6Fhf2X/v4Y6J
 na87WuE2j41KgdmdbIAkh3GqJ3KpslI5hA2FA7TRMxF5oI2Ycg+gX4U0mdnvqjXYyo4NhNB28jv
 ORXzgJMNJ64mSL1SHlY6dHRDxov/YSVQ1WrlfV23hS8D4is6Y8Z/Td2rDrCpdYg7vZ/ctnr3o8Q
 X4l45UYOcFXRxv69EtzOTmqhktvwsg=
X-Received: by 2002:a05:600c:3b07:b0:489:1a3a:9e45 with SMTP id
 5b1f17b1804b1-48fe651e127mr47027885e9.26.1778842199987; 
 Fri, 15 May 2026 03:49:59 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feaa2949asm18194355e9.1.2026.05.15.03.49.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 03:49:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/23] hw/intc/arm_gicv5: Add missing early return in
 gicv5_set_handling()
Date: Fri, 15 May 2026 11:49:32 +0100
Message-ID: <20260515104945.4145203-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515104945.4145203-1-peter.maydell@linaro.org>
References: <20260515104945.4145203-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

In gicv5_set_handling(), if the guest tried to set the handling mode
on a nonexistent SPI then we print a GUEST_ERROR log message.
However, we forgot to then return, so execution continues into a NULL
pointer dereference.

Add the missing "return", bringing the code structure in to line with
the equivalent parts in other functions like gicv5_set_pending() and
gicv5_set_target().

CID: 1659596
Fixes: 5beb48ab53d ("hw/intc/arm_gicv5: Make gicv5_set_* update SPI state")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260512093856.3197700-5-peter.maydell@linaro.org
---
 hw/intc/arm_gicv5.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 7ad274e369..6b1dd04991 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -926,6 +926,7 @@ void gicv5_set_handling(GICv5Common *cs, uint32_t id,
         if (!spi) {
             qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_handling: tried to set "
                           "priority of unreachable SPI %d\n", id);
+            return;
         }
 
         spi->hm = handling;
-- 
2.43.0



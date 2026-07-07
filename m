Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46709C44502
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:10:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh7Qc-0005QK-4b; Tue, 07 Jul 2026 11:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wh7Qa-0005Pb-31
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 11:09:40 -0400
Received: from mail-wr2-x00.google.com ([2a00:1450:4864:30::])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wh7QY-0006OS-6t
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 11:09:39 -0400
Received: by mail-wr2-x00.google.com with SMTP id
 ffacd0b85a97d-46e260f9e57so686709f8f.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 08:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783436977; x=1784041777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aqUPZZYFcVjX8PACbAJKRitHki4Sln9thZIkfpQ+s28=;
 b=n1xGn+v10YeEK7OthbDMPzwbhE+MsY6+WykaNbROoD5Ptrzj+VDkgwLu3MBCThe84S
 cJn8x2KLbF7RcCsaku6gLdYELPrzMrZ9xif7cryB/AGOMRKaJGdKHx8wd0xuNuGqrVOl
 JDB9oHqcJBN7ZmoqRj1KpTi16yJ2u5a37gx+tyz5Bkz53AdMMP+QZb54qLWZy4dYswOg
 NErLZ+WDr2Le5ft89bxvRVWvEhOjP12F57PTyavqUQY5winSTdoxx6/rOSzbxUT1mSo/
 HIeeOgQF7yUAjvSWnba6N1menVkf2V3Le8Dh/XPqFpQLPyx63fKB1N+MU603aE2T1g9C
 /NpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783436977; x=1784041777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aqUPZZYFcVjX8PACbAJKRitHki4Sln9thZIkfpQ+s28=;
 b=NZgtk36rpOyiCXs2qmUDkIuhnU9zY2yI1M20SHw+reJT6wSB6uljkhZTpW/m1dx4Rg
 2HaB9EV89WnZfwUbo7RJI5eKU4X8lC49D4AWj6p5ANJFNq64h/RQdGfYFqd1/QXARBwT
 1yCZFy1dakhoH+QZhcD7ikolv9iTMZpriyMYKPAtsf+JHsLH4oLuA0GrgrcFZPE+zvrk
 1pB+b4uvCpicpFoAtVYqNXkXuz8zDV1uWucPuLUtw//mX78GjfUG7grum+HDshh33ofe
 43xQNjdoGo5YYEfWH9xmdsd9K/nQV65EwKBFxvjWLMmbmwVqWFFsyTwrVdITeHpjHe0T
 gaLA==
X-Gm-Message-State: AOJu0YxTOBiuoKKdvSNILtjykp61IHKRb2GgPQBTgxs0xUCaWQ32pDVw
 GLsoZ7VupqUWUOX1Ab5Nd/3d/Z6Vr1ZVyvvoc9O4eKFj/iWO6FnfO84Wg2HUPsg6YFmnNPgaqB7
 OrZW1AWdFD/Xc
X-Gm-Gg: AfdE7ckjYBZT4kLMeDYyft9a86ZjFgfjh5tnEiwdmn8fvDTK750Z+/uzWx6TujI+N73
 NqIza6zWuEgJII/akwxveVZQvXZKnEynmcJup3YgrGrgyzQoFQc8DDb1C+61I9RG/jngY6CX8lJ
 H4qIn0KN3/o1n2kpi3oov9+IKhmlH98fKUQIA8SLhI5hQcMOJT/dcOTvhDv1zrVAcc1T97cd5uq
 luExRrUNgGFmRjqxjEOQrUldNkTREBeHfbMm6rooJ32lo3WW0pDfGgWph1Zrelad55yl0x0TjM5
 K6OokwOSQ4DTVeCdTlGRor1HWHwv5oDT4LAeqSHkaToa8atS6yImgh4ViCtz31/A5K8a4NmthmI
 6Y3DzaEy6EF4U4F4Thdrdr7UMDwtkHKF0D2bqwrnRCKqQkZWxPEoFccF+XMX3KrAxuJSy1yS/p7
 jcUmz/1SwKODvprg+omLcaMC0A6G1J0NJgh8XapjXnd9BgR6Uh8HGXWqdNrY6ASSZ8UR5xUud4s
 yCb/wqiO3vRUjpervpTxg==
X-Received: by 2002:a5d:4289:0:b0:46d:d6c1:8383 with SMTP id
 ffacd0b85a97d-47de66dd473mr5105483f8f.44.1783436976654; 
 Tue, 07 Jul 2026 08:09:36 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1e785sm34181813f8f.8.2026.07.07.08.09.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:09:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org,
	BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 1/3] hw/display/sm501: Catch bad coordinates for RTL operations
Date: Tue,  7 Jul 2026 16:09:31 +0100
Message-ID: <20260707150933.1410507-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707150933.1410507-1-peter.maydell@linaro.org>
References: <20260707150933.1410507-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr2-x00.google.com
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
Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3920
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/display/sm501.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index af87004837..0da25477bc 100644
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



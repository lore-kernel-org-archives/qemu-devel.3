Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C94C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 15:33:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjIeG-0008Q9-3q; Mon, 13 Jul 2026 11:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIe8-0008Pi-72
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:32:40 -0400
Received: from mail-wr2-x02.google.com ([2a00:1450:4864:30::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIe6-00015s-4c
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:32:39 -0400
Received: by mail-wr2-x02.google.com with SMTP id
 ffacd0b85a97d-4744516a312so526565f8f.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 08:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783956756; x=1784561556; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j/FNYb+MXYMHJHLPxbhC8lFmm+mlt3LYTkPOncRVq40=;
 b=AfPfh1Zrik4xEOICCV5RlRKuneD2Uk27ZjUJyUiGA9FpyxGZnIhwBRkf+KEy7Rt4ij
 wj8JT71sOEF5AZrsKp0tc67Oz14D3ds6JVB0eWJsNmAsJz1YlyL45cUzuYNyC3debhL0
 d+LN4OhO/xkRO5B9DGfQI1hH7AYONwglIB+Kio+0Zx8akpT1i3G6WEin7Cr1RGFjifcv
 I3kAdtzM90ilbAhR9rEYnzGKJup3ZUc0q3ydIK7Q5K/wTIaVmgc78gz9jeFRYabCYXsd
 5SViiBxIoxEm0piXcbNlj9Ok2OrMZ1wkNDis+cIjAz7FACVRewNl9QsFr/98/bFod4UI
 s5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783956756; x=1784561556;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=j/FNYb+MXYMHJHLPxbhC8lFmm+mlt3LYTkPOncRVq40=;
 b=dfLPXBmTbMJ9MIoNK2dYUOuI9FcV6rdW7OM+g5ORfftc0mSLmmzCUizFaA2LEFN0Ni
 zZaz0V/+Dlx0GuYgKYjGT1RdbWs0zTB7T6lJrPRHTgDGeB/ns32MeCSOqbquSUlo1odo
 8m+XC1XI8r3u2awHd7SwEpl7iwSUWfKCGzTIaeeD50YlAcirVZfPmHcdwxhuGZVMMNw5
 smngKXmQm+ljG5/3OuB3TBhKD4nZOBpXAcg4J8M8Yv9BJ4LVmOzGc8rBXg4+dm6TsMP5
 gOXoiyrJ3JkVhTgwEmHsahE+P4C5VSZVaEvvpTM5tfIG80Ltes0vat2/8PIiFGE7KOTp
 WIhQ==
X-Gm-Message-State: AOJu0YyILaqKvyD1BzxTim1vQ7x0bwzxtqq+eH/vvUdeStgxiuG0yKgL
 nT9L6peYrC7kbhV+sH1jLzYC/QOUQbBQluoKIhT+GMBeoBPM7efrxG99Pny9/GCI0SLkluTWr2S
 bBG4ce45Hy/dU
X-Gm-Gg: AfdE7ckBP6ko0r89JaRK1dAf1ndNJHRgFB0I3wbao6NMCPDD8YtdRMvLkOuEzp4E1pu
 XE/0DNe7Y57t5t7QKRc0d11IogBBE9Jix500XdwkrK+q4pVPljxoWHC3fsLnBvfWhXXKfcbEJiT
 i9fTHGfx5WG0jkAdUB3poXKEXWe5VXjhgHrMyhK5no2wPAYj48rWdULVmgGCjGRbTmt5PxLSKEh
 8dPf/q4sOYH+wo6uRabLkdyT55aERYighsmMNW6Cm7FTGb7t6Whrw6c0F0hEMVbo3MI89KzJML5
 8Ef4i/xTjFgCZ1QB1DXU0OEG3X8cuTwECsKNfllGkTGuadyXgzvxbFN+hxVKxUIi6QKJAXHUpgK
 mC2xNbw7Jf+e4VXlGLSYyuAw2gqQMDl23TLlPZI+WbAyjjzwqUcZ1ADjXBHmD926IHS/Uq1AM1Q
 hhdArrLO8zliTIlyHg5UVE6wyhj428KFl0QtylVz0ZLe7OxfCnNaT3Q/BDOQrKU/DiVBzWX6bCj
 b6OPhqE8MnEuc8btGUyxA==
X-Received: by 2002:a05:600c:c8f:b0:493:ee34:d875 with SMTP id
 5b1f17b1804b1-493f88bd7famr94758655e9.10.1783956756211; 
 Mon, 13 Jul 2026 08:32:36 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508727f7dsm3825985e9.4.2026.07.13.08.32.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 08:32:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/26] hw/misc/zynq_slcr.c: drop duplicate reset value for
 DDRIOB_DCI_CTRL
Date: Mon, 13 Jul 2026 16:32:08 +0100
Message-ID: <20260713153233.3391818-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713153233.3391818-1-peter.maydell@linaro.org>
References: <20260713153233.3391818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::2;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr2-x02.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Corvin Köhne <c.koehne@beckhoff.com>

When adding a reset value for DDRIOB_DCI_CTRL in c8ba862dbfdc, we haven't
noticed that a reset value already exists. DDRIOB is a 32 bit register, so
incrementing it by 12 will access the DDRIOB_DCI_CTRL register. According to
the manual [1] the correct reset value is 0x00000020. Additionally,
c8ba862dbfdc won't work with a reset value of 0x00000021 because it tries to
detect a toggle of the reset bit (bit 0). Therefore, we drop the old reset
value and keep the new one introduced in c8ba862dbfdc.

[1] https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM/Register-slcr-DDRIOB_DCI_CTRL

Fixes: c8ba862dbfdc ("hw/misc/zynq_slcr: Add logic for DCI configuration")
Signed-off-by: Corvin Köhne <c.koehne@beckhoff.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20260707145407.70287-1-corvin.koehne@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/zynq_slcr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
index 0ae5d607be9..d0f899c3be4 100644
--- a/hw/misc/zynq_slcr.c
+++ b/hw/misc/zynq_slcr.c
@@ -427,7 +427,6 @@ static void zynq_slcr_reset_init(Object *obj, ResetType type)
                           = s->regs[R_DDRIOB + 3] = 0x00000e00;
     s->regs[R_DDRIOB + 4] = s->regs[R_DDRIOB + 5] = s->regs[R_DDRIOB + 6]
                           = 0x00000e00;
-    s->regs[R_DDRIOB + 12] = 0x00000021;
 
     s->regs[R_DDRIOB_DCI_CTRL] = 0x00000020;
 }
-- 
2.43.0



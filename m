Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC99DCEE34C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 19:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLQxf-0008LX-B2; Tue, 18 Nov 2025 14:01:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQxX-0008Ko-Ga
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 14:01:47 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQxU-00061f-PD
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 14:01:46 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-42b39d51dcfso3301508f8f.2
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 11:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763492501; x=1764097301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=x8Y+NEj6VKJAI0u4Zr/Y3281FFvefQs1CGtjQUIOGQo=;
 b=ZdqBrKn5yvGW/UuHcE/v6gkitSZ2KuCQUO413I80qH3EZoD67bSegC5t8N61FIufFp
 K0F/IGYFUZqJcngVJGwzCKJh6MS0MCRT75YaOrxDm29ADHSRBPzL1mcMd2gyycz9RbYy
 80y/pRtR8C6JKwaJUl/UV5MfSTgMkYFWaAy1Pci1mmkj8jurjXQHlYwbQHiWmBzxqoLs
 k+WE+yuaDumLeg3LMFDVRSTFpQid1kESipZR/Hxsmlu/WhzmEpOKAZgDoMRnqAEkRq5I
 sZH9l5HiLUZ7rIyvhDOi1XwdkXozsiz8SOftg2H6Rm8fdQn8V+QjvF05FgAWP+9HV9HR
 heIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763492501; x=1764097301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=x8Y+NEj6VKJAI0u4Zr/Y3281FFvefQs1CGtjQUIOGQo=;
 b=KNKy1KRBTr196haHY5Q34b//TGC0DXEMyeoRwVxfl69/EikvU1zVB9okY9krVcjqEd
 1txI9EwXD49Z9HNQZXfW1QnVVm9HZc1iOhA/i0EqdZnbv1rN+NEOt7z9airD3EFEdMib
 EBgLPS+76N5lxzUuxP7GWcok9vtjgXyx4kd6N/uWRnzOpXe9Dm0i/Vg8twX7a+5umc94
 SOKFIynqX37I7A1/d5cgF27Q1DBtjBLpV3amY7VKAWeaDbw5u/pFKGXDpIyyktzD46Zk
 iM7ZLv9bKvj3FY5qcmqhGFQUc7eLFHQHzDQvTMHIKKIi0AQHEcUCvuRbihgAwzvXG7CT
 8KbQ==
X-Gm-Message-State: AOJu0YzcgOPwUA+F9SimW9gc2GOz/oNeD0stKvinB5zKkVOFxXTJ/Hfr
 /W4MKiIVo36gxbTZ60x02m8HoPu2b8FMEc2l4Y45r5r6E/XOHaIDxXNj1avBSNoniKJkwgSHfmp
 fD1rHrt2ApA==
X-Gm-Gg: ASbGncsas/wPLrC5ye1f+5pNKYcMEzMq9g+Ji2q2naWpZpPRlQzaSTQyF0nPHJNevdR
 KxYwoSWDLSbpjCLuT26aa95+Sk8d4Ay9ZQZmQnS+mkjro+kD+eTeXpi7UxeEQh9SwO9PbqiBuPC
 3lA5aR+odiy+t4to7Kj4qqCJixPzxNPrJwRBRlgfAOK2ICttvpAhGmhRrxcHXCWsF9nThRdK0wl
 iVdbsnwkTF81zE0GJfxgIxjzplvzpYkoxGYhgbDP8EcjNFA2MJ5O2zjJOGvHh6fkFQM90giLdoZ
 JicBYRDcmnVrFIfypwXfkHuRiWmr6pPGPOcq9J0/Lat0R+CWZK25AZf8Cd9GF9lCaYSrUT5Au97
 I+4kjlk4bmx6EM7vRGiwsL5UZ5fwM4kvl4S7Z+I4yZ8Tsrc2766XB66Y9LgWiXgzSFAhWjSpFsF
 Fv9+4+h+R4Ffam+TTwxIkR7h/N3PxnqxZgu+2EA8Y5BYvd2bPsBW6q9i+cx3DT3h4v15IzFxs=
X-Google-Smtp-Source: AGHT+IE6EJVQp8Ym48GIZjuBQ9IeQMu0Q7kn5wH6v6j9sQS8ImFdUdWo2cR1FDrZrOAikzr2aK3OpA==
X-Received: by 2002:a05:6000:1449:b0:42b:3298:4690 with SMTP id
 ffacd0b85a97d-42b593741dbmr16379094f8f.33.1763492501353; 
 Tue, 18 Nov 2025 11:01:41 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53f19aa0sm34186556f8f.37.2025.11.18.11.01.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Nov 2025 11:01:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/18] hw/dma/zynq-devcfg: Fix register memory
Date: Tue, 18 Nov 2025 20:00:41 +0100
Message-ID: <20251118190053.39015-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251118190053.39015-1-philmd@linaro.org>
References: <20251118190053.39015-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Yannick Voßen <y.vossen@beckhoff.com>

Registers are always 32 bit aligned. R_MAX is not the maximum
register address, it is the maximum register number. The memory
size can be determined by 4 * R_MAX.

Currently every register with an offset bigger than 0x40 will be
ignored, because the memory size is set wrong. This effects the
MCTRL register and makes it useless. This commit restores the
correct behaviour.

Cc: qemu-stable@nongnu.org
Fixes: 034c2e69023 ("dma: Add Xilinx Zynq devcfg device model")
Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251111102836.212535-9-corvin.koehne@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/dma/xlnx-zynq-devcfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
index 26845713ee5..8141d460338 100644
--- a/hw/dma/xlnx-zynq-devcfg.c
+++ b/hw/dma/xlnx-zynq-devcfg.c
@@ -372,7 +372,7 @@ static void xlnx_zynq_devcfg_init(Object *obj)
                               s->regs_info, s->regs,
                               &xlnx_zynq_devcfg_reg_ops,
                               XLNX_ZYNQ_DEVCFG_ERR_DEBUG,
-                              XLNX_ZYNQ_DEVCFG_R_MAX);
+                              XLNX_ZYNQ_DEVCFG_R_MAX * 4);
     memory_region_add_subregion(&s->iomem,
                                 A_CTRL,
                                 &reg_array->mem);
-- 
2.51.0



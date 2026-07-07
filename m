Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3794FC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 14:54:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh7Bf-0006Yc-Dc; Tue, 07 Jul 2026 10:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1wh7Bd-0006Xq-ET
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 10:54:13 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1wh7Bb-0003sr-Sq
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 10:54:13 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-493b77b150aso39168165e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 07:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783436050; x=1784040850; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fzFC75ogeT0IyP06gRR/9SRbSQoQZxiJHNniJnsTtWI=;
 b=fl7anRUASCFs0HGYPshkFbbJ5pWglxl3F8CNB7ZROt1oE1R93XPl/Tlta847vZkVya
 v9NIWvwfvf89sN7nDYIF+mobVChPWWqtplQ3MLCpCqG8Zsb1Ns1/FJYL3qkbrVxp10E8
 KC3Fszk9vgumEFKHLx7qNOeSxjwiGvUadlgxJrI5cWHdossSD2m9KhbsdvjU9M31buSo
 sw+DUE+cDSWSIY5u7ywzFKnBIqZwa2lR53mCP69n1VLcU7hMVTwG/iPJPpWFBG9gEjO2
 osXq1WM+rnbLRjRrKIGEoxw7/OVaq2BDdifoMqmYPUdM7c4bpZejdHa539Ph10TqTKHD
 uErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783436050; x=1784040850;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fzFC75ogeT0IyP06gRR/9SRbSQoQZxiJHNniJnsTtWI=;
 b=KQbZ4doi+UBQBrMZOWOpnWD1ER9A/8UJ/LHciRSbfbQ0vS8H6TEhJDFOXTK9NdVNtO
 wUN1BnyrMtD4aAmxDDk2G6GIJp7Yw0IuPm6OoLAh6zY/K3FT1R46sJPrCrnr4Dk1rlpf
 RLgVmEJVdLtg19n0R/62mLPm3pEfbhlzLBDR3jOAz/Zb+MrW/nRWSl9KbZt92e66LVeQ
 UDAifbFvz+tSswyDCQ3LVHQTZ4i7YovlnYjVJRvN9PL0RAEeT4i7mBTo5Ik0ZFgv097G
 3r283chYvPKuTHK0RHGoRkjVK6Q6F9MUyMP6IKfGR5WGNHQo2yrcT06llil9/T00maXy
 J0AQ==
X-Gm-Message-State: AOJu0YxyUhRhQ+bhh1AEi/q0jE352O3iAswD6SuJgGfkojFZprFybGf8
 i8TjfzYg5kRC4oVuwEJrWb8ieIoNrsrViF3RLGfXXpzHRterEJFW2htINTB1jw==
X-Gm-Gg: AfdE7cl/Pgq7beAcGelOUZh1ayT1xjrR7cfvOdjtTpXq8zeQQhXT+SHfJPg2ZdkwHDf
 hE3JxI2A+pWbSU53LA/A//hb/shm53FqScYFpKebjd1keyHUyqq7pqtwoLbNwZP4POwG38PiXez
 EYIdH+oNf4tvlykX0NGITWyRlbfTgByeatms3NnJIZFoOwbKWSJU/rH66MU94At3eBNhryvJwM8
 V7U0xULE36+1Pk+z6/uBm4srI9GVh6s7JllRtjAcKPFw+rSay/JBd81T6SRdNvEzithbc3t8rVU
 jWEYJVEAxkctBzL8IYxX+YjYNkRcEHKK99pKuJiWMqimv/8IUwVEGYLWwr58PDq7kN4OklxpcMT
 96831rjDHCiXJs/X4YPvi0pyovTJ9ebn/cWR5f4ncrPrekzEGZ6OjKq2B1/G1u8lwlbvrZ8ZgvN
 aiUl9zB6RhZIK9J/3oPYEo67ogh7ZM7xwNW8c=
X-Received: by 2002:a05:600c:6990:b0:493:915b:dc4a with SMTP id
 5b1f17b1804b1-493df055999mr64308325e9.8.1783436049526; 
 Tue, 07 Jul 2026 07:54:09 -0700 (PDT)
Received: from PC-DA2D10.beckhoff.com
 ([2001:9e8:dc38:2781:b40a:d629:717b:1d8c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039b0cesm34811367f8f.22.2026.07.07.07.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 07:54:08 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, YannickV <Y.Vossen@beckhoff.com>,
 qemu-arm@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
Subject: [PATCH] hw/misc/zynq_slcr.c: drop duplicate reset value for
 DDRIOB_DCI_CTRL
Date: Tue,  7 Jul 2026 16:54:07 +0200
Message-ID: <20260707145407.70287-1-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=corvin.koehne@gmail.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 hw/misc/zynq_slcr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
index 0ae5d607be9b..d0f899c3be4d 100644
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
2.47.3



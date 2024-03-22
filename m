Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 372CFC54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 08:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnafH-0004J5-22; Fri, 22 Mar 2024 04:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnafF-0004FZ-Ro
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 04:54:13 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnafE-00011t-41
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 04:54:13 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1dddad37712so15712665ad.3
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 01:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711097650; x=1711702450; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gggN9oJqY5bBdrfB5/j/DAwZ/Z57rRd8F4t6/CMnQ6k=;
 b=Ao3eFCFLIXNv2Uj/pT/2TIPEx8t1r1K4Op7l+XyC35LkRbVB1wNCGKaqnKdhnnoC2m
 mHPic4cL4V/+NE4wzwXsMXJo6M1EYjyQlLCK3Q+yM9xeioswYSiNqpx5tIqL2H5Da2yl
 957f41oMQOFTJU9gppCZNTHB34Xjr5CvdAxo15Si7WiiQw9oYGLK78GZquDGuGRG7jCe
 pvpTTxyGY0WVQQlWsBHPtiWGhBchY/8wWtVw1st1NpWdZkUjhQDXu4HwPMW8tJsd2H6E
 EZ7vHS3CC+tuQy7JI4HpXuziFL20MYZ8AsHKTldpxjbAJYyh6aKta4QPfJom8A57ofvg
 /WMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711097650; x=1711702450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gggN9oJqY5bBdrfB5/j/DAwZ/Z57rRd8F4t6/CMnQ6k=;
 b=M29AlhEU6uVq9fzGR71EnbByFK4xG8czhSorDvYsjHWsherRzSRkdxfsxjiLCmlbg9
 4jdDBdKD4mMTL+r1rfRkLiCVf54+07K9uwBKH5yOoICf/iV8YsI2q6i603nRHTL4njGa
 Cw12NX/nrZDSI6ST5025nIqHLvjVEoNewWtajNkTbza4l1x8QOo8Eq3+P2u8llcKkk1v
 0tnp78yVO3xn2JLW1Qhtekly8iQGKJ1sRJseuuz0tcqiZoguBB49X20FXKBZM6UJTjv0
 1Gcoh3yGFC36fQ7nsA1S/Dac0nwCTCCBf+9S7WMVhfv/M4c9Q+NO21hoi/mxJlJMwnEp
 rLEg==
X-Gm-Message-State: AOJu0Yw2IpMXG7/A66MJKpYTvu9aA4Z4Kr2MN3snlSQZTWXry4h/ctwN
 wZkqjh23Uepe+6Hb6C5cqa3qGRYPBl7BhUcIdPfZZSinH9OI/9kPd1cHy6iOPezoxw==
X-Google-Smtp-Source: AGHT+IEiuqoY3YgKcT+0OGq6dN7j3f4prsO+0GxfLfd/dAoamgkuCvNL/yF1ccWKE2UAA6K1rCXeDg==
X-Received: by 2002:a17:902:d485:b0:1df:fa83:2cdf with SMTP id
 c5-20020a170902d48500b001dffa832cdfmr2268237plg.18.1711097650472; 
 Fri, 22 Mar 2024 01:54:10 -0700 (PDT)
Received: from toolbox.wdc.com ([129.253.180.114])
 by smtp.gmail.com with ESMTPSA id
 h5-20020a170902680500b001ddde07af12sm1369048plk.143.2024.03.22.01.54.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 01:54:10 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Frank Chang <frank.chang@sifive.com>,
 Jim Shu <jim.shu@sifive.com>, Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 12/15] hw/intc: Update APLIC IDC after claiming iforce register
Date: Fri, 22 Mar 2024 18:53:16 +1000
Message-ID: <20240322085319.1758843-13-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322085319.1758843-1-alistair.francis@wdc.com>
References: <20240322085319.1758843-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Frank Chang <frank.chang@sifive.com>

Currently, QEMU only sets the iforce register to 0 and returns early
when claiming the iforce register. However, this may leave mip.meip
remains at 1 if a spurious external interrupt triggered by iforce
register is the only pending interrupt to be claimed, and the interrupt
cannot be lowered as expected.

This commit fixes this issue by calling riscv_aplic_idc_update() to
update the IDC status after the iforce register is claimed.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240321104951.12104-1-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/intc/riscv_aplic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 6a7fbfa861..fc5df0d598 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -488,6 +488,7 @@ static uint32_t riscv_aplic_idc_claimi(RISCVAPLICState *aplic, uint32_t idc)
 
     if (!topi) {
         aplic->iforce[idc] = 0;
+        riscv_aplic_idc_update(aplic, idc);
         return 0;
     }
 
-- 
2.44.0



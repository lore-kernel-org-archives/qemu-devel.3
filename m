Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C18FAC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 06:14:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9eE8-0003Yc-Mu; Tue, 29 Apr 2025 02:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1u9eDd-0002X8-7J; Tue, 29 Apr 2025 02:13:30 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1u9eDb-0005RS-G5; Tue, 29 Apr 2025 02:13:24 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22c33e4fdb8so59608655ad.2; 
 Mon, 28 Apr 2025 23:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745907202; x=1746512002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WxlPI2Cvo+aYt0rDJ/RZsKYq/rKLYTpIrIvw7Wpa0ew=;
 b=XvvcV19KzjJu94T6ug7vL1zXpSQMmN2g0YXnRklZVLNwqDmw33eLqqKznKKmJ5YwXh
 Muoip6w1u8jSa+9+Cdb1uEoG/n37v51uKD2GxUspRbopOhTtvLOKrAdll00e3eYwom/Z
 P1EVhx7hTntX4Cg1ZI1MB1Z9kWgHHHgk45WeZanU6GGm2RUlI0Fg37i9LwKYY2CNBI96
 qd25zMZt7BWWexZeai/dGf5MsrXay+i37Objs16+zSe2s3p1/Yr+DmUndGcBUvNEX295
 uZES5Xsi3CPuE9V7TBU6g9gLPt1nAbsG47HFZOfsYmmO5qQi1nt7Tvogdjq5EPfG62aE
 INtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745907202; x=1746512002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WxlPI2Cvo+aYt0rDJ/RZsKYq/rKLYTpIrIvw7Wpa0ew=;
 b=UKmSM4SSq5e89oP/IJ417cZOjGbD8+CWp4hIsM93WxBoKIAnKIMBt33l+PslLsEdzx
 neOqKpKd/D/nrRz39V1kSjCGL/Ntv4P9DvXRsKRY+avfPocm/tUV3Exw4YfOhKr+yz+l
 FQWNLDNM7vb6ZpN6U/CV0yvn5pna8dhsXGBKcygoXzTptjdj5/I4shMBv+Nng8dO0l96
 HnHnK4JUlW8PhDcJ/0O/VlAPph6TzPr7te9Al9FEm0/dIFl3/cTnKJVZDjYUp+p7VmPv
 YNfekjI9Dd8MZiodqTfMz5txnkQOVbac40xWd0+gt5r8G8HmqiPHzQAZSLiL7SdF7P4r
 XaHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXA4iXCZFdybHgfLSR4bVciBmt7+vETbJezZ+ulUojWNBN2QL0CU2vKrrY/pycu5874KSmMzOehCybO@nongnu.org
X-Gm-Message-State: AOJu0YxZtvIyXq24ISsJ6RSR4syQ2/HXiC2OJ1mPYxj/KbXGmp701FAE
 9II39ZA9VLVT2CV+vJABo2faZ7V6i12kDb1TT14FXdjd4Oy/HUrVGcSQaQ==
X-Gm-Gg: ASbGncvgOJFCy099a46XPUORjOvWvGSt4PjsAS4xtPIpZFywPOv3Csl4pGzRHHeeuhS
 xmec+L61g1qGp2DExO+6TLER6Om1eXQYTGSE6dWOYF7oOJX0Nx3mD6Or4+WvY65mjzcBvj/gsV6
 uFU2JuahR2kKVlnjF7LhZAxascfNJV9H+0V06rAOtS+spNdMpE82udaVZXVBxZoN6T/MAmyM89s
 LQTgn6C1T/AAxI3uyaHntAy6HBW8HOtbCzb4mDCFI7lRAqK3X8z08toa422fE4K4DT4fkpFJn7m
 RzPP666xxpGzOaeED1u5XUZvE1XGgs7KWxS10SLmjUcbU30cwKFO9dqqkxx0Xw==
X-Google-Smtp-Source: AGHT+IHGd7RoTEuqvYQxIqXo+LbRYVo414Ih3xk3Y1sgp1FJrOV2dc098erqm/x0wbRZ5IQ31ArIqA==
X-Received: by 2002:a17:903:120d:b0:223:47b4:aaf8 with SMTP id
 d9443c01a7336-22de60a3e97mr33309615ad.52.1745907201632; 
 Mon, 28 Apr 2025 23:13:21 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db52169casm93947765ad.238.2025.04.28.23.13.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 23:13:20 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 10/13] hw/riscv/virt: Use setprop_sized_cells for rtc
Date: Tue, 29 Apr 2025 15:42:19 +0930
Message-ID: <20250429061223.1457166-12-joel@jms.id.au>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250429061223.1457166-1-joel@jms.id.au>
References: <20250429061223.1457166-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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

The current device tree property uses two cells for the address (and for
the size), but assumes the they are less than 32 bits by hard coding the
high cell to zero.

Use qemu_fdt_setprop_sized_cells to do the job of splitting the upper
and lower 32 bits across cells.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/riscv/virt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d9303c9bb033..823ef7cbe447 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -992,8 +992,9 @@ static void create_fdt_rtc(RISCVVirtState *s,
     qemu_fdt_add_subnode(ms->fdt, name);
     qemu_fdt_setprop_string(ms->fdt, name, "compatible",
         "google,goldfish-rtc");
-    qemu_fdt_setprop_cells(ms->fdt, name, "reg",
-        0x0, s->memmap[VIRT_RTC].base, 0x0, s->memmap[VIRT_RTC].size);
+    qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
+                                 2, s->memmap[VIRT_RTC].base,
+                                 2, s->memmap[VIRT_RTC].size);
     qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent",
         irq_mmio_phandle);
     if (s->aia_type == VIRT_AIA_TYPE_NONE) {
-- 
2.47.2



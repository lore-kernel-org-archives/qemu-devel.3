Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A5C3C3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 14:17:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEqPu-00041N-DM; Tue, 13 May 2025 10:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1uEqPr-000411-Nz
 for qemu-devel@nongnu.org; Tue, 13 May 2025 10:15:31 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1uEqPp-0005Wx-OM
 for qemu-devel@nongnu.org; Tue, 13 May 2025 10:15:31 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a0b291093fso4230589f8f.0
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 07:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1747145727; x=1747750527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=F+maDH+SeTIObLyt1PoV+b1biPi7a1G5liB2x6ZkIPE=;
 b=OeIQM7MnnDagy+LiETWgfWvZt8tzoQfk8VjEK8t438bQbQ0Sr041Pk0hxvdauGJsIt
 6XBvKwE9W+qjScJsF+aQthSfA2RLxb0tCQZOGobdYw//V6XWbuDkmHK+UQriEowOhRk6
 zymj8Va7hwkvws9sgc5cYosQYQnorYN6KMqhSy4rDhLiLcXgwbuWlXuWAah98nhmZHMQ
 0jDOET4xPVoHNcvrIPqSV171DrBb1/aCPaLEpVP3V8he+xLVdMMlS06CXaHHLDmWAThd
 39iI/60vUua0dQkx9Erd+yIlA1JtSE7E8fjE4ttbgexTMq4AspwiY1QyG6r4ZlQaWgqk
 94kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747145727; x=1747750527;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F+maDH+SeTIObLyt1PoV+b1biPi7a1G5liB2x6ZkIPE=;
 b=JTAzukQr/tS+tBcF8LZayEmZT8kHdNas9ujecl9j9Oe1pDlVL9HVlwtZcuLGvIf2PE
 kS5N4jGx1lMghx9BApc0JT7NO8zPKh5yBOAV7JLtuXcgeDD6q3I1vlKUkvDN2TVaaFxi
 8dnIvwlt1XQepVsAQcyrPLw+ZX5OqHzL7jagm2Al/o519IPTdYtqxQzml4Ubi74Vklqz
 DbUFt/lmM9KVfXsXNVLEJD79ybaEkC00nj+Glr7xusZ7krAji3n6aHI3oq1DcI5IijeR
 N+wOm4yhR+6LYwQ3BTJrU4Phr5GwY6fQyyRzhsQ+clSeitTB825lKdY7a9O+/NrIM5wE
 cH4w==
X-Gm-Message-State: AOJu0YwCAOLEZTu5EPhvegcizUUgvWGjhPo6wnQPP1fCRMOL3xJcb349
 0b5AXkYk2W2ltcZ9UyzKpc4mVulxMP8NRT+eJQvzxwnOZEwhQdjZoC2tckm+m94SlMuiHmjiFVM
 =
X-Gm-Gg: ASbGncuAF3QePaOjfTEMIbMFHNm+bbJpErdquNlGwKYH9Bb725tOhVw1NpVXs/5+2oW
 hWE88YIqm+E8uV6cf04/8jwoPxlW0/NOYZ1D+1SI/5OkhSWOpFKo2GErBn53b+vyujG85DU4r24
 5oUTS4pAW0u3mLUD0MNGgZfTkStu4ZPAIRYEgWq2zHzKkM4mH788LJZvMMm3odQ/50IzmUS3uB5
 6fp0ymTBaPVQu5hpHmkUo8mxFEDxh6TkjBO+vRbz1GGwmb2rYo4CHnngf7LqsRYS8dVtHwNrY/M
 P6clqn0rcalzzch11Zw1tZ4k2XAmzfjCoCSonojIN6okZqVLs5yyAnclJWfXFrg6j1BMF6OYpdQ
 oqcomJacK3qh+cpxtyNUqnQ4HRQtS2pUBVFUOLD7kT5R67K1u
X-Google-Smtp-Source: AGHT+IEcOyVOEHfKNQjhWJliAvd9bfwxuukvTRBrTZxcLdwMka8L6bMixMAA75YVRK6O5cW0e6n4rw==
X-Received: by 2002:a05:6000:1847:b0:3a1:f538:d9d5 with SMTP id
 ffacd0b85a97d-3a340d345f1mr2724047f8f.28.1747145727135; 
 Tue, 13 May 2025 07:15:27 -0700 (PDT)
Received: from chigot-Dell.telnowedge.local
 (lmontsouris-659-1-24-67.w81-250.abo.wanadoo.fr. [81.250.175.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd3b7e7fsm213438805e9.39.2025.05.13.07.15.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 07:15:26 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, edgar.iglesias@gmail.com,
 alistair@alistair23.me,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH 0/4] xlnx-zynqmp: add support to boot on RPUs
Date: Tue, 13 May 2025 16:14:44 +0200
Message-Id: <20250513141448.297946-1-chigot@adacore.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=chigot@adacore.com; helo=mail-wr1-x431.google.com
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

This series enhances Xilinx ZynqMP support to allow booting on RPUs and
ease gdb connections to them.

It was validated with home-made binaries. FreeRTOS was tested but without
success: outputs/IRQ seems broken. AFAICT, FreeRTOS is expecting Xilinx's
QEMU thus I didn't investigate further, but I'd still like advice
on the 3rd patch ("wire a second GIC") since it could be related to it.

Clément Chigot (2):
  hw/arm: make cpu targeted by arm_load_kernel the primary CPU.
  hw/arm/xlnx-zynqmp: adapt cluster-id based on the boot cpu

Frederic Konrad (2):
  hw/intc/arm_gic: introduce a first-cpu-index property
  hw/arm/xlnx-zynqmp: wire a second GIC for the Cortex-R5

 hw/arm/boot.c                    |  15 +++--
 hw/arm/xlnx-zynqmp.c             | 104 ++++++++++++++++++++++++++++---
 hw/intc/arm_gic.c                |   2 +-
 hw/intc/arm_gic_common.c         |   1 +
 include/hw/arm/boot.h            |   3 +
 include/hw/arm/xlnx-zynqmp.h     |   6 ++
 include/hw/intc/arm_gic_common.h |   2 +
 7 files changed, 115 insertions(+), 18 deletions(-)

-- 
2.34.1



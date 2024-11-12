Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 328FED42BBA
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 18:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAvLs-0004tu-Jw; Tue, 12 Nov 2024 13:10:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAvLp-0004tc-HN
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:10:53 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAvLn-0001rH-PH
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:10:53 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-539e63c8678so6998793e87.0
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 10:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731435050; x=1732039850; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=02nbOPquIFIJqwULBYnSGnknsi6UNk1AXrz3sdcihGw=;
 b=rarw7PSrqk/FXhgqVnYkquTy6QhaKAyRQZxmWPh9HGLkixNfoKETP8fqmEiTW+HSfA
 l96GXsDRrDOsnzyB2+ldqvouTJVr7J/dk02HLkodUovIZsXp9pyIXbAVnjpf4tiB2fsU
 /cBYknTlMwr/mSp74+XTGCdk4kpCN/l8fk8MCMxJFPpS1NcU2xLwB9Uwvtv16cNTue5m
 v5QzhKUbMZclDD5C9fEvQueXuRswkxO7ShC3myJHr7JZ8FNI1roqpxqyhWcFrcw/fiTt
 EBe4q6+a5HvMI/SLPYJ43dc52quwD7neM6W26bHLPwIKV4J5OIiMvf0uMAyrBH7AAhHP
 erTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731435050; x=1732039850;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=02nbOPquIFIJqwULBYnSGnknsi6UNk1AXrz3sdcihGw=;
 b=OjLLt0iUNWYTm3suxCRuE3P4UWdqHBDVHRszQSo42Iya3CFt/EkPnUhrHgtkbdX413
 rBQN9xNbgME6B9QEOQcCg2gn6mMlVEPXEkpSD8ioSk/aKyygS7whtl5QDZEWtxpk4at1
 n9yKTBqOT6oRMpxXEA+TedrOQ3jfwDMjnGy3AqUoyz/rjwoflf8kWxkqqs8xc63sFynv
 4Q2gDmiRFfE9exrlXJgMtXRHk29RmsVRZ1HrKlAGpaWu3Eh6ifZcIHLjL+wNSQqZhpKx
 h+zws3i7grFrCNi2WNc4YZD2I27VZ9dcXODoji0VNhjQRHkQgqnPgGWvuztsa8bqA++s
 4bbQ==
X-Gm-Message-State: AOJu0YyPO2Zsbf96/qqeUBkhszWSLzGnL+geLNt2VH+ejOJ/Svmqp57b
 56H9E3lRkivkQnzmJ1pNlxZOEkD3dzZe2oUae9JOZr0pS5cMulGURrmdx8LGoQd0weTt+CsDF21
 v
X-Google-Smtp-Source: AGHT+IGTl5y0oWVkY+zC2US0YIbLJ2BK/5maW+YFiznEpj9PFCrr0+kUaH3VLY9cdpks2ULSgFMVGg==
X-Received: by 2002:a05:6512:3d29:b0:539:8fcd:510 with SMTP id
 2adb3069b0e04-53d862d3b19mr8737610e87.20.1731435049416; 
 Tue, 12 Nov 2024 10:10:49 -0800 (PST)
Received: from localhost.localdomain
 (cnf78-h01-176-184-27-250.dsl.sta.abo.bbox.fr. [176.184.27.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b0562ccdsm214644345e9.23.2024.11.12.10.10.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Nov 2024 10:10:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Anton Johansson <anjo@rev.ng>,
 Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 00/20] hw/net/xilinx_ethlite: Map RAM buffers as RAM and
 remove tswap() calls
Date: Tue, 12 Nov 2024 19:10:24 +0100
Message-ID: <20241112181044.92193-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is the result of a long discussion with Edgar (started few
years ago!) and Paolo:
https://lore.kernel.org/qemu-devel/34f6fe2f-06e0-4e2a-a361-2d662f6814b5@redhat.com/
After clarification from Richard on MMIO/RAM accesses, I figured
strengthening the model regions would make things obvious,
eventually allowing to remove the tswap() calls for good.

This costly series mostly plays around with MemoryRegions.

The model has a mix of RAM/MMIO in its address range. Currently
they are implemented as a MMIO array of u32. Since the core
memory layer swaps accesses for MMIO, the device implementation
has to swap them back.
In order to avoid that, we'll map the RAM regions as RAM MRs.
First we move each MMIO register to new MMIO regions (RX and TX).
Then what is left are the RAM buffers; we convert them to RAM MRs,
removing the need for tswap() at all.

Once reviewed, I'll respin my "hw/microblaze: Allow running
cross-endian vCPUs" series based on this.

Please review,

Phil.

Philippe Mathieu-Daudé (20):
  hw/microblaze: Restrict MemoryRegionOps are implemented as 32-bit
  hw/net/xilinx_ethlite: Convert some debug logs to trace events
  hw/net/xilinx_ethlite: Remove unuseful debug logs
  hw/net/xilinx_ethlite: Update QOM style
  hw/net/xilinx_ethlite: Correct maximum RX buffer size
  hw/net/xilinx_ethlite: Map MDIO registers (as unimplemented)
  hw/net/xilinx_ethlite: Rename rxbuf -> port_index
  hw/net/xilinx_ethlite: Add addr_to_port_index() helper
  hw/net/xilinx_ethlite: Introduce txbuf_ptr() helper
  hw/net/xilinx_ethlite: Introduce rxbuf_ptr() helper
  hw/net/xilinx_ethlite: Access RX_CTRL register for each port
  hw/net/xilinx_ethlite: Access TX_GIE register for each port
  hw/net/xilinx_ethlite: Access TX_LEN register for each port
  hw/net/xilinx_ethlite: Access TX_CTRL register for each port
  hw/net/xilinx_ethlite: Map RX_CTRL as MMIO
  hw/net/xilinx_ethlite: Map TX_LEN as MMIO
  hw/net/xilinx_ethlite: Map TX_GIE as MMIO
  hw/net/xilinx_ethlite: Map TX_CTRL as MMIO
  hw/net/xilinx_ethlite: Map the RAM buffer as RAM memory region
  hw/net/xilinx_ethlite: Rename 'mmio' MR as 'container'

 hw/char/xilinx_uartlite.c |   4 +
 hw/intc/xilinx_intc.c     |   4 +
 hw/net/xilinx_ethlite.c   | 357 ++++++++++++++++++++++++--------------
 hw/timer/xilinx_timer.c   |   4 +
 hw/net/trace-events       |   4 +
 5 files changed, 246 insertions(+), 127 deletions(-)

-- 
2.45.2



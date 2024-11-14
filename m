Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799FED6A22F
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 21:00:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBgwv-00080e-HE; Thu, 14 Nov 2024 16:00:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBgwt-0007va-PY
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 16:00:20 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBgws-0007ss-02
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 16:00:19 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4315f24a6bbso8938795e9.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 13:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731618015; x=1732222815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LwtKlFyLirVGmcUUsZN1RQkG5HiIWs+0ZyXLJLGhGNs=;
 b=s6PvdGYn3CN48S4Effqx5D1I1n4zX3eArpEKxyJNJwNtVga1dLc4/azlQa81QchkF+
 /ex4uEdHsXgHJhrArXHcZKUEyPpIB2ExKMI0bQbvUOjY9GDJpDXFBkKdwb3VVcleU+dH
 hH0RzsQ5BiDOEStncH+/3hsJS2sEO3bbV6oyiE8rS86lmGtmDz6E0yoXCJMne8PxAdxT
 7M/8lI1Y2kwxWF1FCTTnjvAQy3vxnKLILMAsjqIvj45kn53mZVzTggi5FMVpcZhh+YnO
 AponhmEHjqmmY0u/hVRDql2XS1FIVQAF+rwnV4LHASJv+y/Wjiz1/75wPp6b2P1xDC4f
 m19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731618015; x=1732222815;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LwtKlFyLirVGmcUUsZN1RQkG5HiIWs+0ZyXLJLGhGNs=;
 b=rnlUbJPkmF6QcPUa9IuCH1/x1aOiYXs4FQRfIO14pqPicwZAf3UqXJBy7DhnV+RWzi
 ZWgW2No15+9ce0+CITH2eijJTVaahprdcVZYjvfwl5Moc3sKhlIHq/Xu4bmjs+ZYyV4N
 KvlVdjE5Y1kzxt5DjwhFyLD64KN1U0/RgEHGWp3X+aYCkf75wHZhF3YJhXR/3+XvnZwa
 W7ZNfVBu81/7kiYMCILte4F46JKoichXxiRMWtsXglhR5W5BkL4R5LJ/hBG8MuA9cu5A
 l/xEAgIHjLmmI/q+qL4VxwXPoKARuRJb4cbC9MsqG1B5bAm/ifMTFlG9Uh/5SpKUXTY4
 RtYA==
X-Gm-Message-State: AOJu0YwCsvOwdi2iuKa21Gr0L5/LlwF2tGAHC6hYDKKe+8l0iDbk4V20
 PX3qSklxfvh9/W7mi+x19g3O0C28H7JzLDlNEb6zJee7wRvEpjis8IIEte3aqZYJ7DC+zPue9+J
 X
X-Google-Smtp-Source: AGHT+IHR4ZTtLJKnr9zKGkdvZ0M5RA087012bErx+BNcXy/PFcHJ/D0fBJs3udScel0wGiPPLIN2Jw==
X-Received: by 2002:a05:600c:198a:b0:426:60b8:d8ba with SMTP id
 5b1f17b1804b1-432df78f0abmr1187295e9.28.1731618015615; 
 Thu, 14 Nov 2024 13:00:15 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.228])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dac223e6sm32380635e9.43.2024.11.14.13.00.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Nov 2024 13:00:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Bernhard Beschow <shentey@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH RESEND v2 00/19] hw/net/xilinx_ethlite: Map RAM buffers as RAM
 and remove tswap() calls
Date: Thu, 14 Nov 2024 21:59:51 +0100
Message-ID: <20241114210010.34502-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Missing review: patch #19 (new)

Since v1:
- Addressed Edgar review comments
- New patch to map RSVD I/O region (Paolo)
- Added Edgar R-b tags

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

Tested using 'make check-functional-microblaze{,el}'.

Please review,

Phil.

Philippe Mathieu-Daudé (19):
  hw/microblaze: Restrict MemoryRegionOps are implemented as 32-bit
  hw/net/xilinx_ethlite: Convert some debug logs to trace events
  hw/net/xilinx_ethlite: Remove unuseful debug logs
  hw/net/xilinx_ethlite: Update QOM style
  hw/net/xilinx_ethlite: Correct maximum RX buffer size
  hw/net/xilinx_ethlite: Map MDIO registers (as unimplemented)
  hw/net/xilinx_ethlite: Rename rxbuf -> port_index
  hw/net/xilinx_ethlite: Introduce txbuf_ptr() helper
  hw/net/xilinx_ethlite: Introduce rxbuf_ptr() helper
  hw/net/xilinx_ethlite: Access TX_GIE register for each port
  hw/net/xilinx_ethlite: Access TX_LEN register for each port
  hw/net/xilinx_ethlite: Access TX_CTRL register for each port
  hw/net/xilinx_ethlite: Map RX_CTRL as MMIO
  hw/net/xilinx_ethlite: Map TX_LEN as MMIO
  hw/net/xilinx_ethlite: Map TX_GIE as MMIO
  hw/net/xilinx_ethlite: Map TX_CTRL as MMIO
  hw/net/xilinx_ethlite: Map the RAM buffer as RAM memory region
  hw/net/xilinx_ethlite: Rename 'mmio' MR as 'container'
  hw/net/xilinx_ethlite: Map RESERVED I/O as unimplemented

 hw/char/xilinx_uartlite.c |   4 +
 hw/intc/xilinx_intc.c     |   4 +
 hw/net/xilinx_ethlite.c   | 371 ++++++++++++++++++++++++--------------
 hw/timer/xilinx_timer.c   |   4 +
 hw/net/trace-events       |   4 +
 5 files changed, 256 insertions(+), 131 deletions(-)

-- 
2.45.2



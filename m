Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A93C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 06:56:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taUfA-0006Uh-Hh; Wed, 22 Jan 2025 01:56:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taUf9-0006UY-EV
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 01:56:31 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taUf8-0004qA-3E
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 01:56:31 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3863494591bso3518549f8f.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 22:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737528987; x=1738133787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zXmb8IR/aSdk7HjYL9Mo6XsRDrHneoBc8L/q8OEpb2o=;
 b=uzjlosoSIOIofMK7lGFdcx6+FHhRmvzVchEEKgJ9klbCX/Urc7bfu0fWFsDLJYbUFz
 Hz1rijkBSucXaXHBZhpfer1DP/n+nfDhxqaC/g9yztdkbTN6BDDnA9NWnfiws8uvvIqg
 wvSxzIRBEeYHegJB1MyR7nIRvXaEpKC+cQ3OoKLlLXgVeL6tA1j/0SSFXQ+D22ZDuJhz
 XYiIsXU+y8NTN7p/rYTW8iL2BG9D9jEubQHXuTmoDAk9MZjjZSiPKaQaU2IyZlHLTwSB
 2IOG4Hct4WG6pG4Ior/wXfyBDOH80ye76pgu7/E+dDQud/xwIJ2qDpismEmvibzapYSH
 qU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737528987; x=1738133787;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zXmb8IR/aSdk7HjYL9Mo6XsRDrHneoBc8L/q8OEpb2o=;
 b=shC9UOaud3+waQL2WvFYocCeHHb85uUr0UHtHUAOHZR1skFy9E+Nxmt+UJGxAsrZyV
 4zzQLJQw6nS9Rz075gQ4lQjkh/TZSahQNmD7oIcD355+or4gVPh0SS6IO2jlS1VH0ulT
 9Y52tnhUtvNdXezhn6z/ttRJkWquwhbekMbGqBeRgbWELyqaVEC/FKheh/2RtPD4ObOS
 7pFU5QFORF2bA8S+dfvkJO8GvYvbBzB98sknXwl8lfH2Wa/T3UOqW/WY4j+IEhLaqNIS
 cPMV2wHLKpodyXQAENl6SsBloe56b/dHoS7wkfWCRqRb98CiiGOj6MgqHkyetqDw3YjY
 L/aA==
X-Gm-Message-State: AOJu0YzWJeN30ZcNp7Fh1OGj1tXVQc2QL/3d9s2fTpanK+ZQIxs1/F01
 punEf8nEfd4D6JdlYeOKcmbJ9KmPW/931Vt5Eq7pW9P3Ir7q+TJIy1wp9JSLhkN+3oHGsTA24se
 +ik0=
X-Gm-Gg: ASbGncuOQutfbR2mtd5INGoODQPGTzfLiq4KM08OEMshnCTpZeIaNcbUvErhGdUSOyU
 sBXZyPxNzHsm2gUmOvRQ0SZuXmXQhzotzZZFO+sQpYWRr1gm20BQydUnvT7PShpth25iGgsMGUV
 VNo4FlNVY9BD6THghIb5iH3zFmyWZWxQtYRQUAyeH6Lmh4ZFCzYFZUXU40/+D3XqNtOPy3Ch1Nt
 f1SX4243Vem5KGYxFJrjbMgLWxGsRzAyOqqybnKyYEkC/0phQ3qX9YH+5ywlzzqMN21enhf6fNT
 P36SYNYE51icQLMZ3kyZd5dfhmGxVHsCHF62IASVrIBp
X-Google-Smtp-Source: AGHT+IHklGeODAwhvLpX7LM9OkCr7lDKWpMtK3LW9mKjTDIBwj8dbZsu3g96IpkOTtaIQv9Yl7Iyqg==
X-Received: by 2002:adf:e283:0:b0:386:1cf9:b993 with SMTP id
 ffacd0b85a97d-38bf57896ccmr12861435f8f.26.1737528986847; 
 Tue, 21 Jan 2025 22:56:26 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf3214fbdsm15745722f8f.19.2025.01.21.22.56.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 22:56:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] hw/cxl: Add tracing for component I/O region
Date: Wed, 22 Jan 2025 07:56:22 +0100
Message-ID: <20250122065624.34203-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Allow tracing component I/O accesses,
remove unused io_registers[] array.

Philippe Mathieu-Daudé (2):
  hw/cxl: Remove unused component_registers::io_registers[] array
  hw/cxl: Allow tracing component I/O accesses

 include/hw/cxl/cxl_component.h |  4 ++--
 hw/cxl/cxl-component-utils.c   | 14 +++++++++++---
 hw/cxl/Kconfig                 |  1 +
 3 files changed, 14 insertions(+), 5 deletions(-)

-- 
2.47.1



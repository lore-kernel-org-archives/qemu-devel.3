Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE4BD6EBFA
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 10:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGy42-0002QW-Oh; Fri, 29 Nov 2024 05:17:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGy40-0002QA-Bj
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 05:17:28 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGy3y-0002gB-V8
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 05:17:28 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3824aef833bso1231247f8f.0
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 02:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732875443; x=1733480243; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TRQ5OhXrEBPPuxw5v4nWbYuMta+PmkN5FPYtcXKbsD0=;
 b=q3Vq9ZpuSBNoPTtYL+siJ1qg1MnBN0nner5FL+2o+nnDNqJJ+j56B2OTY9QzT5oii4
 MkDtzVb3XrXawwO9w1I3Os042ES3SnUCU0jlZ5prcSYtU6tXmOqrzhrR3RLTd0GJnaVt
 uM8fN++XY8l78qraAN81QqH8EQkYkEyilZDhFDjhrNVuG4HTwiZ5l56t8nSqBakLoBBK
 aq/9axT5ZAc1nmwZL8q+plGb7xh53V7C+79+brGlgHDPBzSOz7YhR26btOu4ZR/HL/km
 kp9Hhh845q3IBysd+ns7Af5re1tOCUf66t0zWgrmZ2USH8xm4DkrRNFVI0EgNKqngKvC
 B5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732875443; x=1733480243;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TRQ5OhXrEBPPuxw5v4nWbYuMta+PmkN5FPYtcXKbsD0=;
 b=PORTeRHmb+VYsBUmIjjQwJSr6m04ptJYM7YTA585XedsfuEnI8eQYQvA2iSVMZPz5W
 w01VjlQpNkKISXBZJuiineooJEKHg93lU2NptteFAXB14UHlVjZNBsd7AwQQMpYU2z0n
 GRQI+4dXXZoLC0d2CxXOUXvKQjc6kkcNrRkjFcsXMWmmfBEF/d0o03KO7knNh6IIKqUj
 y6HPrc6hxL/pF7rGT50b94O+6sAADldBK2ebDGMimVuXM3mTJ0itUqG+zWPCJIa0TxCI
 oxFI8wAzojanEeW04Gf5saclyr77GSFKVrZjHT2i5YK3ZfAYmwGCf6lvfJi+aWfvX4O1
 MdLA==
X-Gm-Message-State: AOJu0YzmPBIUvxHGsxHYIshQztcp03vqhOvwOGJmVKz+zdeoi9YIpB3/
 sOcUuAWNPf6AFiJLlu5dhA6cdQgeTD/H2Q3LMk8raMVUCP3Mia7C4lzZDoYkOi4sgxlJtAR1Rfe
 Q
X-Gm-Gg: ASbGncuzZVvcOLEsRxg597lrA+8zglz0oPxOx61kjr5FmPeyxvJUvsMxuzuN9Lq/XEM
 m4SykEFhs1rutGarAya4DfzgLAd953MUUVc+JjbnP3cU6WW/l/HkOxJQtRDaCsZUZjDILI125RX
 WyfeWkUI6GWCqYNbWe30tnnHQ/r1hZVk98twjOKDspcGvnJkm8/0IH2shWAGcxWaB0pyNw20ukM
 B+6kfU4G3GZx/xWTdRefoBOwbNAGwPcUQbD1qY6S6984emp0GLGiyrJryCQ2n+PAxjpkQwa8PL1
 IIbVxCivq3Ur8smZObu4iuPsZokF2w==
X-Google-Smtp-Source: AGHT+IFBm5sH4dKOaQBtHqjWIidLDjEk0rMHDzbNsAYO5WtUz5mtyoIW14N7TbojB77Fo7AZ9xCabg==
X-Received: by 2002:a05:6000:156f:b0:382:5295:b366 with SMTP id
 ffacd0b85a97d-385c6cca8d4mr9455010f8f.11.1732875443493; 
 Fri, 29 Nov 2024 02:17:23 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385df488559sm1116454f8f.63.2024.11.29.02.17.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 29 Nov 2024 02:17:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/2] hw/display/vga: Do not reset 'big_endian_fb' in
 vga_common_reset()
Date: Fri, 29 Nov 2024 11:17:19 +0100
Message-ID: <20241129101721.17836-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Since v1: Split in 2 distinct patches

Philippe Mathieu-Daudé (2):
  hw/display/vga: Do not reset 'big_endian_fb' in vga_common_reset()
  hw/display/vga: Remove pointless VGACommonState::default_endian_fb

 hw/display/vga_int.h | 1 -
 hw/display/vga.c     | 5 ++---
 2 files changed, 2 insertions(+), 4 deletions(-)

-- 
2.45.2



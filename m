Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C66CCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 12:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDMTK-0005Z2-0e; Mon, 27 Oct 2025 08:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDMTH-0005Ug-1D
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 08:37:11 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDMT3-0006Fh-2g
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 08:37:10 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-4270a3464caso2181624f8f.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 05:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761568606; x=1762173406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZmMNH1Y87swIVdIWCYHcdCqVlv4sKMHJmPkKp3l+JAE=;
 b=MYWA72XzuC0eWBR05c7l7EbdvQMahrknaL3aQmMTGi2NH9U43GO6v3YH1bUNogU8c6
 gVmpPftc54ZX8KQiagVJBqlpZoLIuW7y67pc+feUKlOC1lQ+UW51YM5Yk6J6fH1u0EFC
 qVVlQtOmMhL7cRY5CJlS7Vbfo1FaaXySqCfcUrkxmKSdP65pNbIL+DNq+bfqyamq3KC7
 lYu/CsK8GqaQoS/yfQc2rMOR/MLkCemVF31D7k/jHg1lO4DLtJ/P64Ms1yBaB8GJwEAU
 Y4pOpgOpXQ95jS2QNPJmUvhQTS4FetzFLh4IfEvVIHuKzthikEUU/S5O8DGdFXXiDglP
 7VqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761568606; x=1762173406;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZmMNH1Y87swIVdIWCYHcdCqVlv4sKMHJmPkKp3l+JAE=;
 b=VQLw6V2FsS60sv80VOsEkTkSS5D02nRFw9ST23dUOGsewbnc4miCLpEt2gMVa1bGvD
 74cK53LuNbJUuhVEoDDao3K7TKqYKts8ZRTE+8I/noFm6lrf75+ubHmwn/BZdASEfHAU
 o63BNre005UkJZlOAkklzSwysQV5kozz2rju/cxjO1wOufh2J8qxBSTHftjgmDvQgEF5
 /v3LeG8CKAw9+DPep23mfgUUyoZees/dOQ2S0x0e35guXNV1KvlLqgGo/tQsmVMSBi4D
 h5LUXx4tZyEqysTBhXk8bzljFo3iJl7BJOj2VJsPghuHr1s2Onrvh2KbZvB6HK9ODzTG
 z5lQ==
X-Gm-Message-State: AOJu0Yx5KQRFLexmEAE2tG3AeighohDQNwDlyTXtANTAz27ZZhqSGGSn
 WBcqqIRy/Sm3ICnCBZyCQ7NCFSGfOz4HXWvoD+P4GnXjOhLSAneMeBBev2YtFDF+6bFAHavH8kB
 AOyZCn8M=
X-Gm-Gg: ASbGnctPtcUY7Jc3kAvcq2d+jIE0zNkde4hYKEcibSZJawroUx0Sv7wgwj54LmBz2Uw
 jrSCB2w8VesxPEbbbVZMp9AMPY+nJmIE2sJamY3gR1mUX9uA4Qun49JpepA8xNnLixKSxjtMVRG
 3p5wcxkYPGe81s1iFztKuO3ry3gTQNJDLOmgDDEKCFxhJeI3NZ/tVX+Zag2kRJZOdfoD9rfXpRr
 TNUO+1sBmbDOigLkJNhmYOAugd9KLCslXPnLxwEjAi5xbgyS/cyexgKT7GxysdleocTew+4d5Mi
 el8B2/5caa8jLaV/x8J6hueiAYciGLt8Uh8ITAsyd1yYb2i+FqenNnEOj+pZHXXRLQ/Owgdug5J
 L7xnMxPsWxNhhVlr8x2J8TYMDpjVGkmDa5tULJcK+YwPkHxjw4jOpMvxNQNIROKlBkp+cFeTaS8
 f5NJ723Wkz6AaNwKww14PCnNsEpi/w0tCm2QMN7SdO+v8DL+ffDQ==
X-Google-Smtp-Source: AGHT+IGdP4VevcIfO5jRH3vkn6QGYzrBMioVhxD4uFLisrsCOPgle1Zke5+VZ7/asnWDfOAoAFPImA==
X-Received: by 2002:a05:6000:2c09:b0:427:9a9:462b with SMTP id
 ffacd0b85a97d-4298a04e65emr10290870f8f.18.1761568606087; 
 Mon, 27 Oct 2025 05:36:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952de971sm14053377f8f.39.2025.10.27.05.36.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 05:36:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Hildenbrand <david@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Helge Deller <deller@gmx.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Peter Xu <peterx@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>
Subject: [PATCH 0/6] hw: Log unassigned MMIO accesses with unassigned_mem_ops
Date: Mon, 27 Oct 2025 13:36:37 +0100
Message-ID: <20251027123644.63487-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Do not log unassigned MMIO accesses as I/O ones:
expose unassigned_mem_ops then use it instead of
unassigned_io_ops.

Philippe Mathieu-Daudé (6):
  system/memory: Expose unassigned_mem_ops symbol
  hw/display/vga: Log unassigned MMIO accesses with unassigned_mem_ops
  hw/pci-host/gpex: Log unassigned MMIO accesses with unassigned_mem_ops
  hw/pci-host/aspeed: Log unassigned MMIO accesses with
    unassigned_mem_ops
  hw/pci-host/astro: Log unassigned MMIO accesses with
    unassigned_mem_ops
  hw/sparc64/ebus: Log unassigned MMIO accesses with unassigned_mem_ops

 include/system/memory.h    | 2 ++
 system/memory-internal.h   | 2 --
 hw/display/bochs-display.c | 2 +-
 hw/display/vga-pci.c       | 4 ++--
 hw/pci-host/aspeed_pcie.c  | 2 +-
 hw/pci-host/astro.c        | 2 +-
 hw/pci-host/gpex.c         | 2 +-
 hw/sparc64/sun4u.c         | 2 +-
 8 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.51.0



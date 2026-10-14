Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5528DCC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGpbK-0001dB-FA; Tue, 13 Oct 2026 23:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xGpbE-0001XX-Vr
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:24:17 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xGpbB-0000CV-Le
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:24:16 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3a81e149649so259800a91.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1791948251; x=1792553051; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5Yrq0zmhnCQ6jmfiCd+0Py/eNG5Woc0hw6n8wML7KAM=;
 b=QsctJxzm9L6M0oLnJQWuQOLwBUvuP/UhWk9QkFstG4EHPNSMYfTvR3BmZfen185aGl
 BbICq3bQ0mNEwmQozimiFqTDTOurqkA08koXEt5hNvXM6W9gDgjQQZBGbctoXJm5uMKe
 gKUnPJ5WuQKpMfJFHMAHLrLpFaFI82cy8qj+9pYhqAdLoxi08KFMI0Yd5hlC8gdZIzrZ
 3EBOpHONYzV6ljquRFca85gqPgPmfYYVB6zGf8CiYEEfiXUK4C1DfzHojycfeBBX2Jir
 wc+8KzlLLrm5BjGbD9MlPOEMxWytpmtXUuq+FHzIHIeZyF2gtsUHvTt+xCwQDx7vSYrr
 7yoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791948251; x=1792553051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5Yrq0zmhnCQ6jmfiCd+0Py/eNG5Woc0hw6n8wML7KAM=;
 b=io+Sh5pR4agvpaIfgf/0DvSlslC2IpPMHk/ubeEaJL4I2cgali5YpsV3vYSqRY8hYd
 F9ljvUrhzqZv0ynAu5jGYoRJ7URd8hHuqxVi49wnn8X1Rk6UqmE+A178qK2rszeYOOlY
 s2KR4jxjmhEsRHt5zHdEie/quBiCWGOS9oVr1BzSXMRqV+/2e6zX5FXDUGodMjr0VNfl
 5XCxhxgdiV/JI8g7Q1P+MBMTq/08iJz7YrwnZwUy+yhEmaM+f0Qio0CWs94ggOVjURiC
 zkNw5UV0egygOgJG0y0uiYyjAiBnkhpOq5MzEEgIyIlBnr0sTBVNDmav6WngG3WI+sAP
 kJNA==
X-Gm-Message-State: AFq9FYK+tMr7Em/yknsNZrAgo7ZsnNRLBuUptW6yIL3AUTrvrLXpo6Z4
 nRiIFIzxhKTcxmmrXXravJVa8t4kCwj2RTsgpveXdTRXbj9xeUADelYFz18+USSho1JHgPbD5qo
 BnXOsA90=
X-Gm-Gg: AYBFou1xu3OQiEmYt1UTwQRbajfHqX6WL9xIk4jwLUTo7hf+TgUQv6P6csvzdJk6pM5
 tA6HndulqTd00iJr3Dd1X3KlIQ9wrnuaiqK0CQpjPjphAl/+oEU6YfnPCTh25cOzh9gmT5hTe+T
 yoUfwexnbHEfe07L7jxob0ZjhSzFqWIhVaAbBCvEiV/PKvtZMkm6qzczXeXRpJMjbkSoLDwPEOy
 d6uvCFZJp4k/oiaKvv1EqsbNaZOe7LYdh+x84U1U2KTV+myAnsSiVxqGskC0I5vjM1XoRSimxGG
 FsMmYbsJ43JR+5S4SJmyOqlu5/1IfRvHbjEWWruzhHcBaePMX5080exDj7Li8jJTeeudTjhmyGq
 eYfzccyy83MGmbfNjBBxIYLxaP89oUg6G+SVkpTlztk3769vmXazwTR8gUI5ebjBsMf5MJg2QZl
 /iOaibvvUEIK9Ym/h0F8pRTIV5NWfYAsdaswNFxpRsdW6QngyrCNhWEeXdNdqyQzvoO7xGEJ3IH
 B1cuYnbhtwRx0A83v5DFgtiAYdmoQh3m8jm7LaGI7PNFhU=
X-Received: by 2002:a17:90b:3145:b0:3a6:f7be:fee6 with SMTP id
 98e67ed59e1d1-3ab3a346e9dmr19919437a91.1.1791948251551; 
 Tue, 13 Oct 2026 20:24:11 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac6069ca15sm2211261a91.11.2026.10.13.20.24.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:24:11 -0700 (PDT)
From: Portia Stephens <portias@oss.tenstorrent.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-riscv@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Joel Stanley <joel@jms.id.au>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Michael Ellerman <mpe@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v4 3/3] docs/atlantis: Update Atlantis UART documentation
Date: Wed, 14 Oct 2026 13:23:46 +1000
Message-ID: <20261014032346.732257-4-portias@oss.tenstorrent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014032346.732257-1-portias@oss.tenstorrent.com>
References: <20261014032346.732257-1-portias@oss.tenstorrent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=portias@tenstorrent.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Update Atlantis documentation to describe the DesignWare UART used.

Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
---
 docs/system/riscv/tt_atlantis.rst | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/docs/system/riscv/tt_atlantis.rst b/docs/system/riscv/tt_atlantis.rst
index 1f2880d617..0150140a39 100644
--- a/docs/system/riscv/tt_atlantis.rst
+++ b/docs/system/riscv/tt_atlantis.rst
@@ -13,7 +13,7 @@ tt-atlantis QEMU model features
 
 * 8-core Ascalon-X CPU Cluster
 * RISC-V compliant Advanced Interrupt Architecture
-* 16550A compatible UART
+* DW8250 compatible UART x5
 
 Known limitations
 -----------------
@@ -24,9 +24,8 @@ real platform. Notably:
 * There is no PCI host bridge, so virtio-pci devices cannot be
   attached. Boots that need block storage must use ``-initrd`` with
   an initramfs.
-* The DesignWare UART is modelled with QEMU's ns16550-compatible
-  ``serial_mm`` device; DesignWare-specific registers beyond that
-  set return 0.
+* The Atlantis platform has 5 UARTs but only ``UART1`` is currently exposed
+  on the command line serial interface. ``UART1`` is the Ascalon console.
 
 Supported software
 ------------------
-- 
2.43.0



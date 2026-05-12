Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92DE9CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 09:47:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMjhA-0004MS-Df; Tue, 12 May 2026 05:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wMjh8-0004Lz-9H
 for qemu-devel@nongnu.org; Tue, 12 May 2026 05:46:30 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wMjh6-000107-LZ
 for qemu-devel@nongnu.org; Tue, 12 May 2026 05:46:29 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-83975e992e1so2584315b3a.2
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 02:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778579187; x=1779183987; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5aeued/jJSxm/LIZdi9vE3w7+NBzSgkjW44cCJmecRg=;
 b=ajQhPUcrHvLt9Zj/cHpyYsMasfMwrK5AhIkmwN445BJgeyBmKA+qe9uhElg2jmN/he
 NzlCncoC8QzVRhHf3fLwSeTb4iVKizI7RIde0EgrPmpJRp0x+QCDUZ5/ylu8pwxSGSAP
 wRfqN/3+5Nzc9ylw/j687KzX5N6/je0MVcW7QUUsJVfAyC2jVmXt+tdtAKrGHe3FvT1e
 EH3De4+pyPaL2h8637zMLMWcUbJs2Qa5Wm/uJYmK+IXvlwk7OshUMaBKV2Ws6aVk/VVi
 LNIZJXYW8tnRCXtsp3WlmVVdqXW+ogecEj/9mC4kK2TJwA1ZqOQ6mQGEIIQauBWGqcyu
 gGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778579187; x=1779183987;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5aeued/jJSxm/LIZdi9vE3w7+NBzSgkjW44cCJmecRg=;
 b=CTnXCSaXZCAYKtOOR5g520nhFidZm2TWchqze2NiBDXOdva6lC9PJMghTYBVPewJDX
 9ualOgvddahKcH9rvjEdoTp17JN5wtMtV2ELFOnBevxLebxBJfIwjqmLRGQMP6iew0kL
 +J4csItBWT5IT3GeG39kiObapu2qZhGAFw1n20FtMtpCQEhtD+JpjRzM4RRdcbUkjGkO
 cftSEssHLjfwqvZWWcv1hyqxGzCuN547+SrQ+rGac8EHbnp9QP4/W3WKwE3ntSbGw3+X
 2l5fU8xLQJzMMfUopkkHOFP/BVmf+n6A0bstnsheUO+LUV40hX+r24XVD2VDIMg6jYiz
 RDhQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+CgKaLKRM0R0HmLKXEe7bohx3deGqmbxGB1taLw6qTgvBbeGXqOFcrPqvtNyUFq+e6J9428QMaWHVx@nongnu.org
X-Gm-Message-State: AOJu0YwYi18E6ZpnPyBu4AB+gv4QoqBA/nwtwJK5eWLGN4ZqFMLvFyey
 AqmoEc8HFulJ1gZOr9D+jCnq78orqGXqzQzFpqEW8GESlMINqs7w8Kii
X-Gm-Gg: Acq92OG/X6yG6IZSZroxHi+VQHjSCun8419jeRkhywnDNGTHJ4kJK6lvmLLvI7d/GFn
 TY30PkVJG8NBeBAXmcQLjLyOBHgsyYuHpgmI3y498FrsaFdZG/tmzHThO1wuqnqQh3a5fuqRg6k
 o89HwK5O9fVanThGcpNDYyR0O1tjt8biTEdwQL5GbDGNEdge/+lmWYzE11M9AtPC0oJbrcoRWap
 aj+8q8n0QB99fHyTQoVUOktdmF0ME5RjOKM55yCzA9fT8gz4v2HCfQfG/OrintpGydBIECT8CBi
 CIpwDopyr9Gnxf9EZ6XuN/kq4GjlWkZb+lHmNfN4wB3ZDjaU40375qWpWW2SbwVS2gxpJonTYv0
 Be2g1kdUIKPr8RALcU1FPkCK2OpYFMxy22AaQOsxQAJm3LvZfK/93WVC+GkDFLoKSpbCzJZBLx/
 HW1s/noGCTkRzgYzdIftjI2s2PHAM9XahgCDc5X3tRK2LN0il2rGQNYzIEk9gIlM4Adk0QnW0Hz
 Q364MJtsdBoFPmp1ThtModqh2tpxfMcZ6cKHFAg0TF7
X-Received: by 2002:a05:6a00:2406:b0:838:c01a:7a54 with SMTP id
 d2e1a72fcca58-83eeb9b5db0mr2628190b3a.2.1778579186615; 
 Tue, 12 May 2026 02:46:26 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (32.237.80.34.bc.googleusercontent.com. [34.80.237.32])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-839682aba01sm22960593b3a.55.2026.05.12.02.46.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 02:46:26 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: pbonzini@redhat.com, marcandre.lureau@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, christoph.muellner@vrull.eu
Cc: liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH RFC 0/5] hw/riscv: Add support for Milk-V Duo board
Date: Tue, 12 May 2026 09:46:08 +0000
Message-ID: <20260512094614.3464388-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=visitorckw@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add initial support for the Milk-V Duo board.

This is something I've been playing around with in my local branch, and
I've reached a point where the implementation is enough to boot OpenSBI
and reach a Linux shell using an SD card image.

I am sending this as an RFC to get early feedback to understand the gap
between this minimal implementation and what is required for a upstream
merge. I plan to continue implementing missing blocks (like gpio and
clk/rst) in future.

Kuan-Wei Chiu (5):
  target/riscv: Add stubs for T-Head PMU CSRs
  hw/char: Add dw8250 UART
  hw/misc: Add Sophgo CV1800B clock controller
  hw/riscv: Add Sophgo CV1800B SoC support
  hw/riscv: Add Milk-V Duo board support

 MAINTAINERS                                 |  11 ++
 configs/devices/riscv64-softmmu/default.mak |   1 +
 hw/char/Kconfig                             |   4 +
 hw/char/dw8250.c                            | 118 ++++++++++++++
 hw/char/meson.build                         |   1 +
 hw/misc/Kconfig                             |   3 +
 hw/misc/cv1800b_clk.c                       |  89 +++++++++++
 hw/misc/meson.build                         |   1 +
 hw/riscv/Kconfig                            |  14 ++
 hw/riscv/cv1800b.c                          | 168 ++++++++++++++++++++
 hw/riscv/meson.build                        |   3 +
 hw/riscv/milkv_duo.c                        | 122 ++++++++++++++
 include/hw/char/dw8250.h                    |  27 ++++
 include/hw/misc/cv1800b_clk.h               |  24 +++
 include/hw/riscv/cv1800b.h                  |  52 ++++++
 target/riscv/th_csr.c                       |  30 ++++
 16 files changed, 668 insertions(+)
 create mode 100644 hw/char/dw8250.c
 create mode 100644 hw/misc/cv1800b_clk.c
 create mode 100644 hw/riscv/cv1800b.c
 create mode 100644 hw/riscv/milkv_duo.c
 create mode 100644 include/hw/char/dw8250.h
 create mode 100644 include/hw/misc/cv1800b_clk.h
 create mode 100644 include/hw/riscv/cv1800b.h

-- 
2.54.0.563.g4f69b47b94-goog



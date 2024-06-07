Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8D0C41513
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 00:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFNPV-0001DW-T9; Thu, 06 Jun 2024 20:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sFNPU-0001DA-3c
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 20:24:48 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sFNPS-0006wG-DZ
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 20:24:47 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-701b0b0be38so1572727b3a.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 17:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717719885; x=1718324685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JpCaxNdPEbUKCHyaU8QeByudgLqqWshFb8jc2026cAI=;
 b=ezfRCB6a8SGlSvilPgSmLGgawK7nmNEymU0SrqWCj+bwda2HxfBnOZEFH524hstNEb
 9+0WL8b34d5j+5G3V+QPkF2pqyjq0Xb/Y2nxQai8TVhiHFk25GwrQgy4ZU5ykDjRrhP5
 1V2CpojN0x91vytAN/ZE40NZKfZb2BimqziFJGIaXZizeBgHAzgSjJN3mJwqnoagUVA0
 HSZ1TlNVxr4tjYtxL7u17BfdOFvQJvycUZJ9JjYiUwAB6penZJTlH7MrQRJ39GXcxJbS
 /XcueCDYZbC4ngyoszTMkMzZUWt9TheSejFHC/jc/Jf43JWHc68k07Y8dgz1YLBh+WHw
 6+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717719885; x=1718324685;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JpCaxNdPEbUKCHyaU8QeByudgLqqWshFb8jc2026cAI=;
 b=c72slK+rLcqO3j2p+1MPYJHImVe+GUpWxHzCN/1f0kGedKzK+H47+huy6lUCavTbuD
 egC2Y8H4HRglk9Ck+luQ2iAmYEI/E9h9EG0EZp4XwLJeMe2FQcFOqQqMNFO2h5Eg8KCG
 vPssfXGQFx1LGMmp8bD+XLUWqjx4chJbo1g13NR6ETC3LorylyKcji2e0p7+QUWG1h/G
 xIAgoJRYcfAmwupCLtsmJXY+AXUveIfvEYlA0++vlbGgxm3paDlh7FssIT6/935s30i1
 pNNlrjHbxM3ks6VB3C2i/c4jmkNECubZgDxbNE+8yhFcjS7kbwzo5URIfDgx4jF7/Lhl
 pIEw==
X-Gm-Message-State: AOJu0Ywa3bRkfgCJlMjLNhh14YtqhNutBcZ3tb1ERKGCK69cLOHer2FB
 SawyeRNSvIWlW3bT1YCc2J9JpoqiXlP01ViJgagWdIrcNqULmEI7FVkVXVHrAK4Y1Ar+Bu2KQMf
 O
X-Google-Smtp-Source: AGHT+IHfSsU7QJc4Z9jopisUmRC7K8gMlXBcyI8B81OOZQySwsO+ZTr5zG7m0c9dFYNoD5v+Q8ePpw==
X-Received: by 2002:a05:6a20:7284:b0:1ad:7e66:659a with SMTP id
 adf61e73a8af0-1b2f96d6b16mr1312191637.15.1717719884646; 
 Thu, 06 Jun 2024 17:24:44 -0700 (PDT)
Received: from stoup.. ([75.147.178.105]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6e2fc776f24sm30985a12.25.2024.06.06.17.24.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 17:24:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: maobibo@loongson.cn
Subject: [PATCH v2 0/2] util/bufferiszero: Split out hosts, add loongarch64
Date: Thu,  6 Jun 2024 17:24:41 -0700
Message-Id: <20240607002443.5820-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Based-on: 20240527211912.14060-1-richard.henderson@linaro.org
("[PATCH 00/18] tcg/loongarch64: Support v64 and v256")
For "util/loongarch64: Detect LASX vector support"

For v2:
  * Rename to bufferiszero.c.inc (philmd).
  * Add inline assembly for loongarch64.

On cfarm400.cfarm.net (Loongson-3C5000L-LL @ 2.0GHz):

# Start of bufferiszero tests
# buffer_is_zero #0:  1KB    11021 MB/sec
# buffer_is_zero #0:  4KB    32107 MB/sec
# buffer_is_zero #0: 16KB    59118 MB/sec
# buffer_is_zero #0: 64KB    67940 MB/sec
# 
# buffer_is_zero #1:  1KB     9540 MB/sec
# buffer_is_zero #1:  4KB    24050 MB/sec
# buffer_is_zero #1: 16KB    38082 MB/sec
# buffer_is_zero #1: 64KB    36399 MB/sec
# 
# buffer_is_zero #2:  1KB     8026 MB/sec
# buffer_is_zero #2:  4KB    15493 MB/sec
# buffer_is_zero #2: 16KB    20865 MB/sec
# buffer_is_zero #2: 64KB    19694 MB/sec


r~


Richard Henderson (2):
  util/bufferiszero: Split out host include files
  util/bufferiszero: Add loongarch64 vector acceleration

 util/bufferiszero.c                           | 191 +-----------------
 host/include/aarch64/host/bufferiszero.c.inc  |  76 +++++++
 host/include/generic/host/bufferiszero.c.inc  |  10 +
 host/include/i386/host/bufferiszero.c.inc     | 124 ++++++++++++
 .../loongarch64/host/bufferiszero.c.inc       | 143 +++++++++++++
 host/include/x86_64/host/bufferiszero.c.inc   |   1 +
 6 files changed, 355 insertions(+), 190 deletions(-)
 create mode 100644 host/include/aarch64/host/bufferiszero.c.inc
 create mode 100644 host/include/generic/host/bufferiszero.c.inc
 create mode 100644 host/include/i386/host/bufferiszero.c.inc
 create mode 100644 host/include/loongarch64/host/bufferiszero.c.inc
 create mode 100644 host/include/x86_64/host/bufferiszero.c.inc

-- 
2.34.1


